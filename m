Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49622 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaAKQJ1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 11:09:27 -0500
Message-ID: <52D16CC0.90509@kernel.org>
Date: Sat, 11 Jan 2014 16:09:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] iio:magnetometer:mag3110: Fix initialization of ctrl_reg1
References: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net> <1389391163-9622-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389391163-9622-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10/01/14 21:59, Peter Meerwald wrote:
> DR bits need to be shifted; since MAG3110_CTRL_DR_DEFAULT is
> zero, the change has no effect
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Again, I'll hold this one for after the fixes are in.

Thanks,

Jonathan
> ---
>   drivers/iio/magnetometer/mag3110.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index 02e4f97..9e774de 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -339,7 +339,7 @@ static int mag3110_probe(struct i2c_client *client,
>   	indio_dev->num_channels = ARRAY_SIZE(mag3110_channels);
>   	indio_dev->available_scan_masks = mag3110_scan_masks;
>
> -	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT;
> +	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT << MAG3110_CTRL_DR_SHIFT;
>   	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG1,
>   		data->ctrl_reg1);
>   	if (ret < 0)
>
