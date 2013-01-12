Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44995 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab3ALV7U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 16:59:20 -0500
Message-ID: <50F1DCB5.5030003@kernel.org>
Date: Sat, 12 Jan 2013 21:59:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio:common: Add STMicroelectronics common library
References: <1357733221-6248-1-git-send-email-denis.ciocca@st.com> <1357733221-6248-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1357733221-6248-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

...
> +int st_sensors_read_axis_data(struct iio_dev *indio_dev, u8 ch_addr, int *data)
> +{
> +	int err;
> +	u8 outdata[ST_SENSORS_BYTE_FOR_CHANNEL];
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> +			ch_addr, ST_SENSORS_BYTE_FOR_CHANNEL,
> +						outdata, sdata->multiread_bit);
> +	if (err < 0)
> +		goto read_error;
> +

If you want to keep the cast this way around, then make
it __le16 instead of u16.  Personally I'd make outdata a __le16
array and then do the cast the other way, but it is far from important.

> +	*data = ((s16)le16_to_cpup((u16 *)outdata));
> +
> +read_error:
> +	return err;
> +}
> +EXPORT_SYMBOL(st_sensors_read_axis_data);
...
