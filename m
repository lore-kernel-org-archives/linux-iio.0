Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD783D1A82;
	Mon,  8 Jun 2026 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943118; cv=none; b=GVjYyXUVKhsYHMyg3W6TaFEmhNjLRDcN/FGul2uKf1FZviRuDOeWBiHn/RTeNJeDOnT90pwv0QhzG9QQCABGaPvu4bcu/uA70owoYvJlNWVpq8boW+29SoKpO1xIwFCAsQ7h5TdaY7PcxiAzzrSdPAAVugCLMYx8bkUb/2Z52MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943118; c=relaxed/simple;
	bh=9IpjzufNOVTHBBcl7gN+w6CUmZlUzZpigw2LpVPYVV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=op6rXCWDCOMmtSRGcw1lIL2CkgLiwJ9P7Dn2qB5TTBZcC4xUif9tRig+aypHOKdVQuVV4MVckp5siJy18smZhGmynKYDSuAETnquwCw8nYVqFa+9x09Ttvh3ozE+39MIjJ/xmXDXaEopuVPM6IgErA05WFawfK2hShblHn980h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvhEpmAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvhEpmAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E341F00893;
	Mon,  8 Jun 2026 18:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780943116;
	bh=HAgGWzXz1Jqz5A1PiXxmD4D+l+T+NSCfLaOJg2FdU0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BvhEpmAiBsRu1ua5l/eGBGTlYCr61s0x+4VtblUxq06kKZ94wcB2AzLvMqW2GYCxz
	 pSTHssdr7ZPssiHeyIS8LUuWziabNQSatE/ReyIos3i+i2fqYcxd3/p5xMpn4n5CBC
	 8zM98luW2FOSX8N1w7ePnfxYK+Z3kQHzQs9s58MqKpFU4ctyZfohtSf5hSjwLZAhjk
	 uaG+v1LIdSSmHy38n0w7J3uoCTNC6zVafTq/O6DGRuSrISzd6wnn9bT92/m7Y2WAIt
	 rDoPuCu02ts2c1/fukmSgQr0ugm/uuwtyKXAWbBp0gpFoQrgN9EzfhGDupo4mqa1Ej
	 urUXRiyUTno0g==
Date: Mon, 8 Jun 2026 19:25:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 jorge.marques@analog.com, antoniu.miclaus@analog.com,
 mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com,
 duje@dujemihanovic.xyz, wens@kernel.org, sakari.ailus@linux.intel.com,
 linusw@kernel.org
Subject: Re: [PATCH 0/3] iio: adc: Extend ti-ads1100 driver
Message-ID: <20260608192505.3a920eab@jic23-huawei>
In-Reply-To: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 20:35:39 +0200
Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:

> Extend ADS 1100 driver to support ADS1110, which is a pin-to-pin 
> compatible device with higher resolution. This patch also updates the 
> device tree bindings and Kconfig description to reflect the new 
> supported device.
> 
> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
Look at your series title vs others that add support of new
devices to an existing driver.  It needs to be a lot more
specific than 'extend'.

J
> ---
> jszczudlo (3):
>   dt-bindings: iio: adc: Update title and enum
>   iio: adc: Update Kconfig description for TI_ADS1100
>   iio: adc: Add ti-ads1110 support to ti-ads1100 driver
> 
>  .../bindings/iio/adc/ti,ads1100.yaml          |   3 +-
>  drivers/iio/adc/Kconfig                       |   6 +-
>  drivers/iio/adc/ti-ads1100.c                  | 165 +++++++++++++-----
>  3 files changed, 131 insertions(+), 43 deletions(-)
> 

