Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A4346E56;
	Sun, 26 Jul 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096517; cv=none; b=nq1g4PFm8wPXlVNTfkI1MJdw4DkwfVE7uywZhvlty9Xk+6PVqMKyMlGSFzJFcjvqd3ZyLUc6DVbxtQEBEmeL9iSCVwGjsqLvbdTOJbSQGVsaG/OCaBqxd6Dwf443hZD77Shg75XNqP3Kxy8Z257oQm2t2e2Oa7zoCQA3SOfXEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096517; c=relaxed/simple;
	bh=OS8R3o8sPXu+5Er/VTsw3wTJ232UZm/BYLNhvoQPxpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/XI5gHYFXuUaHW73lhrIhXdg2gCM3JRLPRLdi3bzphvz4o6WI3tfnnNzK0LiGRb6Ftv//SVkrOf6mnDyrTnhdT3f9PWWZ824rfl/HICgyFSfp1IMnshAo+NmYYoUMWN1GU4sWrjblu9uMuR3Bsij0KG+3SVUwAcZMQe8b7oLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pruv/9Zq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pruv/9Zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C991F000E9;
	Sun, 26 Jul 2026 20:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785096516;
	bh=DzMZkhJoSysZDRCHgIZ0EewLtn9Oo7973j/pwjoT1dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pruv/9Zq55I9mCxkGVcHREPfvgUQwnrbHRQEIigAEtXRRWYuUwAstK9Q5UKGmivoH
	 3CI0iXIbJwpd6fQ5+2HEXKP0GNmdNDv6CRsm2vCMaOqQ/dmVSm20Cj7vfWQi7iNQ8V
	 MRK9iu/IeTcOLJ92iQWRMU2JwEHwPvWr0Khos5c5paGnf+yV2XgX9hdzqDL6VJNoyh
	 BgOOoVuLbbzvvY0r5ZJ4egs1EkWD4Yir6H3DgUp52UCge3yz/lZTFJBPkXLM1Vmn/7
	 rZQsA2nbHGZCbPGUtou6JePF8EdFluhWd2pzOHi0XnGxrqDpCi/VisnjW14mI86vwY
	 mozmDwzNTWl3g==
Date: Sun, 26 Jul 2026 21:08:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Pan Chuang <panchuang@vivo.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Siratul Islam <email@sirat.me>, Matti Vaittinen
 <mazziesaccount@gmail.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, "open list:IIO SUBSYSTEM AND
 DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/13] iio: chemical: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <20260726210830.2eca3e9a@jic23-huawei>
In-Reply-To: <amVAkbdREpNVZahV@archlinux>
References: <20260724030524.607185-1-panchuang@vivo.com>
	<20260724030524.607185-4-panchuang@vivo.com>
	<amVAkbdREpNVZahV@archlinux>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 20:16:15 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> On Fri, Jul 24, 2026 at 11:03:38AM +0800, Pan Chuang wrote:
> > Since commit
> > 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
> > devm_request_irq() and devm_request_threaded_irq() automatically log
> > detailed error messages on failure. Remove the now-redundant
> > driver-specific dev_err() and dev_err_probe() calls.
> > 
> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> > ---
> >  drivers/iio/chemical/ccs811.c      | 4 +---
> >  drivers/iio/chemical/ens160_core.c | 2 +-
> >  drivers/iio/chemical/scd30_core.c  | 2 +-
> >  3 files changed, 3 insertions(+), 5 deletions(-)
> >   
> 
> Reviewed-by: Gustavo Silva <gustavograzs@gmail.com> # for ens160
> 

For some reason b4 is adding a review from Andy to this one
that I can't find either locally or on the list (not for v1
or this).  I've edited it out by hand.

Maxwell did give a tag though on v1 so I've kept that.

Thanks,

Jonathan
