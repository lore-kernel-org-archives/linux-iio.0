Return-Path: <Sonic.Zhang@analog.com>
From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>, Jonathan Cameron
	<jic23@cam.ac.uk>
CC: Mike Frysinger <vapier@gentoo.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 26 Oct 2010 00:20:59 -0400
Subject: RE: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16578B2238F@NWD2CMBX1.ad.analog.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk> <20101024234735.GB15616@ericsson.com>
In-Reply-To: <20101024234735.GB15616@ericsson.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



>-----Original Message-----
>From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
>Sent: Monday, October 25, 2010 7:48 AM
>To: Jonathan Cameron
>Cc: Mike Frysinger; linux-iio@vger.kernel.org;
>device-drivers-devel@blackfin.uclinux.org; Zhang, Sonic
>Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for
>ADT7408 temperature sensors
>
>On Sun, Oct 24, 2010 at 06:53:44PM -0400, Jonathan Cameron wrote:
>> On 10/23/10 21:29, Mike Frysinger wrote:
>> > From: Sonic Zhang <sonic.zhang@analog.com>
>> Here we enter new territory. This device is already supported in
>> hwmon.  Do we have a usecase that is not covered by that driver?
>>
>> If this is only for hardware monitoring by Guenter (cc'd)
>can perhaps
>> advise on how to support everything you have here...
>>
>
>device_id and manufactory_id (shouldn't that be
>manufacturer_id ?) don't provide much value since they are (or
>could be) already part of the device name.
>
>"capability" reflects a raw register value. I would be opposed
>to any attribute like that, since it does not mean anything
>beyond the driver for that specific chip.
>The data it provides might make sense in the driver
>documentation, but what is anyone supposed to do with the
>returned hex value ? That kind of ABI really does not make any
>sense. If the reported values are really valuable enough to be
>reported, a real abi (eg tempX_accuracy and tempX_resolution)
>would be much better.

With the raw register value, the driver gives application develop full flex=
ibility to control the device. Is it possible to define a unifiied ABI for =
all different ADCs in IIO framework? May IIO should document a policy on AB=
I difinition.


>
>For "power-save" (or "power-down" ?) and "full" mode I am not
>sure why suspend/resume isn't used instead. Is that some new
>upcoming ABI ?
>

I think the user may want to disable specific AD sensors while still keepin=
g system running.


Sonic
