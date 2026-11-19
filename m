Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081498;
	b=IivDoN442gtusItjaQdblWwkZo83PGIL2IlAwRzLf4GdgIa7cvx16soRsdJIaFy4iOc7
	 lmQ7U9tPhbxEV2mklp19gDx5Io/ucutPivw8Ewd1qWXLILcfkY4mrkcEz7vW2m3p2pa9i
	 SrhGn2c5hNzGwGiQ2xXUB9PVWBhbt2mONtazncOAe3KhjXPSZbM02f1V4rPvOXg02EUNi
	 oqeB4WX6w0lGT35cWi1VOI9gwdAYLDg1+Sbf+/3ORDezXBg7EBm2xGTpBIWuM5OAfGhKY
	 NyTskUqvKGL9OyOA9Ol8IzhPzZHhVoBEYbOqWsDrhei/bK44Z1z150q7q7jMuTCjZaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081498;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=YqeiPLfNjKXmPyvzUWMnk9Cqa9JDVTCN0McxrwDNA9g=;
	b=pKqvxdHtzME9HrsrlvQ2KrZvnni4+/l8nQvF/ivVqqU/5PvHoo/BlGC5R6OcqgL8O37E
	 sWigKgiBvC9lUp0KVZWuKEahDyTIoGTY/6Ugp9DjUHLs21gI0tzzFq3JEmUiELMZtLmYg
	 eKi4sNqc5Od/EcnQ/2QPs/e7eIew/T/uaz2S3YUILOuVx1kEKEW8bR3oZenNFe7bpRxpv
	 b1f1r8QCVgDFWaClnBTJ/5UGqF5rNUG+BQAZr+2VPoSAoT3/5Z+ozj1JMeMgQ+z/5SXit
	 VVxnIA89XV4DM5A/TDFHhOzVpSLYGwt5PZkgMsstZN9o8SJTWuEG2woGNwlxnE4IEnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dZBqQmoP;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C0606A320;
	Thu, 19 Nov 2026 09:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9C0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dZBqQmoP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795081496; x=1826617496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GrxUehPYuAdZ9/RKMpHXF+LGSfBV45QK6OO7c7G2neU=;
  b=dZBqQmoPX32TQKYS5VESwyGGqAmIIgcBF8yg1cKQFA7ZexWky8NYtBjw
   cFU0LnOVlxTSCAlnQe7Mokd6KTYhkPVwKzz/R+52pMdpRHn4bX+Uxg5lX
   OMzVfxaR7mp3ulZRW/S+cV4s7353Gtk9bxTWaMdmA48Wd4IEpDATQ5PyY
   PBigPQ7+jBfv/E0FxblNtpVhj2q9ScTlIje2MgFUev91ollQ/W6hZ0SIp
   Gzgw3e5Je/xOUz95yOg0d11j6B/t6zWPpMgc+vVGZ+Ck34qnhAjRa6IpC
   rfEx3MjmgnIeoETDrMleB9iiNH1QMrkTBFdHL0dHCO3Lgjac9GW/bs6o0
   Q==;
X-CSE-ConnectionGUID: tPn9xoR3QNOq68JPEy/vEQ==
X-CSE-MsgGUID: 4Qn5kw30R/a5HKH73ymddQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3815558"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3815558"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:44:54 -0800
X-CSE-ConnectionGUID: KydEFDI0RQGTZj/DOyvsjA==
X-CSE-MsgGUID: Sh455h9HQyyJ4OnK67pEcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10196106"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:44:47 -0800
Date: Thu, 19 Nov 2026 11:44:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 02/11] iio: adc: stm32-mdf: add core registration
Message-ID: <av7FDVDUH9EvNJmQ@ashevche-desk.local>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 04:17:47PM +0100, Olivier Moysan wrote:
> The STM32 multifunction digital filter (MDF) shares its register bank,
> kernel clock and power resources between serial interfaces and digital
> filters. Add a core driver to manage these common resources on STM32MP2.
> 
> Check the number of filter actually supported from identification
> registers.

...

> +config STM32_MDF_CORE
> +	tristate "STMicroelectronics STM32 MDF core"
> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST

Why OF?

> +	depends on COMMON_CLK

> +	select REGMAP

Redundant.

> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable the driver for STMicroelectronics
> +	  STM32 Multi-function Digital Filter for sigma delta converter.
> +
> +	  This driver can also be built as a module. If so, the module
> +		  will be called stm32-mdf.

Broken indentation in the last line.

...

> +/*
> + * This file is part of STM32 MDF driver

Better to be more explicit. "This is the core part of ..."

> + * Copyright (C) 2023-2026, STMicroelectronics - All Rights Reserved
> + * Author: Olivier Moysan <olivier.moysan@foss.st.com>.
> + */

...

> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/module.h>

> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>

Oh, really all of them are required?

> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>

Missing types.h at least. Please follow IWYU principle.

> +#include "stm32-mdf.h"

...

