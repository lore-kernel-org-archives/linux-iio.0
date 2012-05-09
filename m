Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:37437 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489Ab2EINEu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 09:04:50 -0400
Message-ID: <4FAA6B6C.5080406@cam.ac.uk>
Date: Wed, 09 May 2012 14:04:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas@free-electrons.com, patrice.vilchez@atmel.com,
	nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Subject: Re: [PATCH 1/9] ARM: AT91: Add platform data for the AT91 ADCs
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com> <1336554366-16957-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336554366-16957-2-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/9/2012 10:05 AM, Maxime Ripard wrote:
> The AT91 SoCs often embeds an ADC. This patch adds the needed
> platform data to specify the informations required by the driver
> to work properly.
>
> For now, we only need the reference voltage and which channels
> are available on the board.
One utterly trivial element inline.
> Signed-off-by: Maxime Ripard<maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   include/linux/platform_data/at91_adc.h |   61 ++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>   create mode 100644 include/linux/platform_data/at91_adc.h
>
> diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
> new file mode 100644
> index 0000000..f9e2f00
> --- /dev/null
> +++ b/include/linux/platform_data/at91_adc.h
> @@ -0,0 +1,61 @@
> +/*
> + * Copyright (C) 2011 Free Electrons
> + *
> + * Licensed under the GPLv2 or later.
> + */
> +
> +#ifndef _AT91_ADC_H_
> +#define _AT91_ADC_H_
> +
> +/**
> + * struct at91_adc_reg_desc - Various informations relative to registers
> + * @channel_base:	Base address for the channel data registers
> + * @drdy_mask:		Mask of the DRDY field in the relevant registers
> +			(Interruptions registers mostly)
> + * @status_register:	Address of the Interrupt Status Register
> + * @trigger_register:	Address of the Trigger setup register
> + */
> +struct at91_adc_reg_desc {
> +	u8	channel_base;
> +	u32	drdy_mask;
> +	u8	status_register;
> +	u8	trigger_register;
> +};
> +
> +/**
> + * struct at91_adc_trigger - description of triggers
> + * @name:		name of the trigger advertised to the user
> + * @value:		value to set in the ADC's mode register to enable
> +			the trigger
> + * @is_external:	is the trigger relies on an external pin ?
no space before the ? (nitpick of the day ;)
> + */
> +struct at91_adc_trigger {
> +	const char	*name;
> +	u8		value;
> +	bool		is_external;
> +};
> +
> +/**
> + * struct at91_adc_data - platform data for ADC driver
> + * @channels_used:		channels in use on the board as a bitmask
> + * @num_channels:		global number of channels available on the board
> + * @registers:			Registers definition on the board
> + * @startup_time:		startup time of the ADC in microseconds
> + * @trigger_list:		Triggers available in the ADC
> + * @trigger_number:		Number of triggers available in the ADC
> + * @use_external_triggers:	does the board has external triggers availables
> + * @vref:			Reference voltage for the ADC in millivolts
> + */
> +struct at91_adc_data {
> +	unsigned long			channels_used;
> +	u8				num_channels;
> +	struct at91_adc_reg_desc	*registers;
> +	u8				startup_time;
> +	struct at91_adc_trigger		*trigger_list;
> +	u8				trigger_number;
> +	bool				use_external_triggers;
> +	u16				vref;
> +};
> +
> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
> +#endif

