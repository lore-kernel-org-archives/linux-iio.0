Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFE49363C
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787444184; cv=none; b=TClglTGbAHiuJYfj5UaypBbSh51y9FQuVDPvTEY51827cAlQiSuSeg+ZxnMTs+JRiESvKn2HhVpcOdexh9LRxmhgzrQMBk1u4vzNxkNNvqOrZNMOcpE9REZIulLVEA86wbqHggEVnHqvy+St1dCZvklCMOx1kiu3jLFkqk7ybtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787444184; c=relaxed/simple;
	bh=bUeZgEYj+7Qcs4FFf4YrK3zjW0OyEWwWvQRbu8tfXkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbt6BfLhiFM8IVxLB2rg8drvNV3fdop7nuG2gyaVuIj+RCMDSdlM/FdtnbwH7YeHQHDnGcWJJ07IH+GW7BaUYklfd8EW9cc078FMdaeNRvdFmBlkIhLwDpKqT+vwB0afnaJgDaNyXhR52tq5kq74Hho84CvQh/OA9t7S5oh6DXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1lEj0/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1lEj0/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF4B1F000E9;
	Sun, 23 Aug 2026 00:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787444182;
	bh=Pq+LWn66xxwbkmU07fVCZADNXlmlYR+X2VxfzgEzCEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J1lEj0/tzaZ2IxU0hybcvPEEz5u1OZbEvkLAuaBo/K2CeeZIzlxnsk3mASLdjy8DV
	 oK6vUCl3FUtm4XZFzy4VuOpFtIDGjcrxmuYQwwuk7lXq+zvHo59MeZKLf6catwD2wk
	 1TudsXJ9Oe09UA5wD/tijK7PSwudRHzyL2FDakoiEkw6d8qtPfedFuLCRVSglnfIi6
	 Hnawl6EykqsagKJ+31OzRyUAL6YOCNY2ZzDiOeV4mlrpyyvsoO8C3R072P8lJCuwfu
	 M+Si6LzOzrbG0rRiVY+Byrbt6uyLq0SAmPauZEwhZpUHKYZVL58mqhkJaUXAbKjVjp
	 j+rFLDMpAom5A==
Date: Sun, 23 Aug 2026 01:16:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: fix sg entry iteration when
 building dma_vecs
Message-ID: <20260823011618.2176b016@jic23-huawei>
In-Reply-To: <aoV32knWqL6s4xjF@nsa>
References: <20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com>
	<20260819014104.56bd4157@jic23-huawei>
	<aoV32knWqL6s4xjF@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2026 11:16:22 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Wed, Aug 19, 2026 at 01:41:04AM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Aug 2026 17:45:29 +0100
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >  =20
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > >=20
> > > iio_dmaengine_buffer_submit_block() counts scatterlist entries with
> > > sg_nents_for_len(), which walks the CPU-side lengths (sg->length), but
> > > then consumes the DMA-side fields (sg_dma_address()/sg_dma_len()).
> > > After dma_map_sgtable() the two views may differ: an IOMMU can coales=
ce
> > > the mapping so that only the first sgt->nents entries carry valid DMA
> > > addresses, with nents < orig_nents.
> > >=20
> > > On x86 with an IOMMU enabled, a DMABUF block backed by two 1 MiB
> > > system-heap chunks maps to a single 2 MiB IOVA range. The CPU-side
> > > count is 2, so the loop reads one entry past the mapped set and emits=
 a
> > > garbage vec ({addr =3D ~0, len =3D 0}). The DMA engine driver rejects=
 the
