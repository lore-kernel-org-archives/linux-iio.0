Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F253BC660
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030648; cv=none; b=tmLl0yTQLTR/opYzAtU5hQDaGtCBriDjWgpl2+iOh4AquF1JhRgpo8/zzHySKE09J/5KcC7pWvR9TakZvbWIaQiJWpeIOEAFpZUzdStXQBP17i9gr+3RiaC5r2kYGOZrehBxzDJkjvARZLE9K81nqDLkgKJVQk78pcsudJo9gH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030648; c=relaxed/simple;
	bh=yc1/kyMrgFK7JW4l3Xdkcola3wjqMVNbb4SsqBlcsEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEddVAjg5DiUiblKmIijtmkzcMpkEHziW9vNdZYOop+L43XvQlpx9FOHlFdiEfbG6C2c3pXlWHhfTECNE4UKN62OZpPoJap/cqiAtWydiMJtjTvh9j2QoHnU0x49sDiky4KzhUB5kaDWW19OTKSdR7zq9ehrmCZBA4mBNdYcxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjmoS4eL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjmoS4eL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC6AC19425;
	Fri, 24 Apr 2026 11:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777030647;
	bh=yc1/kyMrgFK7JW4l3Xdkcola3wjqMVNbb4SsqBlcsEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DjmoS4eLp1i1p+mRIAXkSBa9BHS8mkLBL7SkThM0ioM3Fs4MTkCssXSjycZ442LU6
	 /3VjJRzFi84mBpRmZmqWD2rrEruQx5sSU/9BwPIt9K9AtsIY43d87vsVmCckvxiQqU
	 mB7fPk/5+3pxuJj7y1dsAwhhalip4r0b1GSZT2xX71vJ1Akh0ta/RyHkpzEvlKcRUT
	 4Qmbpj/QpD0N6q1sDdAC3//BTzry/CWmfkf65Kub6RQ1BcKtpvmV3smbxam/t/ogHl
	 BIvkbSpf3OWahilC8PKeCeBTQfra2+Pz5e4f3nxiZ3cXsctFquddmX+s7HCz4VOLdP
	 g/qo5di5ehfKw==
Date: Fri, 24 Apr 2026 12:37:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, Eduardo Augusto
 <eduardoaugustoabc@ime.usp.br>, Christian Barry
 <christian.barry@ime.usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: adc: mcp320x: sort headers alphabetically
Message-ID: <20260424123719.64022c30@jic23-huawei>
In-Reply-To: <aesjT6Zo50KS3BaR@ashevche-desk.local>
References: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
	<20260422222553.67660-2-gustavo.pagnotta@ime.usp.br>
	<aepa8jD4uBrtY4WV@ashevche-desk.local>
	<CAD7rJs=gNZoS7=HfhUoi6K0myMQmo-9Wd_-oYcfkX8cAtpBJbw@mail.gmail.com>
	<aesjT6Zo50KS3BaR@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2026 11:01:19 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Apr 23, 2026 at 05:45:08PM -0300, Gustavo Pagnotta Faria wrote:
> > On Thu, Apr 23, 2026 at 20:46:26 +0300, Andy Shevchenko wrote: =20
> > > Is this SoB chain for real? If you want to give credits to mentors or=
 so,
> > > it should be done differently. =20
> >=20
> > Yes, the chain is real. Eduardo, Christian, and I are classmates at the
> > University of S=C3=A3o Paulo (IME-USP), and we are working on this driv=
er
> > together as a group assignment.
> >=20
> > We are doing mob programming on the same machine, which is why we
> > included the Co-developed-by tags for everyone involved in the changes.
> > They are not my mentors or professors. =20
>=20
> A-ha, thanks for elaboration on this. See below how I suggest to address =
this
> case.
>=20
> > However, I understand that having three authors for such a trivial patch
> > (like sorting headers) looks highly unusual. I also realize that, as the
> > sender of the patch, my Signed-off-by should have been placed at the
> > very bottom of the chain. =20
>=20
> We use terms: Author, Committer, Submitter. The latter one is probably wh=
at
> you are referring to.
>=20
> > For the upcoming v5, would you prefer me to keep the Co-developed-by
> > tags on the main refactoring patch (Patch 2) and leave only my
> > Signed-off-by on this trivial header sorting one? =20
>=20
> It's up to maintainers. Just put the information in the cover letter to e=
xplain
> these rather long SoB chains. If maintainer is happy, they will take chan=
ge as
> is, otherwise they will ask for modifications.
I'm fine with a bunch of co-devs for IIO (and had a good idea
what was going on in this case!)

Given I'm getting a lot of patches from IME-USP folk this year
I would encourage you all to do a bit of cross review.  Some of the
patches are tackling similar problems in different drivers, so
it would be helpful perhaps to 'spread' the feedback by pointing
out where similar improvements apply to your fellow students work.

I guess that might well be going on behind the scenes, but feel
free to do it in public too.   A large part of getting involved in
the upstream kernel is in helping to review!

Thanks,

Jonathan
=20
>=20

