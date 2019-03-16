Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009B1C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A46218D4
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552756057;
	bh=BfsTFg58GpNDl8SbtHPiuuRkF+zjR7vWDAovzf7COAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dqXW19oJXuZPuHLd8JqcHn09/P7Q534jlDBnzUp5CUj46kIuwOfYh6vtbH0tTx7wG
	 GMPN2KszSH7i2fNy8bMGF0rQcdt1qT9PCj/p2FsqpkFa+bmvKmzQ45shxcICGiJhMk
	 m/uZxCJIgWZmyqSwAzwxqQ0UdCATRazwMNnDD/no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCPRHh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfCPRHh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 13:07:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD4F2186A;
        Sat, 16 Mar 2019 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552756056;
        bh=BfsTFg58GpNDl8SbtHPiuuRkF+zjR7vWDAovzf7COAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vxOxq32jXIkF2BpTE0QlGPeVMFcQYnqKI8reh7eF7q5ye5msB5XkSdsk4y6EjnZ8n
         LVvPYCQiyH5mI4saGSplO5c/ZnLzF83E9wY2PZD1kDGOXAE3k222+j+4iogjw8gEjE
         77tR24Fdq4627OuNCA5x+Gzyelvzfxe4TfaKIR9E=
Date:   Sat, 16 Mar 2019 17:07:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add bindings for TI ADS8344
 A/DC chips
Message-ID: <20190316170730.2ed341cc@archlinux>
In-Reply-To: <20190315151152.30467-2-gregory.clement@bootlin.com>
References: <20190315151152.30467-1-gregory.clement@bootlin.com>
        <20190315151152.30467-2-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Mar 2019 16:11:50 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> This adds device tree bindings for the TI ADS8344 A/DC chips.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Looks good to me, though io-channel-cells only needs to be 1 if
you have consumers...  Otherwise, it shouldn't be there at all..

Jonathan

> ---
>  .../bindings/iio/adc/ti-ads8344.txt           | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
> new file mode 100644
> index 000000000000..6576c4fed7b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
> @@ -0,0 +1,21 @@
> +* Texas Instruments ADS8344 A/DC chip
> +
> +Required properties:
> + - compatible: Must be "ti,ads8344"
> + - #io-channel-cells: Must be 1 as per ../iio-bindings.txt
> + - reg: SPI chip select number for the device
> + - vref-supply: phandle to a regulator node that supplies the
> +   reference voltage
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,ads8344";
> +	reg = <0>;
> +	#io-channel-cells = <1>;
> +	vref-supply = <&refin_supply>;
> +	spi-max-frequency = <10000000>;
> +};

