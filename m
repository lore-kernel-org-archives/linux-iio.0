Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B692C11F3;
	Sun, 22 Mar 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181190; cv=none; b=bnSrFSvlQEwcaEeL1GEaLw9QkA/FfDW2p/XeZxSI4y8q87zF1VXb01TE0qM15PBejlYah+iL2MOLgpbsq3tQHzJCEPaF/Wvn/AQuxE41V1o0J8RJ/GjtUCmozf6wdtI2T6AyX1xFubr770aBj4tMJYqWDvDuHyxOq0pkFF8RN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181190; c=relaxed/simple;
	bh=dZ9gD+DMUsKDGu9hoskcxNTy0Xk8K0Sxcn1V8b1mhp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/MyToqkSVa4HossjyZVSFjM4oYuJZTisj6vR4PRwo97Al872SgN9Tsi6sHY+qjRjTZdBFOvzLZPYwH6Eg2DXM34AJPE94xEz4f0IlyijmCnR0puY5JcWOV4VBp+OVe6d0wtWhRDEG1f/nLK64jW3ahnUFp0VCRyMu2Fl+RFuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrh+/vFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrh+/vFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F037C19424;
	Sun, 22 Mar 2026 12:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774181190;
	bh=dZ9gD+DMUsKDGu9hoskcxNTy0Xk8K0Sxcn1V8b1mhp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rrh+/vFKqKZa6J0PltZ8Phia+4bSQjpzOpUExkjpJc0VlaBAcr9byqSk3Aud1kwvM
	 1yK32Mw+Byx2p/fpb5qExQxa2hzUhaCdlCREsUxEPfKmX5HiHjiF/wj4D2t6Tl61xl
	 iOvykX+FzpMrEegfeZqXibJyhwisJEnaiFSVSG+NWkmec3Pps8f+0wdHFj4LnjZ0iN
	 HpmZP2AghQ957OqC0zK4PvfH4kOHdh0bYDbZJJMVTo2jRIrDevN2hYr6YCdAzGMNIl
	 skxyrvKXNdnuA1TP7fkCq5/RuG22vJrPuXGm9fkpvJRE4tC7wmMNlCkxrPL+Puom5r
	 tWbgJcOaQPM2g==
Date: Sun, 22 Mar 2026 12:06:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: ShiHao <i.shihao.999@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 marcelo.schmitt@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, till@linux.com
Subject: Re: Request for guidence
Message-ID: <20260322120621.5eaf627f@jic23-huawei>
In-Reply-To: <abD572bpEU8f9Uil@fedora>
References: <aapjuiq0JSVWfmWA@fedora>
	<ebb8bcb5-660c-409c-89b1-d473ba5140d3@gmail.com>
	<aa_yTUNAmkOUnN7j@ashevche-desk.local>
	<abD572bpEU8f9Uil@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 10:43:19 +0530
ShiHao <i.shihao.999@gmail.com> wrote:

> On Tue, Mar 10, 2026 at 12:28:29PM +0200, Andy Shevchenko wrote:
> > We are already in the relevant mailing list, so if ShiHao wants to work=
 on IIO
> > drivers, welcome! =20
>=20
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20
> Hello,
> 	First of all, thank you all for your time and responses. After
> 	learning that the IIO driver development project will not be
> 	part of this year=E2=80=99s GSoC, I shifted my preparation toward the
> 	DT binding project idea since it aligns with my driver development
> 	goals and Thank you, Andy, for letting me know that I can still
> 	work on driver development. However, I still have no clear idea
> 	how to get started.
>=20
> 	My main questions are: how should I begin, which sensors currently
> 	need drivers, and what happens if someone else is already working
> 	on a particular driver? Would it still be possible for me to
> 	contribute?

For devices that need drivers, best bet is normally to see if a commonly
available part with a break out board (to avoid having to design and build
circuit boards!) is not yet supported.  Works best when it's something
you are interested in.

Other alternatives that can be good places to learn are around modernising =
or
debugging existing drivers.  Either get the hardware if possible, or
another useful skill to learn is how to emulate that hardware.
Personally I tend to do that on QEMU but that's because I'm more familiar
with that than other alternatives.=20

Other than mechanical changes where we can easily see there is no functional
affect I wouldn't advise trying to work on drivers unless you have good
emulation to test against.  Doing emulation for a device that isn't current=
ly
supported is also unwise because it's hard to know if it is right without
getting that thoroughly reviewed. As such it tends to be most helpful when
you can assume the existing code works, test the emulation using that and
then test your refactors and updates.

Jonathan

>=20
> 	Therefore, I would really appreciate some guidance on how to get
> 	started. Any help would be greatly appreciated. Thank you all again.
>=20
> With sincere regards,
> Shi Hao
>=20
>=20

