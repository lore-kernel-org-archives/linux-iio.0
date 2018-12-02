Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0A5C04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1620B20881
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFK6/2B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1620B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLBPrK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:47:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLBPrK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Dec 2018 10:47:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B738B2082F;
        Sun,  2 Dec 2018 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543765625;
        bh=IqC2C+pUjhOjhCD4brnHEBIdWgykmzOpc1Ui5OK1FJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uFK6/2B4apq8kDBkGGElrZMsvWr6e0upZKf6d5adbnx9x/Cl+J2lstXanOnn3iwBO
         BOSqvF/6JEV+rt96aI+vmyAoGjUXmyvECeuzKWY6fkkMVOs6OrCjLh/4jCbxe2k6s6
         texh6x0oCtS8etTx/0LUTKk1ywDNuoWKyJr7t8eo=
Date:   Sun, 2 Dec 2018 15:47:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/3] staging: iio: adc: ad7280a: split
 ad7280_attr_init() to more functions
Message-ID: <20181202154701.160243b9@archlinux>
In-Reply-To: <20181202115830.20363-3-sst@poczta.fm>
References: <20181202115830.20363-1-sst@poczta.fm>
        <20181202115830.20363-3-sst@poczta.fm>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  2 Dec 2018 12:58:29 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> The ad7280_attr_init function has been split into more specific
> functions to increase the code readability.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 79 +++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index a6b1bdd9f372..6faa85bf6f7e 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -592,11 +592,49 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  	return cnt + 1;
>  }
>  
> +static int ad7280_balance_switch_attr_init(struct ad7280_state *st, int cnt,
> +					   int dev, int ch)
> +{
> +	struct iio_dev_attr *attr = &st->iio_attr[cnt];

I would pass this in to the function (and the dev you need below) to make the
scope of what the function is doing more obvious.

> +
> +	attr->address = ad7280a_devaddr(dev) << 8 | ch;
> +	attr->dev_attr.attr.mode = 0644;
> +	attr->dev_attr.show = ad7280_show_balance_sw;
> +	attr->dev_attr.store = ad7280_store_balance_sw;
> +	attr->dev_attr.attr.name = devm_kasprintf(&st->spi->dev, GFP_KERNEL,
> +						  "in%d-in%d_balance_switch_en",
> +						  ch, ch + 1);
> +	if (!attr->dev_attr.attr.name)
> +		return -ENOMEM;
> +
> +	ad7280_attributes[cnt] = &attr->dev_attr.attr;
> +
> +	return 0;
> +}
> +
> +static int ad7280_balance_timer_attr_init(struct ad7280_state *st, int cnt,
> +					  int dev, int ch)
> +{
> +	struct iio_dev_attr *attr = &st->iio_attr[cnt];
> +
> +	attr->address = ad7280a_devaddr(dev) << 8 | (AD7280A_CB1_TIMER + ch);
> +	attr->dev_attr.attr.mode = 0644;
> +	attr->dev_attr.show = ad7280_show_balance_timer;
> +	attr->dev_attr.store = ad7280_store_balance_timer;
> +	attr->dev_attr.attr.name = devm_kasprintf(&st->spi->dev, GFP_KERNEL,
> +						  "in%d-in%d_balance_timer",
> +						  ch, ch + 1);
> +	if (!attr->dev_attr.attr.name)
> +		return -ENOMEM;
> +
> +	ad7280_attributes[cnt] = &attr->dev_attr.attr;
> +
> +	return 0;
> +}
> +
>  static int ad7280_attr_init(struct ad7280_state *st)
>  {
> -	int dev, ch, cnt;
> -	unsigned int index;
> -	struct iio_dev_attr *iio_attr;
> +	int dev, ch, cnt, ret;
>  
>  	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
>  				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
> @@ -607,35 +645,14 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
>  		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
>  			ch++, cnt++) {
> -			iio_attr = &st->iio_attr[cnt];
> -			index = dev * AD7280A_CELLS_PER_DEV + ch;
> -			iio_attr->address = ad7280a_devaddr(dev) << 8 | ch;
> -			iio_attr->dev_attr.attr.mode = 0644;
> -			iio_attr->dev_attr.show = ad7280_show_balance_sw;
> -			iio_attr->dev_attr.store = ad7280_store_balance_sw;
> -			iio_attr->dev_attr.attr.name =
> -				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
> -					       "in%d-in%d_balance_switch_en",
> -					       index, index + 1);
> -			if (!iio_attr->dev_attr.attr.name)
> -				return -ENOMEM;
> -
> -			ad7280_attributes[cnt] = &iio_attr->dev_attr.attr;
> +			ret = ad7280_balance_switch_attr_init(st, cnt, dev, ch);
> +			if (ret < 0)
> +				return ret;
> +
>  			cnt++;
> -			iio_attr = &st->iio_attr[cnt];
> -			iio_attr->address = ad7280a_devaddr(dev) << 8 |
> -				(AD7280A_CB1_TIMER + ch);
> -			iio_attr->dev_attr.attr.mode = 0644;
> -			iio_attr->dev_attr.show = ad7280_show_balance_timer;
> -			iio_attr->dev_attr.store = ad7280_store_balance_timer;
> -			iio_attr->dev_attr.attr.name =
> -				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
> -					       "in%d-in%d_balance_timer",
> -					       index, index + 1);
> -			if (!iio_attr->dev_attr.attr.name)
> -				return -ENOMEM;
> -
> -			ad7280_attributes[cnt] = &iio_attr->dev_attr.attr;
> +			ret = ad7280_balance_timer_attr_init(st, cnt, dev, ch);
> +			if (ret < 0)
> +				return ret;
>  		}
>  
>  	ad7280_attributes[cnt] = NULL;

