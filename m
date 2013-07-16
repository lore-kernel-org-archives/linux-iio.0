Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.245]:27258 "EHLO
	DVREDG01.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753078Ab3GPIAu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 04:00:50 -0400
Message-ID: <51E4FC4E.2010203@atmel.com>
Date: Tue, 16 Jul 2013 15:54:54 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: <jic23@cam.ac.uk>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/5] iio: at91: use adc_clk_khz to make the calculation
 not easy to large than u32.
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-2-git-send-email-josh.wu@atmel.com> <20130715125213.GB2962@lukather>
In-Reply-To: <20130715125213.GB2962@lukather>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi, Maxime

On 7/15/2013 8:52 PM, Maxime Ripard wrote:
> Hi Josh,
>
> On Sun, Jul 14, 2013 at 04:04:25PM +0800, Josh Wu wrote:
>> for example, if adc_clk is 20Mhz and start-up time set as larger than 215us.
>> then the calculation "st->startup_time * adc_clk_khz" will out of u32.
>>
>> In this patch, it will use khz unit for adc_clk, that avoids above problem.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Maybe we can have a slightly better commit log here, like:
>
> ------8<-----------
> iio: at91: Fix adc_clk overflow
>
> The adc_clk variable is currently defined using a 32-bits unsigned
> integer, which will overflow under some very valid range of operations.
>
> Such overflow will occur if, for example, the parent clock is set to a
> 20MHz frequency and the ADC startup time is larger than 215ns.
>
> To fix this, introduce an intermediate variable holding the clock rate
> in kHz.
>
> --------8<---------------
>
> Or something like that.
>
> For the patch itself, I'm happy about it. You can add my Acked-by.

Thank you. Your commit log is better. I will fix the commit log base on 
your commit in next version.

>
> Thanks!
> Maxime
>

Best Regards,
Josh Wu
