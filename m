Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:48243 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926Ab0JZJIE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Oct 2010 05:08:04 -0400
Message-ID: <4CC69BD8.2010504@cam.ac.uk>
Date: Tue, 26 Oct 2010 10:14:00 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
CC: Guenter Roeck <guenter.roeck@ericsson.com>,
	Mike Frysinger <vapier@gentoo.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408 temperature
 sensors
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org> <1287865757-1031-12-git-send-email-vapier@gentoo.org> <4CC4B8F8.7010005@cam.ac.uk> <20101024234735.GB15616@ericsson.com> <DB904C5425BA6F4E8424B3B51A1414D16578B2238F@NWD2CMBX1.ad.analog.com>
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16578B2238F@NWD2CMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/26/10 05:20, Zhang, Sonic wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
>> Sent: Monday, October 25, 2010 7:48 AM
>> To: Jonathan Cameron
>> Cc: Mike Frysinger; linux-iio@vger.kernel.org;
>> device-drivers-devel@blackfin.uclinux.org; Zhang, Sonic
>> Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for
>> ADT7408 temperature sensors
>>
>> On Sun, Oct 24, 2010 at 06:53:44PM -0400, Jonathan Cameron wrote:
>>> On 10/23/10 21:29, Mike Frysinger wrote:
>>>> From: Sonic Zhang <sonic.zhang@analog.com>
>>> Here we enter new territory. This device is already supported in
>>> hwmon.  Do we have a usecase that is not covered by that driver?
>>>
>>> If this is only for hardware monitoring by Guenter (cc'd)
>> can perhaps
>>> advise on how to support everything you have here...
>>>
>>
>> device_id and manufactory_id (shouldn't that be
>> manufacturer_id ?) don't provide much value since they are (or
>> could be) already part of the device name.
>>
>> "capability" reflects a raw register value. I would be opposed
>> to any attribute like that, since it does not mean anything
>> beyond the driver for that specific chip.
>> The data it provides might make sense in the driver
>> documentation, but what is anyone supposed to do with the
>> returned hex value ? That kind of ABI really does not make any
>> sense. If the reported values are really valuable enough to be
>> reported, a real abi (eg tempX_accuracy and tempX_resolution)
>> would be much better.
> 
> With the raw register value, the driver gives application develop
> full flexibility to control the device. Is it possible to define a
> unifiied ABI for all different ADCs in IIO framework? May IIO should
> document a policy on ABI difinition.

Yes. We have fairly comprehensive documentation (updated version was posted
to linux-iio the other day, but the stuff in place isn't that different).
drivers/staging/iio/Documentation/sysfs-bus-iio is a good starting point.

Take a look at how the other ADC drivers in tree handle similar functionality
(though I'm not entirely sure what this functionality is). max1363 or Michael's
recent drivers are good starting points.

If you want to extend the ABI, in common with every other kernel subsystem, you
propose the additions on the relevant mailing lists as an RFC.  Hardly seems
necessary to document that policy.
>>
>> For "power-save" (or "power-down" ?) and "full" mode I am not
>> sure why suspend/resume isn't used instead. Is that some new
>> upcoming ABI ?
>>
> 
> I think the user may want to disable specific AD sensors while still keeping system running.
Indeed, but it should be done using the runtime pm framework because then they can also
have the relevant spi / i2c controllers power down saving even more power.

There are some heuristics in various drivers (not in IIO) that handle auto power off.
I'm not sure if manual controls are currently supported.
> 
> 
> Sonic
> 

