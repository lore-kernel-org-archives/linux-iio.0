Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B3330B07;
	Tue, 30 Jun 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863001; cv=none; b=iix6wAa8mrgXDINECtKlIiEMFoBEpQfxW8zVsCvKl/Ja7Q3lScasmHGrGIiACXqDnP1yhzH5JjvjwCLK8oMqmxlP7JuxUMg9hfXsS5hcZfltx59C+mESZUY/VRldFNBczwrodFvtjpghGT/4/fipWYS/2djuY8eTYW4MxTcZC3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863001; c=relaxed/simple;
	bh=YGRHyTH/j8WHPjaiEhleJE4ThtAt7V8s5YhMRO9kRjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5qGUi2CYTBbqm/re3+WkrqS7PZ13QQs37ioWLw8XsdtIqLLEwwhO0RODNyw21JIF3uuPzzl2eFAGKXZE4eMMfhbJAbCvkQ1UKRS5VCOESu0F/nVHRatyrLkKmZW76kcyqiax92hru7G7d/jJh5Qt1RxljVqPu0y911bz2+v1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXEouIuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXEouIuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3DD1F000E9;
	Tue, 30 Jun 2026 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863000;
	bh=VQt8aDAcT+pT0xkh+esWHy6l7T4oBo6vOKm84lKYkDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CXEouIuGnmZkc61Kw7GRTjTiHsJtTmMz9EE+gS6ISSMXRyyz+pVA+Vc7XZm+qGhMG
	 SZzmPLMZejh1dQjkyleXHt9bSfvkRlwINkvwPV9YqNXZER8xH8oaxzBJkBQ2HT+nbv
	 GNT0at1RY/GAa/e24bLPGGpCOSmsfDRz0ErwD0D5FwtfwDml2CRrg9eZk1NZr8lNpf
	 00X+ZyX4hbzV0EVK8naX5LrXlmkwyY+meoOHLSRM8xiZ3ooMtTMKed2LGGDZy5/+cb
	 3WqHAipBeY04rrH61utvgWUWa4FfiVaOwyPMFGu2/Lu+rec8yD2i5rk/w1luXeSUwE
	 q/z/Kz2lyvZog==
Date: Wed, 1 Jul 2026 00:43:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>,
 <jorge.marques@analog.com>, <mazziesaccount@gmail.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/13] iio: adc: at91-sama5d2_adc: adapt the driver
 for sama7d65
Message-ID: <20260701004313.7bd1a35e@jic23-huawei>
In-Reply-To: <20260630093603.38663-5-varshini.rajendran@microchip.com>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
	<20260630093603.38663-5-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 15:05:54 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add support for sama7d65 ADC. The differences are highlighted with the
> compatible. The calibration data layout is the main difference.
> 
> Update Kconfig help text to mention SAMA7 SoC family support.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> @@ -2639,6 +2667,9 @@ static const struct of_device_id at91_adc_dt_match[] = {
>  	}, {
>  		.compatible = "microchip,sama7g5-adc",
>  		.data = (const void *)&sama7g5_platform,
> +	}, {
> +		.compatible = "microchip,sama7d65-adc",
> +		.data = (const void *)&sama7d65_platform,
Silly question for you that is more about the original code than what you
are adding, but why the casts?  It is already a const pointer so I think
we are fine under the C spec to just do this cast implicitly to a const
void *

If you agree, ideally please add a precursor patch to drop these casts
before this patch.

Thanks,

Jonathan

>  	}, {
>  		/* sentinel */
>  	}

