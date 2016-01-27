Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:56232 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932922AbcA0Pd2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 Jan 2016 10:33:28 -0500
Subject: Re: [PATCH] iio:dac:ad5755 fixed SPI_MODE
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <1453905547-27938-1-git-send-email-sean.nyekjaer@prevas.dk>
 <56A8D800.3030804@metafoo.de>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <56A8E344.8070803@prevas.dk>
Date: Wed, 27 Jan 2016 16:33:24 +0100
MIME-Version: 1.0
In-Reply-To: <56A8D800.3030804@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 2016-01-27 15:45, Lars-Peter Clausen wrote:
> On 01/27/2016 03:39 PM, Sean Nyekjaer wrote:
>> According to datasheet data is latched on the falling edge of the SCK.
>>
>> I agree it works in SPI_MODE_0 on the eval kit, but in other configurations
>> with optic isolators (that adds a small delay). We are falling out of spec.
>>
>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Hi,
>
> The SPI mode is usually specified in the spi_board_info struct or devicetree
> rather than hardcoding it in the driver.
>
> - Lars
Hi
I know :-)
But, all devices in this family have only support for SPI_MODE_1. So why 
leave it up to the spi_board_info or devicetree when only one mode is 
allowed?
If you don't like this patch I think we should create some documentation 
for the device, so other people don't have to use hours in debugging :-D

/Sean
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

