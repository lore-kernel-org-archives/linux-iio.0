Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35261 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdAUOls (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:41:48 -0500
Subject: Re: [PATCH v2 04/15] staging: iio: isl29028: change newlines to
 improve readability
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-5-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ccbf4640-966b-fe66-f690-342629ae272b@kernel.org>
Date: Sat, 21 Jan 2017 14:41:46 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-5-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> Add and remove newlines to improve code readability in preparation for
> moving the driver out of staging.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/isl29028.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index a13c8db..d05d761 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -69,10 +69,8 @@ enum isl29028_als_ir_mode {
>  struct isl29028_chip {
>  	struct mutex			lock;
>  	struct regmap			*regmap;
> -
>  	unsigned int			prox_sampling;
>  	bool				enable_prox;
> -
>  	int				lux_scale;
>  	enum isl29028_als_ir_mode	als_ir_mode;
>  };
> @@ -88,6 +86,7 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
>  		if (period >= prox_period[sel])
>  			break;
>  	}
> +
>  	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
>  				  ISL29028_CONF_PROX_SLP_MASK,
>  				  sel << ISL29028_CONF_PROX_SLP_SH);
> @@ -107,6 +106,7 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
>  
>  	/* Wait for conversion to be complete for first sample */
>  	mdelay(DIV_ROUND_UP(1000, chip->prox_sampling));
> +
>  	return 0;
>  }
>  
> @@ -139,13 +139,11 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
>  					 ISL29028_CONF_ALS_RANGE_MASK,
>  					 ISL29028_CONF_ALS_RANGE_HIGH_LUX);
>  		break;
> -
>  	case ISL29028_MODE_IR:
>  		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
>  					 ISL29028_CONF_ALS_IR_MODE_MASK,
>  					 ISL29028_CONF_ALS_IR_MODE_IR);
>  		break;
> -
>  	case ISL29028_MODE_NONE:
>  		return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
>  					  ISL29028_CONF_ALS_EN_MASK,
> @@ -192,6 +190,7 @@ static int isl29028_read_als_ir(struct isl29028_chip *chip, int *als_ir)
>  	}
>  
>  	*als_ir = ((msb & 0xF) << 8) | (lsb & 0xFF);
> +
>  	return 0;
>  }
>  
> @@ -205,6 +204,7 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
>  		ret = isl29028_enable_proximity(chip, true);
>  		if (ret < 0)
>  			return ret;
> +
>  		chip->enable_prox = true;
>  	}
>  
> @@ -214,7 +214,9 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
>  			ISL29028_REG_PROX_DATA, ret);
>  		return ret;
>  	}
> +
>  	*prox = data;
> +
>  	return 0;
>  }
>  
> @@ -245,6 +247,7 @@ static int isl29028_als_get(struct isl29028_chip *chip, int *als_data)
>  		als_ir_data = (als_ir_data * 49) / 100;
>  
>  	*als_data = als_ir_data;
> +
>  	return 0;
>  }
>  
> @@ -258,6 +261,7 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
>  		dev_err(dev, "Error in enabling IR mode err %d\n", ret);
>  		return ret;
>  	}
> +
>  	return isl29028_read_als_ir(chip, ir_data);
>  }
>  
> @@ -279,11 +283,13 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  				mask);
>  			break;
>  		}
> +
>  		if (val < 1 || val > 100) {
>  			dev_err(dev,
>  				"Samp_freq %d is not in range[1:100]\n", val);
>  			break;
>  		}
> +
>  		ret = isl29028_set_proxim_sampling(chip, val);
>  		if (ret < 0) {
>  			dev_err(dev,
> @@ -291,9 +297,9 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  				ret);
>  			break;
>  		}
> +
>  		chip->prox_sampling = val;
>  		break;
> -
>  	case IIO_LIGHT:
>  		if (mask != IIO_CHAN_INFO_SCALE) {
>  			dev_err(dev,
> @@ -301,25 +307,29 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  				mask);
>  			break;
>  		}
> +
>  		if ((val != 125) && (val != 2000)) {
>  			dev_err(dev,
>  				"lux scale %d is invalid [125, 2000]\n", val);
>  			break;
>  		}
> +
>  		ret = isl29028_set_als_scale(chip, val);
>  		if (ret < 0) {
>  			dev_err(dev,
>  				"Setting lux scale fail with error %d\n", ret);
>  			break;
>  		}
> +
>  		chip->lux_scale = val;
>  		break;
> -
>  	default:
>  		dev_err(dev, "Unsupported channel type\n");
>  		break;
>  	}
> +
>  	mutex_unlock(&chip->lock);
> +
>  	return ret;
>  }
>  
> @@ -348,30 +358,32 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			break;
>  		}
> +
>  		if (ret < 0)
>  			break;
> +
>  		ret = IIO_VAL_INT;
>  		break;
> -
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (chan->type != IIO_PROXIMITY)
>  			break;
> +
>  		*val = chip->prox_sampling;
>  		ret = IIO_VAL_INT;
>  		break;
> -
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type != IIO_LIGHT)
>  			break;
>  		*val = chip->lux_scale;
>  		ret = IIO_VAL_INT;
>  		break;
> -
>  	default:
>  		dev_err(dev, "mask value 0x%08lx not supported\n", mask);
>  		break;
>  	}
> +
>  	mutex_unlock(&chip->lock);
> +
>  	return ret;
>  }
>  
> @@ -497,6 +509,7 @@ static int isl29028_probe(struct i2c_client *client,
>  			ISL29028_REG_TEST1_MODE, ret);
>  		return ret;
>  	}
> +
>  	ret = regmap_write(chip->regmap, ISL29028_REG_TEST2_MODE, 0x0);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
> @@ -517,6 +530,7 @@ static int isl29028_probe(struct i2c_client *client,
>  	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +
>  	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
> @@ -524,6 +538,7 @@ static int isl29028_probe(struct i2c_client *client,
>  			ret);
>  		return ret;
>  	}
> +
>  	return 0;
>  }
>  
> 

