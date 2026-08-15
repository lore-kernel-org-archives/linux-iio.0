Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1C346E44;
	Sat, 15 Aug 2026 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786758315; cv=none; b=bwJ3DOn+2tdh2jKMe6pnjohHil/sy/ipO95+O0k5PbIuW53ALLZ4sAATR74h9e83UAhuHufgdYwKkin9V35cDB3v2pfr1bx/GaOS3X3JsW+5WiNIptMps8mJ3FHN8AFqVXZvIB4p6yLxxsDkyX2/UXewjVVTlHCeoJMjciHSG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786758315; c=relaxed/simple;
	bh=RwpxIv3nPzVp7IdhrXTbkAlkt9OeIpd/r2hKdRXlQds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uX/9F2Is9Y1/SoJbjLjnwwu/pAnR+vc6poTEMJLdi4eAz0EY1adnZwwLflxWrlXc9N40YeYr3qP027XEcNdhi0yHjPEEylD1UJfUDkuM6xDmAVDxu9J5ppaPigjJ1xyO7jR24RRytLu/OnEWD3Mc+Lord1JQnma9KiqL+dQCRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eyiii193; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eyiii193"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57231F000E9;
	Sat, 15 Aug 2026 01:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786758313;
	bh=RwpxIv3nPzVp7IdhrXTbkAlkt9OeIpd/r2hKdRXlQds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Eyiii193R1Y3nDPGd5lAubhDZwisGRqllhijW8eNf4IBR9s+HRa6LlyNCNwFHBX5x
	 FsiTN5oY0v22DZ9OCDB/hbHmUqHL36GMRXOH+YJpkwk/CM3f4KO01hPAWIpoFEldWm
	 uWrtfHX/RfBNLN2LTtfgMlvUT92BCERuQlRfCOrcz7vcmPSiV8Enc/uEAqMMKzDTiL
	 g27p6Cv46RjZx7GnmLm+sxhuVJs3sRYvoI2g0lqpNfeyYc9jarpw4IKvS30gtp573G
	 YFB8lDRH3OrIBw+yClAa9ZCpbJqRHlruraxf8tkPVebVcM2c5rKHnhSxvRF5DPv8dJ
	 OLu7Yn0i+mLZQ==
Date: Sat, 15 Aug 2026 02:44:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>, Conall
 O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v3 3/6] iio: adc: xilinx-xadc: Split driver into core
 and platform files
Message-ID: <20260815024457.39f531d1@jic23-huawei>
In-Reply-To: <ann-96_VVW6mGzJX@ashevche-desk.local>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
	<20260729125455.95893-4-DileepKumar.Nagavarapu@amd.com>
	<amuqm5qdzXqKutPS@monoceros>
	<ann-96_VVW6mGzJX@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Aug 2026 19:40:23 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jul 30, 2026 at 09:52:24PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Jul 29, 2026 at 06:24:52PM +0530, Dileep Kumar Nagavarapu wrote=
: =20
>=20
> ...
>=20
> > > +#include <linux/mod_devicetable.h> =20
> >=20
> > I wonder why so many people recently add <linux/mod_devicetable.h> in
> > their patches. Is there some tool that suggests that? =20
>=20
> My bet that this is AI agent suggestion based on the previous numerous
> recommendations to include it.

Given the number of years I asked for rather than of.h / acpi.h there
is probably plenty of training data - which was nice until Uwe tidied
this all up.

Jonathan

>=20

