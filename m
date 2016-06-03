Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32936 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659AbcFCMJU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:09:20 -0400
Subject: Re: [PATCH 2/3] iio: adc: ina3221: Add support for IIO ADC driver for
 TI INA3221
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
	corbet@lwn.net, lars@metafoo.de
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com>
 <1464784454-7988-2-git-send-email-ldewangan@nvidia.com>
 <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org>
 <57516980.1040907@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c12d7b59-3013-91fc-5414-5583bdb7d962@kernel.org>
Date: Fri, 3 Jun 2016 13:09:16 +0100
MIME-Version: 1.0
In-Reply-To: <57516980.1040907@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/16 12:26, Laxman Dewangan wrote:
> 
> On Friday 03 June 2016 03:36 PM, Jonathan Cameron wrote:
>> On 01/06/16 13:34, Laxman Dewangan wrote:
>>> Add support for INA3221 SW driver via IIO ADC interface. The device is
>>> register as iio-device and provides interface for voltage/current and power
>>> monitor. Also provide interface for setting oneshot/continuous mode and
>>> critical/warning threshold for the shunt voltage drop.
>>>
>>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> Hi Laxman,
>>
>> As ever with any driver lying on the border of IIO and hwmon, please include
>> a short justification of why you need an IIO driver and also cc the
>> hwmon list + maintainers. (cc'd on this reply).
>>
>> I simply won't take a driver where the hwmon maintainers aren't happy.
>> As it stands I'm not seeing obvious reasons in the code for why this
>> should be an IIO device.
> 
> I thought that all ADC or monitors are going to be part of IIO device
> framework. I saw the ina2xx which is same (single channel) which was
> my reference point.

That had a rather specific use case IIRC - they needed the buffered support
to get the data fast enough.
> 
>> Funily enough I know this datasheet a little as was evaluating
>> it for use on some boards at the day job a week or so ago.
>>
>> Various comments inline. Major points are:
>> * Don't use 'fake' channels to control events. If the events infrastructure
>> doesn't handle your events, then fix that rather than working around it.
>> * There is a lot of ABI in here concerned with oneshot vs continuous.
>> This seems to me to be more than it should be. We wouldn't expect to
>> see stuff changing as a result of switching between these modes other
>> than wrt to when the data shows up.  So I'd expect to not see this
>> directly exposed at all - but rather sit in oneshot unless either:
>> 1) Buffered mode is running (not currently supported)
>> 2) Alerts are on - which I think requires it to be in continuous mode.
>>
>> Other question to my mind is whether we should be reporting vshunt or
>> (using device tree to pass resistance) current.
> 

> This is bus and shunt voltage device for power monitoring. In our
> platforms, we use this device for bus current and so power monitor.
> 
> We have two usecases, one is one shot, read when it needs it. And
> other continuous when we have multiple core running then continuous
> mode to get the power consumption by rail.
That's fine, but continuous should be using the buffered interfaces
really as that's there explicitly to support groups of channels
captured using a sequencer.

Then the abi ends up much more standard which is nice. Also allows
for high speed ish continuous monitoring which is what the was
I think the point of the single channel driver.

> 
> Yaah, alert is used only on continuous mode and mainly used for
> throttling when rail power goes beyond some limit.
Of interesting in Linux, or routed directly to hardware?
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

