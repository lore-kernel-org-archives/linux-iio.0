Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17193859D4;
	Sat, 29 Aug 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788026279; cv=none; b=qqU+EifO0pan6/oUEKYprej+DA+OI6upzL732vhpleIAzDI62RB++MPuN87txDG52zxqtg2NckQs5Ocg7B6LmjE39SetiseDo56W4WdZn6bXqtZ1/AdpgbgDVsWU2cJbj1cJDb6nR9kLlgHeEZ5uqYrBR5XGyHzWyaBJHdM/az4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788026279; c=relaxed/simple;
	bh=Y7WgeENIXx48rTuDyPTP7PKcrB5u6yUrjDWEdMd/1to=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=AslT4FUrGZAWJAdBArL7vhn7FatrwH4yzFOpt3gUEGickTSWPouavqlvKz4diwlJUVOOAEdL87FvhifvDEdRT52OeYHMb5CblQFDQLhUAUPGET2ginUmtWvxjbsiKmQVC3WcuPSM+X1OK2zTpllihy9YUDX7yq4zq9eycmRhYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbF0lw1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbF0lw1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BE21F00A3D;
	Sat, 29 Aug 2026 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788026278;
	bh=I7PL3MaaV2cs5HT2ddB4+CuGF4aSNsnDQ5ZqzZJhNC8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bbF0lw1DEUEFICw2UMuzS5q75eSVfahnY8ToS3bwzPV/5QhybcsVxhQeC1Puk2fAz
	 sELH8kO+h3okN6qt6U7DoSsQ/I952zH5/Z1+bI7j0WunEMMZvV3+KrIz1c6gWt5sCE
	 EUU8T+f5nI+ih57dj63pw5XfgkYZXNwGJTZRPJd7ndnydMkLJn2RD8w2qsVGciIoj0
	 RldBY3B+Q+4XGb/IxRiBbNZ17zKK7AIR5NtTQrxjdfCXRbSzi0sSbAe+JMtMHh0704
	 FlEJ4SaCiIz18NYy9tN9DB5kTmZbqWVbbhO+LXPP3RWcI0TvUpK6Ozhn7ffyMXvZyb
	 NJzfVD/uq2Shw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 09/11] iio: temperature: tsys01: make headers
 conform to IWYU
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260829-kernel-header-removal-v2-9-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
 <20260829-kernel-header-removal-v2-9-c67739d5dedf@gmail.com>
Date: Sat, 29 Aug 2026 18:57:39 +0100
Message-Id: <178802625991.2637008.10673317877221890998.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=Y7WgeENIXx48rTuDyPTP7PKcrB5u6yUrjDWEdMd/1to=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqkx2keBiZlVx/IjTeI5ZhpCNSA7Jeez/OEqKh5
 Rb76C0PoyuJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapMdpBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiIdNEACTsJgQiqVj334q0jXLCO8SNgoadn6TLoppYLgek0OqBCV
 FjtYWX7VAGSBW64P/EoRhaYqX35QW9mJwk67AC7pjbrzYazufnSOUpoTQeShSzjK6EK4w6hTPmC
 DIj7QVT2PZTE1SOk94fycOx6eJkAJsGbNmj0DFFfcUsgOrOWZRR6UDFDh88+LFu5hHeRNn+GMGz
 q4pV26goi/UUkKdqPKAxBjzqm5S+0YzU2LAQLEy2aCe7TGZRrT3FxtNXIMiQpKtMOnhGadsc/nR
 Fl+zVCkWefQi6ImbdP+YvYIPGQ9LsZWi0NpqMnsg6Vg457YcDYV6sR1I1+dDo0H5iwv1C9Dmpws
 0PxG54abOyGiymGhbyiOUioV94aS3kVBywTbZLjlI8mql1T79eDi9DCPVU6UbR98jGWrJ2LW55y
 W1t5v6BS0a6k8LQW9sAFkbGj7GOB+ufYFlGnQtsbth5UANLWRpjP/uTpK6HXOSGdN50/rX9OWcH
 v6ZRZq37QUwLt4XPoaUoIpIXj5BcG3Zqli41sLDMXf0lUQtlZAGF6JJtb13ye7trHsm0UC7UaqJ
 bF8Z/rEHowiMf89ix9GHjeT1G3HczMfHBlBcFt/lSBKWgApsxDLPPAN3lqdbG7KKcWqUhCotJ3H
 d3BhG2GMQ2YFoh+NE5u8RRBULdVnun0zZhSg83Q==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Remove the catch-all kernel.h header, add missing headers and remove

Seems some fixups in wrong patch as tmp117 stuff in here.

Sashiko shouted about that.

> unused headers.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
>
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index 25bc98e64e48..96252627613f 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -12,13 +12,12 @@
>  #include <linux/array_size.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> -#include <linux/dev_printk.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/limits.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
> -#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/types.h>
>  
> diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
> index 14de67ee8be7..3c1f5b6ac156 100644
> --- a/drivers/iio/temperature/tsys01.c
> +++ b/drivers/iio/temperature/tsys01.c
> @@ -8,12 +8,14 @@
>   *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
>   */
>  
> -#include <linux/device.h>

 | sashiko.dev <sashiko@sashiko.dev>:
 |
 | [Severity: Low]
 | Does removing <linux/device.h> contradict the Include What You Use principles
 | mentioned in the commit message?
 |
 | Looking at tsys01_probe(), it directly dereferences struct device and struct
 | device_driver:
 |
 | tsys01_probe() {
 |     ...
 |     indio_dev->name = dev->driver->name;

Looks valid to me.

 |     ...
 | }

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
