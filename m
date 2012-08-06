Return-Path: <shawn.guo@linaro.org>
Date: Mon, 6 Aug 2012 10:37:45 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Marek Vasut <marex@denx.de>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Jonathan Cameron <jic23@kernel.org>, Juergen Beisert <jbe@pengutronix.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 2/3 V2] IIO: Add basic MXS LRADC driver
Message-ID: <20120806023743.GC18471@S2101-09.ap.freescale.net>
References: <1344007721-11595-1-git-send-email-marex@denx.de>
 <1344007721-11595-3-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1344007721-11595-3-git-send-email-marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Aug 03, 2012 at 05:28:40PM +0200, Marek Vasut wrote:
> --- /dev/null
> +++ b/drivers/staging/iio/adc/mxs-lradc.c

<snip>

> +#include <mach/mxs.h>
> +#include <mach/common.h>
> +
Why do you need these two mach headers?

-- 
Regards,
Shawn
