Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55819 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbaINRsD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 13:48:03 -0400
Message-ID: <5415D4D0.3080707@kernel.org>
Date: Sun, 14 Sep 2014 18:48:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH v2 03/11] iio:bma180: Rename BMA_180 to BMA180_
References: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net> <1408488206-2633-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1408488206-2633-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/08/14 23:43, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Applied.
> ---
>  drivers/iio/accel/bma180.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index d7f34b4..284598d 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -56,7 +56,7 @@
>  /* We have to write this value in reset register to do soft reset */
>  #define BMA180_RESET_VAL	0xb6
>  
> -#define BMA_180_ID_REG_VAL	0x03
> +#define BMA180_ID_REG_VAL	0x03
>  
>  /* Chip power modes */
>  #define BMA180_LOW_NOISE	0x00
> @@ -258,7 +258,7 @@ static int bma180_chip_init(struct bma180_data *data)
>  
>  	if (ret < 0)
>  		goto err;
> -	if (ret != BMA_180_ID_REG_VAL) {
> +	if (ret != BMA180_ID_REG_VAL) {
>  		ret = -ENODEV;
>  		goto err;
>  	}
> 
