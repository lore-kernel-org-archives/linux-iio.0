Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:36581 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbcJXKQt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2016 06:16:49 -0400
Date: Mon, 24 Oct 2016 12:16:43 +0200
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: dac: mcp4725: support voltage reference
 selection
Message-ID: <20161024121643.478feb72@tomas.local.tbs-biometrics.cz>
In-Reply-To: <2a820b1f-b6d7-88f9-7403-06a1c5e3b2ee@kernel.org>
References: <1476812589-18333-1-git-send-email-tomas.novotny@tbs-biometrics.com>
        <1476812589-18333-5-git-send-email-tomas.novotny@tbs-biometrics.com>
        <2a820b1f-b6d7-88f9-7403-06a1c5e3b2ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, 22 Oct 2016 19:18:06 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On 18/10/16 18:43, Tomas Novotny wrote:
> > From: Tomas Novotny <tomas@novotny.cz>
> > 
> > MCP47x6 chip supports selection of a voltage reference (VDD, VREF buffered
> > or unbuffered). MCP4725 doesn't have this feature thus the eventual setting
> > is ignored and user is warned.
> > 
> > The setting is stored only in the volatile memory of the chip. You need to
> > manually store it to the EEPROM of the chip via 'store_eeprom' sysfs entry.
> > 
> > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> Something odd happened and this patch wouldn't apply without some manual
> intervention.
> 
> Please check the result in the testing branch of iio.git.

It was a whitespace fix. The result is correct.

Thanks for the reviews and for taking this series,

Tomas

> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/dac/mcp4725.c       | 97 ++++++++++++++++++++++++++++++++++++++---
> >  include/linux/iio/dac/mcp4725.h | 11 +++++
> >  2 files changed, 102 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> > index e481f38..83d431f 100644
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
> > +		dev_err(&client->dev,
> > +			"external reference is unavailable on MCP4725");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!pdata->use_vref && pdata->vref_buffered) {
> > +		dev_err(&client->dev,
> > +			"buffering is unavailable on the internal reference");
> > +		return -EINVAL;
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
> > +			err = PTR_ERR(data->vdd_reg);
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
> > @@ -366,23 +434,38 @@ static int mcp4725_probe(struct i2c_client *client,
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
> >  	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
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
> > +
> >  err_disable_vdd_reg:
> >  	regulator_disable(data->vdd_reg);
> >  
> > @@ -396,6 +479,8 @@ static int mcp4725_remove(struct i2c_client *client)
> >  
> >  	iio_device_unregister(indio_dev);
> >  
> > +	if (data->vref_reg)
> > +		regulator_disable(data->vref_reg);
> >  	regulator_disable(data->vdd_reg);
> >  
> >  	return 0;
> > diff --git a/include/linux/iio/dac/mcp4725.h b/include/linux/iio/dac/mcp4725.h
> > index 7c062e8..628b2cf 100644
> > --- a/include/linux/iio/dac/mcp4725.h
> > +++ b/include/linux/iio/dac/mcp4725.h
> > @@ -9,7 +9,18 @@
> >  #ifndef IIO_DAC_MCP4725_H_
> >  #define IIO_DAC_MCP4725_H_
> >  
> > +/**
> > + * struct mcp4725_platform_data - MCP4725/6 DAC specific data.
> > + * @use_vref: Whether an external reference voltage on Vref pin should be used.
> > + *            Additional vref-supply must be specified when used.
> > + * @vref_buffered: Controls buffering of the external reference voltage.
> > + *
> > + * Vref related settings are available only on MCP4756. See
> > + * Documentation/devicetree/bindings/iio/dac/mcp4725.txt for more information.
> > + */
> >  struct mcp4725_platform_data {
> > +	bool use_vref;
> > +	bool vref_buffered;
> >  };
> >  
> >  #endif /* IIO_DAC_MCP4725_H_ */
> > 
> 

