Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378221;
	b=LGr4757kvj2F2tGz1pg6t4i6IbRf1gYKethXaBqF3zgp2uD2w2fPBls+ltHdD6EBDux+
	 8mgBpESverYsxrGeZNLpOfN/h7pDNcQdp21qEY4YQGQNakNdldLlliA8K8sUix/SxmvuV
	 /5u8KNtf02UbdgF0zyT2pCd55/CkQOp0yy6z8GEmc4yGfp0dWXgBgOtS/4hYWvqZEe5tD
	 cnaR+X4QraW6+j1kDgqZWc4Lo4+OnhANIVcKe6wNekaihAi1NABUAnEYQ/Ck0v0/eGlHk
	 GpYacaDVfgyQAO52rY7wagq1Cv6ZeS8YFZb2MOIgnT6slenr3Y8BCXRHitun0EZmNug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p/DIVTa66C9EyXv+bDRw4I+r3LI//pf5iFITSVESUiQ=;
	b=KdX48Zu/CYGSp2yNjxKvIeqv+XG/TwkwWihtPARjTJdZmi2NzMYKtYZ+DaOJQih323+y
	 q3EzK7gg5+vB41EmNgEnIxJDb5EXCAKiMfmM2k0HEAkw/4K38XGJD07YqNGcL18b6Afum
	 L7PLo1ufv5vIj09f4o4nwHN3bYm4JLa1PC7RaeB4b6nM8uP5j/6kuLZQVbsXshCdh1UBS
	 YNHWRN2jkENdIdcvBp+VOQuXY61gjame7EY8c8OyL2hzzcr03TFkE/BHRa9613IH9cjbR
	 wdy2dno8LwXm+csBTiB+CjjmmPJV67YyhjOQ85AU92PS0lpYDCXnUXrC/pRilicHEPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgY3W9JW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CF606A31D;
	Sun, 22 Nov 2026 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgY3W9JW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444C31F000CF;
	Sun, 22 Nov 2026 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795378220;
	bh=p/DIVTa66C9EyXv+bDRw4I+r3LI//pf5iFITSVESUiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AgY3W9JWR2kR9MawQqY9Fc22e8I23dQzclpV5RwT5z5U9BspMgmIC2YszOSGfmaM9
	 v36O33+0NuMT/ol+QmcZ/Gz5ZDPtJY2iGv7GGgnTpM8v3Lhu2sdsMHxlq3+5JHLiXi
	 ae2jWYgwLkEw2TBCzqEdelDAuoz8kTTT4z3Gh0XqheFv0tuu7NhVt+caseTTSMXbK3
	 9NcPsmE5ZqNujPeJ4MWKFrUfGKlN0xUlfQOUjdGaKJXixWKfn4ArewH5hFkXEwgKnp
	 f9lchF8XFhK+H8uYpLTNW92tTTutWh1V99xTUpzGmzWuEQhOKqDXNpUkVZ+6WUKcXB
	 wH0BQwekiBydA==
Date: Sun, 22 Nov 2026 20:10:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 mfd@lists.linux.dev
Subject: Re: [PATCH v2 2/4] mfd: max8907: Add ADC client support
Message-ID: <20261122201016.02be0ecc@jic23-hlaptop>
In-Reply-To: <20261115091120.108684-3-clamor95@gmail.com>
References: <20261115091120.108684-1-clamor95@gmail.com>
	<20261115091120.108684-3-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Nov 2026 11:11:18 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The Maxim MAX8907 has an 8-channel ADC at a fixed location. Add client
> support for it along with its regmap and interrupts.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
It is a bit of a shame the coupling between MFD and ADC drives
is made via those registers having to be visible in both, but I don't
see a clean way around it so:

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


