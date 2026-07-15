Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAC3B840B;
	Wed, 15 Jul 2026 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143297; cv=none; b=poBP2sOG7p0V7JR8++GHrMtt10AbHC6mwIT/VZRQzp3jCDJ8BNkmTOIXDkUsQVU95k1sBzfkO0STPfM7uZyHtoLG5KGwEoz9Zayol5YMblSIpyl4GySmzQtZ9dVBgi+cRrFfj6dbw+AZ6D8hUttYnnf91WHzAQXCcgY3GXIbDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143297; c=relaxed/simple;
	bh=GRvBsyOxjoM7JpMGphXVWqRw3nmtRnJk0afh/8PqTyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Afjc9sJf0vncgHE7LYCjrPdYwc/qMyOVGcMyf/ZA95POv1xOcG4lnrGqRSRMe70y7ngQpfj+fglumAyEvJ58Ffofso5MIdrrgxoKgdXJu4f5SOhK95FKDb5xrS3No9glyNeHl8kAhh6pcmHEumk5NqXSclYVn0TPUElVE9iH55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=R3tAvy2Z; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="R3tAvy2Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=GRvBsyOxjoM7JpMGphXVWqRw3nmtRnJk0afh/8PqTyE=; b=R3tAvy2Zn6mL2TjWKqMx87QUY8
	W3uAEocfkN9IncKeWxVb1X5xtGBhECmRmknAmm2aaXXnvzmICIDGQLo+FBtnB0sfWqkDIhCiTw2lk
	i19Ee3OnmHPgOreZkMCcgvB6Gfq0Bld7FniZ4W0adpUT0NFuPg0vk2SKEHvTvD+izXtVKJ4dpizU+
	f5pMu9pcOkgJq5h9hhrydpOhx/0Cl19MR1XL8yYNTbFkn00TX7DaTcnm8pDIMzah2XbTsRj8dr4rw
	lf6x4j8DaoPpOnlKmLqy/FdKiMr2RplpduZ8dJaty51uRIsBOcqbyXk11FZE/jJFUWtwOkf1/7Cx8
	B7NU7cmA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>, Simon Glass <sjg@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible
Date: Wed, 15 Jul 2026 21:21:17 +0200
Message-ID: <5684233.Sb9uPGUboI@phil>
In-Reply-To:
 <20260714131631.v2.1.0b846080833e4b836793c43fc26d1c6d817cf9b4@changeid>
References:
 <20260714131631.v2.1.0b846080833e4b836793c43fc26d1c6d817cf9b4@changeid>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 14. Juli 2026, 21:16:32 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Simon Glass:
> Add the compatible for the SARADC of the Rockchip RV1106, which is
> compatible with the RK3588 variant.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




