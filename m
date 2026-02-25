Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C62ED848;
	Wed, 25 Feb 2026 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046454; cv=none; b=TdxoWd+2sDoKB3IqYleBq6em/p80ei7Y1d2ETaTXem2Ukhxo/TglBMvKWUCP77VBsjSiq3JssiQcGdkZUntv9ea0i9ZbpB9uC/bSYplg1U2VzZVB1vuV8Q6scFCCczLOoXV/V/bFIFIjzTX8LD83LycH/R6ZTygHptSO0hMsNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046454; c=relaxed/simple;
	bh=n2ThqRKc1AVWhg9cT24RDtRVQbfzmfNVs8WJEir8WL4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fr2TBGOm6MT8+6j3nfd7Ea6l8oTfRP0VSZr5P8Tt4mjB9ELqlwGhCWhq5HKH/vc7PliKaIDYDBeO84Bm9q1cMyAR2+UeaiVemjThYxh5vHmHUqh5sOMVS4KmG4plmCfFhBcHZfg06MM88Nn6eSUS1PBdKiyH0PepAxWyYHP2OVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKWhlnlD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKWhlnlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584F1C116D0;
	Wed, 25 Feb 2026 19:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046454;
	bh=n2ThqRKc1AVWhg9cT24RDtRVQbfzmfNVs8WJEir8WL4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=eKWhlnlDDPaFKVpRi2Ix1lTUPacf8fV45r8m348II1HYnmB2UxwK+VyqxECLO0Nli
	 7WmQVpF6T32cplZLTBa9z6flhd35Yiya55DL6pvXRrjk4/HWnjpC5XTq1Ut0wopkg+
	 ON0OvaA3AFFrS+atnElbcG+VtlFWaHDB6lnbl1vpN6q6wXTSk+seUPr7C9Kai3kcnu
	 lnEmJgIK3ShSinAZk3c/pNy22BtYS+ssAqz5JmzufFjnF6ntN8z5KFRdHLiIwmcJlC
	 bhMVkEipvRc+qeM4H1K+H5wLelX3jtF8YUxyLIZ0g3EftEiPEMN3FAfzCFDDvCDYCC
	 smeoFzQRN8XxA==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>
In-Reply-To: <cover.1770393792.git.antoniu.miclaus@analog.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
Subject: Re: (subset) [PATCH v2 0/4] iio: adc: ad4080: add support for
 AD4880 dual-channel ADC
Message-Id: <177204645111.169139.7163032381688312306.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:07:31 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 06 Feb 2026 18:07:12 +0200, Antoniu Miclaus wrote:
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

[1/4] spi: allow ancillary devices to share parent's chip selects
      commit: ffef4123043c5bb29e61052a41e577ae1ee6837a

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

