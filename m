Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10051473C87;
	Thu, 23 Jul 2026 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807333; cv=none; b=HAhTsjDrqbYC/tcfUkvHPDEkgXQSpqdrdDk+JLtHW+6qcjZYkkauxm0pHp7vipRB+/ZoEzAA04Da9PKyFSmtRX3X4LI2o6jVriolTvsdxNcS4XbTmC0IcZsgvJeg1L8tDKWDDtn9Deh3YmLnJKfkHTvaCI/KsKuYdnUBA7ellpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807333; c=relaxed/simple;
	bh=KKL14ZjOtFHCA/Dm7b2hzIVLIjz+RTKC0uNUJoJ80VI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rh2T63pT0WVscU8PNUCWtyyWh+e4Wu8LwE/zKdBz8OfnDb+9QDU8u0N/F57olqLuHHqKJsf8PKaf92QEipkf31nXrKUMviM1n/Y1f1Rq9DpIxB4SUfmHzJShnRxTDQy0iy64dZqUtDTrsOfn/4o9OFQ+vtQvQNlWq6d0rbVnua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FEC1F000E9;
	Thu, 23 Jul 2026 11:48:36 +0000 (UTC)
From: Lee Jones <lee@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Roman Vivchar <rva333@protonmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
In-Reply-To: <20260709-mt6323-adc-v5-3-d11b8332a735@protonmail.com>
References: <20260709-mt6323-adc-v5-3-d11b8332a735@protonmail.com>
Subject: Re: (subset) [PATCH v5 3/4] mfd: mt6397-core: add mt6323 AUXADC
 support
Message-Id: <178480731596.3380420.12025738982623132782.b4-ty@b4>
Date: Thu, 23 Jul 2026 12:48:35 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 09 Jul 2026 13:52:49 +0300, Roman Vivchar wrote:
> The mt6323 PMIC includes an AUXADC. Register the AUXADC in the mt6323
> devices array to allow the corresponding driver to probe using compatible
> string.

Applied, thanks!

[3/4] mfd: mt6397-core: add mt6323 AUXADC support
      commit: 0e03ecbb17b1249471560227f210c3f98acaee08

--
Lee Jones [李琼斯]

