Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751793AbdGAMHA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 08:07:00 -0400
Date: Sat, 1 Jul 2017 13:06:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Reno Farnesi <nfarnesi4@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: sca3000: Remove trailing whitespace
Message-ID: <20170701130656.6e42f672@kernel.org>
In-Reply-To: <1498527922.31066.3.camel@gmail.com>
References: <1498527922.31066.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Jun 2017 21:45:22 -0400
Reno Farnesi <nfarnesi4@gmail.com> wrote:

> Removes trailing whitespace to fix checkpatch errors
> 
> Signed-off-by: Reno Farnesi <nfarnesi4@gmail.com>
Hi Reno,

Your patch doesn't apply as your email client as line wrapped it.
Please see the hints in Documentation/process/email-clients.rst

Actual change is good though and description is fine - so just
the email client bit needs sorting.

I've fixed it up and applied the patch to the togreg branch of
iio.git which is initially pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/sca3000.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index cb1d83fa19a0..39ab210c44f6 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -36,7 +36,7 @@
>  #define   SCA3000_LOCKED				BIT(5)
>  #define   SCA3000_EEPROM_CS_ERROR			BIT(1)
>  #define   SCA3000_SPI_FRAME_ERROR			BIT(0)
> - 
> +
>  /* All reads done using register decrement so no need to 
> directly access LSBs */
>  #define SCA3000_REG_X_MSB_ADDR				0x05
>  #define SCA3000_REG_Y_MSB_ADDR				0x07
> @@ -74,7 +74,7 @@
>  #define SCA3000_REG_INT_STATUS_ADDR			0x16
>  #define   SCA3000_REG_INT_STATUS_THREE_QUARTERS		BIT(7)
>  #define   SCA3000_REG_INT_STATUS_HALF			BIT(6)
> -	
> +
>  #define SCA3000_INT_STATUS_FREE_FALL			BIT(3)
>  #define SCA3000_INT_STATUS_Y_TRIGGER			BIT(2)
>  #define SCA3000_INT_STATUS_X_TRIGGER			BIT(1)
> @@ -124,7 +124,7 @@
>  
>  #define SCA3000_REG_INT_MASK_ADDR			0x21
>  #define   SCA3000_REG_INT_MASK_PROT_MASK		0x1C
> - 
> +
>  #define   SCA3000_REG_INT_MASK_RING_THREE_QUARTER	BIT(7)
>  #define   SCA3000_REG_INT_MASK_RING_HALF		BIT(6)
>  

