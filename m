Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538513AE1A0;
	Fri,  2 Oct 2026 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933500; cv=none; b=aK+yjz8SgbKmLKaKCmIvDoOpWzxlBx5QyZDBjxDyE8CD10qfv2LawjvCYpiK2MUbbe3Lr6vrH85E0pcrGRdHPyrhEJmTxjBDnLQW7nKFWuAAg2g8JnfUlff7DMoJthYV7gU/SCdFu0WOXucuMw6PUXZaQzYc75GGGPfUhmV56n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933500; c=relaxed/simple;
	bh=xxOmyjuNcm7xgU6w20HAlqte0/FiHC47VMiFfggs+Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwmHZt7qosJE3wpuu3Q0YDBScAlAykY8Il+ryf1phhCMX8bB6l5vhmHGvh6HmvNnHrHHu82Tafw2WfBw6PRAsdEttQ8YLKsDmyFXmmVZTV+3itiRYkQ5/5GNR4S6zq4lp9xVWdR736o4De5iAfbcu0HAO/6sLtIHkEc+4DeTT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIvLm+cX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIvLm+cX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A501F000FF;
	Fri,  2 Oct 2026 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790933495;
	bh=jf6FbG1+8KuIJRm4kC+gTyizLWnbqehLcfbKm2+sZCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIvLm+cXMNfj4nhdTeFFWv/QRCOkkc22D/ogvv5gF9WRdK9aAq+oaTk0CSEGyeEy8
	 g3cUjY3xvUP2Gs/E2x7z0uSZH0mVre7dhxlIsKH6bhN9qbsKGo1ieYpPXJgKS3WTME
	 VYiHuW3Rpg6EYEQFheqDaA6W583y2ebLs2RN3gUIYJtPYui+zeZKBwQ7dYgOr+4mQU
	 YD9JqgO0faLob7ozRhBqJW8U5ALCF9ESSjrUxWX/TvJx2L4JSIlcNIi15c64i2/2/g
	 gsUvtg471SZUmBG0q4oMsQH+EcbpKMTmaQwtD/QShB4ndqDuRZ5F0DKbJKvUf+zSa2
	 2cD4RAqNKXmaQ==
Date: Fri, 2 Oct 2026 11:31:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 2/3] iio: adc: add stm32 mdf support
Message-ID: <20261002-rigorous-eggplant-octopus-ebf89e@quoll>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-3-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001145702.2628429-3-olivier.moysan@foss.st.com>

On Thu, Oct 01, 2026 at 04:56:46PM +0200, Olivier Moysan wrote:
> +static int stm32_mdf_core_of_cck_get(struct platform_device *pdev, struct stm32_mdf_priv *priv)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 freq;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "clock-frequency", &freq);

How? Your driver depends on OF and there is no such property in OF, so
why can you read it?

Otherwise what is this:

"depends on (ARCH_STM32 && OF)"

