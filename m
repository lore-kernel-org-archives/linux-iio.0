Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50481 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934419AbcAKTVI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2016 14:21:08 -0500
Subject: Re: [PATCH v5] iio: add ad5761 DAC driver
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
References: <1452274180-16673-1-git-send-email-ricardo.ribalda@gmail.com>
 <5691322C.2030004@kernel.org>
 <CAPybu_1oPAVtEyTOj6urZagvBf67Q8qwRC6vTsLa=Agi8t3f8A@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569400A1.2060200@kernel.org>
Date: Mon, 11 Jan 2016 19:21:05 +0000
MIME-Version: 1.0
In-Reply-To: <CAPybu_1oPAVtEyTOj6urZagvBf67Q8qwRC6vTsLa=Agi8t3f8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/16 16:23, Ricardo Ribalda Delgado wrote:
> Hello Jonathan
> 
> Thanks for your review
> 
> On Sat, Jan 9, 2016 at 5:15 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> I'm a little unsure that we shouldn't just fail the probe if the
>> range is supplied.  Even the default (the best option available)
>> could in theory do damage to a circuit with a maximum of 3V though
>> it's probably unlikely...
> 
> I personally hate when a driver needs a mandatory pdata. I expect a
> default behaviour on the absence of it.
That's fair enough, though in this particular case, in theory it could
cause damage.  Let's take the view that's unlikely.
> 
>>> +     st->vref_reg = devm_regulator_get_optional(&st->spi->dev, "vref");
>>> +     if (!st->vref_reg || PTR_ERR(st->vref_reg) == -ENODEV) {
>> This is a little unusual... Only one of those errors is returned by
>> devm_regulator_get_optional if the regulator is not specified.
>> I believe from a quick look at the regulator code that it returns the
>> -ENODEV part.
>>
>> So how can it be null?
>>
> 
> After a fast look:
> 
> devm_regulator_get_optional-> _devm_regulator_get -> regulator_get
> (regulator/consumer.h)
> 
> Probably consumer.h cannot be reached at the same time than
> _devm_regulator_get. But for safety I rather leave the check.
Hmm. In this particular case it's relatively clear that one of
the checks must be meaningless so chances of patches turning up
to 'fix' this in future makes me think it's better to save time
and drop it now.
> 
> 
> 
> I send v6 right away.
> 
> 
> Thanks!
> 
> 
> 

