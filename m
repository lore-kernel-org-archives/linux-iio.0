Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5290CC10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1402084E
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555249225;
	bh=glXZC5GlYov5ex8o7RTbGnhO1nivpCgxToMpJavM+H4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MXh6JvI1luWWpy77+A85PUGdIylQoDiUbG1ADnCT/9qYLMzTz1HCFxNfu5l16MklW
	 C5phr8RJAid9o0E4nVy7kxBt2ipGEjLYHYH376x/qPNuBTmS6LkC2Gl0OySqK3LT9W
	 CXRudPD0r0kRJlDkt7RgEANRzw+f8aLe1jCfQoI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfDNNkY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfDNNkY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 09:40:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 796DA2070D;
        Sun, 14 Apr 2019 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555249223;
        bh=glXZC5GlYov5ex8o7RTbGnhO1nivpCgxToMpJavM+H4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rPVCWD6ZKMJNZNt00qLePwpH8eXWZklevc7jI1WWGCBNf0xB+apRkfBPZyx8xJdRY
         hlHnEXXSj7oyBFngZoM4ix6xrtzlvmNUVa3Qmn2Y26lwK4aIwkN4pCXRUEfH4rgHBV
         6qCoYc44ydO8fLiGFjnvdRZrNnQbYoR87ZT473Ho=
Date:   Sun, 14 Apr 2019 14:40:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 6/6] MAINTAINERS: add entry for fxas21002c gyro
 driver
Message-ID: <20190414144014.34cb5d6b@archlinux>
In-Reply-To: <20190412164901.2321-7-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
        <20190412164901.2321-7-rui.silva@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Apr 2019 17:49:01 +0100
Rui Miguel Silva <rui.silva@linaro.org> wrote:

> Add me as maintainer of the nxp fxas21002c gyroscope driver.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Applied.

Thanks,

Jonathan
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3671fdea5010..f770f5124f4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11117,6 +11117,16 @@ F:	Documentation/ABI/stable/sysfs-bus-nvmem
>  F:	include/linux/nvmem-consumer.h
>  F:	include/linux/nvmem-provider.h
>  
> +NXP FXAS21002C DRIVER
> +M:	Rui Miguel Silva <rmfrfs@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/gyroscope/fxas21002c.txt
> +F:	drivers/iio/gyro/fxas21002c_core.c
> +F:	drivers/iio/gyro/fxas21002c.h
> +F:	drivers/iio/gyro/fxas21002c_i2c.c
> +F:	drivers/iio/gyro/fxas21002c_spi.c
> +
>  NXP SGTL5000 DRIVER
>  M:	Fabio Estevam <festevam@gmail.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)

