Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219D314D18;
	Sun, 28 Jun 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782659535; cv=none; b=bi4O2h3//AaJJVh6gLZMrdUpQq9X0wMS6gsX18gQEtHD+TQzQ8yEbJuCj9H7Cg8RRVgRnewQ+ug1egxIf3avKhT+XwDo9bxS+KLbeRy8arbQr0w2BkVffwbpC0aW9fIKG7bQ226BKy9zbuUraAGCq45oRP8gsJ16GeeX/00Y0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782659535; c=relaxed/simple;
	bh=JXG9DjGZ6oGtt1EaRNoGFQ0OigtdXWJrFt5FoD7YP0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itbGzYpXsbsZIE/96gLLdzBKgciG8P1ZaZChU4sNP9d2aVFhsHFViSugONrrNCM0aq8RZh4E0OQZFQwaj5pUXdPw66aJiB6L96LegAKPJ58L44OdCTKcIRMc/KszFGszjLo2iVQKPUZ4vyq7jndYm6FfLFv+xKtAnLAOYImHjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjYlZILd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjYlZILd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1641F000E9;
	Sun, 28 Jun 2026 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782659534;
	bh=IWgs1+Oej+M+5T80/lrO8pmr74UWry80sNFnJC69qUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DjYlZILdsJkXbUs9Juc6LyF6htc2aN3ikOWOkVingxSEPdI1VnJCwjiyYTVW7vN4E
	 oQprx1s++vtyNyItD9QcMXSis8FIMO+W8ixmNRF49ozRr2x24ylcsCYOGqTD6XWj6r
	 /74wzmHQx5WL68//XeQfZ7ty/4CQVHOkOtMSqLmQnD8k50Xr7JBiEdeE6+mBBYN2Bf
	 pDBT4XE2tB+Cb4ZOE55I6876ueo+0VA78jY42QiHAHYTuphw5KjpUHlDEhZ0r/vV+Q
	 YPAlRajzoehv8476UZuo5YjKvpqbAuNQgnpwRLVy6qJmUN9RrL8wEYMd2dsvIqzXav
	 R8xlbCYhebLzg==
Date: Sun, 28 Jun 2026 17:12:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, u.kleine-koenig@baylibre.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: magnetometer: add Melexis
 MLX90393
Message-ID: <20260628-strict-armored-asp-572d82@quoll>
References: <20260627095519.8377-1-nikhilgtr@gmail.com>
 <20260627095519.8377-2-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260627095519.8377-2-nikhilgtr@gmail.com>

On Sat, Jun 27, 2026 at 03:25:18PM +0530, Nikhil Gautam wrote:
> Add devicetree bindings for the Melexis MLX90393
> 3-axis magnetometer and temperature sensor.
> 
> The device supports magnetic field and temperature
> measurements over I2C and SPI interfaces.
> 
> This initial binding documents the I2C interface.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

If you are going to send any new version, then fix wrapping in commit
msg:
Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Best regards,
Krzysztof

