Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45817B418;
	Sun, 18 Oct 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792281914; cv=none; b=X0oWjqxl8B0o9Y1M3TYC/68AMRgL5nFe6LJJ1Pgo0amQJlAx14Hv0Sf/t5rrpTFUGkKCwWdcPoz7WROlOQi4UZxu+Nd2ZIPU5kwVn/LlTvstFdmqA23tR0y6rN6nts4O9nSEJX7rDV09V/WVdVRZLq2Ad36YKVvP4JRz1NeoQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792281914; c=relaxed/simple;
	bh=XBCbGYHKngI90KUpEVBPFI8SZiujdPN0RzokHMQin18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfE8NjRgAxvSiWdDwSqxrc8tP9ewCGDJrRGl/2zWOFTdM8wwzucEayEtPwgcWY96KO+tsM40LNZDyQmDSDJv29u3xuoi/wAcXh1VT1lvoO3cW/O8g8HbbMusdaGLR+ojJLuSK2kASzVAFTrGUQAxa0sgpSSBBzNAs8QVyZMbzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGy+8lIP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGy+8lIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2E91F000C4;
	Sun, 18 Oct 2026 00:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792281913;
	bh=xMzD3gYMH9QJmtQljsNe5RN7lI1FbqX71rgxn6t17JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bGy+8lIPwd+6RFIf4HflZunjjiOYjxtSAj1T3Vtnplbp6RplMk1AZ853YcgiCvAFw
	 TwPW4twDcZ3t6wgPWSpk8PSGHKEhvXgmfEP0HtoravWoqRv8A7LB+2ZbT2G28HnVnc
	 0sWeiR8umXDzzrFYbngAVKZubZ7kGTcKCarbEKTm22zHcTseKNFIbIBTUxBE7eWvTO
	 9UK9uxI+/VPmq9N0pQZusJlUmEwuYKgIzlb1aayRrxprVDVZZcGZxy7KMy1JOKYOFq
	 h7Jku1rgDsyLKadxAmcdrlrD4DLdQevfdQ/XSyAT4U8NrLLFUOPuK2sgVPOdyRikmG
	 bY02jfZDiKX+g==
Date: Sun, 18 Oct 2026 01:05:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 raffaele.tranfaglia@gmail.com, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: use dev_err_probe() for
 ldac GPIO
Message-ID: <20261018010507.5a7b89d6@jic23-hlaptop>
In-Reply-To: <as1Qs5H5-SG3gik4@ashevche-desk.local>
References: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
	<aszvaazebS2NISxS@nsa>
	<as1Qs5H5-SG3gik4@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2026 00:27:15 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 12, 2026 at 03:35:30PM +0100, Nuno S=C3=A1 wrote:
> > On Sun, Oct 11, 2026 at 07:56:22PM +0100, Raffaele Tranfaglia via B4 Re=
lay wrote: =20
>=20
> > > Use dev_err_probe() when requesting the ldac GPIO fails. This
> > > avoids logging an error when the GPIO controller is not ready yet
> > > and the request returns -EPROBE_DEFER, and records the deferral
> > > reason. It also simplifies the error path. =20
>=20
> > Not sure what's Jonathan policy in here (or don't remember :)).
> > Personally, I don't see much benefit on this kind of patches. I'm aware
> > you might be eager to have something upstream but for staging I guess
> > the real value is in having someone willing to really cleanup the driver
> > so that we can take it out of staging (naturally that also means having
> > HW or someone willing to test it). =20
>=20
> This is a real fix for a (rare enough) problem. Without this it's possible
> to get your dmesg flooded with the messages instead of the useful logs, so
> I'm definitely in favour of taking it.
>=20


Whilst I'd love someone to take this driver on properly, I also don't mind =
taking
minor cleanup like this one.  This is one of the few bits of the driver tha=
t might
survive such a cleanup!

Jonathan

