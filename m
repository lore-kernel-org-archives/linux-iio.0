Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42572 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbDZSti (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:49:38 -0400
Message-ID: <553D3341.7000202@kernel.org>
Date: Sun, 26 Apr 2015 19:49:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 11/17] iio: accel: mma9553: prefix naming fixes
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-12-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-12-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> Add mma9553_ prefix to all local functions/declarations.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
app
> ---
>  drivers/iio/accel/mma9553.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 47cb14b..9573147 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -76,8 +76,8 @@
>  #define MMA9553_DEFAULT_GPIO_PIN	mma9551_gpio6
>  #define MMA9553_DEFAULT_GPIO_POLARITY	0
>  
> -#define STATUS_TO_BITNUM(bit)		(ffs(bit) - 9)
>  /* Bitnum used for GPIO configuration = bit number in high status byte */
> +#define MMA9553_STATUS_TO_BITNUM(bit)	(ffs(bit) - 9)
>  
>  #define MMA9553_DEFAULT_SAMPLE_RATE	30	/* Hz */
>  
> @@ -351,11 +351,11 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
>  	 * This bit is the logical OR of the SUSPCHG, STEPCHG, and ACTCHG flags.
>  	 */
>  	if (activity_enabled && ev_step_detect->enabled)
> -		bitnum = STATUS_TO_BITNUM(MMA9553_MASK_STATUS_MRGFL);
> +		bitnum = MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_MRGFL);
>  	else if (ev_step_detect->enabled)
> -		bitnum = STATUS_TO_BITNUM(MMA9553_MASK_STATUS_STEPCHG);
> +		bitnum = MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_STEPCHG);
>  	else if (activity_enabled)
> -		bitnum = STATUS_TO_BITNUM(MMA9553_MASK_STATUS_ACTCHG);
> +		bitnum = MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_ACTCHG);
>  	else			/* Reset */
>  		appid = MMA9551_APPID_NONE;
>  
> @@ -948,11 +948,11 @@ static const struct iio_event_spec mma9553_activity_events[] = {
>  	},
>  };
>  
> -static const char * const calibgender_modes[] = { "male", "female" };
> +static const char * const mma9553_calibgender_modes[] = { "male", "female" };
>  
>  static const struct iio_enum mma9553_calibgender_enum = {
> -	.items = calibgender_modes,
> -	.num_items = ARRAY_SIZE(calibgender_modes),
> +	.items = mma9553_calibgender_modes,
> +	.num_items = ARRAY_SIZE(mma9553_calibgender_modes),
>  	.get = mma9553_get_calibgender_mode,
>  	.set = mma9553_set_calibgender_mode,
>  };
> 

