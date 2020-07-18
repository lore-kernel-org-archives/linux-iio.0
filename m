Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1711C433E1
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17842083B
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595087769;
	bh=aNUn0ufeItAoFwIvQWSUKYizVdAeSsHrPyXQ2ezbtSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jHZSsFkrCUrpFYMO/FXUtttqiCurJORjLu5g4wZ3QeFEM+BhVpDElcWibrR24EF+j
	 nkgIPD1ZlUvRu/HZdfPQyukQDvjemuiU8el1FBrVX+le9SfVEnUyuz+f18UsnW7RfI
	 DDolm49AgWO0OUD2iyXFXU7KQ6UY8CCfx0vNfC5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgGRP4J (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRP4J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:56:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF032076A;
        Sat, 18 Jul 2020 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087768;
        bh=aNUn0ufeItAoFwIvQWSUKYizVdAeSsHrPyXQ2ezbtSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lsA3oc2Wrq8Xq4ncIYgzaipHTuM3059XTdvvBIEWOekAmag1fCP7pJGoY2P2eGLwT
         eAfO1sV2YMWGUjTHcx/7Fs9QJ4Nm5VLKmQG0eEoBJXE72GEwarjhq59sy7tYjP9UFH
         JU/YUwi858YYmVM2FaDmkfZ+EQyTylQ1n1Y4hGho=
Date:   Sat, 18 Jul 2020 16:56:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>
Subject: Re: [PATCH 20/30] iio: adc: max1363: Fix kerneldoc attribute
 formatting for 'lock'
Message-ID: <20200718165604.4f7f8feb@archlinux>
In-Reply-To: <20200717165538.3275050-21-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-21-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:28 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/max1363.c:190: warning: Function parameter or member 'lock' not described in 'max1363_state'
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rohit Sarkar <rohitsarkar5398@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Given the age of this driver, I suspect that this is the source
of all the cut and paste.  Oops.

Applied,

Jonathan

> ---
>  drivers/iio/adc/max1363.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 9d92017c79b2d..0fe348a47fe01 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -150,7 +150,7 @@ struct max1363_chip_info {
>   * @current_mode:	the scan mode of this chip
>   * @requestedmask:	a valid requested set of channels
>   * @reg:		supply regulator
> - * @lock		lock to ensure state is consistent
> + * @lock:		lock to ensure state is consistent
>   * @monitor_on:		whether monitor mode is enabled
>   * @monitor_speed:	parameter corresponding to device monitor speed setting
>   * @mask_high:		bitmask for enabled high thresholds

