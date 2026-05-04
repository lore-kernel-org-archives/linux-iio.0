Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C23783C7;
	Mon,  4 May 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913670; cv=none; b=SVccjNF5KnjCj5kG6K78qH5tGtyIUGS/iVAid7BrwNM4DpgjgTH23tFY+JQgo0r8XstQNFz5xBdDwN8oSMMIPu0Ls18shaRRihP2VZbpYGP7fphgn4UDdhfn3rEBZXm6CaE87dxifzo0EYpB5xy5iNFYF94uVkcydYZt5UEKKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913670; c=relaxed/simple;
	bh=EGOU/KH5Dp5DWRRE/3eHoNDZbWewaXlFQMfD6NcvqXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ut/AcSKjG3pZor2HN2nmO4U8FBVc53HGNLCZV2+wqVoy+OBw1etyNnp+Y5OVb4IZHgvd+IL2o2C2Ariy/eTUbmwTMMSZDtMUKblypEOlgVyK2ilhYWQGY9KFPkhe+dXV85yCsWSusnUO0N+Brh6giW4UbakOX4JnqaU9RApQ4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gELJBGCg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gELJBGCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6621C2BCB8;
	Mon,  4 May 2026 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777913670;
	bh=EGOU/KH5Dp5DWRRE/3eHoNDZbWewaXlFQMfD6NcvqXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gELJBGCg0R8U8o6zpZnnff0m+u6DMaNPjZ5zV0g70pzbw5Bq/q5753tWocJd7ZKvU
	 lPOnKBnH6T3eYwRIj7rP5jrCZXMNAdJ5KZ3HZY6RTWthSy4kRc5Hb2nVPF3aqP7ZwC
	 kheWdkpUIoqDXfEYwqeBnusJ+oIDHOQf0X1neg1zASpfG8MhmAcLmr84EjlEMjDYx/
	 mEepI742ic21R7u0GrbJSsAVSf19yXKO+QfWvS676GViMjOW41enBW0jEKAaca7RKb
	 SmlH/uYf/9nUR5SSXxKagUav8yY7+3qiJb2oI1j9pqNWAlt/tb2ZrvwYzALXUMx/Qh
	 MJ6qpHP+BbfmA==
Date: Mon, 4 May 2026 17:54:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Angus Gardner <angusg778@gmail.com>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, lars@metafoo.de,
 Michael.Hennerich@analog.com
Subject: Re: [PATCH v2 0/3] staging: iio: ad9834: driver cleanup
Message-ID: <20260504175423.2b0a9523@jic23-huawei>
In-Reply-To: <CAKqfh0FiqN3ztMxYRWasj8+2+z0wvYanrdfvze4z3U8YVcgS9A@mail.gmail.com>
References: <20260504092059.1536094-1-angusg778@gmail.com>
	<20260504162346.53668925@jic23-huawei>
	<CAKqfh0FiqN3ztMxYRWasj8+2+z0wvYanrdfvze4z3U8YVcgS9A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 May 2026 11:10:27 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Mon, May 4, 2026 at 10:23=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon,  4 May 2026 19:20:56 +1000
> > Angus Gardner <angusg778@gmail.com> wrote:
> > =20
> > > v2: Split into a series of three patches as suggested by reviewer fee=
dback.
> > >     Also add a missing dev_err_probe() conversion for the SPI init er=
ror
> > >     path pointed out by Joshua.
> > >
> > > v1: https://lore.kernel.org/linux-staging/20260502021815.3953423-1-an=
gusg778@gmail.com/ =20
> > Hi Angus
> >
> > Series looks good to me (Thanks Maxwell and Joshua for reviewing!)
> >
> > Applied to the testing branch of iio.git.
> > =20
>=20
> I realized I forgot to add my explicit reviewed-by to the v2 of the
> "use dev_err_probe() in probe function" patch. If it's not too much
> trouble, could I get my reviewed-by tag added to that patch? If not
> then no worries.

Added.

Thanks again Max!

Jonathan

>=20
> best regards,
> maxwell
>=20
> (p.s., feel free to call me Max, cheers)
>=20

