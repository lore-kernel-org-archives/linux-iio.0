Return-Path: <knaack.h@gmx.de>
Message-ID: <553020A5.8010307@gmx.de>
Date: Thu, 16 Apr 2015 22:50:45 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/9] iio: mma8452: Add access to registers via DebugFS
References: <20150219141553.27001.18825.stgit@localhost> <20150219141558.27001.74884.stgit@localhost>
In-Reply-To: <20150219141558.27001.74884.stgit@localhost>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Martin Fuzzey schrieb am 19.02.2015 um 15:15:
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
A few comments inline.

> ---
>  drivers/iio/accel/mma8452.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 04a4f34..c46df4e 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -34,6 +34,8 @@
>  #define MMA8452_CTRL_REG2 0x2b
>  #define MMA8452_CTRL_REG2_RST		BIT(6)
>  
> +#define MMA8452_MAX_REG 0x31
> +
>  #define MMA8452_STATUS_DRDY (BIT(2) | BIT(1) | BIT(0))
>  
>  #define MMA8452_CTRL_DR_MASK (BIT(5) | BIT(4) | BIT(3))
> @@ -292,6 +294,28 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> +static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
> +			      unsigned reg, unsigned writeval,
> +			      unsigned *readval)
As before, parameters should be aligned with open parenthesis.

> +{
> +	int ret;
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +
> +	if (reg > MMA8452_MAX_REG)
> +		return -EINVAL;
> +
> +	if (readval == NULL) {
> +		ret = mma8452_change_config(data, reg, writeval);
You could return straight here without using ret.

> +	} else {
> +		ret = i2c_smbus_read_byte_data(data->client, reg);
> +		if (ret < 0)
> +			return ret;
> +		*readval = ret;
> +		ret = 0;
Same here.

> +	}
> +	return ret;
> +}
> +
>  #define MMA8452_CHANNEL(axis, idx) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -331,6 +355,7 @@ static const struct iio_info mma8452_info = {
>  	.attrs = &mma8452_group,
>  	.read_raw = &mma8452_read_raw,
>  	.write_raw = &mma8452_write_raw,
> +	.debugfs_reg_access = &mma8452_reg_access_dbg,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
