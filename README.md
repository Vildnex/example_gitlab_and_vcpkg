This repository is just to display a bug found when combining the VCPKG tool with GitLab via a docker container.
There is not any purpose of this repository other than to show the bug.

## Steps to reproduce

1. Run the docker-compose file in order to start the GitLab instance.
2. Edit the .env file to change the DOCKER_GITLAB_IP to the IP of the docker container. This can ce done by running the following command:
```docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gitlab-ce```
3. Restart the docker-compose file by running the following command:
```docker-compose restart```
4. Go to the GitLab instance via the IP of the docker container and login with the username root and the password. The password can be found by running:
```docker exec -it gitlab-ce grep 'Password:' /etc/gitlab/initial_root_password```
5. Create a new project and upload this project to the local gitlab repository.
6. Create a new runner by going to Setting -> CI/CD under the section Runners click ``Expand`` and then click ``New project runner``.
7. Then Click on the Platform tab and select ``Linux``.
8. Then click on ``Run untagged jobs``.
9. Then click on ``Create runner``.
10. Take the IP address and the TOKEN from the registration and them replace the ``registration_token`` and ``url`` from the ``start.sh`` file. 
11.  Run the ``start.sh`` file.
12.  Go to the GitLab instance and click the Build -> Pipelines and then click on the pipeline that was just created.
13.  The pipeline should fail with an error similar with this:
```
#12 270.0 error: Failed to download from mirror set
#12 270.0 error: https://github.com/google/googletest/archive/release-1.12.1.tar.gz: curl failed to download with exit code 28
#12 270.0   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#12 270.0                                  Dload  Upload   Total   Spent    Left  Speed
#12 270.0 
#12 270.0 
#12 270.0 curl: (28) Failed to connect to codeload.github.com port 443 after 130834 ms: Couldn't connect to server
#12 270.0 
#12 270.0 
#12 270.0 [DEBUG] /mnt/vss/_work/1/s/src/vcpkg/base/downloads.cpp(961): 
#12 270.0 [DEBUG] Time in subprocesses: 131456664us
#12 270.0 [DEBUG] Time in parsing JSON: 3us
#12 270.0 [DEBUG] Time in JSON reader: 0us
#12 270.0 [DEBUG] Time in filesystem: 96us
#12 270.0 [DEBUG] Time in loading ports: 0us
#12 270.0 [DEBUG] Exiting after 2.2 min (131456981us)
#12 270.0 
#12 270.0 CMake Error at scripts/cmake/vcpkg_download_distfile.cmake:32 (message):
#12 270.0       
#12 270.0       Failed to download file with error: 1
#12 270.0       If you are using a proxy, please check your proxy setting. Possible causes are:
#12 270.0       
#12 270.0       1. You are actually using an HTTP proxy, but setting HTTPS_PROXY variable
#12 270.0          to `https://address:port`. This is not correct, because `https://` prefix
#12 270.0          claims the proxy is an HTTPS proxy, while your proxy (v2ray, shadowsocksr
#12 270.0          , etc..) is an HTTP proxy. Try setting `http://address:port` to both
#12 270.0          HTTP_PROXY and HTTPS_PROXY instead.
#12 270.0       
#12 270.0       2. If you are using Windows, vcpkg will automatically use your Windows IE Proxy Settings
#12 270.0          set by your proxy software. See https://github.com/microsoft/vcpkg-tool/pull/77
#12 270.0          The value set by your proxy might be wrong, or have same `https://` prefix issue.
#12 270.0       
#12 270.0       3. Your proxy's remote server is out of service.
#12 270.0       
#12 270.0       If you've tried directly download the link, and believe this is not a temporary
#12 270.0       download server failure, please submit an issue at https://github.com/Microsoft/vcpkg/issues
#12 270.0       to report this upstream download server failure.
#12 270.0       
#12 270.0 
#12 270.0 Call Stack (most recent call first):
#12 270.0   scripts/cmake/vcpkg_download_distfile.cmake:270 (z_vcpkg_download_distfile_show_proxy_and_fail)
#12 270.0   scripts/cmake/vcpkg_from_github.cmake:106 (vcpkg_download_distfile)
#12 270.0   buildtrees/versioning_/versions/gtest/8f4ae2732d1a648bdfe56b16ae5d68df63ecf344/portfile.cmake:5 (vcpkg_from_github)
#12 270.0   scripts/ports.cmake:147 (include)
#12 270.0 
#12 270.0 
#12 270.0 error: building gtest:x64-linux failed with: BUILD_FAILED
#12 270.0 Please ensure you're using the latest port files with `git pull` and `vcpkg update`.
#12 270.0 Then check for known issues at:
#12 270.0     https://github.com/microsoft/vcpkg/issues?q=is%3Aissue+is%3Aopen+in%3Atitle+gtest
#12 270.0 You can submit a new issue at:
#12 270.0     https://github.com/microsoft/vcpkg/issues/new?title=[gtest]+Build+error&body=Copy+issue+body+from+%2Fvcpkg_installed%2Fvcpkg%2Fissue_body.md
#12 270.0 
#12 ERROR: executor failed running [/bin/sh -c ./vcpkg install --feature-flags=manifests]: exit code: 1
------
 > [ 8/13] RUN ./vcpkg install --feature-flags=manifests:
#12 270.0   scripts/ports.cmake:147 (include)
#12 270.0 
#12 270.0 
#12 270.0 error: building gtest:x64-linux failed with: BUILD_FAILED
#12 270.0 Please ensure you're using the latest port files with `git pull` and `vcpkg update`.
#12 270.0 Then check for known issues at:
#12 270.0     https://github.com/microsoft/vcpkg/issues?q=is%3Aissue+is%3Aopen+in%3Atitle+gtest
#12 270.0 You can submit a new issue at:
#12 270.0     https://github.com/microsoft/vcpkg/issues/new?title=[gtest]+Build+error&body=Copy+issue+body+from+%2Fvcpkg_installed%2Fvcpkg%2Fissue_body.md
#12 270.0 
------
failed to solve: executor failed running [/bin/sh -c ./vcpkg install --feature-flags=manifests]: exit code: 1
ERROR: Job failed: exit code 17
```

## Expected behavior

Every single time this pipeline is going to fail with other lib that will not be able to download and install.
This should not happen because the runner is running inside the docker container, and it should be able to download all the needed libs.

## Question

Can anyone explain to me what exactly I am missing here? Or is this a bug?
