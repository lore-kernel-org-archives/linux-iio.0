Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AA28640B;
	Sun,  1 Mar 2026 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772367832; cv=none; b=O8plDOI+jxJg4VIDtd9nbKtGwgVCoF5S4DlkZ206PqDMAma6TQcR6KU5jPwt7musV52cXXCQ/M3n3UMszO9RRioJ9obBbh6FKXDQf1Rt8iJ0uwlJjdz8gbi92emnQnviMmqm7oPIyuCLrPhgiRglV3dpOCVTfcQhlIHSkH+rgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772367832; c=relaxed/simple;
	bh=B5RHnWouZGbSWRKvAJTvQTX52TqXg+P+s4M4a2aEP54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuxtSKum7/C3WBGBIBQkR0T9RkSZCtqJQyBwTbAom8AIyWgPMFV/D5Kb+Z7lNreprWcF2UwdIVE8XjMjgC2CeGGyQpARCJMLftrsYRKwoalu59Tqvogqca2e/9KCeZfdpLfGv3+OXPcZChkhiOX0lKfFmVET4wrlWS416klYyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRqQaxkl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRqQaxkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB996C116C6;
	Sun,  1 Mar 2026 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772367831;
	bh=B5RHnWouZGbSWRKvAJTvQTX52TqXg+P+s4M4a2aEP54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SRqQaxkl1c5qvEi3MWrQPTMCN4Hktj/5X40pwrkmaIhIq4Wdiq7MS0iKYdkuUtebB
	 3OkkAzGJnc16M5WmK5//QMdMVOSE6bADQhHi5FfixmPshN5x/VR+0FK+gOQGEox+GG
	 SR+MDqgSWl//mwx0kYPacgwEyKN4sYpR+vCcWDgB316T+stKEKOu91LhJ54loIx1Xp
	 JurezoT8ndzyF60cI9mPaxeFk4J90njUunDEXAenJXFMusobOQVopUiYo0Q6xzfdi+
	 UEw+A2EywqSdKgA0XbAspGkJnAxgDA6b8k4UxYI41snPAZsee1DlpiqQrTSOSTxbtR
	 2P8VjGaLAgkWA==
Date: Sun, 1 Mar 2026 12:23:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Dmitry Antipov
 <dmantipov@yandex.ru>
Subject: Re: [PATCH v7 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <20260301122340.3fedf64e@jic23-huawei>
In-Reply-To: <CAHp75VdSV2QDMR0DueCuP=Ds-5A1NsNjqPWtmRbG4NvoJ=LjXQ@mail.gmail.com>
References: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
	<20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
	<20260222172912.60a103c0@jic23-huawei>
	<aZwYshRxNgSh3CWk@smile.fi.intel.com>
	<zb752y7tnjzsc35na572o4sip6efwv3i4lha4ls6fhdrr52h5v@bfgy65cmae4p>
	<CAHp75VdSV2QDMR0DueCuP=Ds-5A1NsNjqPWtmRbG4NvoJ=LjXQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb 2026 12:41:45 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Feb 23, 2026 at 12:37=E2=80=AFPM Rodrigo Alencar
> <455.rodrigo.alencar@gmail.com> wrote:
> > On 26/02/23 11:06AM, Andy Shevchenko wrote: =20
> > > On Sun, Feb 22, 2026 at 05:29:12PM +0000, Jonathan Cameron wrote: =20
> > > > On Mon, 16 Feb 2026 15:02:17 +0000
> > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@ke=
rnel.org> wrote:
> > > > =20
> > > > > Add iio_str_to_fixpoint64() function that leverages simple_strtou=
ll()
> > > > > to parse numbers from a string.
> > > > > A helper function __iio_str_to_fixpoint64() replaces
> > > > > __iio_str_to_fixpoint() implementation, extending its usage for
> > > > > 64-bit fixed-point parsing.
> > > > >
> > > > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com> =20
> > > > Hi Rodrigo.
> > > >
> > > > This looks fine to me, but given earlier discussions I'd ideally li=
ke
> > > > to wait for a final review from Andy. =20
> > >
> > > It all depends on the series from Dmitry Antipov.
> > > Can somebody help reviewing the patch 1 there?
> > > https://lore.kernel.org/linux-hardening/20260212125628.739276-1-dmant=
ipov@yandex.ru/ =20
> >
> > can we push for the exposure of that function to kernel modules?
> > We have discussed that in v6, and I understand that:
> >
> > EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> > in lib/kstrtox.c;
> >
> > #include "../../lib/kstrtox.h"
> > in drivers/iio/industrialio-core.c
> >
> > is not a good call... =20
>=20
> Yep, because it's a temporary band-aid. The proper solution is to have
> shared code provided by the lib/. So, the wrapper to parse 64-bit out
> from the constant string literal should be part of the lib/ in the
> result.
>=20
> > > When it's in, we can continue on this one. TL;DR: for me this is on h=
old.
> > > But if you see the need to have the driver being in IIO, please add a=
 big
> > > fat FIXME to make sure we will get this all being sorted out in the
> > > (nearest?) future. =20
> >
> > I could add the FIXME into iio_safe_strntou64() doc header. It explains
> > the context:
> > =20
> > > + * The implementation of this function is similar to _parse_integer_=
limit()
> > > + * available in lib/kstrtox.h, but that header/function is not avail=
able to be
> > > + * used in kernel modules. Hence, this implementation may need to ch=
ange or
> > > + * removed to reuse a new suitable helper that is properly exposed. =
=20
>=20
> Up to Jonathan, I hope we can move the above mentioned series forward.
> Without that, as I pointed out, this one sounds to me suboptimal and
> unneeded double effort.
>=20
I don't want to hold this series for another cycle, but we are still
fairly early in this one, so some focus on moving that forwards seems
sensible.  If we are running out of time, we can fallback to a loud
FIXME and a plan to move to the generic version in the library next cycle.
So let's set a rough deadline of rc5 and see how things are going then.

For now I'm going to mark this series as "changes requested" in patchwork
and stop tracking it.=20

Jonathan

>=20

