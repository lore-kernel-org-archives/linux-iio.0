Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7F379990;
	Wed, 18 Mar 2026 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821819; cv=none; b=RLDyfSSelJ8VAJoSOooatsKOnVBrb9lvsAi8jsuJOmhBgFXGx/8AzN/B3tFzGUWk8prC9/joGJJuuN2s4ATI/W0iP33xQheKehlMaNYQtzUAzt3jTotSUWGE3OfOwb3/kz8jZPrvslJ1c3uBjCMbK6M+LPxUCssB1LFH4IaDc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821819; c=relaxed/simple;
	bh=SSjbX/oZCVC7F7z2pKEuPTbc+cbByYqZJzcz3d9kuxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+yBwTOJRQG2bSNaotX3BypizJqxm4dgXauKRcVlQ7lZ4CeOHmvIdhER9Ycr4tbPhL0cwvP8OlWTh1DFgRyoULD9P3CyVxmodnbJzvAJ55T62PWP1fQ2dgcoHMVOdrCaYCKbFGLEnx4Xx2UWFoRGpI6GDi8mPxciLy84x/AgKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akfrV6+2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akfrV6+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773821819; x=1805357819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SSjbX/oZCVC7F7z2pKEuPTbc+cbByYqZJzcz3d9kuxI=;
  b=akfrV6+29gEti379DW7HxuK/+fGfYPYrRfVmZ6kmh0h5qSdKTxoChMfU
   BJ5Mt5DQXcE7qYkUEhZKAjRvWbJEToSlXC7QEacHruAeHJhBLSjyKWiZd
   xOCfWRA+OhkJYRibwVQkn6rt2jeqX9ezs4PKicA98nz0FzXhJxDVmUkNF
   KPKGhzmz00yEheDYgxoHW6SXUTg8w5YO9oLaRF2FgzsPfSDHhPsD8F9Xg
   ypTik78q9/TNM3X+SpNZidZTvciEfibk39XF12gnrB8SmAsfI4lxNiGJ3
   AOmXTHAJgLXVE3D/laHjxknP61B957dtj03/QmoF/Z1sIfWHV1U12zZ+D
   g==;
X-CSE-ConnectionGUID: WQxW0pCbTmmssZbaYD39MA==
X-CSE-MsgGUID: QmlRrr93TAexgDfT9OzGlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="75051594"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="75051594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:16:59 -0700
X-CSE-ConnectionGUID: whA4oRNTQyC1pMX7DvDd0Q==
X-CSE-MsgGUID: IBLUXZ6+T4iZtJ1zcQn+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="253026429"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:16:55 -0700
Date: Wed, 18 Mar 2026 10:16:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <abpfdELI33a0Ncl3@ashevche-desk.local>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
 <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 01:13:36PM +0800, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed


> ---
> Changes since v1:
>   - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER

Why was regmap removed?! Was it not used?

>   - Removed all custom ext_info sysfs attributes
>   - Simplified to basic raw read/write and read-only scale
>   - SPI read/write can handle multibyte registers

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>

+ errno.h

> +#include <linux/iio/iio.h>

+ mod_devicetable.h

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/spi/spi.h>

+ types.h

> +#include <linux/unaligned.h>

Follow IWYU principle.

...

> +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct ad5706r_state *st = iio_priv(indio_dev);
> +	u16 reg_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &st->lock) {


Can't it be simply guard()() ?

> +			ret = ad5706r_spi_read(st, AD5706R_REG_DAC_DATA_READBACK_CH(chan->channel),

It's too long line.

> +					       &reg_val);
> +
> +			if (ret)
> +				return ret;
> +
> +			*val = reg_val;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 50;
> +		*val2 = AD5706R_DAC_RESOLUTION;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ad5706r_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val >= AD5706R_DAC_MAX_CODE)

in_range()?

(will need minmax.h)

> +			return -EINVAL;
> +
> +		guard(mutex)(&st->lock);
> +		return ad5706r_spi_write(st,
> +					 AD5706R_REG_DAC_INPUT_A_CH(chan->channel),
> +					 val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


