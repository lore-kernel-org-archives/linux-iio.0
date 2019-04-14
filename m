Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA3BC10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2D218D3
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555248068;
	bh=VLI8EvTq8EcVLODo76C1Jy5XDx0Wq+B6w06q9XjMUhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hs5hezMEv1UFQFAJlGBWk5bPI0icBRlG9MP+IW00MwgdN3fT6pheXHdA6rXxYbWAg
	 FwH+ZfIPoRQ+8hMN2IybSIjX8Us4r+ZZCsoO+/nHF7arP78I6895Rnd6f8rZtkC2EQ
	 04WPcR3pgQ5qnIeKuUpGDzem04S87l/EBJeJSd+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfDNNVH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfDNNVH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 09:21:07 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D200320870;
        Sun, 14 Apr 2019 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555248067;
        bh=VLI8EvTq8EcVLODo76C1Jy5XDx0Wq+B6w06q9XjMUhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hCmyugpKb1U74ujFxAmqG+XwtkUpr6VOdD1cxtrEOvpqQD40gL2NnLoBjRL2hcMwL
         TrL7CtgQf6k9KwHCpvcD0mCkyRXQD0FaIQOr4FlLZC0AZwKZFKjmLocAQ3xd//UHGt
         KkL1GclwlXvqY2IG0v5h7cnoqeT96HwRuzsQJulk=
Date:   Sun, 14 Apr 2019 14:21:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/6] iio: gyro: add DT bindings to fxas21002c
Message-ID: <20190414142100.6153ac79@archlinux>
In-Reply-To: <20190412164901.2321-2-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
        <20190412164901.2321-2-rui.silva@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Apr 2019 17:48:56 +0100
Rui Miguel Silva <rui.silva@linaro.org> wrote:

> Add device tree bindings for the FXAS21002C gyroscope.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore.

Thanks,

Jonathan

> ---
>  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> new file mode 100644
> index 000000000000..465e104bbf14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> @@ -0,0 +1,31 @@
> +* NXP FXAS21002C Gyroscope device tree bindings
> +
> +http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> +
> +Required properties:
> +  - compatible : should be "nxp,fxas21002c"
> +  - reg : the I2C address of the sensor or SPI chip select number for the
> +          device.
> +  - vdd-supply: phandle to the regulator that provides power to the sensor.
> +  - vddio-supply: phandle to the regulator that provides power to the bus.
> +
> +Optional properties:
> +  - reset-gpios : gpio used to reset the device, see gpio/gpio.txt
> +  - interrupts : device support 2 interrupts, INT1 and INT2,
> +                 the interrupts can be triggered on rising or falling edges.
> +                 See interrupt-controller/interrupts.txt
> +  - interrupt-names: should contain "INT1" or "INT2", the gyroscope interrupt
> +                     line in use.
> +  - drive-open-drain: the interrupt/data ready line will be configured
> +                      as open drain, which is useful if several sensors share
> +                      the same interrupt line. This is a boolean property.
> +                      (This binding is taken from pinctrl/pinctrl-bindings.txt)
> +
> +Example:
> +
> +gyroscope@20 {
> +	compatible = "nxp,fxas21002c";
> +	reg = <0x20>;
> +	vdd-supply = <&reg_peri_3p15v>;
> +	vddio-supply = <&reg_peri_3p15v>;
> +};

