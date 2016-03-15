Return-Path: <amsfield22@gmail.com>
Date: Tue, 15 Mar 2016 15:38:32 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: isl29028: use regmap to retrieve struct
 device
Message-ID: <20160315223830.GA2120@d830.WORKGROUP>
References: <20160315184903.GA14115@d830.WORKGROUP>
 <56E88BFB.1050307@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E88BFB.1050307@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Mar 15, 2016 at 10:26:03PM +0000, Jonathan Cameron wrote:
> On 15/03/16 18:49, Alison Schofield wrote:
> > Driver includes struct regmap and struct device in its global data.
> > Remove the struct device and use regmap API to retrieve device info.
> > 
> > Simplified version of Coccinelle semantic patch used:
> > 
> > @ a @
> > identifier drvdata, r;
> > position p;
> > @@
> >   struct drvdata@p {
> >   ...
> >   struct regmap *r;
> >   ...
> >   };
> > 
> > @ b @
> > identifier a.drvdata, d;
> > position a.p;
> > @@
> >   struct drvdata@p {
> >   ...
> > - struct device *d;
> >   ...
> >   };
> > 
> > @ passed depends on b @
> > identifier a.drvdata, a.r, b.d, i, f;
> > @@
> >   f (..., struct drvdata *i ,...) {
> > + struct device *dev = regmap_get_device(i->r);
> >    <+...
> > -	   i->d
> > +	   dev
> >    ...+>
> >   }
> > 
> > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> A good little patch, but there are probably a few formatting cleanups
> that should be associated with it.  It results in shortening a few lines
> to the point that 'I think' (have counted wrong before!) that the whole
> functional call will now fit on one line.
> 
> Those want to be done in here as well but will be a case of editing the
> result of the script to do it.  A lot of patches are a hybrid of automated
> and manual edits for exactly this reason.
> 
> I've fixed up the two cases I found and applied.  An annoying number 81 characters!
> 
> Pushed out as testing for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan

Thanks Jonathan.  I see what you mean and will watch for it in future
patches. Do you want me to proof this and send a v2?



