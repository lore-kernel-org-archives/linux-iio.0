Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48310 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdCSKea (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:34:30 -0400
Subject: Re: [PATCH v1 2/7] dt-bindings: iio: rockchip-saradc: add support for
 rk3328
To: Heiko Stuebner <heiko@sntech.de>, cl@rock-chips.com
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
 <1489572237-6649-3-git-send-email-cl@rock-chips.com>
 <8664375.8vdE6CQfX9@phil>
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
Message-ID: <fff0d197-c88e-fd04-0f56-c4fbc982bae4@kernel.org>
Date: Sun, 19 Mar 2017 10:34:22 +0000
MIME-Version: 1.0
In-Reply-To: <8664375.8vdE6CQfX9@phil>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/03/17 08:28, Heiko Stuebner wrote:
> Am Mittwoch, 15. März 2017, 18:03:52 CET schrieb cl@rock-chips.com:
>> From: Chen Liang <cl@rock-chips.com>
>>
>> The rk3328 saradc is the same as rk3399.
>>
>> Signed-off-by: Chen Liang <cl@rock-chips.com>
>> ---
>>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt index
>> 205593f..f81bc20 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> @@ -5,6 +5,7 @@ Required properties:
>>     - "rockchip,saradc": for rk3188, rk3288
>>     - "rockchip,rk3066-tsadc": for rk3036
>>     - "rockchip,rk3399-saradc": for rk3399
>> +   - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328
> 
> not sure how iio people see that, but I would suggest keeping the order, so 
> put rk3328 above rk3399.
In my case I'm not that fussed either way. Still if this list keeps growing
I can see it would be better to keep it in numeric order!

Jonathan
> 
> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

