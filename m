Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-053.synserver.de ([212.40.185.53]:1087 "EHLO
	smtp-out-053.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab3AJSSz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jan 2013 13:18:55 -0500
Message-ID: <50EF0636.6090903@metafoo.de>
Date: Thu, 10 Jan 2013 19:19:34 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
References: <1355449598-15980-1-git-send-email-marex@denx.de> <201212191801.31920.marex@denx.de> <20130110005748.GA947@core.coreip.homeip.net> <201301101048.38036.marex@denx.de> <20130110174630.GB2797@core.coreip.homeip.net>
In-Reply-To: <20130110174630.GB2797@core.coreip.homeip.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/2013 06:46 PM, Dmitry Torokhov wrote:
> On Thu, Jan 10, 2013 at 10:48:37AM +0100, Marek Vasut wrote:
>> Dear Dmitry Torokhov,
>>
>> [...]
>>>>> +	enum mxs_lradc_ts	use_touchscreen;
>>>>> +	unsigned int		stop_touchscreen:1;
>>>>> +	unsigned int		use_touchbutton:1;
>>>
>>> Can we make them bools instead of bit fields?
>>
>> Sure.
>> [...]
>>
>>>>> +static void mxs_lradc_ts_close(struct input_dev *dev)
>>>>> +{
>>>>> +	struct mxs_lradc *lradc = input_get_drvdata(dev);
>>>>> +
>>>>> +	/* Indicate the touchscreen is stopping. */
>>>>> +	lradc->stop_touchscreen = 1;
>>>>> +
>>>>> +	/* Disable touchscreen touch-detect IRQ. */
>>>>> +	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
>>>>> +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
>>>>> +
>>>>> +	/* Power-down touchscreen touch-detect circuitry. */
>>>>> +	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
>>>>> +		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>>>
>>> These 2 writes are racing with writes in mxs_lradc_ts_work(). I think
>>> you need to:
>>>
>>> 	lradc->stop_touchscreen = true;
>>> 	mb();
>>
>> Nice catch, do we need the memory barrier here though, is it not enough to 
>> reorder the cancel_work_sync() just before the register writes?
> 
> You really need to make sure that setting lradc->stop_touchscreen =
> true; is not reordered, because otherwise you may cancel the work,
> interrupt happens and reschedules it, and then you set up the flag.

Does it really matter? If it is rescheduled you get one event more reported
after the device has been closed, but input core should ignore it anyway, or
doesn't it?

Btw. why not use threaded interrupts instead of irq + workqueue combo?

- Lars