> +static bool stm32_mdf_core_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * In MDF_CKGCR_REG register only CKGACTIVE bit is volatile. MDF_CKGCR_REG is not marked
> +	 * as volatible to ease the suspend/resume case, and benefit from the regcache API.
> +	 * Access to CKGACTIVE bit is managed specifically instead.
> +	 */

Why file is using 80 limit and comments 100? Be consistent!

> +	return false;
> +}

...

> +static const struct regmap_config stm32_mdf_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = MDF_SIDR_REG,
> +	.readable_reg = stm32_mdf_core_readable_reg,
> +	.volatile_reg = stm32_mdf_core_volatile_reg,
> +	.writeable_reg = stm32_mdf_core_writeable_reg,
> +	.num_reg_defaults_raw = MDF_SIDR_REG / sizeof(u32) + 1,

ARRAY_SIZE()?

> +	.fast_io = true,
> +	.cache_type = REGCACHE_FLAT,
> +};

...

> +struct stm32_mdf_priv {
> +	struct stm32_mdf mdf;

> +	struct platform_device *pdev;

Why?!

> +	struct regmap *regmap;

> +	struct clk *kclk;
> +	void __iomem *base;
> +	phys_addr_t phys_base;
> +	atomic_t n_active_ch;
> +	spinlock_t lock; /* Manage common resources race conditions */
> +	unsigned long kclk_rate;

Units? _Hz? Why not group it with kclk above?

> +	bool exclusive_flg;
> +};

...

> +static inline struct stm32_mdf_priv *to_stm32_mdf_priv(struct stm32_mdf *mdf)
> +{
> +	return container_of(mdf, struct stm32_mdf_priv, mdf);

+ container_of.h

> +}

...

> +int stm32_mdf_core_start_mdf(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
> +	struct device *dev = &priv->pdev->dev;
> +	int ret;

> +	u32 val;

regmap uses unsigned int.

> +
> +	if (atomic_inc_return(&priv->n_active_ch) == 1) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			goto err;
> +
> +		/* Enable PROCDIV and CCKDIV clock dividers */
> +		ret = regmap_set_bits(priv->regmap, MDF_CKGCR_REG, MDF_CKG_CKGDEN);
> +		if (ret < 0)
> +			goto pm_put;
> +
> +		/* Check clock status. Bypass cache to access volatile CKGACTIVE active bit */
> +		regcache_cache_bypass(priv->regmap, true);
> +		regmap_read(priv->regmap, MDF_CKGCR_REG, &val);
> +		regcache_cache_bypass(priv->regmap, false);
> +		if (!(val & MDF_CKG_ACTIVE)) {
> +			ret = -EINVAL;
> +			dev_err(dev, "MDF clock not active\n");
> +			goto pm_put;
> +		}
> +
> +		if (!priv->exclusive_flg) {
> +			clk_rate_exclusive_get(priv->kclk);
> +			priv->exclusive_flg = true;
> +		}
> +	}
> +
> +	return 0;
> +
> +pm_put:
> +	pm_runtime_put_sync(dev);
> +err:
> +	atomic_dec(&priv->n_active_ch);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_core_start_mdf);

No namespace?

...

> +int stm32_mdf_core_trigger(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
> +	int ret;
> +	u32 val;

As per above.

> +	guard(spinlock)(&priv->lock);
> +
> +	/* Bypass cache to access TRGO volatile bit */
> +	regcache_cache_bypass(priv->regmap, true);
> +
> +	ret = regmap_read(priv->regmap, MDF_GCR_REG, &val);
> +	if (ret < 0)

Why ' < 0' ?

> +		goto err;
> +
> +	if (val & MDF_GCR_TRGO) {
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	ret = regmap_set_bits(priv->regmap, MDF_GCR_REG, MDF_GCR_TRGO);
> +
> +err:
> +	regcache_cache_bypass(priv->regmap, false);
> +
> +	return ret;
> +}

...

> +int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);

> +	int ret = 0;

Top assignments like this one is harder to maintain. And they might
lead to subtle errors.

> +	if (atomic_dec_and_test(&priv->n_active_ch)) {
> +		if (priv->exclusive_flg) {
> +			clk_rate_exclusive_put(priv->kclk);
> +			priv->exclusive_flg = false;
> +		}
> +
> +		ret = regmap_clear_bits(priv->regmap, MDF_CKGCR_REG, MDF_CKG_CKGDEN);
> +
> +		pm_runtime_put_sync(&priv->pdev->dev);

		return ret;

> +	}
> +
> +	return ret;

	return 0;

> +}

...

> +static int stm32_mdf_core_parse_of(struct platform_device *pdev, struct stm32_mdf_priv *priv)

Oh my... In the name _of_ is present, in the code device property API is used,
the inclusion block includes set of rarely required of_*.h! Please, fix this
mess.

