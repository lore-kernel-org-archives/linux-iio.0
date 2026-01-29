Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB403273803;
	Thu, 29 Jan 2026 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711074; cv=none; b=qxK2oV0jOLNb2+zHvWQWrkHS2ICswsVLoOYqj/ExBZ4ChV0Uv9R4mQ9LdAO4FmxJ4MOQ6Z9LVi8pZxGm9QfRWGZ3Gfqii8GXGSO48q8qqFoXPA9MpGtj4H5TgoWDFTKq17MO1iqAzxhAEa//NMjKl2XlWfiT/O8OgSktqQECVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711074; c=relaxed/simple;
	bh=JNUcput7wLytfKldYqT97RMfdVuiojaMfiZdLUMOCWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/RVSvXXHD6QRfxZONL05x3IKAuzuF/XWP0JmiXLnqI3t7IVDa6HfVRlFvfMCbXfKVwvlu5ZY4/+EYUYiRYF1y1dpCmDMx8ZFElx14452pqUJ4CeMHyQxjfiYZIae6oGw9ZFtfZdIGFTu5vNE8MZQS6jZ6cAraa77n55r7k4Zp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l07dOdT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l07dOdT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D62C4CEF7;
	Thu, 29 Jan 2026 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769711074;
	bh=JNUcput7wLytfKldYqT97RMfdVuiojaMfiZdLUMOCWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l07dOdT6oby0Qk+9McnBZf5IYX9FtsbFKu3SRErnQF/aKPSTzFPwTENqS+x9vu1i9
	 mL2yTPaHWeEfoNkWysbptXT7Mk1i5+TZtL+ighOP0KieiIzEfA6e7VafGxl4+f41bz
	 eUJKsqxCj4LBsOCc3Xvz1wBoDUTQfe5s6+O4i//ip44/euoVLPKDC1WHn8xn0hObu3
	 Lev8Xn5Z65adrnERw3K6CylMNlRv07xzE2+khwj9zTL++rnmQJf0xM9eY7JLBkx9CA
	 USlueR4VXfh+XAtGrl0OCb8CmuCNTpGVuGfjIwT42nhg1gyXr3aprFdvb4NellvS7K
	 3U2nYjBAh0iZA==
Date: Thu, 29 Jan 2026 18:24:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Gustavo Bastos <gustavobastos@usp.br>, Andrew
 Ijano <andrew.ijano@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
Subject: Re: [PATCH] iio: sca3000: Fix a resource leak in sca3000_probe()
Message-ID: <20260129182424.2c0b1cfa@jic23-huawei>
In-Reply-To: <5703036f-fcff-4474-9adc-5b1438295b7c@oracle.com>
References: <20260128064953.2952714-1-harshit.m.mogalapalli@oracle.com>
	<aXnbcNYWaf2u9I4u@smile.fi.intel.com>
	<5703036f-fcff-4474-9adc-5b1438295b7c@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jan 2026 20:15:06 +0530
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Hi Andy,
>=20
> On 28/01/26 15:18, Andy Shevchenko wrote:
> > On Tue, Jan 27, 2026 at 10:49:49PM -0800, Harshit Mogalapalli wrote: =20
> >> spi->irq from request_threaded_irq() not released when
> >> iio_device_register() fails. Add an return value check and jump to a
> >> common error handler when iio_device_register() fails. =20
> >=20
> > LGTM, but I would rather converting this to use managed resources.
> >  =20
>=20
> Thanks for the review.
>=20
> I=E2=80=99ll follow up with a separate patch that converts it to devm-bas=
ed
> resource handling. Maybe that helps in a way to keep the fix and
> refactor separate ?
>=20
Yes.

> > So, if Jonathan wants to take this first,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > =20
Applied.

Not that often we get changes for this one. It was one of the
earliest IIO drivers. Anyhow, nothing wrong with modernising it
if you want to work on it!

Thanks,

Jonathan

>=20
> Thanks!
>=20
> Regards,
> Harshit
>=20
>=20

