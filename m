Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2998 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbcFCMPu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:15:50 -0400
Message-ID: <57517200.6080102@nvidia.com>
Date: Fri, 3 Jun 2016 17:33:12 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <robh+dt@kernel.org>,
	<corbet@lwn.net>, <lars@metafoo.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] iio: adc: ina3221: Add support for IIO ADC driver
 for TI INA3221
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com> <1464784454-7988-2-git-send-email-ldewangan@nvidia.com> <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org> <20f70b31-afb5-e012-0baf-ba0b83ac6d36@kernel.org> <57516A74.4060008@nvidia.com> <42c00dfb-bb45-405c-a1d2-516ece137826@kernel.org>
In-Reply-To: <42c00dfb-bb45-405c-a1d2-516ece137826@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Friday 03 June 2016 05:34 PM, Jonathan Cameron wrote:
> On 03/06/16 12:31, Laxman Dewangan wrote:
>> On Friday 03 June 2016 03:46 PM, Jonathan Cameron wrote:
>>> On 03/06/16 11:06, Jonathan Cameron wrote:
>>>> Code looks good, bu these more fundamental bits need sorting.
>>> Another minor point - why do the power calculations in driver?
>>> no hardware support for it, so why not just leave it to userspace?
>> Device supports the bus and shunt voltage monitoring. So even no current. Also the warning/critical limit is for the voltage across shunt.
>>
>> So should we only expose the shunt/bus voltage, no power/current?
>>
>> I am thinking that user space should not know the platform and hence shunt resistance and so exposing the current and power on bus is better option.
>>
> I'd go for current and voltage rather than current and power, but
> otherwise agree.

OK, I will have the voltage (bus voltage) and current (on bus).
User space can get power out of this.

Thanks for suggestion.

The critical limits will be still in current. And it should be 
customized sysfs instead of the iio_chan_spec i.e. iio_device attribute 
interface.




