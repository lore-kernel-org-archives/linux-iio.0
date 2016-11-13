Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40505 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbcKMMZL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:25:11 -0500
Subject: Re: [PATCH v4 19/26] staging: iio: tsl2583: move from a global to a
 per device lux table
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-20-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1f7aea9c-359d-e1e7-8d09-ef038c0aa1b4@kernel.org>
Date: Sun, 13 Nov 2016 12:25:09 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-20-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> The driver contains a global lux table that can be updated via sysfs.
> Change this to a per device lux table so that multiple devices can be
> hooked up to the same system with different lux tables.
> 
> There are 10 entries, plus 1 for the termination segment, set aside for
> the entries in the lux table. When updating the lux table via sysfs,
> only 9 entries, plus the terminator, could be added. This changes
> the code to allow for the 10 entries, plus the terminator.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 80 +++++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 78967dc..3818ffa 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -70,11 +70,34 @@ struct tsl2583_als_info {
>  	u16 lux;
>  };
>  
> +struct tsl2583_lux {
> +	unsigned int ratio;
> +	unsigned int ch0;
> +	unsigned int ch1;
> +};
> +
> +static const struct tsl2583_lux tsl2583_default_lux[] = {
> +	{  9830,  8520, 15729 },
> +	{ 12452, 10807, 23344 },
> +	{ 14746,  6383, 11705 },
> +	{ 17695,  4063,  6554 },
> +	{     0,     0,     0 }  /* Termination segment */
> +};
> +
> +#define TSL2583_MAX_LUX_TABLE_ENTRIES 11
> +
>  struct tsl2583_settings {
>  	int als_time;
>  	int als_gain;
>  	int als_gain_trim;
>  	int als_cal_target;
> +
> +	/*
> +	 * This structure is intentionally large to accommodate updates via
> +	 * sysfs. Sized to 11 = max 10 segments + 1 termination segment.
> +	 * Assumption is that one and only one type of glass used.
> +	 */
> +	struct tsl2583_lux als_device_lux[TSL2583_MAX_LUX_TABLE_ENTRIES];
>  };
>  
>  struct tsl2583_chip {
> @@ -87,24 +110,6 @@ struct tsl2583_chip {
>  	bool suspended;
>  };
>  
> -struct tsl2583_lux {
> -	unsigned int ratio;
> -	unsigned int ch0;
> -	unsigned int ch1;
> -};
> -
> -/*
> - * This structure is intentionally large to accommodate updates via sysfs.
> - * Sized to 11 = max 10 segments + 1 termination segment. Assumption is that
> - * one and only one type of glass used.
> - */
> -static struct tsl2583_lux tsl2583_device_lux[11] = {
> -	{  9830,  8520, 15729 },
> -	{ 12452, 10807, 23344 },
> -	{ 14746,  6383, 11705 },
> -	{ 17695,  4063,  6554 },
> -};
> -
>  struct gainadj {
>  	s16 ch0;
>  	s16 ch1;
> @@ -142,6 +147,10 @@ static void tsl2583_defaults(struct tsl2583_chip *chip)
>  
>  	/* Known external ALS reading used for calibration */
>  	chip->als_settings.als_cal_target = 130;
> +
> +	/* Default lux table. */
> +	memcpy(chip->als_settings.als_device_lux, tsl2583_default_lux,
> +	       sizeof(tsl2583_default_lux));
>  }
>  
>  /*
> @@ -151,7 +160,7 @@ static void tsl2583_defaults(struct tsl2583_chip *chip)
>   * Time scale factor array values are adjusted based on the integration time.
>   * The raw values are multiplied by a scale factor, and device gain is obtained
>   * using gain index. Limit checks are done next, then the ratio of a multiple
> - * of ch1 value, to the ch0 value, is calculated. The array tsl2583_device_lux[]
> + * of ch1 value, to the ch0 value, is calculated. The array als_device_lux[]
>   * declared above is then scanned to find the first ratio value that is just
>   * above the ratio we just calculated. The ch0 and ch1 multiplier constants in
>   * the array are then used along with the time scale factor array values, to
> @@ -233,7 +242,7 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
>  	ratio = (ch1 << 15) / ch0;
>  
>  	/* convert to unscaled lux using the pointer to the table */
> -	for (p = (struct tsl2583_lux *)tsl2583_device_lux;
> +	for (p = (struct tsl2583_lux *)chip->als_settings.als_device_lux;
>  	     p->ratio != 0 && p->ratio < ratio; p++)
>  		;
>  
> @@ -270,7 +279,7 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
>  
>  	/*
>  	 * Adjust for active gain scale.
> -	 * The tsl2583_device_lux tables above have a factor of 8192 built in,
> +	 * The tsl2583_default_lux tables above have a factor of 8192 built in,
>  	 * so we need to shift right.
>  	 * User-specified gain provides a multiplier.
>  	 * Apply user-specified gain before shifting right to retain precision.
> @@ -522,15 +531,17 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
>  					     struct device_attribute *attr,
>  					     char *buf)
>  {
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl2583_chip *chip = iio_priv(indio_dev);
>  	unsigned int i;
>  	int offset = 0;
>  
> -	for (i = 0; i < ARRAY_SIZE(tsl2583_device_lux); i++) {
> +	for (i = 0; i < ARRAY_SIZE(chip->als_settings.als_device_lux); i++) {
>  		offset += sprintf(buf + offset, "%u,%u,%u,",
> -				  tsl2583_device_lux[i].ratio,
> -				  tsl2583_device_lux[i].ch0,
> -				  tsl2583_device_lux[i].ch1);
> -		if (tsl2583_device_lux[i].ratio == 0) {
> +				  chip->als_settings.als_device_lux[i].ratio,
> +				  chip->als_settings.als_device_lux[i].ch0,
> +				  chip->als_settings.als_device_lux[i].ch1);
> +		if (chip->als_settings.als_device_lux[i].ratio == 0) {
>  			/*
>  			 * We just printed the first "0" entry.
>  			 * Now get rid of the extra "," and break.
> @@ -545,15 +556,14 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
>  	return offset;
>  }
>  
> -#define TSL2583_MAX_LUX_INTS ((ARRAY_SIZE(tsl2583_device_lux) - 1) * 3)
> -
>  static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  					      struct device_attribute *attr,
>  					      const char *buf, size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	int value[ARRAY_SIZE(tsl2583_device_lux) * 3 + 1];
> +	const unsigned int max_ints = TSL2583_MAX_LUX_TABLE_ENTRIES * 3;
> +	int value[TSL2583_MAX_LUX_TABLE_ENTRIES * 3];
>  	int ret = -EINVAL;
>  	unsigned int n;
>  
> @@ -568,10 +578,10 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  	 * and the last table entry is all 0.
>  	 */
>  	n = value[0];
> -	if ((n % 3) || n < 6 || n > TSL2583_MAX_LUX_INTS) {
> +	if ((n % 3) || n < 6 || n > max_ints) {
>  		dev_err(dev,
> -			"%s: The number of entries in the lux table must be a multiple of 3 and within the range [6, %zu]\n",
> -			__func__, TSL2583_MAX_LUX_INTS);
> +			"%s: The number of entries in the lux table must be a multiple of 3 and within the range [6, %d]\n",
> +			__func__, max_ints);
>  		goto done;
>  	}
>  	if ((value[n - 2] | value[n - 1] | value[n]) != 0) {
> @@ -581,8 +591,10 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  	}
>  
>  	/* Zero out the table */
> -	memset(tsl2583_device_lux, 0, sizeof(tsl2583_device_lux));
> -	memcpy(tsl2583_device_lux, &value[1], value[0] * sizeof(value[1]));
> +	memset(chip->als_settings.als_device_lux, 0,
> +	       sizeof(chip->als_settings.als_device_lux));
> +	memcpy(chip->als_settings.als_device_lux, &value[1],
> +	       value[0] * sizeof(value[1]));
>  
>  	ret = len;
>  
> 

