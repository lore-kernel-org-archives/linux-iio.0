Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38985 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbcDGB5i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 21:57:38 -0400
Message-ID: <5705BA51.4040808@denx.de>
Date: Thu, 07 Apr 2016 03:39:29 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH V2] iio: pressure: hp03: Add Hope RF HP03 sensor support
References: <1459899644-8757-1-git-send-email-marex@denx.de> <alpine.DEB.2.02.1604060153550.1352@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1604060153550.1352@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/06/2016 08:04 AM, Peter Meerwald-Stadler wrote:
>> Add support for HopeRF pressure and temperature sensor.
> 
> some minor comments

Thanks

[...]

>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/pressure/hp03.txt
>> @@ -0,0 +1,17 @@
>> +HopeRF HP03 digital pressure/temperature sensors
>> +
>> +Required properties:
>> +- compatible: must be "hoperf,hp03"
>> +- xclr-gpio:  must be device tree identifier of the XCLR pin .
> 
> remove space before . 
> indentation seems wrong

OK, fixed now.

>> +              The XCLR pin is a reset of the ADC in the chip,
>> +	      it must be pulled HI before the conversion and
>> +	      readout of the value from the ADC registers and
>> +	      pulled LO afterward.
>> +
>> +Example:

[...]

>> +static int hp03_read_raw(struct iio_dev *indio_dev,
>> +			 struct iio_chan_spec const *chan,
>> +			 int *val, int *val2, long mask)
>> +{
>> +	struct hp03_priv *priv = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	mutex_lock(&priv->lock);
>> +	ret = hp03_update_temp_pressure(priv);
>> +	mutex_unlock(&priv->lock);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		switch (chan->type) {
>> +		case IIO_PRESSURE:
>> +			*val = priv->pressure / 100;
>> +			*val2 = (priv->pressure % 100) * 10000;
>> +			ret = IIO_VAL_INT_PLUS_MICRO;
> 
> maybe return directly, here and below

Good point. Looking at the code, I think I will also need to change the
code like the snippet below. The priv->pressure is in 1Pa steps, the
priv->temp is in 0.01C steps. Does it make sense or am I confused ?


        switch (mask) {
        case IIO_CHAN_INFO_RAW:
                switch (chan->type) {
                case IIO_PRESSURE:
                        *val = priv->pressure;
                        return IIO_VAL_INT;
                case IIO_TEMP:
                        *val = priv->temp;
                        return IIO_VAL_INT;
                default:
                        return -EINVAL;
                }
                break;
        case IIO_CHAN_INFO_SCALE:
                switch (chan->type) {
                case IIO_PRESSURE:
                        *val = 1;
                        return IIO_VAL_INT;
                case IIO_TEMP:
                        *val = 0;
                        *val2 = 10000;
                        return IIO_VAL_INT_PLUS_MICRO;
                default:
                        return -EINVAL;
                }
                break;
        default:
                return -EINVAL;
        }

>> +			break;
>> +		case IIO_TEMP:
>> +			*val = priv->temp / 100;
>> +			*val2 = (priv->temp % 100) * 10000;
>> +			ret = IIO_VAL_INT_PLUS_MICRO;
>> +			break;
>> +		default:
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +		break;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_PRESSURE:
>> +		case IIO_TEMP:
>> +			*val = 0;
>> +			*val2 = 10000;
>> +			ret = IIO_VAL_INT_PLUS_MICRO;
>> +			break;
>> +		default:
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +		break;
>> +
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}

[...]

Best regards,
Marek Vasut
