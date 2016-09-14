Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33208 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756110AbcINNuP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Sep 2016 09:50:15 -0400
Received: by mail-pa0-f45.google.com with SMTP id cm16so5735725pac.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Sep 2016 06:50:15 -0700 (PDT)
Message-ID: <1473861009.9913.7.camel@researchut.com>
Subject: Re: possible odd acceleration scaling
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Date: Wed, 14 Sep 2016 19:20:09 +0530
In-Reply-To: <1473845312.23872.5.camel@researchut.com>
References: <1473787814.8047.8.camel@researchut.com>
         <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
         <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
         <1473793566.6874.10.camel@linux.intel.com>
         <1473843953.23872.3.camel@researchut.com>
         <1473845312.23872.5.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Srinivas,

On Wed, 2016-09-14 at 14:58 +0530, Ritesh Raj Sarraf wrote:
> 
> And linked are debug logs with both, 1.1 and 1.2
> 
> https://people.debian.org/~rrs/tmp/1.1.log
> https://people.debian.org/~rrs/tmp/1.2.log
> 

After reverting your changes[1], and applying Bastien's change [2], it is better
as in now it can detect all orientation types. But they do not align with the
actual physical orientation of the device. They are flipped to the actual
orientation of the device. Logs linked [3]. Tested on Linux 4.8-rc6

rrs@learner:/var/tmp/Debian-Build/Result$ monitor-sensor 
    Waiting for iio-sensor-proxy to appear
+++ iio-sensor-proxy appeared
=== Has accelerometer (orientation: right-up)
=== Has ambient light sensor (value: 0.000000, unit: lux)
    Accelerometer orientation changed: normal
    Accelerometer orientation changed: right-up
    Accelerometer orientation changed: bottom-up
    Accelerometer orientation changed: right-up




^C
2016-09-14 / 19:09:16 ♒♒♒  ☹  => 130  

[1] https://github.com/hadess/iio-sensor-proxy/commit/984803bc1b06e882bf3cf434fb
4deb2ea3b98f65

[2] https://github.com/hadess/iio-sensor-proxy/commit/07299fb51b8d80f12d74dc044f
189e410078b241

[3] https://people.debian.org/~rrs/tmp/iio-4.8-revert.txt


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX2VWRAAoJEKY6WKPy4XVp2Z8QAKh4WBPkGRUgpynkfdRiKWeK
osB67Cs1SLt2fnT9SVC48PqCEU0VPfdK8aoetDqFcuNbu0w0Eko4lw1w06FG9tfk
sui1RLpHA+uQmBcDn8UTTyIDZ3xydoAvnNMYFslHQ9bDHM31QdLeSPx4gGV8OS02
Ge2VyyjZgAcFiYLO3PaZUTMuwbPqiULeEi4dpzuyQGHfoh2rHcpIzUR26AK1ER1s
yUT/5If0PDuaTNg94dVjXwgHkLxAzp1ehP0AUV3k6x1UC/M2YpESaRZOVNX6nfU3
xHiTc7pCyy+rKT9+pucO7kemQLDXQPcGZ7TTilGZPmafmJs08/l0dFKKzEaEJwuF
nbOebj0bNGXetMTs8xfh/fgniFci85623MxbOXXI549Ndaxzu4cCKFRU+lxPZjKM
bGRPFDgfMgaTpGXdGYI2leHcIIGKRZu7ph7eVK60HY6ni+KxdqMJrHZPPRMvnsuU
3GrIrtT8/AD9/gnGivNmSIg9EMHZmw1ZaRFgqcJSO9kDY9FjbM2LF4L7O93kTthm
Spvk1871/umJe9iealZmDhVYDX0n/mBz4QfWADRe6R9j/VXPLf2PSdFLhpYZGDp0
ydSkAyRehu14+AblzF8xXWC3TwqAdy8l8XCEOX+C2LVS88iDKt2Ynm2OoyOaOeTb
yRQsspT/nA8BA1ImJ2Mn
=v/cN
-----END PGP SIGNATURE-----

