Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A25464C;
	Mon, 10 Aug 2026 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786320591; cv=none; b=ajbON+KoAdv0s4kxTvJadPcpJNk0NBTAJMUHCeumZNr1dv1snWKgPyDrlKuiLTX3FkCd+IAdNDbDCVAAIfaBgvGLrWiVvdE7qnyWQsRrC76O/7dZfz1wtd7rRln2pdjPayvpoJ9d2UJ2mJmcK+Fw8ZM8WVEGfwZ5WLqyLfIlhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786320591; c=relaxed/simple;
	bh=vg8hyz2anSCxB1NhyOp8MN6bier34Tb5rGbQbl20P6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdC2ezDMRBBtE6WmrUX3J6LsXVWmeAIbH5a8E07krq02K396goWQ9seLLvU03kTNrqUOjDF6H1mUdT+3dGCnouSC1hvrieuUKfmsZNfYcF3B1vGp3wf0P5gv5mgfAWDOkLI0+vyKazzZ1H/NYU70zHMZvauFgY1Xzt5V6YmpeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtVRkmEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtVRkmEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3F31F000E9;
	Mon, 10 Aug 2026 00:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786320589;
	bh=XZ5ACkbqjZul/8N+RwI44P+oxbdRG5GmT5QCGnxh9EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XtVRkmEuilJY3LDcT7W0/DzOj2cGAT37HN5R8/wMDwXyDIFXBjxMv60Pipn7BQaCy
	 sRwZYi4WFIklZ1fVlvhSy1Xzc27l9F58bz6+m9lu9eoptOYZVlGSygtwOnh6PuDKKx
	 VosIPUyyNJIZC3ZE/tpR3k1BbbdfZxRfyoWumd3cbMuoL/NHBXMPsFdysVnejpnpHY
	 xhwb1/H12AyjJltYjDRbhQte0keAf6Cyjhe7P3Jou8hrQ1XmcN+l4xMHPdg3kupICN
	 ooBBY3X4rfReIXuMArndXM5uJL5gL9qJ5J/KcqcRaopagy3dtUTaCRc10GUYciqF+9
	 gHONPB7B3uGjg==
Date: Mon, 10 Aug 2026 01:09:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/5] iio: humidity: hts221: report available values via
 read_avail()
Message-ID: <20260810010943.014d8db1@jic23-huawei>
In-Reply-To: <20260808090026.34187-2-adinata.softwareengineer@gmail.com>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
	<20260808090026.34187-2-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 17:00:22 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> Replace the custom oversampling_ratio_available sysfs attributes with
> the standard IIO read_avail() callback. This lets the IIO core create
> and format *_available attributes and exposes the lists to
> in-kernel consumers.

Sashiko points out that there is an ABI change in here as oddly
the driver uses
in_humidity_oversampling_ratio_available rather than
in_humidityrelative_oversampling_ratio_available

Which makes this an ABI fix.  Therefore this should have a fixes
tag and be moved to the start of the set.  Please check that logic
though as maybe I'm missing something.

J
> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> ---
>  drivers/iio/humidity/hts221_core.c | 106 +++++++++++------------------
>  1 file changed, 40 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index bfeb0a60d3af..76a391f421f5 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -10,7 +10,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> @@ -49,7 +48,7 @@ struct hts221_odr {
>  struct hts221_avg {
>  	u8 addr;
>  	u8 mask;
> -	u16 avg_avl[HTS221_AVG_DEPTH];
> +	int avg_avl[HTS221_AVG_DEPTH];
>  };
>  
>  static const struct hts221_odr hts221_odr_table[] = {
> @@ -58,6 +57,8 @@ static const struct hts221_odr hts221_odr_table[] = {
>  	{ 13, 0x03 },	/* 12.5Hz */
>  };
>  
> +static const int hts221_odr_avail[] = { 1, 7, 13 };
> +
>  static const struct hts221_avg hts221_avg_list[] = {
>  	{
>  		.addr = 0x10,
> @@ -97,7 +98,11 @@ static const struct iio_chan_spec hts221_channels[] = {
>  				      BIT(IIO_CHAN_INFO_OFFSET) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available =
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 's',
> @@ -113,7 +118,11 @@ static const struct iio_chan_spec hts221_channels[] = {
>  				      BIT(IIO_CHAN_INFO_OFFSET) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available =
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 's',
> @@ -192,53 +201,35 @@ static int hts221_update_avg(struct hts221_hw *hw,
>  	return 0;
>  }
>  
> -static ssize_t hts221_sysfs_sampling_freq(struct device *dev,
> -					  struct device_attribute *attr,
> -					  char *buf)
> -{
> -	int i;
> -	ssize_t len = 0;
> -
> -	for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -				 hts221_odr_table[i].hz);
> -	buf[len - 1] = '\n';
> -
> -	return len;
> -}
> -
> -static ssize_t
> -hts221_sysfs_rh_oversampling_avail(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf)
> -{
> -	const struct hts221_avg *avg = &hts221_avg_list[HTS221_SENSOR_H];
> -	ssize_t len = 0;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -				 avg->avg_avl[i]);
> -	buf[len - 1] = '\n';
> -
> -	return len;
> -}
> -
> -static ssize_t
> -hts221_sysfs_temp_oversampling_avail(struct device *dev,
> -				     struct device_attribute *attr,
> -				     char *buf)
> +static int hts221_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
>  {
> -	const struct hts221_avg *avg = &hts221_avg_list[HTS221_SENSOR_T];
> -	ssize_t len = 0;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -				 avg->avg_avl[i]);
> -	buf[len - 1] = '\n';
> -
> -	return len;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			*vals = hts221_avg_list[HTS221_SENSOR_H].avg_avl;
> +			*length = ARRAY_SIZE(hts221_avg_list[HTS221_SENSOR_H].avg_avl);
> +			break;
> +		case IIO_TEMP:
> +			*vals = hts221_avg_list[HTS221_SENSOR_T].avg_avl;
> +			*length = ARRAY_SIZE(hts221_avg_list[HTS221_SENSOR_T].avg_avl);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = hts221_odr_avail;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(hts221_odr_avail);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  int hts221_set_enable(struct hts221_hw *hw, bool enable)
> @@ -521,27 +512,10 @@ static int hts221_validate_trigger(struct iio_dev *iio_dev,
>  	return hw->trig == trig ? 0 : -EINVAL;
>  }
>  
> -static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, S_IRUGO,
> -		       hts221_sysfs_rh_oversampling_avail, NULL, 0);
> -static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, S_IRUGO,
> -		       hts221_sysfs_temp_oversampling_avail, NULL, 0);
> -static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hts221_sysfs_sampling_freq);
> -
> -static struct attribute *hts221_attributes[] = {
> -	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> -	&iio_dev_attr_in_humidity_oversampling_ratio_available.dev_attr.attr,
> -	&iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group hts221_attribute_group = {
> -	.attrs = hts221_attributes,
> -};
> -
>  static const struct iio_info hts221_info = {
> -	.attrs = &hts221_attribute_group,
>  	.read_raw = hts221_read_raw,
>  	.write_raw = hts221_write_raw,
> +	.read_avail = hts221_read_avail,
>  	.validate_trigger = hts221_validate_trigger,
>  };
>  

