Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:52473
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751133AbdINO3A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Sep 2017 10:29:00 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] staging: iio: ad7192: Use the dedicated reset function
To: Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <1505397028-15461-1-git-send-email-stefan.popa@analog.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <1c2f62f5-3a64-29a0-7bbf-8545173530f9@analog.com>
Date: Thu, 14 Sep 2017 16:31:06 +0200
MIME-Version: 1.0
In-Reply-To: <1505397028-15461-1-git-send-email-stefan.popa@analog.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14.09.2017 15:50, Stefan Popa wrote:
> SPI host drivers can use DMA to transfer data, so the buffer should be properly allocated.
> Keeping it on the stack could cause an undefined behavior.
> 
> The dedicated reset function solves this issue.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Well done!


> ---
>   drivers/staging/iio/adc/ad7192.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d11c6de..6150d27 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -223,11 +223,9 @@ static int ad7192_setup(struct ad7192_state *st,
>   	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
>   	unsigned long long scale_uv;
>   	int i, ret, id;
> -	u8 ones[6];
>   
>   	/* reset the serial interface */
> -	memset(&ones, 0xFF, 6);
> -	ret = spi_write(st->sd.spi, &ones, 6);
> +	ret = ad_sd_reset(&st->sd, 48);
>   	if (ret < 0)
>   		goto out;
>   	usleep_range(500, 1000); /* Wait for at least 500us */
> 


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
