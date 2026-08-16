Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03B29C327;
	Sun, 16 Aug 2026 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913083; cv=none; b=g5lflGkO5fIH3YTS5kHe6FWKQqB8Jyj7TpcAgLt6nSGoJLVjmnfDB9ZPDxaJmJrSqa52+riAcK+Q3tuSgOmBNrDE/+4QM1bVNTNw16yLN7KOj2aOnYiE58umi7wlH/82WI0awK1AUqrn0nmFZYLe++BdykrwgBuAuUdlHSECe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913083; c=relaxed/simple;
	bh=RqvhbOUuVkHBFuTqOZSYYAco6loxRFwaF3tkfLGrQj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGwvVLlKFLU/YRCs+rdOAH9ptuqFtg+QZw0wwNXoh9fKhQwFKN7As0IP5TfGubIeb/gAYhAE6yv4nhYILt71Kx7ukwC7fN2OLdZ2nTlqpflrzKAR5Mzong8Ryu5aZljBpdZGvGPtx+FMZ6ATyX0w154uhkzbHlXGeblclQ2OARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ/hp14X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ/hp14X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0523B1F000E9;
	Sun, 16 Aug 2026 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786913081;
	bh=j2i4BAMMq+r21cSKi5lo/JB9+D7moFrU4XD2jrsffbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oZ/hp14XxbXgexd1hPaIJ8WZOzr1yKeedjAP9sGDYgad790hNy9upJDZnV3ZS3qAv
	 0aagDDeNQ/iG6Nf1qhjebzenZc7UQqES01bJHwyispcB2WsuFcs5buImY181+dO3LF
	 5yjThECNGl5FtBBsGYxjNkvCXXSkdE4Bo7furTANWW88Uj/yzcJpttzIQIBDPqQKEE
	 hXK+YY756DAyr/oj4TcnkERHlONvepAnYcSbfaUnEBfr7Sni+SSkQkuiVMJJZUknHQ
	 hsOLDFj8WJiCk4cTk7lOv8BwxqQBCbxu7bdfLK/IC1kwiSnk+FdZ9pZVfCm5enzh8l
	 xPs1lu9lSQi7g==
Date: Sun, 16 Aug 2026 21:44:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: adc: ti-ads112c14: add filter support
Message-ID: <20260816214437.745d25bc@jic23-huawei>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 07 Aug 2026 19:19:45 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> TI ADS112C14 has several features related to filtering that are all
> interconnected. And to make things more interesting, not of the register
> fields map directly to IIO attributes. So this is one of those cases
> where we need to bend the rules a bit and just document it (we've
> already discussed this a bit in the previous series for this driver and
> came to this conclusion).

I've long forgotten that :)

>=20
> Here is the high-level overview:
>=20
> We are adding sampling_frequency, oversampling_ratio, filter_type, and
> a (new to IIO) settlingtime attribute.
>=20
> Since register fields have different meanings depending on filter type
> we have a quirky rule that if the filter type is sinc4 or sinc4+sinc1,
> then you need to set the oversampling ratio first in order to see the
> expected available values for the sampling frequency. For sinc4+sinc1+pf1
> it is the other way around, you have to set sampling frequency first
> in order to see the expected available oversampling ratios.

That's rather horrible...

>=20
> In other drivers, we've opted to store the requested values for dependant
> attributes like this and pick the closest available one when actually
> starting sampling. I opted not to do that here as there is not much
> overlap between settings. And as we will see below, there are other
> reasons for being picky about sampling frequency.
>=20
> We also discussed in another series about a proposed settlingtime
> attribute. The conclusion was that it should be the total settling time
> delay (in seconds) before a chip takes the first sample (after any
> settings have changed). In this chip there is a DELAY field in a
> register that programs some extra delay in addition to an always present
> fixed delay. So the way the attribute will work for this chip is that
> the settlingtime_available attribute will list the range including a
> minimum value. This happens to be the always present fixed delay. So the
> difference between that and the current value of the settlingtime
> attribute will be programed as the DELAY value. It also seems that the
> fixed latency period includes the conversion time. We've just glossed
> over that for now and not subtracted that from the settlingtime
>  attribute.
>=20
> Now, here is where things really get interesting/complicated. There are
> even more settings that affect the settling time. We defined the
> settling time as just a delay before the first sample. However, there
> are a couple of things that trigger the "first" sample. On this chip,
> the first sample only counts in continuous sampling mode. So only works
> as described when using the DRDY trigger in this driver. When using
> a generic trigger, e.g. a hrtimer trigger, single-shot sampling mode
> is used, so every sample is a "first" sample and has the settling delay
> added. This is mostly a non-issue other than it could throw people off
> that they cannot set the hrtimer frequency close to the sampling
> frequency attribute and actually get that sampling rate.

