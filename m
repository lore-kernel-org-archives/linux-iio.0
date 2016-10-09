Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39105 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbcJIH6p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 03:58:45 -0400
Subject: Re: [PATCH] Staging: iio: meter: ade7758_core: implement
 IIO_CHAN_INFO_SAMP_FREQ
To: Sandhya Bankar <bankarsandhya512@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
References: <20161003205906.GA9271@localhost.localdomain>
Cc: outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <db94a7bd-715c-0c8d-3d9d-ecc4dbdefde4@kernel.org>
Date: Sun, 9 Oct 2016 08:58:34 +0100
MIME-Version: 1.0
In-Reply-To: <20161003205906.GA9271@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/16 21:59, Sandhya Bankar wrote:
> This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ attribute
> wherein usage has some advantages like it can be accessed by in-kernel
> consumers as well as reduces the code size.
> 
> Hence moving functionality from IIO_DEV_ATTR_SAMP_FREQ attribute into
> IIO_CHAN_INFO_SAMP_FREQ handlers. Also Adding ade7758_read_raw() and
> ade7758_write_raw() to allow reading/writing the element as well.
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

This is another driver where I'd argue that hardware will be needed
to take it much further unfortunately. I've asked Lars to confirm
if Analog have any intent wrt to these meter drivers in the other
thread. Let's see what he comes back with,

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7758_core.c | 86 +++++++++++++++++++++++---------
>  1 file changed, 63 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index ebb8a19..8fcca97 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -465,38 +465,26 @@ err_ret:
>  	return ret;
>  }
>  
> -static ssize_t ade7758_read_frequency(struct device *dev,
> -				      struct device_attribute *attr, char *buf)
> +static int ade7758_read_samp_freq(struct device *dev, int *val)
>  {
>  	int ret;
>  	u8 t;
> -	int sps;
>  
>  	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &t);
>  	if (ret)
>  		return ret;
>  
>  	t = (t >> 5) & 0x3;
> -	sps = 26040 / (1 << t);
> +	*val = 26040 / (1 << t);
>  
> -	return sprintf(buf, "%d SPS\n", sps);
> +	return 0;
>  }
>  
> -static ssize_t ade7758_write_frequency(struct device *dev,
> -				       struct device_attribute *attr,
> -				       const char *buf, size_t len)
> +static int ade7758_write_samp_freq(struct device *dev, int val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	u16 val;
>  	int ret;
>  	u8 reg, t;
>  
> -	ret = kstrtou16(buf, 10, &val);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&indio_dev->mlock);
> -
>  	switch (val) {
>  	case 26040:
>  		t = 0;
> @@ -525,9 +513,49 @@ static ssize_t ade7758_write_frequency(struct device *dev,
>  	ret = ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	return ret;
> +}
>  
> -	return ret ? ret : len;
> +static int ade7758_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&indio_dev->mlock);
> +		ret = ade7758_read_samp_freq(&indio_dev->dev, val);
> +		mutex_unlock(&indio_dev->mlock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ade7758_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val2)
> +			return -EINVAL;
> +		mutex_lock(&indio_dev->mlock);
> +		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> +		mutex_unlock(&indio_dev->mlock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
>  }
>  
>  static IIO_DEV_ATTR_TEMP_RAW(ade7758_read_8bit);
> @@ -553,17 +581,12 @@ static IIO_DEV_ATTR_BVAHR(ade7758_read_16bit,
>  static IIO_DEV_ATTR_CVAHR(ade7758_read_16bit,
>  		ADE7758_CVAHR);
>  
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> -		ade7758_read_frequency,
> -		ade7758_write_frequency);
> -
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26040 13020 6510 3255");
>  
>  static struct attribute *ade7758_attributes[] = {
>  	&iio_dev_attr_in_temp_raw.dev_attr.attr,
>  	&iio_const_attr_in_temp_offset.dev_attr.attr,
>  	&iio_const_attr_in_temp_scale.dev_attr.attr,
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_awatthr.dev_attr.attr,
>  	&iio_dev_attr_bwatthr.dev_attr.attr,
> @@ -611,6 +634,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
>  		.channel = 0,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
>  		.scan_index = 0,
>  		.scan_type = {
> @@ -622,6 +646,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.type = IIO_CURRENT,
>  		.indexed = 1,
>  		.channel = 0,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_CURRENT),
>  		.scan_index = 1,
>  		.scan_type = {
> @@ -634,6 +659,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 0,
>  		.extend_name = "apparent",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_APP_PWR),
>  		.scan_index = 2,
>  		.scan_type = {
> @@ -646,6 +672,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 0,
>  		.extend_name = "active",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_ACT_PWR),
>  		.scan_index = 3,
>  		.scan_type = {
> @@ -658,6 +685,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 0,
>  		.extend_name = "reactive",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
>  		.scan_index = 4,
>  		.scan_type = {
> @@ -669,6 +697,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
>  		.channel = 1,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
>  		.scan_index = 5,
>  		.scan_type = {
> @@ -680,6 +709,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.type = IIO_CURRENT,
>  		.indexed = 1,
>  		.channel = 1,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_CURRENT),
>  		.scan_index = 6,
>  		.scan_type = {
> @@ -692,6 +722,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 1,
>  		.extend_name = "apparent",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_APP_PWR),
>  		.scan_index = 7,
>  		.scan_type = {
> @@ -704,6 +735,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 1,
>  		.extend_name = "active",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_ACT_PWR),
>  		.scan_index = 8,
>  		.scan_type = {
> @@ -716,6 +748,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 1,
>  		.extend_name = "reactive",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
>  		.scan_index = 9,
>  		.scan_type = {
> @@ -727,6 +760,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
>  		.channel = 2,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
>  		.scan_index = 10,
>  		.scan_type = {
> @@ -738,6 +772,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.type = IIO_CURRENT,
>  		.indexed = 1,
>  		.channel = 2,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_CURRENT),
>  		.scan_index = 11,
>  		.scan_type = {
> @@ -750,6 +785,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 2,
>  		.extend_name = "apparent",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_APP_PWR),
>  		.scan_index = 12,
>  		.scan_type = {
> @@ -762,6 +798,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 2,
>  		.extend_name = "active",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_ACT_PWR),
>  		.scan_index = 13,
>  		.scan_type = {
> @@ -774,6 +811,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  		.indexed = 1,
>  		.channel = 2,
>  		.extend_name = "reactive",
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_REACT_PWR),
>  		.scan_index = 14,
>  		.scan_type = {
> @@ -787,6 +825,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  
>  static const struct iio_info ade7758_info = {
>  	.attrs = &ade7758_attribute_group,
> +	.read_raw = &ade7758_read_raw,
> +	.write_raw = &ade7758_write_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 

