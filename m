Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51228 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbaECKZz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:25:55 -0400
Message-ID: <5364C490.20805@kernel.org>
Date: Sat, 03 May 2014 11:27:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio:magnetometer:mag3110: Fix initialization of ctrl_reg1
References: <1399018187-29742-1-git-send-email-pmeerw@pmeerw.net> <1399018187-29742-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399018187-29742-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 09:09, Peter Meerwald wrote:
> DR bits need to be shifted; since MAG3110_CTRL_DR_DEFAULT is
> zero, the change has no effect
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Gah, my careful colour coding of patches went astray on these two so I
lost them.  Thanks for the reminder.

Applied to the togreg branch of iio.git

J
> ---
>   drivers/iio/magnetometer/mag3110.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index 8b77782..1b2df75 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -338,7 +338,7 @@ static int mag3110_probe(struct i2c_client *client,
>   	indio_dev->num_channels = ARRAY_SIZE(mag3110_channels);
>   	indio_dev->available_scan_masks = mag3110_scan_masks;
>
> -	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT;
> +	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT << MAG3110_CTRL_DR_SHIFT;
>   	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG1,
>   		data->ctrl_reg1);
>   	if (ret < 0)
>

