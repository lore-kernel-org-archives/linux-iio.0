Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E12405ED;
	Fri, 20 Feb 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771589708; cv=none; b=gLgUX4heJEIO9f5tsdrW8FDWkOeq8cs7w7kBNeBCI2HHAVCYgWWY5ptI5K2lBNQ5I5x5HrY+O8nFAqoHd/oWxofwGz8FZsCh+RQoOjgE7Jq+FP5OB22Og2tpgMhY37KahbuGxhMMmhhUWM6j5ON120Czq2Bbyw86LHglECbYvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771589708; c=relaxed/simple;
	bh=0o9IW6EKqd4Vq8sUK5914JF6ZzNgkbx9lFcrfjsLYeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlXUrQPcaycb5WZZzG5NNaSJXPbNGl6GZc4odsiZjYCoz60mZSSVVXOn2vP/NDQLfsIB3NtRb6Jb8ZS4OSDpwFotwBOUA9yAW8iDAp5OhOXra5YWDEza65sxkHO8BskewuEZ9dfnptCXW+4PoIMyT3l0w/FaF93ld+Uk0s6Jjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOZwv5mw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOZwv5mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FDCC116C6;
	Fri, 20 Feb 2026 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771589708;
	bh=0o9IW6EKqd4Vq8sUK5914JF6ZzNgkbx9lFcrfjsLYeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oOZwv5mwvpQQN4VQkUdCqusXpbBt7ESO0eqqIzhElruWRJ5RApq4QcWI45sujXb84
	 etFZs1opKE7qutBadLCuURXzo8ElfrsGmhrjcXgPjKYEQw2n/kz1YW17L3gHMOHsTe
	 mNfswUm3he0obQN8kkm0AZ+Nfeuq9UAE8hkS4haKeacr6a1riZtYWzOeTvHHzcb0MQ
	 jAA9mUi79nd3XEco0R4hapGpS4EYGcjjlQukstx768FLzV4gzr5Dyu6X+P1zvwOpBU
	 /gP/eVndL8VRDnlDLCeV3zUSokx2tJowONx0cj90eAYt+o0hdnyDU/G3/VLGFClfed
	 6Fo/RhoFpwrRQ==
Date: Fri, 20 Feb 2026 12:14:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <20260220121450.74586f44@jic23-huawei>
In-Reply-To: <CAHp75VdQufe2ANMm=FWvnGAfpe4Y-U_oocs-ax+tY39=z81g4A@mail.gmail.com>
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
	<20260220101844.17f3bc63@jic23-huawei>
	<CAHp75VdQufe2ANMm=FWvnGAfpe4Y-U_oocs-ax+tY39=z81g4A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Feb 2026 12:27:40 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Feb 20, 2026 at 12:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > On Mon, 16 Feb 2026 09:14:12 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote: =20
>=20
> ...
>=20
> > This had me briefly confused as I failed to notice it was static
> > (no idea why I gave such a simple internal function kernel-doc!)
> >
> > However that brings the obvious follow up question.  Given your
> > simplification does having a helper make sense given only a single call=
er?
> >
> > Let's just squash it and have the two calls inline + some resulting docs
> > updates to get rid of the references to this function. =20
>=20
> Do you want to have this change inside the proposed patch? Or in a
> separate (pre/post) one?
Same patch would be fine I think.  It's small and coupled to the code
getting simpler because of the main change here.  Seems like a pointless
dance to refactor same code twice.

Jonathan

>=20

