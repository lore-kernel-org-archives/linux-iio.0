Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42538 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbbDZSq5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:46:57 -0400
Message-ID: <553D329F.50800@kernel.org>
Date: Sun, 26 Apr 2015 19:46:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 06/17] iio: accel: mma9551_core: typo fix in RSC APP
 ID
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-7-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-7-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> Fix typo in Reset/Suspend/Clear Application ID definition.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/accel/mma9551_core.c | 2 +-
>  drivers/iio/accel/mma9551_core.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index efe09a3..2fd2a99 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -800,7 +800,7 @@ EXPORT_SYMBOL(mma9551_read_accel_scale);
>   */
>  int mma9551_app_reset(struct i2c_client *client, u32 app_mask)
>  {
> -	return mma9551_write_config_byte(client, MMA9551_APPID_RCS,
> +	return mma9551_write_config_byte(client, MMA9551_APPID_RSC,
>  					 MMA9551_RSC_RESET +
>  					 MMA9551_RSC_OFFSET(app_mask),
>  					 MMA9551_RSC_VAL(app_mask));
> diff --git a/drivers/iio/accel/mma9551_core.h b/drivers/iio/accel/mma9551_core.h
> index edaa56b..79939e4 100644
> --- a/drivers/iio/accel/mma9551_core.h
> +++ b/drivers/iio/accel/mma9551_core.h
> @@ -22,7 +22,7 @@
>  #define MMA9551_APPID_TILT		0x0B
>  #define MMA9551_APPID_SLEEP_WAKE	0x12
>  #define MMA9551_APPID_PEDOMETER	        0x15
> -#define MMA9551_APPID_RCS		0x17
> +#define MMA9551_APPID_RSC		0x17
>  #define MMA9551_APPID_NONE		0xff
>  
>  /* Reset/Suspend/Clear application app masks */
> 

