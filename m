Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EED346771;
	Fri, 22 May 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471920; cv=none; b=ajhHT8VV1Phzsn0U1WjA4dsUPLquQ0s84rJm0rgDFBLgRfj3Q9h9ftta2EGEVxR+QDT60oGy3nwziCrtZTSF0JwM2cCsEmb0XoVBKvDT9j5K5ETyXdKF8M/cn0dEEapovEmUZJOMjn0aecKewioEnh7s1pSIC5NoyIbALae+i3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471920; c=relaxed/simple;
	bh=cvdE9TL8Qd8dUF9NTxwef98WEoJRHFSpJRmRu1+yFNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9kS8mb667kgmhHipzR60H5oddPn/k5Aia/U9cThhbwZ2hsmSo+5/hHF0bwyNcNvCjzTXxyLya5eZeZKLa+hckL+jbFmhdKzj6wQA4wwQ7olTMTTEjtxQqPKVTMYiOgF4iTkEZmYgPVo/6+Umv3iacS/mM9Y1dL9ZXpM2AO2kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EES70m+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EES70m+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F011F000E9;
	Fri, 22 May 2026 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779471918;
	bh=NYwdXtmvsKZ8LQl603GUa7DsPedjDzeXfQhmEHt0feY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EES70m+EzaXNLvym+V6cFP1YoNQm1Vw45nV8Zx224Vex+glywnwoSddrICYrBWLe4
	 l9XuqzCfdM/ZD1eI+0b2/wKiJFD4WxVyojk1jq0EHMuhDo3ppz/Of9lYtxE5vOTo8x
	 +53UQOVwZSQhBkDTV3OtFPFkAo6SMdigNnlCnsEhbc1T65/zFGkq6j4YYjShYafT60
	 8usRv4MeWNeUgRyuyeFwZoep8ocgOf1e/qWayIdBX33puL7r9aOaFLdSDgXiDWj9rf
	 ZA4TwE+lGHSkNXohKLlubEEPWTWGV4nssRgnPI3G9M5jlEQ5F2YIYNVorc9zWtKX9g
	 ahCn8HrXXlf1A==
Date: Fri, 22 May 2026 18:45:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 03/13] iio: core: add hierarchical channel
 relationships
Message-ID: <20260522184506.51690ac5@jic23-huawei>
In-Reply-To: <hjv4uuudhkueaotpyuzj3u3jg2rkr73jmrx2vxi37w3po5xk5x@3fhfebj6a3wt>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
	<20260517-ad9910-iio-driver-v5-3-31599c88314a@analog.com>
	<hjv4uuudhkueaotpyuzj3u3jg2rkr73jmrx2vxi37w3po5xk5x@3fhfebj6a3wt>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2026 14:48:30 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/18 03:26PM, Rodrigo Alencar wrote:
