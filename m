Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35833 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcEDOj2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:39:28 -0400
Subject: Re: [PATCH 2/3] iio: bmi160: Fix ODR setting
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
 <1461930155-13871-3-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <df9ec160-714b-72b7-cd9a-67bdd3092c89@kernel.org>
Date: Wed, 4 May 2016 10:51:03 +0100
MIME-Version: 1.0
In-Reply-To: <1461930155-13871-3-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/16 12:42, Daniel Baluta wrote:
> mask and val parameters of regmap_update_bits were reveresed.
> 
> Fixes: 77c4ad2d6a9 ("iio: imu: Add initial support for Bosch BMI160")
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git.

Not pushed out as anything at all yet.

Jonathan
> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index cd9b75e..b8a290e 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -364,8 +364,8 @@ int bmi160_set_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
>  
>  	return regmap_update_bits(data->regmap,
>  				  bmi160_regs[t].config,
> -				  bmi160_odr_table[t].tbl[i].bits,
> -				  bmi160_regs[t].config_odr_mask);
> +				  bmi160_regs[t].config_odr_mask,
> +				  bmi160_odr_table[t].tbl[i].bits);
>  }
>  
>  static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
> 

