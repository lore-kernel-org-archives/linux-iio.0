Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697550;
	b=usTxOUptMlnzbgupkK+tJiEPiDU/lDGsLdcyVXm7O3ssX4f09DoZlWEtlvcVm2rTo42N
	 YNTCwk8W0IVKrr2dxc4u2Hw6EmboJwtUDONLdZWldBHBoP2dJQfO/EkSaxLwDSqL4BiIB
	 qBcHsDYKz9j+UxYjfGIossRvB+ynf2/4zgBoBXz4dX6TZDJpZPGUEBPFu11YCUl4j+dzK
	 5NGe52uWa407n0gQdMTbQLoYVQdMW4sLmaxqPO5+sGEgiPii9qOIMfyU43yMXN+zeyMbL
	 Rp453Mn1loD21hcpVVt135I3pX63Toq+JaKcN+NvNDcVkXN2u5vYEdUDyK3Ajrn+x3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697550;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WBGcJXuZqNZSmUGs/S8/zNPIexz8UHDYVmoVkXeUkJ8=;
	b=EI0+n++uLZPjcw2E4MkAqc73hGGKz0EI34P74eiUnFMFzxvejrdyaDuX/UzFM9f8Yb0p
	 JGz0eDCmq7wxmzxCnUU7UimWnI6OTA1xI0OM4B78FP5ow59vWbOJKbdOIT9/x6s2dc7C4
	 dR3W2j/LdYYpaDF20MXBUUy4C+21a+ym9JrT0cMEdR30+8KDJQ2jJEYUll59IOkPLwQPL
	 MY7GN9yCAbiwFBVQUwpVtl+1KOC3IQYkl+F7iMK11sJDI8Vu7fkEj59RCdGB7/JWFFmAz
	 MOlJeAK5lxlqbXyY0sFtDP0Ygwtfx4hjD1c73lDX8gKHPS9jlS4vGk5X+FzRhAyJIfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omH1TqMT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB90606A323;
	Sat, 14 Nov 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omH1TqMT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5121F000C4;
	Sat, 14 Nov 2026 23:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794697549;
	bh=WBGcJXuZqNZSmUGs/S8/zNPIexz8UHDYVmoVkXeUkJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=omH1TqMTW01NQuJLnPV07i9kX17c3Zpz9ShSzQqCn95L+AXSSvRD60QUWfySDld9g
	 mGWrcCTXZePFQZmR5Qliw9UVpZrpHf4yfYu85pSlKHAkSWm1mTJ9P/pkOvE+x9OgMO
	 UuQQ2WOtsSDXmdyoFjqOpnIJTdsNSCJJrgJHWzrHz5+aA8wjGEVspiMKXmpeJmzaoq
	 QUM8evP6t8LTX+1my+YMBR41BGJx08PzNGGMJzkw8jFoveSu73DLr9SCYuNkqhHRuc
	 fQah116e22vdwJfhxCLhII/55QPeNLWeSEbzqoPy6bW24vzROM4UiTvD58lT1h/jgN
	 G2xjwT2F5+9hQ==
Date: Sat, 14 Nov 2026 23:05:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Adi =?UTF-8?B?S2FkdcWhacSH?= <kadusicadi1@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: use __free(kfree) for
 temporary buffers
Message-ID: <20261114230542.7d9cfb38@jic23-hlaptop>
In-Reply-To: <20261108201522.249539-1-kadusicadi1@gmail.com>
References: <20261108201522.249539-1-kadusicadi1@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  8 Nov 2026 21:15:22 +0100
Adi Kadu=C5=A1i=C4=87 <kadusicadi1@gmail.com> wrote:

> Replace manual kfree() calls with the __free(kfree) cleanup attribute.
> No functional change.
>=20
> Signed-off-by: Adi Kadu=C5=A1i=C4=87 <kadusicadi1@gmail.com>
Applied to the testing branch of iio.git

Thanks,

Jonathan
