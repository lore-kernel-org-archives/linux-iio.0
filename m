Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33686 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbcG2V2f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2016 17:28:35 -0400
Date: Fri, 29 Jul 2016 16:28:33 -0500
From: Rob Herring <robh@kernel.org>
To: Caesar Wang <wxt@rock-chips.com>
Cc: jic23@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dianders@chromium.org, linux-rockchip@lists.infradead.org,
	john@metanate.com, linux@roeck-us.net,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] iio: adc: rockchip_saradc: reset saradc
 controller before programming it
Message-ID: <20160729212833.GA12688@rob-hp-laptop>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 27, 2016 at 10:24:04PM +0800, Caesar Wang wrote:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> ---
> 
> Changes in v3:
> - %s/devm_reset_control_get_optional()/devm_reset_control_get()
> - add Guente's test tag.
> 
> Changes in v2:
> - Make the reset as an optional property, since it should work
> with old devicetrees as well.
> 
>  .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++
>  drivers/iio/adc/Kconfig                            |  1 +
>  drivers/iio/adc/rockchip_saradc.c                  | 30 ++++++++++++++++++++++
>  3 files changed, 38 insertions(+)

Please add acks when posting new versions.

Rob
