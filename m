Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923803;
	b=0WT/6GMnZ87WRlw9MAfcZI72/higPGK6JeGz6YC+zGIP6fNgTFE10Z95Z7+HPyCR27LD
	 O4+X+jr2R8BH5+wyohnbWOhajpTpAcjGWmQwTQRcqE2NX5XP0cDTlMp9NgPzAE9gwjYb2
	 GmwbFAXvycH5RawWM7roSsa4bCmoKmlJJ5yWGwEbeR3Ha7GgqpCoKsLA5GuIwftqDM7XM
	 EZQvJ1JqNyyNFoQvadoNvjmmC9c6g/94bZnWbUZpODZ2EtNtR11LQVdyticTD6oSOhOua
	 k2nCjN6Hf0tUiYvZpFbyOLxAtr+umjC7RJrs39YCx/31cPxGQB0KpRnIxfqW4sNqQig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923803;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=JdoNxbvOdGdn5zkdEm9b8MntiuQ8OfXeFa1AJ3RThLM=;
	b=dUquGFiJkEi+E2C10Y/Xo0Q323gItA1LhiTysXsFy20nndKf1sHLi3ADd7LLFblmS4et
	 aNAtuN/Jdo0caGOgZUrcLEtDidBlwm5xU7+QET5w0rZSnj2c5GJHEysG4ZZvWio7aH4Go
	 xS4B42GVt0uiOLqQ0Ne/5wIlVwxyT+a05ijwwMV8//3ZQhNiqnaN3Qy83uv0oDTdRIsqh
	 t9umhQWqDGHyRIJI1JQwssLmAPt5K6KQmMFotuUoyRzPj+r3deLr4oor4wjRHlBGbLvUw
	 8J6gqr8BFYWqQmn52rMAYSh4tdr/0v2dt74eGPqDfyp6e8kg2BORNxILrgCPTQpMvyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kqyD75yD;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C6606A323;
	Tue, 17 Nov 2026 13:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754C6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kqyD75yD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794923803; x=1826459803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ea3tlvsxN6sCO4EObLOHeR1Qlhl1afKZETW82drmShU=;
  b=kqyD75yDOMISXV11f2Q6hOWGumU/XTDsEz1MYpsMigncg8Z3pgTWwoMk
   NgoJiTL03mWJQQ0JY6YxkuRSAttVs5SPl19Z4fnPc/sBL2A/pyHVyyIRh
   TnunsUWBJ2Np3ykdxnz4CPPJcoTKZSAcxVFienv3LfouugtWDpWrUhIkd
   C49hcr9l5+d1ukwn3ORcypX38UPzIi22hkjoTeAIkB5je0WhU22X5ziPq
   FUVuvnJyCMfnvhdB58b7LL/odZRy8ihQg9QrXHdfxmVYFELjYT/v038ZX
   l6GH4b7S61XkNiv+FeAbwlmKgHhv75ijlcf/byCp0Mn5u4mMcb/bmnetU
   g==;
X-CSE-ConnectionGUID: GnohH8m/R2OtU+BEWR2KTw==
X-CSE-MsgGUID: UTmMVJS1QZOnS8WO0azxcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3576235"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3576235"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 05:56:41 -0800
X-CSE-ConnectionGUID: 3EEqGSKdRvuTkNRBbInPHw==
X-CSE-MsgGUID: fvSVtpXaSMuS3eike8RdfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9701080"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 05:56:36 -0800
Date: Tue, 17 Nov 2026 15:56:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adil =?iso-8859-1?Q?H=FCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: proximity: add Imagis ISG5320A SAR sensor
 driver
Message-ID: <avxdEl-IB2yf3pdi@ashevche-desk.local>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
 <20261117104414.1182364-1-tadilhusrev@gmail.com>
 <20261117104414.1182364-2-tadilhusrev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117104414.1182364-2-tadilhusrev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 01:44:14PM +0300, Adil Hüsrev Tepe wrote:
> Add an IIO driver for the Imagis ISG5320A capacitive SAR/grip sensor
> (I2C), as fitted on the Samsung Galaxy XCover5. It exposes one
> IIO_PROXIMITY channel (the B-channel signal minus its baseline) and a
> rising/falling threshold proximity event.

