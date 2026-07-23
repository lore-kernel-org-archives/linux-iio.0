Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BA24E4C3;
	Thu, 23 Jul 2026 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849840; cv=none; b=KAlsms79GZ2bG0Ui/nqxf4+T+bDQx+YAiXHk1+1qNnN9s6UsFZBwIRkq4IHZJZFgiNcPdsi+fe/r3tKMaubdXLHx/77cBnUG0CE4pZZNfpHSdaAsvDXfRDQQz8g141WVAbDvJQ8Jp/0ohbv1je6d+eeAeqPXca5IFasY7fJok/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849840; c=relaxed/simple;
	bh=3v+SxE/KKstVXvpBK+5VNoEaOQkbWcDWytrt2tyDUVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGdiqtQl1oApYgSvvPR+PVEt7crdZlb1FovDUfoHEny+DFiwNgZQpA8gwDwivgpUubT5xtlcwrROj4LowvEUFvt0wJu/pZIRhBp/nVTnNMdJHlGX6h270qliAQkETKGIVQLdIVVyEXc1u07tq97Hd/2md9fS3hr0dOTQ03dmaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1eWaRLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1eWaRLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7F31F000E9;
	Thu, 23 Jul 2026 23:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784849838;
	bh=nhTeM4jHx/QEYcJzygiAIFfhTA5RK4NPqEkW80RsJ/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U1eWaRLS93ufA1nLMgoDzd/IzL6vZRN40Mf5Ts9f0exWdwz/4gnvJcgQY7rxiRdL1
	 xsOB723PUYlF4x3IuszNIhGX8leOoUVCiRsL8kvssZFeLdBU5qwRaI3o28MAtGkMar
	 1yhUuLAVyMmagAPIwEQpmetpa00KuCuIuGDuShHpMYLQvSetwEwK7M3G2OLqLEGgOy
	 KW7ZWD4BtVZEbReAYbNTo1dtaxT+FjiKvK/6cGsZFFHw1ct8m9g7h4d9pXiiAOxKsC
	 mTnfr0aIbzoeFqI4Ycs1Sk+aU6/NeSzQ1Tx2ckyal5NlfZnhZdilfn79RhZlOHB9AS
	 wiSrjm6l364Kg==
Date: Fri, 24 Jul 2026 00:37:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
Cc: m32285159@gmail.com, andy@kernel.org, dlechner@baylibre.com,
 email@sirat.me, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxwell@maxwelld.cc,
 mazziesaccount@gmail.com, nuno.sa@analog.com, tduszyns@gmail.com,
 u.kleine-koenig@baylibre.com
Subject: Re: [PATCH 03/13] iio: chemical: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <20260724003714.4dc81d56@jic23-huawei>
In-Reply-To: <20260720074543.616062-1-panchuang@vivo.com>
References: <CAKqfh0HT3qxdPjw5s-5RrZUZmCyNbJbLDsQ9vaCYRXhj6X0KCA@mail.gmail.com>
	<20260720074543.616062-1-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul 2026 15:45:43 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> On 2026/7/18 17:11, Maxwell Doose wrote:
> > On Fri, Jul 17, 2026 at 6:24=E2=80=AFPM Jonathan Cameron
> > <jonathan.cameron@oss.qualcomm.com> wrote: =20
> >>
> >> On Fri, 17 Jul 2026 17:05:22 -0500
> >> "Maxwell Doose" <maxwell@maxwelld.cc> wrote:
> >> =20
> >>> Hi Pan,
> >>>
> >>> On Fri Jul 17, 2026 at 4:42 AM CDT
> >>> Pan Chuang <panchuang@vivo.com> wrote:
> >>> =20
> >>>> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> >>>> devm_request_*_irq()"),
> >>>> devm_request_irq() and devm_request_threaded_irq() automatically log
> >>>> detailed error messages on failure. Remove the now-redundant
> >>>> driver-specific dev_err() and dev_err_probe() calls.
> >>>>
> >>>> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> >>>> ---
> >>>>  drivers/iio/chemical/ccs811.c      | 4 +---
> >>>>  drivers/iio/chemical/ens160_core.c | 2 +-
> >>>>  drivers/iio/chemical/scd30_core.c  | 2 +-
> >>>>  3 files changed, 3 insertions(+), 5 deletions(-)
> >>>> =20
> >>> ... =20
> >>>>
> >>>> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemica=
l/scd30_core.c
> >>>> index f85cdd8bd84f..770571c21521 100644
> >>>> --- a/drivers/iio/chemical/scd30_core.c
> >>>> +++ b/drivers/iio/chemical/scd30_core.c
> >>>> @@ -686,7 +686,7 @@ static int scd30_setup_trigger(struct iio_dev *i=
ndio_dev)
> >>>>                                     IRQF_NO_AUTOEN,
> >>>>                                     indio_dev->name, indio_dev);
> >>>>     if (ret)
> >>>> -           return dev_err_probe(dev, ret, "failed to request irq\n"=
);
> >>>> +           return ret;
> >>>>
> >>>>     return 0;
> >>>>  } =20
> >>>
> >>> Please split per driver and resubmit and feel free to add =20
> >>
> >> For large and simple repeat actions like this it's a trade off between
> >> the noise of a lot of patches vs easy handling of any future conflicts=
 in
> >> backports.  Given there are 60ish patches if this is broken up, it is a
> >> bit marginal for which approach is preferable.
> >>
> >> For more complex changes I would entirely agree that one patch per dri=
ver.
> >>
> >> So I think I'm fine either way for this particular series.  One patch
> >> per directory, or one patch per driver. =20
> >
> > Just personal preference given multiple drivers and multiple
> > maintainers. I suppose either is fine but I would prefer it split for
> > this one. =20
>=20
> Hi Jonathan, Maxwell, and  Andy,
>=20
> Thank you for the feedback. I completely understand the trade-off, and
> I've been struggling with the same question myself: whether to split by
> driver or submit as a larger series.
>=20
> My primary goal is to make the patches as easy to merge and as maintainab=
le
> as possible in the long run. I know that different subsystems have differ=
ent
> preferences on this.
>=20
> Therefore, I would like to ask for your guidance specifically for the IIO
> subsystem: would you prefer one patch per driver, or one patch per direct=
ory?

For this change (not a hard rule!) one per directory is fine.

>=20
> Also, for directories with many changes, like light, would it be better to
> submit them separately in a follow-up series to keep the initial series=20
> more focused?

No it is fine to do them in this series.

Jonathan

>=20
> Additionally, I will also adopt all the other suggestions from this patch=
set
> and resubmit in v2.
>=20
> Looking forward to your reply.
>=20
>=20
> Best Regards,
>=20
> PanChuang
>=20

