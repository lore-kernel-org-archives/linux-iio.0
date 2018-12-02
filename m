Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14DC04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A9520881
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1z9b0H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A9520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbeLBPrx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLBPrx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Dec 2018 10:47:53 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 936302082F;
        Sun,  2 Dec 2018 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543765671;
        bh=iwmLJPymiH4C1jgCR5l6kneEY64SIsu1IdyhFRhes40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I1z9b0H6tnd/I131Q+EwoVwhWlgsoryfmQnvZkbWvY1t4jwKwscdeuTs3AZ5DF7Ft
         YMUu5NNM9b7idLY81Pn8EIJGAGTs9qXgNkdTFcvk+0iEkoTTCdpKySob89RI2I4alh
         mIe88ajZO6AObhFWrtDJSASvchnsGFXB/xlT5PVc=
Date:   Sun, 2 Dec 2018 15:47:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 3/3] staging: iio: adc: ad7280a: add braces to complex
 for loops
Message-ID: <20181202154748.17100d9a@archlinux>
In-Reply-To: <20181202115830.20363-4-sst@poczta.fm>
References: <20181202115830.20363-1-sst@poczta.fm>
        <20181202115830.20363-4-sst@poczta.fm>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  2 Dec 2018 12:58:30 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> These for loops have just only one instruction as its body. However this
> body is complex, so add braces to them.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
This is fine.  I'll pick it up when 1 and 2 are updated.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 6faa85bf6f7e..6ec5a0d2a438 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -574,7 +574,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  	if (!st->channels)
>  		return -ENOMEM;
>  
> -	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
> +	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++) {
>  		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6;
>  			ch++, cnt++) {
>  			if (ch < AD7280A_AUX_ADC_1)
> @@ -584,6 +584,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  
>  			ad7280_common_fields_init(st, cnt, dev, ch);
>  		}
> +	}
>  
>  	ad7280_all_voltage_channel_init(st, cnt, dev);
>  	cnt++;
> @@ -642,7 +643,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  	if (!st->iio_attr)
>  		return -ENOMEM;
>  
> -	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
> +	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++) {
>  		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
>  			ch++, cnt++) {
>  			ret = ad7280_balance_switch_attr_init(st, cnt, dev, ch);
> @@ -654,6 +655,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  			if (ret < 0)
>  				return ret;
>  		}
> +	}
>  
>  	ad7280_attributes[cnt] = NULL;
>  

