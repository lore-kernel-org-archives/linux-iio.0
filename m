Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1473866880.35049.5.camel@linux.intel.com>
Subject: Re: possible odd acceleration scaling
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rrs@researchut.com, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Date: Wed, 14 Sep 2016 08:28:00 -0700
In-Reply-To: <1473861009.9913.7.camel@researchut.com>
References: <1473787814.8047.8.camel@researchut.com>
	 <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
	 <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
	 <1473793566.6874.10.camel@linux.intel.com>
	 <1473843953.23872.3.camel@researchut.com>
	 <1473845312.23872.5.camel@researchut.com>
	 <1473861009.9913.7.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2016-09-14 at 19:20 +0530, Ritesh Raj Sarraf wrote:
> Hello Srinivas,
> 
> On Wed, 2016-09-14 at 14:58 +0530, Ritesh Raj Sarraf wrote:
> > 
> >  
> > And linked are debug logs with both, 1.1 and 1.2
> > 
> > https://people.debian.org/~rrs/tmp/1.1.log
> > https://people.debian.org/~rrs/tmp/1.2.log
> > 
> 
> After reverting your changes[1], and applying Bastien's change [2],
> it is better
> as in now it can detect all orientation types. But they do not align
> with the
> actual physical orientation of the device. They are flipped to the
> actual
> orientation of the device. Logs linked [3]. Tested on Linux 4.8-rc6
> 
> rrs@learner:/var/tmp/Debian-Build/Result$ monitor-sensor 
>     Waiting for iio-sensor-proxy to appear
> +++ iio-sensor-proxy appeared
> === Has accelerometer (orientation: right-up)
> === Has ambient light sensor (value: 0.000000, unit: lux)
>     Accelerometer orientation changed: normal
>     Accelerometer orientation changed: right-up
>     Accelerometer orientation changed: bottom-up
>     Accelerometer orientation changed: right-up

I was surprised why the sorting function didn't work (it should be
qsort compliant). We need some way not to depend on the order of
scan_elements read from file system. So we need to fix this.

Thanks,
Srinivas


> 
> 
> 
> 
> ^C
> 2016-09-14 / 19:09:16 ♒♒♒  ☹  => 130  
> 
> [1] https://github.com/hadess/iio-sensor-proxy/commit/984803bc1b06e88
> 2bf3cf434fb
> 4deb2ea3b98f65
> 
> [2] https://github.com/hadess/iio-sensor-proxy/commit/07299fb51b8d80f
> 12d74dc044f
> 189e410078b241
> 
> [3] https://people.debian.org/~rrs/tmp/iio-4.8-revert.txt
> 
> 