Whilst odd I'm not that bothered by this one.  Maybe some weasel
words about it potentially applying in other circumstances that
chopping or first sample.


>=20
> And there a few other idiosyncrasies we haven't accounted for. To keep
> things simple, we've implemented settlingtime as tDELAY + tLATENCY
> (datasheet values). But this actually include the conversion time as
> well. Also, tLATENCY is longer if you are coming out of standby mode
> (this doesn't matter at this point since we didn't implement power
> management, but we wouldn't want to change it and break userspace
> later).
>=20
> Then there is also input chopping where the positive and negative input
> channels are swapped in the mux in the ADC on each sample. In these
> cases, every conversion requires the settling time because the mux is
> switched after every conversion. And the actual first sample has
> additional delay (presumably does two conversions).=20

oh goody.  I wonder if that is standard in any sense for chopping devices?

> So the first sample
> takes tGC_LATENCY =3D 2 =C3=97 (tDELAY + tLATENCY) =E2=80=93 12 tMOD and =
every sample
> after that takes tGC_DATA =3D tDELAY + tLATENCY =E2=80=93 12 tMOD. For th=
is one,
> I have valued simplicity over accuracy in the implementation, so it is
> the same where settlingtime =3D tDELAY + tLATENCY and not worried about
> the 12 tMOD difference. I think it makes sense to keep settlingtime
> as a single tDELAY + tLATENCY in this case since the when the mux
> changes after each sample, the next sample is now the first sample after
> settings have changed.
>=20
> This sort of breaks the definition of sampling frequency though since
> in IIO, the 1 / sampling frequency is the time between each sample
> being sent over the bus. I don't really want to change how sampling
> frequency is implemented here though because the current values match
> the datasheet which can be used to infer information like where the
> notches in the filter are. The actual observed sampling rate will be
> 1 / tGC_DATA.
>=20
> Having written all of this out now though, I'm tempted to go back and
> change the settlingtime attribute implementation to be more accurate.
> In any case, tDELAY will always be easy to infer because it is the
> current value minus the minimum value (from the _available attribute).
> Then when using input chopping one could get a reasonably accurate
> sample period by taking 1 / sampling_frequency + settlingtime.
>=20
> We will follow this up later with a documentation patch that explains
> all of this too.
This is pretty nasty but not first time we've had to bend the ABI
a little. =20

I stopped reviewing later patches as didn't want to unwind that
misplaces snippet Andy called out.

+ there is quite a bit in flight for this driver and my backlog of
IIO emails is a mere 268...

J
>=20
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> David Lechner (TI) (5):
>       iio: adc: ti-ads112c14: support external clock
>       iio: adc: ti-ads112c14: add filter support
>       iio: ABI: add sinc4+sinc1+pf1 filter_type
>       iio: adc: ti-ads112c14: add settlingtime attribute
>       iio: ABI: add settlingtime attributes
>=20
>  Documentation/ABI/testing/sysfs-bus-iio |  22 +
>  drivers/iio/adc/ti-ads112c14.c          | 859 ++++++++++++++++++++++++++=
+++++-
>  2 files changed, 862 insertions(+), 19 deletions(-)
> ---
> base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
> change-id: 20260807-iio-adc-ti-ads112c14-filter-support-8a56850f590f
> prerequisite-change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1=
580754609:v3
> prerequisite-patch-id: 0be96266a72458a63f7da7ca876d87cdf5769a8b
> prerequisite-patch-id: 32ba48fd5eacaee60d50a0272557859cc9ea83ca
> prerequisite-patch-id: c1eb09689bd5f259ea0110cbbfb3fa76689bdb04
> prerequisite-change-id: 20260724-iio-adc-ti-ads112c14-burnout-18430466916=
5:v1
> prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
> prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993
> prerequisite-patch-id: ed5d4c1628ef60ed542339fe5fb490383ee8074f
> prerequisite-patch-id: b92f5609fcf39e958e78b4dd74c3d323ebb6a161
> prerequisite-patch-id: 755be140432ee53c84c3a4112dc8a42d78dfd01c
> prerequisite-patch-id: e89fe89cd6ceae3d875219611372a6d48bf0e064
>=20
> Best regards,
> -- =20
> David Lechner (TI) <dlechner@baylibre.com>
>=20
>=20

