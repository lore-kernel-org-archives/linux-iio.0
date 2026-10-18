Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB339B48D;
	Sun, 18 Oct 2026 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347521; cv=none; b=MvfDzraKz6gle9IRhXPArq2Z2Fg5glGbQUUAy13gJzAerhsNDDT7+J7myv+x+jqgSk7EKsFe/w4hZksnu1kGgdngUfpX4/G5D0XIBRyHSg8FjubtvrJ9gFf+wZmBiHfEnDao6Q3ZhvkASxdUWymcRG/lyjKqGy77q19sJbmeZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347521; c=relaxed/simple;
	bh=O1tGnyiVVYqKaU4kDuPSlEgbUfF9S/g4Zlcr+2CDBm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3VAEO9yWbZMINEB89sImtm3rPVQWJvik7cs7BJZYJihQc0F/WdxSf4NfVkPbVlGAjp2qB/zcAn0DQKQPIu8q5VTwSkPtjfr0dG5zdLVV12pGK9Os2pdSHcYR+qsxLIDyF7rRREfumN2jq2FOKeZo8EdLc6PFZYLYD3Q/cdrWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLVLCJ8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLVLCJ8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6531F000C4;
	Sun, 18 Oct 2026 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792347519;
	bh=nVCzRRiUilT7u/7gGX5zKNp4IhsHVJk4mkub5Hm3z38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oLVLCJ8hLunNjy8BEvDXpApLtGd60bau3PfvhRtH8iPsFQpp17+UWxgqewN+C7nuT
	 PrXXMH4iHeXcLoLb36Q1+HNT3rjNPJ4BWkJAzUoB1wT5IJ68n6ra1c0TMHD0CcO74p
	 VUh9i9MOifh3UM9C+XL6AkHwbEhe5EMMEw5qqJ3oxLH87iD5lQYqnbfXj9h9zOzStp
	 jtCNZF/SM14/Est4pwZ+0dlXxLLG6DdAN0wqcjXcU7r4f8ToMnvRlcl+36MNCx9h7C
	 Nuz0bTEHJ/qK5BzRKE+POQfFL2YHG+byirdFl01S7c80AhzlEW6JSkzLkFEM60oFWH
	 BXfkv8ACL8Gew==
Date: Sun, 18 Oct 2026 19:18:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v1 1/1] iio: Allow device drivers to specify IIO event
 unit type
Message-ID: <20261018191835.5cd0a01e@jic23-hlaptop>
In-Reply-To: <atHhvhEahMT7TonZ@nsa>
References: <e359fa003ebc61c8b0e37ba9810a04c70e5a300e.1791437050.git.marcelo.schmitt@analog.com>
	<atHhvhEahMT7TonZ@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 09:37:54 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Thu, Oct 08, 2026 at 02:27:15AM -0300, Marcelo Schmitt wrote:
> > The IIO event ABI documentation distinguishes between interfaces that
> > handle values in device-specific units (_raw) and event interfaces that
> > handle values in real-world units (e.g. meters, Joules, lux, etc).
> > However, the IIO event code infrastructure had never really implemented=
 the
> > bits to distinguish between those two types of interfaces.
> >=20
> > Because distinguishing between device (_raw) and real-world (_input) un=
its
> > only makes sense for value and hysteresis info, only add complementary =
enum
> > item for those.
> >=20
> > Users of the IIO event ABI should, as much as possible, match the event
> > unit type with the channel unit type. I.e. device drivers that present
> > device-specific raw units for their channels ought to also provide event
> > interfaces that handle raw units. Conversely, when IIO channels provide
> > processed (_input) data, IIO events will generally be expected to opera=
te
> > over real-world units as well.
> >=20
> > Complement the IIO event info enum, allowing IIO drivers to specify what
> > type of event info is used for their event interfaces.
> >=20
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> > This was originally a patch series [1], but the suggestions provided ba=
ck then
> > allowed it to be greatly simplified.
> >=20
> > [1]: https://lore.kernel.org/linux-iio/cover.1768759292.git.marcelo.sch=
mitt1@gmail.com/
> >=20
> >  include/linux/iio/types.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > index d8944c9e5e90..bf03eb498753 100644
> > --- a/include/linux/iio/types.h
> > +++ b/include/linux/iio/types.h
> > @@ -15,7 +15,11 @@
> >  enum iio_event_info {
> >  	IIO_EV_INFO_ENABLE,
> >  	IIO_EV_INFO_VALUE,
> > +	IIO_EV_INFO_VALUE_RAW,
> > +	IIO_EV_INFO_VALUE_INPUT,
> >  	IIO_EV_INFO_HYSTERESIS,
> > +	IIO_EV_INFO_HYSTERESIS_RAW,
> > +	IIO_EV_INFO_HYSTERESIS_INPUT, =20
>=20
> I might be missing something but how will the new values be different in
> terms of ABI? Shouldn't we expose different interfaces depending on RAW
> vs INPUT? Naturally we need to keep the old IIO_EV_INFO_VALUE ABI for
> existing drivers and encourage new ones to use the new one. And if any
> existing one wants to convert to the new thing, needs to keep both.

Agreed with all that.  Right now any driver that uses these new entries
will be broken as the string creation stuff to make the file names
needs to be in the same patch.

Jonathan
>=20
> - Nuno S=C3=A1
>=20
> >  	IIO_EV_INFO_PERIOD,
> >  	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
> >  	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
> >=20
> > base-commit: 04434a1d0f311d76b1f15fa987918b471a0b8c6a
> > --=20
> > 2.53.0
> >  =20

