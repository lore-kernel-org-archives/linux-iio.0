Return-Path: <SRS0=BGF5=5N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C1C43331
	for <linux-iio@archiver.kernel.org>; Sat, 28 Mar 2020 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C668120723
	for <linux-iio@archiver.kernel.org>; Sat, 28 Mar 2020 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585404983;
	bh=gU5OU/1nQ9lCMlTw2P7p3BfBd6ofZMOkQTbkOv23oSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C9VidhllI+tWVRCVRgn7G+S2RqSCVRgMp8hSSFFbcDq/DAxBtTNy4i4pcGbc92S7/
	 6Xt56ymbKvA+BfWdlhEdHhzkMIWP2GVimVGPiVI/XF3BuHLqCYzthRRYp0gSMeHAKx
	 D/E4QB5D4iPgYPea1bkWluRWqAV1IYl4xMw+IBsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1OQX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1OQX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:16:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F956206DB;
        Sat, 28 Mar 2020 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585404982;
        bh=gU5OU/1nQ9lCMlTw2P7p3BfBd6ofZMOkQTbkOv23oSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dk2s4KYDeSsj1FaInWmHPaoppFv6WriwY0KV2SJW0fX6iwDaKYlHdISk4K/yb59EE
         sMwQ/4U3RNMX7liOxMvD/RNIqNcdGavRBqp9DKaxDToqFWvmfwnTIc3dJtaUnl0Z52
         7EcEeBZJQqD1P8JStI2B9GgocILPiONIs3/DUUJQ=
Date:   Sat, 28 Mar 2020 14:16:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] iio: gyro: bmg160_spi: Use vsprintf extension
 %pe for symbolic error name
Message-ID: <20200328141618.64938f3e@archlinux>
In-Reply-To: <5f2c696ab083108b18898bcead8489f46d000114.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
        <5f2c696ab083108b18898bcead8489f46d000114.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 22:53:07 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Utilize %pe format specifier from vsprintf while printing error logs
> with dev_err(). Discards the use of unnecessary explicit casting and
> prints symbolic error name which might prove to be convenient during
> debugging.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>

Side note on this one.  Would have made sense to combine the two patches
for the bmg160 gyro into one, but doesn't really matter.

Applied.

Thanks,


> ---
> 
> Changes in v2:
>   - Rewrite commit subject line outlining the usage of %pe.
>   - Add a separator between regmap and its error name.
> 
> Based on conversations in [1] & [2].
> 
> [1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
> [2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
> ---
>  drivers/iio/gyro/bmg160_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
> index 182a59c42507..6f82bbe0ae92 100644
> --- a/drivers/iio/gyro/bmg160_spi.c
> +++ b/drivers/iio/gyro/bmg160_spi.c
> @@ -19,8 +19,8 @@ static int bmg160_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
> +			regmap);
>  		return PTR_ERR(regmap);
>  	}
>  

