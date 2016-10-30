Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43260 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbcJ3Rle (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 13:41:34 -0400
Subject: Re: [PATCH v3] staging: iio: cdc: ad7746: add additional config
 defines
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1477643212-7200-1-git-send-email-eraretuya@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f59b10dc-e273-d147-611c-0fca52ee8bc0@kernel.org>
Date: Sun, 30 Oct 2016 17:41:32 +0000
MIME-Version: 1.0
In-Reply-To: <1477643212-7200-1-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/10/16 09:26, Eva Rachel Retuya wrote:
> Introduce defines for shifting and mask under the config register for
> better readability. Also, introduce helper variables for index
> calculation.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Looks good to me.

Lars could you sanity check this one as well?

Thanks,

Jonathan
> ---
> This patch might cause a conflict with this patch:
> staging: iio: cdc/ad7746: fix missing return value
> https://marc.info/?l=linux-driver-devel&m=147741283722806&w=2
> I am waiting to rebase to the branch where this commit is present but
> I was told it was not yet pushed to kernel.org
> 
> Changes in v3:
> * Make commit message more detailed.
> * Fix incorrect use of GENMASK.
> * Drop the AD7746_CONF_*FS(x) macros and use the mask and direct shifting where
>   needed.
> * With the proper masks set, invert the AND'ng and shifting on the index
>   calculations.
> 
> Changes in v2:
> * Use GENMASK to generate both VTFS and CAPFS masks including offset,
>   respectively.
> * Introduce helper variables for index calculation.
> 
>  drivers/staging/iio/cdc/ad7746.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index f41251c..e97658a 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -70,8 +70,10 @@
>  #define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
>  
>  /* Config Register Bit Designations (AD7746_REG_CFG) */
> -#define AD7746_CONF_VTFS(x)		((x) << 6)
> -#define AD7746_CONF_CAPFS(x)		((x) << 3)
> +#define AD7746_CONF_VTFS_SHIFT		6
> +#define AD7746_CONF_CAPFS_SHIFT		3
> +#define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
> +#define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
>  #define AD7746_CONF_MODE_IDLE		(0 << 0)
>  #define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
>  #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
> @@ -217,15 +219,16 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
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
> +		idx = (chip->config & AD7746_CONF_CAPFS_MASK) >>
> +			AD7746_CONF_CAPFS_SHIFT;
> +		delay = ad7746_cap_filter_rate_table[idx][1];
>  
>  		if (chip->capdac_set != chan->channel) {
>  			ret = i2c_smbus_write_byte_data(chip->client,
> @@ -246,8 +249,9 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  	case IIO_TEMP:
>  		vt_setup = (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
>  		cap_setup = chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
> -		delay = ad7746_cap_filter_rate_table[(chip->config >> 6) &
> -			0x3][1];
> +		idx = (chip->config & AD7746_CONF_VTFS_MASK) >>
> +			AD7746_CONF_VTFS_SHIFT;
> +		delay = ad7746_cap_filter_rate_table[idx][1];
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -369,8 +373,8 @@ static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
>  	if (i >= ARRAY_SIZE(ad7746_cap_filter_rate_table))
>  		i = ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
>  
> -	chip->config &= ~AD7746_CONF_CAPFS(0x7);
> -	chip->config |= AD7746_CONF_CAPFS(i);
> +	chip->config &= ~AD7746_CONF_CAPFS_MASK;
> +	chip->config |= i << AD7746_CONF_CAPFS_SHIFT;
>  
>  	return 0;
>  }
> @@ -387,8 +391,8 @@ static int ad7746_store_vt_filter_rate_setup(struct ad7746_chip_info *chip,
>  	if (i >= ARRAY_SIZE(ad7746_vt_filter_rate_table))
>  		i = ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
>  
> -	chip->config &= ~AD7746_CONF_VTFS(0x3);
> -	chip->config |= AD7746_CONF_VTFS(i);
> +	chip->config &= ~AD7746_CONF_VTFS_MASK;
> +	chip->config |= i << AD7746_CONF_VTFS_SHIFT;
>  
>  	return 0;
>  }
> @@ -527,7 +531,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  			   long mask)
>  {
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> -	int ret, delay;
> +	int ret, delay, idx;
>  	u8 regval, reg;
>  
>  	mutex_lock(&indio_dev->mlock);
> @@ -635,13 +639,15 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		switch (chan->type) {
>  		case IIO_CAPACITANCE:
> -			*val = ad7746_cap_filter_rate_table[
> -					(chip->config >> 3) & 0x7][0];
> +			idx = (chip->config & AD7746_CONF_CAPFS_MASK) >>
> +				AD7746_CONF_CAPFS_SHIFT;
> +			*val = ad7746_cap_filter_rate_table[idx][0];
>  			ret = IIO_VAL_INT;
>  			break;
>  		case IIO_VOLTAGE:
> -			*val = ad7746_vt_filter_rate_table[
> -					(chip->config >> 6) & 0x3][0];
> +			idx = (chip->config & AD7746_CONF_VTFS_MASK) >>
> +				AD7746_CONF_VTFS_SHIFT;
> +			*val = ad7746_vt_filter_rate_table[idx][0];
>  			break;
>  		default:
>  			ret = -EINVAL;
> 

