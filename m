Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A4F330B30;
	Mon,  2 Feb 2026 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072543; cv=none; b=jDBraZw0QFp7pYCkRr05HBI49+Pk69l978Ix5EaqhYyyM1OgTzj1tk5Kde3qen/HGVZzNw/+T2YNSYqNHh4uwzvXDnvPeSlY+Cz+2e8z8aD8N1HxAUHzeUC8bAe/KmDJ47jpgVplryJ4Kt9uVXILdpzpUxUpYl0NAgsuY9qrtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072543; c=relaxed/simple;
	bh=ZsoD2vl1E06oYSAcnI6EVM/cXK5Ab1V7TGQu/No2s9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mK9BkD8IgaExfretV2JJnhcLCqnGRM8kIAGh9Eic/iyz0HsUYrqRUtPtMFjRCEFxnmW6ace2OVh8/sjwLWHzdA0tf6m8n9qw0j5UeufD5HFHCzanJy90c4V30xK5To70cm9NBcq7PVJkp6IMWyU/cMLmM/nWj5U3ZPydtlIAwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dstfJg26; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dstfJg26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D32C116C6;
	Mon,  2 Feb 2026 22:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770072543;
	bh=ZsoD2vl1E06oYSAcnI6EVM/cXK5Ab1V7TGQu/No2s9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dstfJg26Ge6HFusPvD7+mzzfPJjvLq+jWT66JQI2ukQGkK0td0/8+vcyrtmwiDBQQ
	 FW73CWg3oZO37COMCqQXRzGtvaGAc73tw/hvd/nN2m+faUe3ZJ5HItIRKVlPsxTgvd
	 +ybxRizMS64c7PSWILAkZ9w14wg1jGejZH5t7R2wzJ2El0WEHKHOdk6QPFOOpFGcia
	 7n7ar/YlEjorCSSoZMK6nC0Inl1+aZaagBo7YI8RW3tI1jRrgFsGV+d17qdzZ5EWZW
	 gXoUtvaDlPWjGbm7pSVZd2lMu1svhb6DW+0O1IGalYDivpKqcQ3bq5zid1YUOygCOK
	 YIeiS/g6NGTkw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
Subject: Re: (subset) [PATCH v6 0/9] spi: add multi-lane support
Message-Id: <177007254040.964046.276664033882680983.b4-ty@kernel.org>
Date: Mon, 02 Feb 2026 22:49:00 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 23 Jan 2026 14:37:23 -0600, David Lechner wrote:
> This series is adding support for SPI controllers and peripherals that
> have multiple SPI data lanes (data lanes being independent sets of
> SDI/SDO lines, each with their own serializer/deserializer).
> 
> This series covers this specific use case:
> 
> +--------------+    +---------+
> | SPI          |    | SPI     |
> | Controller   |    | ADC     |
> |              |    |         |
> |          CS0 |--->| CS      |
> |         SCLK |--->| SCLK    |
> |          SDO |--->| SDI     |
> |         SDI0 |<---| SDOA    |
> |         SDI1 |<---| SDOB    |
> |         SDI2 |<---| SDOC    |
> |         SDI3 |<---| SDOD    |
> +--------------+     +--------+
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
      commit: 37bb4033e48b8a0ddee66fd77f9e12a9a930681b
[2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map properties
      commit: 31eab8425110b933dd7c818809cb4ffa3b2c6d82
[3/9] spi: support controllers with multiple data lanes
      commit: 002d561f89c3a61ee17d38070e48ea4eb1243732
[4/9] spi: add multi_lane_mode field to struct spi_transfer
      commit: 5621a7bc851658ea2f8e015060f8bb5d27739b06
[5/9] spi: Documentation: add page on multi-lane support
      commit: 05c3bd745bb065223201824f0044455558541bdc
[6/9] spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
      commit: 2e706f86a5aa94702694774efb7d8b151c6d724f
[7/9] spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
      commit: 0ec5ed7c95d1ba6a74491928ff38abb351dbed36

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

