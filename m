Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:59734 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdIMMJr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Sep 2017 08:09:47 -0400
Subject: Re: [PATCH v1 02/10] clk: at91: pmc: Save SCSR during suspend
To: Romain Izard <romain.izard.pro@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
 <20170908153604.28383-3-romain.izard.pro@gmail.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Message-ID: <318420d4-044f-d018-f70e-3ed4fcfb0fd0@microchip.com>
Date: Wed, 13 Sep 2017 14:10:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170908153604.28383-3-romain.izard.pro@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/09/2017 at 17:35, Romain Izard wrote:
> The contents of the System Clock Status Register (SCSR) needs to be
> restored into the System Clock Enable Register (SCER).
> 
> As the bootloader will restore some clocks by itself, the issue can be
> missed as only the USB controller, the LCD controller, the Image Sensor
> controller and the programmable clocks will be impacted.
> 
> Fix the obvious typo in the suspend/resume code, as the IMR register
> does not need to be saved twice.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Yes, it looks like a typo:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I didn't experienced the issue with LCD nor USB though.

Regards,

> ---
>  drivers/clk/at91/pmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 5c2b26de303e..07dc2861ad3f 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -86,7 +86,7 @@ static int pmc_suspend(void)
>  {
>  	int i;
>  
> -	regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.scsr);
> +	regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
>  	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
>  	regmap_read(pmcreg, AT91_CKGR_UCKR, &pmc_cache.uckr);
>  	regmap_read(pmcreg, AT91_CKGR_MOR, &pmc_cache.mor);
> @@ -129,7 +129,7 @@ static void pmc_resume(void)
>  	if (pmc_cache.pllar != tmp)
>  		pr_warn("PLLAR was not configured properly by the firmware\n");
>  
> -	regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.scsr);
> +	regmap_write(pmcreg, AT91_PMC_SCER, pmc_cache.scsr);
>  	regmap_write(pmcreg, AT91_PMC_PCER, pmc_cache.pcsr0);
>  	regmap_write(pmcreg, AT91_CKGR_UCKR, pmc_cache.uckr);
>  	regmap_write(pmcreg, AT91_CKGR_MOR, pmc_cache.mor);
> 


-- 
Nicolas Ferre
