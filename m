Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11949 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbcCZJ1R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 26 Mar 2016 05:27:17 -0400
Subject: Re: [PATCH 1/8] phy: Fix phy-hi6220-usb dependencies
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
 <CAMuHMdU19590PHEMbg6B7XRmMgSv2E-c96Buxy7q8x2Asykvbg@mail.gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56F655F0.9000503@nod.at>
Date: Sat, 26 Mar 2016 10:27:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU19590PHEMbg6B7XRmMgSv2E-c96Buxy7q8x2Asykvbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 26.03.2016 um 10:05 schrieb Geert Uytterhoeven:
> Hi Richard,
> 
> On Fri, Mar 25, 2016 at 11:40 PM, Richard Weinberger <richard@nod.at> wrote:
>> This driver needs io memory.
>>
>> Fixes the following Kconfig warning:
>> warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>
>> And this build error:
>> drivers/mfd/syscon.c: In function ‘of_syscon_register’:
>> drivers/mfd/syscon.c:67:2: error: implicit declaration of function ‘ioremap’ [-Werror=implicit-function-declaration]
>>   base = ioremap(res.start, resource_size(&res));
>>   ^
>> drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer without a cast [enabled by default]
>>   base = ioremap(res.start, resource_size(&res));
>>        ^
>> drivers/mfd/syscon.c:109:2: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
>>   iounmap(base);
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Fixes: d896910f3 ("phy: Restrict phy-hi6220-usb to HiSilicon arm64")
> 
> I don't think that commit is the root cause ;-)
> Before there were no dependencies at all...

Fair point. :-)

> Fixes: 30e9a0b2147c8405 ("phy: add phy-hi6220-usb")
> 
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> With the above fixed:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks,
//richard
