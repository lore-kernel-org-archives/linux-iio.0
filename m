Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2E411F8B;
	Tue,  1 Sep 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278535; cv=none; b=Poxu2phRcizofFIIGmeuN7XVt/0TZXxLVJ02+2WBoAfaD4jgRMI0/80Hw2OupFs21AsKbHy++VyxBTvmrYgoKWcUYype0kp+U+gVB/U06W5u54ymi/Xmp6lbTNJksLBGMgsh+xYdynIhvTxs3eQ6gZKsyt+LzucpVTyXXvSYwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278535; c=relaxed/simple;
	bh=JhAPST/cckRAjXOdBldIuZ+AZFL/30Ad+cB7AwNGac8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxkal1UVeTCIHPsi9VZIgdEAn0T5zg8NFz22r/n1jH92e1f9xk0gf9hsHIGDPgWj4IH7PsT3qzDh5rDkA0etYMIvBGn9S+ToDfno2e+I1lcy5kk4TKAzf86AmipwvvZGQiYC3y71jgIfjmskh8FtbZiIk1raoHycK9nF/RplbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGkhTtd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGkhTtd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A491F000E9;
	Tue,  1 Sep 2026 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788278534;
	bh=X6i1+tjyp+oVQMmqqICtbcN0wOo9ajhUjvRdABVFzhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bGkhTtd6njwOW4h5K0rY0/sqpVYOTA6wPuW6NJjix+aBJjiqpq8R4eLdZ0XsX8WgE
	 N+h/g5Af/mcTNtEMqJ48VgsckXYUge6JM+ZQVTH7CwOnGxKWld5j3oKEDMYQ684OF4
	 7sSVjXyRydpCd8qEXbGUs+SspyC7+dsihS0kaGhelb212IxBTSuJ4aDyiYs6ebiY4d
	 6OXEcxyJeMBWAxKVhrKTSkIq3TIoUQikPgROTJsbD1GSbN3fFhHQ0o4ALpd4An+6qW
	 Sarx/zQdUY6Q2TXLHWPKeQW/WWIhgvil9tQygpnANA6xm/IcY1JH/zifwRogYpJhxV
	 FDN1c2D6uMwHQ==
Date: Tue, 1 Sep 2026 17:02:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: vcnl4000: use sysfs_emit() for
 near_level
Message-ID: <20260901170209.3e5f4937@jic23-huawei>
In-Reply-To: <20260831111243.00001714@gmail.com>
References: <20260830185345.2209268-1-donggeunyoo.kernel@gmail.com>
	<20260831111243.00001714@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 11:12:43 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 31 Aug 2026 03:53:45 +0900
> Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:
> 
> > Use sysfs_emit() instead of sprintf() for writing to the sysfs
> > output buffer. sysfs_emit() is aware of the buffer's PAGE_SIZE
> > limit and is the preferred helper for sysfs callbacks.
> > 
> > Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> > ---  
> 
> Seems fine.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

Applied. Forgot to say the other day (or update patchwork).

J
