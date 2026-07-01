Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6150A224FA;
	Wed,  1 Jul 2026 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782868167; cv=none; b=Xb9u29FfndEYGNMKgcjDZdtU5S1c+W3emHH5/J+I8dNPV2vDVQ7KoBvuU+ag1Mf61+B90QwZeIHM41JWw20NjqFrDHGcSjz3BG/84SbWa+8WujInXiB0iVLks998fg4MIbEg/t4KNEzYbiPEpYS9z/qGfWq4w/69ruEWbEZ2iPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782868167; c=relaxed/simple;
	bh=jiIwxiv7d0RRAAbCsL0m5awSb5p+ZeMuiwx1DnNERXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTbHbCV5kmdzTyL7dAZ9aEni/1EAPpI9eUMqqB1oFqNjV0jGsDsGSet7HrXyaKqE88mNLd1XpJwTYXXJfb8cC5nM/MhgQt8H9wcffJiWQ23u4GDNUVxyHOXuAziLCpbQPIO9JBtH1c2AP+7e06QFPLFyKs79CPpWn4qHCNRUag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9LfO2tQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9LfO2tQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E341F000E9;
	Wed,  1 Jul 2026 01:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782868166;
	bh=WGEJ22NFXnQCMfezmrnWrhjXR1KVcCqgzikm3HRhU+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X9LfO2tQ0yDWNCZL8ilRaSbxjAuzTNUyQP4vJAMiJ06B9AsIOBLGF+9da1OLcHs7E
	 WlTBLu1f6edZgQ5wghY8VJT7JvcdvedJaZwEDyyMiBKnFI20nwC7RzvyQGNQch778S
	 wfGElYMgSxybaPC8H0xM2wF1W835LRls9pgOkvTHpS5FVMbE1f+QPOxrXGExE7QtwY
	 nScDgkaCKqhSi06kORhi/yLC85EaXTQDjRiCgtOLT91dkZJI2HcgNhcXgakhiAosWp
	 w0GUrzuNO9x77KFupHe3mfdYHBDqgfiz5lnBJt+0RKegxEiU7FpOEUL/RltITAofDl
	 Xsh/lBk2bC7Sg==
Date: Wed, 1 Jul 2026 02:09:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <20260701020921.6aaacb67@jic23-huawei>
In-Reply-To: <20260626162802.0000716b@gmail.com>
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
	<aj5v3rDRlY7H39Tq@ashevche-desk.local>
	<aj6EhyuOxBqDDf0X@nsa>
	<20260626162802.0000716b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 16:28:02 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 26 Jun 2026 14:57:05 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > I'm not sure we have a defined policy for that in IIO. Now that you
> > mention it, maybe time to ask...
> >=20
> > My understanding always was that Jonathan takes care of Ccing stable
> > but maybe he just does it and being nice about it, does not complain :).
> >=20
> > So, Jonathan,
> >=20
> > Should the sender take care about Cc or not? Or it does not really matt=
er
> > :)? =20
>=20
> I always add a Cc: stable when submitting bugfixes, only this time I
> forgot :P In the end Jonathan decides whether it should be marked for
> stable so he can just remove the tag if the fix isn't backport-worthy.
>=20

I do frequently amend for the presence of these (in both directions) whilst
applying.  Ultimately I don't care that much either way at point of original
submission.

Jonathan
