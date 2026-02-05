Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BCF2E7BB4;
	Thu,  5 Feb 2026 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321535; cv=none; b=odGW4BN0UKwF1DYi5UP1zW3fINlfwVNb490bVhb1HNUutYfBHiT/3JkLGD6jYWk0i1O7HAOt+Fw5N6uU2MPPJwfrkSI2JYBU2EtUQnBrgPsUUPFOdMO6O2mcHZO0t9ok1jF/h2lT/7QVCg3v6JEmCteV7qb6uTLhlvZmtIVF0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321535; c=relaxed/simple;
	bh=xZT1gmvI9n2/1ulV7CRcyy5PwX8cHsFkvcSudgyblXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+dKNJLK+SiKKhS1+nwJeZWf1eOrisS1520lz7hIG0okL9bKGMBJ/H1s1qaKcScmrjnNNUz72EiU2Wpj4+uY2OenMSK0w14zNYtCyBOch4+TD7AOESurnouAxt8gtPsXGTkeqFCkfo20gCpUVE6iYunHvfGrb8UnRhsS0unAsbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaLIRAWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaLIRAWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BA1C4CEF7;
	Thu,  5 Feb 2026 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770321534;
	bh=xZT1gmvI9n2/1ulV7CRcyy5PwX8cHsFkvcSudgyblXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LaLIRAWHvmA9Hs9NIx3OaJEamoZQJMEV0XmcGEd/zUFSoFR4smTkbjODbS6CfFpwM
	 yEpeDruXzu/lB/G5RAKSrLJ3fcvi/aqvQrc9a4OAKxZZYIVG2kw+1v8LkUkXMiQYDg
	 eeWsgcTMM6STloZM1/s0tfb1NBasxG3T0QFFOk+C7hCx9IEEecorXs2ZrAqHxXLbTt
	 pFeXxaDg6JkR2Rud+rpFFNeaHBL2G1TjqR/hBcuxJ1rcfDTbiQMAQ4wLFZy/l77CLc
	 WK37BgCXhjE0Jlwg5LOlF85oYza+aGn40NslGOv+0ZSwxsL8gNBLCdqhEbLXofGDZ3
	 ThzkrjpfbOsFg==
Date: Thu, 5 Feb 2026 19:58:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Andrew Ijano
 <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, David
 Lechner <dlechner@baylibe.com>
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration
 with devm helper
Message-ID: <20260205195845.4e108117@jic23-huawei>
In-Reply-To: <aYTPkt5jKoX3X_4i@smile.fi.intel.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
	<20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
	<aYTFUMe3jUO_bGCr@smile.fi.intel.com>
	<34bac81e-6a6c-4cf6-b370-beead4f705c1@oracle.com>
	<CAHp75VfSYGoNUTqDb9WLYNYeChkB4mM+LEBpyRVnLOEKkr==WQ@mail.gmail.com>
	<437592e6-460d-435d-bd83-7ff8222a6130@oracle.com>
	<aYTPkt5jKoX3X_4i@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Feb 2026 19:12:50 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Feb 05, 2026 at 10:30:31PM +0530, Harshit Mogalapalli wrote:
> > On 05/02/26 22:26, Andy Shevchenko wrote: =20
> > > On Thu, Feb 5, 2026 at 6:51=E2=80=AFPM Harshit Mogalapalli
> > > <harshit.m.mogalapalli@oracle.com> wrote: =20
> > > > On 05/02/26 21:59, Andy Shevchenko wrote: =20
> > > > > On Thu, Feb 05, 2026 at 05:12:13AM -0800, Harshit Mogalapalli wro=
te: =20
>=20
> ...
>=20
> > > > > > -    struct iio_dev *indio_dev =3D spi_get_drvdata(spi); =20
> > > > >=20
> > > > > Do you still need spi_set_drvdata() or analogue in the ->probe()?
> > > > >  =20
> > > >=20
> > > > That's a great catch, I don't see spi_get_drvdata() anymore after t=
his
> > > > series, so yes I think we should get rid of this.
> > > >=20
> > > > Should I fold that into this patch in v6, as spi_get_drvdata() is a=
lso
> > > > removed in this patch ? =20
> > >=20
> > > Ideally it should be done in this patch, but let's wait for Jonathan.
> > > He usually may tweak these small things when applying.
I removed it.
> > >  =20
> >=20
> > Also, while checking the patch now, I see I copied a wrong tag(RB with
> > missing r in baylibre from [1])
Fixed that up.
> >=20
> > So that's one more thing to fix. Let me know if v6 would be a preferred
> > approach, I can do it. =20
>=20
> Let's not hurry, wait for Jonathan to decide.
>=20
> > [1] https://lore.kernel.org/all/a5fa2f97-9ba3-4085-bfaf-a255d24a81f0@ba=
ylibre.com/ =20
>=20

And applied to the testing branch of iio.git.  Note this will be
rebased after rc1 is out before I push it out as a branch linux-next picks
up.

thanks,

Jonathan
