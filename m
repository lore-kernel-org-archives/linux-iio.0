Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:46422 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdHNBmf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Aug 2017 21:42:35 -0400
Subject: Re: [PATCH v3 10/13] ARM: dts: rockchip: add saradc support for
 rv1108
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Wu <david.wu@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
 <1502423211-31216-1-git-send-email-andy.yan@rock-chips.com>
 <2309743.33rDFhBfGp@phil>
From: Andy Yan <andy.yan@rock-chips.com>
Message-ID: <f920f312-3de2-74cd-d762-ac0d0c9729c8@rock-chips.com>
Date: Mon, 14 Aug 2017 09:42:23 +0800
MIME-Version: 1.0
In-Reply-To: <2309743.33rDFhBfGp@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Heiko:


On 2017年08月13日 20:13, Heiko Stuebner wrote:
> Hi Andy,
>
> Am Freitag, 11. August 2017, 11:46:51 CEST schrieb Andy Yan:
>> Add saradc device tree node for rv1108 soc
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> +	adc: adc@1038c000 {
>> +		compatible = "rockchip,rv1108-saradc", "rockchip,rk3399-saradc";
>> +		reg = <0x1038c000 0x100>;
>> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-ranges;
> What do you need the io-channel-ranges for?
> I.e. according to the documenation it is meant for when the adc is also
> a "bus node" and has children that should inherit channels from it.
>
> In all saradc uses so far we only have separate nodes referencing the
> adc controller (like adc-keys etc), so this does not look like it is needed?

     Sorry, I just copied it from the downstream dts. After checked with 
David, he suggested that we could remove it.
>
>
> Heiko
>
>
>
>


