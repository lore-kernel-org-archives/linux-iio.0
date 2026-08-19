Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99859382365
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787100072; cv=none; b=Kl1nN2dHsiYX6aUAuuOWWbgmmWkHFVqbKv1XZDrnmF/IMq02mq5QRS7+JN6uB+ihNSUNHPUSiS57MSbCsV18TtSpSVNt48jmiQi6f6uUe3G24ijq31mOHQlUOn+oxNSRukKNLoeFK+KWyYm+bFudm6Zz2/oG0gciApCMrdeAqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787100072; c=relaxed/simple;
	bh=AZaefKcHNJchwzvw0bkArtx6CAJxwXyNj7WpiBiIUZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcqB4W542Khf+Qywil50A5+NU8t+/uVNU/WS61VevRFg1NCEBYGsswuHGbEF8NvClYnGIRd5py+oq0xhSsbx4Vx+Ysh7owpXv4sJXNupFVVODN8sFwlN8h4rOBhM7IHCuKbJrqRoIIIuVUUJ7udHB2KECNoxa9rJ/6GbuqLe+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQR09A04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQR09A04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7091F000E9;
	Wed, 19 Aug 2026 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787100067;
	bh=P1un+bO6c0XYKSqIuJE9Ic0GE4dRSOJi+4P8zX4KHiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NQR09A04TsjFtHdJNe+RJN06zlX+EO0DjW0yzVGs+VwSekHLon7Sty/X5OhXwRCKz
	 Ov/IR7QWnTNaZrmEwu59DXOsV54mZHCFiQuPGxCcySqPQGuluVw+MMBeiKi1LR57zy
	 xrwWlfHSAm3DYM2gJVUF2kyvgVpy8KZuGSlQTnYGDYxHS61hu9PijHxYKLL3JAQ5j1
	 DqjxEtWQtgRYqcYIoQj7KuDTlJeAeagrzZ88bDOYhObgrRjh/fEP697FEZVjhOuCe6
	 R5gzYtyBJr6vig78XxR3yDHbYAMzbDOVERo/oyhSHaxPZXhke1b7hirZkqmMiHgWqf
	 bgYMx3txpBxeg==
Date: Wed, 19 Aug 2026 01:41:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: fix sg entry iteration when
 building dma_vecs
Message-ID: <20260819014104.56bd4157@jic23-huawei>
In-Reply-To: <20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com>
References: <20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2026 17:45:29 +0100
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
> Size the vec array with sg_nents_for_dma(), which walks the DMA-mapped
> view and accounts for max-length splitting, and stop the fill loop once
> bytes_used is covered - which is allowed to be smaller than the block
> size - passing the reduced count to dmaengine_prep_peripheral_dma_vec().
>=20
> Assisted-by: Claude:claude-fable-5
> Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based use=
rspace API")
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

There are some gremlins nearby in this code...
In the else just of this context seems max_size is computed again
having been done just above the code seen here.

Unless I'm missing something that should be cleaned up as well.

Been a while since I got my head into the scatterlist
stuff, so I might have it wrong below, but I don't think what
you have here actually works if the merging of entries is
larger than the max dma entry the hardware supports.


> ---
> Note the Signed-off-by is just because I'm carrying Michael's patch!
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index ecc02a427b92..bece45381c8c 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -104,10 +104,16 @@ static int iio_dmaengine_buffer_submit_block(struct=
 iio_dma_buffer_queue *queue,
>  	if (block->sg_table) {
>  		unsigned long flags;
> =20
> +		/*
> +		 * Use the DMA-mapped view of the sg_table: after mapping
> +		 * (e.g. through an IOMMU) the DMA entries (sgt->nents) can be
> +		 * fewer than the CPU entries, and sg_dma_address()/sg_dma_len()
> +		 * are only valid for the first sgt->nents entries. Counting
> +		 * with sg_nents_for_len() (CPU lengths) walks past them and
> +		 * hands garbage vecs to the DMA engine.

This feels like too much info after the fix is in place.  Talking about oth=
er
stuff that would be wrong is rather unusual.

> +		 */
>  		sgl =3D block->sg_table->sgl;
> -		nents =3D sg_nents_for_len(sgl, block->bytes_used);
> -		if (nents < 0)
> -			return nents;
> +		nents =3D sg_nents_for_dma(sgl, block->sg_table->nents, max_size);

So this fun function will generally give us the number of sgl entries, but =
not
quite always. It will give us how many chunks of up to max_size fit into
a particularly large entry.

> =20
>  		vecs =3D kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
>  		if (!vecs)
> @@ -115,7 +121,7 @@ static int iio_dmaengine_buffer_submit_block(struct i=
io_dma_buffer_queue *queue,
> =20
>  		len_total =3D block->bytes_used;
> =20
> -		for (i =3D 0; i < nents; i++) {
> +		for (i =3D 0; i < nents && len_total; i++) {
So this needs to be more clever as we aren't just iterating entrees and fil=
ling
them in, some of them could at least in theory be too big to fit
in a single vec - hence you need to do a loop in here that sets
multiple entries if that occurs.

If that can't happen for some other reason then I think you can=20
just use block->sgtable->nents instead of the more complex call above.

>  			vecs[i].addr =3D sg_dma_address(sgl);
>  			vecs[i].len =3D min(sg_dma_len(sgl), len_total);
>  			len_total -=3D vecs[i].len;
> @@ -133,6 +139,8 @@ static int iio_dmaengine_buffer_submit_block(struct i=
io_dma_buffer_queue *queue,
>  		 * before it can run, so always set the EOT flag.
>  		 */
>  		flags |=3D DMA_PREP_LOAD_EOT;
> +		nents =3D i;
> +
>  		desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
>  							 vecs, nents, dma_dir,
>  							 flags);
>=20
> ---
> base-commit: b756b143e5391151e577ae645b1378a43f93c2f5
> change-id: 20260818-iio-buffer-dmabuf-iommu-fic-1b281f15e5a4
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20

