Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019A36897E;
	Sun, 22 Mar 2026 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181299; cv=none; b=PsB8PFhw/aY739DnjwUrKyxaOlQxPr3I6DAtgoVKm/dwrIl1Ac8HIWlkQjKhPq3eXkDo6TZuhc886tOvz8Vv/3pPqLjTaGXyRdpNd0JiDe4lrH4v0vK1dx9FAMAskgkG0v9aHX1ztiGWb5oXx4ncgJhJ310il4/m2y3M6y53lTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181299; c=relaxed/simple;
	bh=BBnqDGxsqmTJAWTFAfi9gkdGcIx3QZvEsQYJ7GGYIEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESCYRuzVk5OpymcTaG/dgKb8yJ+mQhggKIFJSxsoVNM2yoKHli7TuzJfbgi5u8P/5612F3+5cY0eLj+ifvoQ7Tu7VPQGWvdBFL/M2tkHLyogQl74/FlflMCEcBYikJpmC8OkTvWvSsV9oGSBkBYbN8MCBBK9DimazHQwkf0XS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwlhZ1SH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwlhZ1SH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B031C19424;
	Sun, 22 Mar 2026 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774181299;
	bh=BBnqDGxsqmTJAWTFAfi9gkdGcIx3QZvEsQYJ7GGYIEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwlhZ1SH1MX2zzQ7JYVUM+nS6ZKm1wWWcqHpkVNR1mEjChgRIa1KQtJIdZQCoPChB
	 C/xtlR4lIOM/FLRR9abmP+lB0ZNPPshQmEG45ZPG6rDz7ikv9SRGNCVQShWs9YClBU
	 1d9i17TQvru2kBMgIfoUPT7YDtu481vrVPN3yPsR945h+doEh9M5zdDb8tXeVo7G8E
	 61HfGhaL4NbniESXJO9iMCL73FGagGBWuCXKWN+ytMFGFukij151jU4h5UBLUmGd1E
	 db6q2GiYeHZMqpEulxzgY3nvibP6vVdMF764XzzAVyad4xG4ZZdIUflyYDoJIM+npG
	 MABYUhkrEU7Xg==
Date: Sun, 22 Mar 2026 12:08:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 tomasborquez13@gmail.com
Subject: Re: [RFC PATCH] staging: iio: ad9832: modernize ABI and remove
 dds.h dependency
Message-ID: <20260322120810.01ba87dd@jic23-huawei>
In-Reply-To: <CAPC4XCQC_JqdFXf5_OYBPk-KOcg_xDBo0N-s0uQie-t7wZHoFg@mail.gmail.com>
References: <20260305210347.120446-1-rougueprince47@gmail.com>
	<20260308183135.1de38062@jic23-huawei>
	<CAPC4XCQC_JqdFXf5_OYBPk-KOcg_xDBo0N-s0uQie-t7wZHoFg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Mar 2026 04:49:01 +0530
Bhargav Joshi <rougueprince47@gmail.com> wrote:

> Hello Jonathan,
>=20
> On Mon, Mar 9, 2026 at 12:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri,  6 Mar 2026 02:33:47 +0530
> > Bhargav Joshi <rougueprince47@gmail.com> wrote:
> > =20
> > > The AD9832 driver currently relies on legacy custom IIO macros defined
> > > in dds.h. This triggers checkpatch.pl warnings (NON_OCTAL_PERMISSIONS)
> > > and, more importantly, exposes a non-standard sysfs ABI (e.g.,
> > > frequency0, frequency1, phase0-3) directly to user space.
> > >
> > > This patch removes the custom macros and migrates the driver to stand=
ard
> > > IIO API mechanisms:
> > > - Standard attributes (frequency, phase) now use info_mask_separate.
> > > - Non standard specific toggles (frequencysymbol, phasesymbol,
> > >   pincontrol) have been migrated to an ext_info array.
> > > - Remove dds.h header dependency.
> > > - Pointless frequency_scale and phase_scale attributes are dropped as
> > >   suggested by Jonathan in
> > >   https://lore.kernel.org/linux-iio/20251231180939.422e9e62@jic23-hua=
wei/
> > >
> > > NOTE: This patch introduces an intentional ABI changes. The non-stand=
ard
> > > attributes (out_altvoltage0_frequency0, etc.) have been removed. They
> > > are replaced by standard attributes (out_altvoltage0_frequency and
> > > out_altvoltage0_phase). Routing to correct register while writing is
> > > handled by checking currently active frequencysymbol or phasesymbol. =
=20
> >
> > Ah I think maybe the discussions around this bit got confused as this w=
as
> > not the direction I was expecting it to go in.
> >
> > This doesn't align with the existing cases of how we do symbol selection
> > devices.
> >
> > Often the last thing we want to do is change the active symbol before w=
e've set
> > the value. We could have done a multiplexing write function but if
> > we had it would need to be separate from the controls on which symbol is
> > in use.
> > =20
> I initially thought multiplexing would help perfectly standardize the
> frequency and
> phase attributes, but you are right. Multiplexing would break
> hardware's modulation
> leading to unwanted glitches.
>=20
> While we can still use a single standard attribute by introducing
> separate freq_write_target
> (and phase_write_target) selector, but that will overcomplicate it for th=
e user.
>=20
> So, for v2, I should drop the multiplexing approach and keep
> frequency0/1 and phase0-3
> separated using the ext_info array.
>=20
> > There are a few examples of existing ABI for this in tree.
> > e.g.
> > dac/ad8460.c which has 16 different rawX outputs and a symbol to pick b=
etween those.
> > dac/ltc2644.c which has _raw0 and _raw1 for similar purposes
> > dac/ltc2688.c is similar.
> >
> > We've never added more 'standard' control for channels with symbol cont=
rols simply
> > because there aren't that many users yet.
> >
> > =20
> > >
> > > Testing: This patch has been strictly compile-tested. I do not have
> > > access to physical AD9832 hardware. I am submitting this as an RFC to
> > > see if these changes are acceptable, and to ask if someone with physi=
cal
> > > hardware could test thisg and provide a Tested-by tag.
> > > =20
> Considering David's valid reply: I would not be able to get hands on
> AD9832 hardware
> to validate these changes. So I am not quite sure if I should continue
> with v2 or not?

This sort of ABI update can in my view be safely done against emulation,
but for that you'd need to first emulate the device carefully then verify
that emulation (to some degree anyway) using the existing driver.

So up to you on how large a project you want to take on!

Jonathan

>=20
> Thank you for the feedback!
>=20
> Best regards,
> Bhargav
>=20
> > > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com> =20
> > =20