> +	if (ret < 0) {
> +		/* If property does not exist return immediately */
> +		if (ret == -EINVAL)
> +			return 0;
> +
> +		dev_err(dev, "Failed to read clock-frequency property: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!freq) {
> +		dev_err(dev, "Null frequency not allowed for cck output frequency\n");
> +		return -EINVAL;
> +	}
> +	priv->cck_freq = freq;
> +
> +	return 0;
> +}
> +
> +static int stm32_mdf_core_parse_clocks(struct platform_device *pdev, struct stm32_mdf_priv *priv)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk *kclk;
> +	int ret;
> +
> +	kclk = devm_clk_get(dev, "ker_ck");
> +	if (IS_ERR(kclk))
> +		return dev_err_probe(dev, PTR_ERR(kclk), "Failed to get kernel clock\n");
> +
> +	priv->kclk = kclk;
> +	priv->kclk_rate = clk_get_rate(kclk);
> +
> +	/* CCK0 and CCK1 clocks are optional. Used only in SPI master modes. */
> +	ret = stm32_mdf_core_of_cck_get(pdev, priv);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->cck_freq) {
> +		ret = stm32_mdf_core_cck_divider_set_rate(pdev, priv, priv->kclk_rate);
> +		if (ret) {
> +			dev_err(dev, "Failed to set cck rate: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = stm32_mdf_core_register_clock_provider(pdev, priv);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int stm32_mdf_core_parse_of(struct platform_device *pdev, struct stm32_mdf_priv *priv)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct reset_control *rst;
> +	struct device *dev = &pdev->dev;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct fwnode_handle *handle;
> +	struct fwnode_handle **fh;
> +	int count, ret, i;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "mdf");
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset controller\n");
> +
> +	ret = reset_control_reset(rst);
> +	if (ret) {
> +		dev_err(&pdev->dev, "reset_control_reset failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = stm32_mdf_core_parse_clocks(pdev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (device_property_present(&pdev->dev, "st,interleave")) {
> +		count = fwnode_property_count_u32(fwnode, "st,interleave");
> +		if (count < 2 || count > priv->mdf.nbf) {
> +			dev_err(dev, "Wrong interleave filters number [%d]\n", count);
> +			return -EINVAL;
> +		}
> +
> +		fh = devm_kzalloc(dev, count * sizeof(*fh), GFP_KERNEL);
> +		if (!fh)
> +			return -ENOMEM;
> +		priv->mdf.fh_interleave = fh;
> +
> +		for (i = 0; i < count; i++) {
> +			handle = fwnode_find_reference(fwnode, "st,interleave", i);
> +			if (IS_ERR(handle)) {
> +				dev_err(dev, "Failed to read filter handle: %ld\n",
> +					PTR_ERR(handle));
> +				return PTR_ERR(handle);
> +			}
> +			priv->mdf.fh_interleave[i] = handle;
> +		}
> +
> +		priv->mdf.nb_interleave = count;
> +
> +		/* Configure GCR */
> +		ret = regmap_update_bits(priv->regmap, MDF_GCR_REG,
> +					 MDF_GCR_ILVNB_MASK, MDF_GCR_ILVNB(count - 1));
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id stm32_mdf_of_match[] = {
> +	{ .compatible = "st,stm32mp25-mdf" },
> +	{ .compatible = "st,stm32mp23-mdf", .data = (void *)STM32_MDF_MP23_FILTER_NB },

Again odd order of entries. Why doing things reverse from natural sort order?

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, stm32_mdf_of_match);
> +
> +static int stm32_mdf_core_identification(struct platform_device *pdev, struct stm32_mdf_priv *priv)
> +{
> +	struct stm32_mdf *mdf = &priv->mdf;
> +	u32 val;
> +	int ret;
> +
> +	/* If filter number is explicitly defined, don't check identification registers */
> +	mdf->nbf = (uintptr_t)device_get_match_data(&pdev->dev);

Don't use uintptr_t, but unsigned long.

> +	if (mdf->nbf)
> +		return 0;
> +
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
> +
> +		dev_dbg(&pdev->dev, "MDF version: %lu.%lu\n", FIELD_GET(MDF_VERR_MAJREV_MASK, val),
> +			FIELD_GET(MDF_VERR_MINREV_MASK, val));
> +	} else {
> +		dev_err(&pdev->dev, "Unexpected ID number: 0x%x\n", val);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_mdf_core_probe(struct platform_device *pdev)
> +{
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
> +	priv->regmap =
> +		devm_regmap_init_mmio_clk(&pdev->dev, "ker_ck", priv->base, &stm32_mdf_regmap_cfg);

Odd wrappung.

> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		dev_err(&pdev->dev, "Failed to allocate regmap: %d\n", ret);

We do not print allocation errors.

OTOH, every other probe failure should use return dev_err_probe syntax.
Again, same with bindings, please take existing recent code as starting
point, not upstream your old vendor code.


> +		return ret;
> +	}
> +
> +	ret = stm32_mdf_core_identification(pdev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = stm32_mdf_core_parse_of(pdev, priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	INIT_LIST_HEAD(&priv->mdf.sitf_list);
> +	INIT_LIST_HEAD(&priv->mdf.filter_list);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> +	if (ret)
> +		goto pm_put;
> +
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
> +
> +static void stm32_mdf_core_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_get_sync(&pdev->dev);
> +	of_platform_depopulate(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +}
> +
> +static int stm32_mdf_core_suspend(struct device *dev)
> +{
> +	struct stm32_mdf *mdf = dev_get_drvdata(dev);
> +	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
> +	int ret;
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	regcache_cache_only(priv->regmap, true);
> +	regcache_mark_dirty(priv->regmap);
> +
> +	/* Balance devm_regmap_init_mmio_clk() clk_prepare() */
> +	clk_unprepare(priv->kclk);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int stm32_mdf_core_resume(struct device *dev)
> +{
> +	struct stm32_mdf *mdf = dev_get_drvdata(dev);
> +	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set pins default state: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare(priv->kclk);
> +	if (ret) {
> +		dev_err(dev, "Failed to prepare kernel clock: %d\n", ret);
> +		goto err_clk;
> +	}
> +
> +	regcache_cache_only(priv->regmap, false);
> +	ret = regcache_sync(priv->regmap);
> +	if (ret) {
> +		dev_err(dev, "Failed to sync cache: %d\n", ret);
> +		goto err_cache;
> +	}
> +
> +	return pm_runtime_force_resume(dev);
> +
> +err_cache:
> +	clk_unprepare(priv->kclk);
> +err_clk:
> +	pinctrl_pm_select_sleep_state(dev);
> +
> +	return ret;
> +}
> +
> +static int stm32_mdf_core_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int stm32_mdf_core_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops stm32_mdf_core_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(stm32_mdf_core_suspend, stm32_mdf_core_resume)
> +	SET_RUNTIME_PM_OPS(stm32_mdf_core_runtime_suspend, stm32_mdf_core_runtime_resume, NULL)
> +};
> +
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
> +module_platform_driver(stm32_mdf_driver);
> +
> +MODULE_AUTHOR("Olivier Moysan <olivier.moysan@foss.st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 MDF driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/adc/stm32-mdf-serial.c b/drivers/iio/adc/stm32-mdf-serial.c
> new file mode 100644
> index 000000000000..15a58cf833be
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-mdf-serial.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * This file is part of STM32 MDF driver
> + *
> + * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "stm32-mdf.h"
> +
> +#define STM32_MDF_MODE_SZ 12
> +
> +enum {
> +	STM32_MDF_SCKSRC_CCK0,
> +	STM32_MDF_SCKSRC_CCK1,
> +	STM32_MDF_SCKSRC_CLK,
> +	STM32_MDF_SCKSRC_NONE,
> +};
> +
> +struct stm32_mdf_sf_mode {
> +	const char *name;
> +	u32 mode;
> +};
> +
> +static const struct stm32_mdf_sf_mode stm32_mdf_mode[STM32_MDF_MODE_NB] = {
> +	{ "spi", STM32_MDF_MODE_SPI },
> +	{ "lf_spi", STM32_MDF_MODE_LF_SPI },
> +	{ "manchester_r", STM32_MDF_MODE_MANCHESTER_R },
> +	{ "manchester_f", STM32_MDF_MODE_MANCHESTER_F },
> +};
> +
> +static bool stm32_mdf_sitf_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MDF_SITFCR_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool stm32_mdf_sitf_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MDF_SITFCR_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config stm32_sitf_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = MDF_SITFCR_REG,
> +	.readable_reg = stm32_mdf_sitf_readable_reg,
> +	.writeable_reg = stm32_mdf_sitf_writeable_reg,
> +	.fast_io = true,
> +	/* Do not use regcache as it does not support single register map */
> +};
> +
> +int stm32_mdf_sitf_start(struct stm32_mdf_sitf *sitf)
> +{
> +	int ret;
> +
> +	spin_lock(&sitf->lock);
> +
> +	ret = regmap_set_bits(sitf->regmap, MDF_SITFCR_REG, MDF_SITFCR_SITFEN);
> +	if (!ret)
> +		sitf->refcnt++;
> +
> +	spin_unlock(&sitf->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_sitf_start);

You need kerneldoc for all of exports.


> +
> +int stm32_mdf_sitf_stop(struct stm32_mdf_sitf *sitf)
> +{
> +	int ret = 0;
> +
> +	spin_lock(&sitf->lock);
> +
> +	if (!sitf->refcnt) {
> +		dev_err(sitf->dev, "Unbalanced serial interface stop ?\n");
> +		ret = -EPERM;
> +		goto out;
> +	} else {
> +		sitf->refcnt--;
> +	}
> +
> +	if (!sitf->refcnt)
> +		ret = regmap_clear_bits(sitf->regmap, MDF_SITFCR_REG, MDF_SITFCR_SITFEN);
> +
> +out:
> +	spin_unlock(&sitf->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_sitf_stop);
> +
> +static int stm32_mdf_sitf_get_clk(struct device *dev, struct stm32_mdf_sitf *sitf)
> +{
> +	struct clk *sck;
> +
> +	/* Optional clock. Clock not needed in Manchester mode */
> +	sck = clk_get_optional(sitf->dev, 0);
> +	if (IS_ERR(sck))
> +		return dev_err_probe(sitf->dev, PTR_ERR(sck), "Can't get serial clock\n");
> +
> +	sitf->sck = sck;
> +
> +	if (sitf->sck) {
> +		if (!strncmp(__clk_get_name(sck), STM32_MDF_CCK0, sizeof(STM32_MDF_CCK0)))
> +			sitf->scksrc = STM32_MDF_SCKSRC_CCK0;
> +		else if (!strncmp(__clk_get_name(sck), STM32_MDF_CCK1, sizeof(STM32_MDF_CCK1)))
> +			sitf->scksrc = STM32_MDF_SCKSRC_CCK1;
> +		else
> +			sitf->scksrc = STM32_MDF_SCKSRC_CLK;
> +	}
> +
> +	return 0;
> +};
> +
> +static int stm32_mdf_sitf_parse(struct platform_device *pdev, struct stm32_mdf_sitf *sitf)
> +{
> +	struct device *dev = &pdev->dev;
> +	const char *str;
> +	int ret, i = 0;
> +	u32 idx, mode, sitfcr;
> +
> +	ret = device_property_read_u32(dev, "reg", &idx);
> +	if (ret) {
> +		dev_err(dev, "Could not get interface index: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (idx % 0x80) {
> +		dev_err(dev, "Unexpected reg property value [%x]\n", idx);
> +		return -EINVAL;
> +	}
> +
> +	idx = (idx >> 7) - 1;
> +	if (idx > sitf->mdf->nbf) {
> +		dev_err(dev, "Interface index [%d] exceeds maximum [%d]\n", idx, sitf->mdf->nbf);
> +		return -EINVAL;
> +	}
> +
> +	/* Get SITF mode */
> +	ret = device_property_read_string(dev, "st,sitf-mode", &str);
> +	if (ret) {
> +		dev_err(dev, "Could not get interface mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	while (i < STM32_MDF_MODE_NB) {
> +		if (!strncmp(stm32_mdf_mode[i].name, str, STM32_MDF_MODE_SZ)) {
> +			mode = stm32_mdf_mode[i].mode;
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	if (i >= STM32_MDF_MODE_NB) {
> +		dev_err(dev, "Unknown serial interface mode [%s]\n", str);
> +		return -EINVAL;
> +	}
> +
> +	sitf->mode = mode;
> +	sitfcr = MDF_SITFCR_SITFMOD(mode);
> +
> +	ret = stm32_mdf_sitf_get_clk(dev, sitf);
> +	if (ret)
> +		return ret;
> +
> +	if (mode == STM32_MDF_MODE_SPI && sitf->scksrc == STM32_MDF_SCKSRC_NONE) {
> +		dev_err(dev, "Missing clock for serial interface [%d] in SPI mode\n", idx);
> +		return -EINVAL;
> +	}
> +
> +	if (mode == STM32_MDF_MODE_LF_SPI && (sitf->scksrc != STM32_MDF_SCKSRC_CCK0 &&
> +					      sitf->scksrc != STM32_MDF_SCKSRC_CCK1)) {
> +		dev_err(dev, "Missing CCKx clock for serial interface [%d] in LF_SPI mode\n", idx);
> +		return -EINVAL;
> +	}
> +
> +	sitf->id = idx;
> +	sitf->node = dev_fwnode(dev);
> +	spin_lock_init(&sitf->lock);
> +
> +	sitfcr |= MDF_SITFCR_SCKSRC(sitf->scksrc);
> +
> +	/* Configure SITF register */
> +	regmap_set_bits(sitf->regmap, MDF_SITFCR_REG, sitfcr);
> +
> +	dev_dbg(dev, "Serial interface [%d] registered\n", idx);

Drop, that's just probe success.

> +
> +	return 0;
> +}
> +
> +static int stm32_mdf_sitf_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct stm32_mdf_sitf *sitf;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	sitf = devm_kzalloc(&pdev->dev, sizeof(*sitf), GFP_KERNEL);
> +	if (!sitf)
> +		return -ENOMEM;
> +	sitf->dev = dev;
> +	sitf->mdf = dev_get_drvdata(dev->parent);
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio_clk(dev, "ker_ck", base, &stm32_sitf_regmap_cfg);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");

And here quite different choice. Your code is just inconsistent.

> +	sitf->regmap = regmap;
> +
> +	ret = stm32_mdf_sitf_parse(pdev, sitf);
> +	if (ret < 0)
> +		return ret;

Best regards,
Krzysztof

