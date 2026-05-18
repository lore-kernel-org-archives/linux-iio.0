Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55703E277F;
	Mon, 18 May 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093076; cv=none; b=aBlUlQZ3GaBEhaVMkmU1ko6q6hKdOWjGmZdTw0EHmvEWOfdT+VvL8sodfpM+Vi9W/aP6zQciFNULGTQYvQJpU/cvDGTxOEYWVCQfGJYrBPJ9KVK6Dts99T9hK5ZvK/CDSSklN+d6LQFw60RbeOv/47InWG+WurWZiQM8aUgXnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093076; c=relaxed/simple;
	bh=AT/hcZdLE85rEbKjXCsWv7uoUnEmpLgdPxCxBS+/9iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5BmxkzjJkjYrp60grEjxlBM9xQ5irILXQHxb38YM2QbQIUZhR7ho9JLVyQ+yr/PKarRlOUfXoA//p98dWzNsI+JCyjtcmKJ78Kj4zabA3+A1u0al3QpzbBxDoNK4hllTyTf/7ZF9Ea5BW4ouPdUHzVX2fBDehuD2AT/onKzRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zk1g/EFx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zk1g/EFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779093074; x=1810629074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AT/hcZdLE85rEbKjXCsWv7uoUnEmpLgdPxCxBS+/9iY=;
  b=Zk1g/EFxRYYY+4hwXO4qPOOslfkx5tS/IlQSLnAQ6AJHo2ATEw9F3Dmw
   WTeTFU0hDkdJAmJ7VEXYsmJJPlha20pjiwPj4cgza12ngt3M0CYy3Sew1
   nArq3mM1q9NQm6ZUgCNdaxePxwV2OGbn6AeEWhpYGgUgUXHseq3dYagRW
   9SWF99jv9YaOfTVv4HX4BTwT6u28NqpzGiF3I2P0Rl97K0NKrbtYI7Vrg
   WEfl6uatdOkj7GDIJrw58JduDOUMGRMLGYxbNs2ZbPDyMZTr+62KOpagM
   CNPlamCg9kQ963BY6F5VG0t0u/fAdTsmQ/Y5QGwdxd6CMZM9kvL+kdBgR
   g==;
X-CSE-ConnectionGUID: BC5u9GxgRua5eTBW9kCu0A==
X-CSE-MsgGUID: yj6QX3pIS4G2MM5Bu8R/5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="97371496"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="97371496"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:31:13 -0700
X-CSE-ConnectionGUID: a6ZfpOllTGSxI3vK/Gw6IQ==
X-CSE-MsgGUID: oVCjaE+bRmS83bVsaVISCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="277458232"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:31:11 -0700
Date: Mon, 18 May 2026 11:31:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Message-ID: <agrOS-sqqldnGGeP@ashevche-desk.local>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-3-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518081852.116909-3-xingyu.wu@starfivetech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 04:18:52PM +0800, Xingyu Wu wrote:
> Add a new IIO ADC driver for the StarFive JHB100 SAR ADC controller.
> 
> The hardware provides 12-bit conversion precision and up to 8 input
> channels. This driver supports single-shot channel reads and exposes
> standard IIO interfaces for raw ADC values, processed voltages, and
> scale reporting. The driver also supports channel monitor mode with
> out-of-bound detection and scan frequency configuration.

Seems like this is just dust off code from ca 2020, as it uses sometimes
quite old APIs (no driver uses in the past few years in IIO!).
This needs much more work, please take your time to go via existing IIO
drivers that were submitted and accepted in 2025/2026 and take them as
examples (may be not the best, but good enough) and update your code
accordingly. Note, reviewing others' patches may help a lot to get
your knowledge up-to-date.

...

> +config STARFIVE_SARADC
> +	tristate "StarFive SARADC driver"
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	depends on COMMON_CLK && RESET_CONTROLLER
> +	help
> +	  Say yes here to build support for the SARADC found in SoCs from
> +	  StarFive.
> +
> +          To compile this driver as a module, choose M here: the
> +          module will be called starfive_saradc.

