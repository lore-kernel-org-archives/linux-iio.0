Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:15620 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbcA1HkY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 28 Jan 2016 02:40:24 -0500
Subject: Re: [PATCH] iio:dac:ad5755 fixed SPI_MODE
To: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
References: <1453905547-27938-1-git-send-email-sean.nyekjaer@prevas.dk>
 <56A8D800.3030804@metafoo.de> <56A8E344.8070803@prevas.dk>
 <56A8E606.2030708@metafoo.de>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <56A9C375.70501@prevas.dk>
Date: Thu, 28 Jan 2016 08:29:57 +0100
MIME-Version: 1.0
In-Reply-To: <56A8E606.2030708@metafoo.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 2016-01-27 16:45, Lars-Peter Clausen wrote:
> On 01/27/2016 04:33 PM, Sean Nyekjær wrote:
>> On 2016-01-27 15:45, Lars-Peter Clausen wrote:
>>> On 01/27/2016 03:39 PM, Sean Nyekjaer wrote:
>>>> According to datasheet data is latched on the falling edge of the SCK.
>>>>
>>>> I agree it works in SPI_MODE_0 on the eval kit, but in other configurations
>>>> with optic isolators (that adds a small delay). We are falling out of spec.
>>>>
>>>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>>> Hi,
>>>
>>> The SPI mode is usually specified in the spi_board_info struct or devicetree
>>> rather than hardcoding it in the driver.
>>>
>>> - Lars
>> Hi
>> I know :-)
>> But, all devices in this family have only support for SPI_MODE_1. So why
>> leave it up to the spi_board_info or devicetree when only one mode is allowed?
> As far as I can see they should work with either SPI_MODE_1 or SPI_MODE_2.
> But it would certainly be nice if the SPI framework had support for
> auto-configuration, based on the support modes of the SPI controller and the
> device, in case no mode was explicit specified.
>
>> If you don't like this patch I think we should create some documentation for
>> the device, so other people don't have to use hours in debugging :-D
> https://wiki.analog.com/resources/tools-software/linux-drivers/iio-dac/ad5755?&#example_platform_device_initialization
Ops the gmail app on android is not very good answering text only emails :-)

Is there a reason why this documentation is not in the kernel?
It's also missing the options and examples for devicetree bindings...

Should I create the devicetree documentation instead of this patch?
I still think this patch is a better solution to prevent future problems 
with the driver.

/Sean
