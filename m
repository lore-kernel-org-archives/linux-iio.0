Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:32776 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbcCaIBH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Mar 2016 04:01:07 -0400
Received: by mail-oi0-f52.google.com with SMTP id d205so50166182oia.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Mar 2016 01:01:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1458721195-28915-1-git-send-email-michael.hennerich@analog.com>
References: <1458721195-28915-1-git-send-email-michael.hennerich@analog.com>
Date: Thu, 31 Mar 2016 10:01:06 +0200
Message-ID: <CACRpkdYAqPn9o-wMbb-iZn7bjad8u9JmdwRqwrjFMArPrOXEOQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs
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

On Wed, Mar 23, 2016 at 9:19 AM,  <michael.hennerich@analog.com> wrote:

> From: Paul Cercueil <paul.cercueil@analog.com>
>
> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
> ADC/DAC/GPIO devices.
>
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

For this v5 version:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I'm fine with this new gpiochip driver being merged into the
IIO tree.

Yours,
Linus Walleij
