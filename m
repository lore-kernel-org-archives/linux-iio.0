Return-Path: <heiko@sntech.de>
From: Heiko Stuebner <heiko@sntech.de>
To: Caesar Wang <wxt@rock-chips.com>
Cc: jic23@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, john@metanate.com, linux@roeck-us.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm: dts: rockchip: add reset node for the exist saradc SoCs
Date: Mon, 22 Aug 2016 19:20:20 +0200
Message-ID: <2485357.yNPXRzbCnj@phil>
In-Reply-To: <1469629447-544-4-git-send-email-wxt@rock-chips.com>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com> <1469629447-544-4-git-send-email-wxt@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Am Mittwoch, 27. Juli 2016, 22:24:07 CEST schrieb Caesar Wang:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>
Cc: <Stable@vger.kernel.org>
