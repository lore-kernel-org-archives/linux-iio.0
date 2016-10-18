Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:55182 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755723AbcJRNvQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2016 09:51:16 -0400
Date: Tue, 18 Oct 2016 15:51:10 +0200
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: dac: mcp4725: support voltage reference
 selection
Message-ID: <20161018155110.72d90b46@tomas.local.tbs-biometrics.cz>
In-Reply-To: <e015de34-51bd-f43b-4a9f-cfe047d4fb3c@kernel.org>
References: <1476194263-12015-1-git-send-email-tomas@novotny.cz>
        <1476194263-12015-3-git-send-email-tomas@novotny.cz>
        <e015de34-51bd-f43b-4a9f-cfe047d4fb3c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, 15 Oct 2016 15:07:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On 11/10/16 14:57, Tomas Novotny wrote:
> > MCP47x6 chip supports selection of a voltage reference (VDD, VREF buffered
> > or unbuffered). MCP4725 doesn't have this feature thus the eventual setting
> > is ignored and user is warned.
> > 
> > The setting is stored only in the volatile memory of the chip. You need to
> > manually store it to the EEPROM of the chip via 'store_eeprom' sysfs entry.
> > 
> > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> A few minor bits inline.  I think we should error out on invalid settings
> in the platform data.  Last thing we want to do is to have to have the driver
> papering over these issues and get bitten years down the line by some refactoring
> that suddenly doesn't paper over them any more.
> 
> Also, a sneaky unconnected error in a comment in here which needs to be broken
> out to it's own patch as nothing much to do with this. (good spot though!)
> 
> Jonathan
> > ---
> >  drivers/iio/dac/mcp4725.c       | 98 ++++++++++++++++++++++++++++++++++++++---
> >  include/linux/iio/dac/mcp4725.h |  2 +
> >  2 files changed, 93 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> > index 2b28b1f..29cf85d 100644
> > --- a/drivers/iio/dac/mcp4725.c
> > +++ b/drivers/iio/dac/mcp4725.c
> > @@ -27,12 +27,20 @@
> >  
> >  #define MCP4725_DRV_NAME "mcp4725"
> >  
> > +#define MCP472X_REF_VDD			0x00
> > +#define MCP472X_REF_VREF_UNBUFFERED	0x02
> > +#define MCP472X_REF_VREF_BUFFERED	0x03
> > +
> >  struct mcp4725_data {
> >  	struct i2c_client *client;
> > +	int id;
> > +	unsigned ref_mode;
> > +	bool vref_buffered;
> >  	u16 dac_value;
> >  	bool powerdown;
> >  	unsigned powerdown_mode;
> >  	struct regulator *vdd_reg;
> > +	struct regulator *vref_reg;
> >  };
> >  
> >  static int mcp4725_suspend(struct device *dev)
> > @@ -87,6 +95,7 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
> >  		return 0;
> >  
> >  	inoutbuf[0] = 0x60; /* write EEPROM */
> > +	inoutbuf[0] |= data->ref_mode << 3;
> >  	inoutbuf[1] = data->dac_value >> 4;
> >  	inoutbuf[2] = (data->dac_value & 0xf) << 4;
> >  
> > @@ -279,6 +288,28 @@ static int mcp4725_set_value(struct iio_dev *indio_dev, int val)
> >  		return 0;
> >  }
> >  
> > +static int mcp4726_set_cfg(struct iio_dev *indio_dev)
> > +{
> > +	struct mcp4725_data *data = iio_priv(indio_dev);
> > +	u8 outbuf[3];
> > +	int ret;
> > +
> > +	outbuf[0] = 0x40;
> > +	outbuf[0] |= data->ref_mode << 3;
> > +	if (data->powerdown)
> > +		outbuf[0] |= data->powerdown << 1;
> > +	outbuf[1] = data->dac_value >> 4;
> > +	outbuf[2] = (data->dac_value & 0xf) << 4;
> > +
> > +	ret = i2c_master_send(data->client, outbuf, 3);
> > +	if (ret < 0)
> > +		return ret;
> > +	else if (ret != 3)
> > +		return -EIO;
> > +	else
> > +		return 0;
> > +}
> > +
> >  static int mcp4725_read_raw(struct iio_dev *indio_dev,
> >  			   struct iio_chan_spec const *chan,
> >  			   int *val, int *val2, long mask)
> > @@ -291,7 +322,11 @@ static int mcp4725_read_raw(struct iio_dev *indio_dev,
> >  		*val = data->dac_value;
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_SCALE:
> > -		ret = regulator_get_voltage(data->vdd_reg);
> > +		if (data->ref_mode == MCP472X_REF_VDD)
> > +			ret = regulator_get_voltage(data->vdd_reg);
> > +		else
> > +			ret = regulator_get_voltage(data->vref_reg);
> > +
> >  		if (ret < 0)
> >  			return ret;
> >  
> > @@ -335,8 +370,9 @@ static int mcp4725_probe(struct i2c_client *client,
> >  	struct mcp4725_data *data;
> >  	struct iio_dev *indio_dev;
> >  	struct mcp4725_platform_data *pdata = dev_get_platdata(&client->dev);
> > -	u8 inbuf[3];
> > +	u8 inbuf[4];
> >  	u8 pd;
> > +	u8 ref;
> >  	int err;
> >  
> >  	if (!pdata) {
> > @@ -350,6 +386,26 @@ static int mcp4725_probe(struct i2c_client *client,
> >  	data = iio_priv(indio_dev);
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client = client;
> > +	data->id = id->driver_data;
> > +
> > +	if (data->id == MCP4725 && pdata->use_vref) {
> > +		dev_warn(&client->dev,
> > +			"ignoring unavailable external reference on MCP4725");
> Could make this an error case as something is horribly wrong if it occurs.

ok, I will scream a bit louder.

> > +		pdata->use_vref = false;
> > +	}
> > +
> > +	if (!pdata->use_vref && pdata->vref_buffered) {
> > +		dev_warn(&client->dev,
> > +			"buffering is unavailable on the internal reference");
> > +		pdata->vref_buffered = false;
> Likewise here. Invalid state so should really error out.

same here.

> > +	}
> > +
> > +	if (!pdata->use_vref)
> > +		data->ref_mode = MCP472X_REF_VDD;
> > +	else
> > +		data->ref_mode = pdata->vref_buffered ?
> > +			MCP472X_REF_VREF_BUFFERED :
> > +			MCP472X_REF_VREF_UNBUFFERED;
> >  
> >  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> >  	if (IS_ERR(data->vdd_reg))
> > @@ -359,6 +415,18 @@ static int mcp4725_probe(struct i2c_client *client,
> >  	if (err)
> >  		return err;
> >  
> > +	if (pdata->use_vref) {
> > +		data->vref_reg = devm_regulator_get(&client->dev, "vref");
> > +		if (IS_ERR(data->vref_reg)) {
> > +			err =  PTR_ERR(data->vdd_reg);
> Looks like you have a stray space in the line above.

oh, good catch.
 
> > +			goto err_disable_vdd_reg;
> > +		}
> > +
> > +		err = regulator_enable(data->vref_reg);
> > +		if (err)
> > +			goto err_disable_vdd_reg;
> > +	}
> > +
> >  	indio_dev->dev.parent = &client->dev;
> >  	indio_dev->name = id->name;
> >  	indio_dev->info = &mcp4725_info;
> > @@ -366,23 +434,37 @@ static int mcp4725_probe(struct i2c_client *client,
> >  	indio_dev->num_channels = 1;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> > -	/* read current DAC value */
> > -	err = i2c_master_recv(client, inbuf, 3);
> > +	/* read current DAC value and settings */
> > +	err = i2c_master_recv(client, inbuf, data->id == MCP4725 ? 3 : 4);
> >  	if (err < 0) {
> >  		dev_err(&client->dev, "failed to read DAC value");
> > -		goto err_disable_vdd_reg;
> > +		goto err_disable_vref_reg;
> >  	}
> >  	pd = (inbuf[0] >> 1) & 0x3;
> >  	data->powerdown = pd > 0 ? true : false;
> > -	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
> > +	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
> This fix is clearly right, but not part of the change this patch is making.
> Please break out to a separate patch.

ok, I will do.

> >  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
> > +	if (data->id == MCP4726)
> > +		ref = (inbuf[3] >> 3) & 0x3;
> > +
> > +	if (data->id == MCP4726 && ref != data->ref_mode) {
> > +		dev_info(&client->dev,
> > +			"voltage reference mode differs (conf: %u, eeprom: %u), setting %u",
> > +			data->ref_mode, ref, data->ref_mode);
> > +		err = mcp4726_set_cfg(indio_dev);
> > +		if (err < 0)
> > +			goto err_disable_vref_reg;
> > +	}
> >  
> >  	err = iio_device_register(indio_dev);
> >  	if (err)
> > -		goto err_disable_vdd_reg;
> > +		goto err_disable_vref_reg;
> >  
> >  	return 0;
> >  
> > +err_disable_vref_reg:
> > +	if (data->vref_reg)
> > +		regulator_disable(data->vref_reg);
> >  
> >  err_disable_vdd_reg:
> >  	regulator_disable(data->vdd_reg);
> > @@ -397,6 +479,8 @@ static int mcp4725_remove(struct i2c_client *client)
> >  
> >  	iio_device_unregister(indio_dev);
> >  
> > +	if (data->vref_reg)
> > +		regulator_disable(data->vref_reg);
> >  	regulator_disable(data->vdd_reg);
> >  
> >  	return 0;
> > diff --git a/include/linux/iio/dac/mcp4725.h b/include/linux/iio/dac/mcp4725.h
> > index 7c062e8..0684cf6 100644
> > --- a/include/linux/iio/dac/mcp4725.h
> > +++ b/include/linux/iio/dac/mcp4725.h
> > @@ -10,6 +10,8 @@
> >  #define IIO_DAC_MCP4725_H_
> >  
> Some docs on this seems wise. Maybe state the restrictions (i.e. which parts
> support which combinations).

I will write a short info here with a link to the dt documentation.

Thanks for the review,

Tomas

> >  struct mcp4725_platform_data {
> > +	bool use_vref;
> > +	bool vref_buffered;
> >  };
> >  
> >  #endif /* IIO_DAC_MCP4725_H_ */
> > 
> 
