Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53833 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964798AbcJVRpS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:45:18 -0400
Subject: Re: [PATCH v2] staging: iio: cdc: ad7746: add additional config
 defines
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <1476886753-9739-1-git-send-email-eraretuya@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d20a6894-2a56-d8ac-dcdb-f662ea2c5879@kernel.org>
Date: Sat, 22 Oct 2016 18:45:15 +0100
MIME-Version: 1.0
In-Reply-To: <1476886753-9739-1-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 15:19, Eva Rachel Retuya wrote:
> Introduce defines for shifting and mask under the config register for
> better readability.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Worth sanity checking the resulting values when using macros (and reading
the docs closely!)
> ---
> Changes in v2:
> * Use GENMASK to generate both VTFS and CAPFS masks including offset,
>   respectively.
> * Introduce helper variables for index calculation.
> 
>  drivers/staging/iio/cdc/ad7746.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index f41251c..5e9ceeb 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -70,8 +70,12 @@
>  #define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
>  
>  /* Config Register Bit Designations (AD7746_REG_CFG) */
> -#define AD7746_CONF_VTFS(x)		((x) << 6)
> -#define AD7746_CONF_CAPFS(x)		((x) << 3)
> +#define AD7746_CONF_VTFS_SHIFT		6
> +#define AD7746_CONF_CAPFS_SHIFT		3
> +#define AD7746_CONF_VTFS_MASK(x)	GENMASK(1, x)
> +#define AD7746_CONF_CAPFS_MASK(x)	GENMASK(2, x)
These are only safe if x <= 1, 2


> +#define AD7746_CONF_VTFS(x)		((x) << AD7746_CONF_VTFS_SHIFT)
> +#define AD7746_CONF_CAPFS(x)		((x) << AD7746_CONF_CAPFS_SHIFT)
>  #define AD7746_CONF_MODE_IDLE		(0 << 0)
>  #define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
>  #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
> @@ -217,15 +221,16 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan)
>  {
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> -	int ret, delay;
> +	int ret, delay, idx;
>  	u8 vt_setup, cap_setup;
>  
>  	switch (chan->type) {
>  	case IIO_CAPACITANCE:
>  		cap_setup = (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
>  		vt_setup = chip->vt_setup & ~AD7746_VTSETUP_VTEN;
> -		delay = ad7746_cap_filter_rate_table[(chip->config >> 3) &
> -			0x7][1];
> +		idx = (chip->config >> AD7746_CONF_CAPFS_SHIFT) &
> +			AD7746_CONF_CAPFS_MASK(0);
> +		delay = ad7746_cap_filter_rate_table[idx][1];
>  
>  		if (chip->capdac_set != chan->channel) {
>  			ret = i2c_smbus_write_byte_data(chip->client,
> @@ -246,8 +251,9 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  	case IIO_TEMP:
>  		vt_setup = (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
>  		cap_setup = chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
> -		delay = ad7746_cap_filter_rate_table[(chip->config >> 6) &
> -			0x3][1];
> +		idx = (chip->config >> AD7746_CONF_VTFS_SHIFT) &
> +			AD7746_CONF_VTFS_MASK(0);
> +		delay = ad7746_cap_filter_rate_table[idx][1];
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -369,7 +375,7 @@ static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
>  	if (i >= ARRAY_SIZE(ad7746_cap_filter_rate_table))
>  		i = ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
>  
> -	chip->config &= ~AD7746_CONF_CAPFS(0x7);
> +	chip->config &= ~AD7746_CONF_CAPFS_MASK(AD7746_CONF_CAPFS_SHIFT);
>  	chip->config |= AD7746_CONF_CAPFS(i);
>  
>  	return 0;
> @@ -387,7 +393,7 @@ static int ad7746_store_vt_filter_rate_setup(struct ad7746_chip_info *chip,
>  	if (i >= ARRAY_SIZE(ad7746_vt_filter_rate_table))
>  		i = ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
>  
> -	chip->config &= ~AD7746_CONF_VTFS(0x3);
> +	chip->config &= ~AD7746_CONF_VTFS_MASK(AD7746_CONF_VTFS_SHIFT);
This evaulates (I think) to GENMASK(1, 6);
Now this is gibberish (mask from bit 1 downto 6...)
To satisfy curiousity the implementation is:
GENMASK(h, l)
(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))

so we have something like (0xFFFFFFFF << 6) & (0xFFFFFFFF >> (32 - 1 - 1))
0xFFFFFFC0 & ( 0x00000003) = 0.  Not good.


>  	chip->config |= AD7746_CONF_VTFS(i);
>  
>  	return 0;
> @@ -527,7 +533,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  			   long mask)
>  {
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> -	int ret, delay;
> +	int ret, delay, idx;
>  	u8 regval, reg;
>  
>  	mutex_lock(&indio_dev->mlock);
> @@ -635,13 +641,15 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		switch (chan->type) {
>  		case IIO_CAPACITANCE:
> -			*val = ad7746_cap_filter_rate_table[
> -					(chip->config >> 3) & 0x7][0];
> +			idx = (chip->config >> AD7746_CONF_CAPFS_SHIFT) &
> +				AD7746_CONF_CAPFS_MASK(0);
> +			*val = ad7746_cap_filter_rate_table[idx][0];
>  			ret = IIO_VAL_INT;
>  			break;
>  		case IIO_VOLTAGE:
> -			*val = ad7746_vt_filter_rate_table[
> -					(chip->config >> 6) & 0x3][0];
> +			idx = (chip->config >> AD7746_CONF_VTFS_SHIFT) &
> +				AD7746_CONF_VTFS_MASK(0);
> +			*val = ad7746_vt_filter_rate_table[idx][0];
>  			break;
>  		default:
>  			ret = -EINVAL;
> 

