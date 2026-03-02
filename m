Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F993161BA;
	Mon,  2 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455902; cv=none; b=SjOSEVaNS8oWX5B8qZ0oit1epCokYweA782AJJVoTGw/neAszEA5ohVjaQi0NJb9c7GbPfZd9RyqlXb5eXOWWo0l3bQKnykGnbUJsa1/EW02Gcv1R2yGuPLIefE14ybrnQh3EC4Mr5ZVZFpuIzMt/Pg6WxyZmkkYIm9QqjcBOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455902; c=relaxed/simple;
	bh=gTScIVlB6yD/HGUewzWpA2s53no8xM4mEc43zf4KHyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeuDuj0DLttyXhL4RlmbG6hLy1YVpKxAjcv5EOgVaYhszca+bQACphexhx4YcdyZDIppzbm55trRb5fbERNB5wvD+Y37uWwnD0xS8gaJ1TSmhyCQe3Cg8LdLkqQBLsOUAvr1Kj1KwXdCB950dmBlNSi6XkMRxpfPZOmESsQOlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjsJU8hI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjsJU8hI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772455902; x=1803991902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gTScIVlB6yD/HGUewzWpA2s53no8xM4mEc43zf4KHyU=;
  b=mjsJU8hIEQ6xdk3hatXQ9AEDjK0lXk/ILqMbEUgU/a6jj0sEfpc6YZbk
   sfaAUr+aCj8jFyXk78/+6GheyENfTRuerOJSGq7/9IJpHlrJIlsp36UHS
   5It60FWCjr2OCq17GQXwJLJ/PkF69P/Hw9i861OdhA3f5CURBZysMmYq5
   GcDMKn2CepQ9Wr0rjo7KaW32yEK0DwxqXCvnQVKtBBteUi+tiR3FloAKE
   HXmqVJC63WyR4bJJydy5j1OLFL8MWftPL8NcM9SDrT5C1rXPvDi8l8cAK
   N4MqHGTtLBITgTL/0RzUoA35NYGjVFxPkdvXBRRZHgvo2w9mmDCzN1bHD
   A==;
X-CSE-ConnectionGUID: iyzq8IbzQ9ODC0EEYin5uw==
X-CSE-MsgGUID: 6jPccw1rSD+7rnLZbuldHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77073365"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="77073365"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:51:41 -0800
X-CSE-ConnectionGUID: Ha69GzKNS4qzL9iVJaYaDA==
X-CSE-MsgGUID: +C575fO0Rxqzsw5Z0AIGeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="255503986"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:51:37 -0800
Date: Mon, 2 Mar 2026 14:51:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, cosmin.tanislav@analog.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad4130: add new supported parts
Message-ID: <aaWH1wL8odeCmE6w@ashevche-desk.local>
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
 <1d5baeec27724a1c8ebf909c29c3599d583948a1.1772078999.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d5baeec27724a1c8ebf909c29c3599d583948a1.1772078999.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 28, 2026 at 09:39:04AM -0300, Jonathan Santos wrote:
> Add support for AD4129-4/8, AD4130-4, and AD4131-4/8 variants.
> 
> The AD4129 series supports the same FIFO interface as the AD4130 but with
> reduced resolution (16-bit). The AD4131 series lacks FIFO support, so
> triggered buffer functionality is introduced.
> 
> The 4-channel variants feature fewer analog inputs, GPIOs, and sparse pin
> mappings for VBIAS, analog inputs, and excitation currents. The driver now
> handles these differences with chip-specific configurations, including pin
> mappings and GPIO counts.

...

