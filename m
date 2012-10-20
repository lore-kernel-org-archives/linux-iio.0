Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35993 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab2JTJtU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Oct 2012 05:49:20 -0400
Message-ID: <5082739E.1000800@kernel.org>
Date: Sat, 20 Oct 2012 10:49:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Derek Basehore <dbasehore@chromium.org>
CC: jic23@cam.ac.uk, bleung@chromium.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jon Brenner - TAOS <jbrenner@taosinc.com>
Subject: Re: [PATCH] tsl2563: fixed bug with disabling interrupts
References: <1349394896-4856-1-git-send-email-dbasehore@chromium.org>
In-Reply-To: <1349394896-4856-1-git-send-email-dbasehore@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

cc'd iio mailing list and Jon Brenner.
Being lazy I haven't dug out the datahsheet to check this (my board has a broken
track to the interrupt line so can't easily test this!)

> In tsl_2563_write_interrupt_config and tsl2562_remove, interrupts are not
> disabled where they should be. This seems to be from a mistake of using |=
> instead of &= in 2 lines of code.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/staging/iio/light/tsl2563.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
> index 954ca2c..3f72543 100644
> --- a/drivers/staging/iio/light/tsl2563.c
> +++ b/drivers/staging/iio/light/tsl2563.c
> @@ -652,7 +652,7 @@ static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
>  	}
>  
>  	if (!state && (chip->intr & 0x30)) {
> -		chip->intr |= ~0x30;
> +		chip->intr &= ~0x30;
>  		ret = i2c_smbus_write_byte_data(chip->client,
>  						TSL2563_CMD | TSL2563_REG_INT,
>  						chip->intr);
> @@ -814,7 +814,7 @@ static int __devexit tsl2563_remove(struct i2c_client *client)
>  	if (!chip->int_enabled)
>  		cancel_delayed_work(&chip->poweroff_work);
>  	/* Ensure that interrupts are disabled - then flush any bottom halves */
> -	chip->intr |= ~0x30;
> +	chip->intr &= ~0x30;
>  	i2c_smbus_write_byte_data(chip->client, TSL2563_CMD | TSL2563_REG_INT,
>  				  chip->intr);
>  	flush_scheduled_work();
> 
