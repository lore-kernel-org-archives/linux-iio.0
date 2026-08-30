Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76F25B0B6
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788049395; cv=none; b=PGyQ4DFJn+4mqO7KnbH4d4Pj/9PmwhVC6BtOcJwzjR1deLRXT6tBR/jbWwFGy8pWORUzwSVdIaAXaRjOB4vVDYnqXWUzXWIel/zGjuP7zcIpDfCPwKIcEEECG4ptYpkK8uklg+KozC+iyBRrQhnFhpQbyfSXUtd2c8H/udhMNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788049395; c=relaxed/simple;
	bh=WjASU/gb+xBNmeCTpyeHBIPq+XkLEagKfVbA8vXOHo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Usuw9maVwDoYQHGxQFdLO9NKjZr1veyPaxEWaxeghkH4jO+7YCx7/cD5yLC4q08+qHPYxchkFpGe2ILsCvRUexqtdM1YtcHdJTZBWpvyyy9PXBHBpj6hSIY1JO3Rgn5NfU3AxIIkdoT9wjrRv7WWNl/z11Jkmns1/rIJSnKr0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYDzPh7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYDzPh7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF531F000E9;
	Sun, 30 Aug 2026 00:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788049394;
	bh=H2cI4YQQoQZQiuRfbvm365kqgUOBpjNRDTv41OlHTRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dYDzPh7+lVKEPVJsXHrC+IHIvIafnddnYCjvT4dGmSFDpCDYyqgJKgBLIrHkIWDMX
	 YlBH9Znhvu3IbAnE0EhwOkVtT//oNnh/Aa3MwlupaF9y+A1Lvbp6iXgjufiOnBufMg
	 t6Uqo+SxGbgUkGVxaY5pax7UQPWmvMUyRTBTmXJ70U2bHj0wo2Uh8nA/EGP/pGY7/+
	 nLjuZK2K1r0WYK24jcuCkWJCMp0YYCtGWEgHKvhWMb9EYmtajRO/LDyfzBzQT1M+02
	 G2sGNCAyQgGdCwkAm5VkPW8t8GYPtJSnsmOuON3J+PENm65f/cT4f5oJEanQ5dkZL4
	 2yRZHSkoWhfiw==
Date: Sun, 30 Aug 2026 01:23:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/2] iio: buffer-dmaengine: fix sg entry iteration
 when building dma_vecs
Message-ID: <20260830012310.0a6930bf@jic23-huawei>
In-Reply-To: <20260828-iio-buffer-dmabuf-iommu-fic-v2-1-b4dd71827621@analog.com>
References: <20260828-iio-buffer-dmabuf-iommu-fic-v2-0-b4dd71827621@analog.com>
	<20260828-iio-buffer-dmabuf-iommu-fic-v2-1-b4dd71827621@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Aug 2026 11:46:55 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> iio_dmaengine_buffer_submit_block() counts scatterlist entries with
> sg_nents_for_len(), which walks the CPU-side lengths (sg->length), but
> then consumes the DMA-side fields (sg_dma_address()/sg_dma_len()).
> After dma_map_sgtable() the two views may differ: an IOMMU can coalesce
> the mapping so that only the first sgt->nents entries carry valid DMA
> addresses, with nents < orig_nents.
>=20
> On x86 with an IOMMU enabled, a DMABUF block backed by two 1 MiB
> system-heap chunks maps to a single 2 MiB IOVA range. The CPU-side
> count is 2, so the loop reads one entry past the mapped set and emits a
> garbage vec ({addr =3D ~0, len =3D 0}). The DMA engine driver rejects the
> vec array (prep returns NULL), the fence is signalled with -ENOMEM,
> which a userspace poller cannot observe, and the block is left in
> ACTIVE state so every further enqueue of it fails with -EBUSY. The
> visible symptom is a stream of zero-filled blocks followed by a wedged
> buffer.
>=20
> Platforms without an IOMMU never hit this because nents =3D=3D orig_nents.
>=20
> Size the vec array with sgt->nents, i.e. the DMA-mapped view, and stop
> the fill loop once bytes_used is covered - which is allowed to be
> smaller than the block size - passing the number of vecs actually
> filled to dmaengine_prep_peripheral_dma_vec().
>=20
> One vec per mapped entry is enough since coalescing can only ever
> reduce the number of entries. A single mapped entry longer than the
> device's maximum segment size would need more than one, but the DMA API
> already assumes no single segment exceeds it [1], and splitting a vec
> down to the hardware descriptor size is the DMA engine driver's job -
> which both current .device_prep_peripheral_dma_vec() implementations
> do.
>=20
> [1]: commit ab2cbeb0ed30 ("iommu/dma: Handle SG length overflow better")
>=20
> Assisted-by: Claude:claude-fable-5
> Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based use=
rspace API")
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Seems I can get away with taking patch 2 via the testing branch as
well :)  So done that.

Both those branches will get rebased so if anyone else has feedback on this
series it would be good to have.

Thanks,

Jonathan

>=20
> ---
>=20
> Note the Signed-off-by is just because I'm carrying Michael's patch!
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index ecc02a427b92..376486be3f55 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -104,10 +104,13 @@ static int iio_dmaengine_buffer_submit_block(struct=
 iio_dma_buffer_queue *queue,
>  	if (block->sg_table) {
>  		unsigned long flags;
> =20
> -		sgl =3D block->sg_table->sgl;
> -		nents =3D sg_nents_for_len(sgl, block->bytes_used);
> -		if (nents < 0)
> -			return nents;
> +		/*
> +		 * Only the first sgt->nents entries carry a valid
> +		 * sg_dma_address()/sg_dma_len() pair as mapping the table may
> +		 * have coalesced entries, in which case nents is smaller than
> +		 * orig_nents.
> +		 */
> +		nents =3D block->sg_table->nents;
> =20
>  		vecs =3D kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
>  		if (!vecs)
> @@ -115,7 +118,8 @@ static int iio_dmaengine_buffer_submit_block(struct i=
io_dma_buffer_queue *queue,
> =20
>  		len_total =3D block->bytes_used;
> =20
> -		for (i =3D 0; i < nents; i++) {
> +		sgl =3D block->sg_table->sgl;
> +		for (i =3D 0; i < nents && len_total; i++) {
>  			vecs[i].addr =3D sg_dma_address(sgl);
>  			vecs[i].len =3D min(sg_dma_len(sgl), len_total);
>  			len_total -=3D vecs[i].len;
> @@ -123,6 +127,8 @@ static int iio_dmaengine_buffer_submit_block(struct i=
io_dma_buffer_queue *queue,
>  			sgl =3D sg_next(sgl);
>  		}
> =20
> +		nents =3D i;
> +
>  		if (block->cyclic)
>  			flags =3D DMA_PREP_REPEAT;
>  		else
>=20

