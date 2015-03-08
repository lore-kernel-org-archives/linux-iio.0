Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41091 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbCHTLJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 15:11:09 -0400
MIME-Version: 1.0
In-Reply-To: <1425835778-7827-1-git-send-email-tduszyns@gmail.com>
References: <1425835778-7827-1-git-send-email-tduszyns@gmail.com>
Date: Sun, 8 Mar 2015 21:11:07 +0200
Message-ID: <CAEnQRZAfZZFN7TLMfa_MNOM4JEVgDoNnTRMi-ff_O4V-C1o22Q@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: add support for MS5611 pressure and
 temperature sensor
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Tomasz,

On Sun, Mar 8, 2015 at 7:29 PM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> Add support for Measurement Specialities MS5611 pressure
> and temperature sensor.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>

<snip>

> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -0,0 +1,131 @@
> +/*
> + * MS5611 pressure and temperature sensor driver (I2C bus)
> + *
> + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *

If fixed, please specify here the I2C slave address.

> + */
> +#include <linux/delay.h>

<snip>

> +static int ms5611_read_adc(struct ms5611_state *st, s32 *val)
> +{
> +       int ret;
> +       u8 buf[3];
> +
> +       ret = i2c_smbus_read_i2c_block_data(st->client, MS5611_READ_ADC,
> +                                           3, buf);
> +       if (ret < 0)
> +               return ret;
> +
> +       *val = (buf[0] << 16) | (buf[1] << 8) | buf[0];

Hmm, buf[2] is not used. Is this intended or the formula
has buf[2] as the last OR factor?

thanks,
Daniel.
