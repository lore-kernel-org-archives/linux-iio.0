Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784A36403C;
	Sat,  1 Aug 2026 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548851; cv=none; b=X4i8KUK/aI63vks76s0E+irCZdsooneeeFrqlr3pToBUWo9+aG+NptwyvAWkt62JT9KkYOHLzrtNGJ23jC6JWAI4QBUbGaNuje/AsUNKAPidZbnU+qOOVd0oHz7Qj22ljsSPFgPb7t8Fks0Em1GgHJ71nYk7Au2jLmNlo3gTFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548851; c=relaxed/simple;
	bh=qWFvE2kqHO7nLEOqo7ErpfN5x6O11pCAKML9BtLqo2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7Et4NyuoRsRBzT0Yn1Rkxp+2lIQRYPYIUc+ubHOgwegeNAqJC3rqgYbOb+X80eS0cW8ag5aYM7Sd1Wr40ibiIFJ/bJHCKjxgRl57ir3il/64FsGwP6XRrVBa4n7xo+m26TSRDe/nbP2PDjX0SyEmVrfcLRP6paHE+PDawyYM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYupQP0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYupQP0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1195E1F00AC4;
	Sat,  1 Aug 2026 01:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548850;
	bh=Y5/DgHWzgyv2kjaa1GD0QGQycWnzAImCZYiIRr8RIZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nYupQP0ScXM7Ijs0FFCFdkLCppe7/z1nWjr5g47TwBcD4pMjhYPEZhkWtxRv9g4QF
	 rclTw3DO50ztc0K4X4vJp3++xjinmmj9DBZ89dYwmrOz9hqMBvJBsop8mJyHfLNSCB
	 GXQgHg3K18AwfhEOhmt48YmIjEvW7pRwFxPBqraxpOMxfY6j1+Dt1hu1+FPKX0VBUH
	 609sNbz2+si7it4Ys8pK8zECODouVM5fp4twQOfK2QibrohagHR2VgUgn/WiHdtqHt
	 i8ZibRjGi4Gpo/4iEwKc1mjGmAFem+3mnzzyw/+kAR6ZTPcRBgxzPLHbSbMjz6WfAb
	 mZNyFvL5y+dXg==
Date: Sat, 1 Aug 2026 02:47:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: adc: ti-ads112c14: buffered read support
Message-ID: <20260801024727.086bd896@jic23-huawei>
In-Reply-To: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
References: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 09:09:49 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> This is the next phase of ti-ads112c14 support after [1].
> 
> Some design decision notes:
> * This just includes support for software triggers using the single-shot
>   mode for now. We will follow up later with DRDY interrupt support and
>   a new trigger to allow using the continuous mode.
> * We wanted to enable CRC checking for data integrity, so it is just
>   always enabled. This way, the buffer layout is always the same. I
>   don't think we have an existing control for toggling CRC checking
>   anyway.
> 
> [1]: https://lore.kernel.org/linux-iio/20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com/
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Applied to the testing branch of iio.git.

Thanks

Jonathan
