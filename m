Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:57245 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbcHVRUA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Aug 2016 13:20:00 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Caesar Wang <wxt@rock-chips.com>
Cc: jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, john@metanate.com, linux@roeck-us.net,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: add reset saradc node for rk3368 SoCs
Date: Mon, 22 Aug 2016 19:19:55 +0200
Message-ID: <1802628.7aG4jhMeVI@phil>
In-Reply-To: <1469629447-544-3-git-send-email-wxt@rock-chips.com>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com> <1469629447-544-3-git-send-email-wxt@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am Mittwoch, 27. Juli 2016, 22:24:06 CEST schrieb Caesar Wang:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>
Cc: <Stable@vger.kernel.org>

