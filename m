Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:65092 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbaFYK5K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jun 2014 06:57:10 -0400
From: Kukjin Kim <kgene.kim@samsung.com>
To: 'Naveen Krishna Chatradhi' <ch.naveen@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
	jdelvare@suse.de, linux@roeck-us.net
Cc: naveenkrishna.ch@gmail.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, lars@metafoo.de
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
Subject: RE: [PATCH 0/4 v2] hwmon: ntc_thermistor: prepose vendor prefix change
Date: Wed, 25 Jun 2014 19:57:07 +0900
Message-id: <02b501cf9064$34f16b80$9ed44280$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen Krishna Chatradhi wrote:
> 
+ Jean Delvare, Guenter Roeck

I'm adding maintainers for drivers/hwmon/ntc* but I'm not sure.

Hi,

This series looks good to me. I will take 3/4 and 4/4 for exynos DT changes once
hwmon/ntc maintainer pick the others.

Thanks,
Kukjin

> As Murata is the manufacturer of the NTC (Negative Temperature coefficient)
> based Thermistors. ntc_thermistor driver extensively used the prefix "ntc".
> But, vendor-prefix should be "murata" instead of "ntc".
> 
> This patchset
> 1. Updates the vendor-prefix, DT bindings and Documentation,
>    where ever necessary.
> 2. Adds thermistor nodes to Exynos5420 based Peach PIT board.
> 
> Patches:
> 1/4. devicetree: bindings: Document murata vendor prefix
>      Adds the vendor prefix "murata" to vendor-prefixes.txt.
> 2/4. hwmon: ntc_thermistor: Use the manufacturer name properly
>      Updates the driver, Kconfig, device tree bindings and Documentation
>      with the Manufacturer/vendor information.
>      Keeps the old bindings marked as <DEPRECATED> in code and Documentation
> 3/4. ARM: DTS: use new compatible string as per the documentation
>      Updates the device node in Exynos4412 based Trats2 board
>      with the new device tree bindings.
> 4/4. ARM: DTS: Add NTC thermistor nodes as child nodes to ADC
>      Adds Thermistor nodes to Exynos5420 based Peach PIT board.
> 
> This patchset
> Naveen Krishna Chatradhi (4):
>   devicetree: bindings: Document murata vendor prefix
>   hwmon: ntc_thermistor: Use the manufacturer name properly
>   ARM: DTS: use new compatible string as per the documentation
>   ARM: DTS: Add NTC thermistor nodes to Exynos5420 based Peach_PIT
> 
>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |    2 +-
>  .../devicetree/bindings/hwmon/ntc_thermistor.txt   |   20 ++++++++----
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  Documentation/hwmon/ntc_thermistor                 |    8 ++---
>  arch/arm/boot/dts/exynos4412-trats2.dts            |    4 +--
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |   34
++++++++++++++++++++
>  drivers/hwmon/Kconfig                              |    5 +--
>  drivers/hwmon/ntc_thermistor.c                     |   14 +++++++-
>  8 files changed, 72 insertions(+), 16 deletions(-)
> 
> --
> 1.7.9.5

