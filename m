Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:56832 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753333Ab1JUR4d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 13:56:33 -0400
Message-ID: <4EA1B229.308@metafoo.de>
Date: Fri, 21 Oct 2011 19:55:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com> <4E9FC916.2070800@metafoo.de> <4EA1B1BD.7000908@free-electrons.com>
In-Reply-To: <4EA1B1BD.7000908@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/2011 07:54 PM, Maxime Ripard wrote:
> [...]
>>> +static int __devexit at91adc_remove(struct platform_device *pdev)
>>> +{
>>> +	struct iio_dev *idev = platform_get_drvdata(pdev);
>>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	struct at91adc_state *st = iio_priv(idev);
>>> +
>>> +	free_irq(st->irq, st);
>>> +	iounmap(st->reg_base);
>>> +	release_mem_region(res->start, resource_size(res));
>>> +	iio_device_unregister(idev);
>>> +
>>
>> The iio API changed a bit recently and uses a two stage unregistration now.
>> You should call iio_device_unregister before freeing resources and
>> iio_device_free afterwards.
> 
> Hmmm, I don't see the iio_device_free in Jonathan's git. Is it
> iio_free_device, or should I use another git repo/branch as base ?
> 
> Thanks,
> 

Yes, iio_free_device, sorry.

- Lars
