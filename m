Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38730 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab2I2KJG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Sep 2012 06:09:06 -0400
Message-ID: <5066C8BE.6010302@kernel.org>
Date: Sat, 29 Sep 2012 11:09:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Senna Tschudin <peter.senna@gmail.com>
CC: trivial@kernel.org, gregkh@linuxfoundation.org, lars@metafoo.de,
	michael.hennerich@analog.com, w.sang@pengutronix.de, marex@denx.de,
	sfr@canb.auug.org.au, pmeerw@pmeerw.net, shubhrajyoti@ti.com,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drivers/staging/iio: Remove unnecessary semicolon
References: <1348826227-32567-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1348826227-32567-1-git-send-email-peter.senna@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/2012 10:57 AM, Peter Senna Tschudin wrote:
> A simplified version of the semantic patch that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r1@
> statement S;
> position p,p1;
> @@
> S@p1;@p
> 
> @script:python r2@
> p << r1.p;
> p1 << r1.p1;
> @@
> if p[0].line != p1[0].line_end:
>         cocci.include_match(False)
> @@
> position r1.p;
> @@
> -;@p
> // </smpl>
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

Merged to togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Will hit next cycle now.

> ---
> Changes from v1:
> Include semantic patch in the commit message.
> 
> The full version of the semantic patch can be found at:
> http://comments.gmane.org/gmane.comp.version-control.coccinelle/2724
> 
>  drivers/staging/iio/accel/adis16201_core.c |  4 ++--
>  drivers/staging/iio/accel/adis16204_core.c |  2 +-
>  drivers/staging/iio/accel/adis16209_core.c |  4 ++--
>  drivers/staging/iio/accel/kxsd9.c          |  2 +-
>  drivers/staging/iio/adc/mxs-lradc.c        |  2 +-
>  drivers/staging/iio/cdc/ad7150.c           | 12 ++++++------
>  drivers/staging/iio/cdc/ad7152.c           |  2 +-
>  drivers/staging/iio/cdc/ad7746.c           |  2 +-
>  drivers/staging/iio/gyro/adis16260_core.c  |  4 ++--
>  drivers/staging/iio/magnetometer/hmc5843.c |  2 +-
>  10 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
> index 8e37d6e..5d2ae5d 100644
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ b/drivers/staging/iio/accel/adis16201_core.c
> @@ -345,7 +345,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		mutex_lock(&indio_dev->mlock);
>  		addr = adis16201_addresses[chan->address][1];
>  		ret = adis16201_spi_read_reg_16(indio_dev, addr, &val16);
> @@ -382,7 +382,7 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		val16 = val & ((1 << bits) - 1);
>  		addr = adis16201_addresses[chan->address][1];
>  		return adis16201_spi_write_reg_16(indio_dev, addr, val16);
> diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
> index 05bdb7c..c6bf641 100644
> --- a/drivers/staging/iio/accel/adis16204_core.c
> +++ b/drivers/staging/iio/accel/adis16204_core.c
> @@ -389,7 +389,7 @@ static int adis16204_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		val16 = val & ((1 << bits) - 1);
>  		addr = adis16204_addresses[chan->address][1];
>  		return adis16204_spi_write_reg_16(indio_dev, addr, val16);
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index b7333bf..4f70efd 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -295,7 +295,7 @@ static int adis16209_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		val16 = val & ((1 << bits) - 1);
>  		addr = adis16209_addresses[chan->address][1];
>  		return adis16209_spi_write_reg_16(indio_dev, addr, val16);
> @@ -373,7 +373,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		mutex_lock(&indio_dev->mlock);
>  		addr = adis16209_addresses[chan->address][1];
>  		ret = adis16209_spi_read_reg_16(indio_dev, addr, &val16);
> diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
> index fdd5fbd..e8e6e3f 100644
> --- a/drivers/staging/iio/accel/kxsd9.c
> +++ b/drivers/staging/iio/accel/kxsd9.c
> @@ -171,7 +171,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
> -	};
> +	}
>  
>  error_ret:
>  	return ret;
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index ca7c1fa..df5bba2 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -351,7 +351,7 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
>  		writel(chan_value, lradc->base + LRADC_CH(ofs));
>  		enable |= 1 << ofs;
>  		ofs++;
> -	};
> +	}
>  
>  	writel(LRADC_DELAY_TRIGGER_LRADCS_MASK | LRADC_DELAY_KICK,
>  		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_CLR);
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 6a40414..c72a6c0 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -156,7 +156,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev, u64 event_code)
>  			return !adaptive && (threshtype == 0x1);
>  		else
>  			return !adaptive && (threshtype == 0x0);
> -	};
> +	}
>  	return -EINVAL;
>  }
>  
> @@ -194,7 +194,7 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev, u64 event_code)
>  		break;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
>  	ret = i2c_smbus_write_byte_data(chip->client,
>  					ad7150_addresses[chan][4],
>  					sens);
> @@ -257,7 +257,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
>  	default:
>  		ret = -EINVAL;
>  		goto error_ret;
> -	};
> +	}
>  
>  	cfg |= (!adaptive << 7) | (thresh_type << 5);
>  
> @@ -327,7 +327,7 @@ static int ad7150_write_event_value(struct iio_dev *indio_dev,
>  	default:
>  		ret = -EINVAL;
>  		goto error_ret;
> -	};
> +	}
>  
>  	/* write back if active */
>  	ret = ad7150_write_event_params(indio_dev, event_code);
> @@ -360,7 +360,7 @@ static ssize_t ad7150_show_timeout(struct device *dev,
>  		break;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
>  
>  	return sprintf(buf, "%d\n", value);
>  }
> @@ -394,7 +394,7 @@ static ssize_t ad7150_store_timeout(struct device *dev,
>  	default:
>  		ret = -EINVAL;
>  		goto error_ret;
> -	};
> +	}
>  
>  	ret = ad7150_write_event_params(indio_dev, this_attr->address);
>  error_ret:
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index 98c3015..288b33e 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -405,7 +405,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	default:
>  		ret = -EINVAL;
> -	};
> +	}
>  out:
>  	mutex_unlock(&indio_dev->mlock);
>  	return ret;
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 754e11e..e6c11d9 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -677,7 +677,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	default:
>  		ret = -EINVAL;
> -	};
> +	}
>  out:
>  	mutex_unlock(&indio_dev->mlock);
>  	return ret;
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 9571c03..ff16430 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -528,7 +528,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		mutex_lock(&indio_dev->mlock);
>  		addr = adis16260_addresses[chan->address][1];
>  		ret = adis16260_spi_read_reg_16(indio_dev, addr, &val16);
> @@ -548,7 +548,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		mutex_lock(&indio_dev->mlock);
>  		addr = adis16260_addresses[chan->address][2];
>  		ret = adis16260_spi_read_reg_16(indio_dev, addr, &val16);
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 10e0954..f7edf69 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -555,7 +555,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
>  		*val = 0;
>  		*val2 = data->variant->regval_to_nanoscale[data->range];
>  		return IIO_VAL_INT_PLUS_NANO;
> -	};
> +	}
>  	return -EINVAL;
>  }
>  
> 
