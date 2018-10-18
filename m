Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50056 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJSBdn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 21:33:43 -0400
Subject: Re: [PATCH v2 1/1] staging: iio: adc: ad7280a: use crc8.h API to
 build crc table
To: Slawomir Stepien <sst@poczta.fm>, Michael.Hennerich@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
References: <20181018114915.GA30276@x220.localdomain>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ef781380-2306-fb2a-8a9c-f95b23e59b0e@metafoo.de>
Date: Thu, 18 Oct 2018 19:31:13 +0200
MIME-Version: 1.0
In-Reply-To: <20181018114915.GA30276@x220.localdomain>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2018 01:49 PM, Slawomir Stepien wrote:
> The custom build function ad7280_crc8_build_table is not needed. The
> crc8_populate_msb function from linux/crc8.h will build the same crc
> table.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>

This looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

I supposed the code could be improved a bit further in a follow up patch by
only having one global table since it will be the same for all instances.

> ---
> Since v1:
> * Fix typo in commit message.
> ---
>  drivers/staging/iio/adc/ad7280a.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index b736275c10f5..c701f07853fa 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -6,6 +6,7 @@
>   * Licensed under the GPL-2.
>   */
>  
> +#include <linux/crc8.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -121,8 +122,6 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
>   * P(x) = x^8 + x^5 + x^3 + x^2 + x^1 + x^0 = 0b100101111 => 0x2F
>   */
>  #define POLYNOM		0x2F
> -#define POLYNOM_ORDER	8
> -#define HIGHBIT		(1 << (POLYNOM_ORDER - 1))
>  
>  struct ad7280_state {
>  	struct spi_device		*spi;
> @@ -131,7 +130,7 @@ struct ad7280_state {
>  	int				slave_num;
>  	int				scan_cnt;
>  	int				readback_delay_us;
> -	unsigned char			crc_tab[256];
> +	unsigned char			crc_tab[CRC8_TABLE_SIZE];
>  	unsigned char			ctrl_hb;
>  	unsigned char			ctrl_lb;
>  	unsigned char			cell_threshhigh;
> @@ -144,23 +143,6 @@ struct ad7280_state {
>  	__be32				buf[2] ____cacheline_aligned;
>  };
>  
> -static void ad7280_crc8_build_table(unsigned char *crc_tab)
> -{
> -	unsigned char bit, crc;
> -	int cnt, i;
> -
> -	for (cnt = 0; cnt < 256; cnt++) {
> -		crc = cnt;
> -		for (i = 0; i < 8; i++) {
> -			bit = crc & HIGHBIT;
> -			crc <<= 1;
> -			if (bit)
> -				crc ^= POLYNOM;
> -		}
> -		crc_tab[cnt] = crc;
> -	}
> -}
> -
>  static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
>  {
>  	unsigned char crc;
> @@ -857,7 +839,7 @@ static int ad7280_probe(struct spi_device *spi)
>  	if (!pdata)
>  		pdata = &ad7793_default_pdata;
>  
> -	ad7280_crc8_build_table(st->crc_tab);
> +	crc8_populate_msb(st->crc_tab, POLYNOM);
>  
>  	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
>  	st->spi->mode = SPI_MODE_1;
> 
