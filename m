Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38733 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab2DMIA4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 04:00:56 -0400
Message-ID: <4F87DD2D.70109@kernel.org>
Date: Fri, 13 Apr 2012 09:00:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/5] ARM: AT91: Add platform data for the AT91 ADCs
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com> <1333641684-20325-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1333641684-20325-2-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/5/2012 5:01 PM, Maxime Ripard wrote:
> The AT91 SoCs often embeds an ADC. This patch adds the needed
> platform data to specify the informations required by the driver
> to work properly.
>
> For now, we only need the reference voltage and which channels
> are available on the board.
Trivial, though I'm in a fussy mood so see below.
>
> Signed-off-by: Maxime Ripard<maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez<patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> ---
>   include/linux/platform_data/at91_adc.h |   23 +++++++++++++++++++++++
>   1 files changed, 23 insertions(+), 0 deletions(-)
>   create mode 100644 include/linux/platform_data/at91_adc.h
>
> diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
> new file mode 100644
> index 0000000..1f71510
> --- /dev/null
> +++ b/include/linux/platform_data/at91_adc.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2011 Free Electrons
> + *
> + * Licensed under the GPLv2 or later.
If we are really being nitpicky, no point in the next blank line!
> + *
> + */
> +
> +#ifndef _AT91_ADC_H_
> +#define _AT91_ADC_H_
> +
> +/**
> + * struct at91_adc_data - platform data for ADC driver
> + * @channels_used:	channels in use on the board as a bitmask
> + * @vref:		Reference voltage for the ADC in millivolts
> + */
> +struct at91_adc_data {
> +	unsigned long	channels_used;
> +	u16		vref;
> +};
> +
> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
> +
> +#endif

