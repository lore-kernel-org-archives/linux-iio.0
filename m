Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36301 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeJYSzf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Oct 2018 14:55:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so8728334wrw.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Oct 2018 03:23:28 -0700 (PDT)
Date: Thu, 25 Oct 2018 11:23:24 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 09/11] power: supply: add AC power supply driver for
 AXP813
Message-ID: <20181025102324.GS4939@dell>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-10-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181023185330.10472-10-oskari@lemmela.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 23 Oct 2018, Oskari Lemmela wrote:

> AXP813 and AXP803 PMICs can control input current and minimum voltage.
> 
> Both of these values are configurable.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 94 ++++++++++++++++++++++++++

>  include/linux/mfd/axp20x.h             |  1 +

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
