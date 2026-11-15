Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704533;
	b=aXMZyZH7ybpXKcngjvlyAU3C7uR33pDEnpQnIh4itPaIfrKZYYbeekS13c1Ny9vbxnLu
	 EU4G7Wc2Jgr6I6w0JT4Sj+OpMlruez4ny5cSsPfvE5OhVXe+NYsdDte05u0YISV1vjM09
	 6Jk7DA2OUN8ujz9cXbHLqh79GvLENt3bHhM3gJifi1JRGG/lG8sti7QC3YdoE6mrzuoXU
	 raACBoIgXQtuj/FxClO2jxyJXK4Er/5oqeO51DFd8xc8y9r1+KzUSVXpCd+lRgq/XpxZm
	 pOeGzsMliSxdq1es+/djTYn4VQDWlovAvFGkmLuZO+Q64sON6saPJfY39ReSqFa6rdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704533;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=etWFYi5rHjM4zE+rq0ccelK/W5emNS5ctdYs0StSj0w=;
	b=Osy3gSd3O5XsTa/FZK+cjTlcFqpRxDcq94RxL9RykX+aMxyQbZcb0pS/XpJtxenjdQFn
	 aQglP+AOx4U5AbOoeK6vm0jiL5ba76nC+HYu8otRf/Rk7aDsY2JH3KQ79j+m5/ZjOmWHW
	 YyKcw2KKWJ3FtY/n8Mn3injDtH7qsQElWVGlD/tmoDDExWly6mW5tMH+thpenymmEm4xh
	 hZpqC3whWuNo709Vk7ahOc3Rygldu3+em2I+qA0cYIYYbfPK9i06/VdxUrpY1XlqwHzhZ
	 m0L50jAxKAI9G4xL8CI+i79DaoPTUP2Iy2Gd1yR5cxKRMqvUgUa02LSIGxpdHGuholQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtBQkECr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631B606A323;
	Sun, 15 Nov 2026 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtBQkECr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E491F000C5;
	Sun, 15 Nov 2026 01:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704532;
	bh=etWFYi5rHjM4zE+rq0ccelK/W5emNS5ctdYs0StSj0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VtBQkECrDoQPAA3cegzRbaeMxIo5f1ZHwwQpoUnwiIY8rmvnxJwVwNVuk0UHB4E1H
	 pyZmB2nLDPO2AISB0T2fv2+58AAEJgghS4XM8dJzMRbadNWnfmeAkNYsvxNWxJmu/Q
	 H3khWtAT0sCopUgZmbodl3xC4vLw/uJuI9VzMbqPUvjzsh7oKvYNDtABy/QJ5FqOLO
	 xi1dV7uyXMBPcF01WdGSRfLNg8XlSuns9n8whmfdV3mL4oZ9pdiPMWBO2O/L38FMiM
	 6mWIM0bh3SuBLqszenBxi+xDKkEio0GpgjX2Zsxim0hsGetvwL0RlHIZ6IrMcYtYoK
	 UomRtSuUYTScA==
Date: Sun, 15 Nov 2026 01:02:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Arnav
 Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: don't wait for new
 temperature in trigger handler
Message-ID: <20261115010203.2a939bd6@jic23-hlaptop>
In-Reply-To: <20261114083525.11972-1-zoone.rupert@gmail.com>
References: <20261113230241.82046-1-zoone.rupert@gmail.com>
	<20261114013817.476f8fb9@jic23-hlaptop>
	<20261114083525.11972-1-zoone.rupert@gmail.com>
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

On Sat, 14 Nov 2026 10:35:25 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Sat, 14 Nov 2026 01:38:17 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > > Read pressure first and take the latest temperature, as a direct
> > > pressure read already does. Wait for temperature only when pressure is
> > > not in the scan. Read a temperature in probe, so there is a latest one
> > > from the first scan on.  
> >
> > That was potentially a while back.  Why not do it in preenable for the buffer?
> > Will make the buffer start a bit slow but should 'work' from there on.  
> 
> Probe value only lasts until the next temperature result. By the
> time the buffer starts TMP_RDY is set, so first scan takes a new
> temperature anyway (checked on the board, buffer enabled 5 s after
> probe). The probe read also covers direct pressure reads.
I'm a bit lost.  So how stale can it be in the direct pressure read case?

Sounds like the buffer one is fine.

J
> 
> Happy to move it to preenable if you prefer.
> 
> Thanks,
> Rupesh

