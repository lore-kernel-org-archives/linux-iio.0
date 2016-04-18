Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58510 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbcDRN20 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 09:28:26 -0400
Message-ID: <5714E07B.4090902@denx.de>
Date: Mon, 18 Apr 2016 15:26:19 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: Matt Ranostay <mranostay@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH V3] iio: pressure: hp03: Add Hope RF HP03 sensor support
References: <1460321544-8619-1-git-send-email-marex@denx.de> <57129538.6010300@kernel.org>
In-Reply-To: <57129538.6010300@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/16/2016 09:40 PM, Jonathan Cameron wrote:
> On 10/04/16 21:52, Marek Vasut wrote:
>> Add support for HopeRF pressure and temperature sensor.
>>
>> This device uses two fixed I2C addresses, one for storing
>> calibration coefficients and another for accessing the ADC.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Matt Ranostay <mranostay@gmail.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
> Sorry I didn't get to this earlier in the week.
> 
> Unfortunately the resulting scales don't match the standard ABI for these
> two channel types.

Ah, sorry for the inconvenience.

> Otherwise, looks good. I've cc'd the devicetree list and maintainers.
> The binding is trivial I think, but always good to give people a
> opportunity to comment.
> 
> Jonathan
>> ---
>> V2: - Expand the binding document with more details on the XCLR pin
>>     - Switch from IIO_CHAN_INFO_PROCESSED to RAW + SCALE
>>     - Add failpath into hp03_update_temp_pressure() for the case
>>       when ADC readout fails. This correctly sets the XCLR pin back
>>       to LO now.
>>     - Add comment explaining the need for allocation of child device
>>       in hp03_probe().
>> V3: - Fix indent in the DT binding documentation
>>     - Report raw pressure and temperature unmodified
> Good
>>     - Report pressure scale to be 1 , since pressure is in Pa
> Standard units for pressure (see Documentation/ABI/testing/sysfs-bus-iio
> are KPa so it wants to report 0.001)

OK, got it.

>>     - Report temperature scale to be 0.01 , since temp is in 0.01C steps
> Unfortunately the documented base unit for temp (originally from hwmon before
> we started going for SI units every time) are milli Celcius.  Thus the value
> reported * scale should end up in milli degrees Celcius. Hence if it is in 0.01
> steps the scale should be 0.1

Shouldn't this be 10 ? The value is in 0.01C steps , so the value has to
be multiplied by 10 to convert it into mC units.

>> ---
>>  .../devicetree/bindings/iio/pressure/hp03.txt      |  17 ++
>>  drivers/iio/pressure/Kconfig                       |  11 +
>>  drivers/iio/pressure/Makefile                      |   1 +
>>  drivers/iio/pressure/hp03.c                        | 307 +++++++++++++++++++++
>>  4 files changed, 336 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/hp03.txt
>>  create mode 100644 drivers/iio/pressure/hp03.c


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
>> +			*val = priv->pressure;
>> +			return IIO_VAL_INT;
>> +		case IIO_TEMP:
>> +			*val = priv->temp;
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_PRESSURE:
>> +			*val = 1;
>> +			return IIO_VAL_INT;
> *val = 0, *val2 = 1000;
> return IIO_VAL_INT_PLUS_MICRO;
>> +		case IIO_TEMP:
>> +			*val = 0;
>> +			*val2 = 10000;
> Val2 should I think be 100000 giving scale * lsb of 0.001 degrees.

I think this should be:

val = 10;
return IIO_VAL_INT;

Since the temp value is in 10mC steps.

>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return -EINVAL;
>> +}

[...]

Best regards,
Marek Vasut
