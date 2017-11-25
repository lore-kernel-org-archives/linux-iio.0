Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbdKYOVU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:20 -0500
Date: Sat, 25 Nov 2017 14:17:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 10/13] iio: health: max30102: Move mode setting to
 buffer_postenable
Message-ID: <20171125141740.72135089@archlinux>
In-Reply-To: <CAJCx=gn3VAVO-z9y1S-F2wB9Oag1cexMpGu83s_BS0jf5U7nOw@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-11-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gn3VAVO-z9y1S-F2wB9Oag1cexMpGu83s_BS0jf5U7nOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 12:56:28 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> > Move the programming of the mode setting from init() to
> > buffer_postenable()
> >
> > Split out a separate function to
> > only update the power/shutdown bit
> >
> > This changes permits to more easily implement different
> > modes of measurements in further patches
> >
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.
> 
> > ---
> >  drivers/iio/health/max30102.c | 44 +++++++++++++++++++++++++++----------------
> >  1 file changed, 28 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index 37176c2..1c7fe63 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -66,6 +66,7 @@ enum max3012_led_idx {
> >  #define MAX30102_REG_FIFO_CONFIG_AFULL         BIT(0)
> >
> >  #define MAX30102_REG_MODE_CONFIG               0x09
> > +#define MAX30102_REG_MODE_CONFIG_MODE_NONE     0x00
> >  #define MAX30102_REG_MODE_CONFIG_MODE_HR       0x02 /* red LED */
> >  #define MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2  0x03 /* red + IR LED */
> >  #define MAX30102_REG_MODE_CONFIG_MODE_MULTI    0x07 /* multi-LED mode */
> > @@ -139,25 +140,41 @@ static const struct iio_chan_spec max30102_channels[] = {
> >         },
> >  };
> >
> > -static int max30102_set_powermode(struct max30102_data *data, bool state)
> > +static int max30102_set_power(struct max30102_data *data, bool en)
> >  {
> >         return regmap_update_bits(data->regmap, MAX30102_REG_MODE_CONFIG,
> >                                   MAX30102_REG_MODE_CONFIG_PWR,
> > -                                 state ? 0 : MAX30102_REG_MODE_CONFIG_PWR);
> > +                                 en ? 0 : MAX30102_REG_MODE_CONFIG_PWR);
> > +}
> > +
> > +static int max30102_set_powermode(struct max30102_data *data, u8 mode, bool en)
> > +{
> > +       u8 reg = mode;
> > +
> > +       if (!en)
> > +               reg |= MAX30102_REG_MODE_CONFIG_PWR;
> > +
> > +       return regmap_update_bits(data->regmap, MAX30102_REG_MODE_CONFIG,
> > +                                 MAX30102_REG_MODE_CONFIG_PWR |
> > +                                 MAX30102_REG_MODE_CONFIG_MODE_MASK, reg);
> >  }
> >
> >  static int max30102_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> >         struct max30102_data *data = iio_priv(indio_dev);
> > +       u8 reg;
> > +
> > +       reg = MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2;
> >
> > -       return max30102_set_powermode(data, true);
> > +       return max30102_set_powermode(data, reg, true);
> >  }
> >
> >  static int max30102_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> >         struct max30102_data *data = iio_priv(indio_dev);
> >
> > -       return max30102_set_powermode(data, false);
> > +       return max30102_set_powermode(data, MAX30102_REG_MODE_CONFIG_MODE_NONE,
> > +                                     false);
> >  }
> >
> >  static const struct iio_buffer_setup_ops max30102_buffer_setup_ops = {
> > @@ -278,7 +295,7 @@ static int max30102_chip_init(struct max30102_data *data)
> >         if (ret)
> >                 return ret;
> >
> > -       /* enable 18-bit HR + SPO2 readings at 400Hz */
> > +       /* configure 18-bit HR + SpO2 readings at 400Hz */
> >         ret = regmap_write(data->regmap, MAX30102_REG_SPO2_CONFIG,
> >                                 (MAX30102_REG_SPO2_CONFIG_ADC_4096_STEPS
> >                                  << MAX30102_REG_SPO2_CONFIG_ADC_MASK_SHIFT) |
> > @@ -288,13 +305,6 @@ static int max30102_chip_init(struct max30102_data *data)
> >         if (ret)
> >                 return ret;
> >
> > -       /* enable HR + SPO2 mode */
> > -       ret = regmap_update_bits(data->regmap, MAX30102_REG_MODE_CONFIG,
> > -                                MAX30102_REG_MODE_CONFIG_MODE_MASK,
> > -                                MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2);
> > -       if (ret)
> > -               return ret;
> > -
> >         /* average 4 samples + generate FIFO interrupt */
> >         ret = regmap_write(data->regmap, MAX30102_REG_FIFO_CONFIG,
> >                                 (MAX30102_REG_FIFO_CONFIG_AVG_4SAMPLES
> > @@ -334,7 +344,7 @@ static int max30102_get_temp(struct max30102_data *data, int *val, bool en)
> >         int ret;
> >
> >         if (en) {
> > -               ret = max30102_set_powermode(data, true);
> > +               ret = max30102_set_power(data, true);
> >                 if (ret)
> >                         return ret;
> >         }
> > @@ -351,7 +361,7 @@ static int max30102_get_temp(struct max30102_data *data, int *val, bool en)
> >
> >  out:
> >         if (en)
> > -               max30102_set_powermode(data, false);
> > +               max30102_set_power(data, false);
> >
> >         return ret;
> >  }
> > @@ -448,7 +458,9 @@ static int max30102_probe(struct i2c_client *client,
> >                 return ret;
> >         dev_dbg(&client->dev, "max3010x revision %02x\n", reg);
> >
> > -       ret = max30102_set_powermode(data, false);
> > +       /* clear mode setting, chip shutdown */
> > +       ret = max30102_set_powermode(data, MAX30102_REG_MODE_CONFIG_MODE_NONE,
> > +                                    false);
> >         if (ret)
> >                 return ret;
> >
> > @@ -479,7 +491,7 @@ static int max30102_remove(struct i2c_client *client)
> >         struct max30102_data *data = iio_priv(indio_dev);
> >
> >         iio_device_unregister(indio_dev);
> > -       max30102_set_powermode(data, false);
> > +       max30102_set_power(data, false);
> >
> >         return 0;
> >  }
> > --
> > 2.7.4
> >  

