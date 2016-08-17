Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33096 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbcHQRp4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2016 13:45:56 -0400
Date: Wed, 17 Aug 2016 10:45:54 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc100x: fix sensor data reads of temp
 and humidity
Message-ID: <20160817174552.GA17877@d830.WORKGROUP>
References: <20160808181430.GA2852@d830.WORKGROUP>
 <8136e55d-1acd-cd56-e879-14877a16a43c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8136e55d-1acd-cd56-e879-14877a16a43c@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 15, 2016 at 05:27:00PM +0100, Jonathan Cameron wrote:
> On 08/08/16 19:14, Alison Schofield wrote:
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
> Hi Alison,
> 
> Nice fix.  Note that I'd have liked a fixes: tag for this one...
> It's a bit fiddly as will need backporting to older stable kernels.
> 
> I'll leave it marked for stable but with no version. As long as
> it applies cleanly it should be fine.
> 
> Applied to the fixes-togreg branch of iio.git.
> 
> Thanks,
> 
> Jonathan

Here's the fixes tag, if you can still insert it...

	Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")

alisons

> 
> > ---
> > Changes in v2:
> >   update commit message to say what this fixes
> >   use endian type & macro to correctly manage byte order
> >   use sizeof for data length
> > 
> >  drivers/iio/humidity/hdc100x.c | 27 +++++++--------------------
> >  1 file changed, 7 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index a03832a..e0c9c70 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -142,7 +142,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
> >  	struct i2c_client *client = data->client;
> >  	int delay = data->adc_int_us[chan->address];
> >  	int ret;
> > -	int val;
> > +	__be16 val;
> >  
> >  	/* start measurement */
> >  	ret = i2c_smbus_write_byte(client, chan->address);
> > @@ -154,26 +154,13 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
> >  	/* wait for integration time to pass */
> >  	usleep_range(delay, delay + 1000);
> >  
> > -	/*
> > -	 * i2c_smbus_read_word_data cannot() be used here due to the command
> > -	 * value not being understood and causes NAKs preventing any reading
> > -	 * from being accessed.
> > -	 */
> > -	ret = i2c_smbus_read_byte(client);
> > +	/* read measurement */
> > +	ret = i2c_master_recv(data->client, (char *)&val, sizeof(val));
> >  	if (ret < 0) {
> > -		dev_err(&client->dev, "cannot read high byte measurement");
> > +		dev_err(&client->dev, "cannot read sensor data\n");
> >  		return ret;
> >  	}
> > -	val = ret << 8;
> > -
> > -	ret = i2c_smbus_read_byte(client);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev, "cannot read low byte measurement");
> > -		return ret;
> > -	}
> > -	val |= ret;
> > -
> > -	return val;
> > +	return be16_to_cpu(val);
> >  }
> >  
> >  static int hdc100x_get_heater_status(struct hdc100x_data *data)
> > @@ -272,8 +259,8 @@ static int hdc100x_probe(struct i2c_client *client,
> >  	struct iio_dev *indio_dev;
> >  	struct hdc100x_data *data;
> >  
> > -	if (!i2c_check_functionality(client->adapter,
> > -				I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
> > +				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
> >  		return -EOPNOTSUPP;
> >  
> >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > 
> 
