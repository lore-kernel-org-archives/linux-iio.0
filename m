Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9833C3434;
	Thu, 21 May 2026 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363095; cv=none; b=FcH74mIs+SHDQoDjrDEFoXhmVwMVSWiWkf2mIwwozYq0OUYnJSVqzrXD76B3sABTMiz7U4447C00TlWm6pGuedcry+39lvy++cZn5RJkODOKsGV5eThhqCsW8shIJU5AHNSQYT5D9PyLvTTrohZHobS+kz1V9TNJgsqsFsPrM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363095; c=relaxed/simple;
	bh=azN7BJbKQrXNBIqnjQGFrjJ782DRpfncBxemk7SIoIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDbJy4FymLC+1KH0QS00yaisipe0kjjKJkk9GQ+I6xmXitU3Gz0GeP9Ha52pz/Ib+36mCAn0hbW9k+kmOe8FwUbKGACaoaUFAxYAMHqHeO3ktpJzoyM07+80PlOP4uWHT9XNRKVtLh9GRklhsNmYxmd03SLJ0Cb+dQzqVBWcAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QapwLD73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QapwLD73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EB01F00A3B;
	Thu, 21 May 2026 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363093;
	bh=PnNYpoO8Cvl1LC0thQiy1HYwVNEfqzP1Fv+pVlsE7Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QapwLD73V2UBGTt8kYiJfunNgatQiZS2eM1SpygOeN7pSdYDuIpaWrF0anmdARcB1
	 grLfNTF+QC/kLj+HZTtTUOvat1whPX8TSS+RknrftBEzPm0SQjeKRoV1lgnvtE8oGw
	 ltAaPMdSWAtMvnedtPobNnpDSv83NntKVv1IP0eyowxJuW2pphwElD0/EHkL6qin5U
	 7Qehueieu0e8NjjBTqb+Fd2PaMiDDV+xoqGq8d+U4za6ClawPil8kzq+yznMU+g7iq
	 YcOSv6oSQR9CN2JA3OzwlStDj8DrNGLp+ZGPwOlcv8LYZDmZz7at7lHYsUyP9wDai8
	 44Hqa4e/mikcw==
Date: Thu, 21 May 2026 12:31:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Aldo Conte <aldocontelk@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
Message-ID: <20260521123125.4000a67a@jic23-huawei>
In-Reply-To: <bfd9d999-57cb-45fc-a7e1-369905896770@baylibre.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
	<20260512223215.25596-6-aldocontelk@gmail.com>
	<agRfMWL9BughLT2x@ashevche-desk.local>
	<36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
	<agS70Dph8-zQT-e6@ashevche-desk.local>
	<20260515190517.70bb0ba5@jic23-huawei>
	<1c87362a-bba8-45b8-a836-153f468815c4@gmail.com>
	<20260516132555.64e27d62@jic23-huawei>
	<7f56ee25-11ad-4dcf-87bc-a353bed3f914@gmail.com>
	<bfd9d999-57cb-45fc-a7e1-369905896770@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 20:03:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/20/26 12:12 PM, Aldo Conte wrote:
> > On 16/05/26 14:25, Jonathan Cameron wrote: =20
> >> On Sat, 16 May 2026 13:04:13 +0200
> >> Aldo Conte <aldocontelk@gmail.com> wrote:
> >> =20
> >>> On 15/05/26 20:05, Jonathan Cameron wrote: =20
> >>>> On Wed, 13 May 2026 20:58:40 +0300
> >>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> >>>
> >>> ...
> >>> =20
> >>>>
> >>>> I would add for this that, to reduce churn it's fine to add the
> >>>> struct device *dev =3D ... bit and use it in new devm calls. Just do=
 the
> >>>> remainder in the follow on commit.
> >>>> =C2=A0=C2=A0 =20
> >>>>>
> >>>>> =C2=A0  =20
> >>>> =C2=A0=C2=A0  =20
> >>>
> >>> Hi Jonathan, Andy and all!
> >>>
> >>> Thanks for your reviews! they=E2=80=99re teaching me so much!
> >>> If I understand correctly, I need to wait a week before submitting ve=
rsion v3
> >>> such that other reviewers can comment right?
> >>>
> >>> I=E2=80=99d like to take this opportunity to suggest two alternative =
lists of what
> >>> version v3 might look like in terms of patch order:
> >>>
> >>> First option does not consider the "=3D=3D NULL with !" patch and so:
> >>> 1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug=
 fix)
> >>> 2. iio: tcs3472: sort headers alphabetically (same)
> >>> 3. iio: tcs3472: convert several functions to use guard(mutex)() (mod=
ified)
> >>> 4. iio: tcs3472: use devm for resource management (slimmed down)
> >>> 5. iio: tcs3472: use locale struct device * for remaining cases (NEW)
> >>> 6. iio: tcs3472: implement wait time and sampling frequency (revised)
> >>> 7. iio: tcs3472: move standalone return to default case (same as v2)
> >>>
> >>> Second version will consider it:
> >>> 1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug=
 fix)
> >>> 2. iio: tcs3472: sort headers alphabetically (same as v2)
> >>> 3. iio: tcs3472: convert several functions to use guard(mutex)() (mod=
ified)
> >>> 4. iio: tcs3472: replace =3D=3D NULL with ! (NEW, optional)
> >>> 5. iio: tcs3472: use devm for resource management (slimmed down)
> >>> 6. iio: tcs3472: use locale struct device * for remaining cases (NEW)
> >>> 7. iio: tcs3472: implement wait time and sampling frequency (revised)
> >>> 8. iio: tcs3472: move standalone return to default case (same as v2)
> >>>
> >>>
> >>> What do you think? =20
> >> Either is fine but swap the last two patches.=C2=A0 The wait time one =
is
> >> more complex than that trivial cleanup so might take more revisions.
> >>
> >> I frequently pick up the first part of series just to avoid people
> >> having to keep sending the same unchanged code to the list (that I've
> >> often forgotten about completely by the next version!)
> >>
> >> Jonathan
> >> =20
> >>>
> >>>
> >>> Thanks,
> >>> Aldo =20
> >> =20
> >=20
> > Hi Jonathan,
> >=20
> > I have two quick questions.
> >=20
> > First, Uwe's "[PATCH v2 0/7] iio: Rework i2c_device_id initialisation" =
also touches tcs3472.c. My series modifies the same file for unrelated reas=
ons. Should I wait for Uwe's series to land and rebase on top, or is it fin=
e to send now and let you handle the overlap? How does it work in=C2=A0 cas=
e? =20
>=20
> Just add a patch to your series that does the same change
> for that one file. Then it won't matter which one gets picked
> up first.
>=20
Normally I'd say don't bother unless you are modifying that specific code.
If there is an actual conflict (rather than lines moving around a bit) then
indeed having such a patch is good.

If minor conflicts occur I'll just fix them up whilst applying.
Gets messy if conflict between a fix and a non fix if I don't notice
it, but otherwise it is easy enough.

J
> >=20
> > Second, the first patch in my series fixes missing power-down on probe =
failure (goto err_powerdown). Do I need to add the =E2=80=9CFixes=E2=80=9D =
tag? =20
>=20
> Sounds like it.
>=20
> >=20
> > Thanks for your time.
> >=20
> > Aldo Conte
> >  =20
>=20
>=20

