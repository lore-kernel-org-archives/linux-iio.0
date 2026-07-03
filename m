Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98C196C7C;
	Fri,  3 Jul 2026 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040890; cv=none; b=ZSxvjQhZVGC5NTFRAUra6vrQ9jZkx/hC8HmSlfk2zLo/pY4KTvCIijVS9uJ9mhkt7IWlFp4H17//um2JE7J1YG6o/t+G1GKrH1BLJhfrR2NV9B51eKA38v9zATv0aDJRXaAcBaQZlyB4qwSAsj+vDKG82dJrpVaSiWkYYSl5HR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040890; c=relaxed/simple;
	bh=HAM3nORWpQR8w0ae3IIXqP94wl3JyNFXg7lgZuttN2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfL0y6oQhmVNao+u7Ea+6pPapaw/QWjoOEaKc+9oE6TNQDq1WwAAg73UtzqxN3vMf5In3/LajsiNdBLWTcZSHdg+YqOi3blxlEw1STkKe0h37u1DNeseQA8Cuy8UWmnBgtLQpwSgt2oBnc5tTJDqoIICLjroge3W8jdy68iXQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcJjyj7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcJjyj7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EED1F00A3A;
	Fri,  3 Jul 2026 01:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783040889;
	bh=q7lNi8+BoVFtGn8keQstNnZo0JkUvXcamXgek2agl10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bcJjyj7qxst6AXpQ70x2+lXspE5VDxu9uJ3hP6Tv5krNJDTMOUO4LMv7qb6WRK/nN
	 vHzNOC9LFm2zH+E5fJHdlypTid25fgK7ANt5/9C4Jnw4PoXhy4HMfDRjuQkF+7qc3S
	 W6V/bmT9A5FeRBUY/W6zNeSNDS0D5fX0dQNDo17VygzcFzb+2gLSHEtBKhrTTlCYbI
	 dcHstyYj03w5/VdQbBOBl9HSiWNe+MusmXan6xk5+obvqPuHFGrUImuShpjKKgs2cU
	 WlBKP4MrxgndQdEh7EJLyRjtq+Xvfn1glNGqjRXFhmjakit9IvN0P16m2LFoazXwzn
	 PzFnyAhJjKTKg==
Date: Fri, 3 Jul 2026 02:08:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 06/16] iio: core: create local
 __iio_chan_prefix_emit() for reuse
Message-ID: <20260703020803.0bb4636d@jic23-huawei>
In-Reply-To: <ajUIRHZZOKgdyGu4@nsa>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-6-79125ffbe430@analog.com>
	<ajQGTQ1_qcOwfzne@nsa>
	<x3aijvc4buo7aqbchikuoyyrgiq3afidtkla37h2rg4tvfdbc3@h42qp3estg2s>
	<ajUIRHZZOKgdyGu4@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 10:16:31 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, Jun 18, 2026 at 05:14:19PM +0100, Rodrigo Alencar wrote:
> > On 18/06/26 16:06, Nuno S=C3=A1 wrote: =20
> > > On Thu, Jun 18, 2026 at 02:27:22PM +0100, Rodrigo Alencar via B4 Rela=
y wrote: =20
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > >=20
> > > > Move logic to create a channel prefix for naming attribute files in=
to a
> > > > separate __iio_chan_prefix_emit() function for reuse. =20
> >=20
> > ...
> >  =20
> > > > +static int __iio_chan_prefix_emit(const struct iio_chan_spec *chan,
> > > > +				  enum iio_shared_by shared_by,
> > > > +				  char *buf, size_t len)
> > > > +{
> > > > +	const char *dir =3D iio_direction[chan->output];
> > > > +	const char *type =3D iio_chan_type_name_spec[chan->type];
> > > > +	int n =3D 0;
> > > > +
> > > > +	switch (shared_by) {
> > > > +	case IIO_SHARED_BY_ALL:
> > > > +		buf[0] =3D '\0'; /* empty channel prefix */
> > > > +		break;
> > > > +	case IIO_SHARED_BY_DIR:
> > > > +		n =3D scnprintf(buf, len, "%s", dir);
> > > > +		break;
> > > > +	case IIO_SHARED_BY_TYPE:
> > > > +		n =3D scnprintf(buf, len, "%s_%s", dir, type);
> > > > +		if (chan->differential)
> > > > +			n +=3D scnprintf(buf + n, len - n, "-%s", type);
> > > > +		break;
> > > > +	case IIO_SEPARATE:
> > > > +		if (chan->indexed) {
> > > > +			n =3D scnprintf(buf, len, "%s_%s%d", dir, type,
> > > > +				      chan->channel);
> > > > +			if (chan->differential)
> > > > +				n +=3D scnprintf(buf + n, len - n, "-%s%d", type,
> > > > +					       chan->channel2);
> > > > +		} else {
> > > > +			if (chan->differential) {
> > > > +				WARN(1, "Differential channels must be indexed\n");
> > > > +				return -EINVAL;
> > > > +			}
> > > > +			n =3D scnprintf(buf, len, "%s_%s", dir, type);
> > > > +		}
> > > > +
> > > > +		if (chan->modified) {
> > > > +			if (chan->differential) {
> > > > +				WARN(1, "Differential channels can not have modifier\n");
> > > > +				return -EINVAL; =20
> > >=20
> > > WARN() looks too much to me. dev_error() as we're treating it as such=
. I
> > > guess you don't want to pass struct device but not really an issue IM=
HO. =20
> >=20
> > __iio_device_attr_init() also used WARN(), probably because it didnt ha=
ve
> > access to a dev pointer. It would not be a problem to add an extra para=
m. =20
>=20
> Hmm, fair enough. Maybe a chance to change it. Not sure how others feel
> about it.
I was young and knew less back then (either as reviewer or author).
WARN() on a lot of systems actually means panic, so for stuff like this
it isn't appropriate.  I'd definitely support a series flipping any
WARN() to dev_err() or similar.

Thanks,

Jonathan