> v1 -> v2 (addressing Andy Shevchenko's and Sashiko AI's review of v1,
> https://sashiko.dev/#/patchset/20261116074013.355363-1-tadilhusrev@gmail.com?part=2):
> - Drop the unused #include <linux/kernel.h>; audit includes for the
>   IWYU principle (array_size.h, cleanup.h, errno.h, types.h for
>   symbols actually used).
> - Use ACQUIRE(pm_runtime_active_auto_try_enabled)/ACQUIRE_ERR() in
>   isg5320a_get_sample() instead of open-coded
>   pm_runtime_resume_and_get()/pm_runtime_put_autosuspend().
> - Make the Kconfig prompt, this file's top comment, and
>   MODULE_DESCRIPTION() use the same wording.
> - Propagate the PROTECT-unlock write failure in isg5320a_reset()
>   instead of only warning (matches the existing SOFTRESET handling).
> - isg5320a_wait_int() now reads the INT gpio with
>   gpiod_get_value_cansleep() (logical, polarity-aware) instead of
>   _raw_, and returns a real error instead of looping to -ETIMEDOUT on
>   a failed read.
> - Cache device_may_wakeup() at isg5320a_events_on() time
>   (irq_wake_enabled) and use that cached value in
>   isg5320a_events_off(), instead of re-checking device_may_wakeup() at
>   disable time: toggling /sys/.../power/wakeup between enable and
>   disable no longer produces an unbalanced
>   enable_irq_wake()/disable_irq_wake() pair.
> - isg5320a_shutdown() now calls isg5320a_events_off() (disables the
>   IRQ and takes data->lock around the IRQFUNC write) instead of
>   writing IRQFUNC unlocked with the IRQ still enabled, and only calls
>   isg5320a_mode_sleep() when the device isn't already
>   runtime-suspended.
> - Register the isg5320a_teardown() devres action right after
>   isg5320a_mode_normal() succeeds instead of after the IRQ request, so
>   a later probe failure (e.g. devm_request_threaded_irq()) still puts
>   the chip back to sleep instead of leaving it scanning unbound.
> - Use a named initializer in isg5320a_id[].

Changelog should be in the comment block, after the '---' line below.

> The driver was derived from the Samsung vendor driver during XCover5
> mainline bring-up with the help of an AI coding assistant (Claude Code,
> Anthropic), which drafted the mainline IIO driver; I reviewed every
> line, built it (arm64, 0 warnings), ran checkpatch --strict (clean),
> and tested it live on a Samsung Galaxy XCover5 (2026-11-17): the driver
> binds and registers as iio:device4 "isg5320a", with a live
> in_proximity0_raw read-back.

This paragraph has to be in the cover letter and not here.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>

> +#include <linux/mod_devicetable.h>

Nope. This should not be included in a new code.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>

> +#include <linux/pm_wakeup.h>

Have you read what's written in the top of that file?
Please, drop it here.

> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>

...

> +#define ISG5320A_RESET_CONDITION	5000	/* reg.h :99, for cfcal_th */

This is a cryptic comment. Either drop it, or better to explain on top of the
definition.

...

> +#define ISG5320A_AUTOSUSPEND_MS		5000

(5 * MSEC_PER_SEC)

will require time.h to be included.

...

> +struct isg5320a_reg_data {
> +	u8 addr;
> +	u8 val;
> +};

> +/*
> + * Vendor setup_reg[] for "XCOVER5 ALL" (isg5320a_reg.h :283-435). The other
> + * table (:130-282) is under CONFIG_SENSORS_ISG5320A_XCOVER5_KOR, which the
> + * stock exynos850-xcover5xx_defconfig leaves unset; it differs only in
> + * 0x9C (threshold low byte), 0xA0 (far hysteresis low byte) and 0xBA.
> + */
> +static const struct isg5320a_reg_data isg5320a_setup_reg[] = {
> +	{ 0x05, 0xFC }, { 0x06, 0xF1 }, { 0x07, 0x13 }, { 0x08, 0x01 },
> +	{ 0x09, 0x80 }, { 0x0A, 0x20 }, { 0x0B, 0x00 }, { 0x0C, 0x00 },
> +	{ 0x12, 0x89 }, { 0x19, 0x8A }, { 0x1B, 0x28 }, { 0x1D, 0x20 },
> +	{ 0x1E, 0x00 }, { 0x1F, 0x18 }, { 0x20, 0x05 }, { 0x21, 0x10 },
> +	{ 0x22, 0x10 }, { 0x23, 0x00 }, { 0x24, 0x00 }, { 0x25, 0x05 },
> +	{ 0x26, 0x05 }, { 0x27, 0x10 }, { 0x28, 0x20 }, { 0x29, 0x00 },
> +	{ 0x2A, 0x20 }, { 0x2B, 0x00 }, { 0x2C, 0x00 }, { 0x2D, 0x20 },
> +	{ 0x2F, 0x18 }, { 0x30, 0xC0 }, { 0x41, 0x11 }, { 0x60, 0xF0 },
> +	{ 0x61, 0x8F }, { 0x62, 0x0C }, { 0x63, 0x00 }, { 0x64, 0x00 },
> +	{ 0x65, 0x44 }, { 0x66, 0x3C }, { 0x67, 0x01 }, { 0x68, 0x00 },
> +	{ 0x69, 0x00 }, { 0x6A, 0x10 }, { 0x6B, 0x00 }, { 0x6C, 0x10 },
> +	{ 0x6D, 0x40 }, { 0x6E, 0x22 }, { 0x6F, 0x00 }, { 0x70, 0x01 },
> +	{ 0x71, 0x60 }, { 0x72, 0xFF }, { 0x73, 0xFF }, { 0x74, 0xFF },
> +	{ 0x7B, 0x08 }, { 0x7C, 0x00 }, { 0x7D, 0x0C }, { 0x7E, 0x00 },
> +	{ 0x7F, 0xF8 }, { 0x80, 0xF8 }, { 0x81, 0x00 }, { 0x82, 0xF0 },
> +	{ 0x83, 0xF0 }, { 0x84, 0xF0 }, { 0x85, 0xF0 }, { 0x86, 0xF0 },
> +	{ 0x87, 0xF0 }, { 0x88, 0x00 }, { 0x89, 0x00 }, { 0x8A, 0x08 },
> +	{ 0x8B, 0x00 }, { 0x8C, 0x02 }, { 0x8D, 0x00 }, { 0x99, 0x21 },
> +	{ 0x9A, 0x3C }, { 0x9B, 0x01 }, { 0x9C, 0x2C }, { 0x9D, 0x00 },
> +	{ 0x9E, 0x00 }, { 0x9F, 0x00 }, { 0xA0, 0x96 }, { 0xA1, 0xC0 },
> +	{ 0xA2, 0x22 }, { 0xA3, 0x00 }, { 0xA4, 0x08 }, { 0xA5, 0x60 },
> +	{ 0xA6, 0xFF }, { 0xA7, 0xFF }, { 0xA8, 0xFF }, { 0xA9, 0x00 },
> +	{ 0xAF, 0x40 }, { 0xB0, 0x00 }, { 0xB1, 0x60 }, { 0xB2, 0x00 },
> +	{ 0xB3, 0xD0 }, { 0xB4, 0x10 }, { 0xB5, 0x28 }, { 0xB6, 0xF0 },
> +	{ 0xB7, 0xF6 }, { 0xB8, 0xFD }, { 0xB9, 0xDE }, { 0xBA, 0xFD },
> +	{ 0xBB, 0xF0 }, { 0xBC, 0x00 }, { 0xBD, 0xFF }, { 0xBE, 0x01 },
> +	{ 0xBF, 0x5E }, { 0xC0, 0x00 }, { 0xC1, 0x69 }, { 0xC2, 0xF0 },
> +	{ 0xC3, 0x00 }, { 0xC4, 0x00 }, { 0xC5, 0x00 }, { 0x13, 0x3A },
> +	{ 0x18, 0xF1 }, /* A ch : CS0, B ch : CS1 */
> +	{ 0x1C, 0x18 }, { 0x35, 0x00 }, { 0x36, 0x00 }, { 0x3A, 0x0A },
> +	{ 0x3B, 0x50 }, { 0x3C, 0x0A }, { 0x3D, 0x50 }, { 0x3E, 0x60 },
> +	{ 0x94, 0x10 }, { 0x95, 0xA9 }, { 0x96, 0x11 }, { 0x2E, 0x14 },
> +	{ 0x0E, 0xE0 }, { 0x0F, 0x1E }, { 0x10, 0xC0 }, { 0x11, 0xC1 },
> +	{ 0xD0, 0xE0 }, { 0xD1, 0x08 }, { 0xD2, 0x00 }, { 0xD3, 0xFF },
> +	{ 0xD4, 0xFF }, { 0xD5, 0x1E }, { 0xD6, 0x32 }, { 0xD7, 0xFF },
> +	{ 0xD8, 0x20 }, { 0xD9, 0x70 }, { 0xDA, 0x7F }, { 0xDB, 0xE0 },
> +	{ 0xDC, 0x00 }, { 0x76, 0x08 }, { 0x77, 0x00 }, { 0x79, 0x02 },
> +	{ 0x7A, 0x00 }, { 0xAA, 0x36 }, { 0xAB, 0xB0 }, { 0xAD, 0x04 },
> +	{ 0xAE, 0x00 },
> +};

...

> +struct isg5320a_data {
> +	struct device *dev;
> +	struct regmap *regmap;

One of the above is redundant.

> +	struct gpio_desc *int_gpio;
> +	int irq;
> +	/* Serialises multi-register chip sequences and the cached sample. */
> +	struct mutex lock;
> +	/* Serialises event enable/disable (sleeps in disable_irq()). */
> +	struct mutex ev_lock;

> +	bool ev_enabled;
> +	bool irq_wake_enabled;
> +	bool close;

If they are protected by the same lock or have no clashes, use

	bool XXX:1;

to pack all of them into a single boolean. Move them to the end, so
there will be a chance to reduce a gap. Check with `pahole`.

> +	u16 cdc;
> +	u16 base;
> +	u16 thresh;
> +	u16 close_hyst;
> +	u16 far_hyst;
> +	u32 cfcal_th;

Move it upper, before u16 ones.

> +};

...

> +static const struct regmap_config isg5320a_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ISG5320A_MAX_REG,
> +	.writeable_reg = isg5320a_writeable_reg,
> +	.precious_reg = isg5320a_precious_reg,

> +	.cache_type = REGCACHE_NONE,

Why?! This has to be justified in the comment above.

> +};

