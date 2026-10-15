Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646825A645;
	Thu, 15 Oct 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066678; cv=none; b=IWnVhmNuaXpjyfl1dSmjjjkRnDNFvcly+DI460XqIXSf3C4pR2fffS7Ch+golufV7EXu3ZGtTddGMX1V0al1RXSq/1Trv2WsOlNGDHKJ9GyiJb4iUrj8xEhzIfiSlMLG02vqyOG9uq7/8quzFDyaBOlgzQP8iTJEVqeG+t+Hx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066678; c=relaxed/simple;
	bh=sKCWxmKzeOQ1Yioi/RMhxMmK59jEUswQ89CHaFbG0m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ggZcUptmEP1yW6zW1WwJxsxHw2tVVQJHkFAtT9r7UwQjHjan/hEtHwIW65zAS7O7fPFWNzJyeHAbIOA5jY40mMTP7qRwn6962w2yRuOeRzHObbfnfy0X9ILsjXs1k/+miLsoB/xoaOmf3cjbtDdcJVZWM1ec86ZX57QjlPiVo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxyu6AE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxyu6AE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0671F000C4;
	Thu, 15 Oct 2026 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792066677;
	bh=kH/zjW2C9vFNpW+x//wSoOuLPWBCSMD6sNcP8TxdV18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Qxyu6AE6nZcEnFpeDP1G6VIh/Anf1wZt9KopvjKUzAjQlGfp+olDhcwXHq5hFJbQl
	 Y/hBfoqEhLjh9YFtSpzl4XWO42EAKLJ7njc0TEZHmZBVDLz4BEHl1KmhsDiJJDcN+p
	 5Ip1aMQSUq7J4upFYBVLbmD2MdyoZTkeuUHGjaCJY1Il1ksNCOHkylBdwOEqXv0mGJ
	 aWANrpfTWHGAic3BGzDAnY+1nXHz+Q1jCNl90XDnny0WpS1YNiTOTm3TMyifbgw5gB
	 s9aOU26BoFOq1BJGxNcZZL7MxpyRHwk+eTaMNsHfp69Ts5PONRzaBtx+P0XS3fcF/7
	 dZfXf/DN19dYw==
From: Lee Jones <lee@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Ryan Brue <ryanbrue.dev@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, mfd@lists.linux.dev, 
 Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
References: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
Subject: Re: (subset) [PATCH 0/3] iio: adc: add mt6397 PMIC AUXADC support
Message-Id: <179206667323.1910726.10765951043723632991.b4-ty@b4>
Date: Thu, 15 Oct 2026 13:17:53 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 15 Sep 2026 23:15:25 -0500, Ryan Brue wrote:
> The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
> reach. On boards built around it that ADC is the only path to the battery:
> the SoC's AUXADC is wired to board thermistors, and the charger ICs these
> boards use have no ADC at all, so without it there is no pack voltage and
> no state of charge.
> 
> Patch 1 adds the compatible to the existing MediaTek PMIC AUXADC schema and
> the header naming the channels, patch 2 the driver, patch 3 the MFD cell
> that instantiates it. The cell comes last so that no commit in between
> registers a child no driver can claim.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add mt6397 PMIC AUXADC
      (no commit info)
[2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC driver
      (no commit info)
[3/3] mfd: mt6397-core: Add mt6397 AUXADC support
      commit: cc6597f4e3b752de42249879e0c7054fd23628a1

--
Lee Jones [李琼斯]

