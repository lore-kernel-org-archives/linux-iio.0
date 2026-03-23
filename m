Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415B391821;
	Mon, 23 Mar 2026 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262857; cv=none; b=KKoSEdpKaVsFPUkZShCgNPNU6BqCxCdUwOoLDYocmHrVVlBorOy0LKnr3FmbYFvEMoDN1QAmW5Q2DXDD95knnYld4rgVrjqY7Xy1vJD2oKeQyxGUzekF5MYAhIB/Ick3fuyPAlowWnwhtOEpc7LxQcVuDcikh9/qA7aZpRdU37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262857; c=relaxed/simple;
	bh=FCKrt2gqpw9wh1RlH7VtYPIeF+zWONfzPOyem6I4+LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1vgXOtz8hk8uacK/GufM9RgTROfZNrk7rI5NoTZlzITfx9R7T3Sk3hgtzOOMdP8t+liXUeAGXo4WG0DEfFaNxDaJjGyLiJhEGjxqxhFSA4wFJhoHLKWmcecy7xqEzZmjcoqDlRYYRBusqioVjRKteedH9AVOvjVMus8yeEWYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/zGzGdm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/zGzGdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774262855; x=1805798855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FCKrt2gqpw9wh1RlH7VtYPIeF+zWONfzPOyem6I4+LE=;
  b=T/zGzGdmP6PKygTbbpur6MtYV7qogqYqvQiG8Iwq8YYjo9sR6UGI85tl
   LFsBcaZkgwIteUwUgIKXopNraAmtPXaohq3H6UN84kcMGf2HqnTRQzUC5
   bpRrRufM/SF7RZBB9s25F8t7FGOA6rmwi67otar8IOG6aOHlddmT5PLcH
   d0TkFnUhaXTkmv+qMpzif1+wcGg739zFGWbjmdzsgh9lFZqkSa1VPnymn
   1gWn3ikunSFDafXUVkDVkg6YERpkq3D+hrPcczWXt/gs604vEPrHWj4kI
   HSMuaLS4tuG1uiblHT7LDWuTR5muQIbpn7bmuT23E4baUpuiKzROv3EDb
   w==;
X-CSE-ConnectionGUID: EiuWewCBSoOUSSDa3ZHIzQ==
X-CSE-MsgGUID: 5RgM0IFFREq54DeB24FYLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="74435227"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74435227"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:47:34 -0700
X-CSE-ConnectionGUID: zmwPpgwsS2uL96bNKL++XA==
X-CSE-MsgGUID: 6lGLvtiITI+5jDMaksciLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223946511"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:47:31 -0700
Date: Mon, 23 Mar 2026 12:47:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
	git@amd.com
Subject: Re: [PATCH v2 1/4] iio: adc: xilinx-xadc: Split driver into core and
 platform files
Message-ID: <acEaQLGOcI5mshsC@ashevche-desk.local>
References: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
 <20260323074505.3853353-2-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323074505.3853353-2-sai.krishna.potthuri@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 01:15:02PM +0530, Sai Krishna Potthuri wrote:
> Split the xilinx-xadc-core.c into separate core and platform specific
> files to prepare for I2C interface support.
> 
> xilinx-xadc-core.c is reorganized as follows:
> xilinx-xadc-core.c:
>   - Platform-independent IIO/ADC operations
>   - Channel definitions and management
>   - Buffer and trigger management
>   - Device tree parsing
> 
> xilinx-xadc-platform.c:
>   - ZYNQ platform (FIFO-based) register access and interrupt handling
>   - AXI platform (memory-mapped) register access and interrupt handling
>   - Platform-specific setup and configuration
>   - Platform device probe function
> 
> Update Kconfig to introduce XILINX_XADC_CORE as a helper module selected
> by XILINX_XADC and update Makefile to build the split modules:
>   - xilinx-xadc-common.o (core + events)
>   - xilinx-xadc-platform.o (platform-specific)
> 
> Reorganized the code and No behavioral changes.

...

> +void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val)
>  {
>  	writel(val, xadc->base + reg);
>  }
> +EXPORT_SYMBOL_GPL(xadc_write_reg);
>  
> -static void xadc_read_reg(struct xadc *xadc, unsigned int reg,
> -	uint32_t *val)
> +void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val)
>  {
>  	*val = readl(xadc->base + reg);
>  }
> +EXPORT_SYMBOL_GPL(xadc_read_reg);

Use namespace.

...

> -static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t mask, uint16_t val)
> +static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)

This is unrelated. Make it a separate change "Switch to use kernel types"
or alike.

...

> -static int xadc_update_scan_mode(struct iio_dev *indio_dev,
> -	const unsigned long *mask)
> +static int xadc_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *mask)

This is unrelated indentation change. Either drop or move to a separate patch.

...

>  	struct xadc *xadc = iio_priv(indio_dev);
> -	size_t n;
>  	void *data;
> +	size_t n;

Ditto.

...

>  static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
>  {
>  	struct xadc *xadc = iio_trigger_get_drvdata(trigger);
> +	unsigned int convst, val;
>  	unsigned long flags;
> -	unsigned int convst;
> -	unsigned int val;
>  	int ret = 0;

This shouldn't be done at all, one variable per line is fine and readable.

...

>  		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC,
> -					convst);
> +					   convst);

Separate patch for indentation.

...

> -static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
> -	const char *name)
> +static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const char *name)

Ditto and anything similar should go to a separate patch.

