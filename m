Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40986 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbcBFSEu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:04:50 -0500
Subject: Re: [RFC PATCH 1/2] iio: hmc5843 Add channel attribute for bias
 configuration
To: Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1454597413-5298-1-git-send-email-cristina.moraru09@gmail.com>
 <56B38E29.8040300@metafoo.de>
 <CAEnQRZARAOvNo6Yac5a0oJj8ARHE8_93=JNJp6YwZokjo2byZw@mail.gmail.com>
Cc: Cristina Moraru <cristina.moraru09@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>,
	marek@goldelico.com, sdliyong@gmail.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	driverdev <devel@driverdev.osuosl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	shubhrajyoti@ti.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B635BF.2090201@kernel.org>
Date: Sat, 6 Feb 2016 18:04:47 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZARAOvNo6Yac5a0oJj8ARHE8_93=JNJp6YwZokjo2byZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/16 09:58, Daniel Baluta wrote:
> On Thu, Feb 4, 2016 at 7:45 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 02/04/2016 03:50 PM, Cristina Moraru wrote:
>>> Replace non standard meas_conf attribute with the standard IIO
>>> calibbias attribute.
>>>
>>> API for setting bias measurement configuration:
>>>
>>> 0 - Normal measurement configuration (default): In normal measurement
>>>     configuration the device follows normal measurement flow. Pins BP
>>>     and BN are left floating and high impedance.
>>>
>>> 1 - Positive bias configuration: In positive bias configuration, a
>>>     positive current is forced across the resistive load on pins BP
>>>     and BN.
>>>
>>> 2 - Negative bias configuration. In negative bias configuration, a
>>>     negative current is forced across the resistive load on pins BP
>>>     and BN.
>>>
>>> 3 - Only available on HMC5983. Magnetic sensor is disabled.
>>>     Temperature sensor is enabled.
>>>
>>> With this in place, we can think of moving this driver out of staging.
>>
>> Using a standard attribute, but overloading it with custom semantics doesn't
>> do any good either. calibbias is supposed to be a integer that gets added to
>> measurements internally in the device (unit is device specific though).
>>
>> This attribute seems to do something else. In that case it might be better
>> to stay with a custom attribute (as long as it is documented) or come up
>> with a better way to map the device configuration onto standard attributes.
> 
> We missed the RFC tag. So, with this in mind we still have some minor
> issues to fix and then we can move the code out of staging.
> 
> 1) checkpatch.pl -- strict warnings
> 2) suspend/resume functions in hmc5843_core.c.
> 
> int hmc5843_common_suspend(struct device *dev)
> {
>         return hmc5843_set_mode(iio_priv(dev_get_drvdata(dev)),
>                         HMC5843_MODE_CONVERSION_CONTINUOUS);
> }
> 
> int hmc5843_common_resume(struct device *dev)
> {
>         return hmc5843_set_mode(iio_priv(dev_get_drvdata(dev)),
>                                 HMC5843_MODE_SLEEP);
> }
> 
> I think the function names or implementations were swapped.
> The device should go to sleep at suspend and back to continuous
> mode on resume.
Yup, from a quick glance - it otherwise looks sensible to me.
Will as ever attract more reviews once the move out of staging
patch shows up.

Jonathan

> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

