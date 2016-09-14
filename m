Return-Path: <rrs@researchut.com>
Message-ID: <1473845312.23872.5.camel@researchut.com>
Subject: Re: possible odd acceleration scaling
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jonathan
 Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Bastien Nocera
 <hadess@hadess.net>
Date: Wed, 14 Sep 2016 14:58:32 +0530
In-Reply-To: <1473843953.23872.3.camel@researchut.com>
References: <1473787814.8047.8.camel@researchut.com>
	 <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
	 <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
	 <1473793566.6874.10.camel@linux.intel.com>
	 <1473843953.23872.3.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, 2016-09-14 at 14:35 +0530, Ritesh Raj Sarraf wrote:
> Not much changed even after reverting that commit.
> 
> 
> With iio-sensor-proxy, 1.2, I get:
> 
> rrs@learner:/var/tmp/Debian-Build/Result$ monitor-sensor 
>     Waiting for iio-sensor-proxy to appear
> +++ iio-sensor-proxy appeared
> === Has accelerometer (orientation: right-up)
> === Has ambient light sensor (value: 0.000000, unit: lux)
>     Accelerometer orientation changed: left-up
>     Accelerometer orientation changed: right-up
>     Accelerometer orientation changed: left-up
>     Accelerometer orientation changed: right-up
> --- iio-sensor-proxy vanished, waiting for it to appear
> 
> 
> Notice that there is no 'normal' orientation mode reported.
> 
> Now reverting back to 1.1 of iio-sensor-proxy, I get:
> 
> +++ iio-sensor-proxy appeared
> === Has accelerometer (orientation: undefined)
> === Has ambient light sensor (value: 0.000000, unit: lux)
> +++ Accelerometer appeared
>     Accelerometer orientation changed: undefined
> +++ Light sensor appeared
>     Light changed: 0.000000 (lux)
>     Accelerometer orientation changed: right-up
>     Accelerometer orientation changed: normal
>     Accelerometer orientation changed: right-up
> 
> 
> This is on Linux 4.8-rc6.

And linked are debug logs with both, 1.1 and 1.2

https://people.debian.org/~rrs/tmp/1.1.log
https://people.debian.org/~rrs/tmp/1.2.log

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX2RhAAAoJEKY6WKPy4XVpFOsP+wdPPbiGzyn3FSEoT6SxK/vy
c11OzvjD3M2HBUHE+hcwvfxU0m1WnjUkM0UYC8uJ+wbGL+dOKwKAsazL0l3m3/qD
R/pFl8S0UXGh1VcfaQULZGYrZXsYu71UDgfIqqVoAr9UiY0UzsbK1Kx2qGwl87MD
eRn68uhqN++Es/fwRTISw0Cmi//gPShpuya6r9ynsP+Iex0uXG+E+idJPEnfWJkw
f+q5TJNii05wSyjt7kDsGtkFuxws5P+dk78OJ2jUVvdQ3ttMRlj1sUGgYwbp8eM5
fWNtnlhEG3RaDQOoNqetOLMbYrfyTBGTsokeeIeNorAjiCVI8nxRQtAfpVlf7Ww3
VWsX082/Aq4bd/LfMem9p3EF6XXLwVWIqX3dZwHSN9YDF78qFfYH9HvXSR79ei2i
I/8TPMbMI5bYlLHAs4rl8ACBTsepoS6d6RmM59s7C+v6gYjuY9RI5BYX0AbqjaEA
XO9BErbZN/L/wjxdiISwXKHOyv/zpoTpeLRiIqZTjs/qR3nI3UnJeWtRmuSzIdgA
jfyduJNZpB+vfw6bd0OjmZwiTYS2uAB/rerCO3uqAxK0BID8bk8f2u3VClO4Hd0x
+I/NKi/+dJ5JUsNbkZaMqNhHf/zhKGgUycklmxTUuFg6pi1iX1z+8jqkGs+ntQAM
bEWhSCbSM4faEakiYhz0
=KP81
-----END PGP SIGNATURE-----
