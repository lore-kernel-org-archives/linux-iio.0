Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33984 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758976AbcCVKuo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2016 06:50:44 -0400
Received: by mail-oi0-f46.google.com with SMTP id i17so1068408oib.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2016 03:50:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56F0001B.9010608@analog.com>
References: <1456407412-16218-1-git-send-email-michael.hennerich@analog.com>
	<56D1E1CB.6070704@kernel.org>
	<CACRpkdap_8YGCAvNeK7_0H2MDDnwQ9QDJH4O2SzEkDmczPGtLg@mail.gmail.com>
	<56F0001B.9010608@analog.com>
Date: Tue, 22 Mar 2016 11:50:42 +0100
Message-ID: <CACRpkdZk=wMEDCw4dm7VNhxtGeSKFb1ELV4Tosi00+jjcWFmFg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs
From: Linus Walleij <linus.walleij@linaro.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Paul Cercueil <paul.cercueil@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 21, 2016 at 3:07 PM, Michael Hennerich
<michael.hennerich@analog.com> wrote:
> On 03/11/2016 05:28 PM, Linus Walleij wrote:

>>>> +             mutex_lock(&iio_dev->mlock);
>>>> +             st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
>>>> +             mutex_unlock(&iio_dev->mlock);
>>
>> What's that? (0xdac)? Clever magic?
>
> Clever magic - to avoid accidental resets.

I see. Put in a small comment like:

/* Writing this magic value resets the device */

Yours,
Linus Walleij