> +{
> +	struct device_node *node = pdev->dev.of_node;

Why?!

> +	struct reset_control *rst;
> +	struct device *dev = &pdev->dev;
> +	u32 count;
> +	int ret;

> +	if (!node)
> +		return -EINVAL;

Do we really need this (or at least why here?)?

> +	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset controller\n");
> +
> +	ret = reset_control_reset(rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset MDF\n");
> +
> +	ret = stm32_mdf_core_parse_clocks(pdev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (device_property_present(&pdev->dev, "st,interleave")) {
> +		ret = device_property_read_u32(dev, "st,interleave", &count);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read interleaved filter count\n");
> +
> +		if (count < 2 || count > 8 || count > priv->mdf.nbf)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid interleaved filter count [%u]\n", count);
> +
> +		priv->mdf.nb_interleave = count;
> +
> +		/* Configure GCR */
> +		ret = regmap_update_bits(priv->regmap, MDF_GCR_REG,
> +					 MDF_GCR_ILVNB_MASK,
> +					 FIELD_PREP(MDF_GCR_ILVNB_MASK, count - 1));
> +	}

> +	return ret;

This is unusual. Just make return early and return 0 on success.

> +}

...

> +static const struct of_device_id stm32_mdf_of_match[] = {
> +	{ .compatible = "st,stm32mp23-mdf", .data = (void *)STM32_MDF_MP23_FILTER_NB },
> +	{ .compatible = "st,stm32mp25-mdf" },

Make both provide chip_info and not some constant.

> +	{}

Follow the common style (space inside).

> +};

...

> +static int stm32_mdf_core_identification(struct platform_device *pdev, struct stm32_mdf_priv *priv)
> +{
> +	struct stm32_mdf *mdf = &priv->mdf;
> +	u32 val;
> +	int ret;
> +
> +	/* If filter number is explicitly defined, don't check identification registers */
> +	mdf->nbf = ((unsigned long)device_get_match_data(&pdev->dev));

Outer parentheses make no sense at all.

> +	if (mdf->nbf)
> +		return 0;

No, return -ENODATA and make sure you provide chip_info for all of
the components.

> +	ret = regmap_read(priv->regmap, MDF_IPIDR_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val == STM32MP25_MDF_IPIDR_NUMBER) {
> +		ret = regmap_read(priv->regmap, MDF_HWCFGR_REG, &val);
> +		if (ret)
> +			return ret;
> +
> +		mdf->nbf = FIELD_GET(MDF_HWCFGR_NBF_MASK, val);
> +
> +		ret = regmap_read(priv->regmap, MDF_VERR_REG, &val);

This ret is not used?

> +		dev_dbg(&pdev->dev, "MDF version: %lu.%lu\n", FIELD_GET(MDF_VERR_MAJREV_MASK, val),
> +			FIELD_GET(MDF_VERR_MINREV_MASK, val));
> +	} else {
> +		dev_err(&pdev->dev, "Unexpected ID number: 0x%x\n", val);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

...

> +static int stm32_mdf_core_probe(struct platform_device *pdev)
> +{

	struct device *dev = &pdev->dev;

> +	struct stm32_mdf_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->pdev = pdev;
> +	spin_lock_init(&priv->lock);
> +
> +	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +	priv->phys_base = res->start;
> +
> +	priv->kclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->kclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->kclk),
> +				     "Failed to get kernel clock\n");
> +	priv->mdf.kclk = priv->kclk;
> +
> +	priv->regmap = stm32_mdf_regmap_init(&pdev->dev, priv->kclk, priv->base,
> +					     &stm32_mdf_regmap_cfg);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->regmap),
> +				     "Regmap init error\n");
> +
> +	ret = stm32_mdf_core_identification(pdev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = stm32_mdf_core_parse_of(pdev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	INIT_LIST_HEAD(&priv->mdf.filter_list);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);

> +	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);

dev_of_node(dev)

> +	if (ret)
> +		goto pm_put;

Yeah, if needed, this is the only thing that needs of.h and of_platform.h IIUC.

> +	pm_runtime_put(&pdev->dev);
> +
> +	return 0;
> +
> +pm_put:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
> +	return ret;
> +}

...

> +static const struct dev_pm_ops stm32_mdf_core_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(stm32_mdf_core_suspend, stm32_mdf_core_resume)
> +	SET_RUNTIME_PM_OPS(stm32_mdf_core_runtime_suspend, stm32_mdf_core_runtime_resume, NULL)
> +};

Use modern way of representing PM callbacks.

...

> +static struct platform_driver stm32_mdf_driver = {
> +	.probe = stm32_mdf_core_probe,
> +	.remove = stm32_mdf_core_remove,
> +	.driver = {
> +		.name = "stm32-mdf",
> +		.of_match_table = stm32_mdf_of_match,
> +		.pm = &stm32_mdf_core_pm_ops,
> +	},
> +};

> +

Drop this blank line.

> +module_platform_driver(stm32_mdf_driver);

...

I stopped here, this series need much more work, please study existing drivers
in IIO for the modern style and APIs they are using. Also make code be consistent.

-- 
With Best Regards,
Andy Shevchenko


