Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55028 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3FDKwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 06:52:14 -0400
Date: Tue, 4 Jun 2013 12:52:10 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub
 devices to regmap interface
Message-ID: <20130604105210.GI1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-13-git-send-email-bigeasy@linutronix.de>
 <51AB84F5.2030405@kernel.org>
 <20130604102318.GC1151@linutronix.de>
 <F58DCC19-20B7-4385-B323-C1A2E5F22641@antoniou-consulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <F58DCC19-20B7-4385-B323-C1A2E5F22641@antoniou-consulting.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Pantelis Antoniou | 2013-06-04 13:25:28 [+0300]:

>>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>>>> index bd127bd..a27401a 100644
>>>> --- a/drivers/mfd/ti_am335x_tscadc.c
>>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>>>> @@ -31,6 +31,7 @@ static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
>>>> {
>>>> 	unsigned int val;
>>>> 
>>> ????  What is this doing here? It's not doing the move to regmap but rather setting a default value.
>> 
>> No lo sé :) I saw that and was wondering myself a little and planned the
>> romval of this default for later. Now I think I do this earlier.
>> 
>
>The tscadc_read function doesn't have a failure mode; doesn't return an error in case of a regmap_read
>fail. Rather that change all the callers, we make sure we don't ever return an uninitialized value 
>in case of an error (when val should be unchanged).

One stupid question: Why did you start using regmap in the first place?

>>>> +	val = (unsigned int)-1;
>>>> 	regmap_read(tsadc->regmap_tscadc, reg, &val);
>>>> 	return val;
>>>> }

Sebastian