> > ---
> >  drivers/staging/iio/light/isl29028.c | 53 ++++++++++++++++++++----------------
> >  1 file changed, 30 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> > index 6e2ba45..0ef96e6 100644
> > --- a/drivers/staging/iio/light/isl29028.c
> > +++ b/drivers/staging/iio/light/isl29028.c
> > @@ -69,7 +69,6 @@ enum als_ir_mode {
> >  };
> >  
> >  struct isl29028_chip {
> > -	struct device		*dev;
> >  	struct mutex		lock;
> >  	struct regmap		*regmap;
> >  
> > @@ -166,20 +165,21 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
> >  
> >  static int isl29028_read_als_ir(struct isl29028_chip *chip, int *als_ir)
> >  {
> > +	struct device *dev = regmap_get_device(chip->regmap);
> >  	unsigned int lsb;
> >  	unsigned int msb;
> >  	int ret;
> >  
> >  	ret = regmap_read(chip->regmap, ISL29028_REG_ALSIR_L, &lsb);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev,
> > +		dev_err(dev,
> >  			"Error in reading register ALSIR_L err %d\n", ret);
> >  		return ret;
> >  	}
> >  
> >  	ret = regmap_read(chip->regmap, ISL29028_REG_ALSIR_U, &msb);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev,
> > +		dev_err(dev,
> >  			"Error in reading register ALSIR_U err %d\n", ret);
> >  		return ret;
> >  	}
> > @@ -190,12 +190,13 @@ static int isl29028_read_als_ir(struct isl29028_chip *chip, int *als_ir)
> >  
> >  static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
> >  {
> > +	struct device *dev = regmap_get_device(chip->regmap);
> >  	unsigned int data;
> >  	int ret;
> >  
> >  	ret = regmap_read(chip->regmap, ISL29028_REG_PROX_DATA, &data);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev, "Error in reading register %d, error %d\n",
> > +		dev_err(dev, "Error in reading register %d, error %d\n",
> >  			ISL29028_REG_PROX_DATA, ret);
> >  		return ret;
> >  	}
> > @@ -218,13 +219,14 @@ static int isl29028_proxim_get(struct isl29028_chip *chip, int *prox_data)
> >  
> >  static int isl29028_als_get(struct isl29028_chip *chip, int *als_data)
> >  {
> > +	struct device *dev = regmap_get_device(chip->regmap);
> >  	int ret;
> >  	int als_ir_data;
> >  
> >  	if (chip->als_ir_mode != MODE_ALS) {
> >  		ret = isl29028_set_als_ir_mode(chip, MODE_ALS);
> >  		if (ret < 0) {
> > -			dev_err(chip->dev,
> > +			dev_err(dev,
> >  				"Error in enabling ALS mode err %d\n", ret);
> >  			return ret;
> >  		}
> > @@ -251,12 +253,13 @@ static int isl29028_als_get(struct isl29028_chip *chip, int *als_data)
> >  
> >  static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
> >  {
> > +	struct device *dev = regmap_get_device(chip->regmap);
> >  	int ret;
> >  
> >  	if (chip->als_ir_mode != MODE_IR) {
> >  		ret = isl29028_set_als_ir_mode(chip, MODE_IR);
> >  		if (ret < 0) {
> > -			dev_err(chip->dev,
> > +			dev_err(dev,
> >  				"Error in enabling IR mode err %d\n", ret);
> >  			return ret;
> >  		}
> > @@ -271,25 +274,26 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
> >  			      int val, int val2, long mask)
> >  {
> >  	struct isl29028_chip *chip = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(chip->regmap);
> >  	int ret = -EINVAL;
> >  
> >  	mutex_lock(&chip->lock);
> >  	switch (chan->type) {
> >  	case IIO_PROXIMITY:
> >  		if (mask != IIO_CHAN_INFO_SAMP_FREQ) {
> > -			dev_err(chip->dev,
> > +			dev_err(dev,
> >  				"proximity: mask value 0x%08lx not supported\n",
> >  				mask);
> >  			break;
> >  		}
> >  		if (val < 1 || val > 100) {
> > -			dev_err(chip->dev,
> > +			dev_err(dev,
> >  				"Samp_freq %d is not in range[1:100]\n", val);
> >  			break;
> >  		}
> >  		ret = isl29028_set_proxim_sampling(chip, val);
> >  		if (ret < 0) {
> > -			dev_err(chip->dev,
> > +			dev_err(dev,
> >  				"Setting proximity samp_freq fail, err %d\n",
> >  				ret);
> >  			break;
> > @@ -299,19 +303,19 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
> >  
> >  	case IIO_LIGHT:
> >  		if (mask != IIO_CHAN_INFO_SCALE) {
> > -			dev_err(chip->dev,
> > +			dev_err(dev,
> >  				"light: mask value 0x%08lx not supported\n",
> >  				mask);
> >  			break;
> >  		}
> >  		if ((val != 125) && (val != 2000)) {
> > -			dev_err(chip->dev,
> > +			dev_err(dev,
> >  				"lux scale %d is invalid [125, 2000]\n", val);
> >  			break;
> >  		}
> >  		ret = isl29028_set_als_scale(chip, val);
> >  		if (ret < 0) {
> > -			dev_err(chip->dev,
> > +			dev_err(dev,
> >  				"Setting lux scale fail with error %d\n", ret);
> >  			break;
> >  		}
> > @@ -319,7 +323,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
> >  		break;
> >  
> >  	default:
> > -		dev_err(chip->dev, "Unsupported channel type\n");
> > +		dev_err(dev, "Unsupported channel type\n");
> >  		break;
> >  	}
> >  	mutex_unlock(&chip->lock);
> > @@ -331,6 +335,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
> >  			     int *val, int *val2, long mask)
> >  {
> >  	struct isl29028_chip *chip = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(chip->regmap);
> >  	int ret = -EINVAL;
> >  
> >  	mutex_lock(&chip->lock);
> > @@ -370,7 +375,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
> >  		break;
> >  
> >  	default:
> > -		dev_err(chip->dev, "mask value 0x%08lx not supported\n", mask);
> > +		dev_err(dev, "mask value 0x%08lx not supported\n", mask);
> >  		break;
> >  	}
> >  	mutex_unlock(&chip->lock);
> > @@ -417,6 +422,7 @@ static const struct iio_info isl29028_info = {
> >  
> >  static int isl29028_chip_init(struct isl29028_chip *chip)
> >  {
> > +	struct device *dev = regmap_get_device(chip->regmap);
> >  	int ret;
> >  
> >  	chip->enable_prox  = false;
> > @@ -426,34 +432,34 @@ static int isl29028_chip_init(struct isl29028_chip *chip)
> >  
> >  	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev, "%s(): write to reg %d failed, err = %d\n",
> > +		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
> >  			__func__, ISL29028_REG_TEST1_MODE, ret);
> >  		return ret;
> >  	}
> >  	ret = regmap_write(chip->regmap, ISL29028_REG_TEST2_MODE, 0x0);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev, "%s(): write to reg %d failed, err = %d\n",
> > +		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
> >  			__func__, ISL29028_REG_TEST2_MODE, ret);
> >  		return ret;
> >  	}
> >  
> >  	ret = regmap_write(chip->regmap, ISL29028_REG_CONFIGURE, 0x0);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev, "%s(): write to reg %d failed, err = %d\n",
> > +		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
> >  			__func__, ISL29028_REG_CONFIGURE, ret);
> >  		return ret;
> >  	}
> >  
> >  	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev, "setting the proximity, err = %d\n",
> > +		dev_err(dev, "setting the proximity, err = %d\n",
> >  			ret);
> >  		return ret;
> >  	}
> >  
> >  	ret = isl29028_set_als_scale(chip, chip->lux_scale);
> >  	if (ret < 0)
> > -		dev_err(chip->dev,
> > +		dev_err(dev,
> >  			"setting als scale failed, err = %d\n", ret);
> There are a few cases in here that I 'think' will now fit on one line
> due to shortening from chip->dev to dev in the dev_err calls.
> 
> Would be nice to do this in this patch.
> >  	return ret;
> >  }
> > @@ -496,19 +502,19 @@ static int isl29028_probe(struct i2c_client *client,
> >  	chip = iio_priv(indio_dev);
> >  
> >  	i2c_set_clientdata(client, indio_dev);
> > -	chip->dev = &client->dev;
> >  	mutex_init(&chip->lock);
> >  
> >  	chip->regmap = devm_regmap_init_i2c(client, &isl29028_regmap_config);
> >  	if (IS_ERR(chip->regmap)) {
> >  		ret = PTR_ERR(chip->regmap);
> > -		dev_err(chip->dev, "regmap initialization failed: %d\n", ret);
> > +		dev_err(&client->dev, "regmap initialization failed: %d\n",
> > +			ret);
> >  		return ret;
> >  	}
> >  
> >  	ret = isl29028_chip_init(chip);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev, "chip initialization failed: %d\n", ret);
> > +		dev_err(&client->dev, "chip initialization failed: %d\n", ret);
> >  		return ret;
> >  	}
> >  
> > @@ -520,7 +526,8 @@ static int isl29028_probe(struct i2c_client *client,
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> >  	if (ret < 0) {
> > -		dev_err(chip->dev, "iio registration fails with error %d\n",
> > +		dev_err(&client->dev,
> > +			"iio registration fails with error %d\n",
> >  			ret);
> >  		return ret;
> >  	}
> > 
> 
