Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753272AbeDUQlx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:41:53 -0400
Date: Sat, 21 Apr 2018 17:41:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: potentiostat: lmp91000: remove lookup table for
 temperature values
Message-ID: <20180421174148.008e587a@archlinux>
In-Reply-To: <20180421064730.11358-1-matt.ranostay@konsulko.com>
References: <20180421064730.11358-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 23:47:30 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Lookup table was highly dependent on using the LMP91000EVM which had an
> 16-bit TI ADC161S626 but it is mistake to assume all applications will
> be using that ADC part. Any processing should be done in the respective
> userspace application.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Hohum.  The problem here is that now, any users that are out there will
have code based on the conversion done in this table.

It should at least be linear (I think) off the back of this table?
If so we should probably have reported it as raw (as there is an unknown
scale still to apply) but the table is otherwise valid (I think!)

Jonathan

> ---
>  drivers/iio/potentiostat/lmp91000.c | 38 ++++---------------------------------
>  1 file changed, 4 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 85714055cc74..e464f72b144b 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -41,21 +41,6 @@ static const int lmp91000_rload[] = { 10, 33, 50, 100 };
>  
>  #define LMP91000_TEMP_BASE	-40
>  
> -static const u16 lmp91000_temp_lut[] = {
> -	1875, 1867, 1860, 1852, 1844, 1836, 1828, 1821, 1813, 1805,
> -	1797, 1789, 1782, 1774, 1766, 1758, 1750, 1742, 1734, 1727,
> -	1719, 1711, 1703, 1695, 1687, 1679, 1671, 1663, 1656, 1648,
> -	1640, 1632, 1624, 1616, 1608, 1600, 1592, 1584, 1576, 1568,
> -	1560, 1552, 1544, 1536, 1528, 1520, 1512, 1504, 1496, 1488,
> -	1480, 1472, 1464, 1456, 1448, 1440, 1432, 1424, 1415, 1407,
> -	1399, 1391, 1383, 1375, 1367, 1359, 1351, 1342, 1334, 1326,
> -	1318, 1310, 1302, 1293, 1285, 1277, 1269, 1261, 1253, 1244,
> -	1236, 1228, 1220, 1212, 1203, 1195, 1187, 1179, 1170, 1162,
> -	1154, 1146, 1137, 1129, 1121, 1112, 1104, 1096, 1087, 1079,
> -	1071, 1063, 1054, 1046, 1038, 1029, 1021, 1012, 1004,  996,
> -	 987,  979,  971,  962,  954,  945,  937,  929,  920,  912,
> -	 903,  895,  886,  878,  870,  861 };
> -
>  static const struct regmap_config lmp91000_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -95,7 +80,7 @@ static const struct iio_chan_spec lmp91000_channels[] = {
>  		.type = IIO_TEMP,
>  		.channel = 1,
>  		.address = LMP91000_REG_MODECN_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.scan_index = -1,
>  	},
>  };
> @@ -157,11 +142,11 @@ static int lmp91000_read_raw(struct iio_dev *indio_dev,
>  			     int *val, int *val2, long mask)
>  {
>  	struct lmp91000_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -	case IIO_CHAN_INFO_PROCESSED: {
> -		int ret = iio_channel_start_all_cb(data->cb_buffer);
> +		ret = iio_channel_start_all_cb(data->cb_buffer);
>  
>  		if (ret)
>  			return ret;
> @@ -173,29 +158,14 @@ static int lmp91000_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		if (mask == IIO_CHAN_INFO_PROCESSED) {
> -			int tmp, i;
> -
> -			ret = iio_convert_raw_to_processed(data->adc_chan,
> -							   *val, &tmp, 1);
> -			if (ret)
> -				return ret;
> -
> -			for (i = 0; i < ARRAY_SIZE(lmp91000_temp_lut); i++)
> -				if (lmp91000_temp_lut[i] < tmp)
> -					break;
> -
> -			*val = (LMP91000_TEMP_BASE + i) * 1000;
> -		}
>  		return IIO_VAL_INT;
> -	}
>  	case IIO_CHAN_INFO_OFFSET:
>  		return iio_read_channel_offset(data->adc_chan, val, val2);
>  	case IIO_CHAN_INFO_SCALE:
>  		return iio_read_channel_scale(data->adc_chan, val, val2);
>  	}
>  
> -	return -EINVAL;
> +	return ret;
>  }
>  
>  static const struct iio_info lmp91000_info = {

