Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A04EF154
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780102; cv=none; b=hNbUBlPBkWvGrtP04HblrH8DNOnQPFVW5l8eA/XhcJ3d/SDkZjtgFakh9Lb+SGmaC84H4VSv1j2C8RDxhukKSG7vE6H790g9uDS3hRGI/JQosnl0LzvllDTRwfe+eK6HhvmaJ7++OuWxAO+wqUeKVJnUEm/KRyXrf/7Zw8Odp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780102; c=relaxed/simple;
	bh=wD3NZssZMW68AQJrY2P8J4DOvVjSGsMzgeQD9NT7T6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGs5Ry7KNvwCBFNx3tQ32SL66QBYTI41j5Bj/NLqzHel/a38cxg9iQf+M2uHeMITzZ+uzxIEXCIuGyicsSB6ufJ69YVG+ZKQyc9kS6Eldd+n928WJA6W2DP8ma8b3JuE9UUehFkuEcTfTcG9OdqP0HDbnqEwJMq9fnRKR4OGhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiE/dC+P; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiE/dC+P"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso23850525e9.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780089; x=1791384889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fX+GMtVZvZFwpjXU+kCF5PX/DfKN7b04TfWCfb65nWU=;
        b=WiE/dC+P1u6L1CgCGkblchR3yrMX0NqAzRZBCzQW5V78MPzOFdb1bsbsutjKINcbxD
         gbkU2Nf9Tl+ktDF5KPPmRrMXrpzB5QgfJDn2OAqPk8rnTbf2CZ3j+9eRh/UVebVWwuUx
         ZJytVWsb1VNXr8Hcy2lvzUYUbgpAyu7/49E5XW35CNFX+deuYLXncyQQH0Z+Kf6Zu57W
         ZV17UXPhq3LtKj0t+Gh7Iyvjq99lxtOTJd02qFNF12/oDURewlD/c4rYufodIcZH0r0m
         xZwuAB7jCVZBoSEK6tqpU38AxcOdELhPJujTdws/7VIU/rTJ4vM8IG+MVMQfnntF3jMs
         t8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780089; x=1791384889;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fX+GMtVZvZFwpjXU+kCF5PX/DfKN7b04TfWCfb65nWU=;
        b=JkjpMX0KiERmQQKJcfpE//U/tFVHEK7OYqmxHOYGBNarlSl0bOehQ6ppLEgw9vHR0N
         2+dxHs+fQsmyj+XSp2PpXS2XN15C91zPDfJdXj7NVI+qodI+8pZsPu3pNnSRpLgStO+E
         4mrIL1mme4C4puNpfjEZnqiRSs7FOYLl2xGbfrXPSQMqCjz0k4J0icAVyQMcFcX3NWf7
         RIH1lm377MZZQD/0m7I35nyQyeDuI0nxlwdJ9e+l5egtWGBiDME5LEjZy6SU5jAia9BX
         9U4pbmTdCZLFmFKldW1/qMqPIYvYB7BJX6JkBjy/zhG5eKFdMuLM8SPGi1cTjA/8vBg3
         DS1Q==
X-Forwarded-Encrypted: i=1; AKwUvBx6MnT/b4IEAjoeyRB53Vw0AITCAZ7Nd9cEoelnUe7SRCEBtq6I2E2CBGJkEu4tczDk5Zz8DrJ0+oc=@vger.kernel.org
X-Gm-Message-State: AFuF++mfGAMBRYQuZHaYOLwRFnwbQbq9JWk5pDAiR6k1iEhUDzaYM6kT
	+NOT3jlzLWVW1BS5sVS8JiplSFqnUUXh1cSHmxauVJULk4Jh+nbR4UzL
