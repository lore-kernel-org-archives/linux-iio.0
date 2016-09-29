Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35035 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755308AbcI2TcD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2016 15:32:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id b4so287675wmb.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Sep 2016 12:31:50 -0700 (PDT)
Subject: Re: [PATCH v7] iio: potentiostat: add LMP91000 support
To: Matt Ranostay <mranostay@gmail.com>, jic23@kernel.org
References: <1474776180-21601-1-git-send-email-matt@ranostay.consulting>
Cc: linux-iio@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c266db79-44c4-cf9d-58b0-a62cbe7d61d0@gmail.com>
Date: Thu, 29 Sep 2016 21:31:47 +0200
MIME-Version: 1.0
In-Reply-To: <1474776180-21601-1-git-send-email-matt@ranostay.consulting>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/25/2016 06:03 AM, Matt Ranostay wrote:
> From: Matt Ranostay <mranostay@gmail.com>
> 
> Add support for the LMP91000 potentiostat which is used for chemical
> sensing applications.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>

[...]

> +#define LMP91000_REG_LOCK		0x01
> +#define LMP91000_REG_TIACN		0x10
> +#define LMP91000_REG_TIACN_GAIN_SHIFT	2
> +
> +#define LMP91000_REG_REFCN		0x11
> +#define LMP91000_REG_REFCN_EXT_REF	0x20
> +#define LMP91000_REG_REFCN_50_ZERO	0x80
> +
> +#define LMP91000_REG_MODECN		0x12
> +#define LMP91000_REG_MODECN_3LEAD	0x03
> +#define LMP91000_REG_MODECN_TEMP	0x07
> +
> +#define LMP91000_DRV_NAME	"lmp91000"
> +
> +static const int lmp91000_tia_gain[] = { 0, 2750, 3500, 7000, 14000, 35000,
> +					 120000, 350000 };
> +
> +static const int lmp91000_rload[] = { 10, 33, 50, 100 };

Shouldn't both be static const unsigned int ?

> +#define LMP91000_TEMP_BASE	-40
> +
> +static const u16 lmp91000_temp_lut[] = {

static const u16 const ? :-)

> +	1875, 1867, 1860, 1852, 1844, 1836, 1828, 1821, 1813, 1805,
> +	1797, 1789, 1782, 1774, 1766, 1758, 1750, 1742, 1734, 1727,
> +	1719, 1711, 1703, 1695, 1687, 1679, 1671, 1663, 1656, 1648,
> +	1640, 1632, 1624, 1616, 1608, 1600, 1592, 1584, 1576, 1568,
> +	1560, 1552, 1544, 1536, 1528, 1520, 1512, 1504, 1496, 1488,
> +	1480, 1472, 1464, 1456, 1448, 1440, 1432, 1424, 1415, 1407,
> +	1399, 1391, 1383, 1375, 1367, 1359, 1351, 1342, 1334, 1326,
> +	1318, 1310, 1302, 1293, 1285, 1277, 1269, 1261, 1253, 1244,
> +	1236, 1228, 1220, 1212, 1203, 1195, 1187, 1179, 1170, 1162,
> +	1154, 1146, 1137, 1129, 1121, 1112, 1104, 1096, 1087, 1079,
> +	1071, 1063, 1054, 1046, 1038, 1029, 1021, 1012, 1004,  996,
> +	 987,  979,  971,  962,  954,  945,  937,  929,  920,  912,
> +	 903,  895,  886,  878,  870,  861 };
> +
> +static const struct regmap_config lmp91000_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};

[...]

> +static int lmp91000_read(struct lmp91000_data *data, int channel, int *val)
> +{
> +	int state, ret;
> +
> +	ret = regmap_read(data->regmap, LMP91000_REG_MODECN, &state);

Shouldn't state be u8 ?

> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = regmap_write(data->regmap, LMP91000_REG_MODECN, channel);
> +	if (ret)
> +		return -EINVAL;
> +
> +	/* delay till first temperature reading is complete */
> +	if ((state != channel) && (channel == LMP91000_REG_MODECN_TEMP))
> +		usleep_range(3000, 4000);
> +
> +	data->chan_select = channel != LMP91000_REG_MODECN_3LEAD;
> +
> +	iio_trigger_poll_chained(data->trig);
> +
> +	ret = wait_for_completion_timeout(&data->completion, HZ);
> +	reinit_completion(&data->completion);
> +
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	*val = data->buffer[data->chan_select];
> +
> +	return 0;
> +}

[...]

> +static int lmp91000_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct lmp91000_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED: {
> +		int ret = iio_channel_start_all_cb(data->cb_buffer);
> +
> +		if (ret)
> +			return ret;
> +
> +		ret = lmp91000_read(data, chan->address, val);
> +
> +		iio_channel_stop_all_cb(data->cb_buffer);
> +
> +		if (ret)
> +			return ret;
> +
> +		if (mask == IIO_CHAN_INFO_PROCESSED) {

You can invert the condition here and reduce the indent depth.

> +			int tmp, i;
> +
> +			ret = iio_convert_raw_to_processed(data->adc_chan,
> +							   *val, &tmp, 1);
> +			if (ret)
> +				return ret;
> +
> +			for (i = 0; i < ARRAY_SIZE(lmp91000_temp_lut); i++)
> +				if (lmp91000_temp_lut[i] < tmp)
> +					break;
> +
> +			*val = (LMP91000_TEMP_BASE + i) * 1000;
> +		}
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_OFFSET:
> +		return iio_read_channel_offset(data->adc_chan, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return iio_read_channel_scale(data->adc_chan, val, val2);
> +	}
> +
> +	return -EINVAL;
> +}

[...]


-- 
Best regards,
Marek Vasut
