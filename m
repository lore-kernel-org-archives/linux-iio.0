Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7353438B5;
	Sun, 24 May 2026 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779656657; cv=none; b=OiPbexdQIS++i1NsAv7GWELTh7c+iWeGZsCgE4kcBpSLcf6rOT0sRcXbfAXYnI24CPIDY0tfp+dOKaWWYNc9PybPc9efYlUYTRevg9P/xvsZPv8G74DnQ1TcpsLqddOgdlXEDwJXrdgUb4rQbLazgwKvF+2FMCIJyugxNytUisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779656657; c=relaxed/simple;
	bh=HvSm/K85iZomHNPHfHkOgB0b4+Qd2VST8q2O/sL1E7A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tBa7FrP3qBpdDtAfZc4ZpZAy1UGjTJvYzOwBcCkoPFi1TXtzP5TKEgYiKjsBK1GC11HFRiACRcSHCZfOib8h79FoIWUXb85kemF4BrAa7dF+oyCwPVDwehPNOZQnDaCRUqnFu0feij9o8thO6igZyodigFIKFUvQNKhZiJhV1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amvIA7xB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amvIA7xB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C463D1F000E9;
	Sun, 24 May 2026 21:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779656655;
	bh=4Jo/vbPByOEa/DPjlGN3cnyIvKkPU6P7russhnbY7K8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=amvIA7xB2VEXc9wVdXYXtZoGXXAu1O2/4qbr3ZDz5XtTea7HAQgaWPeBvyIJjxa8s
	 YEuPoezesW64Za2ZwISj66+GaRvWpRXvdeGtFmF54zYzBJy1KK0FeCCHjBDzBBBGsu
	 2u+c9mOd9q+q4FiLGF404nQ0or5xSFYlR2cveLfthQqimDeQWROTBJwsL26V1S/Hbi
	 d09By8DToFYTgcPq2U7AYzOMEUgGNvH7csIjvKbg236z2FvzO/G5CiiJnw2ZtQw33f
	 OXMNrNviyyqMGvHq9Iq5h/LnQC/l7h6yxl0mejmZqKZQ2+/b9H6Y9EVQtnFi/GcGiY
	 bp0vjK4NWnFqw==
From: Chen-Yu Tsai <wens@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maksim Kiselev <bigunclemax@gmail.com>, 
 Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260516-sunxi-a523-gpadc-v3-0-a3a04cff2620@mmpsystems.pl>
References: <20260516-sunxi-a523-gpadc-v3-0-a3a04cff2620@mmpsystems.pl>
Subject: Re: (subset) [PATCH v3 0/3] Add GPADC support for A523
Message-Id: <177965665249.167937.6469450269441634899.b4-ty@kernel.org>
Date: Mon, 25 May 2026 05:04:12 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sat, 16 May 2026 07:34:13 +0200, Michal Piekos wrote:
> Add support for Allwinner A523 GPADC in sun20i gpadc driver and describe
> corresponding node in dts for A523 SoC.
> 
> A523 uses same model as existing driver except it has two clocks.
> 
> Added support to enable more than one clock in the driver, extended the
> binding with new compatible and wired up dts node for A523 as its own
> fallback compatible.
> 
> [...]

Applied to sunxi/dt-for-7.2 in sunxi, thanks!

[3/3] arm64: dts: allwinner: a523: add gpadc node
      https://git.kernel.org/sunxi/linux/c/44cf19e41c76

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

