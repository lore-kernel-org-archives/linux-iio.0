Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33216 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab3AARni (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jan 2013 12:43:38 -0500
Message-ID: <50E32049.8040508@kernel.org>
Date: Tue, 01 Jan 2013 17:43:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: max1363 comment and whitespace fixes
References: <1356910018-14422-1-git-send-email-pmeerw@pmeerw.net> <1356910018-14422-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1356910018-14422-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/30/2012 11:26 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/adc/max1363.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 46d8365..0ba4fea 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -56,7 +56,7 @@
>  #define MAX1363_SETUP_POWER_UP_INT_REF		0x10
>  #define MAX1363_SETUP_POWER_DOWN_INT_REF	0x00
>  
> -/* think about includeing max11600 etc - more settings */
> +/* think about including max11600 etc - more settings */
>  #define MAX1363_SETUP_EXT_CLOCK			0x08
>  #define MAX1363_SETUP_INT_CLOCK			0x00
>  #define MAX1363_SETUP_UNIPOLAR			0x00
> @@ -87,7 +87,7 @@
>  /* max123{6-9} only */
>  #define MAX1236_SCAN_MID_TO_CHANNEL		0x40
>  
> -/* max1363 only - merely part of channel selects or don't care for others*/
> +/* max1363 only - merely part of channel selects or don't care for others */
>  #define MAX1363_CONFIG_EN_MON_MODE_READ 0x18
>  
>  #define MAX1363_CHANNEL_SEL(a) ((a) << 1)
> @@ -134,7 +134,7 @@ enum max1363_modes {
>   * @mode_list:		array of available scan modes
>   * @default_mode:	the scan mode in which the chip starts up
>   * @int_vref_mv:	the internal reference voltage
> - * @num_channels:	number of channels
> + * @num_modes:		number of modes
>   * @bits:		accuracy of the adc in bits
>   */
>  struct max1363_chip_info {
> @@ -153,7 +153,7 @@ struct max1363_chip_info {
>   * @client:		i2c_client
>   * @setupbyte:		cache of current device setup byte
>   * @configbyte:		cache of current device config byte
> - * @chip_info:		chip model specific constants, available modes etc
> + * @chip_info:		chip model specific constants, available modes, etc.
>   * @current_mode:	the scan mode of this chip
>   * @requestedmask:	a valid requested set of channels
>   * @reg:		supply regulator
> @@ -294,7 +294,7 @@ static const struct max1363_mode max1363_mode_table[] = {
>  
>  static const struct max1363_mode
>  *max1363_match_mode(const unsigned long *mask,
> -const struct max1363_chip_info *ci)
> +	const struct max1363_chip_info *ci)
>  {
>  	int i;
>  	if (mask)
> @@ -1395,7 +1395,7 @@ static int max1363_initial_setup(struct max1363_state *st)
>  		| MAX1363_SETUP_UNIPOLAR
>  		| MAX1363_SETUP_NORESET;
>  
> -	/* Set scan mode writes the config anyway so wait until then*/
> +	/* Set scan mode writes the config anyway so wait until then */
>  	st->setupbyte = MAX1363_SETUP_BYTE(st->setupbyte);
>  	st->current_mode = &max1363_mode_table[st->chip_info->default_mode];
>  	st->configbyte = MAX1363_CONFIG_BYTE(st->configbyte);
> @@ -1424,7 +1424,6 @@ static int __devinit max1363_alloc_scan_masks(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -
>  static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -1523,7 +1522,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	/* Estabilish that the iio_dev is a child of the i2c device */
> +	/* Establish that the iio_dev is a child of the i2c device */
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->name = id->name;
>  	indio_dev->channels = st->chip_info->channels;
> 
