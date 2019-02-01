Return-Path: <SRS0=jBoM=QI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2DFC282D8
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9BB20823
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 11:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfBALYN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:24:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbfBALYN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Feb 2019 06:24:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7F81693D022A36219DA0;
        Fri,  1 Feb 2019 19:24:11 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 19:24:09 +0800
Date:   Fri, 1 Feb 2019 11:24:01 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Beniamin Bia <biabeniamin@gmail.com>
CC:     <linux-iio@vger.kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH 1/2] staging: iio: frequency: ad9833: Get frequency
 value statically
Message-ID: <20190201112401.00005d16@huawei.com>
In-Reply-To: <20190201093638.26068-1-biabeniamin@gmail.com>
References: <20190201093638.26068-1-biabeniamin@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Feb 2019 11:36:37 +0200
Beniamin Bia <biabeniamin@gmail.com> wrote:

> The value of frequency is taken from ad9834.c instead of platform data

Why?  I would rather see this move over to DT than take aways the flexibility
that was previously there.

Jonathan

> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  drivers/staging/iio/frequency/ad9834.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 995acdd7c942..d92d4bf71261 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -99,6 +99,16 @@ enum ad9834_supported_device_ids {
>  	ID_AD9838,
>  };
>  
> +static struct ad9834_platform_data default_config = {
> +	.mclk = 25000000,
> +	.freq0 = 1000000,
> +	.freq1 = 5000000,
> +	.phase0 = 512,
> +	.phase1 = 1024,
> +	.en_div2 = false,
> +	.en_signbit_msb_out = false,
> +};
> +
>  static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
> @@ -391,16 +401,13 @@ static const struct iio_info ad9833_info = {
>  
>  static int ad9834_probe(struct spi_device *spi)
>  {
> -	struct ad9834_platform_data *pdata = dev_get_platdata(&spi->dev);
> +	struct ad9834_platform_data *pdata;
>  	struct ad9834_state *st;
>  	struct iio_dev *indio_dev;
>  	struct regulator *reg;
>  	int ret;
>  
> -	if (!pdata) {
> -		dev_dbg(&spi->dev, "no platform data?\n");
> -		return -ENODEV;
> -	}
> +	pdata = &default_config;
>  
>  	reg = devm_regulator_get(&spi->dev, "avdd");
>  	if (IS_ERR(reg))