X-Gm-Gg: AYBFou1wy++zWtLJD5xUTgIqV45hK1J8bu+Bx5n2vzuIgIntkEDqWrUAXP2uw6elWMF
	Zn+XL57KWikbc4sb3m0Imlh0YdQld35HYhnj34oyWw0HUAp6x5MMjeMFwVcIuqY3/Fjq7uN5Ves
	aDOwwqUCGtrv6A3jMUS6j8gU6uZsFWu9hwKBdk5lX3ErvqGdOmQwqcLHMe4LyK4O7IrIelNc2+V
	kryPBcFN1UXSN5fslx3RzitPo36Deccng5gpNt4vFqWr9wvl3LjB2EaMHOAnKrriFOFUaJcSaD2
	iZpX3QAl8obaqZl/ZPbwc4l07gwLYXInZnKTL5yMRz77hNlv0/wYTY/6UD8CK2RYgte6Wr9x0Zp
	IPJJ2fGAPgucTAkBP7J/i39lj8S6koRRHDNfjS80+cxzCU4M6Vz7ywvh1IZi91QOksnnBkxRZTs
	Q7RMmBIuZofo15JyHAjx3F2Yb7MXft3CibSEANgWufesWrfHQTbyYxl980so0DmlHUj0hROo1wL
	5GchZX/L9wsZ3An/Pxep7B82crHeiAYoqRT07N9gI49Gqd0ry6M3OjzadXN7m0B49tnj6Vh0kog
	8H3tnEcTBqo5PhfkwVzmCevtUZIQtp/BoROavzs7fcOymPbvleWL3D1Z11KLKUVM0lIoCzvwUaF
	D4rqNaE4ppWdfzl1QBw0DICuDueRBS/l7zlIJoPevGup7ApHiD/8Riya+Nmbz/Xs4Wn0oH5LAH2
	2FD6NR
X-Received: by 2002:a05:600c:a00b:b0:4a0:1c69:f607 with SMTP id 5b1f17b1804b1-4a01c69f64dmr14101255e9.29.1790780088847;
        Wed, 30 Sep 2026 07:54:48 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01e6622e1sm4236005e9.3.2026.09.30.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:54:48 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:54:47 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Marek Vasut
 <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v3 04/15] iio: adc: stm32-adc: manage characterization
 voltage diversity
Message-ID: <20260930165447.000046e4@gmail.com>
In-Reply-To: <20260930-adc-stm32mp25-v1-v3-4-406834430d72@foss.st.com>
References: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
	<20260930-adc-stm32mp25-v1-v3-4-406834430d72@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 16:18:25 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> From: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> The characterization voltage used to calibrate vrefint depends
> on SoC family. Add vref_charac_mv field in stm32_adc_cfg structure
> to store the characterization voltage for each SoC, and use it
> in Vref computation formula.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v2:
> - Andy's review comments: rename variable to vref_charac_mv (unit suffix).
>   Drop the const attribute.
> ---
>  drivers/iio/adc/stm32-adc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 600f975f1d7b..fa46803d54be 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -43,7 +43,6 @@
>  #define STM32_ADC_TIMEOUT_US		100000
>  #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
>  #define STM32_ADC_HW_STOP_DELAY_MS	100
> -#define STM32_ADC_VREFINT_VOLTAGE	3300
>  
>  #define STM32_DMA_BUFFER_SIZE		PAGE_SIZE
>  
> @@ -211,6 +210,7 @@ struct stm32_adc;
>   * @set_ovs:		routine to set oversampling configuration
>   * @smp_cycles:		programmable sampling time (ADC clock cycles)
>   * @ts_int_ch:		pointer to array of internal channels minimum sampling time in ns
> + * @vref_charac_mv:	Vref characterization voltage used to measure vrefint calibration value
>   */
>  struct stm32_adc_cfg {
>  	const struct stm32_adc_regspec	*regs;
> @@ -230,6 +230,7 @@ struct stm32_adc_cfg {
>  	void (*set_ovs)(struct iio_dev *indio_dev, u32 ovs_idx);
>  	const unsigned int *smp_cycles;
>  	const unsigned int *ts_int_ch;
> +	int vref_charac_mv;

Case-sensitive units if it's SI is preferred in IIO, therefore *_mV.
(checkpatch warns against this, but just ignore it).

-- 
Kind regards,
Joshua Crofts
