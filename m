Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37790 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab3IHNQZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 09:16:25 -0400
Message-ID: <522C86C0.8000909@kernel.org>
Date: Sun, 08 Sep 2013 15:16:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	'Lars-Peter Clausen' <lars@metafoo.de>
Subject: Re: [PATCH V3] staging: iio: replace strict_strto*() with kstrto*()
References: <004c01ce9d4d$718f9180$54aeb480$@samsung.com>
In-Reply-To: <004c01ce9d4d$718f9180$54aeb480$@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/20/13 03:31, Jingoo Han wrote:
> The usage of strict_strto*() is not preferred, because
> strict_strto*() is obsolete. Thus, kstrto*() should be
> used.
> 
> Previously, there were only strict_strtol(), strict_strtoul(),
> strict_strtoull(), and strict_strtoll(). Thus, when converting
> to the variables, only long, unsigned long, unsigned long long,
> and long long can be used.
> 
> However, kstrto*() provides various functions handling all types
> of variables. Therefore, the types of variables can be changed
> properly.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
> Changes since v2:
> - Fixed the type of variables suggested by Jonathan Cameron
> 
>  drivers/staging/iio/accel/sca3000_core.c           |    8 ++---
>  drivers/staging/iio/accel/sca3000_ring.c           |    4 +--
>  drivers/staging/iio/addac/adt7316.c                |   38 ++++++++++----------
>  drivers/staging/iio/frequency/ad9832.c             |    4 +--
>  drivers/staging/iio/frequency/ad9834.c             |    4 +--
>  drivers/staging/iio/impedance-analyzer/ad5933.c    |   12 +++----
>  drivers/staging/iio/light/isl29018.c               |   18 +++++-----
>  drivers/staging/iio/light/tsl2583.c                |   24 ++++++-------
>  drivers/staging/iio/meter/ade7753.c                |   12 +++----
>  drivers/staging/iio/meter/ade7754.c                |   12 +++----
>  drivers/staging/iio/meter/ade7758_core.c           |   12 +++----
>  drivers/staging/iio/meter/ade7759.c                |   12 +++----
>  drivers/staging/iio/meter/ade7854.c                |   16 ++++-----
>  drivers/staging/iio/resolver/ad2s1210.c            |   20 +++++------
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   23 +++++-------
>  .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    4 +--
>  16 files changed, 109 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index 32950ad..5e99975 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -624,9 +624,9 @@ static ssize_t sca3000_set_frequency(struct device *dev,
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret, base_freq = 0;
>  	int ctrlval;
> -	long val;
> +	int val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtoint(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  
> @@ -931,12 +931,12 @@ static ssize_t sca3000_set_free_fall_mode(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct sca3000_state *st = iio_priv(indio_dev);
> -	long val;
> +	u8 val;
>  	int ret;
>  	u8 protect_mask = SCA3000_FREE_FALL_DETECT;
>  
>  	mutex_lock(&st->lock);
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index 3e5e860..0f2ee33 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -177,11 +177,11 @@ static ssize_t sca3000_set_ring_int(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	long val;
> +	u8 val;
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 1e13568..47e482f 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -412,13 +412,13 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config2;
> -	unsigned long data = 0;
> +	u8 data;
>  	int ret;
>  
>  	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
>  		return -EPERM;
>  
> -	ret = strict_strtoul(buf, 10, &data);
> +	ret = kstrtou8(buf, 10, &data);
>  	if (ret)
>  		return -EINVAL;
>  
> @@ -823,10 +823,10 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 dac_config;
> -	unsigned long data = 0;
> +	u8 data;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 16, &data);
> +	ret = kstrtou8(buf, 16, &data);
>  	if (ret || data > ADT7316_DA_2VREF_CH_MASK)
>  		return -EINVAL;
>  
> @@ -878,13 +878,13 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 dac_config;
> -	unsigned long data;
> +	u8 data;
>  	int ret;
>  
>  	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
>  		return -EPERM;
>  
> -	ret = strict_strtoul(buf, 10, &data);
> +	ret = kstrtou8(buf, 10, &data);
>  	if (ret || data > ADT7316_DA_EN_MODE_MASK)
>  		return -EINVAL;
>  
> @@ -933,7 +933,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 ldac_config;
> -	unsigned long data;
> +	u8 data;
>  	int ret;
>  
>  	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA) {
> @@ -941,7 +941,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
>  			ADT7316_DA_EN_MODE_LDAC)
>  			return -EPERM;
>  
> -		ret = strict_strtoul(buf, 16, &data);
> +		ret = kstrtou8(buf, 16, &data);
>  		if (ret || data > ADT7316_LDAC_EN_DA_MASK)
>  			return -EINVAL;
>  
> @@ -1079,11 +1079,11 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 ldac_config;
> -	unsigned long data;
> +	u8 data;
>  	int ret;
>  
>  	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) {
> -		ret = strict_strtoul(buf, 16, &data);
> +		ret = kstrtou8(buf, 16, &data);
>  		if (ret || data > 3)
>  			return -EINVAL;
>  
> @@ -1093,7 +1093,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
>  		else if (data & 0x2)
>  			ldac_config |= ADT7516_DAC_CD_IN_VREF;
>  	} else {
> -		ret = strict_strtoul(buf, 16, &data);
> +		ret = kstrtou8(buf, 16, &data);
>  		if (ret)
>  			return -EINVAL;
>  
> @@ -1281,11 +1281,11 @@ static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
>  static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
>  		int offset_addr, const char *buf, size_t len)
>  {
> -	long data;
> +	int data;
>  	u8 val;
>  	int ret;
>  
> -	ret = strict_strtol(buf, 10, &data);
> +	ret = kstrtoint(buf, 10, &data);
>  	if (ret || data > 127 || data < -128)
>  		return -EINVAL;
>  
> @@ -1442,7 +1442,7 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
>  		int channel, const char *buf, size_t len)
>  {
>  	u8 msb, lsb, offset;
> -	unsigned long data;
> +	u16 data;
>  	int ret;
>  
>  	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
> @@ -1454,7 +1454,7 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
>  
>  	offset = chip->dac_bits - 8;
>  
> -	ret = strict_strtoul(buf, 10, &data);
> +	ret = kstrtou16(buf, 10, &data);
>  	if (ret || data >= (1 << chip->dac_bits))
>  		return -EINVAL;
>  
> @@ -1830,11 +1830,11 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	unsigned long data;
> +	u16 data;
>  	int ret;
>  	u8 mask;
>  
> -	ret = strict_strtoul(buf, 16, &data);
> +	ret = kstrtou16(buf, 16, &data);
>  	if (ret || data >= ADT7316_VDD_INT_MASK + 1)
>  		return -EINVAL;
>  
> @@ -1901,7 +1901,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	long data;
> +	int data;
>  	u8 val;
>  	int ret;
>  
> @@ -1909,7 +1909,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
>  		this_attr->address > ADT7316_EX_TEMP_LOW)
>  		return -EPERM;
>  
> -	ret = strict_strtol(buf, 10, &data);
> +	ret = kstrtoint(buf, 10, &data);
>  	if (ret)
>  		return -EINVAL;
>  
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 4e18380..944fb52 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -81,9 +81,9 @@ static ssize_t ad9832_write(struct device *dev,
>  	struct ad9832_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	unsigned long val;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 5cba3c0..155abed 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -70,9 +70,9 @@ static ssize_t ad9834_write(struct device *dev,
>  	struct ad9834_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	unsigned long val;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 6330af6..8f2ff53 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -323,10 +323,10 @@ static ssize_t ad5933_store_frequency(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	long val;
> +	unsigned long val;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  
> @@ -400,12 +400,12 @@ static ssize_t ad5933_store(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	long val;
> +	u16 val;
>  	int i, ret = 0;
>  	unsigned short dat;
>  
>  	if (this_attr->address != AD5933_IN_PGA_GAIN) {
> -		ret = strict_strtol(buf, 10, &val);
> +		ret = kstrtou16(buf, 10, &val);
>  		if (ret)
>  			return ret;
>  	}
> @@ -434,7 +434,7 @@ static ssize_t ad5933_store(struct device *dev,
>  		ret = ad5933_cmd(st, 0);
>  		break;
>  	case AD5933_OUT_SETTLING_CYCLES:
> -		val = clamp(val, 0L, 0x7FFL);
> +		val = clamp(val, (u16)0, (u16)0x7FF);
>  		st->settling_cycles = val;
>  
>  		/* 2x, 4x handling, see datasheet */
> @@ -448,7 +448,7 @@ static ssize_t ad5933_store(struct device *dev,
>  				AD5933_REG_SETTLING_CYCLES, 2, (u8 *)&dat);
>  		break;
>  	case AD5933_FREQ_POINTS:
> -		val = clamp(val, 0L, 511L);
> +		val = clamp(val, (u16)0, (u16)511);
>  		st->freq_points = val;
>  
>  		dat = cpu_to_be16(val);
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 351936c..e314d7e 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -240,7 +240,7 @@ static ssize_t store_range(struct device *dev,
>  	unsigned long lval;
>  	unsigned int new_range;
>  
> -	if (strict_strtoul(buf, 10, &lval))
> +	if (kstrtoul(buf, 10, &lval))
>  		return -EINVAL;
>  
>  	if (!(lval == 1000UL || lval == 4000UL ||
> @@ -279,18 +279,18 @@ static ssize_t store_resolution(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct isl29018_chip *chip = iio_priv(indio_dev);
>  	int status;
> -	unsigned long lval;
> +	unsigned int val;
>  	unsigned int new_adc_bit;
>  
> -	if (strict_strtoul(buf, 10, &lval))
> +	if (kstrtouint(buf, 10, &val))
>  		return -EINVAL;
> -	if (!(lval == 4 || lval == 8 || lval == 12 || lval == 16)) {
> +	if (!(val == 4 || val == 8 || val == 12 || val == 16)) {
>  		dev_err(dev, "The resolution is not supported\n");
>  		return -EINVAL;
>  	}
>  
>  	mutex_lock(&chip->lock);
> -	status = isl29018_set_resolution(chip, lval, &new_adc_bit);
> +	status = isl29018_set_resolution(chip, val, &new_adc_bit);
>  	if (status < 0) {
>  		mutex_unlock(&chip->lock);
>  		dev_err(dev, "Error in setting resolution\n");
> @@ -319,11 +319,11 @@ static ssize_t store_prox_infrared_suppression(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct isl29018_chip *chip = iio_priv(indio_dev);
> -	unsigned long lval;
> +	int val;
>  
> -	if (strict_strtoul(buf, 10, &lval))
> +	if (kstrtoint(buf, 10, &val))
>  		return -EINVAL;
> -	if (!(lval == 0UL || lval == 1UL)) {
> +	if (!(val == 0 || val == 1)) {
>  		dev_err(dev, "The mode is not supported\n");
>  		return -EINVAL;
>  	}
> @@ -331,7 +331,7 @@ static ssize_t store_prox_infrared_suppression(struct device *dev,
>  	/* get the  "proximity scheme" i.e. if the chip does on chip
>  	infrared suppression (1 means perform on chip suppression) */
>  	mutex_lock(&chip->lock);
> -	chip->prox_scheme = (int)lval;
> +	chip->prox_scheme = val;
>  	mutex_unlock(&chip->lock);
>  
>  	return count;
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index b377dd3..44d00a9 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -493,9 +493,9 @@ static ssize_t taos_power_state_store(struct device *dev,
>  	struct device_attribute *attr, const char *buf, size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	unsigned long value;
> +	int value;
>  
> -	if (strict_strtoul(buf, 0, &value))
> +	if (kstrtoint(buf, 0, &value))
>  		return -EINVAL;
>  
>  	if (value == 0)
> @@ -536,9 +536,9 @@ static ssize_t taos_gain_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	unsigned long value;
> +	int value;
>  
> -	if (strict_strtoul(buf, 0, &value))
> +	if (kstrtoint(buf, 0, &value))
>  		return -EINVAL;
>  
>  	switch (value) {
> @@ -582,9 +582,9 @@ static ssize_t taos_als_time_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	unsigned long value;
> +	int value;
>  
> -	if (strict_strtoul(buf, 0, &value))
> +	if (kstrtoint(buf, 0, &value))
>  		return -EINVAL;
>  
>  	if ((value < 50) || (value > 650))
> @@ -619,9 +619,9 @@ static ssize_t taos_als_trim_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	unsigned long value;
> +	int value;
>  
> -	if (strict_strtoul(buf, 0, &value))
> +	if (kstrtoint(buf, 0, &value))
>  		return -EINVAL;
>  
>  	if (value)
> @@ -644,9 +644,9 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	unsigned long value;
> +	int value;
>  
> -	if (strict_strtoul(buf, 0, &value))
> +	if (kstrtoint(buf, 0, &value))
>  		return -EINVAL;
>  
>  	if (value)
> @@ -671,9 +671,9 @@ static ssize_t taos_do_calibrate(struct device *dev,
>  	struct device_attribute *attr, const char *buf, size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	unsigned long value;
> +	int value;
>  
> -	if (strict_strtoul(buf, 0, &value))
> +	if (kstrtoint(buf, 0, &value))
>  		return -EINVAL;
>  
>  	if (value == 1)
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index 74025fb..f0bba33 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -186,9 +186,9 @@ static ssize_t ade7753_write_8bit(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	u8 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = ade7753_spi_write_reg_8(dev, this_attr->address, val);
> @@ -204,9 +204,9 @@ static ssize_t ade7753_write_16bit(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	u16 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = ade7753_spi_write_reg_16(dev, this_attr->address, val);
> @@ -399,11 +399,11 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7753_state *st = iio_priv(indio_dev);
> -	unsigned long val;
> +	u16 val;
>  	int ret;
>  	u16 reg, t;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  	if (val == 0)
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index f649ebe..63a6ad1c 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -186,9 +186,9 @@ static ssize_t ade7754_write_8bit(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	u8 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = ade7754_spi_write_reg_8(dev, this_attr->address, val);
> @@ -204,9 +204,9 @@ static ssize_t ade7754_write_16bit(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	u16 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = ade7754_spi_write_reg_16(dev, this_attr->address, val);
> @@ -419,11 +419,11 @@ static ssize_t ade7754_write_frequency(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7754_state *st = iio_priv(indio_dev);
> -	unsigned long val;
> +	u16 val;
>  	int ret;
>  	u8 reg, t;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  	if (val == 0)
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index 6005d4a..6a62751 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -269,9 +269,9 @@ static ssize_t ade7758_write_8bit(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	u8 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = ade7758_spi_write_reg_8(dev, this_attr->address, val);
> @@ -287,9 +287,9 @@ static ssize_t ade7758_write_16bit(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	u16 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = ade7758_spi_write_reg_16(dev, this_attr->address, val);
> @@ -502,11 +502,11 @@ static ssize_t ade7758_write_frequency(struct device *dev,
>  		size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	unsigned long val;
> +	u16 val;
>  	int ret;
>  	u8 reg, t;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index d214ac4..c1a3a5d 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -185,9 +185,9 @@ static ssize_t ade7759_write_8bit(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	u8 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = ade7759_spi_write_reg_8(dev, this_attr->address, val);
> @@ -203,9 +203,9 @@ static ssize_t ade7759_write_16bit(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> -	long val;
> +	u16 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = ade7759_spi_write_reg_16(dev, this_attr->address, val);
> @@ -360,11 +360,11 @@ static ssize_t ade7759_write_frequency(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7759_state *st = iio_priv(indio_dev);
> -	unsigned long val;
> +	u16 val;
>  	int ret;
>  	u16 reg, t;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  	if (val == 0)
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index e8379c0..8e068ab 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -100,9 +100,9 @@ static ssize_t ade7854_write_8bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	int ret;
> -	long val;
> +	u8 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = st->write_reg_8(dev, this_attr->address, val);
> @@ -121,9 +121,9 @@ static ssize_t ade7854_write_16bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	int ret;
> -	long val;
> +	u16 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = st->write_reg_16(dev, this_attr->address, val);
> @@ -142,9 +142,9 @@ static ssize_t ade7854_write_24bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	int ret;
> -	long val;
> +	u32 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou32(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = st->write_reg_24(dev, this_attr->address, val);
> @@ -163,9 +163,9 @@ static ssize_t ade7854_write_32bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	int ret;
> -	long val;
> +	u32 val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou32(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = st->write_reg_32(dev, this_attr->address, val);
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index dcdadbb..2b0c8e5 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -206,10 +206,10 @@ static ssize_t ad2s1210_store_fclkin(struct device *dev,
>  				     size_t len)
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned long fclkin;
> +	unsigned int fclkin;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &fclkin);
> +	ret = kstrtouint(buf, 10, &fclkin);
>  	if (ret)
>  		return ret;
>  	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
> @@ -243,10 +243,10 @@ static ssize_t ad2s1210_store_fexcit(struct device *dev,
>  				     const char *buf, size_t len)
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned long fexcit;
> +	unsigned int fexcit;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &fexcit);
> +	ret = kstrtouint(buf, 10, &fexcit);
>  	if (ret < 0)
>  		return ret;
>  	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
> @@ -282,11 +282,11 @@ static ssize_t ad2s1210_store_control(struct device *dev,
>  			const char *buf, size_t len)
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned long udata;
> +	unsigned char udata;
>  	unsigned char data;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 16, &udata);
> +	ret = kstrtou8(buf, 16, &udata);
>  	if (ret)
>  		return -EINVAL;
>  
> @@ -337,10 +337,10 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
>  	unsigned char data;
> -	unsigned long udata;
> +	unsigned char udata;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &udata);
> +	ret = kstrtou8(buf, 10, &udata);
>  	if (ret || udata < 10 || udata > 16) {
>  		pr_err("ad2s1210: resolution out of range\n");
>  		return -EINVAL;
> @@ -438,11 +438,11 @@ static ssize_t ad2s1210_store_reg(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned long data;
> +	unsigned char data;
>  	int ret;
>  	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
>  
> -	ret = strict_strtoul(buf, 10, &data);
> +	ret = kstrtou8(buf, 10, &data);
>  	if (ret)
>  		return -EINVAL;
>  	mutex_lock(&st->lock);
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 38a158b..ebb189c 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -83,32 +83,28 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
>  {
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
> -	unsigned long val;
> +	unsigned int val;
>  	bool enabled;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtouint(buf, 10, &val);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
>  
>  	if (val > 100000) {
> -		ret = -EINVAL;
> -		goto error_ret;
> -	}
> +		return -EINVAL;
>  
>  	enabled = get_enabled_gptimers() & st->t->bit;
>  
>  	if (enabled)
>  		disable_gptimers(st->t->bit);
>  
> -	if (!val)
> -		goto error_ret;
> +	if (val == 0)
> +		return count;
>  
>  	val = get_sclk() / val;
> -	if (val <= 4 || val <= st->duty) {
> -		ret = -EINVAL;
> -		goto error_ret;
> -	}
> +	if (val <= 4 || val <= st->duty)
> +		return -EINVAL;
>  
>  	set_gptimer_period(st->t->id, val);
>  	set_gptimer_pwidth(st->t->id, val - st->duty);
> @@ -116,8 +112,7 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
>  	if (enabled)
>  		enable_gptimers(st->t->bit);
>  
> -error_ret:
> -	return ret ? ret : count;
> +	return count;
>  }
>  
>  static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> index 7969597..48a6afa 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -53,10 +53,10 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
>  {
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
> -	unsigned long val;
> +	int val;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoint(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  
> 
