Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C7472775;
	Tue, 28 Apr 2026 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400075; cv=none; b=NhcwbHKbKepF4ag9Nxr+OusntG95COFB3dcuK2xprhIU/FXq/ITpA/GxXmorHlHu3KxB30BiVvV/aavPeaf+MvLcWJQAOz1gLPIsilq93qxLjKLRYdbgCIOi3XoS42TngBzat5C/ZDHsQBCWgxzbmRZU6GNq4iV4WC0qqEXaieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400075; c=relaxed/simple;
	bh=qULRWw+IldPy9wDV2saJGZ0ZQDCI0L9NM7/4IKcoXZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8BDcTWj7HHPuc9ob3IQmAqEdw4nW3BCLvNz+65LXq1V+9LFdof5ksTnqlQFVQWY8pgyuiLjHaoMiIeYdPdmDiTTHgV1deCeGMw/YwA0SBpAPAdWZiaGBEQ18RbsTcr+2tE6+dXogNxw2gcPpijfNLogCO5b5yqVd+03mp4Uudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIu8EKnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIu8EKnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54F3C2BCAF;
	Tue, 28 Apr 2026 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777400074;
	bh=qULRWw+IldPy9wDV2saJGZ0ZQDCI0L9NM7/4IKcoXZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LIu8EKnvoiC7x8POwgI1tGqnvsrjsZeZKmp6oIo57aobvGWH6GXLms0FvfTniOC1a
	 i7o/aGKQSZ89R/pDD+KQSniUAFk2GrNb4muVdtrVsn4ZT+A4UMoLlErlsK4FX6UYSC
	 kxqd3gNNXNR0z5U3MtSslCFl79y8Rin8GPXCrAMRI4kWSbcgSVci0eJ8EPi3UsxYWE
	 UGN65tmyNo3HUHwk+fRGt9C5DjNPJVx7iovSJZJ/Qy9/SACM6/ud9I42yQxp2Zj/51
	 JfwiiR2DiKSVj6+6cGZAQ/MxRjcP1t+zVjRVasGHQ9I2kAmBVYsLI/Iv6FO73p4T40
	 ZiFT9EhiIOs2w==
Date: Tue, 28 Apr 2026 19:14:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7138: explicitly include <linux/slab.h>
Message-ID: <20260428191423.28888451@jic23-huawei>
In-Reply-To: <CAE7dp2pUnDbEHPGvxVE5VkaYeV2rEWnTNfdqGaSy1DjZxge-Dw@mail.gmail.com>
References: <20260424081809.61841-2-giorgitchankvetadze1997@gmail.com>
	<aesyzOMUl2Iyjgjz@ashevche-desk.local>
	<20260424113600.4e76fdb7@jic23-huawei>
	<aetVGYQcq1NAJb7k@ashevche-desk.local>
	<20260424175753.2d0ca494@jic23-huawei>
	<CAE7dp2pUnDbEHPGvxVE5VkaYeV2rEWnTNfdqGaSy1DjZxge-Dw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 15:29:57 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> On Fri, Apr 24, 2026 at 8:58=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> > =20
>=20
> > > Why do we need to have kmalloc() here at all? I don't understand that=
. =20
> > Absolutely.  Locally it looks like length might be large and therefore
> > the array not suitable to be on the stack, but that's not the case.
> > length =3D=3D 2 so the array only has 4 elements and can go on the stac=
k.
> > =20
> > > =20
> > > > This function is just overly flexible. =20
> > > =20
> > =20
>=20
> Thanks Jonathan and Andy. I have sent v2.
Whilst you are welcome you've fallen into the process related trap
of being too polite!  Better to thank us in the change log of v2
and we all have one less email to check.

Note, pretty much everyone does this when they start working on the
kernel and so get this email once!=20

Jonathan

