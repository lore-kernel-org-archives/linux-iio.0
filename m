Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:47158 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdIRI3w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 04:29:52 -0400
Received: by mail-wr0-f172.google.com with SMTP id k20so5559496wre.4
        for <linux-iio@vger.kernel.org>; Mon, 18 Sep 2017 01:29:51 -0700 (PDT)
Date: Mon, 18 Sep 2017 09:29:48 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 2/6] iio: adc: sun4i-gpadc-iio: rename A33-specified
 registers to contain A33
Message-ID: <20170918082948.2bl5e44tzsufdj7n@dell>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170914145251.21784-3-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 14 Sep 2017, Icenowy Zheng wrote:

> As the H3 SoC, which is also in sun8i line, has totally different
> register map for the thermal sensor (a cut down version of GPADC), we
> should rename A23/A33-specified registers to contain A33, in order to
> prevent obfuscation with H3 registers. Currently these registers are
> only prefixed "SUN8I", not "SUN8I_A33".
> 
> Add "_A33" after "SUN8I" on the register names.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v4:
> - Change A23 to A33, as the driver never supports A23.
> 
>  drivers/iio/adc/sun4i-gpadc-iio.c | 2 +-

>  include/linux/mfd/sun4i-gpadc.h   | 6 +++---

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
