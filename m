Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36645 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932673AbcCKQhy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2016 11:37:54 -0500
Received: by mail-ob0-f182.google.com with SMTP id m7so118208030obh.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2016 08:37:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56DD7548.8050306@analog.com>
References: <1457009883-4017-1-git-send-email-michael.hennerich@analog.com>
	<56DAEDF4.6040008@kernel.org>
	<56DD7548.8050306@analog.com>
Date: Fri, 11 Mar 2016 23:37:53 +0700
Message-ID: <CACRpkdY=n30A5UkRX7avP7eWrPffh3faF8K_Ey2f2cs1GRZP7g@mail.gmail.com>
Subject: Re: [PATCH v3] iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs
From: Linus Walleij <linus.walleij@linaro.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Paul Cercueil <paul.cercueil@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 7, 2016 at 7:34 PM, Michael Hennerich
<michael.hennerich@analog.com> wrote:
> On 03/05/2016 03:32 PM, Jonathan Cameron wrote:

>>> Changes since v2:
>>>         * Use child nodes to describe channels
>>>         * Fix probe return and driver remove path
>>>         * Move locking closer to where its used
>>>         * Remove WARN_ON but return error
>>>         * Remove OPEN DRAIN configuration option
>>
>> Why? I don't particularly mind as of course you aren't obliged to support
>> every option in a driver, but I'm curious ;)
>
> I'm not aware that someone asked for that feature.
> Supporting it the proper way requires a new GPIOF flag for gpiolib, which we
> can still discuss later, in case someone asks for it.

We have:
include/dt-bindings/gpio/gpio.h

/*
 * Open Drain/Collector is the combination of single-ended active low,
 * Open Source/Emitter is the combination of single-ended active high.
 */
#define GPIO_OPEN_DRAIN (GPIO_SINGLE_ENDED | GPIO_ACTIVE_LOW)
#define GPIO_OPEN_SOURCE (GPIO_SINGLE_ENDED | GPIO_ACTIVE_HIGH)

So consumers can ask (in DT) for a line in open drain mode.

FLAG_OPEN_DRAIN will be set internally in gpiolibs gpio_desc
in of_find_gpio() as a result and it will behave as expected.

Yours,
Linus Walleij
