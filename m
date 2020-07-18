Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6030C433E0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F5D207FB
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595084699;
	bh=AAZPwQTU94R3L/QF22yxuFg1zBYZopItzGUsuLf8eIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K9S7SeRJLNh3sunwCO0B9RcYnTJWxgSqQuYq9FjNCfJ6Dpl7GC3AvJRX1Dg0zRHJj
	 NCa6FTR/gGbWQ9xT2gx2pkvWrUW/cyW/hhuBLxtXkRMX/haJl4auPXEgSZcRPfqc78
	 KXFZL7p5siXEbUfMaWEIdMBgFqkVC7EBmWQ8AM2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGRPE7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgGRPE7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:04:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68612065D;
        Sat, 18 Jul 2020 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084698;
        bh=AAZPwQTU94R3L/QF22yxuFg1zBYZopItzGUsuLf8eIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CaZ/g7ubXGxlkcOaOs2tbnOSLM7dFTYTLf3ULk6VCUl90SMLCaGPuqa82Vm9+fJXM
         HJB9aH6Cv1FZHDh/uFGPS4No6pcsHVJJr8RQry71bi8qsEXNpfjrPUXufP7z/seQlP
         trpFIqyQGby3AhH6yrjZRtGUL08DTYf0D6TLi2HE=
Date:   Sat, 18 Jul 2020 16:04:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/30] iio: dac: ad5064: Fix a few kerneldoc
 misdemeanours
Message-ID: <20200718160454.1a722eea@archlinux>
In-Reply-To: <20200716135928.1456727-20-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-20-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:17 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Misspelling, missing description and compiler attribute ordering.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5064.c:71: warning: bad line:                         internal vref.
>  drivers/iio/dac/ad5064.c:83: warning: Function parameter or member 'channels' not described in 'ad5064_chip_info'
>  drivers/iio/dac/ad5064.c:125: warning: Function parameter or member 'lock' not described in 'ad5064_state'
>  drivers/iio/dac/ad5064.c:125: warning: Function parameter or member '____cacheline_aligned' not described in 'ad5064_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Holding this one for that discussion around kernel-doc handing of
___cacheline_aligned

Jonathan

> ---
>  drivers/iio/dac/ad5064.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index 303f6d1a5f311..d7109f8f52efa 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -68,8 +68,8 @@ enum ad5064_regmap_type {
>   * struct ad5064_chip_info - chip specific information
>   * @shared_vref:	whether the vref supply is shared between channels
>   * @internal_vref:	internal reference voltage. 0 if the chip has no
> -			internal vref.
> - * @channel:		channel specification
> + *			internal vref.
> + * @channels:		channel specification
>   * @num_channels:	number of channels
>   * @regmap_type:	register map layout variant
>   */
> @@ -98,6 +98,7 @@ typedef int (*ad5064_write_func)(struct ad5064_state *st, unsigned int cmd,
>   * @use_internal_vref:	set to true if the internal reference voltage should be
>   *			used.
>   * @write:		register write callback
> + * @lock:		maintain consistency between cached and dev state
>   * @data:		i2c/spi transfer buffers
>   */
>  
> @@ -111,7 +112,6 @@ struct ad5064_state {
>  	bool				use_internal_vref;
>  
>  	ad5064_write_func		write;
> -	/* Lock used to maintain consistency between cached and dev state */
>  	struct mutex lock;
>  
>  	/*
> @@ -121,7 +121,7 @@ struct ad5064_state {
>  	union {
>  		u8 i2c[3];
>  		__be32 spi;
> -	} data ____cacheline_aligned;
> +	} ____cacheline_aligned data;
>  };
>  
>  enum ad5064_type {

