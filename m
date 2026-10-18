Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ADF49620
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290501; cv=none; b=PTydv1Td4/16MdvjwnZrfM3tRULvqhLNjPidL5x8meKRI6T3yMlLturrd/EJBsX12SptwvYuN0hj05nzzcwtF98VrucOXiqLhTmzINv+XUd41JyO8rOEx0Y7k7hN66pTf5BJhRAcVOmcUMjYzvJOA94RU8oS1Ww36uAqgsNtHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290501; c=relaxed/simple;
	bh=4Saf8qFod62mXJBIAE99vf5LYjYBcjX3c6Dj6IpAiZI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmX3YU3YaqmLdQP2Qz8F7fuEpJcc8scVT5fgjyVJZ5MaFpsdWI1GlFhNPbuhheRkuHRLiqYlUyLCPrG8BA6o/6rj+gLY9pVHhaUQ549XYeVM8v6Y+QeWj1N/cuMOJdaaxtGnAlArLgPwEECq8MFyngKTtEd4vC69A9VDh0Ai2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg; spf=pass smtp.mailfrom=ranostay.sg; dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b=MTVvXHxN; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b="MTVvXHxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ranostay.sg;
	s=protonmail; t=1792290488; x=1792549688;
	bh=zsloX7Myu5n9n5aLJJW9cXVPPUBmOOwxOk/2okl8WNg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MTVvXHxNqlDHnHOFQkkUHNERe4p3GTO6vUvyDo9QnDfL8r0jCyeyTZ90w3vgo3Lm6
	 9OJEd23Gt3iS0Wxd2dDHuqknj3tqRoVjN+Zva9zogafR3Gi2IdGu8JoBLhvETLhcTR
	 MysL4SFGhdMD+bMtzjk9DWCBpSGZsuoqFJK8GWoCg+lsjBdauP8J5N2H9vAabKr50b
	 +fHAnMuDQZsJ72sPiI9FPS2ziER3H2FFTUZUYovmjXsUY0Brld2Z4sXGkIgw3kvgA8
	 ATWVkpnoPS8YmB5uykDL1eoBeLBDc4LyQ7pmtSZHAX2UAZWXTyHhoK4e1KenfuHaQD
	 x3J0t048RRCbQ==
Date: Sun, 18 Oct 2026 02:28:01 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Matt Ranostay <matt@ranostay.sg>
Cc: Nikhil Gautam <nikhilgtr@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH 1/1] iio: atlas-ezo: Fix humidity channel read support
Message-ID: <XRg2Dn6qienpjl0S8WbVJ4nwMKQ5nppuPTJ6HVuSwZRjdn4lggdxaeY5vtQk6j5ihd3lJ_j58o3ypATqaNo1h1eqMdoLcPd6HBuh23ZvJIo=@ranostay.sg>
In-Reply-To: <20261018003129.533effef@jic23-hlaptop>
References: <20261012114553.3327-1-nikhilgtr@gmail.com> <20261012114553.3327-2-nikhilgtr@gmail.com> <as1G0yGQ5wKhd-dh@ashevche-desk.local> <ab328578-08a6-455d-a9bf-411aeb561c8c@gmail.com> <20261018003129.533effef@jic23-hlaptop>
Feedback-ID: 87502384:user:proton
X-Pm-Message-ID: 0449421d9271131f1c4884b2ff8b2c04051c3c58
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Sunday, October 18th, 2026 at 07:31, Jonathan Cameron <jic23@kernel.org>=
 wrote:

> On Tue, 13 Oct 2026 22:15:23 +0530
> Nikhil Gautam <nikhilgtr@gmail.com> wrote:
>=20
> > Hi Joshua, Andy,
> >
> > Thanks for the review and feedback.
> >
> > I checked the Git history and found that the channel type check was
> > already present
> > in commit dc3ebfc ("iio: chemical: atlas-ezo-sensor: add humidity senso=
r
> > support").
> > It was not removed when humidity sensor support was introduced, and
> > I couldn't find any commit message explaining the original intent of th=
e
> > check.
> >
> > Regarding the potential I2C read issue reported by Sashiko,
> > I'll investigate it and address it in a separate patch series.
> >
> > I'll also omit the cover letter for future single-patch submissions.
>=20
> Matt normally gets back reasonably quickly so +CC but I'll
> assume this is just one of those last minute editing errors and
> apply the fix in the meantime.

Yeah this was probably an oversight on my part. Since the humidity sensor s=
upport came later, and don't think I actually ever had this EVO sensor.
So the patch LGTM.

Reviewed-by: Matt Ranostay <matt@ranostay.sg>

>=20
> So applied to the fxies-togreg branch of iio.git and marked for stable.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >
> > Thanks,
> > Nikhil
> >
> > On 13-10-2026 02:15 am, Andy Shevchenko wrote:
> > > On Mon, Oct 12, 2026 at 05:15:53PM +0530, Nikhil Gautam wrote:
> > >> The atlas_ezo_read_raw() function rejects channels that are not of
> > >> type IIO_CONCENTRATION, preventing the relative humidity channel
> > >> from reading raw and scale values.
> > >>
> > >> Remove the early channel type check to allow both concentration
> > >> and relative humidity channels to reach the mask-specific handling.
> > > Have you checked the Git history on this change? Anything interesting=
 there?
> > >
> >
>=20
> 
