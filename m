Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-075.synserver.de ([212.40.185.75]:1028 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751609AbaAJJII (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jan 2014 04:08:08 -0500
Message-ID: <52CFB88F.20905@metafoo.de>
Date: Fri, 10 Jan 2014 10:08:31 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add si7005 relative humidity and temperature sensor
 driver
References: <1389215837-24060-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389215837-24060-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/08/2014 10:17 PM, Peter Meerwald wrote:
> sensor provides 12-bit relative humidity and 14-bit temperature
> via I2C interface; temperature and linearity compensation is not
> implemented (yet)
> 
> driver also supports the Si7015, but not the 2nd generation
> sensors Si7013/Si7020/Si7021
> 
> datasheet is here
> http://www.silabs.com/Support%20Documents/TechnicalDocs/Si7005.pdf
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

One nitpick:


> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 7; *val2 = 812500;

I can understand why you'd put this on one line, but its a bit confusing
this way when you read the code since two statements on one line is
unexpected. To quote CodingStyle: "Don't put multiple statements on a single
line unless you have something to hide".

> +		} else {
> +			*val = 3; *val2 = 906250;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;

> +static int si7005_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
[...]
> +	return iio_device_register(indio_dev);

Sachin will probably send a patch changing this to devm_iio_device_register ;)


