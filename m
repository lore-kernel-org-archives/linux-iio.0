Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36155 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbcHWSKB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2016 14:10:01 -0400
Subject: Re: [PATCH v3 4/4] arm: dts: rockchip: add reset node for the exist
 saradc SoCs
To: Heiko Stuebner <heiko@sntech.de>, Caesar Wang <wxt@rock-chips.com>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-4-git-send-email-wxt@rock-chips.com>
 <2485357.yNPXRzbCnj@phil>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        john@metanate.com, linux@roeck-us.net,
        linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bd4ebfaa-27e2-5e6c-64f3-62290a8ba3de@kernel.org>
Date: Tue, 23 Aug 2016 19:09:59 +0100
MIME-Version: 1.0
In-Reply-To: <2485357.yNPXRzbCnj@phil>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/16 18:20, Heiko Stuebner wrote:
> Am Mittwoch, 27. Juli 2016, 22:24:07 CEST schrieb Caesar Wang:
>> SARADC controller needs to be reset before programming it, otherwise
>> it will not function properly.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Cc: <Stable@vger.kernel.org>
> 
Applied to the fixes-togreg branch of iio.git

I'll probably get the pull request done tonight to get this on it's
way.

Jonathan
