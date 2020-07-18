Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10150C433E4
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09502076A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595085009;
	bh=lgIWion9D/0OTEIPDUtQys/BnOHW3hcw0kz4qL2VHgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bR0SeT3J1jPIEln0rkB3MYoxxhAxS5cIrGSY3v8yK+/ZQypdN/tQVfEBtCi24D8VJ
	 bCVSq/F/pqTmlgpIeUbX7I+luCLidxIf3nATaMAu7QxcQVfoRNh3U5eP2QISP3r3Et
	 HZqtjofQVnDECJg16ig4MspAC+rIxXl4A2kn40pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgGRPKJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgGRPKJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:10:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63972067D;
        Sat, 18 Jul 2020 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595085008;
        bh=lgIWion9D/0OTEIPDUtQys/BnOHW3hcw0kz4qL2VHgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nd23bh3pd9ijTL9SdNUX38ajizHpH/XusgcniEzCTiAuDxlqXz1lVIkx1OMbMHtXc
         ChATbDYWGZsBGWUTw5UXUEtNRI4lmbWf6uZwcBNT42WQIynnqkVCK4jo9dddRjKtUS
         DpLS9RW7oCeYAbbLzPDRM4iH0NOtKRRo0GN4JNg0=
Date:   Sat, 18 Jul 2020 16:10:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>
Subject: Re: [PATCH 24/30] iio: dac: ad5761: Fix kerneldoc attribute
 formatting for 'lock'
Message-ID: <20200718161004.4e73c08a@archlinux>
In-Reply-To: <20200716135928.1456727-25-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-25-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:22 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5761.c:80: warning: Function parameter or member 'lock' not described in 'ad5761_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ricardo Ribalda <ribalda@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5761.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
> index 67c4fa75c6f13..1d9d0e22d6f44 100644
> --- a/drivers/iio/dac/ad5761.c
> +++ b/drivers/iio/dac/ad5761.c
> @@ -57,7 +57,7 @@ enum ad5761_supported_device_ids {
>   * @use_intref:		true when the internal voltage reference is used
>   * @vref:		actual voltage reference in mVolts
>   * @range:		output range mode used
> - * @lock		lock to protect the data buffer during SPI ops
> + * @lock:		lock to protect the data buffer during SPI ops
>   * @data:		cache aligned spi buffer
>   */
>  struct ad5761_state {

