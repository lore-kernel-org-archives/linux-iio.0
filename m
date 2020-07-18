Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A615C433E0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCA12073A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595087302;
	bh=huLjEPSvdikKTAJ/jeRu5OJpZptfkQBvmJfCRLnUACY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M3AoYJd2kemZ6HiSKMQ3ICK/gZRnXyuD+YTJvd7UVx8F7zNTI81WlGBPFt3+kuZ0J
	 ridFugqmGHo1z5H12thRN902dVC45hCNIlZe7Rnbs3wvUWhqQViTuSuny98qwP20tK
	 M82tTCCwAvEs/20mZ3+2FCx3rtGUMcQJz6eMeNGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPsV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPsV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:48:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C2920734;
        Sat, 18 Jul 2020 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087301;
        bh=huLjEPSvdikKTAJ/jeRu5OJpZptfkQBvmJfCRLnUACY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s3bRqekHO7ckf27VyRtXLqJL2cEwk6kphuCRDAPM0dEV1ikLg5gE3Zqqm1eqpsNcS
         V3yhDJ+irFegRVd0O+AtHT57WkaGZTIwq9FG9sxRhO8P8ONZCUKzG5ffvpUexwGthX
         hAlteOtIajofTE+qWpDrkuWcJLQpvRzhR9ivNnsQ=
Date:   Sat, 18 Jul 2020 16:48:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 12/30] iio: dac: ad5504: Fix formatting errors and
 demote non-compliant kerneldoc
Message-ID: <20200718164817.38a61ccd@archlinux>
In-Reply-To: <20200717165538.3275050-13-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-13-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:20 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5504.c:58: warning: Function parameter or member 'pwr_down_mask' not described in 'ad5504_state'
>  drivers/iio/dac/ad5504.c:58: warning: Function parameter or member 'pwr_down_mode' not described in 'ad5504_state'
>  drivers/iio/dac/ad5504.c:64: warning: cannot understand function prototype: 'enum ad5504_supported_device_ids '
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5504.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index c64e6898ff20a..7e4e422ddfefc 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -43,8 +43,8 @@
>   * @spi:			spi_device
>   * @reg:		supply regulator
>   * @vref_mv:		actual reference voltage used
> - * @pwr_down_mask	power down mask
> - * @pwr_down_mode	current power down mode
> + * @pwr_down_mask:	power down mask
> + * @pwr_down_mode:	current power down mode
>   * @data:		transfer buffer
>   */
>  struct ad5504_state {
> @@ -57,10 +57,9 @@ struct ad5504_state {
>  	__be16				data[2] ____cacheline_aligned;
>  };
>  
> -/**
> +/*
>   * ad5504_supported_device_ids:
>   */
> -
>  enum ad5504_supported_device_ids {
>  	ID_AD5504,
>  	ID_AD5501,

