Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687A2C028F
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471247; cv=none; b=pHZtH7ZK5KB8bMOfOnchfxwd+xdAwcSODHm5I6vKCZvpLEdYcViYGhyZmG8gAESljKL23aYbfTGCnKR6AfGbFQ6bJ4/RWDi7FqQtBTiX6T3bU+IufczwnwdibNqldFsfxa+ECetObCA8sSzZBeR5YLrdSHJJL0NUb3YBoIRuKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471247; c=relaxed/simple;
	bh=DIHQgGi72WdPRB84V4f4Mbe1blK5OraEA03HnTeRnKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXcDWLpK4A/ILxLaEernMSFHtwo/i0KVqFbphNrjFRpLc70HJYc/SI2O9kfCJE71Vhs24r4hB+uHqSkmwCKiBQ0cdoEEYe9+sI1xQ2fnBnf82HTHFlkEZTmA3QNutc3VHwjT5NMXpCDTTj2ZGIQzGP1Jw6W2qpF1T88BDx5NzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccJ42U2A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccJ42U2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06106C4CEF7;
	Wed, 25 Mar 2026 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774471247;
	bh=DIHQgGi72WdPRB84V4f4Mbe1blK5OraEA03HnTeRnKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ccJ42U2ATIR8tK14VtaykVA3TfeJ30YSzUjQDtEf7CPJmezkdNTgDdgeYufMf3an4
	 Cn781I+/04jXXLzbBKaWIUpj+iun0kIBrWNd9ApSXJwIfAhd4Slo5HE1la/vuU/7nT
	 k9iSPhbQQ7QAevLKI/EUIVhjoKvyiue19wFUSqrwd++D7wiw9laxQv5X1gSGi1p3oE
	 WzfiRqANR7qZk8PuVliKvoMRN5/T8cLygbYypCOAbxVeuGonMGnlfxOeaCBXsYdy4N
	 lX7lbWNaAdpTMgpIkob7TV4e9yHwgBhLgYGq7bmgxm0ndBhkAgtqSadU1aYcny/j/q
	 Slf3WOQ19ITUg==
Date: Wed, 25 Mar 2026 20:40:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: Format block comments
Message-ID: <20260325204039.582cce84@jic23-huawei>
In-Reply-To: <CAE7dp2qUM3Sza1endobT44VqAdwoBFqXb77MAfaFK1h8tJkOGQ@mail.gmail.com>
References: <20260314111250.223788-4-giorgitchankvetadze1997@gmail.com>
	<abfVKws8hF4bUbv5@ashevche-desk.local>
	<20260321210833.7268a3b1@jic23-huawei>
	<CAE7dp2qUM3Sza1endobT44VqAdwoBFqXb77MAfaFK1h8tJkOGQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2026 11:20:51 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> On Sun, Mar 22, 2026 at 1:08=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > Anyhow, applied as is without confirmation of Andy's question one
> > way or the other.
> >
> > Thanks,
> >
> > Jonathan
> >
> > p.s. I'm favouring clearing patches this weekend even if not
> > necessarily perfect. =20
>=20
> Thanks Jonathan, and thanks Andy for the review.
>=20
> I haven=E2=80=99t done a full sweep across iio/adc yet; this was a local =
fix.
> Given how broad this kind of cleanup can get(fixing formatting in
> multi line comments in the entire iio/adc directory), I assumed it
> would be preferred to keep the scope limited rather than risk missing
> cases in a larger series.

How big is it looking?  I wasn't expecting these to be particularly common.

Jonathan

>=20
>=20
> Regards,
> Giorgi

