Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2716 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbcFCLjd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 07:39:33 -0400
Message-ID: <57516980.1040907@nvidia.com>
Date: Fri, 3 Jun 2016 16:56:56 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <robh+dt@kernel.org>,
	<corbet@lwn.net>, <lars@metafoo.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>,
	"Guenter Roeck" <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] iio: adc: ina3221: Add support for IIO ADC driver
 for TI INA3221
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com> <1464784454-7988-2-git-send-email-ldewangan@nvidia.com> <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org>
In-Reply-To: <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Friday 03 June 2016 03:36 PM, Jonathan Cameron wrote:
> On 01/06/16 13:34, Laxman Dewangan wrote:
>> Add support for INA3221 SW driver via IIO ADC interface. The device is
>> register as iio-device and provides interface for voltage/current and power
>> monitor. Also provide interface for setting oneshot/continuous mode and
>> critical/warning threshold for the shunt voltage drop.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Hi Laxman,
>
> As ever with any driver lying on the border of IIO and hwmon, please include
> a short justification of why you need an IIO driver and also cc the
> hwmon list + maintainers. (cc'd on this reply).
>
> I simply won't take a driver where the hwmon maintainers aren't happy.
> As it stands I'm not seeing obvious reasons in the code for why this
> should be an IIO device.

I thought that all ADC or monitors are going to be part of IIO device 
framework. I saw the ina2xx which is same (single channel) which was my 
reference point.


> Funily enough I know this datasheet a little as was evaluating
> it for use on some boards at the day job a week or so ago.
>
> Various comments inline. Major points are:
> * Don't use 'fake' channels to control events. If the events infrastructure
> doesn't handle your events, then fix that rather than working around it.
> * There is a lot of ABI in here concerned with oneshot vs continuous.
> This seems to me to be more than it should be. We wouldn't expect to
> see stuff changing as a result of switching between these modes other
> than wrt to when the data shows up.  So I'd expect to not see this
> directly exposed at all - but rather sit in oneshot unless either:
> 1) Buffered mode is running (not currently supported)
> 2) Alerts are on - which I think requires it to be in continuous mode.
>
> Other question to my mind is whether we should be reporting vshunt or
> (using device tree to pass resistance) current.

This is bus and shunt voltage  device for power monitoring. In our 
platforms, we use this device for bus current and so  power monitor.

We have two usecases, one is one shot, read when it needs it. And other 
continuous when we have multiple core running then continuous mode to 
get the power consumption by rail.

Yaah, alert is used only on continuous mode and mainly used for 
throttling when rail power goes beyond some limit.

