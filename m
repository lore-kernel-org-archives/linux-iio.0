Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551552931F0;
	Sun,  2 Aug 2026 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693775; cv=none; b=iSuyjX9JsTM650I81EZO0DdqcnIXAxGfJt8LxifYhHJebXktFApcFDarVl/9UPMa3X6sUXpFlEVdemeNnkXT8+i15wAp4ib+P2lZMvcTWKpA/tivZ4aZ98xsshEICn/exHvdjr6JiDkI05JyKwdTsmBEA89SaLCknzhI6ppTrKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693775; c=relaxed/simple;
	bh=EzAWnt7d9s4hc7aNlQIQVsbQOwpOp+Cccv/vXw3ZXW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjhCk4gJjvbEH8g4UM9Pu0NsiQ4P3/0BqHbN3kVGctBtC/4l03YKh4gRC0BkEA+X3DFIAa5+Homsn/BRMsC0a4hQJIBNCbOBsKllq958iYirhn9dKfXRdUHdo9NwLqDwT6b5NxEdiHqnZBS4zi5Es8x3jLbxNRWEwJthXkHQMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drFyaSFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drFyaSFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BE41F000E9;
	Sun,  2 Aug 2026 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693774;
	bh=Yw0fUSeHly5gGDEVa3JOsRUh6SX/7nYcIBiSFEOmUyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=drFyaSFzXp2F11mMDTDXnIghLlNHuSzZ0yVp6bsmlVFtbSYKCRab2CIbxey8QA0ur
	 NHAReUhJyUML/HcosUflXRfpiLU17t2yEhfVNxDs1vnvAN2jgqAmArgeIuctQbozmi
	 mnqbKuue4vziuCjw8hBRjAr0zTze+ElgG0sQgZYyLYbWzjTwx0IisMBPbPL9XYBsRL
	 w7bAAqeWiIC0rKQITJ6ei+/MVwKJPJGBNyoIDSphTIos10l1p9WAWXH7Ck/XZejvC3
	 gXDfgk8u3B3jsG5YHDvC+0vGeyc9dmmKRAlw0umAdnVzwM7BnM6kYELg7RQ7M+jYbc
	 PJuJDR/H/ljMg==
Date: Sun, 2 Aug 2026 19:02:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philip Mueller <philm@manjaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: imu: bmi270: fix typo found in dc757dc
Message-ID: <20260802190249.6657ed44@jic23-huawei>
In-Reply-To: <20260731195325.44453-5-philm@manjaro.org>
References: <20260731195325.44453-1-philm@manjaro.org>
	<20260731195325.44453-5-philm@manjaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 21:53:25 +0200
Philip Mueller <philm@manjaro.org> wrote:

> Fixes a typo found in dc757dc.
> 
> Fixes: dc757dc1572d ("iio: imu: bmi270: Match PNP ID found on newer GPD firmware")

Comment typos don't warrant fixes tags or stable inclusion.
That is even more so when the meaning of the text is clear even it
it is worth tidying up the typo going forwards.

Thanks

Jonathan


> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Philip Mueller <philm@manjaro.org>
> ---
>  drivers/iio/imu/bmi270/bmi270_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index 839e71b65f05..9bdd4d7a821f 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -42,7 +42,7 @@ static const struct acpi_device_id bmi270_acpi_match[] = {
>  	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>  	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
>  	{ "BOSC0160", (kernel_ulong_t)&bmi260_chip_info },
> -	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
> +	/* GPD Win Max 2 2023 (since BIOS v0.40), etc. */
>  	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
>  	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */
>  	{ "BOSC0260", (kernel_ulong_t)&bmi260_chip_info },

