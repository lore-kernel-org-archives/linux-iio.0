Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56672 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbcCERXJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 12:23:09 -0500
Subject: Re: [PATCH 2/4] iio: mma8452: avoid switching to active because of
 config change
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1456993444-21320-1-git-send-email-martink@posteo.de>
 <1456993444-21320-3-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB15FB.20308@kernel.org>
Date: Sat, 5 Mar 2016 17:23:07 +0000
MIME-Version: 1.0
In-Reply-To: <1456993444-21320-3-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 08:24, Martin Kepplinger wrote:
> The devices' config registers can only be changed in standby mode.
> Up until now the driver just held the device *always* active, so for
> changing a config it was *always* necessary to switch to standby.
> 
> For upcoming support for runtime pm, the device can as well be in standby
> mode. Instead of putting runtime pm functions in there, just keep the
> device in standby if it already is. This section is protected by a lock
> after all.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Applied to the togreg branch of iio.git - initially pushed out as testing

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 17d72bc..9c4a84a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -393,24 +393,47 @@ static int mma8452_active(struct mma8452_data *data)
>  					 data->ctrl_reg1);
>  }
>  
> +/* returns >0 if active, 0 if in standby and <0 on error */
> +static int mma8452_is_active(struct mma8452_data *data)
> +{
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG1);
> +	if (reg < 0)
> +		return reg;
> +
> +	return reg & MMA8452_CTRL_ACTIVE;
> +}
> +
>  static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
>  {
>  	int ret;
> +	int is_active;
>  
>  	mutex_lock(&data->lock);
>  
> -	/* config can only be changed when in standby */
> -	ret = mma8452_standby(data);
> -	if (ret < 0)
> +	is_active = mma8452_is_active(data);
> +	if (is_active < 0) {
> +		ret = is_active;
>  		goto fail;
> +	}
> +
> +	/* config can only be changed when in standby */
> +	if (is_active > 0) {
> +		ret = mma8452_standby(data);
> +		if (ret < 0)
> +			goto fail;
> +	}
>  
>  	ret = i2c_smbus_write_byte_data(data->client, reg, val);
>  	if (ret < 0)
>  		goto fail;
>  
> -	ret = mma8452_active(data);
> -	if (ret < 0)
> -		goto fail;
> +	if (is_active > 0) {
> +		ret = mma8452_active(data);
> +		if (ret < 0)
> +			goto fail;
> +	}
>  
>  	ret = 0;
>  fail:
> 

