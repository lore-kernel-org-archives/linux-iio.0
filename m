Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbdGVUVX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jul 2017 16:21:23 -0400
Date: Sat, 22 Jul 2017 21:21:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 05/10] iio: humidity: hts221: squash
 hts221_power_on/off in hts221_set_enable
Message-ID: <20170722212119.016f86f6@kernel.org>
In-Reply-To: <20170717173905.8209-6-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-6-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 19:39:00 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/hts221.h        |  3 +--
>  drivers/iio/humidity/hts221_buffer.c |  4 ++--
>  drivers/iio/humidity/hts221_core.c   | 24 +++++-------------------
>  3 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index bf33d8f6396c..69dfa5c63ec2 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -62,8 +62,7 @@ extern const struct dev_pm_ops hts221_pm_ops;
>  
>  int hts221_config_drdy(struct hts221_hw *hw, bool enable);
>  int hts221_probe(struct iio_dev *iio_dev);
> -int hts221_power_on(struct hts221_hw *hw);
> -int hts221_power_off(struct hts221_hw *hw);
> +int hts221_set_enable(struct hts221_hw *hw, bool enable);
>  int hts221_allocate_buffers(struct hts221_hw *hw);
>  int hts221_allocate_trigger(struct hts221_hw *hw);
>  
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 7d19a3da7ab7..c4ed153ad397 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -109,12 +109,12 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  
>  static int hts221_buffer_preenable(struct iio_dev *iio_dev)
>  {
> -	return hts221_power_on(iio_priv(iio_dev));
> +	return hts221_set_enable(iio_priv(iio_dev), true);
>  }
>  
>  static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
>  {
> -	return hts221_power_off(iio_priv(iio_dev));
> +	return hts221_set_enable(iio_priv(iio_dev), false);
>  }
>  
>  static const struct iio_buffer_setup_ops hts221_buffer_ops = {
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index f99adc44139e..dc55d9fbc702 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -285,30 +285,16 @@ hts221_sysfs_temp_oversampling_avail(struct device *dev,
>  	return len;
>  }
>  
> -int hts221_power_on(struct hts221_hw *hw)
> +int hts221_set_enable(struct hts221_hw *hw, bool enable)
>  {
>  	int err;
>  
>  	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_ENABLE_MASK, true);
> +				     HTS221_ENABLE_MASK, enable);
>  	if (err < 0)
>  		return err;
>  
> -	hw->enabled = true;
> -
> -	return 0;
> -}
> -
> -int hts221_power_off(struct hts221_hw *hw)
> -{
> -	int err;
> -
> -	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_ENABLE_MASK, false);
> -	if (err < 0)
> -		return err;
> -
> -	hw->enabled = false;
> +	hw->enabled = enable;
>  
>  	return 0;
>  }
> @@ -463,7 +449,7 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>  	u8 data[HTS221_DATA_SIZE];
>  	int err;
>  
> -	err = hts221_power_on(hw);
> +	err = hts221_set_enable(hw, true);
>  	if (err < 0)
>  		return err;
>  
> @@ -473,7 +459,7 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>  	if (err < 0)
>  		return err;
>  
> -	hts221_power_off(hw);
> +	hts221_set_enable(hw, false);
>  
>  	*val = (s16)get_unaligned_le16(data);
>  

