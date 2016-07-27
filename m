Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36452 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbcG0PMf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 11:12:35 -0400
Date: Wed, 27 Jul 2016 10:12:33 -0500
From: Rob Herring <robh@kernel.org>
To: Caesar Wang <wxt@rock-chips.com>
Cc: jic23@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, john@metanate.com,
	dianders@chromium.org, linux@roeck-us.net
Subject: Re: [PATCH v2 1/4] iio: adc: rockchip_saradc: reset saradc
 controller before programming it
Message-ID: <20160727151233.GA31731@rob-hp-laptop>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 26, 2016 at 08:13:12PM +0800, Caesar Wang wrote:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> 
> ---
> 
> Changes in v2:
> - Make the reset as an optional property, since it should work
> with old devicetrees as well.
> 
>  .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |  1 +
>  drivers/iio/adc/rockchip_saradc.c                  | 31 ++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
