Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.3]:49276 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbaH1ThC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Aug 2014 15:37:02 -0400
Received: from regular1.263xmail.com (unknown [192.168.165.184])
	by regular2.263xmail.com (Postfix) with ESMTP id 3AABF1D700
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2014 03:36:55 +0800 (CST)
Message-ID: <53FF84C4.9080902@rock-chips.com>
Date: Fri, 29 Aug 2014 03:36:36 +0800
From: Caesar Wang <caesar.wang@rock-chips.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
CC: Eduardo Valentin <edubezval@gmail.com>, rui.zhang@intel.com,
	grant.likely@linaro.org, robh+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, huangtao@rock-chips.com,
	cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org,
	zyw@rock-chips.com, addy.ke@rock-chips.com,
	dmitry.torokhov@gmail.com, zhaoyifeng <zyf@rock-chips.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com> <20140828143733.GA18084@developer> <3440260.edal29kzlR@diego> <4488604.oBeB6it8Vr@wuerfel>
In-Reply-To: <4488604.oBeB6it8Vr@wuerfel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Arnd & Heiko & Eduardo,

OK. Maybe you are right.

This driver should be put into drivers/iio/adc/* ,
Anyway,I will re-edit it ASAP.


在 2014/8/29 0:16, Arnd Bergmann 写道:
> On Thursday 28 August 2014 18:11:43 Heiko Stübner wrote:
>> Am Donnerstag, 28. August 2014, 10:37:35 schrieb Eduardo Valentin:
>>>> On the driver side, I believe the correct way to deal with this setup
>>>> is to split your driver into a generic drivers/iio/adc/rockchips-tsadc.c
>>>> file, and a smaller thermal driver that uses the iio in-kernel interfaces,
>>>> ideally one that is independent of the underlying hardware and can
>>>> work on any ADC implementation.
>>> Agreed. If you can write such interface and make your driver to work in
>>> such way, that would be great.
>> But I currently don't see how you would model the temperature handling parts
>> from a generic thermal driver to a generic adc driver for the rk3288-tsadc.
>>
>> I guess the general temperature irq handling would use iio-triggers? But how
>> does the target temperature get into the TSADC_COMP1_INT register.
>>
>> Also when getting the temperature, Caesar's driver compares it to its trip
>> points and sets the next trip point depending on the current temperature
>> (passive <-> critical) in rockchip_get_temp.
>>
>> Maybe there is some completely easy way for this, but currently I don't see
>> it.
> Eduardo earlier today replied to an email about a generic driver for
> thermal, which was posted in February but hasn't been merged.
> See https://lkml.org/lkml/2014/2/5/810
>
> There may be a newer version of this patch, which I haven't found.
>
> 	Arnd
>
>
>

-- 
Best regards,
Caesar


