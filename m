Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76503630AF;
	Wed, 12 Aug 2026 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499344; cv=none; b=hPK6rT8XOAzevoQMuJQeluOly0kYNzqhXgQBTfZdNnR2sACtd0Bokn7oNnPMYlli7uUGqoeYdDTY/fINFxzNapcGk2GvjrnQbdcqNVebnUOJ5l+7OeYTgqfnE+Jpcg+5nVPg4OGas0zhvGXkm+tdqZ3bDYAfjYhagVazi8kBgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499344; c=relaxed/simple;
	bh=P/nko4Gqqrq/O4x1l8VxNkcCc5TtxsGxdlgxpE7079A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSDLP+UTktUQ3yz5EXaWO/+d+Fj6hWm3LdNjK7Qys+d3FBEPERomi/y/005TdW6OQWutS6MhOSXRqgHbzsoecTgEUOTzm1lA+JKrkKwrgdVG/8XpQyxPsYQthRW9KTfvIzFoOEW/3O8N7scXHzstq7M4kckNq6vVmZC/C3gLIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkVYFEoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkVYFEoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCA61F000E9;
	Wed, 12 Aug 2026 01:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786499343;
	bh=15TlYge+6QuHLS4U7G2sgXgQ9WYzV26V4Ez1Cqz0UDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BkVYFEoM50k3MioXIg0rMbpjHD1MiNs4rGxc4hS30weu9ZsPxG0lcLo2yp5PelT2J
	 5VPbMQHXwiAZ6JfhEW3/rOZ6aeR6ddkJ6rc8y+TFq2cpvrmjZjEohr8jN7SqW/dwPY
	 e4/vXX7w75EsTqiEYCP4IT6yzbLgxwRRpLXlqmJtI3DqpqNKHIvAXN7RtzxyPMbZtt
	 KldvU9rWC3BcDnuKvMnsem8YqTYoLHfwnzrfH5W6az0ZpzYOfWK8mvPRE6Kqj+FQWH
	 8JgkRP+xTgVe+IOXAOd4wVGpGTokeomOtr+bU7geluX8WN725mIN/lcN+1t42vg94l
	 2FFtY4WVwJTUg==
Date: Tue, 11 Aug 2026 20:49:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: dac: add support for MCP48FEB02
 SPI
Message-ID: <178649933698.495343.14431256197794684691.robh@kernel.org>
References: <20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com>
 <20260804-mcp47feb02_refactor-v3-2-97f8b81f3628@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-mcp47feb02_refactor-v3-2-97f8b81f3628@microchip.com>


On Tue, 04 Aug 2026 16:29:48 +0300, Ariana Lazar wrote:
> Add the SPI MCP48FxBy1/2/4/8 part numbers, the spi-max-frequency property
> and a devicetree example for SPI usage to the existing binding.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 221 ++++++++++++++++-----
>  1 file changed, 173 insertions(+), 48 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

