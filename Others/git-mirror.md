新建同步仓库
============

```bash
git clone --mirror https://github.com/atframework/atframe_utils.git atframe_utils
cd UnrealEngine
git push --mirror https://gitlab.com/atframework/atframe_utils.git
```

更新同步仓库
============

```bash
cd atframe_utils
git remote update
git push --mirror https://gitlab.com/atframework/atframe_utils.git
```

手动指定更新的引用
============

```bash
cd atframe_utils
git remote update
# git show-ref --head
git push --force https://gitlab.com/atframework/atframe_utils.git "+refs/heads/*:refs/heads/*" "+refs/tags/*:refs/tags/*"
```

CI示例
============

```bash
mkdir ~/.ssh -p;

chmod 700 ~/.ssh;

echo "-----BEGIN OPENSSH PRIVATE KEY-----
私钥内容
-----END OPENSSH PRIVATE KEY-----" > ~/.ssh/id_rsa.ci ;

chmod 600 ~/.ssh/id_rsa.ci;

for PENDING_TO_KILL in $(ps --sort start_time -u $(whoami) -o pid,state,etimes,start_time,command | grep "ssh-agent" | grep -v grep | awk '{if($3 > 259200) { print $1;}}') ; do
    kill $PENDING_TO_KILL ;
done

eval $(timeout 3h ssh-agent);

ssh-add ~/.ssh/id_rsa.ci;

export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o Port=22 -o User=owentou -o IdentityFile=$HOME/.ssh/id_rsa.ci" ;


echo "
https://github.com/Tencent/rapidjson.git        git@gitlab.com:atframework/rapidjson.git
https://github.com/lua/lua.git                  git@gitlab.com:atframework/lua.git
https://github.com/warmcat/libwebsockets.git    git@gitlab.com:atframework/libwebsockets.git
https://github.com/libuv/libuv.git              git@gitlab.com:atframework/libuv.git
https://github.com/protocolbuffers/protobuf.git git@gitlab.com:atframework/protobuf.git
https://github.com/google/flatbuffers.git       git@gitlab.com:atframework/flatbuffers.git
https://github.com/ARMmbed/mbedtls.git          git@gitlab.com:atframework/mbedtls.git
https://github.com/jemalloc/jemalloc.git        git@gitlab.com:atframework/jemalloc.git
https://github.com/openssl/openssl.git          git@gitlab.com:atframework/openssl.git
https://github.com/libressl-portable/portable.git git@gitlab.com:atframework/libressl.git
https://github.com/git/git.git                  git@gitlab.com:atframework/git.git
" | while read line; do
    REPOS=($line);
    if [ ${#REPOS[@]} -lt 2 ]; then
        continue;
    fi

    DIRNAME=$(basename ${REPOS[0]}) ;
    if [ -e $DIRNAME ]; then
        cd $DIRNAME ;
        git fetch origin "+refs/heads/*:refs/heads/*" "+refs/tags/*:refs/tags/*" ;
    else
        git clone --mirror ${REPOS[0]} $DIRNAME ;
        cd $DIRNAME ;
    fi

    git push --force ${REPOS[1]} "+refs/heads/*:refs/heads/*" "+refs/tags/*:refs/tags/*" ;

    cd ..
done;

ssh-agent -k ;
```