...


> -static int xadc_postdisable(struct iio_dev *indio_dev)
> +int xadc_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct xadc *xadc = iio_priv(indio_dev);
>  	unsigned long scan_mask;
>  	int ret;

> -	int i;
> +	u32 i;

Why?

>  
>  	scan_mask = 1; /* Run calibration as part of the sequence */
>  	for (i = 0; i < indio_dev->num_channels; i++)

...

> +EXPORT_SYMBOL_GPL(xadc_postdisable);

Add namespace.

...

> +EXPORT_SYMBOL_GPL(xadc_read_samplerate);

Ditto and so on...

...

> -static int xadc_write_samplerate(struct xadc *xadc, int val)
> +int xadc_setup_buffer_and_triggers(struct device *dev, struct iio_dev *indio_dev,
> +				   struct xadc *xadc, int irq)

At this time do you need all three first parameters? I think it may be two or
even one.

> +{
> +	int ret;
> +
> +	if (!(xadc->ops->flags & XADC_FLAGS_BUFFERED))
> +		return 0;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &xadc_trigger_handler,
> +					      &xadc_buffer_ops);
> +	if (ret)
> +		return ret;

> +	if (irq > 0) {

	/* The feature is optional */
	if (irq < 0)
		return 0;

> +		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
> +		if (IS_ERR(xadc->convst_trigger))
> +			return PTR_ERR(xadc->convst_trigger);
> +
> +		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
> +							      "samplerate");
> +		if (IS_ERR(xadc->samplerate_trigger))
> +			return PTR_ERR(xadc->samplerate_trigger);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xadc_setup_buffer_and_triggers);

Namespace.

...

> -static const char * const xadc_type_names[] = {
> +const char * const xadc_type_names[] = {
>  	[XADC_TYPE_S7] = "xadc",
>  	[XADC_TYPE_US] = "xilinx-system-monitor",
>  };

Why this change without export? Is it fine?

...

> +	*ops = device_get_match_data(dev);

> +	if (!*ops)
> +		return ERR_PTR(-ENODEV);

Just drop it. we expect driver to have it.

...

> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>

> +#include <linux/kernel.h>

No driver should use this header (there might be rare exceptions, but not
here).

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

...

> +static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;

Unit suffix?

...

> +#define XADC_ZYNQ_CFG_CFIFOTH_MASK	(0xf << 20)

> +#define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)

Yeah, these all _MASK (here and elsewhere) should use GENMASK().

...

> +static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd, unsigned int n)

Why not u32?

> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < n; i++)

Can be

	for (unsigned int i = 0; i < n; i++)

> +		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
> +}

...

> +static void xadc_zynq_drain_fifo(struct xadc *xadc)
> +{
> +	u32 status, tmp;
> +
> +	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);

	/* Needs a comment explaining why there will be no infinite loop */

> +	while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
> +		xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
> +		xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
> +	}
> +}

...

> +static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
> +{
> +	xadc->zynq_intmask &= ~mask;
> +	xadc->zynq_intmask |= val;

Standard pattern is to have it on a single line

	xadc->zynq_intmask = (xadc->zynq_intmask & ~mask) | (val & mask);

> +	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
> +}

...

> +static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
> +{
> +	u32 cmd[1], tmp;
> +	int ret;
> +
> +	spin_lock_irq(&xadc->lock);

Are you going to use cleanup.h?

> +	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
> +
> +	reinit_completion(&xadc->completion);
> +
> +	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
> +	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
> +	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
> +	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
> +	tmp |= 0 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
> +	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
> +
> +	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
> +	spin_unlock_irq(&xadc->lock);
> +
> +	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
> +	if (ret == 0)
> +		ret = -EIO;
> +	else

> +		ret = 0;

This seems quite wrong. If you use interruptible version, why ignoring the
error codes?

> +	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
> +
> +	return ret;
> +}
> +
> +static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)

u16

> +{
> +	u32 cmd[2], resp, tmp;
> +	int ret;
> +
> +	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
> +	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
> +
> +	spin_lock_irq(&xadc->lock);
> +	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
> +	xadc_zynq_drain_fifo(xadc);
> +	reinit_completion(&xadc->completion);
> +
> +	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
> +	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);

> +	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
> +	tmp |= 1 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;

Are you going to use bitfield.h?

> +	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
> +
> +	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
> +	spin_unlock_irq(&xadc->lock);
> +	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
> +	if (ret == 0)
> +		ret = -EIO;
> +	if (ret < 0)
> +		return ret;

As per above.

> +	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
> +	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
> +
> +	*val = resp & 0xffff;

Unneeded mask.

> +	return 0;
> +}

> +static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
> +{
> +	return ((alarm & 0x80) >> 4) |
> +		((alarm & 0x78) << 1) |
> +		(alarm & 0x07);

One line. Also add a comment explaining this (perhaps with a reference to
datasheet).

> +}

...

> +#define XADC_ZYNQ_TCK_RATE_MAX 50000000
> +#define XADC_ZYNQ_IGAP_DEFAULT 20
> +#define XADC_ZYNQ_PCAP_RATE_MAX 200000000

Unit suffixes?

...

I stopped here. I think what you need is to clean up and modernize the driver
first (see my comments above) and only when it's ready, start splitting it.
The split itself can also be done in a few steps (you can try to prepare
patches with `... -M -C --histogram ...` to see when it will look better).

-- 
With Best Regards,
Andy Shevchenko


