Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:57410 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752793Ab1LNK1X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2011 05:27:23 -0500
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
Date: Wed, 14 Dec 2011 11:27:20 +0100
Message-ID: <77881664.jmuBXsRUXo@ws-stein>
In-Reply-To: <1323856877-18255-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1323856877-18255-1-git-send-email-maxime.ripard@free-electrons.com> <1323856877-18255-2-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday 14 December 2011 11:01:15 Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  include/linux/platform_data/at91_adc.h |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/platform_data/at91_adc.h
> 
> diff --git a/include/linux/platform_data/at91_adc.h
> b/include/linux/platform_data/at91_adc.h new file mode 100644
> index 0000000..bad80b7
> --- /dev/null
> +++ b/include/linux/platform_data/at91_adc.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2011 Free Electrons
> + *
> + * Licensed under the GPLv2 or later.
> + *
> + */
> +
> +#ifndef _AT91_ADC_H_
> +#define _AT91_ADC_H_
> +
> +/**
> + * struct at91_adc_data - platform data for ADC driver
> + * @channels_use:	channels in use on the board as a bitmask
> + * @vref:		Reference voltage for the ADC in millvolts

Nitpick, this should write millivolts, no?

> + */
> +struct at91_adc_data {
> +	unsigned long	channels_used;
> +	u16		vref;
> +};
> +
> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
> +
> +#endif

Regards,
Alexander
