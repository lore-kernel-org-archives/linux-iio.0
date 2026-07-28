Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EA2DCF45;
	Tue, 28 Jul 2026 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229042; cv=none; b=l5NdWYtcyARfeOKoYv6G1sRpphfw3LyQcjMtDVZhJVLshZH9yVj17AIJhpcHZtgwJDflirKzK1jUFRIS8xD+RjJdlBCZiMUob7gRtgTzqYyGbuh+IpNZoJJUuRLG3WpmRFxEq2dfyc8zZly16Uqz//CM/e87b99JR2lJcpKKZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229042; c=relaxed/simple;
	bh=lUhD51bc6FbmG7QU3H2DChRpvP96MhevdBzHdhS/M5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K4EMdcRnNuNBXwuucOT//0vJauoUHaS/fft0t4NT6fQHWLZ2GYsAlNoK17YlL/LEvkPVbVXlwZJl4gmPkqyKKu+Ly+4J/p6HDwLghy9OhOSLBkgi+0HGdnd3in2FTzOcoxF31kINWBIPPAieFNVn2BqZRDuM4RNAB29aj0v4gPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WyV6xFHQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WyV6xFHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785229038;
	bh=lUhD51bc6FbmG7QU3H2DChRpvP96MhevdBzHdhS/M5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WyV6xFHQVO1MkoWRzNERwwuHvdoo1TpMtSmpAgrFCtPK56bPUjBmJLxe+ahdzPKv+
	 xnu6ghGr6T795gabC6orDVpbRy/TeSOCNXvUUyTrl2UlIG/kkao7lF+iBoJ53nUM7Y
	 7wVwyQY4zHuao3vr8Ana9wLGEvhg+CkBZ0eZR/zSN3EPG/y5tkclmr/WMycB/z5s42
	 D3X7CXCJi53cbVfc7g9yPDIlAFWY9ORlBKPREM9yNlRQFTIejqZ0HM+zValwQAOb4s
	 U+Kf1R/q4/HURt7f+RYZeqGd1dvpH/jdzc0qgWQusxfDJgeMmAQCgRTEaJLFN9M79Y
	 yFxnnBbgxzTQQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18BB917E019E;
	Tue, 28 Jul 2026 10:57:18 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
Subject: Re: (subset) [PATCH v5 0/4] AUXADC driver for the MediaTek mt6323
 PMIC
Message-Id: <178522903805.10327.4229525653360897202.b4-ty@b4>
Date: Tue, 28 Jul 2026 10:57:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 09 Jul 2026 13:52:46 +0300, Roman Vivchar wrote:
> This series adds support for the 15-bit AUXADC hardware block found on
> the MediaTek mt6323 PMIC.
> 
> The previous version of the series for all AUXADC, EFUSE and thermal
> drivers was split after Krzysztof's comment [1].
> 
> Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
> mt6323.
> 
> [...]

Applied to v7.2-next/dts32, thanks!

[4/4] ARM: dts: mediatek: mt6323: add AUXADC support
      commit: 6326a6811b1af6674e3eef128df6a3825de26872

Cheers,
Angelo


