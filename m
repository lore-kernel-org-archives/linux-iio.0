Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48372 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbcGWBUa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jul 2016 21:20:30 -0400
Subject: ADS1118: hwmon or iio ? [was: Re: [RCF 1/3] hwmon: Add ads1118
 driver]
To: Joshua Clayton <stillcompiling@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Russell King <linux@armlinux.org.uk>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1468626668.git.stillcompiling@gmail.com>
 <0294fbcb211e8f14f4e68fed4d9375cf23c6a70e.1468626668.git.stillcompiling@gmail.com>
 <578990A1.6020300@roeck-us.net> <5792301A.6030206@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5792C64A.3090600@roeck-us.net>
Date: Fri, 22 Jul 2016 18:20:10 -0700
MIME-Version: 1.0
In-Reply-To: <5792301A.6030206@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/22/2016 07:39 AM, Joshua Clayton wrote:
> Greetings Guenter,
>
> Thank you for reviewing my submission.
>
> On 07/15/2016 06:40 PM, Guenter Roeck wrote:
>> On 07/15/2016 05:18 PM, Joshua Clayton wrote:
>>> Add new driver for Texas Instruments ADS1118 and and ADS1018.
>>> This driver works with ADS1018, because of code borrowed
>>> from asd1015, which is similar, but I can only test ADS1118
>>>
>>
>> Browsing through the datasheet, I think this should probably be implemented
>> as iio driver (and iio already has a driver for ads1015).
>>
>> Jonathan, what do you think ?
>>
>> Thanks,
>> Guenter
>>
> No response from Jonathan as yet, but I am willing to rework the driver when I
> have some time. It might be weeks before I can start, though.
>

Changing the subject - maybe it helps to get Jonathan's attention.

Guenter

