Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0023C00AE
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946097; cv=none; b=q/QxbCcsd2YgvPW9vfZTuWi6qP8r2N723q22O0+NvbylwkQWSirkozManwhdKMG3qw2bum9pl2RR4sI6aA2eCwUER4He9xRDAvIZobuouW/5LtcYVdfqRujaOutsBPvqgc4siFV1rW1eRw1qAYQ2CojzaWxw7RfOicFjWya7xzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946097; c=relaxed/simple;
	bh=wIAfE1GpKfdNQAfy/SrRGZHWQuXEFIp8Z4/FDgeL7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsKeQePWk4atPOuUrdA4zW5PfvjEAFKZIpPZMB6nkowqgv99wqpnrDoDPLOnCs3Ub4SMMkcB629Qccuknsqf/4yzQnfykZpXFLF8eXLdoXyqOr1Ady2po/6BU7XCim5kLJ47dKtjCe4U0skZP7bXLKldkNqfmOSIyZU5QFJ73P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slkrE1nB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slkrE1nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34D3C16AAE;
	Tue, 20 Jan 2026 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768946096;
	bh=wIAfE1GpKfdNQAfy/SrRGZHWQuXEFIp8Z4/FDgeL7pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=slkrE1nB7nd9NSfbqzxMiGuvbnhsdSSudxHdEMpAh36hMCOi5mqhdMkDiYll0qnsu
	 Zpz9v9mSagg5A/K3edheLq/qPmSKGHVrd/5IKEHVnNc8gsB2p+KinKeu45HaVaao7W
	 TID44d7y6A2v1s3nLtxLr5OpXS5Rv6ZT7whkPM9QVWPZ+Gpm9hr20BllXnjoJi/xYT
	 37dNcrY9WRPeA6SxBMmCJ2HRchoxU4IwtRl0penRWVyUfyz4DzYCgnFyam6ZshazFu
	 vEBjbVciDyo5a1GDIzrxuMHRUlW9r2M/dVI1pqy46yoXF2cbIFEQvrR/GCr6Lnavc4
	 hpzSqPbbvISnQ==
Date: Tue, 20 Jan 2026 21:54:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Sasha Levin <sashal@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 jorge.marques@analog.com, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] iio: adc: ad4062: Switch from struct i3c_priv_xfer to
 struct i3c_xfer
Message-ID: <20260120215447.737ff92a@jic23-huawei>
In-Reply-To: <20260120214430.00d1f726@jic23-huawei>
References: <20260119213617.745603-1-jic23@kernel.org>
	<aW8sk9mD-dOHeJZg@smile.fi.intel.com>
	<20260120095041.0000705f@huawei.com>
	<CAHp75VckpV8JWmJ7rwmSAVk71isd=d9J0JAOCjDjmsTH_3s4bQ@mail.gmail.com>
	<20260120214430.00d1f726@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 21:44:30 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 20 Jan 2026 12:03:57 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Tue, Jan 20, 2026 at 11:50=E2=80=AFAM Jonathan Cameron
> > <jonathan.cameron@huawei.com> wrote: =20
> > > On Tue, 20 Jan 2026 09:19:47 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:   =20
> > > > On Mon, Jan 19, 2026 at 09:36:17PM +0000, Jonathan Cameron wrote:  =
 =20
> >=20
> > ...
> >  =20
> > > > > Cc: jorge.marques@analog.com   =20
> > > >
> > > > Can we move this to be after the '---' cutter line?   =20
> > >
> > > When I really want someone to review / test I tend to put them above =
the ---
> > > so that I remember to poke them if they don't and I want them to be
> > > included in any follow on threads.
> > >
> > > More FYI type +CC below the line. Mostly I just add them to the send
> > > list however rather than having a Cc at all.   =20
> >=20
> > The trick is that you can add
> >=20
> > ---
> > Cc: ...
> > Cc: ...
> >=20
> > to the commit message in your local tree. It will be kept and
> > represented in `git format-patch`.
> >  =20
> I do. This is more pointed because I see it when I use b4 to pick
> my own patches up from this list ;)
>=20
> Anyhow, for one or two I don't think the commit log mess matters
> much.
Doh.  What I forgot was that for once, I pushed this directly without
going via the list.  Oops. All the stuff under the --- is there.
Cleaned up now.
>=20
> J
>=20

