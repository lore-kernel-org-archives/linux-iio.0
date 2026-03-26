Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9F33CEBB;
	Thu, 26 Mar 2026 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556531; cv=none; b=S6wvnv8GidaeyNlX7ukidIwbLzeSXvAh/AcynhfeshmSyMFX617oX4OAxnG4NoA0K2SjBQFhKmnMEc3CcUOsqCXnqAXBXf7oi+A9ym3XqGIqOzWB7y9qIfdsE/TBgxLHY6CR4CKyHL9Y/5iF0smumI+KZOZV/waiImTPXv7Fv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556531; c=relaxed/simple;
	bh=5bJsGWMV/dZKOnAYV4yBrsthY/VX0YpUGNd2DCyOjGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlsxWhfQUPZKlSxZRHtiMMPtoAcbwYSybYYfvvi58H/Y7yEtx4REhVuF27rgCqflqmKpq7qbwUY1WpvqvamTiljV8M9UozoPZHca/orKWae6wyJCZ/rRnhvzxaSTDSvmFYY+EctykZ0rYaVSibmwHmzdbFvqKIWcgt7giXXf0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUiuVs5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUiuVs5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703C0C19423;
	Thu, 26 Mar 2026 20:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774556530;
	bh=5bJsGWMV/dZKOnAYV4yBrsthY/VX0YpUGNd2DCyOjGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AUiuVs5v96EEx3bjw4n+crXOHVRU+UcaCSlMFIH4OmPu5uLVgRtDLN+nCRYoLi9uI
	 NG9Qle2KHMVSmXJFjjydGjK08lwmKzMqKRNM+dALFvWPx0Izr/uhLsMFY/bNAEj5nU
	 MCXvm4Zrr4V7tRNmZ3yY8k0Cy2goQjKyKIzvTHVBiHq7IFrXxLr2Fx9EncrN5CylSl
	 gt+NprrWcQXPa/9ZoVaOFvFc1W6+KK19Jl2qEEwpsq0c5aDhGQZ5xRe94I7KavuaI4
	 //9LXvxpcjNP1M3fb+Zg2Q8pQ0hOaJ75Q6jpABtKj8dCGgwTmaoVtkyKRJLefcrJsd
	 VAWju+8HeHM5A==
Date: Thu, 26 Mar 2026 20:22:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina2xx) drop unused platform data
Message-ID: <20260326202202.69510f44@jic23-huawei>
In-Reply-To: <CAMRc=MfYixLYcYz20dv9Afek77b3cqQh7nne93WLOusHnyJKMA@mail.gmail.com>
References: <20260326-drop-ina2xx-pdata-v1-1-c159437bb2df@oss.qualcomm.com>
	<a4661a50-1419-458f-a0f9-a9d9f6f59177@roeck-us.net>
	<fd613c1d-c9c0-464a-ab1f-16bfe20e122d@roeck-us.net>
	<CAMRc=MfYixLYcYz20dv9Afek77b3cqQh7nne93WLOusHnyJKMA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Mar 2026 14:24:20 +0100
Bartosz Golaszewski <brgl@kernel.org> wrote:

> On Thu, Mar 26, 2026 at 12:33=E2=80=AFPM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> >
> > On Thu, Mar 26, 2026 at 04:28:16AM -0700, Guenter Roeck wrote: =20
> > > Hi,
> > >
> > > On Thu, Mar 26, 2026 at 10:30:00AM +0100, Bartosz Golaszewski wrote: =
=20
> > > > Nobody defines struct ina2xx_platform_data. Remove platform data su=
pport
> > > > from the drivers which still have it (it's effectively dead code) a=
nd
> > > > remove the header.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcom=
m.com>
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com> =20
> > >
> > > Thanks a lot for your patch. Checkpatch complains:
> > >
> > > CHECK: Alignment should match open parenthesis
> > >
> > > No need to resend, I'll fix that up.
> > >
> > > Applied.
> > > =20
> >
> > Ah, no, I can not do that. You also touched drivers/iio/adc/ina2xx-adc.=
c,
> > meaning I'll either need an Ack from Jonathan or the patch will need to=
 be
> > split.
> >
> > Guenter =20
>=20
> Yes, sorry I should have mentioned it. This should go through the
> hwmon tree with an Ack from iio maintainers.
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

I have one patch on this driver queued on this driver, but the patch seems
to apply just fine on top of that so hopefully the merge will be automatic
/ trivial.
https://lore.kernel.org/all/20260315182304.613783-1-git@chuang.cz/


>=20
> Bart

