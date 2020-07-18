Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05116C433E2
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF09C20657
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595083364;
	bh=VvVela76WpcPnsaxcOthFFXOe4qU+WFy687zFKejYDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dmJaoPML3FhCjhC8oTkjRgq3GUm4D72EIDcDh0jPqIagsmUuCVMt4aPogJ/95Bcrv
	 kkVHpbJcP5Q8ziRL8n9L8S9Z7HRl5qpgSvK815HFuku8bSZf1/WCRYNGiRKLGSidnV
	 E4FmzQ04lkC6tARU60aZmOZ42ViZMHn5aZz6KZhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGROmo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgGROmn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:42:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D8E2064B;
        Sat, 18 Jul 2020 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595083363;
        bh=VvVela76WpcPnsaxcOthFFXOe4qU+WFy687zFKejYDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WxPfSiPWFZW1iNkTuw1T3WnEyRJSyXYU48HcD/BSQtVwOti3mueVWaJfCVfpwGQB3
         ibc9XGNUy/bnWdfUzr8LQQ9AecFbhvMXkpttEYa8hWRA2OEUEYoOU5wGRR0qFhea7a
         HqubmoHsNFMMWc200ZsjGa+/uVkdrd4+1enj4xts=
Date:   Sat, 18 Jul 2020 15:42:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 11/30] iio: dac: ad5421: Fix kerneldoc attribute
 formatting for 'lock'
Message-ID: <20200718154239.1d5b121b@archlinux>
In-Reply-To: <20200716135928.1456727-12-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-12-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:09 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5421.c:82: warning: Function parameter or member 'lock' not described in 'ad5421_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied

Thanks,

J
> ---
>  drivers/iio/dac/ad5421.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
> index fec27764cea88..95466c86f207a 100644
> --- a/drivers/iio/dac/ad5421.c
> +++ b/drivers/iio/dac/ad5421.c
> @@ -62,7 +62,7 @@
>   * @current_range:	current range which the device is configured for
>   * @data:		spi transfer buffers
>   * @fault_mask:		software masking of events
> - * @lock	lock to protect the data buffer during SPI ops
> + * @lock:		lock to protect the data buffer during SPI ops
>   */
>  struct ad5421_state {
>  	struct spi_device		*spi;

