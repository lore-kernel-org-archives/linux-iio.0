Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46429 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbaKXNEw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Nov 2014 08:04:52 -0500
Message-id: <54732CF0.6040404@samsung.com>
Date: Mon, 24 Nov 2014 14:04:48 +0100
From: Karol Wrona <k.wrona@samsung.com>
MIME-version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2 1/5] misc: sensorhub: Add sensorhub driver
References: <1416593957-19788-1-git-send-email-k.wrona@samsung.com>
 <54707ECA.7090800@kernel.org> <547318E0.8070407@samsung.com>
 <5942877.97OQIAaJx7@wuerfel>
In-reply-to: <5942877.97OQIAaJx7@wuerfel>
Content-type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/24/2014 01:35 PM, Arnd Bergmann wrote:
> On Monday 24 November 2014 12:39:12 Karol Wrona wrote:
>> It is possible that it can serve as input device sth else. So you are
>> right about MFD.
>>
>> The structure of mfd directory is flat. I wonder what can be better:
>> just putting these sources inside mfd dir or to some new category inside mfd.
>> Generally sensorhub will not differ than others mfd devs but in the near future
>> it can be that we end up with different (sensor)hubs or in my case with one core
>> driver with several interfaces, mcu's modes - sth like ssp-i2c.c etc.
>> These drivers can grow in size as these devices will appear in different boards.
>
> You should be able to abstract the interface differences using regmap for the
> most part, so there would only be a small stub that is i2c or spi specific,
> and a lot of mfd drivers have that.
>
>> Also there is a question where firmware loader (stm32fwu) should be placed as it
>> is a library?
>
> Can you describe what this library does? Is this for loading firmware into
> device RAM or into flash? Does it always use USB?
Generally it uploads firmware to STM32F4xx mcu using SPI. Now it writes to 
flash. Its is a subset of STM32 boot code protocol (I suppose version 1.0 but it 
is poorly documented, version 1.1 is available on ST site) so it always can be 
improved to support full protocol or other interfaces.

>
> 	Arnd
>

