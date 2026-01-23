Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B01329E49;
	Fri, 23 Jan 2026 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161460; cv=none; b=ImsdZaBLMTpIQeEG75xeSKT5gO87WwFTM5CEvhhQP8nkU25C2Wshd47peSX81yMpEPCly7Rqu2+Vu0jj5KHmql7je9PrKfjMWCJnweOuPTDm/YzbU926HkR76kVfiOcrzcuY8Ohorbrs8IV957+ySJRaxs0IvXhRYRWwyrBWeks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161460; c=relaxed/simple;
	bh=FhZzmS26gicogY2Q/fn5NyHqWd7aG6dJTam662tJrRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsXJCw6nrgKalH0BLqPEFPTSbNZd3qzyEnQ1UcS+snRHgOWTNWlT/2DMx30K4SQBED+TqQViO7SV0jI5TGEb1Twa7ww81EFp2zbnpnTk2sPdTy89bbcJOZxYowjGktMBjAW4cwaZWq+TWa8Gr4tDU58ZCTT9gkhTZPcapI2SBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO4Xys+M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO4Xys+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651A9C4CEF1;
	Fri, 23 Jan 2026 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769161459;
	bh=FhZzmS26gicogY2Q/fn5NyHqWd7aG6dJTam662tJrRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oO4Xys+MfDy070oQfOyhWRisXFD+WEz1j2ZdERZubZKnuCBCgwC10I33Kq0GwlBCq
	 YifE+wTSDfPuFj6WY6ICO9aivrSwXh/zKoNBn3mYxVuw8JZI5BXNZ18VfgGsk3nMus
	 mfeacILxw31jYn6bfYVpsd+k5V6UUpXt0nZs+wDPQ2zTEa8hgdGtrUN8ol1qyppknC
	 Q9SFCUiynEen6MKm8dux94QwI1oOlmkj1eQEtX9kiBFPf4pph4HMpK2D/Ojo78T4ni
	 5S7stTh8iIzwrvwKrQDmQG9lH3TDcgn2xR9BAYtDBcjbeRE/lX3pl8VkkgL4iQCEv8
	 874WzC6k6ka0Q==
Date: Fri, 23 Jan 2026 09:44:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Michael.Hennerich@analog.com, nuno.sa@analog.com
Cc: SeungJu Cheon <suunj1331@gmail.com>, antoniu.miclaus@analog.com,
 lars@metafoo.de, andriy.shevchenko@intel.com, dlechner@baylibre.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset
 mask
Message-ID: <20260123094409.111e971b@jic23-huawei>
In-Reply-To: <20260111120857.5087e396@jic23-huawei>
References: <20251230123609.210454-1-suunj1331@gmail.com>
	<20251230132126.217802-1-suunj1331@gmail.com>
	<CAHp75VdOX_h1Ksm4MbYyipiSpGrTp84GTkUAO9L_0o3auR3Xkg@mail.gmail.com>
	<20260111120857.5087e396@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 11 Jan 2026 12:09:25 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 31 Dec 2025 13:19:46 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Tue, Dec 30, 2025 at 3:21=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.=
com> wrote: =20
> > >
> > > The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
> > > twice instead of checking both SOFT_RESET_MSK (bit 0) and
> > > SOFT_RESET_R_MSK (bit 7). This causes incomplete reset status check. =
  =20
> >=20
> > an incomplete
> >  =20
> > > Fix by using both masks as done in regmap_update_bits() above.   =20
> >=20
> > ...
> >=20
> >=20
> > May I ask how you tested this? Logically from the code it sounds
> > correct, but I haven't read the datasheet yet, so I can't tell if this
> > is the expected value to read or not.
> >=20
> >  =20
> > >         return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
> > > -                                       !(read_val & (ADF4377_0000_SO=
FT_RESET_R_MSK |
> > > +                                       !(read_val & (ADF4377_0000_SO=
FT_RESET_MSK |
> > >                                         ADF4377_0000_SOFT_RESET_R_MSK=
)), 200, 200 * 100);   =20
> >=20
> > Okay, I opened the datasheet, and the below is what I read there. The
> > code first sets the SOFT_RESET_R and SOFT_RESET bits to "1", and waits
> > for them to be cleared. But the Table 43 does not mention that
> > SOFT_RESET_R is auto cleaned, and actually I don't see with a brief
> > look what the "repeat of" term means.
> >=20
> > And for normal operation they needs to be 0ed as per:
> >   "SOFT_RESET, SOFT_RESET_R, RST_SYS, and ADC_ST_CNV are the only
> > remaining RW bit fields not mentioned yet, and must also be set to
> > their POR state (see Table 34)."
> >=20
> > With that said, I would wait for AD people to clarify the programming
> > workflow here.
> >  =20
>=20
> Small kernel development process thing as well. Please don't send a v2 in=
 reply to a v1.
> It can become very confusing if we end up with a larger number of version=
s.
> Much better to just post a new thread for each version, and include
> a link back to the lore archive of the previous version in your cover let=
ter.
>=20
> Also from a practical point of view, it ends up pages up in people's inbo=
xes and
> so is is less likely to get reviewed!
>=20
> Thanks
>=20
> Jonathan
>=20
ADI folk. This is waiting for one of you to take a look at the questions An=
dy raised.

Thanks!

Jonathan

