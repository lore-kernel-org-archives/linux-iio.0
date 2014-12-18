Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1418925641.4459.11.camel@spandruv-desktop.jf.intel.com>
Subject: Re: [PATCH 3/3] iio: ak8975: Added autodetect feature for ACPI
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, "linux-i2c@vger.kernel.org"
	 <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 18 Dec 2014 10:00:41 -0800
In-Reply-To: <549314C4.8090001@metafoo.de>
References: 
	<1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1418678363-22437-4-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <549300A5.5080904@metafoo.de>
	 <1418921521.740.282.camel@spandruv-desktop.jf.intel.com>
	 <54930965.3030008@metafoo.de>
	 <1418923812.4459.8.camel@spandruv-desktop.jf.intel.com>
	 <549314C4.8090001@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2014-12-18 at 18:54 +0100, Lars-Peter Clausen wrote: 
> On 12/18/2014 06:30 PM, Srinivas Pandruvada wrote:
> > On Thu, 2014-12-18 at 18:05 +0100, Lars-Peter Clausen wrote:
> >> On 12/18/2014 05:52 PM, Srinivas Pandruvada wrote:
> >>> On Thu, 2014-12-18 at 17:28 +0100, Lars-Peter Clausen wrote:
> >>>> Added I2C to Cc.
> >>>>
> >>>> On 12/15/2014 10:19 PM, Srinivas Pandruvada wrote:
> >>>>> Using i2c auto detect feature and auto device creation feature,
> >>>>> enumerate ak8975 device, by checking their presence.
> >>>>> This is needed because when this device sits behind an i2c mux, there
> >>>>> is no way to define i2c mux in ACPI. This will enable ak8975 on
> >>>>> windows based tablets/laptops running Linux when connected via a mux.
> >>>>> Since DT model already can define an i2c mux and devices connected to
> >>>>> it, this feature is only enabled for ACPI.
> >>>>>
> >>>>
> >>>> This is quite a bit of a hack.
> >>> Why?
> >>> Auto detect is standard feature of i2c devices. This is using standard
> >>> auto detect feature provided by the framework.
> >>
> >> Auto detect is ugly, slow and unreliable, it's kind of like the last straw
> >> if nothing else works.
> > That is true here. You can't enumerate this device by ACPI. As discussed
> > before we created i2c mux in inv6050 so that we can use AK8975 in bypass
> > mode. I added some API to create i2c device on this mux, which Wolfram
> > didn't like. He wanted to enumerate using existing mechanisms.
> 
> If there is only a single ACPI ID that says this is a INV6050 with a AK8975 
> attached then the way to handle this is to have a driver that binds to that id 
> and creates both devices.
Which address you will create device also adapter here is i2c mux
created by inv6050? You don't know i2c address of AK8975. To know AK8975
i2c address, even ugly hack to parse propriety vendor ACPI data, which
will change between to manufacturer.

> 
> - Lars
> 
