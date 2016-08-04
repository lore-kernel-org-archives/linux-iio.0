Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:36664 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcHDGB3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 4 Aug 2016 02:01:29 -0400
Date: Thu, 4 Aug 2016 07:19:20 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matt Ranostay <mranostay@gmail.com>
cc: Alison Schofield <amsfield22@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: humidity: hdc100x: use i2c_master_recv to read
 sensor data
In-Reply-To: <CAKzfze9bEdoPTri=+MTK2LPXAJZxwXKP=T_jTKk4aO38ZyANzA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1608040718070.16194@pmeerw.net>
References: <20160804033253.GA31586@d830.WORKGROUP> <CAKzfze9bEdoPTri=+MTK2LPXAJZxwXKP=T_jTKk4aO38ZyANzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > Replace the i2c_smbus_read_byte commmands used to retrieve the sensor
> > data with an i2c_master_recv command.
> >
> > The smbus read byte method fails because the device does not expect a
> > stop condition after sending the first byte. When we issue the second
> > read, we are getting the first byte again. Net effect is that of the 14
> > bits used for the measurement, the 8 most significant bits are correct,
> > the lower 6 are not.
> >
> > None of the smbus read protocols follow the pattern this device requires
> > (S Addr Rd [A] Data [A] Data NA P), hence the switch to an i2c receive
> > transaction.
> >
> > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > ---
> >  drivers/iio/humidity/hdc100x.c | 27 +++++++--------------------
> >  1 file changed, 7 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index a03832a..643a42d 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -142,7 +142,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
> >         struct i2c_client *client = data->client;
> >         int delay = data->adc_int_us[chan->address];
> >         int ret;
> > -       int val;
> > +       u8 buf[2];

__le16 val;

> >
> >         /* start measurement */
> >         ret = i2c_smbus_write_byte(client, chan->address);
> > @@ -154,26 +154,13 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
> >         /* wait for integration time to pass */
> >         usleep_range(delay, delay + 1000);
> >
> > -       /*
> > -        * i2c_smbus_read_word_data cannot() be used here due to the command
> > -        * value not being understood and causes NAKs preventing any reading
> > -        * from being accessed.
> > -        */
> > -       ret = i2c_smbus_read_byte(client);
> > +       /* read the 2 byte measurement */
> > +       ret = i2c_master_recv(data->client, buf, 2);
> >         if (ret < 0) {
> > -               dev_err(&client->dev, "cannot read high byte measurement");
> > +               dev_err(&client->dev, "cannot read sensor data\n");
> >                 return ret;
> >         }
> > -       val = ret << 8;
> > -
> > -       ret = i2c_smbus_read_byte(client);
> > -       if (ret < 0) {
> > -               dev_err(&client->dev, "cannot read low byte measurement");
> > -               return ret;
> > -       }
> > -       val |= ret;
> > -
> > -       return val;
> > +       return (int)(buf[0] << 8 | buf[1]);
> 
> Pretty sure you don't need to cast to int type here.

return le16_to_cpu(val);

> 
> >  }
> >
> >  static int hdc100x_get_heater_status(struct hdc100x_data *data)
> > @@ -272,8 +259,8 @@ static int hdc100x_probe(struct i2c_client *client,
> >         struct iio_dev *indio_dev;
> >         struct hdc100x_data *data;
> >
> > -       if (!i2c_check_functionality(client->adapter,
> > -                               I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
> > +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
> > +                                    I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
> 
> Not sure we want to kill smbus support for this device...  iwe should
> have two read methods for i2c and smbus (see the PulsedLight LIDAR
> driver) in this case.
> 
> Ideally I wouldn't have written it with only smbus in mind, but can
> kill backwards compatibility unless we have a good reason.
> 
> Thanks,
> 
> Matt
> 
> >                 return -EOPNOTSUPP;
> >
> >         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > --
> > 2.1.4
> >
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
