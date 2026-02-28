Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0035E941;
	Sat, 28 Feb 2026 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305222; cv=none; b=CjHn1KiH72pBt7B4RQjPpHHwJj7eMPZ8t/FQ0zzDD3cpv1h1aI0VjHz9Um81dxixbW+QILw15a9/9kZuqqXCsSQkLwQ26oVgSURgwyILn5wXFx5PmcU3GfKKkhA+VBAVruLe4GoJrpFK1q4hj2iMtOSs2lpTXRV6skDakvhFRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305222; c=relaxed/simple;
	bh=CXjq1K1VSjWsjD7ZIPk53AMmYjEmUW+FwerOFUkeM10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfH2gd1qk44nb2auwJ8WfxF/xdAv1KDnssXQg/I1z4L1BqiqIPQ8w+vAKkx0aPV2Vrg5xKcrR50tpoPe4wd9K9jHIRd+y6OCbDJGOG5qno4Qe8g4hz75gdIeSDjrizoL2iDDxnBzNzBgfuvMlCEUTDFPn6rpAynuj2RjCD75nJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htoONh0m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htoONh0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F828C116D0;
	Sat, 28 Feb 2026 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772305222;
	bh=CXjq1K1VSjWsjD7ZIPk53AMmYjEmUW+FwerOFUkeM10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=htoONh0mOBKwpIvwdkuvH+GsTajYWd/gL5hxDB1+xkRmA5jtlGtS2jfjcSTuf059Q
	 5zye7hpT83Gqh6b+nHurMmSfRQHRRPxXnL/wKsm0u3zYBAjPgOQfNdEOTr8mDSNgc9
	 VkuR9yKKy89+8Eo2HoTZuPNv/rMdkTfzGaUZWR5QPkLZOLBmrU65tPZ4RwbDcc4z50
	 LLdx5N3B3OlrUpg3CPZUON50dfbqpiMUXsdPLLEPX39qV+xL6yqWbPpb1+HZWEJTkK
	 74S1s/6cmq4WljutMG7nLYoY3OAI4+kVQZrDf3tH7lDP2DsrPT0jkw+TSWzkHI8O1d
	 LKDSL60JZQ5Bg==
Date: Sat, 28 Feb 2026 19:00:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: (subset) [PATCH v4 0/5] iio: adc: ad4080: add support for
 AD4880 dual-channel ADC
Message-ID: <20260228190011.27f424de@jic23-huawei>
In-Reply-To: <177204657734.171265.1894729966536357038.b4-ty@kernel.org>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
	<177204657734.171265.1894729966536357038.b4-ty@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 19:09:37 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, 23 Feb 2026 18:20:59 +0200, Antoniu Miclaus wrote:
> > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
> > the same family as AD4080.
> > 
> > The AD4880 has two independent ADC channels, each with its own SPI
> > configuration interface and LVDS data output. The driver uses
> > spi_new_ancillary_device() for the second channel's SPI and requires
> > two io-backend instances for the data interfaces.
> > 
> > [...]  
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [2/5] spi: add devm_spi_new_ancillary_device()
>       commit: e02902dd493bf9c9b05353c761737ac514ad7a5c
Hi Mark,

Can I have an immutable branch for this so I can merge it into IIO
once the rest of the series is good to go?

Thanks

Jonathan

> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 

