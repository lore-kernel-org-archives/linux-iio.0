Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36149 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753309AbcHWSIx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2016 14:08:53 -0400
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: add reset saradc node for
 rk3368 SoCs
To: Heiko Stuebner <heiko@sntech.de>, Caesar Wang <wxt@rock-chips.com>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-3-git-send-email-wxt@rock-chips.com>
 <1802628.7aG4jhMeVI@phil>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        john@metanate.com, linux@roeck-us.net,
        linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a2d2892c-60d6-15a4-cc6b-2dce292812b8@kernel.org>
Date: Tue, 23 Aug 2016 19:08:51 +0100
MIME-Version: 1.0
In-Reply-To: <1802628.7aG4jhMeVI@phil>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/16 18:19, Heiko Stuebner wrote:
> Am Mittwoch, 27. Juli 2016, 22:24:06 CEST schrieb Caesar Wang:
>> SARADC controller needs to be reset before programming it, otherwise
>> it will not function properly.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Cc: <Stable@vger.kernel.org>
Thanks,

Applied to the fixes-togreg branch of iio.git.

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

