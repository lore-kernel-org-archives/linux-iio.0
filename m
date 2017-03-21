Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34386 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756327AbdCUKD2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 06:03:28 -0400
Date: Tue, 21 Mar 2017 17:56:57 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: accel: adxl345: Add support for triggered buffer
Message-ID: <20170321095655.GA5213@Socrates-UM>
References: <1489403497-27849-1-git-send-email-eraretuya@gmail.com>
 <1489403497-27849-5-git-send-email-eraretuya@gmail.com>
 <CAHp75VefS18nAH3HkQgNdmo5oUWoaQ7ctj=eXHx9XjwrJtZzuQ@mail.gmail.com>
 <8da981ed-6ce0-0be5-6b56-c3c1ec0d5dab@kernel.org>
 <f03e9577-41f9-8f1f-1963-3e8cbac5f979@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f03e9577-41f9-8f1f-1963-3e8cbac5f979@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 20, 2017 at 08:46:11PM +0100, Lars-Peter Clausen wrote:
> On 03/15/2017 10:50 PM, Jonathan Cameron wrote:
> > On 13/03/17 12:16, Andy Shevchenko wrote:
> >> On Mon, Mar 13, 2017 at 1:11 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> >>> Provide an all-axes read for triggered buffering.
> >>
> >> Better description is needed.
> >>
> >>> -static int adxl345_get_triple(struct adxl345_data *data, void *buf)
> >>> +static int adxl345_get_triple(struct adxl345_data *data)
> >>
> >> Ping-ponging again. This should be essentially a change in the patch
> >> where you introduce a helper.
> >>
> >>> +err_buffer_cleanup:
> >>> +       iio_triggered_buffer_cleanup(indio_dev);
> >>>  err_trigger_unregister:
> >>>         if (data->drdy_trig)
> >>>                 iio_trigger_unregister(data->drdy_trig);
> >>
> >> devm_iio_*() ?
> >>
> >>> @@ -334,6 +435,7 @@ int adxl345_core_remove(struct device *dev)
> >>>         struct adxl345_data *data = iio_priv(indio_dev);
> >>>
> >>>         iio_device_unregister(indio_dev);
> >>> +       iio_triggered_buffer_cleanup(indio_dev);
> >>>         if (data->drdy_trig)
> >>>                 iio_trigger_unregister(data->drdy_trig);
> >>
> >> Ditto.
> >>
> >>> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> >>> index 8c791b8..1e0f071 100644
> >>> --- a/drivers/iio/accel/adxl345_i2c.c
> >>> +++ b/drivers/iio/accel/adxl345_i2c.c
> >>> @@ -30,6 +30,10 @@ static int adxl345_i2c_probe(struct i2c_client *client,
> >>>         bool use_int2 = false;
> >>>         int irq;
> >>>
> >>> +       if (!i2c_check_functionality(client->adapter,
> >>> +                                    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> >>> +               return -EOPNOTSUPP;
> >>
> >> And if driver works before, you make a regression here.
> > Absolutely. Need a fallback if it's not supported...
> 
> I believe regmap has a fallback, so that check could simply be removed, I guess.
> 

Yes, regmap does this check. I've seen it while working on the patchset.
I checked other drivers doing regmap and some have this check_functionality
check so I chose to include it because I'm not sure.

Will remove it on the next version.

Thanks,
Eva