...

> +/* Wait for the INT line to reach @level: up to 10 x 5 ms (vendor :262, :281). */
> +static int isg5320a_wait_int(struct isg5320a_data *data, int level)
> +{
> +	int cnt, val;
> +
> +	if (!data->int_gpio) {

> +		msleep(50);

All sleeps has to be explained.

> +		return 0;
> +	}
> +
> +	for (cnt = 0; cnt < 10; cnt++) {
> +		/* Logical, not raw: honours the GPIO's DT polarity. */
> +		val = gpiod_get_value_cansleep(data->int_gpio);
> +		if (val < 0)
> +			return val;
> +		if (val == level)
> +			return cnt;
> +		usleep_range(5000, 5100);
> +	}

In iopoll.h you may find readx_poll_timeout().

> +	return -ETIMEDOUT;
> +}

...

> +static int isg5320a_reset(struct isg5320a_data *data)
> +{
> +	struct device *dev = data->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	usleep_range(5000, 5100);				/* :255-256 */

Why?! Also use fsleep(5 * USEC_PER_MSEC).

> +	ret = regmap_read(data->regmap, ISG5320A_REG_IRQSRC, &val);	/* :258 */
> +	if (ret)
> +		return dev_err_probe(dev, ret, "no response at IRQSRC\n");
> +
> +	ret = regmap_read(data->regmap, ISG5320A_REG_CHIPID, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "CHIPID read failed\n");

> +	if (val == ISG5320A_VENDOR_CHIP_ID)
> +		dev_info(dev, "CHIPID 0x%02x\n", val);

Useless.

> +	else
> +		dev_warn(dev, "CHIPID 0x%02x (vendor header says 0x%02x; not enforced)\n",
> +			 val, ISG5320A_VENDOR_CHIP_ID);
> +
> +	if (isg5320a_wait_int(data, 1) < 0)			/* :262-266 */
> +		dev_warn(dev, "INT did not go high before reset\n");
> +
> +	ret = regmap_write(data->regmap, ISG5320A_REG_PROTECT,	/* :268-271 */
> +			   ISG5320A_PROTECT_UNLOCK);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unlock protect failed\n");
> +
> +	ret = regmap_write(data->regmap, ISG5320A_REG_SOFTRESET,	/* :273-276 */
> +			   ISG5320A_SOFTRESET_VAL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "soft reset write failed\n");

> +	usleep_range(1000, 1100);				/* :278 */

fsleep (1 * USEC_PER_MSEC) and why?


> +	ret = isg5320a_wait_int(data, 0);			/* :280-289 */
> +	if (ret < 0)
> +		return dev_err_probe(dev, -EIO, "INT not asserted after soft reset\n");
> +	dev_dbg(dev, "reset done, wait cnt %d\n", ret);
> +
> +	return 0;
> +}

