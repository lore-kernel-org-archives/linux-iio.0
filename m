Return-Path: <SRS0=x94u=DZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD57C433E7
	for <linux-iio@archiver.kernel.org>; Sun, 18 Oct 2020 11:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB4021655
	for <linux-iio@archiver.kernel.org>; Sun, 18 Oct 2020 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603021136;
	bh=DMm9NFiMUt0qRoUMUiEFzO+bmj/oVc3DgTYc1EmVZzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=x/5avRF1MFjiQX5fBklkouuzusZKFAy5YCpulbjDlsodCcbAXGuEk7b/9Wtujn9OK
	 qdElSBcSh1SP5zd/jG5+1JjVIq1DnbucDuYiN6BNXU3UZgXdM5RMLIW7qrW+0YbkfH
	 J3vWh/RowwS2gr+PjRElGirmfoNv+haM8wZbJNdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgJRLi4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 18 Oct 2020 07:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgJRLiz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 07:38:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C196121582;
        Sun, 18 Oct 2020 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603021134;
        bh=DMm9NFiMUt0qRoUMUiEFzO+bmj/oVc3DgTYc1EmVZzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gDX7i1DcE0TtT4xm/ntMjS7Ikwylg2spXZQMHeT9Mvv+7y5zElGfbO4Jhx/Hna3SS
         jcvNGfQPSL7YG3ny+NwEV89+A40R1OlHI9CpzLVoUxCwjVmOmjnxEKDfHl0sbxOpct
         2TtaMcJm658v+sNLu0GlPb3r+/6nhgZ/XB+E6K6Y=
Date:   Sun, 18 Oct 2020 12:38:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter/ti-eqep: Fix regmap max_register
Message-ID: <20201018123850.24808751@archlinux>
In-Reply-To: <20201016195838.536791-1-david@lechnology.com>
References: <20201016195838.536791-1-david@lechnology.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Oct 2020 14:58:37 -0500
David Lechner <david@lechnology.com> wrote:

> The values given were the offset of the register after the last
> register instead of the actual last register in each range. Fix
> by using the correct last register of each range.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Fixes tag please.

Thanks,

Jonathan

> ---
>  drivers/counter/ti-eqep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index fe2c6bb22133..e60aec225541 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -798,7 +798,7 @@ static const struct regmap_config ti_eqep_regmap32_config = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
> -	.max_register = 0x24,
> +	.max_register = QUPRD,
>  };
>  
>  static const struct regmap_config ti_eqep_regmap16_config = {
> @@ -806,7 +806,7 @@ static const struct regmap_config ti_eqep_regmap16_config = {
>  	.reg_bits = 16,
>  	.val_bits = 16,
>  	.reg_stride = 2,
> -	.max_register = 0x1e,
> +	.max_register = QCPRDLAT,
>  };
>  
>  static int ti_eqep_probe(struct platform_device *pdev)

