Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D342BDC0B;
	Wed, 25 Feb 2026 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046580; cv=none; b=cYoUNsJZkqY9SeAw9BWyL4wUTUTf4L7NaQM/bwEvcu9+V6coCAiBR+wlcN18qpGYMvsVjlMCKXKNnadY8dQCS1tY56RMWM35eHug+eRSvMJXGPh6rhkWHqClwmTEaUA+u0HLugEvmsFIFJYz7m9eCLUwGYnofXKwMbLXlHRVh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046580; c=relaxed/simple;
	bh=noh+6VhnrLno4CMeO8qob/Mp3YWzLfTF2cssXTDsSpg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NR6iGMF4JPkvgUepz5jD1F3tjk3ZvaSfCsmz0hq7UzeJvkmX8hbWyooKnO1OzZxTKGeWfJi81sb9CYLRnxKmBmBn+8raH2ndbO8IFCuFRtPhPot21T0TSlSbUgn8XJT9YdmQD3XpXuxMOwn4KnNXDztLRXWB1X/ohqIQj9VD7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BejJRzvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BejJRzvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985C2C116D0;
	Wed, 25 Feb 2026 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046580;
	bh=noh+6VhnrLno4CMeO8qob/Mp3YWzLfTF2cssXTDsSpg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=BejJRzvYBjofFZ379gj4g3EV4OJTUbN6+Jj8C6cJrRsZ2Jl+dOtRKgVEUSWMjg6CP
	 qPgVWGYVh8mKjclPde4LfHtNYeRzsQAtOrtsPDbOk3HRPX4isr/4VXwL2JHkb5HC2/
	 4/ksGFNlOosT1DgZPIKoifjaUwxDay6xl0imVJyPqfp2VXPRNBSADgLF55Alg3xrH4
	 3ool2Bn1NiS4WvHJEuvHv6pxB+DAOclk/IsN53KSFUNAMbEMPKwdHGyDxGYylz8vp5
	 BoFCs0imSbc37oEbN9d3k7KsNaDx4Eada+rVXPOCXMeuXBXgVPVk76AF3jhOCPGIxQ
	 NdJNOClubWx9A==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>
In-Reply-To: <20260223162110.156746-1-antoniu.miclaus@analog.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
Subject: Re: (subset) [PATCH v4 0/5] iio: adc: ad4080: add support for
 AD4880 dual-channel ADC
Message-Id: <177204657734.171265.1894729966536357038.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:09:37 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 23 Feb 2026 18:20:59 +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
> the same family as AD4080.
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface and LVDS data output. The driver uses
> spi_new_ancillary_device() for the second channel's SPI and requires
> two io-backend instances for the data interfaces.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/5] spi: add devm_spi_new_ancillary_device()
      commit: e02902dd493bf9c9b05353c761737ac514ad7a5c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

