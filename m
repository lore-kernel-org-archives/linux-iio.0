Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:36571 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab0IDQCI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Sep 2010 12:02:08 -0400
Message-ID: <4C826EA7.3090808@cam.ac.uk>
Date: Sat, 04 Sep 2010 17:07:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Andrew Chew <AChew@nvidia.com>
CC: Laxman Dewangan <ldewangan@nvidia.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
References: <1283463351-15816-1-git-send-email-achew@nvidia.com>	<20100902231942.21375cc0@lxorguk.ukuu.org.uk>	<643E69AA4436674C8F39DCC2C05F763816B85AD096@HQMAIL03.nvidia.com> <20100902234124.584b9bf7@lxorguk.ukuu.org.uk> <4C80300C.1010300@cam.ac.uk> <643E69AA4436674C8F39DCC2C05F763816B85AD09A@HQMAIL03.nvidia.com> <4C80A173.3030205@cam.ac.uk> <643E69AA4436674C8F39DCC2C05F763816B85AD09E@HQMAIL03.nvidia.com>
In-Reply-To: <643E69AA4436674C8F39DCC2C05F763816B85AD09E@HQMAIL03.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/10 21:03, Andrew Chew wrote:
>> if I understand your comment correctly userspace needs to know that
>> number to convert from the magn_raw values to standard units.
>> Hence it must be exported.  My point is that the calib attributes
>> are used for devices that do their calibration offsets and scales
>> internally.  If it is a value userspace needs to apply then the
>> correct parameters are scale and offset. In the majority of devices
>> see so far these are fixed for all instances of the same part. That
>> isn't true here.
>>>
>>> And if we were to emit non-raw values (or provide the scale
>>> attributes), what's theexact name of the attributes?  And 
>> what units are we expecting?  Gauss?  Tesla?  I don't see 
>> that documented anywhere.
>> That is documented.  Gauss is the chosen standard for 
>> magnetometers.  I'll assume the
>> conversion factors are channel dependent in which case you need
>>
>> magn_x_raw, magn_x_scale, magn_x_offset
>>
>> note again, we have documented everything for some device types.
>> At the time, repeating for all of them was considered redundant, but
>> perhaps we do need to do this for the added clarity.
>>
>> The value in Gauss = (magn_x_raw + magn_x_offset)*magn_x_scale
> 

> The conversion formula doesn't have an offset, actually, so the order
> in which the offset and scale are applied don't really matter to me.
Cool. I misread your comment (lots of brackets and I was clearly half
asleep ;)
> 
> In any case, I think I got it now. I'm going to report the raw sensor
> value, and the scale factor for each axis to convert to gauss.
> 
> I assume when you say magn_x_scale, you really mean magn_x_gain?
> Because I don't see magn_x_scale defined in magnet.h. Or should I
> call the attribute magn_x_scale anyway, and not use the IIO_DEV_ATTR
> macro for gain?
Gah.  Take the documentation first.
Looks like the magnetometer macros slipped through the net - mainly
because no one was using them so they shouldn't have been there
in the first place.

Please can you add suitable macros for _scale?  You can also kill the _gain
ones if you like, or I can add that to the next set of clean up patches.
Killing the gain ones should be in a separate patch but it'll obviously cause
merge issues hence it is easier for you to do both.
The only provider of such an attribute is imu/adis16400_core.c and that
one is constant and shared across the axes so it uses
IIO_CONST_ATTR(magn_scale,...)

Thanks for pointing this out.

Jonathan


-----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> 