> > On 26/05/17 06:56PM, sashiko-bot@kernel.org wrote: =20
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [Medium] Exposing the hierarchical relationship via channel labels =
creates an ambiguous UAPI for userspace.
> > > --
> > >=20
> > > commit 64c6f961f1d7645c58f732e4bd4c11200b999e93
> > > Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > iio: core: add hierarchical channel relationships
> > >=20
> > > This commit introduces a parent-child relationship between IIO channe=
ls.
> > > It adds a parent pointer to the iio_chan_spec struct and exposes this
> > > relationship to userspace through a new "parent" sysfs attribute that
> > > returns the parent channel's label.
> > >  =20
> > > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industri=
alio-core.c
> > > > index 5c8404efd0a56..348ac7a597385 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c =20
> > >=20
> > > [ ... ]
> > >  =20
> > > > @@ -1263,6 +1271,31 @@ static int iio_device_add_channel_label(stru=
ct iio_dev *indio_dev,
> > > >  	return 1;
> > > >  }
> > > > =20
> > > > +static int iio_device_add_channel_parent(struct iio_dev *indio_dev,
> > > > +					 struct iio_chan_spec const *chan)
> > > > +{
> > > > +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
> > > > +	int ret;
> > > > +
> > > > +	if (!chan->parent || (!indio_dev->info->read_label &&
> > > > +			      !chan->parent->extend_name))
> > > > +		return 0; =20
> > >=20
> > > Is relying on channel labels robust enough for programmatic parent re=
solution?
> > >=20
> > > IIO channel labels are optional, human-readable descriptors and are n=
ot
> > > guaranteed by the core to be unique. If multiple channels within a de=
vice
> > > share the same label, how can userspace definitively resolve which sp=
ecific
> > > channel is the parent?
> > >=20
> > > Also, if a driver establishes a hierarchy where chan->parent is set, =
but the
> > > parent channel lacks a label, this attribute is silently omitted, hid=
ing the
> > > relationship entirely.
> > >=20
> > > Would it be more reliable to expose a definitive, unique identifier (=
such as
> > > the parent channel's sysfs prefix or index) rather than relying on an=
 optional
> > > descriptive string? =20
> >=20
> > A bit impressive that sashiko can comment on that architecture level.
> >=20
> > Those are all good points. I suppose I went for this because otherwise =
it would
> > require refactoring core code to get the needed parts from __iio_device=
_attr_init()
> > that gets you the channel name without the attribute part.
> >=20
> > Maybe we should have a function that outputs a channel name into a buff=
er based on
> > __iio_device_attr_init() behavior, and that could be reused. =20
>=20
> This is the function with behavior extracted from __iio_device_attr_init(=
):
>=20
> 	static int __iio_chan_prefix_emit(const struct iio_chan_spec *chan,
> 					  enum iio_shared_by shared_by,
> 					  char *buf, size_t len)
> 	{
> 		const char *dir =3D iio_direction[chan->output];
> 		const char *type =3D iio_chan_type_name_spec[chan->type];
> 		int n =3D 0;
>=20
> 		switch (shared_by) {
> 		case IIO_SHARED_BY_ALL:
> 			break;
> 		case IIO_SHARED_BY_DIR:
> 			n =3D scnprintf(buf, len, "%s", dir);
> 			break;
> 		case IIO_SHARED_BY_TYPE:
> 			n =3D scnprintf(buf, len, "%s_%s", dir, type);
> 			if (chan->differential)
> 				n +=3D scnprintf(buf + n, len - n, "-%s", type);
> 			break;
> 		case IIO_SEPARATE:
> 			if (chan->indexed) {
> 				n =3D scnprintf(buf, len, "%s_%s%d", dir, type,
> 					      chan->channel);
> 				if (chan->differential)
> 					n +=3D scnprintf(buf + n, len - n, "-%s%d", type,
> 						       chan->channel2);
> 			} else {
> 				if (chan->differential) {
> 					WARN(1, "Differential channels must be indexed\n");
> 					return -EINVAL;
> 				}
> 				n =3D scnprintf(buf, len, "%s_%s", dir, type);
> 			}
>=20
> 			if (chan->modified) {
> 				if (chan->differential) {
> 					WARN(1, "Differential channels can not have modifier\n");
> 					return -EINVAL;
> 				}
> 				n +=3D scnprintf(buf + n, len - n, "_%s",
> 					       iio_modifier_names[chan->channel2]);
> 			}
>=20
> 			if (chan->extend_name)
> 				n +=3D scnprintf(buf + n, len - n, "_%s", chan->extend_name);
> 			break;
> 		}
>=20
> 		return n;
> 	}
>=20
> I think it is clear and reusable.

You only what the SEPARATE case but given the rest is much simpler anyway p=
robably fine
to just use this function.

Jonathan



>=20
> > > > +
> > > > +	ret =3D __iio_add_chan_devattr("parent",
> > > > +				     chan,
> > > > +				     &iio_read_channel_parent,
> > > > +				     NULL,
> > > > +				     0,
> > > > +				     IIO_SEPARATE,
> > > > +				     &indio_dev->dev,
> > > > +				     NULL,
> > > > +				     &iio_dev_opaque->channel_attr_list);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return 1;
> > > > +} =20
> > >=20
> > > --=20
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517-ad99=
10-iio-driver-v5-0-31599c88314a@analog.com?part=3D3 =20
>=20