> > > vec array (prep returns NULL), the fence is signalled with -ENOMEM,
> > > which a userspace poller cannot observe, and the block is left in
> > > ACTIVE state so every further enqueue of it fails with -EBUSY. The
> > > visible symptom is a stream of zero-filled blocks followed by a wedged
> > > buffer.
> > >=20
> > > Platforms without an IOMMU never hit this because nents =3D=3D orig_n=
ents.
> > >=20
> > > Size the vec array with sg_nents_for_dma(), which walks the DMA-mapped
> > > view and accounts for max-length splitting, and stop the fill loop on=
ce
> > > bytes_used is covered - which is allowed to be smaller than the block
> > > size - passing the reduced count to dmaengine_prep_peripheral_dma_vec=
().
> > >=20
> > > Assisted-by: Claude:claude-fable-5
> > > Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based=
 userspace API")
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> >=20
> > There are some gremlins nearby in this code...
> > In the else just of this context seems max_size is computed again
> > having been done just above the code seen here.
> >=20
> > Unless I'm missing something that should be cleaned up as well. =20
>=20
> Oh yes! Something I already noticed a couple of times but never sent the
> patch right away so I kept forgetting about it.
> >=20
> > Been a while since I got my head into the scatterlist
> > stuff, so I might have it wrong below, but I don't think what
> > you have here actually works if the merging of entries is
> > larger than the max dma entry the hardware supports.
> >  =20
>=20
> In theory might not be a bug but I'm not sure it's a claim we can fully
> take as guarantee.
>=20
> >  =20
> > > ---
> > > Note the Signed-off-by is just because I'm carrying Michael's patch!
> > > ---
> > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 ++++++++++++=
----
> > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/dri=
vers/iio/buffer/industrialio-buffer-dmaengine.c
> > > index ecc02a427b92..bece45381c8c 100644
> > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > @@ -104,10 +104,16 @@ static int iio_dmaengine_buffer_submit_block(st=
ruct iio_dma_buffer_queue *queue,
> > >  	if (block->sg_table) {
> > >  		unsigned long flags;
> > > =20
> > > +		/*
> > > +		 * Use the DMA-mapped view of the sg_table: after mapping
> > > +		 * (e.g. through an IOMMU) the DMA entries (sgt->nents) can be
> > > +		 * fewer than the CPU entries, and sg_dma_address()/sg_dma_len()
> > > +		 * are only valid for the first sgt->nents entries. Counting
> > > +		 * with sg_nents_for_len() (CPU lengths) walks past them and
> > > +		 * hands garbage vecs to the DMA engine. =20
> >=20
> > This feels like too much info after the fix is in place.  Talking about=
 other
> > stuff that would be wrong is rather unusual.
> > =20
>=20
> Oh well, I guess LLM over commenting as usual.
>=20
> > > +		 */
> > >  		sgl =3D block->sg_table->sgl;
> > > -		nents =3D sg_nents_for_len(sgl, block->bytes_used);
> > > -		if (nents < 0)
> > > -			return nents;
> > > +		nents =3D sg_nents_for_dma(sgl, block->sg_table->nents, max_size);=
 =20
> >=20
> > So this fun function will generally give us the number of sgl entries, =
but not
> > quite always. It will give us how many chunks of up to max_size fit into
> > a particularly large entry.
> >  =20
> > > =20
> > >  		vecs =3D kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
> > >  		if (!vecs)
> > > @@ -115,7 +121,7 @@ static int iio_dmaengine_buffer_submit_block(stru=
ct iio_dma_buffer_queue *queue,
> > > =20
> > >  		len_total =3D block->bytes_used;
> > > =20
> > > -		for (i =3D 0; i < nents; i++) {
> > > +		for (i =3D 0; i < nents && len_total; i++) { =20
> > So this needs to be more clever as we aren't just iterating entrees and=
 filling
> > them in, some of them could at least in theory be too big to fit
> > in a single vec - hence you need to do a loop in here that sets
> > multiple entries if that occurs. =20
>=20
> I see! But I think that merging means that we end up with more nents
> (sg_nents_for_len()) entries than DMA ones which was the issue we had
> because we were left with vecs with invalid addresses and 0 sized.

You can end up with a smaller set of DMA mappings than the CPU ones that
were typically pushed in.  That covers what happens in the IOMMU.
However those can be 'big' and so your DMA engines own ability to handle
a particular size of contiguous block may be the problem and result in
you needing more entrees on the hardware side of things.

> The other
> way around should not happen on the IOMMU path at least given the assumpt=
ion
> that a single sg  entry must not be bigger than max_len [1].
Hmm - do I understand this right - is the question: If you original CPU side
mappings (the input scatter gather list entries) are less than max_len byte=
s each
then can we end up with a large set of entries for the DMA Engine after
the merge then split?  If so I think I think the answer is no (as long
as no other constraints like alignment make a mess for us - I gave
up trying to reason those out on a bit of paper).

> I think in theory
> that can actually happen (if we end using a dma provider defaulting to 64=
K and=20
> cma dma_bufs) but maybe we can argue that's not our problem? Given
> the assumptions of course.
>=20
> But even if we somehow reach this path with sg_dma_address > max_size
> and end up stuffing all of it in say, vec[0], the DMA controller should
> also care to make sure it splits each vec if it exceeds the descriptor
> max size. That's what both users of (ADI axi_dmac being one them)
> .device_prep_peripheral_dma_vec() are doing today. But yes, I agree that
> might be a bold assumption.

Then why we are we passing in max_size to the function to work out
how many entrees?  If splits are handled elsewhere we don't need that
limit.

>=20
> >=20
> > If that can't happen for some other reason then I think you can=20
> > just use block->sgtable->nents instead of the more complex call above.
> >  =20
>=20
> I was the one suggesting the other call because it seemed what we
> actually wanted but I'm fine with just using the above. I'm more tempted
> to keep it simple and use 'block->sgtable->nents' rather than jumping in
> a more complex subloop without clear evidence we really need it.
> Thoughts?

If they are split below this layer then indeed we don't need the call
and can use the number DMA entries.

>=20
> As a fun side note this also made visible another subtle issue. Given
> that submitting a block might only happen when enabling the buffer (so
> async to enqueueing it) when we hit this issue, we get -ENOMEM and
> and go ahead  to wake up poll(). But AFAIK, we can't really propagate
> the error code up to userspace so userspace wakes up just to get
> garbage and thinking everything is fine. Easy way out would be to treat
> this as and hard error and return error when enabling the buffer. But
> that also raises the question that other blocks might have been properly
> submitted though. Not really sure how to handle this but anyways a problem
> for another day :)

Hmm. It is always tricky to cleanly surface errors when we get a problem
somewhere random in DMA.  No idea off the top of my head on how to solve
this case.

Jonathan

>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dab2cbeb0ed301a9f0460078e91b09f39958212ef
>=20
> - Nuno S=C3=A1
>=20
> > >  			vecs[i].addr =3D sg_dma_address(sgl);
> > >  			vecs[i].len =3D min(sg_dma_len(sgl), len_total);
> > >  			len_total -=3D vecs[i].len;
> > > @@ -133,6 +139,8 @@ static int iio_dmaengine_buffer_submit_block(stru=
ct iio_dma_buffer_queue *queue,
> > >  		 * before it can run, so always set the EOT flag.
> > >  		 */
> > >  		flags |=3D DMA_PREP_LOAD_EOT;
> > > +		nents =3D i;
> > > +
> > >  		desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> > >  							 vecs, nents, dma_dir,
> > >  							 flags);
> > >=20
> > > ---
> > > base-commit: b756b143e5391151e577ae645b1378a43f93c2f5
> > > change-id: 20260818-iio-buffer-dmabuf-iommu-fic-1b281f15e5a4
> > > --
> > >=20
> > > Thanks!
> > > - Nuno S=C3=A1
> > >  =20
> >  =20

