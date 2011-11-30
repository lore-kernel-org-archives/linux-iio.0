Return-Path: <nicolas.ferre@atmel.com>
Message-ID: <4ED5FB2D.5090900@atmel.com>
Date: Wed, 30 Nov 2011 10:45:17 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        Patrice Vilchez <patrice.vilchez@atmel.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
References: <1322644502-18160-1-git-send-email-maxime.ripard@free-electrons.com> <1322644502-18160-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1322644502-18160-2-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Maxime,

On 11/30/2011 10:15 AM, Maxime Ripard :
> Cc: Patrice Vilchez<patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>

"CC:" lines should not be located here: place them just *after*
"Signed-off-by:" and "Acked-by:" lines.

> Signed-off-by: Maxime Ripard<maxime.ripard@free-electrons.com>
> Acked-by: Jonathan Cameron<jic23@cam.ac.uk>
> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> ---
>   include/linux/platform_data/at91_adc.h |   36 ++++++++++++++++++++++++++++++++
>   1 files changed, 36 insertions(+), 0 deletions(-)
>   create mode 100644 include/linux/platform_data/at91_adc.h
>
> diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
> new file mode 100644
> index 0000000..1e1813d
> --- /dev/null
> +++ b/include/linux/platform_data/at91_adc.h
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (C) 2011 Free Electrons
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Can be shorten in:
"Licensed under GPLv2."
"Licensed under the GPL v2."
"License terms: GNU General Public License (GPL) version 2."

> + *
> + */
> +
> +#ifndef _AT91_ADC_H_
> +#define _AT91_ADC_H_
> +
> +struct at91_adc_data {
> +	/* ADC Clock as specified by the datasheet, in Hz. */
> +	unsigned int adc_clock;
> +	/*
> +	 * Global number of channels available (to specify which channels are
> +	 * indeed used on the board, see the channels_used bitmask).
> +	 */
> +	u8 num_channels;
> +	/* Channels in use on the board as a bitmask */
> +	unsigned long channels_used;
> +	/* Startup time of the ADC, in microseconds. */
> +	u8 startup_time;
> +	/* Reference voltage for the ADC in millivolts */
> +	unsigned short vref;
> +};
> +
> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
> +
> +#endif

I think that now it is located at this generic directory, it can easily 
go mainline through IIO subsystem (patches 1 and 2/3): Jonathan, do you 
agree with this?

Best regards,
-- 
Nicolas Ferre
