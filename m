Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022558;
	b=nhGzcdBEPNb6DwPvzPh5wkOknRlQy1ARcBn7PLQJljmUPHBzvavLOmxVkbBe5eH4vBd3
	 Mg1EGzxYb5ArFvqGQ6FY6pydzge6A11x2z8SrqVIE14nA94oBEUkMXv6y+w0gevJlKKLl
	 N/TXB70uLQDJMWrLmC284orAgMlfscgs3Oq10acpzgegkYva5F0jCUXZsISesqmUGH1uQ
	 /c3vcODxBl6+3jb5JraK1JmujMrg/nKQO6T/XqHWt1oZ5eYosTY3EsDuEgTKjmd14yENi
	 AhcJcNETv0R3g3nwuNr121FXYPuQQhCfv+g28Q57KUiHQME3Rmn8kI4FYHkTqdefmiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022558;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KgaZ62oSa00oA9mQS/DfUIyhLFgBJL1fbVfHwuLm/0U=;
	b=yOoPaeVj1rB8bJ6Sri9g89ixCAK83+xWbZVnQt40oFKEJE7T6Ym8uOEorpmyRbvKu5+c
	 q/PXFOUbY6bRkqrYG0ZxcdUx5L14vmADobl09V2eLnDnvPWcbnqxCGDwwJim5jH7iTlHX
	 us3C1y9/+p8Qjw6MlxcsV/rF3AuHlopIBnD8Jx7ywjlc49b0/t1x/T5bCaLJx9/7C/77j
	 RvjDCGwOMAGDT4dtvgLufa2nZ53VCUDh3Q8V1Dx6lXATVvw1cRLOwSAq7aCur4DpzUeCR
	 8Z0VdSqgUIg0Kxv4Nh7zCJTNn0OHklcNkAfszYfrB+StCA8wGTXL3Kt2+TjP5mpDUSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrEbFcbX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146F606A326;
	Sat,  7 Nov 2026 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrEbFcbX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B131F0089F;
	Sat,  7 Nov 2026 03:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794022557;
	bh=KgaZ62oSa00oA9mQS/DfUIyhLFgBJL1fbVfHwuLm/0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QrEbFcbXL8YtqePGg360aL/IUtwgqELEWhHqDqb3YTK+qyfITfNzQSBKAWGFl9VQ+
	 iyRYocFCvXWN43ih35bEYsaY/ht89KYf2QlFWRCl1fDVsATK/2ldrh+NbW/ed6xQUW
	 YJ6NKsYcV8sca1El91XQsOZuaBmq2aenkvrnEINUtVpj658c3jDNbqJ93O7getmZIO
	 XBu23OMpIuxeEYsGkYqXav5cYqbUWxsQR6SNxxUD/U0IbG5Jz5FE2xvg2FAMcaeepn
	 9EOlXZPjZt+trt8RiULb+jzYplZtao+3R2FKSgtxpTesA1ydAEWkpEyTDXN+0OqAHp
	 IMRVP43KsRlzQ==
Date: Sat, 7 Nov 2026 03:35:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Dragos Bogdan" <dragos.bogdan@analog.com>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] iio: adc: ad7405: Add ADuM7801/7802/7811/7812
 support
Message-ID: <20261107033553.362bb0e5@jic23-hlaptop>
In-Reply-To: <20261106073937.13927-1-pop.ioan-daniel@analog.com>
References: <20261106073937.13927-1-pop.ioan-daniel@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 09:39:35 +0200
Pop Ioan Daniel <pop.ioan-daniel@analog.com> wrote:

> This series adds support for the ADuM7801, ADuM7802, ADuM7811 and
> ADuM7812 isolated second-order sigma-delta modulators to the ad7405
> driver.
> 
> The parts are compatible with the existing ADuM7701/7702 handling and
> differ in input full scale and maximum master clock frequency:
>   - ADuM7801/7811: +/-320 mV full scale
>   - ADuM7802/7812: +/-64 mV full scale
>   - ADuM7801/7802: master clock up to 25 MHz
>   - ADuM7811/7812: master clock up to 50 MHz
Applied.

Thanks

Jonathan

> 
> Pop Ioan Daniel (2):
>   dt-bindings: iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
>   iio: adc: ad7405: Add support for ADuM7801/7802/7811/7812
> 
>  .../bindings/iio/adc/adi,ad7405.yaml          | 25 +++++++++++++----
>  drivers/iio/adc/Kconfig                       | 14 ++++++++--
>  drivers/iio/adc/ad7405.c                      | 28 +++++++++++++++++--
>  3 files changed, 57 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c

