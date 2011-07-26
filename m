Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:55037 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab1GZK6q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2011 06:58:46 -0400
Message-ID: <4E2E9FC5.4030809@cam.ac.uk>
Date: Tue, 26 Jul 2011 12:06:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] blue part 6: IIO abi rework
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com> <4E2E863C.2010706@cam.ac.uk> <4E2E9C77.9050506@analog.com>
In-Reply-To: <4E2E9C77.9050506@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/26/11 11:52, Michael Hennerich wrote:
> On 07/26/2011 11:17 AM, Jonathan Cameron wrote:
>> On 07/26/11 10:01, Hennerich, Michael wrote:
>>> Jonathan Cameron wrote on 2011-07-25:
>>>> Michael pointed out the issues that not having an explicit direction
>>>> for channels was causing and the inconsistency of the inX and outX
>>>> channel naming we got from hmwon.
>>>>
>>>> They are stuck with it, but we aren't, so lets fix this now.
>>>>
>>>> Interesting question is whether we reset the base units to be volts
>>>> whilst we are at it? (for voltage channels obviously!)
>>> What do you mean exactly volts versus milli volts?
>> Make the in_voltage_scale correspond to conversion to volts instead of
>> millivolts as now (I think). Err. Looking at it that isn't actually documented...
>> oops.  I wonder which drivers actually do that and which don't.
> The ones I wrote provide the scale for millivolts.
> With the recent introduction of IIO_VAL_INT_PLUS_NANO we got
> the scale accurate enough for the precession 24-bit converters.
> If we move to the SI base unit volt, we lose this accuracy again.
Yup, that's the principal counter argument to the change.
> 
> Move to IIO_VAL_INT_PLUS_PICO?
Tricky as then we have holes (size of int on 32 bit machines isn't large enough...).
That's probably not a problem, but would mean keeping a close eye on new drivers to
make sure any computed values don't fall foul of the hole.  When constants are used
it will give a compile warning so that would be fine.
>>> Or given the fact that we have some current converter currently as inX and outX -
>> We do?  Ouch.  In the 'interesting' drivers or in the clean ones?
> From top of my head I know the AD5446/AD5444 are current output DACs.
> But the same driver also handles various other voltage output DACs.
> I can make sure once we move this driver to channel spec and iio_info:write_raw
> we get the units right.
Good to know where this is happening.  Clearly no driver is going out of staging until
it uses chan_spec anyway so we'll get them sorted at the conversion stage as you suggest.

Jonathan
