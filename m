Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3B46C82A;
	Sun, 20 Sep 2026 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924175; cv=none; b=W2tYnCb5UwfR3iipK7DdkeBvAyWTOsqFSrgCU7YJONQAJKO87/jeEmIY0gJwFItWEWgBpB3/4O/g1tjODw902KHsu6wWxKNXTEXNfiau/FoMxPhzis6dFVbjyHnF+49xOGkw9e/IoKCGP8rlxDq8pIIMMq4tJZX7hayYm1DQZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924175; c=relaxed/simple;
	bh=epEIftHIJ6guXFyAvgDr34Mirok2VIQrn65ZZPY0Sms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOJslBPIor2OPgH64CDZYbSj6HJs0kIG2JXmY9h3mjcBWaDRFWMaYcRWKSd5fovUKS1ep7HUevUlEaAslvpqzjDbSFBFxtXRBofZlPSfiAXBEMvj+xDoNZwz5h55UIumhp8vMIvwdblyCfbzYySznwDb2SFcT8e9efJFHcul6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHaF1nrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHaF1nrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF801F00893;
	Sun, 20 Sep 2026 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789924173;
	bh=wZeL3R3YkLJnrienhtZ9limxE9zz/cF9+FDo7Jb4mvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DHaF1nrFQwZGVR/Zcxmx7TUVXQTGrYYGlkl1bVIEpB6tGgJuDwUB0M9tjpuQcTR0+
	 5eCTsDz9lTZwXWFag9Ut61vaeiBMlOCF1nr51/VBlZTNEdDrRTZpYeLMCpFIITYOZ7
	 A8SEy0kkJaH+G7OsL/gEmzOKc9U47nxOghoqBFH4/2O+SNQVJVhIALFfEYpf6iZAFE
	 h9uFCoqn2IAUSkpaHS8ChYiS1P34t342/yqBLwa7gVSa6WwNPIX555uRHZODUun+Xy
	 /jaGAGzcRRiRDyieBlIE1ygv6jQK32/fcH2+GY2qBsVsG4Isf6OoPYRhtzz2Q/2zNt
	 gNpHIRi+DGZ0w==
Date: Sun, 20 Sep 2026 18:09:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 4/8] iio: osf: add validated stream parser
Message-ID: <20260920180927.138da86c@jic23-hlaptop>
In-Reply-To: <CALMSew+LJjky+3uSSL3kByzpT-tkNmJTDurykNmH-nj9+zxCJw@mail.gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<e9d1f8f8d69b76797d617965f263df97b2b586e0.1789753020.git.kimjinseob88@gmail.com>
	<20260920023057.71ef0eb5@jic23-hlaptop>
	<CALMSew+LJjky+3uSSL3kByzpT-tkNmJTDurykNmH-nj9+zxCJw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Sep 2026 13:12:54 +0900
Kim Jinseob <kimjinseob88@gmail.com> wrote:

> > You could reorder these two functions and call stream_reset from
> > stream_init. Would make it clear what getting to a 'clean' state
> > means. =20
>=20
> Agreed. I'll move osf_stream_reset() before osf_stream_init() and use
> it from the init path in the next revision.
>=20
A few process things.  Strong preference is always for reply inline so
the context is there next to the reply rather than pulling part of
that context to the top of the email.

The other thing is that if your reply doesn't convey much information
beyond agreeing to make suggested change, don't send the reply.
We all get far too many emails and can check the change log of the next
version to see if everything that was not addressed in the earlier
thread has been dealt with!

Note I send this sort of email about once a week - so you are far from
the first to need a little nudge towards more optimal interactions
on the list!

Thanks,

Jonathan

> Thanks,
>=20
> Jinseob
>=20
> 2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 10:31=
, Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Sat, 19 Sep 2026 03:24:42 +0900
> > Jinseob Kim <kimjinseob88@gmail.com> wrote:
> > =20
> > > Add a UART byte-stream parser for Open Sensor Fusion frames.
> > >
> > > The parser searches for the OSF0 wire magic, keeps partial frames
> > > buffered, checks header length and payload bounds, and passes complete
> > > candidate frames to a registered frame callback.
> > >
> > > Candidates rejected before validation drop only the current head
> > > byte before resynchronizing, so a corrupted unvalidated payload length
> > > cannot make the parser skip later valid frames. CRC-valid validated
> > > frames are consumed in full and classified as handled, ignored, or
> > > rejected.
> > >
> > > Use a direct callback member with an opaque context and keep explicit
> > > statistics for validated outcomes and framing failures.
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com> =20
> > Just one trivial thing.
> >
> > Thanks,
> >
> > Jonathan
> >
> > =20
> > > diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/=
opensensorfusion/osf_stream.c
> > > new file mode 100644
> > > index 000000000000..e262415e69b7
> > > --- /dev/null
> > > +++ b/drivers/iio/opensensorfusion/osf_stream.c =20
> >
> > =20
> > > +void osf_stream_init(struct osf_stream *stream,
> > > +                  int (*receive_frame)(void *context, const u8 *buf,
> > > +                                       size_t len),
> > > +                  void *frame_context)
> > > +{
> > > +     if (!stream)
> > > +             return;
> > > +
> > > +     stream->receive_frame =3D receive_frame;
> > > +     stream->frame_context =3D frame_context;
> > > +     stream->len =3D 0;
> > > +     memset(&stream->stats, 0, sizeof(stream->stats));
> > > +}
> > > +
> > > +void osf_stream_reset(struct osf_stream *stream)
> > > +{
> > > +     if (!stream)
> > > +             return;
> > > +
> > > +     stream->len =3D 0;
> > > +     memset(&stream->stats, 0, sizeof(stream->stats));
> > > +} =20
> >
> > You could reorder these two functions and call stream_reset from
> > stream_init.  Would make it clear what getting to a 'clean' state
> > means.
> >
> >
> > =20
>=20

