Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:52604 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbdHMMNI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Aug 2017 08:13:08 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andy.yan@rock-chips.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 10/13] ARM: dts: rockchip: add saradc support for rv1108
Date: Sun, 13 Aug 2017 14:13:01 +0200
Message-ID: <2309743.33rDFhBfGp@phil>
In-Reply-To: <1502423211-31216-1-git-send-email-andy.yan@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com> <1502423211-31216-1-git-send-email-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Andy,

Am Freitag, 11. August 2017, 11:46:51 CEST schrieb Andy Yan:
> Add saradc device tree node for rv1108 soc
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 

> +	adc: adc@1038c000 {
> +		compatible = "rockchip,rv1108-saradc", "rockchip,rk3399-saradc";
> +		reg = <0x1038c000 0x100>;
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +		#io-channel-cells = <1>;
> +		io-channel-ranges;

What do you need the io-channel-ranges for?
I.e. according to the documenation it is meant for when the adc is also
a "bus node" and has children that should inherit channels from it.

In all saradc uses so far we only have separate nodes referencing the
adc controller (like adc-keys etc), so this does not look like it is needed?


Heiko

