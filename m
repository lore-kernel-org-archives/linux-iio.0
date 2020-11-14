Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1DDC5519F
	for <linux-iio@archiver.kernel.org>; Sat, 14 Nov 2020 16:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC2F22263
	for <linux-iio@archiver.kernel.org>; Sat, 14 Nov 2020 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUvVti4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKNQDn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 14 Nov 2020 11:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgKNQDn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:03:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3EF20665;
        Sat, 14 Nov 2020 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605369823;
        bh=UITx00zAcB1ZwANInVsxHvLlr4TN0cqsz0W9nq0Fyfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fUvVti4IZGwyHeRf61jppFlImIY5Ro7vn13y/OLV9gX6sgcZhMuFM4SgBSWj2W9q9
         8IOXY9jLerAw1cURZCTJF2XO+ghUU3Y0ysEh+cauKrjiE41uLWkdex/ggEBE3f3DQk
         AOzGO4hG8XSn2r+YI1jtf17QDp3b3mYvuKDDkcqA=
Date:   Sat, 14 Nov 2020 16:03:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix CMR value check
Message-ID: <20201114160338.29a178f6@archlinux>
In-Reply-To: <20201111163807.10201-1-vilhelm.gray@gmail.com>
References: <20201111163807.10201-1-vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Nov 2020 11:38:07 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The ATMEL_TC_ETRGEDG_* defines are not masks but rather possible values
> for CMR. This patch fixes the action_get() callback to properly check
> for these values rather than mask them.
> 
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Looks fine to me, but ideally after an ack from Kamel

Thanks,

Jonathan

> ---
>  drivers/counter/microchip-tcb-capture.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 039c54a78aa5..142b389fc9db 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -183,16 +183,20 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
>  
>  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
>  
> -	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
> -
> -	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> +	switch (cmr & ATMEL_TC_ETRGEDG_BOTH) {
> +	default:
>  		*action = MCHP_TC_SYNAPSE_ACTION_NONE;
> -	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
> +		break;
> +	case ATMEL_TC_ETRGEDG_RISING:
>  		*action = MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
> -	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
> +		break;
> +	case ATMEL_TC_ETRGEDG_FALLING:
>  		*action = MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
> -	else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
> +		break;
> +	case ATMEL_TC_ETRGEDG_BOTH:
>  		*action = MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
> +		break;
> +	}
>  
>  	return 0;
>  }

