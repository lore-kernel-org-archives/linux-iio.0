Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:39157 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087AbbCITF5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 15:05:57 -0400
Date: Mon, 9 Mar 2015 20:00:57 +0100
From: tduszyns@gmail.com
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: pressure: add support for MS5611 pressure and
 temperature sensor
Message-ID: <20150309190057.GB598@Arch.lan>
References: <1425835778-7827-1-git-send-email-tduszyns@gmail.com>
 <CAEnQRZAfZZFN7TLMfa_MNOM4JEVgDoNnTRMi-ff_O4V-C1o22Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAEnQRZAfZZFN7TLMfa_MNOM4JEVgDoNnTRMi-ff_O4V-C1o22Q@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 08, 2015 at 09:11:07PM +0200, Daniel Baluta wrote:
> Hi Tomasz,
>
> On Sun, Mar 8, 2015 at 7:29 PM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> > Add support for Measurement Specialities MS5611 pressure
> > and temperature sensor.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
>
> <snip>
>
> > +++ b/drivers/iio/pressure/ms5611_i2c.c
> > @@ -0,0 +1,131 @@
> > +/*
> > + * MS5611 pressure and temperature sensor driver (I2C bus)
> > + *
> > + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
>
> If fixed, please specify here the I2C slave address.
OK
>
> > + */
> > +#include <linux/delay.h>
>
> <snip>
>
> > +static int ms5611_read_adc(struct ms5611_state *st, s32 *val)
> > +{
> > +       int ret;
> > +       u8 buf[3];
> > +
> > +       ret = i2c_smbus_read_i2c_block_data(st->client, MS5611_READ_ADC,
> > +                                           3, buf);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       *val = (buf[0] << 16) | (buf[1] << 8) | buf[0];
>
> Hmm, buf[2] is not used. Is this intended or the formula
> has buf[2] as the last OR factor?
You're right. Last factor should be buf[2].
>
> thanks,
> Daniel.

Thanks for review!