...

> +/* vendor isg5320a_initialize(), :614-660, without the /sdcard override */
> +static int isg5320a_initialize(struct isg5320a_data *data)
> +{
> +	struct device *dev = data->dev;
> +	unsigned int i, val, mismatch = 0;
> +	u8 buf[6];
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = regmap_read(data->regmap, ISG5320A_REG_IRQSRC, &val);	/* :625 */
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(data->regmap, ISG5320A_REG_SCANCTRL1,	/* :626 */
> +			   ISG5320A_SCAN_STOP);
> +	if (ret)
> +		return ret;

> +	msleep(30);						/* :627 */

Do all this needs to be under the mutex?

> +	for (i = 0; i < ARRAY_SIZE(isg5320a_setup_reg); i++) {	/* :631-637 */
> +		const struct isg5320a_reg_data *r = &isg5320a_setup_reg[i];
> +
> +		ret = regmap_write(data->regmap, r->addr, r->val);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "init write 0x%02x failed\n",
> +					     r->addr);

Don't we have something like reg_defaults_raw field and the respective
struct reg_default?

> +		ret = regmap_read(data->regmap, r->addr, &val);
> +		if (ret)
> +			return ret;
> +		if (val != r->val) {
> +			mismatch++;
> +			dev_dbg(dev, "reg 0x%02x wrote 0x%02x read 0x%02x\n",
> +				r->addr, r->val, val);
> +		}
> +	}
> +	dev_info(dev, "init table: %zu writes, %u read back different\n",
> +		 ARRAY_SIZE(isg5320a_setup_reg), mismatch);
> +
> +	/* :646-650 reads the threshold; :890-897 reads all six bytes */
> +	ret = regmap_bulk_read(data->regmap, ISG5320A_REG_B_PROXCTL3, buf,
> +			       sizeof(buf));
> +	if (ret)
> +		return ret;

