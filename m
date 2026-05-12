Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A9306767;
	Tue, 12 May 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597625; cv=none; b=o5dufZJvIEynSvafHsZ+qPMSo6bV6lfw4rE2DcnLH4u/JvXT97tQVDPOVBURbjJiad8b6iW6h/dZy7eiFssg5fbvwTrJAW9jHzIbm7f1cTpp7aYsdFgJSY4EP1kF0V0NnxwzB0qiOPcMyT1Yi5gBvfhsfgEgkN869UuzEiIt4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597625; c=relaxed/simple;
	bh=Ktcyr0KcS4ihTgumnmUDCioLx3OrJTvkOocWQcbpmTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxWYnX+iuT64Okhjxg3m9EyEOEQtBJ8cYHHoWwlcJQKMg7jbMAl421bvpPJfEVO6YGzGp8mpy8c5uag6TgO/54zV2jPBNJJb4drZH8YhrY+aidYShgr1PXJCuQsG2MycOuRaayyeEVPREHcRZLJ1X7M2PomFRN2NWHsLnvbRpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtHpgOpP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtHpgOpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715D4C2BCB0;
	Tue, 12 May 2026 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597624;
	bh=Ktcyr0KcS4ihTgumnmUDCioLx3OrJTvkOocWQcbpmTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JtHpgOpPVf64JS+qw0fML9nRorH2Id+e3/bosEZYMGNART29wZJ2npmeoM+YN4yWO
	 o9LC1+xLeE7skaXpc6k8Fu2BGco3+cGF+ATj8AsDt+60BTQOHTM5B9PWxZDtG1QzKF
	 zlcJTxe11Pzz8GLNhmxMQgCF1z4PhzwRUAlPDb9mHyftzDUrolGdQkGk+dUEuw5pSH
	 baKL9Bh9UGuOaAU3MBYVN2jKsI9DV2I/f1jkC7xcySpgwkD6zOg7SefCFTWlLBMsRh
	 W0D31KSarXwTCVzUZ9EuTZTXYR+7IAJvB9Z006fj4HJYfbgGTdk90N14mJ02rKEv8B
	 iX415mUZbQbtw==
Date: Tue, 12 May 2026 15:53:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 1/8] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <20260512155335.3fdd4dbe@jic23-huawei>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-1-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
	<20260511-magnetometer-fixes-post-pickup-v7-1-9d910faa28b6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 13:26:10 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wr=
ote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
>=20
> The driver currently uses while loops and msleep() for polling during
> conversion waits.
>=20
> Replace the custom polling loops with readx_poll_timeout() and
> read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> boilerplate, standardizes timeout handling and improves overall code
> readability, keeping the original timing and error behaviour. Add
> <linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.
>=20
> Assisted-by: Gemini:3.1-Pro
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
As per discussion on the cover letter thread, lets pick up the easy stuff.

Applied this one.
