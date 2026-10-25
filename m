Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968271;
	b=W9POF8KypGkfAz/Sf9g8wJ8BnGZd6V68nTbQdJXmKcK5yDYrqdDoU5vmE2aAsDLOKApw
	 5CMY1W5N4gz4RwIjjW3ZAdv2semJdZVOY9uwv+18NnRoSCXZp2hV1RHB5rd/FKPsUK4Vm
	 ko336r9QoGesQzug9xaHRCAcAVnRvyVwhwQEPq6SFVz/dxFpdcU4fr33hhRCwwVD7Q4Yb
	 Y4rxPEQMSxspiSB5BexaYohOoMxiua9wUHNRmttaxEi2RxkDYbMHZ2T/CNUmu3N0equ8J
	 8ZExZlSanIvGQV80HqPoZZ4Z0bjj15uuntpKu1bAfSNpzRN+kIfcwGIaDmj+UzSiH5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968271;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AYZMbGj7oht89My8sN94ja1hxWH99fDkLAWp50IGFJo=;
	b=sVvaIB8X2BqBtokJ73eIU+TdofqP552VrKiYfRgV20tmUt9xz5rcA2IpqTYDiZFZARBB
	 wt2QhAiUJTgKBWf0wvhykm21NUuUk1kvCs7ZANwp52DVgYqYCogpyoLej8yK3jwVc6xae
	 5gBjeLgBX4OKdLhWHHcxh2p084nEg0njcFI1cXi8zNlioCrk+/zZiibMeO0pp94wnyQ/U
	 fsjoG4AmJV00SUH73zTQOFkLr+v1ooLcWrhKxtZFo+yQV0So1xnw+Mzu3YDiaucB3mDTM
	 HUMUnXbhijimPF/ddCe8yfPq8PjwCWAWDyHibaGWDDD23/ljlM6Fkrp/m1Ku4Qu2dzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbzkOfk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821F606A31A;
	Sun, 25 Oct 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbzkOfk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03D91F01825;
	Sun, 25 Oct 2026 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968270;
	bh=AYZMbGj7oht89My8sN94ja1hxWH99fDkLAWp50IGFJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QbzkOfk0XPYKteukRUGvuLPQYRS4mq7rMHUgD77pb2OiFDr2Q1PMmb2d0hQGZjnkW
	 jjW4nFKcGkFnUQOUc9ODSiwMAGYlX+FyGFbruw9Q9h2esLYajcQ0q+rs9LR3SWpOIz
	 22Upn+oRQMrP/uWAUQmgVozXGGNJLExk4puWIAY4JqwrVFujFX43vrQiAy5rIYBZT7
	 FqB8W6Q0RVLCUpGcOi6Q+PwC+ACC9O50tQha+HYdPWCU48M/tSdCLyXflBdPpLHp7/
	 /A93MTZbp532wVURITqVSA76dA0npntH6/l+iOGNZlNTUrujL+GU53Ue+Vi/4lGeib
	 rlXCbYR04VNqw==
Date: Sun, 25 Oct 2026 22:44:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Roman
 Vivchar <rva333@protonmail.com>, Luca Leonardo Scorcia
 <l.scorcia@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/2] iio: adc: add mt6397 PMIC AUXADC support
Message-ID: <20261025224421.551f3a7b@jic23-hlaptop>
In-Reply-To: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
References: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
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

On Sun, 25 Oct 2026 00:18:07 -0500
Ryan Brue <ryanbrue.dev@gmail.com> wrote:

> The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
> reach. On boards built around it that ADC is the only path to the battery:
> the SoC's AUXADC is wired to board thermistors, and the charger ICs these
> boards use have no ADC at all, so without it there is no pack voltage and
> no state of charge.
Applied to the testing branch of iio.git. I'll be rebasing that on rc1
once available. At that point I'll push out as togreg which gets picked up
by linux-next.

Thanks,

Jonathan
