Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:57924 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbcG2XNz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2016 19:13:55 -0400
Message-ID: <579BE325.4010103@rock-chips.com>
Date: Sat, 30 Jul 2016 07:13:41 +0800
From: Caesar Wang <wxt@rock-chips.com>
MIME-Version: 1.0
To: jic23@kernel.org
CC: Rob Herring <robh@kernel.org>, Caesar Wang <wxt@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, linux-iio@vger.kernel.org, dianders@chromium.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	john@metanate.com, linux@roeck-us.net
Subject: Re: [PATCH v3 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com> <20160729212833.GA12688@rob-hp-laptop>
In-Reply-To: <20160729212833.GA12688@rob-hp-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 2016年07月30日 05:28, Rob Herring wrote:
> On Wed, Jul 27, 2016 at 10:24:04PM +0800, Caesar Wang wrote:
>> SARADC controller needs to be reset before programming it, otherwise
>> it will not function properly.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: linux-iio@vger.kernel.org
>> Cc: linux-rockchip@lists.infradead.org
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> ---
>>
>> Changes in v3:
>> - %s/devm_reset_control_get_optional()/devm_reset_control_get()
>> - add Guente's test tag.
>>
>> Changes in v2:
>> - Make the reset as an optional property, since it should work
>> with old devicetrees as well.
>>
>>   .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++
>>   drivers/iio/adc/Kconfig                            |  1 +
>>   drivers/iio/adc/rockchip_saradc.c                  | 30 ++++++++++++++++++++++
>>   3 files changed, 38 insertions(+)
> Please add acks when posting new versions.

I didn't get your ACK when posting the V3. :-P

---
Your ack on 2016-07-27 23:12

  .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++

Acked-by: Rob Herring<robh@kernel.org>



>
> Rob
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
caesar wang | software engineer | wxt@rock-chip.com


