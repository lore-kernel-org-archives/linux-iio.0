Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59F42050;
	Sun, 12 Apr 2026 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776008988; cv=none; b=WP+2hI1StvoOt3soQ/oFKX7xinbqMhnWlA2RqaFm1ezQNA9PdMXoiuGYVHEfUzWuJVRhMcvIawManC3PaZytWeRusw+OdP12QPqQFGcN/fN4p59Q89tiwDeCa9yfnhtFBTGMLrUbzyAmgtt8wW5tL4Wdqr2iPEHj4vjT1vVm564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776008988; c=relaxed/simple;
	bh=qhXYTK6ZgvSF57qJs97YIcSWM/RnHWj+0N14Y8xo+zY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HE2ELa1aEAz6rfi+74/S2iK3F4tYVb02uEEjD4QMmKEmqSK/qOHkKENLwIKyNkBEqXH1IzXUWwLPMW6zy/V8sSbMphYStEIvBhW0JZOY2UQA2tzWBGeLOqBgxsPGlO9bBik7xK1Vbu3Gdi0IkD2maZi1ItpaO0B79ddp6Il8Z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boW5PAGI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boW5PAGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C8DC19424;
	Sun, 12 Apr 2026 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776008987;
	bh=qhXYTK6ZgvSF57qJs97YIcSWM/RnHWj+0N14Y8xo+zY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=boW5PAGIYVZiEOGRxY12gyFBS2ELVGaJd/gC+2MGoop3rFG8SKQJ7k/vHeSZ2D6eE
	 Bvs3jjW8zxJNDGpH+ZZJxXjlmr20xRfM2CxAx/gVq8+5ujstcNE7LoxPgM9h1Hg1ky
	 0kq1Ogpn+QmYHylvoNGQ1oapcy5q/cHSUMFVomgNZqYNyRFOVUkQzSkSRjKZgQ2bwi
	 xOe2nf5cStG0s1dDJBmyCLXtR/x+DzYMG2YT7hyO/YGATpBclaxX8y7wQpR3niEcvs
	 MEm7zYVL0BMvNBUglnBCuY5WkFjl5/HbG+8wbVcCezaFSyp96tSFpLyvoL694b0Dbx
	 wv2gucO8GF8SQ==
Date: Sun, 12 Apr 2026 16:49:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>, Andy Shevchenko
 <andy@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, Liam Beguin <liambeguin@gmail.com>,
 "Marques, Jorge" <Jorge.Marques@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and
 optimize chip_info
Message-ID: <20260412164939.068cbe9a@jic23-huawei>
In-Reply-To: <4c34f4f3-f3c0-403e-bf14-29403ce263b8@baylibre.com>
References: <20260331012457.9324-1-carlosjr.jones@analog.com>
	<CAHp75VfkdmebYjBdOnkqrT87Sm9PR8OehYvPSwwxiY9zq9hfbw@mail.gmail.com>
	<SJ0PR03MB5854F9BE63C740C8EDB18E24F4262@SJ0PR03MB5854.namprd03.prod.outlook.com>
	<4c34f4f3-f3c0-403e-bf14-29403ce263b8@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Apr 2026 13:48:05 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/10/26 9:27 PM, Jones, Carlos jr wrote:
> >>> This series adds missing read delay support for the LTC2305 and
> >>> optimizes the chip_info structure for better memory safety and effici=
ency.
> >>>
> >>> The LTC2305 requires a 1.6=CE=BCs delay between I2C channel selection=
 and
> >>> data read operations - a timing requirement identified by the hardware
> >>> designer that wasn't captured in the initial LTC2305 support (commit
> >>> 8625d418d24b ("iio: adc: ltc2309: add support for ltc2305")).
> >>>
> >>> Additionally, the chip_info structure is enhanced with
> >>> __counted_by_ptr() annotation for improved bounds checking and
> >>> reorganized to minimize padding. =20
> >>
> >> Now LGTM,
> >> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >>
> >> --
> >> With Best Regards,
> >> Andy Shevchenko =20
> >  =20
> >>
> >> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> >=20
> > Thank you for the review, Andy and Nuno.
> >=20
> > Hi Jonathan,
> >=20
> > Just a gentle ping on this series, it has received reviews from Andy an=
d Nuno.
> > Let me know if there=E2=80=99s anything else needed from my side.
> >=20
> > Kind regards,
> > Carlos =20
>=20
> FYI, Jonathan uses patchwork, so you can see the status of the patch
> at https://patchwork.kernel.org/project/linux-iio/list/.
>=20
> If it still says "New", then it is still in the queue and hasn't
> been forgotten. There is usually a lull after the -rc6 release
> until the next -rc1 release. Then things start moving at a normal
> pace again. So it still might a be a few weeks before this gets
> picked up.

+ over 2 weeks is convention before reminders... Life gets busy sometimes.
On this occasion I was on holiday - blame Delta cancelling my flight back
for making it a slightly longer holiday than planned!

May take me a week or so to get back on top of things.

https://lore.kernel.org/all/20260323112729.00003715@huawei.com/

As noted we are very close to the merge window anyway so I'm only queuing
up for next cycle now and nothing will hit linux-next until after rc1.

Applied to the testing branch of iio.git.

thanks,

Jonathan




