Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47342 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdDBI6W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:58:22 -0400
Subject: Re: [PATCH v4 1/6] dt-bindings: iio: rockchip-saradc: add support for
 rk3328
To: Heiko Stuebner <heiko@sntech.de>, cl@rock-chips.com
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
 <1490607650-18650-2-git-send-email-cl@rock-chips.com>
 <1940747.DLKBel529v@phil>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, zhengxing@rock-chips.com,
        andy.yan@rock-chips.com, jay.xu@rock-chips.com,
        matthias.bgg@gmail.com, paweljarosz3691@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, wxt@rock-chips.com,
        david.wu@rock-chips.com, linux-iio@vger.kernel.org,
        shawn.lin@rock-chips.com, akpm@linux-foundation.org,
        dianders@chromium.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, will.deacon@arm.com, afaerber@suse.de,
        shawnguo@kernel.org, khilman@baylibre.com, arnd@arndb.de,
        fabio.estevam@nxp.com, zhangqing@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        huangtao@rock-chips.com, yhx@rock-chips.com,
        rocky.hao@rock-chips.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3b0bb12e-3f9e-84b8-3d4e-976ace90fe74@kernel.org>
Date: Sun, 2 Apr 2017 09:58:17 +0100
MIME-Version: 1.0
In-Reply-To: <1940747.DLKBel529v@phil>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/03/17 14:25, Heiko Stuebner wrote:
> Hi Jonathan,
> 
> Am Montag, 27. März 2017, 17:40:46 CEST schrieb cl@rock-chips.com:
>> From: Liang Chen <cl@rock-chips.com>
>>
>> The rk3328 saradc is the same as rk3399.
>>
>> Signed-off-by: Liang Chen <cl@rock-chips.com>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> just for planning purposes, do you plan on picking this up or do you
> want me to queue it with the rest of the changes (Ack needed).

Applied to the togreg branch of iio.git.  Makes more sense that
way as we might get some other changes around that file and it
doesn't make any difference to the rest of the series.

Will probably start it's way upstream this afternoon if I get
through the rest of my backlog.

Thanks,

Jonathan
> 
> Heiko
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

