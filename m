Return-Path: <SRS0=VRlQ=TS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D6C04AAF
	for <linux-iio@archiver.kernel.org>; Sat, 18 May 2019 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8E82087B
	for <linux-iio@archiver.kernel.org>; Sat, 18 May 2019 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558171188;
	bh=0JHXZ9mVz+dWuL7LdWWg/jqg4El/CVKFTBW7bPvOSUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ypv4a3GNO5ITE2gBv3X3+xU2B8lLb2Jw9Lx6G5epc8chgmjv0SGLKn0+9Lrv7sYRG
	 cyuPq0H2T4LbAwHhb/UBFlrn/21DSuTfhHXXjzCxh4HuKKEcsNCF10V0OW06Esb49+
	 f3Xc7NX5KU2MZFCLY89qoeVyb5b4xGXjRqrccSys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfERJTs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 May 2019 05:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfERJTr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 05:19:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770EF2087E;
        Sat, 18 May 2019 09:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558171186;
        bh=0JHXZ9mVz+dWuL7LdWWg/jqg4El/CVKFTBW7bPvOSUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZYxoZlnYQcOC8GchrtUIf/EdCVZmNAnGV2pyZWFGVGEUNdeleN1vOcruh+nD/bRMx
         5BEzdVnMWME096ojcXwojQdrb1uSGxfW/7AH3vo4rwBybrs31LryB+48+hBrP3fA/l
         z4Wk9sQVHrMQNIi207wkD+eUuvW5yhLd02waGcnY=
Date:   Sat, 18 May 2019 10:19:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Adam Michaelis <adam.michaelis@rockwellcollins.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com
Subject: Re: [PATCH v3 5/5] iio: ad7949: Remove logic for config readback
Message-ID: <20190518101941.00f6f20a@archlinux>
In-Reply-To: <1557759185-167857-5-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
        <1557759185-167857-5-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 May 2019 09:53:05 -0500
Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:

> The AD7949 has a feature to include the configuration register value
> used to generate the ADC sample. This feature is configurable, but do
> not see a good use case for it in the driver (neither did reviewing
> maintainers), so removing the supporting logic in order to simplify the
> driver.
> 
> Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
Excellent.  For reference
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Waiting for Analog review on the whole series.

Thanks,

Jonathan

> ---
> 	V3:
> 	- First version of series with this patch. Maintainers agreed
> 	that this capability of the hardware is not useful and should
> 	be dropped from driver.
> ---
>  drivers/iio/adc/ad7949.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index d67033a008e5..bac16a2f7850 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -102,24 +102,6 @@ static void ad7949_set_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
>  		ad7949_adc->bits_per_word = 8;
>  }
>  
> -static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
> -{
> -	if (!(ad7949_adc->cfg & AD7949_CFG_READBACK))
> -		return true;
> -
> -	return false;
> -}
> -
> -static int ad7949_message_len(struct ad7949_adc_chip *ad7949_adc)
> -{
> -	int tx_len = 2;
> -
> -	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> -		tx_len += 2;
> -
> -	return tx_len;
> -}
> -
>  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
>  				u16 mask)
>  {
> @@ -129,7 +111,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
>  	struct spi_transfer tx[] = {
>  		{
>  			.tx_buf = &ad7949_adc->buffer,
> -			.len = ad7949_message_len(ad7949_adc),
> +			.len = 2,
>  			.bits_per_word = ad7949_adc->bits_per_word,
>  		}
>  	};
> @@ -197,7 +179,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	struct spi_transfer tx[] = {
>  		{
>  			.rx_buf = &ad7949_adc->buffer,
> -			.len = ad7949_message_len(ad7949_adc),
> +			.len = 2,
>  			.bits_per_word = ad7949_adc->bits_per_word,
>  		}
>  	};

