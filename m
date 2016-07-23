Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53948 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbcGWKzw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jul 2016 06:55:52 -0400
Subject: Re: [RCF 1/3] hwmon: Add ads1118 driver
To: Joshua Clayton <stillcompiling@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Russell King <linux@armlinux.org.uk>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1468626668.git.stillcompiling@gmail.com>
 <0294fbcb211e8f14f4e68fed4d9375cf23c6a70e.1468626668.git.stillcompiling@gmail.com>
 <578990A1.6020300@roeck-us.net> <5792301A.6030206@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e3e67d8f-9a48-e1ed-c26f-554cb190a0ae@kernel.org>
Date: Sat, 23 Jul 2016 08:02:01 +0200
MIME-Version: 1.0
In-Reply-To: <5792301A.6030206@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/07/16 16:39, Joshua Clayton wrote:
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
Sorry, made week and I thought I'd have time to get reviews done in evenings
so didn't look at anything last weekend.   Catching up on train home this morning.
> 
> I am not very familiar with the iio subsystem, (actually had never heard of it before
> receiving your response). Learning it might be beneficial, as it looks like a good fit
> for an in house driver, which I'd like to eventually upstream.
Cool
> 
> If an hwmon driver is adequate, I have new patches that address kbuild and endianness
> issues in the first version.
I'd flip it over to IIO.  If you keep to just the simple bits it'll end up pretty
simple to do.
> 
> 
> ~Joshua Clayton
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

