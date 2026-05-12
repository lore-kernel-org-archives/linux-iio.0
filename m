Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4753C4B93;
	Tue, 12 May 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601294; cv=none; b=LWt6TBDz9dzhJHtyvOu3yH84pjv36wAJA0PL78Y4+Ft2VLE8/1u7TSC7hUTMYZSUhNyw9DBIbtyuqLuXIzhXKYClGwO3Pw36MMkEUOUELZJJFzBc7Mzuz1Q1Us6bhAtGVPHbAFa1WsarQCzlvQjrRyEyMJwHvrY0sEUcwBert9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601294; c=relaxed/simple;
	bh=x96C7kQutkpEZcWiUIFWIivDdMrS5yAQtQyf7GWWB70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6ttuXd08DMb+JrcsJDIYl4orHCG8cWINc3BTnIxyMwPIyG1cAPQRRDzslRpGX/VmJ3wCS2/lWfETqiutYp3QcJkAk60Z3O2UzrnWYiDNjzPjl5N/XlpVK9dSRv+rHS8QtskSoB+rdlDfuJhJNnPJCzvO2Qj5LL7az61jAtY2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWnObZ5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWnObZ5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB472C2BCC7;
	Tue, 12 May 2026 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601293;
	bh=x96C7kQutkpEZcWiUIFWIivDdMrS5yAQtQyf7GWWB70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mWnObZ5ueRQ8TBR7X3/Qbh3RbLcNntE9kfz4JIelJJIZzfz6H+3kEsUFfvYemSfvz
	 Z3oBIpQecJzCt4OxWEthqCNIm50zojS9KMhtzzDEQRlwP9rNU5aLmYWmSVT/CgDwgh
	 jbFu9BdGrO+oAGC7YMHooJMWqvX3Y21c5oYhHUIQKdHT9VMHJW1YtUSKBx+KIplCL3
	 VtzJaqQRmpjfgxFf+QFUb2NoOgulQ/I+7hWbCjrQkVmk9TFczoy93c0pQ6ySx7HOlh
	 4WUOZAzK/4FzJHtxL7dObM6YHsNls0Jhe6dCB3V4lwxKyNw2iSlwVSdWwyMRu/ZGLx
	 cxS66hxSL5pjQ==
Date: Tue, 12 May 2026 16:54:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Salih Erim <salih.erim@amd.com>, "Conall O'Griofa"
 <conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel
 lookup in event handling
Message-ID: <20260512165444.4ae39d90@jic23-huawei>
In-Reply-To: <CAJgF-xum3OQ36keRW5gCnTTbnUhsHZUzL41xKn0hjJ3GqgyOZg@mail.gmail.com>
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
	<20260414224245.8493-2-guilherme.bozi@usp.br>
	<46bcd2ce-bfb4-4fc3-b840-dba657f39a7f@amd.com>
	<CAJgF-xum3OQ36keRW5gCnTTbnUhsHZUzL41xKn0hjJ3GqgyOZg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 12:40:05 -0300
Guilherme Ivo Bozi <guilherme.bozi@usp.br> wrote:

> Hi Salih,
>=20
> Replies are inline.
>=20
> On Tue, May 12, 2026 at 11:22=E2=80=AFAM Salih Erim <salih.erim@amd.com> =
wrote:
> >
> > Hi Guilherme,
> >
> > Replies are inline.
> >
> > On 4/14/2026 11:40 PM, Guilherme Ivo Bozi wrote: =20
> > > ams_event_to_channel() may return a pointer past the end of
> > > dev->channels when no matching scan_index is found. This can lead
> > > to invalid memory access in ams_handle_event().
> > >
> > > Add a bounds check in ams_event_to_channel() and return NULL when
> > > no channel is found. Also guard the caller to safely handle this
> > > case.
> > >
> > > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > > Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
> > > ---
> > >   drivers/iio/adc/xilinx-ams.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-am=
s.c
> > > index 124470c92529..6191cd1b29a5 100644
> > > --- a/drivers/iio/adc/xilinx-ams.c
> > > +++ b/drivers/iio/adc/xilinx-ams.c
> > > @@ -871,6 +871,9 @@ static const struct iio_chan_spec *ams_event_to_c=
hannel(struct iio_dev *dev,
> > >                  if (dev->channels[i].scan_index =3D=3D scan_index)
> > >                          break;
> > >
> > > +       if (i =3D=3D dev->num_channels)
> > > +               return NULL;
> > > + =20
> > The added lines use spaces for indentation instead of tabs. =20
> I checked both locally and the raw mbox from lore.kernel.org, and the
> indentation uses TAB characters consistently (^I in the diff).
>=20
> To verify, I inspected the relevant hunk using cat -A:
>=20
> ^I^Iif (dev->channels[i].scan_index =3D=3D scan_index)
> ^I^I^Ibreak;
>=20
> +^Iif (i =3D=3D dev->num_channels)
> +^I^Ireturn NULL;
>=20
> ^Ireturn &dev->channels[i];
>=20
> I could not observe any indentation issues locally or from the raw mbox.
FWIW they look good to me as well. Salih, I'd guess you have a local issue.
b4 (on git.kernel.org) is really handy for ensuring none of those occur!

Jonathan

>=20
> >
> > Salih
> > =20
>=20
> --
> Guilherme Ivo

