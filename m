Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33538 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdEBVFB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2017 17:05:01 -0400
MIME-Version: 1.0
In-Reply-To: <20170502121554.GD3030@Socrates-UM>
References: <cover.1493450577.git.eraretuya@gmail.com> <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
 <CAHp75VcTptSxGnHJzosbio-8PG3ojgr2vfhL9QuUf+OgeCQWGA@mail.gmail.com> <20170502121554.GD3030@Socrates-UM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 May 2017 00:05:00 +0300
Message-ID: <CAHp75Vfu_6Lw-JbuB0ensrP-9hPDKavaSJO0s3wGM8Vm2Gwuhg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: accel: adxl345: Setup DATA_READY trigger
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 2, 2017 at 3:15 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> On Mon, May 01, 2017 at 02:31:00PM +0300, Andy Shevchenko wrote:
> [...]
>> > -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>> > +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
>> >                        const char *name);
>>
>> I think I commented this once. Instead of increasing parameters,
>> please introduce a new struct (as separate preparatory patch) which
>> will hold current parameters. Let's call it
>> strut adxl345_chip {
>>  struct device *dev;
>>  struct regmap *regmap;
>>  const char *name;
>> };
>>
>> I insisnt in this chage.
>
> I'm not sure if what you want is more simpler, is it something like what
> this driver does?

Nope. The driver you were referring to does the same you did.

I'm proposing the above struct to be introduced along with changing
prototype like:

 -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
const char *name);
 +int adxl345_core_probe(struct adxl345_chip *chip);

In next patch adding interrupt would not touch prototypes at all!

>
> http://lxr.free-electrons.com/source/drivers/iio/gyro/mpu3050.h#L41
> http://lxr.free-electrons.com/source/drivers/iio/gyro/mpu3050-i2c.c#L34

>> > +#include <linux/of_irq.h>
>>
>> Can we get rid of gnostic resource providers?
>>
>
> I'm uninformed and still learning. Please let me know how to approach
> this in some other way.

I suppose something like platform_get_irq(); to use.
But it would be nice to you to investigate more.

-- 
With Best Regards,
Andy Shevchenko
