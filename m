Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348276;
	b=IsIJu2Lt88ZH3y5Uyyc7eQDgcUCPEeQYN6j3q9uJvzUoTBmotgpWRS+KHk7liwnqkhGj
	 2PqkDRgHdzb6YJvHkqtSjy0lEYXsHNbSCD+5uXAOhF5vVrxpsY77zcl7VDVLJb/ZEZdyQ
	 ogwh1uSGiBlFDyQf0GEje3YZi6k2imr2rZZSNxL7evG7mHh4+Q/N/Rb7Yv4Tn0vvLWxOv
	 XO8Z4WLB9dWFCyvvpnozEaKx+C3pm6WnEmtW7fzPV/ryCSdcdTz6TBy24cR5YAfKMJWZR
	 Fzl7sBLU1v8pAFeT/XKSIkWSElSPU31GoyVC/p7SIxKWtsttFdqQcOvP47cF9aGVmsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348276;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+KG1RMx/uhvuJyslhkkILwlui3s8aJ1rFpXKcWZ5CEM=;
	b=D3cSrVIsc61NhquA0E5tCQ8etAsv0hWNxBQts/nLVxLLjMfmqLwTbgCuIsIgjeHP/1W2
	 QWONqptfSNSygKBs+swDtBvaln0qZ0n8P9KCEcFrsGzeUKFn4MuohGe4JguodmybeNjtL
	 40BytDmQO7fLFzhga3FTZKG15pjRrCphJythYYxy3PiaA0t5l+nkD7fBZt2h+r25x8/g6
	 GJy5gT3TdZwFWBZ+a3s76flHtJOeUZGTiYp3aG9cPjH3RVzjvBife1Fpb+etAGt3alZBA
	 comWV7neEYgh8XbjDry+OU6Ki9H2XkMtqyVglUDOPMvx3lR2LAZikDBazZ9I8Xq2G2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE0vZPZ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F31606A31C;
	Fri, 30 Oct 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE0vZPZ3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793348275;
	b=ZnJhAhc3af4DzLcSbBXOnBiCqW7OiE2krlv7OLRMA38P3q/1m9y96qkDJqvdnx3+j8/O
	 PlMHqDjs18RVcMNL/j2uHtXOv4i3CUrFUw6ZFLAi7jKLIRIqAkh0USnHDAgN9dOMbQ4h7
	 pZrUs6zzHuBqAdQrayqXhixe2ddm5cDQp+F7HFEweTv/Su/Mk6JoNQkpxjzpO6Z2MQVhp
	 npYIOQwYQai/IBhmdQPfxCUWy3XEk/PiOLEUndKoLkWGzq1cHR3k4HlYxYcHpNDD8BjD6
	 tCllAc0ikXI1cDvxBwMX6syF4LiPf94LDXHONnHCxetmiaKT62s61pclqISS7B74I5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793348275;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+KG1RMx/uhvuJyslhkkILwlui3s8aJ1rFpXKcWZ5CEM=;
	b=IM4sBb44aCfKT6WVOxgLhJ8CPxOYHTpwi9485bjzDiYPD5/kds5GX1ZyQU9unY1YQB9N
	 ti2r9OlOg0Qz595YUjj1QzERxQZo8ns4AuaHUQUBIKyN5BI+5+CTrGQH4wDOVANBlYICT
	 c/uvGgEVTUyXL2qsnyaeBSwuy/veT3QhLGq5lc8ZntOjdvLGrLsx0iQIyCqye/K1AKvGD
	 XOp0IrOJxUQBu6qNBdf0TBXl6zWtftx1THXlQ4JfPx4ICIBmesoz8oZYY/e37agUAk6df
	 dtaU7lpHPdXw7DWGFKMjp2Hg5JEKAYzFdMxpS768b6oYUv9aSlHxFbQV3HfeqYsJpBA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id EA8981F0093A;
	Fri, 30 Oct 2026 08:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793348275;
	bh=+KG1RMx/uhvuJyslhkkILwlui3s8aJ1rFpXKcWZ5CEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aE0vZPZ3KVL9SaWkop9ib7BlPO9m/Ds2hmkGUBvO1d7YrwCjOT/cjpfvsZok8FR+s
	 MEhPiectiCi2IZcqYJsW+TlGCUcugx8MEevflQiCuidkgV4JIiFhmQGudBEWgwAG3X
	 ohCamD7hqtxlwO4uA1zhiSsZcnj4VzkJwOl68n53RigaU1ZRZ8UaiBVgtY91RMgrju
	 OtQAAfNpcn2m6Gl4NGuploTZGpMnyVzyZAqdIJ5zsJEqzAfhyyw+xKsQehfUNV48MK
	 QD6Y4cglnDuLYy9TxNCSgYeXIL1IS9H2E8zIoGyE+am5pcx8/lsx7Q1IDiGOiOQ7iq
	 rgjtUSCyGY1fg==
Date: Fri, 30 Oct 2026 09:17:37 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley
 <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Paulius
 Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 1/3] iio: pressure: dps310: reject a zero rate or
 oversampling ratio
Message-ID: <20261030091737.00003868@kernel.org>
In-Reply-To: <20261029220635.18816-2-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
	<20261029220635.18816-2-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Fri, 30 Oct 2026 00:06:33 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> The rate and ratio setters accept 0, which also covers 0.5. ilog2(0)
> gives -1, which masked into the register is 128 Hz or the reserved
> precision 0b1111. The latter makes every pressure read fail with
> -ERANGE and temperature read 974 degrees C.
> 
> Reject values below 1.
> 
> Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
> Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
