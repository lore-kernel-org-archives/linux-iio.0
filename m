Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CC171B1;
	Sun,  2 Aug 2026 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693499; cv=none; b=pOI/2xOw20IhpfUbkdis8xNhHy0yy+ME1AFbw9O3w3x4SAoBQpsa0LanD7sVfpkZfYfZjdmdb+kPPELk2s+wTeIPAsY1aUR6Gd2Yj/67BIuFfRFU7Fp8Cq7jW2N8spUCib6/a9ce7+9z6KkTOoG+qD+fD77UGyF36rUwZFewIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693499; c=relaxed/simple;
	bh=OSJU60Ju+ZK6LjOebLC+PHRFdd5eDpTMWvqdr1i2x4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOC4Vdupxcono3Ed5Oxo1RjtA+LVLU0EPtZTAdsGaf7gp/jXNhb7RFHCyOSGCQntaNfVhTB9NC2c1prYVIPJebup6TV8HP+cOVKet+hARiRcA71riCCPfkS5SQSNMnXVFtuqU1JuktLGhn2DRafiLRBEwM9x9IkppxkLBrrKa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOC76Mk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOC76Mk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E8A1F000E9;
	Sun,  2 Aug 2026 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693498;
	bh=lriC6o+FwwtR0qXxXICqlV5zdC5yBDL0JS78923Six8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bOC76Mk8rBcEUXj8j/Sl8vFkyg6FyZmlLtzVRyY14nnwNE/4NzTRql5kDtP6yCcoU
	 f+qhsI0n9iXafHE3xWbWnv71gzYg26+vgDcySP/iKO/TDP8rBsGots7MegfGpaBF96
	 aVsZWBrb2ESSDR6B/gPmktd9PL4qjlgvoHr+qjt6Q1bpX5QQEP9QM+n6zjviKAsx+W
	 tedLbkLC1TcRlvwOmOV/6Q3MKjjr4xND/W+abDFrGTDNtUonM64lh5+1xwiIi/fdSL
	 vETgx83EgeiTjXp+1lL+itcnE3NEnkuj9fChHQEKAhxPimmflC6mOK7tQ2hfMhwVDB
	 4tQ0a4J+2n9zQ==
Date: Sun, 2 Aug 2026 18:58:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philip Mueller <philm@manjaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: imu: bmi270: Match PNP ID found on OneXPlayer
 X1 Pro (AMD)
Message-ID: <20260802185814.431a6425@jic23-huawei>
In-Reply-To: <20260731195325.44453-3-philm@manjaro.org>
References: <20260731195325.44453-1-philm@manjaro.org>
	<20260731195325.44453-3-philm@manjaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 21:53:23 +0200
Philip Mueller <philm@manjaro.org> wrote:

> The OneXPlayer X1 Pro (AMD) uses 10EC5280 rather than BMI0260 or BOSC0260 as PNP ID.

Groan.  That's a realtech PCI ID not a PNP or ACPI ID.  Those can be used in
ACPI but far as I know realtech never made IMUs.  

More of an issue is this ID is already in the bmi160_i2c driver.
If they are using it for both parts we have a nasty problem
and it is probably a thing to fix as a platform quirk rather than in the
drivers.

There is a bunch of history of this ID 
https://lore.kernel.org/linux-iio/?q=10EC5280

IIRC Bosch provide their own mega driver supporting all parts from one module
and then do part detection.  Thus wrong tables often work :(

Jonathan



> Adding the ID will enable the BMI260 accelerometer on the device using the bmi270 driver.
> 
> Closes: https://github.com/ublue-os/bazzite/issues/4805
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Philip Mueller <philm@manjaro.org>
> ---
>  drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index 036c6f0f7cd4..d7faebcbd2fa 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -45,6 +45,8 @@ static const struct acpi_device_id bmi270_acpi_match[] = {
>  	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
>  	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */
>  	{ "BOSC0260", (kernel_ulong_t)&bmi260_chip_info },
> +	/* OneXPlayer X1 Pro (AMD), etc. */
> +	{ "10EC5280", (kernel_ulong_t)&bmi260_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi270_acpi_match);

