Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <5390A412.8070401@linux.intel.com>
Date: Thu, 05 Jun 2014 10:08:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH] iio: Fix endianness issue in ak8975_read_axis()
References: <1401958410-21183-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401958410-21183-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/05/2014 01:53 AM, Peter Meerwald wrote:
> i2c_smbus_read_word_data() does host endian conversion already,
> no need for le16_to_cpu()
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>   drivers/iio/magnetometer/ak8975.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 09ea5c4..ea08313 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -373,8 +373,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>   {
>   	struct ak8975_data *data = iio_priv(indio_dev);
>   	struct i2c_client *client = data->client;
> -	u16 meas_reg;
> -	s16 raw;
>   	int ret;
>
>   	mutex_lock(&data->lock);
> @@ -422,16 +420,11 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>   		dev_err(&client->dev, "Read axis data fails\n");
>   		goto exit;
>   	}
> -	meas_reg = ret;
>
>   	mutex_unlock(&data->lock);
>
> -	/* Endian conversion of the measured values. */
> -	raw = (s16) (le16_to_cpu(meas_reg));
> -
>   	/* Clamp to valid range. */
> -	raw = clamp_t(s16, raw, -4096, 4095);
> -	*val = raw;
> +	*val = clamp_t(s16, ret, -4096, 4095);
>   	return IIO_VAL_INT;
>
>   exit:
>
I did some experiments on little-endian platforms,  so your change
won't hurt on x86.

Read as word data -> Reg 3 (LB) and Reg 4(HB)
[ 1529.699617] Word read reg->3:ffc8

Read as byte separately LB and HB
[ 1529.711619] Byte read reg->3:c8 reg->4:ff

x86 platform is le, so no change in output by call to le16_to_cpu

[ 1529.711634] Raw value final ffffffc8



Don't we need to convert for big-endian platforms?

When I trace the path for i2c, I don't see any host order
conversion.

Path:
i2c_smbus_read_word_data->i2c_smbus_xfer->i2c_smbus_xfer_emulated

i2c_smbus_xfer_emulated
{

(for designware) bus

// Send command part
adap->algo->master_xfer->i2c_dw_xfer_msg ->

// Rx data
via i2c_dw_read, don't see any host order conversion
\
{
order word according to SMBUS specification, low byte on the bus first
	case I2C_SMBUS_WORD_DATA:
		case I2C_SMBUS_PROC_CALL:
			data->word = msgbuf1[0] | (msgbuf1[1] << 8);
			break;
}
	But there is no host order conversion?

}


Thanks,
Srinivas