Indentation issues.

...


Follow IWYU.

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>

> +#include <linux/of.h>

No OF in a new code for the drivers like this one.

> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>

...

> +#define SARADC_VDD_MV_TO_RAW(x)		({ \
> +						((x) == 0) ? 0U : ({ \
> +							u32 _raw = \
> +							(u32)(((u64)(x) * 64000000ULL + \
> +							4514610639ULL) / 30318750ULL); \
> +							_raw > 4095 ? 4095 : _raw; \
> +						}); \
> +					})

This is so ugly! Use your common sense and see tons of the examples around (the
more recent driver is the average better the code is).

...

> +struct starfive_saradc {

Use `pahole` to check the layout, also shuffle members to see what
`bloat-o-meter` says about the resulting binary (for example, moving 'dev' up
might give less code).

> +	void __iomem		*base;
> +	struct device		*dev;
> +	struct clk		*clk;
> +	struct reset_control	*rst;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex		lock;
> +	int			using_ch;
> +	/* flag of interrupts by error or data done */
> +	bool			err;
> +	bool			mon_working;
> +	u8			mon_ch;
> +	bool			mon_en;
> +	u32			up_bounds[SARADC_MAX_CHANNELS];
> +	u32			low_bounds[SARADC_MAX_CHANNELS];
> +};

...

> +static inline void starfive_saradc_irq_clr_all(struct starfive_saradc *priv)
> +{
> +	unsigned int reg = readl(priv->base + SARADC_IRQ_EN_ST);
> +	int i;
> +
> +	starfive_saradc_irq_clr(priv, reg);

> +	for (i = 0; i < SARADC_MAX_CHANNELS; i++)

	for (unsigned int i = 0; i < SARADC_MAX_CHANNELS; i++)


> +		starfive_saradc_data_clr_ch(priv, i);
> +}

...

> +static void starfive_saradc_ch_dis_save(struct starfive_saradc *priv)
> +{
> +	unsigned int reg;
> +
> +	if (priv->mon_en) {
> +		writel(ADC_IRQ_ST_MSK, priv->base + SARADC_IRQ_EN_ST);
> +
> +		reg = readl(priv->base + SARADC_CTRL) & ~ADC_CHAN_EN_MSK;
> +		writel(reg, priv->base + SARADC_CTRL);
> +		priv->mon_working = false;
> +	}
> +
> +	starfive_saradc_irq_clr_all(priv);
> +	msleep(20);

So long sleeps must be explained (in the code comments with the reference to
datasheet or citing it in case of non-public document)!

> +}
> +
> +static void starfive_saradc_ch_start(struct starfive_saradc *priv)
> +{
> +	int ch = priv->using_ch;
> +	unsigned int reg = readl(priv->base + SARADC_CTRL);
> +
> +	/* Enable channel */
> +	reg = (reg & ~ADC_CHAN_EN_MSK) | SARADC_CHAN_EN(ch);
> +	writel(reg, priv->base + SARADC_CTRL);
> +
> +	msleep(20);

Ditto!

> +	/* Enable conversion */
> +	writel(reg | ADC_EN_MSK, priv->base + SARADC_CTRL);
> +}

...

> +static ssize_t starfive_saradc_monitor_channel_show(struct device *dev,
> +						    struct device_attribute *attr,
> +						    char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct starfive_saradc *priv = iio_priv(indio_dev);

> +	return sprintf(buf, "%d\n", priv->mon_ch);

Huh?! Is this driver taken from the ancient times and got just dust off?

> +}

...

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq,
> +				     "failed to get irq\n");

No, we don't do dup messages.

> +	ret = devm_request_threaded_irq(&pdev->dev, irq,
> +					starfive_saradc_irq_handler,
> +					starfive_saradc_mon_stop_threadfn,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					dev_name(&pdev->dev), priv);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to request irq handler\n");

Ditto.

...

> +

Unneeded blank line.

> +module_platform_driver(starfive_saradc_driver);

-- 
With Best Regards,
Andy Shevchenko


