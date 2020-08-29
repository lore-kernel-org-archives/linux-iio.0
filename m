Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA4FC433E6
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EED207DA
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598713030;
	bh=qdXm+nrrrgpho23Ano7UqAgXxxXTWhxdyQUQUsHB+YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lVn4vt+OhQH4AoPDV50+VnIFKInbK+V+TluDtG6YTTYSIRlykOukNtyR7xUG/UYid
	 RSJe4Vci4psV1tyK8V/E6GGev/IbW8+TDov/GEojv97HE0mslrSuv9nA8XG862V6rE
	 eF6tsiaD6FP0/mOqf5sVOJbC5ldtFLQrX9gzu42Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgH2O5J (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2O5I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 10:57:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A2020791;
        Sat, 29 Aug 2020 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598713027;
        bh=qdXm+nrrrgpho23Ano7UqAgXxxXTWhxdyQUQUsHB+YQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mP0t5E8r1r1tz/SdOWztOtGPNsuXcfxsBDVX+KrSQKE7+NC78hTa02xJHHkBf6UOg
         ndBKdrzyZRNnBV42awFK77kWcRn6HiDV05LtIbxGu2OoQ2/j2b4l2O2agK5ztNiRs3
         MBPeSM2rflYRXHhs9lkytUMx1fiWbw+moZkwF1tk=
Date:   Sat, 29 Aug 2020 15:57:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        xxm@rock-chips.com
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Select IIO_TRIGGERED_BUFFER
Message-ID: <20200829155703.19bf1c9f@archlinux>
In-Reply-To: <20200828174242.338068-1-alexandru.elisei@arm.com>
References: <20200828174242.338068-1-alexandru.elisei@arm.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Aug 2020 18:42:42 +0100
Alexandru Elisei <alexandru.elisei@arm.com> wrote:

> Building the Rockchip saradc driver can trigger the following error if the
> driver is compiled into the kernel, but the IIO triggered buffer is not:
> 
> aarch64-linux-gnu-ld: drivers/iio/adc/rockchip_saradc.o: in function `rockchip_saradc_probe':
> /path/to/linux/drivers/iio/adc/rockchip_saradc.c:427: undefined reference to `devm_iio_triggered_buffer_setup'
> 
> This is because commit 4e130dc7b413 ("iio: adc: rockchip_saradc: Add
> support iio buffers") added support for industrial I/O triggered buffers,
> but didn't update Kconfig to build the required file. Fix that.
> 
> Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

Sorry, I've had a patch queued to fix this for a while, but had a
vacation just after merge window occurred that delayed me sending it out.

Will send a pull sometime this weekend.

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 66d9cc073157..baa36a07a9cf 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -865,6 +865,7 @@ config ROCKCHIP_SARADC
>  	tristate "Rockchip SARADC driver"
>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>  	depends on RESET_CONTROLLER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the SARADC found in SoCs from
>  	  Rockchip.

