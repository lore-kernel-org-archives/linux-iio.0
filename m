Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4F477E27;
	Wed,  1 Apr 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060187; cv=none; b=aXD0N20/XFzUp3eNlhz/CsjZ8AUpL/p6X3jG6HdOO8wN57EL9+P+Gfh+w5XzBvVlfXE2YXP+1dL3fgexbXuxOq93+Et+PeNPl7d45BBd8q9MUyCupfS37k7PCevnYIb6KReL6wUBUgMuGGC3OJ5tUZ3UXIGLGYQQfc5TVEYfa3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060187; c=relaxed/simple;
	bh=2/P2cD9d325/MESL80iZutOvtnDXehmUR+glzRoQv2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hl8JJj+RCZuWwzVGiCmfi7VHZY/s5QU0OnkBVn5lG0Sw3rkQbwIUaLY65L0EZD8wqDeqZfMlhfsDUf+DCinixwFdaCmSX6LQNHZ+b6joZBuTyjUUvGKejAqJSeMMT4FttI0ZfWsDRcCRxkuxXOiwx/HRXqYaE+2Sb5TI7beKAAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=oN61nYm9; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="oN61nYm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1775060175;
	bh=2/P2cD9d325/MESL80iZutOvtnDXehmUR+glzRoQv2g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oN61nYm9QgrsC3tlGIpXeKh0Zh+E9IcIAOwgChu0K28e5C19+AIVyW8Wn0DOut4Bi
	 mSyU05Do6UCJdA0AbWDehW6sMvcWd7oBREHwtQl1FGP9GxtV6Wed3Z+0/9FVD5hyZM
	 w2QWzM8ZzGdqVikbIlQymdfJd+tsj5RR+SIItJyc=
Message-ID: <5fcda84716176de70b6ff968458ee4e4101b36ad.camel@crapouillou.net>
Subject: Re: [PATCH] iio: buffer: Fix DMA fence leak in
 iio_buffer_enqueue_dmabuf()
From: Paul Cercueil <paul@crapouillou.net>
To: =?ISO-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Nuss <jamesnuss@nanometrics.ca>
Date: Wed, 01 Apr 2026 18:16:10 +0200
In-Reply-To: <20260401-iio-dma-fence-v1-1-40993adbfa96@bootlin.com>
References: <20260401-iio-dma-fence-v1-1-40993adbfa96@bootlin.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Beno=C3=AEt,

Le mercredi 01 avril 2026 =C3=A0 17:24 +0200, Beno=C3=AEt Monin a =C3=A9cri=
t=C2=A0:
> iio_buffer_enqueue_dmabuf() allocates a struct iio_dma_fence (104
> bytes,
> kmalloc-128) via kmalloc_obj()+dma_fence_init(), which sets the
> initial
> kref to 1.=C2=A0 It then calls dma_resv_add_fence() which takes a second
> reference (kref=3D2), and stores a raw pointer in block->fence.
>=20
> On the success path the function returns without calling
> dma_fence_put()
> to release the initial reference, so every buffer enqueue permanently
> leaks one kmalloc-128 allocation.
>=20
> The iio_buffer_cleanup() work item only releases the temporary
> reference
> taken during completion signalling by
> iio_buffer_signal_dmabuf_done();
> the initial reference from dma_fence_init() is never released.
>=20
> With four iio_rwdev instances at 240kHz and 512 samples per buffer,
> this produces ~1875 kmalloc-128 allocations per second matching the
> observed slab growth exactly. A test with ftrace confirmed that the
> dma_fence_destroy event was never triggered.
>=20
> Fix by calling dma_fence_put() after dma_resv_add_fence(),
> transferring
> ownership of the fence to the DMA reservation object. The DMA fence
> then
> gets properly discarded after being signalled.
>=20
> Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface
> infrastructure")
> Originally-by: James Nuss <jamesnuss@nanometrics.ca>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

I had a look at the code and indeed, it looks like it's not releasing
the dma_fence properly. The fix makes sense.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul Cercueil

> ---
> =C2=A0drivers/iio/industrialio-buffer.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c
> b/drivers/iio/industrialio-buffer.c
> index 46f36a6ed271..5c3df993bea2 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1909,6 +1909,7 @@ static int iio_buffer_enqueue_dmabuf(struct
> iio_dev_buffer_pair *ib,
> =C2=A0
> =C2=A0	dma_resv_add_fence(dmabuf->resv, &fence->base,
> =C2=A0			=C2=A0=C2=A0 dma_to_ram ? DMA_RESV_USAGE_WRITE :
> DMA_RESV_USAGE_READ);
> +	dma_fence_put(&fence->base);
> =C2=A0	dma_resv_unlock(dmabuf->resv);
> =C2=A0
> =C2=A0	cookie =3D dma_fence_begin_signalling();
>=20
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20260401-iio-dma-fence-5f1ceba11ef5
>=20
> Best regards,
> --=C2=A0=20
> Beno=C3=AEt Monin, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
