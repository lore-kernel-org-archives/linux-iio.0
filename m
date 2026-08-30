Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF9481B1;
	Sun, 30 Aug 2026 01:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788051784; cv=none; b=gaqUbMrHrDp5PKCJBa4xdpUXK+ua9pkjGGe8ks9HRbAAq5QWRLvQRUdIk6jAcf1yhZRi9Xf+kYehdPTg6rTk4jxQXROV2zvPXXvDvDUyeDqfUOpP0EXqVUbDGVcht/gRZRqz70s90TZV/0E8IqfWqL3rBROWv7eEcJbjikzaKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788051784; c=relaxed/simple;
	bh=0JpLxTBbr4mZlrQMw8/bZfQC0EW2t25HDuVZfbIFd4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAHpE23/SVNWV/nWDxicRcMgkvQVVD4bdFig4YWRqgb0spgKM/9DmLu6BDmQKZGXyEHwkxHR0X2BxhapPiIxQLHOlTqVh49ntuzAnMVOoltD4NXdJ2178vYviFgrXyJ7+hayrOdYqPkwLO9f2B/dlqCI/peGU34jSATJgyVpfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXyla/hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXyla/hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682E11F000E9;
	Sun, 30 Aug 2026 01:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788051782;
	bh=0JpLxTBbr4mZlrQMw8/bZfQC0EW2t25HDuVZfbIFd4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NXyla/hnqRlV9hdxIfhXvkj9XvAGyFDccBkwRvzPS1rwwwZXSwuW0mBVDPi7L872a
	 en/QtRKchh8mdg9GPYQakR/F0EOke5aLJr0jZldVbLbNzZpQFgjRvPmLdY8REQh8pT
	 CcgJEMnDMD/N6sTH35inuDhKs9UGZFy+nJysg3QhzH0xelSdekcbYxke7SkqIGx4Z5
	 NHWBDor5GmlAsm0N9lptMInFn40LGQWVZZ5z1pu+yeajFNqJZgVRW3RBYX2bQPASH8
	 PrmtQX1spKv+CIczG//SXo9r0N7+wFJb6c7KYf1G+pbVVt89Pn254sLzkc5lMZGw4R
	 ues+smbcIAJPw==
Date: Sun, 30 Aug 2026 02:02:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 Anshul Dalal <anshulusr@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: ltr390: Remove stale TODOs
Message-ID: <20260830020258.2c94c3ed@jic23-huawei>
In-Reply-To: <CAHp75Vd=0pPVFRrMOiioaCnZS11=nKNe9op7J0xeuafOzqV5=A@mail.gmail.com>
References: <apFDQhk9TUoLnEZt@gmail.com>
	<CAHp75Vd=0pPVFRrMOiioaCnZS11=nKNe9op7J0xeuafOzqV5=A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Aug 2026 11:19:46 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 28, 2026 at 11:14=E2=80=AFAM Chang Yu <marcus.yu.56@gmail.com=
> wrote:
> >
> > Remove stale TODOs from ltr390.c. All features have already been
> > implemented by Abhash Jha<abhashkumarjha123@gmail.com>'s patches:
> >
> > [1] Configurable gain and resolution
> > [2] Suspend/resume support
> > [3] Support for reading the ALS
> > [4] Interrupt support
> >
> > Link: https://git.kernel.org/torvalds/c/13fad2607dad [1]
> > Link: https://git.kernel.org/torvalds/c/288ce72fb5fc [2]
> > Link: https://git.kernel.org/torvalds/c/14e0d914a855 [3]
> > Link: https://git.kernel.org/torvalds/c/7ca4b8957066 [4]
> > =20
>=20
> Link is the official tag, no blank line is supposed to be here. But no
> need to resend anymore, for this patch I hope Jonathan will make a
> necessary tweak whilst applying.
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

It was a touch messy as b4 picked up the fact there were tags in
the earlier version for Link and (I think) because of this blank line
it didn't match them with these ones so we had two sets of the same
thing. Anyhow fixed up and applied

Jonathan

>=20

