Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50100 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329AbbEWLC6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 07:02:58 -0400
Message-ID: <55605E5E.3070107@kernel.org>
Date: Sat, 23 May 2015 12:02:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: light: Updated Vishay Capella cm32181 ambient
 light sensor driver.
References: <1432268380-7302-1-git-send-email-ktsai@capellamicro.com> <1432268380-7302-2-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1432268380-7302-2-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/15 05:19, Kevin Tsai wrote:
> - Added cm32181_als_info structure.
> 
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
Comments inline.  The big one is that you have broken the abilty
to have more than one sensor supported by this driver on a given
machine.  Don't do that!

Jonathan
> ---
>  drivers/iio/light/cm32181.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 0491d73..6b11145 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -48,6 +48,7 @@
>  #define CM32181_ALS_WL_DEFAULT		0x0000
>  
>  /* Software parameters */
> +#define CM32181_HW_ID			0x81
>  #define CM32181_MLUX_PER_BIT		5	/* ALS_SM=01 IT=800ms */
>  #define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
>  #define	CM32181_CALIBSCALE_DEFAULT	1000
> @@ -58,11 +59,31 @@ static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
>  static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
>  	800000};
>  
> +struct cm32181_als_info {
> +	u8 hw_id;
> +	u16 reg_cmd;
> +	u16 reg_als_wh;
> +	u16 reg_als_wl;
> +	int calibscale;
> +	int mlux_per_bit;
> +	int mlux_per_bit_base_it;
Introduce element into here, only when they are actually used.
> +};
> +
const - 
> +static struct cm32181_als_info cm32181_als_info_default = {
> +	.hw_id = CM32181_HW_ID,
Given you elsewhere represent these next 3 as an array, I'd
be consistent and do this here as well.  Then you can just use a
loop to assign them when needed.
> +	.reg_cmd = CM32181_CMD_DEFAULT,
> +	.reg_als_wh = CM32181_ALS_WH_DEFAULT,
> +	.reg_als_wl = CM32181_ALS_WL_DEFAULT,
> +	.calibscale = CM32181_CALIBSCALE_DEFAULT,
> +	.mlux_per_bit = CM32181_MLUX_PER_BIT,
> +	.mlux_per_bit_base_it = CM32181_MLUX_PER_BIT_BASE_IT,
> +};
> +
>  struct cm32181_chip {
>  	struct i2c_client *client;
>  	struct mutex lock;
> +	struct cm32181_als_info *als_info;
>  	u16 conf_regs[CM32181_CONF_REG_NUM];
> -	int calibscale;
Leave calibscale here as this is the data that changes, wherease
the als_info stuff is fixed.
>  };
>  
>  /**
> @@ -76,22 +97,25 @@ struct cm32181_chip {
>  static int cm32181_reg_init(struct cm32181_chip *chip)
>  {
>  	struct i2c_client *client = chip->client;
> +	struct cm32181_als_info *als_info;
>  	int i;
>  	s32 ret;
>  
> +	chip->als_info = &cm32181_als_info_default;
> +	als_info = chip->als_info;
Don't do this.  Either it's static data or it isn't.  You've
just prevented people having two of these sensors on a single machine..
If you want to use this structure, then make a copy of it.

> +
>  	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ID);
>  	if (ret < 0)
>  		return ret;
>  
>  	/* check device ID */
> -	if ((ret & 0xFF) != 0x81)
> +	if ((ret & 0xFF) != als_info->hw_id)
>  		return -ENODEV;
>  
>  	/* Default Values */
> -	chip->conf_regs[CM32181_REG_ADDR_CMD] = CM32181_CMD_DEFAULT;
> -	chip->conf_regs[CM32181_REG_ADDR_ALS_WH] = CM32181_ALS_WH_DEFAULT;
> -	chip->conf_regs[CM32181_REG_ADDR_ALS_WL] = CM32181_ALS_WL_DEFAULT;
> -	chip->calibscale = CM32181_CALIBSCALE_DEFAULT;
> +	chip->conf_regs[CM32181_REG_ADDR_CMD] = als_info->reg_cmd;
> +	chip->conf_regs[CM32181_REG_ADDR_ALS_WH] = als_info->reg_als_wh;
> +	chip->conf_regs[CM32181_REG_ADDR_ALS_WL] = als_info->reg_als_wl;
>  
>  	/* Initialize registers*/
>  	for (i = 0; i < CM32181_CONF_REG_NUM; i++) {
> @@ -197,7 +221,7 @@ static int cm32181_get_lux(struct cm32181_chip *chip)
>  		return ret;
>  
>  	lux *= ret;
> -	lux *= chip->calibscale;
> +	lux *= chip->als_info->calibscale;
>  	lux /= CM32181_CALIBSCALE_RESOLUTION;
>  	lux /= MLUX_PER_LUX;
>  
> @@ -222,7 +246,7 @@ static int cm32181_read_raw(struct iio_dev *indio_dev,
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> -		*val = chip->calibscale;
> +		*val = chip->als_info->calibscale;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		*val = 0;
> @@ -242,7 +266,7 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBSCALE:
> -		chip->calibscale = val;
> +		chip->als_info->calibscale = val;

>  		return val;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		ret = cm32181_write_als_it(chip, val2);
> 

