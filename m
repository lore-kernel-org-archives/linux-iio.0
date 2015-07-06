Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49934 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbbGFJFi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2015 05:05:38 -0400
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH 2/5] iio:light:stk3310: make endianness independent of
 host
Date: Mon, 6 Jul 2015 09:05:34 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F402216C862@IRSMSX109.ger.corp.intel.com>
References: <cover.1436024257.git.knaack.h@gmx.de>
 <c29ff5a7d9a6dc486389171542ebef3737cb253f.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <c29ff5a7d9a6dc486389171542ebef3737cb253f.1436024257.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: Saturday, July 4, 2015 6:57 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
> A
> Subject: [PATCH 2/5] iio:light:stk3310: make endianness independent of host
> 
> Data is stored in the device in be16 format. Make use of be16_to_cpu and
> cpu_to_be16 to have correct endianness on any host architecture.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

+1

Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

> ---
>  drivers/iio/light/stk3310.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c index
> c1a2182..c52c730 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -200,7 +200,7 @@ static int stk3310_read_event(struct iio_dev
> *indio_dev,
>  			      int *val, int *val2)
>  {
>  	u8 reg;
> -	u16 buf;
> +	__be16 buf;
>  	int ret;
>  	struct stk3310_data *data = iio_priv(indio_dev);
> 
> @@ -222,7 +222,7 @@ static int stk3310_read_event(struct iio_dev
> *indio_dev,
>  		dev_err(&data->client->dev, "register read failed\n");
>  		return ret;
>  	}
> -	*val = swab16(buf);
> +	*val = be16_to_cpu(buf);
> 
>  	return IIO_VAL_INT;
>  }
> @@ -235,7 +235,7 @@ static int stk3310_write_event(struct iio_dev
> *indio_dev,
>  			       int val, int val2)
>  {
>  	u8 reg;
> -	u16 buf;
> +	__be16 buf;
>  	int ret;
>  	unsigned int index;
>  	struct stk3310_data *data = iio_priv(indio_dev); @@ -252,7 +252,7
> @@ static int stk3310_write_event(struct iio_dev *indio_dev,
>  	else
>  		return -EINVAL;
> 
> -	buf = swab16(val);
> +	buf = cpu_to_be16(val);
>  	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
>  	if (ret < 0)
>  		dev_err(&client->dev, "failed to set PS threshold!\n"); @@ -
> 301,7 +301,7 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	u8 reg;
> -	u16 buf;
> +	__be16 buf;
>  	int ret;
>  	unsigned int index;
>  	struct stk3310_data *data = iio_priv(indio_dev); @@ -322,7 +322,7
> @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  			mutex_unlock(&data->lock);
>  			return ret;
>  		}
> -		*val = swab16(buf);
> +		*val = be16_to_cpu(buf);
>  		mutex_unlock(&data->lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
> --
> 2.3.6

