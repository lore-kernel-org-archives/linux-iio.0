Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41397 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbaFYUks (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jun 2014 16:40:48 -0400
Received: by mail-vc0-f174.google.com with SMTP id hy4so2506245vcb.5
        for <linux-iio@vger.kernel.org>; Wed, 25 Jun 2014 13:40:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1403677773-21141-5-git-send-email-ch.naveen@samsung.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
	<1403677773-21141-5-git-send-email-ch.naveen@samsung.com>
Date: Wed, 25 Jun 2014 13:40:47 -0700
Message-ID: <CAD=FV=WeuFhGK=JNEm20CT73J=c1Zc_dZGQT6bKeob895M+kQA@mail.gmail.com>
Subject: Re: [PATCH 4/4 v2] ARM: DTS: Add NTC thermistor nodes to Exynos5420
 based Peach_PIT
From: Doug Anderson <dianders@chromium.org>
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	Naveen Krishna <naveenkrishna.ch@gmail.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"cpgs ." <cpgs@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen,

On Tue, Jun 24, 2014 at 11:29 PM, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> Exynos5420 based Peach PIT board has 4 NTC thermistors to measure
> temperatures at various points on the board.
>
> IIO based ADC becomes the parent and NTC thermistors are the childs,
> via the HWMON interface.
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> ---
> Changes since v1:
> 1. Arranged the ADC node alphabetical
> 2. Added "status = "okay"" to the ADC node
>
> This patch needs
> 1. MAX77802 PMIC device tree nodes (for ldo9)
>    https://www.mail-archive.com/devicetree@vger.kernel.org/msg31430.html
> 2. Uses the DT documentation for NTC thermistors updated with vendor-prefix
>
> This patch set is tested
> 1. On Peach PIT board via sysfs entry exposed by hwmon
> localhost ~ # cat /sys/class/hwmon/hwmon*/device/temp1_input
> 37436
> 36449
> 38560
> 38059
>
> 2. Backward compatibility is tested by replacing "murata" with "ntc"
>    in the dts nodes and running the above test.
>
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   34 ++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Now that Javier has spun his patch, perhaps you can fold the "pi"
version in here too?

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