> +	data->thresh = (buf[0] << 8) | buf[1];
> +	data->close_hyst = (buf[2] << 8) | buf[3];
> +	data->far_hyst = (buf[4] << 8) | buf[5];

We have get_unaligned_?eXX(), we have ?eXX_to_cpu() and cpu_to_?eXX(), use them.

> +	ret = regmap_read(data->regmap, ISG5320A_REG_DIGITAL_ACC, &val);	/* :653-657 */
> +	if (ret)
> +		return ret;
> +	data->cfcal_th = ISG5320A_RESET_CONDITION * val / 8;
> +
> +	dev_info(dev, "threshold %u, close hyst %u, far hyst %u, cfcal_th %u\n",
> +		 data->thresh, data->close_hyst, data->far_hyst, data->cfcal_th);
> +
> +	return 0;
> +}

...

> +	/*
> +	 * Registered now, with the chip already active, so that a later
> +	 * failure (e.g. the IRQ request below) still puts it back to sleep
> +	 * instead of leaving it scanning with nothing bound to it.
> +	 */
> +	pm_runtime_set_autosuspend_delay(dev, ISG5320A_AUTOSUSPEND_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_add_action_or_reset(dev, isg5320a_teardown, data);
> +	if (ret)
> +		return ret;

Do you understand how it works? Why don't you use devn_pm_runtime*() calls?

...

> +	if (data->irq > 0) {
> +		irqflags = irq_get_trigger_type(data->irq);
> +		if (!irqflags)
> +			irqflags = IRQF_TRIGGER_FALLING;	/* :1932 */

Why?! It's a new driver, let the firmware to describe thing properly (and you
never know if there is a NOT gate in the middle which make the default working
in a wrong way (and on top, but I haven't checked this, the shared interrupt
case if supported by HW).

> +		ret = devm_request_threaded_irq(dev, data->irq, NULL,
> +						isg5320a_irq_thread,
> +						irqflags | IRQF_ONESHOT |
> +						IRQF_NO_AUTOEN,
> +						"isg5320a", indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "irq request failed\n");

Read mailing list and IIO Git history to understand what's wrong here.

> +
> +		if (device_property_read_bool(dev, "wakeup-source"))
> +			device_init_wakeup(dev, true);
> +	}

...

Overall impression, that this driver was written without enough understanding
on what's going on. Take your time, check datasheet and corner cases, test them
on real HW, et cetera.

-- 
With Best Regards,
Andy Shevchenko