> +static const unsigned int ad4129_reg_size[] = {
> +	[AD4130_STATUS_REG] = 1,
> +	[AD4130_ADC_CONTROL_REG] = 2,
> +	[AD4130_DATA_REG] = 2,
> +	[AD4130_IO_CONTROL_REG] = 2,
> +	[AD4130_VBIAS_REG] = 2,
> +	[AD4130_ID_REG] = 1,
> +	[AD4130_ERROR_REG] = 2,
> +	[AD4130_ERROR_EN_REG] = 2,
> +	[AD4130_MCLK_COUNT_REG] = 1,
> +	[AD4130_CHANNEL_X_REG(0) ... AD4130_CHANNEL_X_REG(AD4130_MAX_CHANNELS - 1)] = 3,
> +	[AD4130_CONFIG_X_REG(0) ... AD4130_CONFIG_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
> +	[AD4130_FILTER_X_REG(0) ... AD4130_FILTER_X_REG(AD4130_MAX_SETUPS - 1)] = 3,
> +	[AD4130_OFFSET_X_REG(0) ... AD4130_OFFSET_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
> +	[AD4130_GAIN_X_REG(0) ... AD4130_GAIN_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
> +	[AD4130_MISC_REG] = 2,
> +	[AD4130_FIFO_CONTROL_REG] = 3,
> +	[AD4130_FIFO_STATUS_REG] = 1,
> +	[AD4130_FIFO_THRESHOLD_REG] = 3,
> +	[AD4130_FIFO_DATA_REG] = 2,
> +};

I hope this passes `make W=1` builds for both clang and GCC.

...

> +static const u8 ad4130_8_pin_map[] = {
> +	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* AIN0/VBIAS_0-AIN7/VBIAS_7 */
> +	0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, /* AIN8/VBIAS_8-AIN15/VBIAS_15 */

These comments are hard to follow. Much better is

> +};

/* Pin mapping for AIN0..AIN15, VBIAS_0..VBIAS_15 */
static const u8 ad4130_8_pin_map[] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,	/* 0 -  7 */
	0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,	/* 8 - 15 */
};

...

>  struct ad4130_chip_info {
>  	const char *name;
>  	unsigned int max_analog_pins;
> +	unsigned int num_gpios;
>  	const struct iio_info *info;
>  	const unsigned int *reg_size;
>  	const unsigned int reg_size_length;
> +	const u8 *pin_map;
> +	bool has_fifo;

Ah, okay, so we fill the potential 4-byte gap from the previous patch.

>  };


...

> +	/* Triggered buffer data structure */
> +	struct {
> +		u32 channels[AD4130_MAX_CHANNELS];
> +		s64 timestamp;

Use aligned_s64 type...

> +	} scan __aligned(8);

...instead of this.

...

> +static irqreturn_t ad4130_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	unsigned int data_reg_size = ad4130_data_reg_size(st);

> +	unsigned int num_en_chn = bitmap_weight(indio_dev->active_scan_mask,
> +						iio_get_masklength(indio_dev));

Split this assignment. It's harder to read in the current form.

> +	struct spi_transfer xfer = {
> +		.rx_buf = st->scan.channels,
> +		.len = data_reg_size * num_en_chn,
> +	};
> +	int ret;
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +err_unlock:
> +	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
>  }

...

> +		/*
> +		 * In continuous read mode, when all samples are read, the data
> +		 * ready signal returns high until the next conversion result is
> +		 * ready. To exit this mode, the command must be sent when data
> +		 * ready is low. In order to ensure that condition, wait for the
> +		 * next interrupt (when the new conversion is finished), allowing
> +		 * data ready to return low before sending the exit command.
> +		 */
> +		st->buffer_wait_for_irq = true;
> +		ret = wait_for_completion_timeout(&st->completion,
> +						  msecs_to_jiffies(1000));
> +		st->buffer_wait_for_irq = false;
> +		if (!ret)
> +			dev_warn(&st->spi->dev, "Conversion timed out\n");

Usage of 'ret' for semantically different (and IIRC unsigned) case is
confusing, perhaps

		st->buffer_wait_for_irq = true;
		if (wait_for_completion_timeout(&st->completion, msecs_to_jiffies(1000))
			dev_warn(&st->spi->dev, "Conversion timed out\n");
		st->buffer_wait_for_irq = false;

-- 
With Best Regards,
Andy Shevchenko


