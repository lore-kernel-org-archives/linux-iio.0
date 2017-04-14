Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56202 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdDNOHP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 10:07:15 -0400
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: simplify data ready pin parsing
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170409180337.12717-1-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b961419e-4151-788a-e258-a94e4177f54f@kernel.org>
Date: Fri, 14 Apr 2017 15:07:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170409180337.12717-1-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/04/17 19:03, Lorenzo Bianconi wrote:
> Simplify st_lsm6dsx_of_get_drdy_pin routine since of_property_read_u32
> error conditions are already managed in st_lsm6dsx_get_drdy_reg()
> 
> Fixes: dba329048ee5 (iio: imu: st_lsm6dsx: add possibility to select drdy pin)
Not really a fix that I can see.  Adding this tag encourages people to pick this
up for stable branches which isn't appropriate for a cleanup like this.
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 98b51d7..462a27b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -559,19 +559,11 @@ static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
>  static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
>  {
>  	struct device_node *np = hw->dev->of_node;
> -	int err;
>  
>  	if (!np)
>  		return -EINVAL;
>  
> -	err = of_property_read_u32(np, "st,drdy-int-pin", drdy_pin);
> -	if (err == -ENODATA) {
> -		/* if the property has not been specified use default value */
> -		*drdy_pin = 1;
> -		err = 0;
> -	}
> -
> -	return err;
> +	return of_property_read_u32(np, "st,drdy-int-pin", drdy_pin);
Does this not result in problems if the pin isn't specified?
There may be devicetrees out there relying on defaulting to 1.

Jonathan


>  }
>  
>  static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
> 

