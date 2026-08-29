Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5C361670;
	Sat, 29 Aug 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788026279; cv=none; b=i8yF+x8vZV3uQ3TE8Hdz92HOdz8WAPn6P4a682ru66EJuXFIf81LUtOO8Ee4F1y+988/iHBjz3oBPrIZhFpZyiRoMDSU+z2rbnL108wfcQGvlgy/LHSXFCLOxALIZRPCjIl3McZeUjln9qXU2nL/tO442yUMW1gPVF70pR/UQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788026279; c=relaxed/simple;
	bh=qpurbaUq8X+lLE7VO72kpjEA2yJO/x8JqnYptdzq/GY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tSFQO9t4hFjXbqBsWtGgeMIIEbaKKZfj8rSD3CK8s5qiXRzHTdWZRUhtZ29un5wh9Obyk4Duxt8dnefP/xGHZT2NpcYHpQlRifswoZi1Olte1irXl+Qt0z0AcWbW3GBpopCKDJpFgVhxMp3TZygHWfxQFK8z9gMx8nit7vhh0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUi2ZcBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUi2ZcBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EDE1F000E9;
	Sat, 29 Aug 2026 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788026277;
	bh=TNceuBiUJTESrYAvt9YoVGu7PLhRCkBFu4MHwIToq0Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NUi2ZcBKPfAZ/gf+g8sHiV9Ep22lMKLm5S2xFJ0/T8obbWBRGlypzPyGO17zk0E20
	 7XoAMbABqrxjtneX3nB+ycVbelvNQgncIjE79zV9ppdNxnL2w+YC9ij6EuBbEGrVjp
	 PosphYWhZkEKXFOU0F7/o4hg7l8UrgimFR9o0ukwF6FOLW4+4SV4ZiHf8JAmp1oULd
	 q35d5rHEn//RcDWg6tq339D1MOrjFp7jgNw2zrhEPMYafT/moK+F11qp0/3w+uYOPD
	 dtN6AyTF42pUtasaS9DKQyhcKKpknELz4igFRzAwhwMtJE48n1QhrmIrARAModVpnF
	 90NQ02bMXBs4A==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 03/11] iio: temperature: ltc2983: make headers
 conform to IWYU
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260829-kernel-header-removal-v2-3-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
 <20260829-kernel-header-removal-v2-3-c67739d5dedf@gmail.com>
Date: Sat, 29 Aug 2026 18:57:39 +0100
Message-Id: <178802625991.2637008.10318808016519364966.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=qpurbaUq8X+lLE7VO72kpjEA2yJO/x8JqnYptdzq/GY=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqkx2XOOtp8bzjDP/jSDvSgBAeRqnz0pDDzOkOV
 ENfnQwO5eeJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapMdlxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiH6rD/4p3Ozpe6dOrzeWDEi0qbA1bSOb2hKlGvC9CreXc1z4mXr
 LzS5Vnxo2enoaWZ5EnwiyWzNGGVgZEja2V7w3f3CoSMqPGa8RD9rjmgWsVaImB0gx7040XHgeEp
 CVkCf/GR1hq2rnOzVD+drsJyWnVspQBQdpqmNrzpzZQxnMqNqKZ91+BpYSkMQxP4zkZH2t1UGBX
 xkiL07cWxU+/C64/WgeGGJl2rOcBJRL27xRNnIHDnkx+dlqvmTSSI/OsCQbTCRwgGBbRTiAfT5P
 Ti4zuzbuzoImU8rlH0PDqndrJZUcsUwhXSeBrqWvmpCRV5TCe5pjlLoDx4ByeKUPbPyjV+I/skx
 b0rtjD1ffcjkfsdkMidBofBKfWdmQ8NVkf1sWcIg4rxAFJOMSsW857T1cbmCWEfRqmxqM4U6wXW
 P7v0M11j1zCW1r9kPzYOSW3/c9QhT9lrlSTnXLupxfzCihvS9NTKPyRFNGVbT2S8FxFfW9qjJN1
 PM9/f/Xv9bAq049bRMs/swx/5xWOOVY716pxUwH27YsXWAfBwKCiLm91qQl0s/adRFCkVZwumHG
 yh23wwPpNmi98wvIB2DmSX4FWvIXLE7sN3eIwBtFgZz5Rv7IHTznMS2Iyz3osWIj0x1JcRf8TnW
 CxV9sJC/zNpvhgw8dJMnz33/qL6yrQL5UxpM7Qg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Remove the catch-all kernel.h header and add the missing headers to
> enforce IWYU.

Sashiko correctly observed that this wasn't really IWYU.  So, to avoid
confusion we should be referring to something "approximate IWYU taking into
account some headers that always include others".

> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
>
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index fe9eec3058d4..b8deb9aa9d48 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -5,19 +5,26 @@
>   *
>   * Copyright 2019 Analog Devices Inc.
>   */
> +
> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/completion.h>
> +#include <linux/container_of.h>
> +#include <linux/dev_printk.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> -#include <linux/errno.h>
> -#include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/list.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>
>  #include <linux/unaligned.h>

There were a few other sashiko comments... 

  [Severity: Medium]
  To fully conform to IWYU, are there other missing headers that should be
  included here?

  For example, __ltc2983_custom_sensor_new() calls strcmp():

 	if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
 		temp = temp * 1000000 + 273150000;

  Does this require including <linux/string.h>?

Seems reasonable to me.  Why did you not include it?

  Similarly, ltc2983_probe() calls devm_gpiod_get_optional() and usleep_range():

 	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
		return PTR_ERR(gpio);

 	usleep_range(1000, 1200);

  Would including <linux/gpio/consumer.h> and <linux/delay.h> be necessary
  here?

Both seem reasonable to me.


  Also, the ltc2983_pm_ops struct is defined using the DEFINE_SIMPLE_DEV_PM_OPS
  macro:

  static DEFINE_SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend,
  				ltc2983_resume);

  Does this macro require including <linux/pm.h>?


Also seems sensible.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
