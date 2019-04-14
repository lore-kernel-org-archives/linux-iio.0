Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE24C10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0022218D3
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555249791;
	bh=K0QawVnSC8+N5q3jJ3j7fgC5isVllWOI/AutQhNsjT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hDJKb/hwQ3IjzVaK/QpLSBiTJ+Ns/8kj4C6njJPbKsu1xbeqe0kls77u2gsPqVDEO
	 WiD/rayLhKbsVl0DFKDRgNjIQvKyM6dh4T8IIxPzEQTMdcto6ta18RVYNvoUwySWGw
	 F9iLStQMKRA4UBN/1jTmd2v/cXx2D7IDxJk1zD7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfDNNtv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfDNNtu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 09:49:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B742148E;
        Sun, 14 Apr 2019 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555249790;
        bh=K0QawVnSC8+N5q3jJ3j7fgC5isVllWOI/AutQhNsjT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HMyCN5ou0df9Qp9b77bxEb/TxI5jY/X8VkUrKxn43RusxX+mF3K1OJppk0yh+cXZv
         KXodGdoXXiMvY0Wr+HRTPqAgKOCTjb0+GW4SkbfPeykbfxBieqFUlZrq6Q7HWc87yY
         3YtPZexJy2MXKZXWWQ4DY+ELFByXXp7t9wcyb3uc=
Date:   Sun, 14 Apr 2019 14:49:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add bindings for TI
 ADS8344 A/DC chips
Message-ID: <20190414144944.62bf502a@archlinux>
In-Reply-To: <20190412091537.14657-2-gregory.clement@bootlin.com>
References: <20190412091537.14657-1-gregory.clement@bootlin.com>
        <20190412091537.14657-2-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Apr 2019 11:15:36 +0200
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> This adds device tree bindings for the TI ADS8344 A/DC chips.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/ti-ads8344.txt           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
> new file mode 100644
> index 000000000000..e47c3759a82b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
> @@ -0,0 +1,19 @@
> +* Texas Instruments ADS8344 A/DC chip
> +
> +Required properties:
> + - compatible: Must be "ti,ads8344"
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
> +	vref-supply = <&refin_supply>;
> +	spi-max-frequency = <10000000>;
> +};

