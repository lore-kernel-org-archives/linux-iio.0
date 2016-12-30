Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52738 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754084AbcL3Sv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:51:29 -0500
Subject: Re: [PATCHv4 6/8] Fixed code wrap alignment with preceding (.
To: Scott Matheina <scott@matheina.com>, linux-kernel@vger.kernel.org
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
 <1482696216-8013-7-git-send-email-scott@matheina.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <117e82cb-b621-c261-a1fe-6a8b1c662944@kernel.org>
Date: Fri, 30 Dec 2016 18:51:25 +0000
MIME-Version: 1.0
In-Reply-To: <1482696216-8013-7-git-send-email-scott@matheina.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/12/16 19:56, Scott Matheina wrote:
> The code wasn't aligned with preceding ( on following lines, fixes
> this coding style issue.
> 
> Signed-off-by: Scott Matheina <scott@matheina.com>
This looks fine, but is invasive enough I suspect it won't apply without
some of the earlier patches.  If you care to respin this, please give
it a title of the same form I suggested for the previous patch.

Jonathan
> ---
>  drivers/staging/iio/addac/adt7316.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 4678a64..91ac222 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -317,8 +317,8 @@ static IIO_DEVICE_ATTR(select_ex_temp, S_IRUGO | S_IWUSR,
>  		0);
>  
>  static ssize_t adt7316_show_mode(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -358,8 +358,8 @@ static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
>  		0);
>  
>  static ssize_t adt7316_show_all_modes(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				      struct device_attribute *attr,
> +				      char *buf)
>  {
>  	return sprintf(buf, "single_channel\nround_robin\n");
>  }
> @@ -367,8 +367,8 @@ static ssize_t adt7316_show_all_modes(struct device *dev,
>  static IIO_DEVICE_ATTR(all_modes, S_IRUGO, adt7316_show_all_modes, NULL, 0);
>  
>  static ssize_t adt7316_show_ad_channel(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				       struct device_attribute *attr,
> +				       char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -383,7 +383,7 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
>  		return sprintf(buf, "1 - Internal Temperature\n");
>  	case ADT7316_AD_SINGLE_CH_EX:
>  		if (((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) &&
> -			(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
> +		    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
>  			return sprintf(buf, "2 - AIN1\n");
>  
>  		return sprintf(buf, "2 - External Temperature\n");
> @@ -451,8 +451,8 @@ static IIO_DEVICE_ATTR(ad_channel, S_IRUGO | S_IWUSR,
>  		0);
>  
>  static ssize_t adt7316_show_all_ad_channels(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					    struct device_attribute *attr,
> +					    char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -472,8 +472,8 @@ static IIO_DEVICE_ATTR(all_ad_channels, S_IRUGO,
>  		adt7316_show_all_ad_channels, NULL, 0);
>  
>  static ssize_t adt7316_show_disable_averaging(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					      struct device_attribute *attr,
> +					      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -511,8 +511,8 @@ static IIO_DEVICE_ATTR(disable_averaging, S_IRUGO | S_IWUSR,
>  		0);
>  
>  static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +						 struct device_attribute *attr,
> +						 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -550,8 +550,8 @@ static IIO_DEVICE_ATTR(enable_smbus_timeout, S_IRUGO | S_IWUSR,
>  		0);
>  
>  static ssize_t adt7316_show_powerdown(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				      struct device_attribute *attr,
> +				      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -588,8 +588,8 @@ static IIO_DEVICE_ATTR(powerdown, S_IRUGO | S_IWUSR,
>  		0);
>  
>  static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					  struct device_attribute *attr,
> +					  char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> 

