Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25688457E58
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115981; cv=none; b=UBBK4/+ePQPbckClkzJx2zCn2kervdrGvlDX5uPHw/FjjFd6ybh1sp6F9t1SruNwN+lIY+UxNadZC/o1/YW1w9Efe6mlcIvSfWO7stmjyaMOXEY9ARHgNBBjp6oF7XcHFF+GGwXbF2tjehfXyBBI48g9tlU1LVgkJlituCZi9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115981; c=relaxed/simple;
	bh=WEAeP2UMgOD8Ite+TGXGssS8xCwNiAFZIJmjrN+ig68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a56sxgr1rw6lYUkkuuojybvXKn+8dcHwYWfijbqc2pnS3h4dpSGQ6Tu9HU2wcjQQ3x7X0rL/YP65IKDuyYZ1Wxt6DR+9ysy8qSDePET4NmJZjjI7UPh3RZSnIsstVRhg2JgWKN09C2U7bt+NRnn+H9azW+53QJlPFSH2+M5EZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxGzTtQL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxGzTtQL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b94fce6e8so5124855e9.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789115977; x=1789720777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fn2vvXPnXQ+/LUT2u/qcNazd0SkBSSNlBmM1Wguvo/U=;
        b=rxGzTtQLo/VTxIz2uKFq/nwYf9zHowFOpqXDEgrXHfP7KQmpeplyLLW8DkWjIMnJ3N
         UbFShq/dK/E5lHNF+5VDih5sy7iMHrbgYAfZHTVflxJ3y6XD5PgqDFoS2t395UPeclBL
         wQpsZN1eNoQ0tiMPIAtDSXajr9sa3t4xusUzU4T9B8qloHWnNeH/SN47/HYE6myEVa9f
         kZRhaUp7jPcHtRFx/rCHbNJP9xYcYiMCwwTSWEu0oxvhXorUWfdGtZJr8bjAjBESiYQ+
         35uT/6gY2QRWDnbu6eWyKi3V+7F/Rt9wtVAdwR+gJSN/kpGpHDnwFg+hWk/wbg8cq+aV
         RkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789115977; x=1789720777;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fn2vvXPnXQ+/LUT2u/qcNazd0SkBSSNlBmM1Wguvo/U=;
        b=pOzKzpUwUgAv1NGtYl6F+W42sN9b/zQC7iHauDVJvUEa6iBuG0AZE1f3Ha1+Z2wD8t
         eirrHkxm7sB/UIkB3xDwMxRwPMmlKNN96R4OvwMB2+25Pk7dY6XQ5UhDRccfvb5tRFHv
         rCNBxQy30OONHAHVC+OFMU1sYI+ufvBxbHASt2CWex+8lDMa3hYq2Z90O5F24ViXuwYr
         +KiJyoAzdqxye4/KAiA5VQP4VWoEo24BvHDP1jt+wqCRi4pRNbMSqQdqpWnWU4ekf0uG
         ub1dc3KpjOyLlsWe7QDabSmNlwyuacLVhnvP3d9JXS7m22vXHi2c06c2oEh5LST1Ongr
         3w5A==
X-Forwarded-Encrypted: i=1; AKwUvByaW8+0J322rLohHm/vllbyQs5vFhZ8F5zpQcW83frfyVKfkzf1WKs3nwi8bF5nOQ7Pf0FnY1dK5Xk=@vger.kernel.org
X-Gm-Message-State: AFuF++nmzwty5UHPDIST5p6kY8+UNw5FrgbA1Ylg5J7Im1ONMyF5tah/
	xzUdB7MXjISIRu/7CzBAqGIjYgkz52Q2HYdWr5QEIos5Kg1xcKkYUFz9
X-Gm-Gg: AYBFou0K/0ZZXUsYzW+yG8ay6UuJwaEjgQV9HVSZF1ZKQUEakRXwguVbd+iMTw+wrg9
	+w+9JHElYYvj6JB6e8olird7BCRiORXAZyQMgsppT2aqgzI8qedw/uuxgH/ZtZXF/Eg9qQEZ7Aj
	7d3VwZzRJGOdvMs52lzOyUT2vQqEdyOxRH4wk8iJvw/N3YJgZyHUh7rWD86xI+wp6A6Ncq3JzP8
	mlmcDjRNgwi0aAYEU20txJnWEyxivfskLVK8N+UMpf7cynpBST3SMvw5jcLTEWFxBhA1SoEAwBq
	S3ssfBWkYN/awJi9e5CRa5A/OJ1VkfgNHbU2ZzCKqpODoZXI6aI8mOMGLSOICkDbQDE/iERnbCg
	bFA6/oQg0NWUsKj463oN/gEeXjdRcQzUbAAICS6KHO79FCC0EW9Q/XNzQ4SZjNB7nCRB/Yj+Wmb
	p8w+2z2htQm7jlmPzIMn4HmqbWFuVeqcfTidArxk9fZaAX8gYKh4Ix/fwWwHxgy5tbrZGUbx0C0
	RZahLDxsF3j+xK5ZGLTNGdOlI161A2Q5bWZdSB+wKQYmYGjCn4Ng6EbQEFjAkJ40hvduIxdnJVK
	Loq2LOsoDE0ChWzp1zkiXYaq/1tH7GLmB2Fpw0lRct+qp3UkWssP2VAUmd2CIFjXWD9Lvc4YsYW
	iN2hrnc/vg/gV09X+nYQWzmof745sPQeBJYNy4PhG92RU/1BOhZx3VpKuXWz55iYvfcCWzqRSpr
	k7Fw1deg9++TRxY+I=
X-Received: by 2002:a05:600c:b96:b0:49d:1916:59c7 with SMTP id 5b1f17b1804b1-49e619831a9mr33840005e9.7.1789115977200;
        Fri, 11 Sep 2026 01:39:37 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm4505226f8f.9.2026.09.11.01.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:39:37 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:38:27 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] iio: adc: ti-ads112c14: support external clock
Message-ID: <20260911103827.00003bde@gmail.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-6-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
	<20260910-iio-adc-ti-ads112c14-filter-support-v3-6-e5a9b27ddb1a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 16:13:05 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for an external clock source to the TI ADS112C14 ADC driver.
> The unused fclk_Hz field is added in preparation for filter support.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ti-ads112c14.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index efea1e22d067..0e4584b4675e 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -11,6 +11,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitmap.h>
>  #include <linux/cleanup.h>
> +#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
> @@ -82,6 +83,8 @@
>  #define     ADS112C14_DEVICE_CFG_BOCS_10_uA		  3
>  
>  #define   ADS112C14_DEVICE_CFG_CLK_SEL			BIT(3)
> +#define     ADS112C14_DEVICE_CFG_CLK_SEL_INTERNAL	  0
> +#define     ADS112C14_DEVICE_CFG_CLK_SEL_EXTERNAL	  1
>  #define   ADS112C14_DEVICE_CFG_CONV_MODE		BIT(2)
>  #define     ADS112C14_DEVICE_CFG_CONV_MODE_CONTINUOUS	  0
>  #define     ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT	  1
> @@ -178,6 +181,8 @@ static const u32 ads112c14_pga_gains_x10[] = {
>  	200, 320, 500, 640, 1000, 1280, 2000, 2560,	/* 8 - 15 */
>  };
>  
> +#define ADS112C14_INTERNAL_CLK_Hz 4096000

4096 * KILO?

Otherwise LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
