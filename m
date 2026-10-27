Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793101597;
	b=YDKb9T/xkJNktxNDA+3O1jBcj18+ovmfi9IYyotzQwhl0Qs5vt2nMQlyZG1U/RXywoq0
	 DFI7fKQWrjcBIgE6tNaPtP+IxYdl9IzvYFaOGgrGHRODRqUEic/HkA6ndYa6EUO0S23T9
	 7orC9NNhg2SgV9SFGARVGF3nG4Y1VPRPxvb5aXl3PV1GO4ubvwFDJLQJ29ROoJ21VuHur
	 2JF5XMzoycnj8spcPSjuiSu2zRLgdQHlFOp1bxYVlvdRBHV5i97+zNE1GVGcQ+D733JXy
	 8IJxbKzz0IPggvNXq8dKrgE29HeC6K9dFVpuGfyk0P8PDL1InktNdkuDtaM7h+rhSNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101597;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=d8vhZeO0xZvUlbqrddDtDmPv9Oi0ovGuZ6eCT2B3uh0=;
	b=lslqMtabUe/SD/afJb4P1i79KLla7nmQZsirhU3LtHFohrARxoTmXqhurHgCR2z3a03j
	 wT2/XPL+iTJohF9vpKReu+UX9L6Zx/TEHWMFMhG9Tsw76TLKdiXGjqTwl8ZE+6f64Iwpd
	 AxBB3VXaYh03YNcGuYw1seO4E74956lbXyaLd4UHq2fAXHLVb5swp6Q86ubF1SEgMRpGK
	 tnvUhIf+6/q70jd07fm96qmYuCUSmGhTZXFcMmz72h9ms0NlaWK2Ch64phUIR717H7dlS
	 fF4mXT6xJXLVUGyCOIvGb8+KFJtKY22vHMJen9wbFGuTYWgjxRGcCDuw6bpFdc7qMdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVA2xktn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63050606A7DC
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVA2xktn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793101596;
	b=WUaExG6clxmUNiZNbYWA54VxsFPbeM0oOVQM3X5k7c9yfg0vZiIymIyrMwqvAeSmm1ZQ
	 tY7+2EbDbRifPuHFaMFZwbMloINgDYXvjMoEWHkXW9b1+aX9qnTtK33w2osgRRaUa9SD/
	 w2LRfiAjaPjBonnxasxOpjCOJTFWb7HZfvK/6eJKCqeXHHXWOLgjTQbNrjJBQwqIncc6w
	 RZklBoTWnOYT0FfXPKWqzt2vU18+vREzwwX0D3h9GlzuFtbQDCRkzM5uIZqBsJ8ZmE6m8
	 eicEko3Ay9eh5LGaPAk9zBewtu/W/NcIqeKvZUDYp5ntC9Ox7skB9R3GgM8JeTbPmJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793101596;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=d8vhZeO0xZvUlbqrddDtDmPv9Oi0ovGuZ6eCT2B3uh0=;
	b=nlHd6EnrI3AjN/7gdsR4JFfCiAe+CIe71A2MvUf1m1pc7s84cdTHIxVKwxCVWatPTd11
	 1Kvc4SUarWoLj2MuAK7J7aYiyZ/gcVQJeBqztKrOcOGVtV/tnhBh+0PjLkRDy+VhrihZR
	 iEN8vMAexMEqzjKfABJqtKc3k+h/6EMr1EhASa/XDC6x5T807INiyeuqQFhqp2kE1AVjN
	 z+JhscsxoRZ+wZV1jCtIOZuLaX694sYi+h+TKmBQIPn6OTaf+p0qaIaYg0gxvFF0S0dO7
	 q9hbBaQTvwHr9PilY+eQme4OEbBNNtGjdAD5jLn1Ri25AipdRjj5o+j4zXwSn1xGUXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 17E451F01184;
	Tue, 27 Oct 2026 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793101596;
	bh=d8vhZeO0xZvUlbqrddDtDmPv9Oi0ovGuZ6eCT2B3uh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lVA2xktnAreMlQTbPVlIw8PK0oFpbzo0QvtEwt1yBoc9diSW3D32hp9XjC9tRysfE
	 Q11AwlHnS9+QBtYN03wT9d2wPKsiuR8/mgqN0nw07IhGqjfAIO1AqkhEm/0Nf/P1Cb
	 gL1YDDBPAZy+nsXDBu2g/2aXzSWiNNa8qa9OoBdhc0BQRTpJoBB35xs26iIQnASnVd
	 9xu8SZ1+y6e7XitAZkd+GaKHbN7AkoGPwIwiPxk60b6ZAyIrdmWA5yJhPY8Fb5Hwiv
	 QActyP9OKwD9TscegSjGflQdRkQ+MsugNSbK+A03SX6SICzOZ+xNBF+llXbaJeU56c
	 t7ana4Gg1wbJQ==
Date: Tue, 27 Oct 2026 12:46:29 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH 32/39] iio: adc: ad7887: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261027124629.00000fee@kernel.org>
In-Reply-To: <auB7zg8H8bMGchzw@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-32-8b136778eedf@oss.qualcomm.com>
	<auB7zg8H8bMGchzw@ashevche-desk.local>
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

On Tue, 27 Oct 2026 12:24:14 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:50PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> > which is a structure within the iio_priv() data.
> > 
> > Replace the data buffer with one declared via
> > IIO_DECLARE_DMA_BUFFER_WITH_TS(), for 2 __be16 channels.
> > 
> > Use be16_to_cpu() to replace the opencoded equivalent.  
> 
> ...
> 
> > Otherwise I might just rip out the pdata path in the near future.
> > This patch being an example of how it is causing maintenance burden.  
> 
> I don't see users in the kernel, I think we may just drop it for good.
> If anybody wants that, they can use software nodes in the future, no
> revert will even be considered.
> 
> ...
> 
> > -	return (st->data[(ch * 2)] << 8) | st->data[(ch * 2) + 1];
> > +	return be16_to_cpu(st->data[ch]);  
> 
> Add asm/byteorder.h into include block. And yes, the include block is a mess
> in this driver.
> 

I will probably do a series removing kernel.h from a subset of drivers
in IIO again (it's really painful though).

-- 
Kind regards,
Joshua Crofts
