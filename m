Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33776 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbcECR6Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2016 13:58:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so2376630pfb.0
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2016 10:58:24 -0700 (PDT)
Subject: Re: [PATCH 3/4] iio: st_sensors: verify interrupt event to status
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <cdleonard@gmail.com>
Message-ID: <5728E6C2.1050901@gmail.com>
Date: Tue, 3 May 2016 20:58:26 +0300
MIME-Version: 1.0
In-Reply-To: <1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/24/2016 03:18 PM, Linus Walleij wrote:
> This makes all ST sensor drivers check that they actually have
> new data available for the requested channel(s) before claiming
> an IRQ, by reading the status register (which is conveniently
> the same for all ST sensors) and check that the channel has new
> data before proceeding to read it and fill the buffer.
> 
> This way sensors can share an interrupt line: it can be flaged
> as shared and then the sensor that did not fire will return
> NO_IRQ, and the sensor that fired will handle the IRQ and
> return IRQ_HANDLED.
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 2ce0d2a3f855..c55898543a47 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -58,6 +58,24 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> +	/* If we have a status register, check if this IRQ came from us */
> +	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
> +		u8 status;
> +
> +		len = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> +			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
> +			   &status);
> +		if (len < 0)
> +			dev_err(sdata->dev, "could not read channel status\n");
> +
> +		/*
> +		 * If this was not caused by any channels on this sensor,
> +		 * return IRQ_NONE
> +		 */
> +		if (!(status & (u8)indio_dev->active_scan_mask[0]))
> +			return IRQ_NONE;
> +	}
>
This seems to break software trigger mode when the timer frequency is
higher that the device polling frequency. In that case it is possible to
poll multiple times between updates and the first time this happens
further updates hang.

Even with hardware triggers: are you sure this is correct? Shouldn't
iio_trigger_notify_done still get called even when there is nothing to do?

-- 
Regards,
Leonard
