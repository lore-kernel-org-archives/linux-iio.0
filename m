Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609843634C;
	Mon, 11 May 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519878; cv=none; b=mz8kFzeSSTQc2hXrkV/RaU8CUkqweBcreOpZ/DFBBbM7QlYwsEr9lvdQUo3cNOzlUHIkkf5EhzzCMIwyX120FJyljWi0toHD5RrHfSIXDbs23QOEw8y06QvWTt4gsqOVEjWiU8SoX3/DqgWB6IhPhPUeNDtbQL3Aou8ZnIFgTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519878; c=relaxed/simple;
	bh=U8s5ic5/MtFaJyM70Qban3slf9rOpj4DnN4LoDfAaE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJ4qNI/kcXDSgHB8QwyXJrSBJmLcwOSdL9ImFbFb307qKgKkoGbnB7qx6s0r9h9dB9Ln5Gs8LC7HK8iS+ByYkgVthCL1MBefC2FiY/x2f3KIuGN5AxTBYZXmOxVX1CRv3aFiR6IwuJpErDRO5Rh7quTlBZPGZQnroLDm5pRBF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZm+swJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZm+swJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4DCC2BCB0;
	Mon, 11 May 2026 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778519877;
	bh=U8s5ic5/MtFaJyM70Qban3slf9rOpj4DnN4LoDfAaE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cZm+swJe0ox3sLy/4VYkICVPhmaX3VyapBRIbaydvceMyX9oKRVaCdBV2NMr5fwEt
	 E84kUTdCksU6nRejRIaCK+26QkD2OHCFcSc6haVfaPup5YYrUpZUq3ktBAR0a2u9yE
	 fFSI4evyhVItpOVRfp+veuTuNEwT+wciPwSOohb36NOoFmVOJzIlZJr99eQHYcz1ML
	 CPKLmhtcdNwGkD6CUwS4YUuFN1ZmCQnKkYJQoZ5Lr9SLMFWWmcgqIFJhaesLDW59qK
	 qhUEtyIE2FG2YERoasnJmjJY+pKUOJeZOOS3mrhmDUyLhBFtug8NT4L5Pt1yf1lla4
	 zlomlx0TVIk1A==
Date: Mon, 11 May 2026 18:17:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "open list:IIO
 SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <20260511181749.32d64889@jic23-huawei>
In-Reply-To: <CAKqfh0ELaB7ifXNT3EkuC-K9s=V-mNgQ9WZt0ufVgmSD3xGQeQ@mail.gmail.com>
References: <20260507223337.48437-1-m32285159@gmail.com>
	<CAKqfh0ELaB7ifXNT3EkuC-K9s=V-mNgQ9WZt0ufVgmSD3xGQeQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 08:03:45 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Thu, May 7, 2026 at 5:33=E2=80=AFPM Maxwell Doose <m32285159@gmail.com=
> wrote:
> > =20
> [snip]
> > @@ -945,29 +942,26 @@ static int kmx61_write_event_config(struct iio_de=
v *indio_dev,
> >         if (state && data->ev_enable_state)
> >                 return 0;
> >
> > -       mutex_lock(&data->lock);
> > +       guard(mutex)(&data->lock);
> > =20
>=20
> Correct me if I'm wrong but this looks like a TOCTOU race, was
> reported by sashiko at
> https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40gmail.c=
om.
> If this is a confirmed race I'll get a fix out this evening.
Indeed looks like a correct report.

Take your time though. I'm swamped anyway so will be a while before
I get to any new patches (probably!)

>=20
> best regards,
> max

