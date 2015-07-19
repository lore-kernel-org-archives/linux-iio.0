Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46332 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbbGSKyN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 06:54:13 -0400
Message-ID: <55AB81D2.5060409@kernel.org>
Date: Sun, 19 Jul 2015 11:54:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: viorel.suman@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: magnetometer: mmc35240: Fix SET/RESET mask
References: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com> <1436885814-29155-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1436885814-29155-3-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/07/15 15:56, Daniel Baluta wrote:
> This fixes setting the SET/RESET bit in the REG_CTRL0
> register.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the fixes-togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/magnetometer/mmc35240.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index e89b059..f4d7495 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -195,8 +195,8 @@ static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
>  		coil_bit = MMC35240_CTRL0_RESET_BIT;
>  
>  	return regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
> -				  MMC35240_CTRL0_REFILL_BIT,
> -				  coil_bit);
> +				  coil_bit, coil_bit);
> +
>  }
>  
>  static int mmc35240_init(struct mmc35240_data *data)
> 

