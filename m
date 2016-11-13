Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40542 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbcKMM2w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:28:52 -0500
Subject: Re: [PATCH v4 21/26] staging: iio: tsl2583: clarified comment about
 clearing interrupts
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-22-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d728b522-3766-3ad6-7086-0f7cc8c059dc@kernel.org>
Date: Sun, 13 Nov 2016 12:28:50 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-22-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> The comment that describes the code that clears the interrupt bit was
> vague and didn't provide much value. This patch adds more detail about
> why that bit needs to be cleared.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 806cb0a..727ed49 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -205,8 +205,9 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
>  	}
>  
>  	/*
> -	 * clear status, really interrupt status (interrupts are off), but
> -	 * we use the bit anyway - don't forget 0x80 - this is a command
> +	 * Clear the pending interrupt status bit on the chip to allow the next
> +	 * integration cycle to start. This has to be done even though this
> +	 * driver currently does not support interrupts.
>  	 */
>  	ret = i2c_smbus_write_byte(chip->client,
>  				   (TSL2583_CMD_REG | TSL2583_CMD_SPL_FN |
> 

