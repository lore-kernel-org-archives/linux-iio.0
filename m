Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57491 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203AbcGZRAh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 13:00:37 -0400
Date: Tue, 26 Jul 2016 10:00:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Caesar Wang <wxt@rock-chips.com>
Cc: heiko@sntech.de, jic23@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dianders@chromium.org, linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org, john@metanate.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] iio: adc: rockchip_saradc: reset saradc
 controller before programming it
Message-ID: <20160726170023.GA6590@roeck-us.net>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
 <57976814.3040605@roeck-us.net>
 <579777F4.2090002@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <579777F4.2090002@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 26, 2016 at 10:47:16PM +0800, Caesar Wang wrote:
> 
> On 2016年07月26日 21:39, Guenter Roeck wrote:
> >
> >>static int rockchip_saradc_probe(struct platform_device *pdev)
> >>{
> >>struct rockchip_saradc *info = NULL;
> >>@@ -218,6 +231,21 @@ static int rockchip_saradc_probe(struct
> >>platform_device *pdev)
> >>if (IS_ERR(info->regs))
> >>return PTR_ERR(info->regs);
> >>
> >>+ /*
> >>+ * The reset should be an optional property, as it should work
> >>+ * with old devicetrees as well
> >>+ */
> >>+ info->reset = devm_reset_control_get_optional(&pdev->dev,
> >>+ "saradc-apb");
> >
> >Does anyone know what the _optional API is for ? It seems to be exactly
> >the same
> >as devm_reset_control_get().
> 
> “
> As far as I see, the difference is WARN_ON(1)
> when CONFIG_RESET_CONTROLLER is not defined.
> 
> 
> The _optional functions were introduced by the following commit:
> 
> ----------------->8-----------------
> commit b424080a9e086e683ad5fdc624a7cf3c024e0c0f
> Author: Philipp Zabel <p.zabel@xxxxxxxxxxxxxx>
> Date: Fri Mar 7 15:18:47 2014 +0100
> 
> reset: Add optional resets and stubs
> 
> This patch adds device_reset_optional and (devm_)reset_control_get_optional
> variants that drivers can use to indicate they can function without control
> over the reset line. For those functions, stubs are added so the drivers can
> be compiled with CONFIG_RESET_CONTROLLER disabled.
> Also, device_reset is annotated with __must_check. Drivers
> ignoring the return
> value should use device_reset_optional instead.
> 

Is that really what we are looking for here ? CONFIG_RESET_CONTROLLER
is required for other functions of rk3399, isn't it ?

Guenter

> Signed-off-by: Philipp Zabel <p.zabel@xxxxxxxxxxxxxx>
> ------------------8<-----------------------------
> ”
> 
> for more information on http://www.spinics.net/lists/kernel/msg2306677.html
> :-)
> 
> >
> >Guenter
> >
> >>+ if (IS_ERR(info->reset)) {
> >>+ ret = PTR_ERR(info->reset);
> >>+ if (ret != -ENOENT)
> >>+ return ret;
> >>+
> >>+ dev_dbg(&pdev->dev, "no reset control found\n");
> >>+ info->reset = NULL;
> >>+ }
> >>+
> >>init_completion(&info->completion);
> >>
> >>irq = platform_get_irq(pdev, 0);
> >>@@ -252,6 +280,9 @@ static int rockchip_saradc_probe(struct
> >>platform_device *pdev)
> >>return PTR_ERR(info->vref);
> >>}
> >>
> >>+ if (info->reset)
> >>+ rockchip_saradc_reset_controller(info->reset);
> >>+
> >>/*
> >>* Use a default value for the converter clock.
> >>* This may become user-configurable in the future.
> >>
> >
> >
> >_______________________________________________
> >Linux-rockchip mailing list
> >Linux-rockchip@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> -- 
> caesar wang | software engineer | wxt@rock-chip.com
> 
> 
