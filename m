Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32908 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcFCME5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:04:57 -0400
Subject: Re: [PATCH 2/3] iio: adc: ina3221: Add support for IIO ADC driver for
 TI INA3221
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
	corbet@lwn.net, lars@metafoo.de
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com>
 <1464784454-7988-2-git-send-email-ldewangan@nvidia.com>
 <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org>
 <20f70b31-afb5-e012-0baf-ba0b83ac6d36@kernel.org>
 <57516A74.4060008@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <42c00dfb-bb45-405c-a1d2-516ece137826@kernel.org>
Date: Fri, 3 Jun 2016 13:04:53 +0100
MIME-Version: 1.0
In-Reply-To: <57516A74.4060008@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/16 12:31, Laxman Dewangan wrote:
> 
> On Friday 03 June 2016 03:46 PM, Jonathan Cameron wrote:
>> On 03/06/16 11:06, Jonathan Cameron wrote:
>>>
>>> Code looks good, bu these more fundamental bits need sorting.
>> Another minor point - why do the power calculations in driver?
>> no hardware support for it, so why not just leave it to userspace?
> 
> Device supports the bus and shunt voltage monitoring. So even no current. Also the warning/critical limit is for the voltage across shunt.
> 
> So should we only expose the shunt/bus voltage, no power/current?
> 
> I am thinking that user space should not know the platform and hence shunt resistance and so exposing the current and power on bus is better option.
> 
I'd go for current and voltage rather than current and power, but
otherwise agree.
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

