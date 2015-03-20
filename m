Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:36501 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbbCTOFm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2015 10:05:42 -0400
Received: by wetk59 with SMTP id k59so82986199wet.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2015 07:05:41 -0700 (PDT)
Message-ID: <550C2931.3010702@linaro.org>
Date: Fri, 20 Mar 2015 15:05:37 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
CC: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org,
	jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
	knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 1/6] clocksource/sh_cmt.c: Fix !HAS_IOMEM build
References: <1426541230-928-1-git-send-email-richard@nod.at>
In-Reply-To: <1426541230-928-1-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/16/2015 10:27 PM, Richard Weinberger wrote:
> Fixes:
> drivers/clocksource/sh_cmt.c: In function ‘sh_cmt_map_memory’:
> drivers/clocksource/sh_cmt.c:920:2: error: implicit declaration of function ‘ioremap_nocache’ [-Werror=implicit-function-declaration]
>    cmt->mapbase = ioremap_nocache(mem->start, resource_size(mem));
>    ^
> drivers/clocksource/sh_cmt.c:920:15: warning: assignment makes pointer from integer without a cast [enabled by default]
>    cmt->mapbase = ioremap_nocache(mem->start, resource_size(mem));
>                 ^
> drivers/clocksource/sh_cmt.c: In function ‘sh_cmt_setup’:
> drivers/clocksource/sh_cmt.c:1034:2: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
>    iounmap(cmt->mapbase);
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---

Applied to my tree for v4.0 fix.

Thanks !


>   drivers/clocksource/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 68161f7..c948f4e 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -192,6 +192,7 @@ config SYS_SUPPORTS_EM_STI
>   config SH_TIMER_CMT
>   	bool "Renesas CMT timer driver" if COMPILE_TEST
>   	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
>   	default SYS_SUPPORTS_SH_CMT
>   	help
>   	  This enables build of a clocksource and clockevent driver for
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

