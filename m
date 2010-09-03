Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:36406 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab0ICHOX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2010 03:14:23 -0400
Message-ID: <4C80A173.3030205@cam.ac.uk>
Date: Fri, 03 Sep 2010 08:19:15 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Andrew Chew <AChew@nvidia.com>
CC: Laxman Dewangan <ldewangan@nvidia.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
References: <1283463351-15816-1-git-send-email-achew@nvidia.com>	<20100902231942.21375cc0@lxorguk.ukuu.org.uk>	<643E69AA4436674C8F39DCC2C05F763816B85AD096@HQMAIL03.nvidia.com> <20100902234124.584b9bf7@lxorguk.ukuu.org.uk> <4C80300C.1010300@cam.ac.uk> <643E69AA4436674C8F39DCC2C05F763816B85AD09A@HQMAIL03.nvidia.com>
In-Reply-To: <643E69AA4436674C8F39DCC2C05F763816B85AD09A@HQMAIL03.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/10 00:57, Andrew Chew wrote:
>>>>>> +static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, 
>>>>> store_mode, 0);
>>>>>> +static IIO_DEVICE_ATTR(magn_x_calibscale, S_IRUGO, 
>>>>> show_calibscale, NULL, 0);
>>>>>> +static IIO_DEVICE_ATTR(magn_y_calibscale, S_IRUGO, 
>>>>> show_calibscale, NULL, 1);
>>>>>> +static IIO_DEVICE_ATTR(magn_z_calibscale, S_IRUGO, 
>>>>> show_calibscale, NULL, 2);
>>>>>> +static IIO_DEV_ATTR_MAGN_X(show_raw, AK8975_REG_HXL);
>>>>>> +static IIO_DEV_ATTR_MAGN_Y(show_raw, AK8975_REG_HYL);
>>>>>> +static IIO_DEV_ATTR_MAGN_Z(show_raw, AK8975_REG_HZL);
>>>>>
>>>>> This seems odd as an interface as it's raw when the maths 
>> to provide
>>>>> non-raw (and thus abstract and easy for user space) data 
>> is trivial
>>>>> enough to do in kernel
>>>>
>>>> IIO guys want to do normalization maths above the 
>> kernel-level magnetometer IIO layer. 
>>>> This interface came before me, so I'm just following 
>> current conventions.
>>>
>>> That will make a generic IIO <-> input bridge very hard to 
>> do right. I
>>> can see why IIO wants to do that but you need both if so 
>> and this also
>>> needs discussion.
>>
>> Note that, though there are few drivers using it (just the 
>> tsl2563 iirc)
>> we do allow the hwmon style _input syntax for values in the 
>> standard units
>> for the device type.  If you are going to use the raw option then,
>> assuming linear conversion, at the very least magn_scale 
>> should be provided
>> to tell userspace how to do the conversion.  If the bridge to input
>> is done in userspace then it is trivial to apply this before passing
>> into uinput.  For background info, the bridge approach currently
>> relies on implementation of the 'buffered' iio interface which uses
>> chrdevs rather than the hwmon like 'simple' interface provided here.
>> It would be a bit of a nightmare to bridge from sysfs (if it could
>> even be done?)  Typically all drivers start with the sysfs interface
>> and the buffered one is only added if needed by someone.
>>
>> Note calibscale is meant for internally applied values.  That 
>> is ones applied
>> actually on the device (looking at what you have here, my 
>> choice of naming
>> wasn't ideal, anyone have a better naming suggestion).  The 
>> value used to do raw to
>> standard unit conversion in userspace is magn_x_scale or equivalent.
>> I think based on the comment in your code that you also need 
>> to provide
>> magn_x_offset.  Looks like our documentation could do to be a 
>> little clearer.
>> Rather tediously these are both computed floating point 
>> values here.  Perhaps
>> we will need to think further on that interface (this is the 
>> first time
>> we have hit this particular situation)
>>
>> The raw option is principally there because we share the 
>> attributes with the
>> buffer access (there performance dictates doing as little as 
>> possible to the
>> data on the way through.) Admittedly our overheads are way 
>> too high at the
>> moment for other reasons but the intent is there.  If you are 
>> intending to
>> add this interface later then keeping to the _raw attributes 
>> makes for a
>> more consistent choice (though as long as the scale and bias 
>> are there for
>> the buffer you could use the processed value...)
> 
> Yes, the little documentation that's there in sysfs-class-iio doesn't
> give me very much guidance on how to do this properly.
That document relies on people generalizing the attributes across the
various sensor types.  The documents are iirc pretty complete for in0_raw
and similar.  Perhaps it is necessary to lay it out in full.
> 
> So what I'm getting from your comments is that I'm using the calib
> attribute wrong (I wasn't even sure I named this correctly...can we
> publish ALL known attributes in magnet.h,
Definitely.  The usual principal is that anything obviously general
or that has turned up in a number of drivers should go in the relevant
header.  We add these as and when they are first used.
> so we can standardize on
> these attribute names through the magnet.h macros?). The ASA
> sensitivity adjustment, then, should be left completely internal to
> the driver, and not emitted through any known attribute?
if I understand your comment correctly userspace needs to know that
number to convert from the magn_raw values to standard units.
Hence it must be exported.  My point is that the calib attributes
are used for devices that do their calibration offsets and scales
internally.  If it is a value userspace needs to apply then the
correct parameters are scale and offset. In the majority of devices
see so far these are fixed for all instances of the same part. That
isn't true here.
> 
> And if we were to emit non-raw values (or provide the scale
> attributes), what's theexact name of the attributes?  And what units are we expecting?  Gauss?  Tesla?  I don't see that documented anywhere.
That is documented.  Gauss is the chosen standard for magnetometers.  I'll assume the
conversion factors are channel dependent in which case you need

magn_x_raw, magn_x_scale, magn_x_offset

note again, we have documented everything for some device types.
At the time, repeating for all of them was considered redundant, but
perhaps we do need to do this for the added clarity.

The value in Gauss = (magn_x_raw + magn_x_offset)*magn_x_scale

(in your case the formula is nicer with magn_x_scale provided
first, but we had to pick one option and the above is what
we went with.

Jonathan
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> 

