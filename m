Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD1FC10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7979520850
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555249285;
	bh=K1NYmGElszxEv3fz7gPF/3iospSSWi3dq4nkrlcXf08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uPLDvsXb7E88+H6hqXw38GOARJwCj6lbRdUamNOkW2BGGL3BE9A5qGFX4V9toP4xJ
	 mOVvV+XbdU4n+C0I+9ZgKCiNPJmb4PqARtBi/ga3rq+TuDM3P2VjO+akz1Z2YpKoxr
	 dVfPL+coW5loHw7m79NA90CR79OPuUsQ1nI39KXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfDNNlZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfDNNlY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 09:41:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3377C2070D;
        Sun, 14 Apr 2019 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555249284;
        bh=K1NYmGElszxEv3fz7gPF/3iospSSWi3dq4nkrlcXf08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cuDFK1a9sgMdICtjFN2Y/a8WAdJGgNIX6gdTlpqnsIpfjcPcL0ioHrAWhZuHxE2nx
         No+9j+ph3hXaEc9WC+bbya9opB6r8UXn/LCSI73CqFFnUGx/6lgh2su05B0RbfN1es
         U5j29S2zPOk0HuJ5MqIj8an06bxyawm3qNtK71GQ=
Date:   Sun, 14 Apr 2019 14:41:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 5/6] ARM: dts: imx7s-warp: add fxas21002c gyroscope
Message-ID: <20190414144115.747d3706@archlinux>
In-Reply-To: <20190412164901.2321-6-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
        <20190412164901.2321-6-rui.silva@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Apr 2019 17:49:00 +0100
Rui Miguel Silva <rui.silva@linaro.org> wrote:

> Add entry to enable the fxas21002c gyroscope in the warp7 board.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
The driver is now queued up in the IIO tree and will head towards
Linux-next fairly soon. Should be in plenty of time for the coming
merge window.

Thanks,

Jonathan

> ---
>  arch/arm/boot/dts/imx7s-warp.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
> index 613f0a9b319f..568f3289b34c 100644
> --- a/arch/arm/boot/dts/imx7s-warp.dts
> +++ b/arch/arm/boot/dts/imx7s-warp.dts
> @@ -242,6 +242,13 @@
>  		compatible = "fsl,mpl3115";
>  		reg = <0x60>;
>  	};
> +
> +	gyroscope@20 {
> +		compatible = "nxp,fxas21002c";
> +		reg = <0x20>;
> +		vdd-supply = <&reg_peri_3p15v>;
> +		vddio-supply = <&reg_peri_3p15v>;
> +	};
>  };
>  
>  &mipi_csi {

