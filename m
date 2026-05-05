Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF23793B3;
	Tue,  5 May 2026 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970715; cv=none; b=nk0RXZmUqFJHf495QTERO9VPvyofrk1z2C5ohCp94mT3H5C/zb6v24cWiq4J2n1+SnoYjaJMgWMJdFr1GjWhkkWVhgXw7qwdIx5adnRbuNxmXfnOphVs9JUCXhYkg1kGWg1tMjIEsSkTbmiyyKsfABerAaPgzdTniRZCBRuhClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970715; c=relaxed/simple;
	bh=TMDCpTWMAj+qHdIIGI4JmLHxDIMLsB6RWL1vo0UQJrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRy/LMolMhco0fkALakBUjaAblVJbRpsnAhH9t3a4oiRnPAGNzwXcP4UVqYJuaF9Oxq4xBNm4uS1WmryZ1o949uf4ZXdfiivUl/N4qjKin9VrGMfmMxDhhfgJI6sddsSAOsFxeWSTjdBeTiiwwsBdz60ezwGpi9j9leu2w+LhTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAaQJNuU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAaQJNuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777970714; x=1809506714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TMDCpTWMAj+qHdIIGI4JmLHxDIMLsB6RWL1vo0UQJrg=;
  b=RAaQJNuU9dtvWg8TK4mkyl7HpCC8A69FZvRt8SI1ETdrZY7I01Ci2Qrj
   RgScWO3mpnzp2dAsE4AwFwK2CzSltZzqrTfRpCW/dezRlpaINTwswmm7J
   HsgKGEr5CB5KJpnfBWm7JFNupEcVswCvZOqQfURDygYfpAC2w1be1mrQT
   eKC11TxLxY+tyhIdyW0SsHeiXQzg+dcdlNzutqFFjfEQV1FBZRgFr2CUx
   tWCVqUnf7BQdAddhhp3HkeB/Bfth+TtNkKeGrf0YjrfNLyBwjYnsLPLAJ
   prdB80A2l+jyLYtXloHH7y0XSXWWOGgd3PguDweZpquq7LJLSN2dknyhl
   g==;
X-CSE-ConnectionGUID: 38Tpi6kMT72Nht8CshEqrw==
X-CSE-MsgGUID: LUaOxocXRTSP2oFPCHP6Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78859656"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78859656"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:45:14 -0700
X-CSE-ConnectionGUID: ZueXutVxScuiafrom2uXTQ==
X-CSE-MsgGUID: HaBZbaj/T7yAPFlq0lDHIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240733294"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:45:09 -0700
Date: Tue, 5 May 2026 11:45:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: Re: [PATCH 10/10] iio: dac: add mcf54415 DAC
Message-ID: <afmuE5YZmfKKeoVQ@ashevche-desk.local>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
 <20260504-wip-stmark2-dac-v1-10-874c36a4910d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-wip-stmark2-dac-v1-10-874c36a4910d@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 07:16:48PM +0200, Angelo Dureghello wrote:

> Add basic version of mcf54415 DAC driver. DAC is embedded in the cpu and
> DAC configuration registers are mapped in the internal IO address space.
> 
> The DAC accepts a 12-bit digital signal and creates a monotonic 12-bit
> analog output varying from ~DAC_VREFL to ~DAC_VREFH. The DAC module
> consists of a conversion unit, an output amplifier, and the associated
> digital control blocks. DAC_VREFL and DAC_VREFH defaults respectivley to
> 0 and 0xfff.
> 
> This initial version of the driver is minimalistic, "output raw" only, to
> be extended in the future. DMA and external sync are disabled, default mode
> is high speed, default format is right-justified 12bit on 16bit word.

The below doesn't make much sense in the commit message (author must contribute
the tested code), but for the record in the comments block it might be useful
when one digs the lore ML archives.

> Basic tests done on stmark2 mcf54415-based board, voltage check on DAC0:
> 
> /sys/bus/iio/devices/iio:device0 # ls
> name                 out_voltage_raw      subsystem
> out_conversion_mode  out_voltage_scale    uevent
> 
> /sys/bus/iio/devices/iio:device0 # cat name
> mcf54415_dac.0
> 
> /sys/bus/iio/devices/iio:device0 #
> 
> echo 4095 > out_voltage_raw     => voltage abt 3.3V by oscilloscope
> echo 4096 > out_voltage_raw     => roll over to 0V
> echo 0 > out_voltage_raw        => voltage is 0V
> echo 2048 > out_voltage_raw     => voltage is abt 1.7V, mid scale
> 
> Same behavior for /sys/bus/iio/devices/iio:device1.
> 
> Generated a sine wave by shell script, sine shape is good.


^^^ See above.

> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Put that here.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>

Follow IWYU. At least the headers for __iomem, ARRAY_SIZE() are missing.

...

> +	int val;

Why signed?

> +	/* Keeping defaults and enable DAC (bit 0 set to 0) */
> +	val = MCF54415_DAC_CR_FILT;
> +	val |= FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);

Why two lines?

	val = MCF54415_DAC_CR_FILT | FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);

even fits 80 limit.

> +	writew(val, info->regs + MCF54415_DAC_CR);
> +
> +	/* DAC is ready after 12us, from RM table 40-3  */
> +	fsleep(MCF54415_DAC_READY_US);

...

> +#define MCF54415_DAC_CHAN { \

Move { to a separate line.

> +	.type = IIO_VOLTAGE, \
> +	.output = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +}

...

> +static const struct iio_chan_spec mcf54415_dac_iio_channels[] = {
> +	MCF54415_DAC_CHAN

Use trailing commas when it's not a terminator.

> +};

...

> +static int mcf54415_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2,
> +			long mask)
> +{
> +	struct mcf54415_dac *info = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = readw(info->regs + MCF54415_DAC_DATA);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Reference voltage as per ColdFire datasheet is 3.3V */
> +		*val = 3300 /* mV */;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}

> +	return 0;

Dead code.

> +}

...

> +static int mcf54415_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,

> +			int val, int val2,
> +			long mask)

One line.

> +{
> +	struct mcf54415_dac *info = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		writew(val, info->regs + MCF54415_DAC_DATA);
> +		return 0;

> +

Already mentioned: Stray blank line.

> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> +					  sizeof(struct mcf54415_dac));

Use

	struct device *dev = &pdev->dev;

to make it neater. Also it's more robust to use sizeof(*).

	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));

> +	if (!indio_dev)
> +		return -ENOMEM;

...

> +static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops, mcf54415_dac_suspend,
> +				mcf54415_dac_resume);

Use logical split:

static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops,
				mcf54415_dac_suspend,
				mcf54415_dac_resume);

OR

static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops,
				mcf54415_dac_suspend, mcf54415_dac_resume);

-- 
With Best Regards,
Andy Shevchenko


