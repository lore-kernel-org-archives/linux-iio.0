Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:60120 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751210Ab3FDKyx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Jun 2013 06:54:53 -0400
Subject: Re: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub devices to regmap interface
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
From: Pantelis Antoniou <panto@antoniou-consulting.com>
In-Reply-To: <20130604105210.GI1151@linutronix.de>
Date: Tue, 4 Jun 2013 13:54:48 +0300
Cc: Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Message-Id: <4AA621AD-5273-444C-875C-05486CC810A8@antoniou-consulting.com>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-13-git-send-email-bigeasy@linutronix.de> <51AB84F5.2030405@kernel.org> <20130604102318.GC1151@linutronix.de> <F58DCC19-20B7-4385-B323-C1A2E5F22641@antoniou-consulting.com> <20130604105210.GI1151@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

What make you think I am the original author?

I just fixed whatever I had to fix to get it working.

Namely that the multi function device was using regmap in one place and
not in another, which had the nice effect of the regmap cache getting out of sync.

Regards

-- Pantelis

On Jun 4, 2013, at 1:52 PM, Sebastian Andrzej Siewior wrote:

> * Pantelis Antoniou | 2013-06-04 13:25:28 [+0300]:
> 
>>>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>>>>> index bd127bd..a27401a 100644
>>>>> --- a/drivers/mfd/ti_am335x_tscadc.c
>>>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>>>>> @@ -31,6 +31,7 @@ static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
>>>>> {
>>>>> 	unsigned int val;
>>>>> 
>>>> ????  What is this doing here? It's not doing the move to regmap but rather setting a default value.
>>> 
>>> No lo sé :) I saw that and was wondering myself a little and planned the
>>> romval of this default for later. Now I think I do this earlier.
>>> 
>> 
>> The tscadc_read function doesn't have a failure mode; doesn't return an error in case of a regmap_read
>> fail. Rather that change all the callers, we make sure we don't ever return an uninitialized value 
>> in case of an error (when val should be unchanged).
> 
> One stupid question: Why did you start using regmap in the first place?
> 
>>>>> +	val = (unsigned int)-1;
>>>>> 	regmap_read(tsadc->regmap_tscadc, reg, &val);
>>>>> 	return val;
>>>>> }
> 
> Sebastian

