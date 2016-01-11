Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:34876 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932958AbcAKQXs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2016 11:23:48 -0500
MIME-Version: 1.0
In-Reply-To: <5691322C.2030004@kernel.org>
References: <1452274180-16673-1-git-send-email-ricardo.ribalda@gmail.com> <5691322C.2030004@kernel.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jan 2016 17:23:27 +0100
Message-ID: <CAPybu_1oPAVtEyTOj6urZagvBf67Q8qwRC6vTsLa=Agi8t3f8A@mail.gmail.com>
Subject: Re: [PATCH v5] iio: add ad5761 DAC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan

Thanks for your review

On Sat, Jan 9, 2016 at 5:15 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> I'm a little unsure that we shouldn't just fail the probe if the
> range is supplied.  Even the default (the best option available)
> could in theory do damage to a circuit with a maximum of 3V though
> it's probably unlikely...

I personally hate when a driver needs a mandatory pdata. I expect a
default behaviour on the absence of it.

>> +     st->vref_reg = devm_regulator_get_optional(&st->spi->dev, "vref");
>> +     if (!st->vref_reg || PTR_ERR(st->vref_reg) == -ENODEV) {
> This is a little unusual... Only one of those errors is returned by
> devm_regulator_get_optional if the regulator is not specified.
> I believe from a quick look at the regulator code that it returns the
> -ENODEV part.
>
> So how can it be null?
>

After a fast look:

devm_regulator_get_optional-> _devm_regulator_get -> regulator_get
(regulator/consumer.h)

Probably consumer.h cannot be reached at the same time than
_devm_regulator_get. But for safety I rather leave the check.



I send v6 right away.


Thanks!



-- 
Ricardo Ribalda
