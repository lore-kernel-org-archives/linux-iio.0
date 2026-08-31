Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE025B08A;
	Mon, 31 Aug 2026 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788141548; cv=none; b=GOAqb/8L1PNZOx4GDsjNco75pp2oLK0yZTdL91/I4TUGMxZerpqlDrcsLd9rAGGM+yiaKRnu5/4GLWqIOfnz5SSeDeyLCWigeF4m4LTCXXGl9riPd1wunrCxs/QweQ4ZSNaUWMGA540ukjdDFmujU+j2oan9oLMJvqV36si5Nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788141548; c=relaxed/simple;
	bh=uozkgvrdN0D9EPdSWIVOtZ7HdTq7rRHBLuseFuqXQ18=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=L72XvCcXfl7KgWSX0T82ZghLgModNDa3u990Q//tzlhZqWgyulPVtZBuZk7D4UZwO9SmHrNjj+CpQ7Lz8l/1K9ZFKSeLQmiINBxWUAFfs29DsJHwKMT6FDOuWW1dgC0kY7Tay0kRt8SD5tp8cW2ZIds0YgvqonW6k9XU/ShUqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/400IRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/400IRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFE51F000E9;
	Mon, 31 Aug 2026 01:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788141547;
	bh=YxGOObEGJAf11f6697dsNOxKmUH2WgXWkRucmQWqZu4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=J/400IRq8B2aPDLPy0OtK2bvM0HD0dG7uuD5fyY1SlTW5OkVKcoeWFAMmZ/2Zlhd7
	 yC4RG3oCGdw8ipwk0konOlsydDhY99AgT8sPu7+Cte3uOoso10Yb4+paxZ/ccn1Cuq
	 8+rh+N6lYM6N49uDdcOGAlQYpaKO5wqPDrjFj3iEt1mQWcJ2CjDWP01YPsYtjkN5L1
	 p0j8glA51tNnbGEyVEqiD/Ay6GUkXeor4sqVW8/p/daFcrMJuy0To7AGXdbtvp3h5l
	 VG+V5kasXUdHBxDI7uG9gYsjAj+elj1X02Z0b+O7QjoDXX6KLfHnXh8GGG1pwQt6tQ
	 XDW3c9zbjaVcA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
From: Jonathan Cameron <jic23@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260824-ti-ads112c04-driver-v7-2-6b3c9c87d0e4@gmail.com>
References: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
 <20260824-ti-ads112c04-driver-v7-2-6b3c9c87d0e4@gmail.com>
Date: Mon, 31 Aug 2026 02:58:51 +0100
Message-Id: <178814153149.2788519.11652993309311337943.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=uozkgvrdN0D9EPdSWIVOtZ7HdTq7rRHBLuseFuqXQ18=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlN/dv1gbvHydGRwccszWFhkslC5sl4B3+1oxK
 XDQhtYZp6+JAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapTf3REcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiGnID/0dr0OZGPfbMkXRAePR0EJRG+Yt8RAAENhggVZYOmvTe+/
 Ggvw7k4RcWGFqjNoPuGY1ia6MSo6RAnVLGkFJIhXKFQCsep69FnP4dpXGHAB9r0810h4PnXOj++
 CRmdujhoZj/6mfC0eeyDKQjn0usysZPndyeTrEWdZlRZn9bpxkLdoTAwFhkWHjoV8LBWP8fFLJs
 WYugK4UJs48Ae2z8mhKZlYxy9gGO8+4sxyyJMwyKCxloreELQ69qaynjhRYti7Qkvq/7xaUUar2
 DI/s86PGhB3HrtK3/kOEsHRmEjkk1UzFJXaom7fg+Ny2tMyA230aoPHKRItCQnv/zReNTH4b/I4
 TW2j6cv9mt65+/E766twvrUkux8+qtXyBTSNNT5UJX0i+uanZhObBLuGwMAtOGYIwR/TOeys5Yq
 KoZQWAxoN/Hfyz6ptqjZRRrmQIN8zOk6dY5LgpKelSNsF9uqkaOIU76adyK1QaUwPYnEZJAL+eQ
 Cpsl9hue7/VbkX3lk7HzxAfXPG8FJT/dp5o8yXTE+Urlt5YDsaOyjttXRml1m2l0mL4ZZkrin8d
 n7Mtp0ZsMvSlX/kfbOCq+Y1zt5YGTb2DuiT9FF4fy7lnCeWZWswjtMCPowWEcAsExf1NV7WpX+/
 LkvrIiLU9g0v3WlcP2k91qy7pDnUQv+yVL4m4Tg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 
> The driver implements:
> - Single-shot conversions using the IIO raw read interface.
> - Dynamic parsing of single-ended and differential channels from
>   device tree child nodes.
> - Hardware interrupt support via the DRDY pin, falling back to
>   software polling if no IRQ is provided.
> - Per-channel reference source selection (internal 2.048V, external
>   REFP/REFN, or AVDD) via the reference-sources device tree property.
>   refn-supply is not yet supported.
> - Hardware reset via the reset controller framework, falling back to
>   the RESET command when no reset controller is present.
Sashiko pointed out that the reset controller interface doesn't
guarantee what state a reset is in when request succeeds. For
GPIO was are actually fine, but in previous discussions on this we
have decided to go with the rule of the reset subsystem not a specific
implementation - even when we know that one is fine.

Maybe consider a follow up patch to add an explicit reset_assert()

Anyhow that's a minor thing and I didn't find anything else.

For Andy's ndelay - it's not a fast path so I'm fine with fsleep.
If you want to change that, send a follow up on top.

Applied to the testing branch of iio.git. I just rebased that on
rc1 so it will go out as togreg sometime in the next few days.

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
