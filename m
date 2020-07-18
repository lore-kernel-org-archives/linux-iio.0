Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650F8C433E2
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF5B2076A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595085051;
	bh=/389A+wKWGM4WAl8EXDz4Qlsk2tNxCmUnJsbW4Rm95E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DtYYP7dyaf9ngM6YjoFzx/ZtTbaY2AXq4Q5kB8nBRVIjzPJdkpzpVIaL01HcVvuyQ
	 a+6Btlya9zVU4KTEa8SsPfRKKHfXOOPrPNQlHJL28ARn/1oeUr2UQLAnAGJuFwTHgW
	 DZArjCnIVoyn8RN2lpT7OjfOkQzRmGAqiXGmU+K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGRPKu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgGRPKu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:10:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652002067D;
        Sat, 18 Jul 2020 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595085050;
        bh=/389A+wKWGM4WAl8EXDz4Qlsk2tNxCmUnJsbW4Rm95E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gEXaqTxZqwQPj4PufX3WYAvN15YwZ5HmIUkm/MgKArxL6NiZmKNaHDzJbtaknaTNx
         AqszxKbSC6XwEQjTY1VRq1EZTzToC5v2m/Mz30XTg3LNgC+pT2RZAHKSz5xlL7l07J
         6tJ6+2W4vkSl7JBQFyrMnRrim00SO55AtdjIedh8=
Date:   Sat, 18 Jul 2020 16:10:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 25/30] iio: dac: ad5764: Fix misdocumenting and
 formatting error
Message-ID: <20200718161045.237efa78@archlinux>
In-Reply-To: <20200716135928.1456727-26-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-26-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:23 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Attribute descriptions must match the name exactly.
> 
> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5764.c:42: warning: Function parameter or member 'channels' not described in 'ad5764_chip_info'
>  drivers/iio/dac/ad5764.c:67: warning: Function parameter or member 'lock' not described in 'ad5764_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5764.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
> index 5b0f0fe354f6b..1e16c464241c4 100644
> --- a/drivers/iio/dac/ad5764.c
> +++ b/drivers/iio/dac/ad5764.c
> @@ -33,9 +33,8 @@
>   * struct ad5764_chip_info - chip specific information
>   * @int_vref:	Value of the internal reference voltage in uV - 0 if external
>   *		reference voltage is used
> - * @channel	channel specification
> + * @channels:	channel specification
>  */
> -
>  struct ad5764_chip_info {
>  	unsigned long int_vref;
>  	const struct iio_chan_spec *channels;
> @@ -46,7 +45,7 @@ struct ad5764_chip_info {
>   * @spi:		spi_device
>   * @chip_info:		chip info
>   * @vref_reg:		vref supply regulators
> - * @lock		lock to protect the data buffer during SPI ops
> + * @lock:		lock to protect the data buffer during SPI ops
>   * @data:		spi transfer buffers
>   */
>  

