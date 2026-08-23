Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C8625
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787444606; cv=none; b=asaPBHrru2wtrlG6nLcjPHWQzVTSj9kjuAz+rA9cUSQFjPWMS3x++dH0CK1WHNJSk0nx4/gXR8WH+4A8B0rMSLqSIphdyIs/RGKlETDCb674U/DfX/ajSWr2vc4DFSc0mmdOpI83d8Gal2SdpuTdeUWuUJMQDJTdf73dKW5WrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787444606; c=relaxed/simple;
	bh=CvxpDwTtiszlMhdWNkGSlv1mRGzEi2efrCIu9QdvK8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eb3I0GY+nI4SQgotD36xgrLY9EFMvUBMpRyLNpuLSBkdIjW7apISWMQ6OS9/m4sba9es+5Vh7pbw5WhkQZ87k/jy+xH0axZNXEurKqXlG0x0ppkNlpqYMnpLe5iz6jSV+yIahgxU7RKjatV0EO8T4Uzx+ZdWcHmcrscmb1wTs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMmw3czM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMmw3czM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2951F000E9;
	Sun, 23 Aug 2026 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787444604;
	bh=e6IvavnIbgMRAjLVJZq1lSPrK5cQ/A+sASw5WsD/vTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QMmw3czMkk/vp5/gawOu/awxOP0rTJWe2fBd7cU88S1LBQ/Kb91Dja9R97zZ8fMUW
	 6GgWRc/r+D0BQxA1MFxT9P4s292XB8saw2XGj0xlA/mqTsftkByjoxzfdUU2Hq5NWj
	 RqePAm3x6ellljlV8qbIAN3I8WyzTXDAplcl7yXbZYu3m7cyOH4/KDHDZMGwYB/ksv
	 mCtLEh7FJqLjnxwJkSq8ajJ+slKG6uCTivp8m3Scy+VArUUL4H7fznSUGe1dFORdCI
	 5tV+od4drsRwWzimhnOaQLbwGR7xPZeptVSUAUMpGgd9YmWk7d6dCuvjwkcZKwpHZZ
	 1VOktxI/UgKIg==
Date: Sun, 23 Aug 2026 01:23:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 Paul Cercueil <paul@crapouillou.net>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: fix sg entry iteration when
 building dma_vecs
Message-ID: <20260823012318.77fcd990@jic23-huawei>
In-Reply-To: <aoYYB5ANWI6GILER@ashevche-desk.local>
References: <20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com>
	<20260819014104.56bd4157@jic23-huawei>
	<aoYYB5ANWI6GILER@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2026 23:54:31 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 19, 2026 at 01:41:04AM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Aug 2026 17:45:29 +0100
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote: =20
>=20
> ...
>=20
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
> > a particularly large entry. =20
>=20
> It gives the number of SG entries needed for the case if each of them will
> satisfy the limit. Whatever following code does, it may allocate a new SG
> list based on the number returned by this function and resplit.

Yup. That's what would be needed if the condition can actually occur.
Also, Nuno is (I think) suggesting the dma engine driver itself
deals with that splitting when it is needed.  So hopefully this
is a place where we can apply the someone else's problem field ;)

>=20
> > > -		for (i =3D 0; i < nents; i++) {
> > > +		for (i =3D 0; i < nents && len_total; i++) { =20
> > So this needs to be more clever as we aren't just iterating entrees and=
 filling
> > them in, some of them could at least in theory be too big to fit
> > in a single vec - hence you need to do a loop in here that sets
> > multiple entries if that occurs.
> >=20
> > If that can't happen for some other reason then I think you can=20
> > just use block->sgtable->nents instead of the more complex call above. =
=20
>=20
> Perhaps sg_split() is what people are looking for in this case?

I'd forgotten that nugget of fun existed. There is a patch on list
to drop the one driver I ever used it in - bringing the total users
down to 4! :) I don't think it applies here though as we are talking
splitting one entry of the list, not the whole list.
That list splitting is for when you have a constraint on the total max DMA
done in one request.=20

Jonathan


>=20

