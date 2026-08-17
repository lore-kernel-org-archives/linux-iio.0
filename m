Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847E4B048A;
	Mon, 17 Aug 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786928520; cv=none; b=m15jOOcJeHxZI8KY3S0y8ryC+0TowRWR5jo0XuQz92XoyF7zJCXnvnPV+BxcHsWwv8prvpIlLlDj8h6MjsmfdXBfxQAQCATuZd0Rwj97eV1lCraF7akUrBttoZQdg3l7b6Ip3MRW3fgkiPHSroNZmhEdxxIDI6NaWDtVKusFD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786928520; c=relaxed/simple;
	bh=4frgjuqHkosMGad0kq+eIDSE8OolDDjyaTJPzuhCBZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5U7913etgMZwZTDCX2538jEcx15lA93DXNo7xi9ztTkYBf5ntzRZbTcf1ZvQLmhs1frZLTlqjy+tnx5ykKtvUD2/7iwo9qG5nJvB/JjzWbR2Yr3Zve2pa/1aWtzodNISeRv8UkgsXpbm+QQj30CTZwf/a3cwR/AQ/kXgCNwdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8KDFsFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8KDFsFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF17B1F000E9;
	Mon, 17 Aug 2026 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786928519;
	bh=X0iLwTN4nRD/0Wvc9Lm2Q3RM1eIrbmA+BUjzF/mql2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O8KDFsFNoX0NvkKjN+J20EvyfkbudOvwpiLmcOElKWAeZG9L+L88mejK+C06VwzQF
	 nUUr7g9u0UeD+VjaPf58gpFlhAVvbBSvb0eaTEEj39VrUdaYaovNfBcGvMPjB3nlnc
	 I4UC5iHF0U0mJ08860xD8aIQh1mUmvMUTRz1MTjOqO/n5WgQmRuxqAU93OqG9lQ8W+
	 DZuYVFTEf1XPWTzppCeZvrshayM3ZxhQLKc4pwEUcR5yo3hF+14nLs9o2XcSko94nm
	 nRL1TcLYTIOLnou1kzCrV4L7OEDNnpK8m7WuN1k9+XN97LYbyBNkVMcAp+UNFgyEQr
	 izP0qoKL5udUw==
Date: Mon, 17 Aug 2026 02:01:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gQ8O0bmc=?= <congnt264@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1363: sign-extend bipolar differential
 channel reads
Message-ID: <20260817020154.343c5080@jic23-huawei>
In-Reply-To: <CAJpJ=GvyZLEwbAS_iZ1sU8tR_cu=uSRZPwsWqXSKFhHauy4nmw@mail.gmail.com>
References: <20260810064234.1850833-1-congnt264@gmail.com>
	<CAHp75Vfzb6cyrpfadfr3-UkNKVqNP1jsLMkmnozG9uqizt=thQ@mail.gmail.com>
	<CAJpJ=GvyZLEwbAS_iZ1sU8tR_cu=uSRZPwsWqXSKFhHauy4nmw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Aug 2026 23:50:53 +0700
Nguy=E1=BB=85n C=C3=B4ng <congnt264@gmail.com> wrote:

> On Mon, Aug 10, 2026 at 1:45=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Aug 10, 2026 at 9:42=E2=80=AFAM Cong Nguyen <congnt264@gmail.co=
m> wrote: =20
> > >
> > > The MAX1363 differential channels are bipolar (scan_type.sign =3D 's'=
) and
> > > the device returns those samples in two's complement. However
> > > max1363_read_single_chan() masks the raw value to the ADC resolution =
and
> > > stores it as-is, without sign extension. A negative differential read=
ing
> > > is therefore reported to userspace as a large positive value (for a 1=
2-bit
> > > part, -1 reads back as 4095). =20
> >
> > Try to make it more compact (remove unneeded or duplicative details,
> > do not blindly rely on AI). =20
>=20
> Done in v2 - trimmed both paragraphs down to the bug, one example, and
> the fix.
>=20
> > =20
> > > These channels expose only IIO_CHAN_INFO_RAW (no offset), so the raw =
sysfs
> > > value is expected to be the signed result. Sign-extend the masked val=
ue
> > > from the resolution bit for differential channels before returning it.
> > > Single-ended channels are unipolar (sign =3D 'u') and are left unchan=
ged. =20
> >
> > Same here.
> > =20
> > > Fixes: 168c9d95a940 ("iio:adc:max1363 move from staging.") =20
> >
> > This is a wrong reference in case the driver existed before (and that
> > is suggested by the commit description).
> >
> > --
> > With Best Regards,
> > Andy Shevchenko =20
>=20
> Right, the bug predates the move. The driver was added in 2010 by
> d1325cf45077 ("Staging: IIO: max1363 ADC driver"), which already reads
> differential channels with an unsigned mask, so v2 uses that as the
> Fixes: tag.

Trivial thing to watch out for - don't put anything a thread that
smells like a tag.  b4 tends to scrape them and if I'm not paying
attention (or like in this case my git hooks catch it) we end up
with bonus tags.


> Thanks for the review.
> Cong

