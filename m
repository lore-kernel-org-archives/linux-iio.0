Return-Path: <SRS0=q/te=5V=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D19C2D0F4
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 12:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB5F20709
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586088644;
	bh=h5fulmSJXzfUZIRpwvx0u42UOey+apawE6u9dYXUglg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l7fHtElBsQgaOegpGwJwNbGjJJMdIttmTzrIhx5oG0dgjWchDMLjFDxmQ912Prdxg
	 8XufY3rniT9oibyhBc2jDsdLiAm3X/hPdEW90tkJILNQ3/h8B9u5Of/LwIojgijNnM
	 3kUTkXzFO7QFFgFU+xYXypg0Mms1y7ACF5I7J8Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDEMKn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Apr 2020 08:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDEMKn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 08:10:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DC8206B8;
        Sun,  5 Apr 2020 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586088643;
        bh=h5fulmSJXzfUZIRpwvx0u42UOey+apawE6u9dYXUglg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HT0u0q44NwoZG1lPH1E0A9FDOsCSfXxS+tetUtVdJrAb53TW+KFFgcAMwhr6x5cSO
         Om0aefm3bNkVbzXlgfQTwaK3JgPs1N+ubaUNGQj5hC6MeDY1i7cZS6pEiXmLphrIDP
         RCcSHUnlOq6C4LusoAexKXKKuGogyRM5BqUFMNp0=
Date:   Sun, 5 Apr 2020 13:10:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: xilinx-xadc: Fix ADC-B powerdown
Message-ID: <20200405131039.37ae5165@archlinux>
In-Reply-To: <20200403132717.24682-1-lars@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Apr 2020 15:27:13 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The check for shutting down the second ADC is inverted. This causes it to
> be powered down when it should be enabled. As a result channels that are
> supposed to be handled by the second ADC return invalid conversion results.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Fixes tag?  Definitely sounds like something we should be backporting!

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 2d6505a66511..4fcf1729341f 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -722,13 +722,14 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
>  {
>  	uint16_t val;
>  
> +	/* Powerdown the ADC-B when it is not needed. */
>  	switch (seq_mode) {
>  	case XADC_CONF1_SEQ_SIMULTANEOUS:
>  	case XADC_CONF1_SEQ_INDEPENDENT:
> -		val = XADC_CONF2_PD_ADC_B;
> +		val = 0;
>  		break;
>  	default:
> -		val = 0;
> +		val = XADC_CONF2_PD_ADC_B;
>  		break;
>  	}
>  

