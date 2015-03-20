Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37262 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbCTOE4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2015 10:04:56 -0400
Received: by wixw10 with SMTP id w10so21574637wix.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2015 07:04:55 -0700 (PDT)
Message-ID: <550C2904.3040702@linaro.org>
Date: Fri, 20 Mar 2015 15:04:52 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
CC: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org,
	jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
	knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 2/6] clocksource/sh_mtu2.c: Fix !HAS_IOMEM build
References: <1426541230-928-1-git-send-email-richard@nod.at> <1426541230-928-2-git-send-email-richard@nod.at>
In-Reply-To: <1426541230-928-2-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/16/2015 10:27 PM, Richard Weinberger wrote:
> Fixes:
> drivers/clocksource/sh_mtu2.c: In function ‘sh_mtu2_map_memory’:
> drivers/clocksource/sh_mtu2.c:391:2: error: implicit declaration of function ‘ioremap_nocache’ [-Werror=implicit-function-declaration]
>    mtu->mapbase = ioremap_nocache(res->start, resource_size(res));
>    ^
> drivers/clocksource/sh_mtu2.c:391:15: warning: assignment makes pointer from integer without a cast [enabled by default]
>    mtu->mapbase = ioremap_nocache(res->start, resource_size(res));
>                 ^
> drivers/clocksource/sh_mtu2.c: In function ‘sh_mtu2_setup’:
> drivers/clocksource/sh_mtu2.c:448:2: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
>    iounmap(mtu->mapbase);
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---

Thanks applied to my tree for v4.0 fix.

>   drivers/clocksource/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index c948f4e..c4063a6 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -202,6 +202,7 @@ config SH_TIMER_CMT
>   config SH_TIMER_MTU2
>   	bool "Renesas MTU2 timer driver" if COMPILE_TEST
>   	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
>   	default SYS_SUPPORTS_SH_MTU2
>   	help
>   	  This enables build of a clockevent driver for the Multi-Function
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

