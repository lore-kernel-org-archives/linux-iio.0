Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:49076 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdCWDdp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 23:33:45 -0400
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-5-git-send-email-cl@rock-chips.com>
 <14610453.rKm3MBREMz@diego>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, zhengxing@rock-chips.com,
        andy.yan@rock-chips.com, jay.xu@rock-chips.com,
        matthias.bgg@gmail.com, paweljarosz3691@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        wxt@rock-chips.com, david.wu@rock-chips.com,
        linux-iio@vger.kernel.org, shawn.lin@rock-chips.com,
        akpm@linux-foundation.org, dianders@chromium.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        will.deacon@arm.com, afaerber@suse.de, shawnguo@kernel.org,
        khilman@baylibre.com, arnd@arndb.de, fabio.estevam@nxp.com,
        zhangqing@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, huangtao@rock-chips.com,
        yhx@rock-chips.com, rocky.hao@rock-chips.com
From: =?UTF-8?B?6ZmI5Lqu?= <cl@rock-chips.com>
Message-ID: <58D34208.6090509@rock-chips.com>
Date: Thu, 23 Mar 2017 11:33:28 +0800
MIME-Version: 1.0
In-Reply-To: <14610453.rKm3MBREMz@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi, Heiko

在 2017年03月21日 16:55, Heiko Stübner 写道:
> Hi,
>
> Am Donnerstag, 16. März 2017, 21:17:22 CET schrieb cl@rock-chips.com:
>> +		assigned-clock-parents =
>> +			<&cru HDMIPHY>, <&cru PLL_APLL>,
>> +			<&cru PLL_GPLL>, <&xin24m>,
>> +			<&xin24m>, <&xin24m>;
>> +		assigned-clock-rates =
>> +			<0>, <61440000>,
>> +			<0>, <24000000>,
>> +			<24000000>, <24000000>,
>> +			<15000000>, <15000000>,
>> +			<100000000>, <100000000>,
>> +			<100000000>, <100000000>,
>> +			<50000000>, <100000000>,
>> +			<100000000>, <100000000>,
>> +			<50000000>, <50000000>,
>> +			<50000000>, <50000000>,
>> +			<24000000>, <600000000>,
>> +			<491520000>, <1200000000>,
>> +			<150000000>, <75000000>,
>> +			<75000000>, <150000000>,
>> +			<75000000>, <75000000>,
>> +			<300000000>, <100000000>,
>> +			<300000000>, <200000000>,
>> +			<400000000>, <500000000>,
>> +			<200000000>, <300000000>,
>> +			<300000000>, <250000000>,
>> +			<200000000>, <100000000>,
>> +			<24000000>, <100000000>,
>> +			<150000000>, <50000000>,
>> +			<32768>, <32768>;
>> +	};
>> +
>> +	gmac2io: eth@ff540000 {
> phandle should be gmac instead?
> Node name, ethernet@ff540000
RK3328 have another gmac channel with PHY in the soc, so gmac2io mean 
the channel with the PHY outside, and it is also called gmac2io in the TRM.
>
>
> Heiko
>


