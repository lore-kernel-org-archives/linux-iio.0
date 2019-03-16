Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F08CC43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF9521903
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552752481;
	bh=9rZ+evqm2WLtyZC51A3v34aV7/gINbARnH60gXMGElU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RpsZ6Gn2n2P6B4mxG3iBDCQD/wch3gPsYx9SoDiP/ovw43QnPib/xESXQ3oNaFKYL
	 4ZPLaDtsPJblNLBL5eTNgRjsJy3hhg1dwz2QWEC92CBzZXR3p0MnBhIUg+FEtzBimg
	 3Dc9fGuqmZWoMpooB1FEIsH+G/0q4mdrOVERWYjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfCPQIA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfCPQIA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 12:08:00 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF5621900;
        Sat, 16 Mar 2019 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552752480;
        bh=9rZ+evqm2WLtyZC51A3v34aV7/gINbARnH60gXMGElU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JdPncVnu0SOtslo624h7JVZYcDYUnygClr99Hxt2QF2Tv4SA4sd+nlH3JQyYz5ojq
         TL5M7TN48dWE1kf8Mn4RX0a+H++W4WKCUwxfCGv5ozimUACXxTJl6OePrrNRoyzSEC
         Mfx3Xpf4SrulFp/iOhR4xGqzyHYtm7tfRT5j5xV0=
Date:   Sat, 16 Mar 2019 16:07:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Stefan Tatschner <stefan.tatschner@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: Re: [PATCH] iio: pressure: bmp280: BMP280 calibration to entropy
Message-ID: <20190316160754.014dbbe7@archlinux>
In-Reply-To: <20190312084018.12697-1-linus.walleij@linaro.org>
References: <20190312084018.12697-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Mar 2019 09:40:18 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The BMP280/BME280 calibration data should also go into the
> entropy pool, like we do for BMP180.
> 
> This just adds the temperature and pressure calibration, the
> humidity calibration seems like too much annoying calls to
> add.
> 
> Cc: Tomasz Duszynski <tduszyns@gmail.com>
> Cc: Stefan Tatschner <stefan.tatschner@gmail.com>
> Cc: Andreas Klinger <ak@it-klinger.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
I'm going to assume you checked these are actually factory set
to values that vary.

Anyhow, applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with them.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index fe87d27779d9..3329d740c86c 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -164,6 +164,9 @@ static int bmp280_read_calib(struct bmp280_data *data,
>  		return ret;
>  	}
>  
> +	/* Toss the temperature calibration data into the entropy pool */
> +	add_device_randomness(t_buf, sizeof(t_buf));
> +
>  	calib->T1 = le16_to_cpu(t_buf[T1]);
>  	calib->T2 = le16_to_cpu(t_buf[T2]);
>  	calib->T3 = le16_to_cpu(t_buf[T3]);
> @@ -177,6 +180,9 @@ static int bmp280_read_calib(struct bmp280_data *data,
>  		return ret;
>  	}
>  
> +	/* Toss the pressure calibration data into the entropy pool */
> +	add_device_randomness(p_buf, sizeof(p_buf));
> +
>  	calib->P1 = le16_to_cpu(p_buf[P1]);
>  	calib->P2 = le16_to_cpu(p_buf[P2]);
>  	calib->P3 = le16_to_cpu(p_buf[P3]);

