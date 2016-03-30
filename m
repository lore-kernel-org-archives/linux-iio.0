Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35866 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbcC3EPN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Mar 2016 00:15:13 -0400
MIME-Version: 1.0
In-Reply-To: <1458945655-5027-1-git-send-email-richard@nod.at>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
Date: Wed, 30 Mar 2016 13:15:10 +0900
Message-ID: <CAJKOXPfeBpMLNpeiZXVvXv-kB_Kp9FH786ETsqBNN_1vrfG05w@mail.gmail.com>
Subject: Re: [PATCH 1/8] phy: Fix phy-hi6220-usb dependencies
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 26, 2016 at 7:40 AM, Richard Weinberger <richard@nod.at> wrote:
> This driver needs io memory.
>
> Fixes the following Kconfig warning:
> warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>
> And this build error:
> drivers/mfd/syscon.c: In function ‘of_syscon_register’:
> drivers/mfd/syscon.c:67:2: error: implicit declaration of function ‘ioremap’ [-Werror=implicit-function-declaration]
>   base = ioremap(res.start, resource_size(&res));
>   ^
> drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer without a cast [enabled by default]
>   base = ioremap(res.start, resource_size(&res));
>        ^
> drivers/mfd/syscon.c:109:2: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
>   iounmap(base);
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: d896910f3 ("phy: Restrict phy-hi6220-usb to HiSilicon arm64")
> Signed-off-by: Richard Weinberger <richard@nod.at>

Waiting with this from 3rd March...
https://www.spinics.net/lists/linux-usb/msg137114.html
(and resent on 15th https://lkml.org/lkml/2016/3/16/408)
...but indeed recent Rob's work is a better solution.

BR,
Krzysztof
