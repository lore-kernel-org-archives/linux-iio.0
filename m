Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228F23536B;
	Sun, 21 Jun 2026 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782060580; cv=none; b=hPRzou0kb0y23bQDWaebEsctA6lL0mbaZBzjR49pVpqknrAYssEwUcA1G7+uAeKZ7SoHIp2/NrMDFVGkcD45p5mQfc6ylFXMRHcA4pFNGK6ByCtOnZiYt0iukTEH+0GUnkU5do8dARChCLlQSMdFcG/idzR+5FTe861/M3xh1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782060580; c=relaxed/simple;
	bh=K8RXR5JOKZ5wuu+0t6hkQ9SXM0nRwS3lf0XfhZwBSEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HR7yQHKywJUnEL9uRKbGSA5xyBWjIZxtwgNJeABgXPbiIHsYl1KIUhJON19y8fjZcixPZljKXAcpoqWeIG6Ft1bE8rUQ9As5OEGYXRwOEt9Dib3QoomYTDK8Fs8TlbI4Chav2rfVKblHzLm2LmhtBb+J4knzVP3osM4HwBt8EIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozSv+6fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozSv+6fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FE51F000E9;
	Sun, 21 Jun 2026 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782060579;
	bh=CmfzyDDUjqNwA27f2RUYLxlzUocZI66hlzMjI6ItgNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ozSv+6fcDTo1ZyR5F//Kl9+MU5JipTFlFuXwCGReIrq43wW0yDlC8cOlCjwhnEbi6
	 6o55a8wxT3vhe0trV7UvYvUKRSbLWbi/jypOwkaEtvBSqJ1Gbnfd4oIBdgKQ2MOUlR
	 Mmq9rJMCHvjRUXG86r0ZZn2FT5UzBobQWw+266qLLPfBASPPUHDCQNaCtyzkAJQi9c
	 ytRgV+JxHZepOy4TQ/6tl3pS45ddFoVGQ9VqwuddTM7cIwhF6bWtgn3IbHmVPs40c3
	 hE3hatk/7HzVtFAMIVF1gFScCEptbz5DECEhdu7vE2L9lj0DfI9vkZfhPYj7Z4HZU/
	 j+tuOpOprRwUg==
Date: Sun, 21 Jun 2026 17:49:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iio: dac: ad3530r: Refactor setup to
 table-driven register bank approach
Message-ID: <20260621174930.35c2091f@jic23-huawei>
In-Reply-To: <20260615-iio-ad3532r-support-v2-1-84a0af8b83fa@analog.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
	<20260615-iio-ad3532r-support-v2-1-84a0af8b83fa@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 14:20:15 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Replace direct register calls in ad3530r_setup() with per-chip register
> address arrays and bank helpers (ad3530r_set_reg_bank_bits,
> ad3530r_write_reg_banks). Convert sw_ldac_trig_reg from a static
> register address to a function pointer for per-bank LDAC trigger
> register selection. Switch spi_device_id to named initializers.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

>  
>  static const struct spi_device_id ad3530r_id[] = {
> -	{ "ad3530", (kernel_ulong_t)&ad3530_chip },
> -	{ "ad3530r", (kernel_ulong_t)&ad3530r_chip },
> -	{ "ad3531", (kernel_ulong_t)&ad3531_chip },
> -	{ "ad3531r", (kernel_ulong_t)&ad3531r_chip },
> +	{ .name = "ad3530", .driver_data = (kernel_ulong_t)&ad3530_chip },
> +	{ .name = "ad3530r", .driver_data = (kernel_ulong_t)&ad3530r_chip },
> +	{ .name = "ad3531", .driver_data = (kernel_ulong_t)&ad3531_chip },
> +	{ .name = "ad3531r", .driver_data = (kernel_ulong_t)&ad3531r_chip },

There is a high chance this will cross with Uwe's series that does
this change for all SPI drivers.  Before you send each version have
a quick look to see if I've already picked that up.  Or perhaps
better to just pick that up your self as a dependency to make
life easy. Just say you have done that in the cover letter.
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad3530r_id);
> 

