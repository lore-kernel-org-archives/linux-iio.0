Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836DB30E851;
	Sat, 11 Jul 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809610; cv=none; b=u0Jg7SLN+Ycfg2iMHg9qOObYUDYVflmvXCHLayBrh6MvpCICzsa72EM++d3cKR6DMbvDNutV2G35IlT3etnuhiO0mZ/xwydLwtPNItjCQmp+yRGIEhKZl/nYCsGqBYAOruHzMOK4XV0P+5CPUDfINBjakc3kFnhOtNlFHVQJXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809610; c=relaxed/simple;
	bh=nyRepXAjK4V2QKnAKIx6YTDi8nFXcp5jgbhJJ6V/C1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJHgQghrbhJN/6obVsQllGoC9J2okeGCRUzk5saxhB9eYLNsO1Eax+fgWPVGit/OsPPSlh3ozdy+udirWqgN4FrqunZ8lHXvwgva78zggiUKkCabLoOr78eRABtBcLUQxaJ2V2PAh8ne8as4+WdLK8/XU7IE+5nJZTocmCLmJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E70vTMHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E70vTMHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B3E1F000E9;
	Sat, 11 Jul 2026 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783809609;
	bh=nyRepXAjK4V2QKnAKIx6YTDi8nFXcp5jgbhJJ6V/C1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E70vTMHagOIQjsGs0kmH7/GK3dj5SlOW6MzYiUkoC5VzILod1opuxlp7N90rRBg2C
	 mM2XzqXS230IVFQWVGBbR46EuRyiP+xhb5CVFwEPcLWjnNh76eiEuUx4/FdxKdafS1
	 EF/VI4O58ee+xLtq5ag4CNbCJvFcv1k5JRDY/lBSm+5wJ1WJefO1rSIdotlLX6ZMCw
	 /34+tQhKLUIK0Sb/qAaxcENBZgvZDO+tu5ce22OnJTYS25trY1tn/HmFASFEvFiKDh
	 dJnX1KrTOEUw7OyVmKlcyKz/FFCigX8adtOVQrPQq3V1Tw0iuFuNQ2t/+kfL4NqY3c
	 AkZr2qN1y9YLw==
Date: Sat, 11 Jul 2026 23:40:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, linux-iio@vger.kernel.org, Andy
 Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, Uwe =?UTF-8?B?S2xlaW5l?=
 =?UTF-8?B?LUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: rpr0521: Propagate regcache_sync() errors
Message-ID: <20260711234003.045e8685@jic23-huawei>
In-Reply-To: <8774ce7a-47a0-459b-b09a-7faef0d0fef3@web.de>
References: <20260704071511.23184-1-pengpeng@iscas.ac.cn>
	<8774ce7a-47a0-459b-b09a-7faef0d0fef3@web.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Jul 2026 09:54:11 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> =E2=80=A6
> > Return the regcache_sync() error so resume does not hide a failed
> > register restore. =20
>=20
> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

A valid question to ask. In this particular case I'm going to treat it is
hardening against a failure that hasn't been observed in practice and
apply it. Note I also added the blank line that Andy called out in a similar
patch.

Applied to the testing branch of iio.git.

Thanks,

Jonathan

>=20
> See also:
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv7.2-rc1#n145
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc1#n34
>=20
>=20
> Regards,
> Markus

