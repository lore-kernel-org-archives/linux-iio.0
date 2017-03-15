Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35269 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdCOJt3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 05:49:29 -0400
Date: Wed, 15 Mar 2017 17:49:25 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
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
Subject: Re: [PATCH 3/4] iio: accel: adxl345: Setup DATA_READY trigger
Message-ID: <20170315094923.GA3080@Socrates-UM>
References: <1489403497-27849-1-git-send-email-eraretuya@gmail.com>
 <1489403497-27849-4-git-send-email-eraretuya@gmail.com>
 <CAHp75Vcz1RTdncG5L1S7q2LVHK6TEA813pjTpue4n3DDcCrMAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75Vcz1RTdncG5L1S7q2LVHK6TEA813pjTpue4n3DDcCrMAg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 13, 2017 at 02:12:54PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 13, 2017 at 1:11 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> 

Hello Andy,
Thanks for the review.

> Missed commit message is no-no!
> 
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> 
> > -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> > -                      const char *name);
> > +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
> > +                      const char *name, bool use_int2);
> 
> Hmm... And tomorrow you will add another flag and another.
> 
> No, consider to use something like
> 
> struct adxl345_chip {
>  struct device *dev;
>  struct regmap *regmap;
>  const char *name;
> }
> 
> Convert your probe to use it, and after extend for your needs.
> 
> >  #define ADXL345_DEVID                  0xE5
> >
> > +#define ADXL345_IRQ_NAME               "adxl345_event"
> 
> 
> >  struct adxl345_data {
> > +       struct iio_trigger *drdy_trig;
> >         struct regmap *regmap;
> > +       bool drdy_trig_on;
> >         u8 data_range;
> 
> drdy -> data_ready
> 
> > +static irqreturn_t adxl345_irq(int irq, void *p)
> > +{
> > +       struct iio_dev *indio_dev = p;
> > +       struct adxl345_data *data = iio_priv(indio_dev);
> > +       int ret = IRQ_NONE;
> > +       u32 int_stat;
> > +
> 
> > +       ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &int_stat);
> 
> > +       if (ret < 0)
> > +               return ret;
> 
> It makes little sense AFAIU.
> 

Can you please elaborate further your comment regarding this?

> > +
> > +       if (int_stat & ADXL345_INT_DATA_READY) {
> > +               iio_trigger_poll(data->drdy_trig);
> > +               ret = IRQ_HANDLED;
> > +       }
> > +
> > +       return ret;
> 
> Useless variable ret. You may return values directly.
> 
> > +}
> > +
> > +static int adxl345_drdy_trigger_set_state(struct iio_trigger *trig, bool state)
> > +{
> > +       struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +       struct adxl345_data *data = iio_priv(indio_dev);
> > +       struct device *dev;
> > +       int ret;
> > +
> 
> > +       dev = regmap_get_device(data->regmap);
> 
> This may be moved to definition block.
> 
> > +       ret = regmap_update_bits(data->regmap, ADXL345_REG_INT_ENABLE,
> 
> > +                                ADXL345_INT_DATA_READY, (state ?
> > +                                ADXL345_INT_DATA_READY : 0));
> 
> No way:
>  Don't split lines like this.
>  Remove extra parens.
> 
> > +static const struct iio_trigger_ops adxl345_trigger_ops = {
> 
> > +       .owner = THIS_MODULE,
> 
> I dunno if we still need this.
> 
> >  static const struct iio_info adxl345_info = {
> 
> >         .driver_module  = THIS_MODULE,
> 
> Ditto.
> 
> >         .read_raw       = adxl345_read_raw,
> >  };
> 
> > +       /*
> > +        * Any bits set to 0 send their respective interrupts to the INT1 pin,
> > +        * whereas bits set to 1 send their respective interrupts to the INT2
> > +        * pin. Map all interrupts to the specified pin.
> > +        */
> 
> > +       if (!use_int2)
> > +               ret = regmap_write(data->regmap, ADXL345_REG_INT_MAP, 0x00);
> > +       else
> > +               ret = regmap_write(data->regmap, ADXL345_REG_INT_MAP, 0xFF);
> 
> I would create a temporary variable to hold the value and call
> regmap_write() unconditionally.
> 
> 
> > -       return iio_device_register(indio_dev);
> 
> You are not supposed to ping-pong changes in your series. Make clear
> your goal either you do like above or like below. If you choose
> latter, don't alter it in previous patch.
> 

Ack. Will revise carefully with consideration to your comments in this
whole series.

> > +       if (irq > 0) {
> 
> > +               ret =
> > +               devm_request_threaded_irq(dev, irq, NULL, adxl345_irq,
> 
> Don't split lines like this.
> 
> > +                                         IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> 
> Are you sure you have threaded IRQ handler?
> 
> > +       ret = iio_device_register(indio_dev);
> > +       if (ret < 0) {
> > +               dev_err(dev, "iio_device_register failed: %d\n", ret);
> > +               goto err_trigger_unregister;
> > +       }
> > +
> > +       return ret;
> 
> > +err_trigger_unregister:
> > +       if (data->drdy_trig)
> > +               iio_trigger_unregister(data->drdy_trig);
> > +
> > +       return ret;
> 
> So, doesn't devm_iio_*() provide a facility to avoid this?
> 
> > @@ -229,6 +334,8 @@ int adxl345_core_remove(struct device *dev)
> >         struct adxl345_data *data = iio_priv(indio_dev);
> >
> >         iio_device_unregister(indio_dev);
> > +       if (data->drdy_trig)
> > +               iio_trigger_unregister(data->drdy_trig);
> 
> Ditto.
> 
> > --- a/drivers/iio/accel/adxl345_i2c.c
> > +++ b/drivers/iio/accel/adxl345_i2c.c
> 
> > -       return adxl345_core_probe(&client->dev, regmap, id ? id->name : NULL);
> > +       irq = of_irq_get_byname(client->dev.of_node, "INT2");
> > +       if (irq == client->irq)
> > +               use_int2 = true;
> 
> Can't you use platform_get_irq() instead?
> 
> 
> > -       return adxl345_core_probe(&spi->dev, regmap, id->name);
> > +       irq = of_irq_get_byname(spi->dev.of_node, "INT2");
> > +       if (irq == spi->irq)
> > +               use_int2 = true;
> 
> Ditto.
> 
> P.S. Are you doing this stuff on your own or you are working for some
> company? If the latter applies, please, consider to do *internal*
> review first.
> 

I'm doing it on my own as a project for Outreachy and have mentors to ask
for advice and/or questions.

Eva

> -- 
> With Best Regards,
> Andy Shevchenko
