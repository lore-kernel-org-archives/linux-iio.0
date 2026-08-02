Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8C2C11CA;
	Sun,  2 Aug 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689441; cv=none; b=EKoahjz7FVjFcRs+ltIossjSDWmebi0gPYFr6NIO8SMqzY65B9H1yoNUeeDaWmR6YoX5uoqghuVIQx/Ism0Pwrq7iIGUxylI1DjdrjDW0Hk/Wybfuex8ewd4zN4otvMFfBrvXN9kvjuFFv7SJw1Y1TN5mEbDgKVUvE7wfpDXnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689441; c=relaxed/simple;
	bh=tpNiPuwQ+MoVZLwrBnjMP5e1CjpSOhg+8Chtcm9qcAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCXzp57FplYJhpRQi+4zaooVJDc1tU9yGAItUcCUftDvK2OA6BRKbDNqios9vrV2z4P4U/S5I/cxNgGypNJIzKI+aJlBBvq8qQo81GF8kV2AH8uJVrsCVu+pr/+GGRijP11X/jIWK3e7BQGOynWSbQPfNpf3Ab8IEk5KzJU2m0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbAmQ5W3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbAmQ5W3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2EE1F000E9;
	Sun,  2 Aug 2026 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785689439;
	bh=I6uSqCKusZkPfne/Wfg3la3O6niFuwnjDwXPVVaVhG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HbAmQ5W3PiXLr+8G6xJ9/S9CWpelB5w0G7cNF4Qcw5cina4JrhdBPAvCXAQQCZoZV
	 ZEndESju3U9B346tMXcxIQJoXQEKjm0DuR7+WjtJLmtzJTTlTECTi8lXmvPPM/N2qp
	 6e8/JElVn5bDoxGyOqf+r9Oziv6SdHymEUb3KqSWyv2KxhN6LO7+f3raO8J/nIdYAk
	 6PHQrd/L1nFK1usbBJoGR0KGD6ZG+RhSSy+gr9pIoMF7C4j2QtI+h8DHs8xZbfKTO4
	 dJkisOn2UXXj1V7oqGzEHqZSP1M+VQMvYBssZ5kb1I0jdP8+4TqbhaAGO8y+9WCEs7
	 fKjyqtoqtzyYQ==
Date: Sun, 2 Aug 2026 17:50:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Adi Nata <adinata.softwareengineer@gmail.com>, joshua.crofts1@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, email@sirat.me,
 bhelgaas@google.com, mazziesaccount@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: chemical: sgp30: fix checkpatch warn to prefer
 __packed
Message-ID: <20260802175032.13aa14a3@jic23-huawei>
In-Reply-To: <am84xDCfJC7c-21r@monoceros>
References: <20260723235542.152a6a25@systembl0wer>
	<20260802025134.25319-1-adinata.softwareengineer@gmail.com>
	<am84xDCfJC7c-21r@monoceros>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Aug 2026 14:34:59 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> Just a few nitpicks. These might not justify a v3, as Jonathan sometimes
> fixes up such thing while applying.

There are enough things across various patches from Adi that I'd like
new versions incorporating all the various bits of feedback.

But wait a few days first in case there is more to come from additional
reviewers!

Thanks,

Jonathan

>=20
> On Sun, Aug 02, 2026 at 10:51:31AM +0800, Adi Nata wrote:
> > Change instance of __attribute__((__packed__)) to __packed per checkpat=
ch.pl warning
> >=20
> > Reported by checkpatch:
> > FILE: drivers/iio/chemical/sgp30.c
> > WARNING: Prefer __packed over __attribute__((__packed__))
> > +} __attribute__((__packed__));
> >=20
> > Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> >=20
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com> =20
>=20
> No empty lines in the S-o-B block, and please put your S-o-b last.
>=20
> > v2:
> > - Rename commit title and message =20
>=20
> the v2 changelog belongs after the tripple dash.
>=20
> >=20
> > ---
> >  drivers/iio/chemical/sgp30.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> > index f10bbebc29e4..c33592a1e0c9 100644
> > --- a/drivers/iio/chemical/sgp30.c
> > +++ b/drivers/iio/chemical/sgp30.c
> > @@ -82,7 +82,7 @@ struct sgp_version {
> >  struct sgp_crc_word {
> >  	__be16 value;
> >  	u8 crc8;
> > -} __attribute__((__packed__));
> > +} __packed; =20
>=20
> Otherwise looks fine.
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>=20
> Best regards
> Uwe

