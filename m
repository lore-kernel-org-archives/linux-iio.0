Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0711D416C;
	Mon,  7 Sep 2026 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746877; cv=none; b=koaxfrsgZB6vRR2OA1ggqz84RK1/uC7FBWmXcYkTnrfA9v8iiItcW0J+5GqBvWciJ0NfsWVx7Q3s/s9xcASfl9gupf80eSk5NcPeiqirh2CuWEW/Sq/cGVR8fZQYy9+/ALj6tWat1XPql2d7cd0ZHH0V/Q+WqnrlWwgSNY2UlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746877; c=relaxed/simple;
	bh=qok1BR21gnWayIlOK39ULGwS2GuTp+1wmMxnhr2mAQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWdkbXVm+1xi3xjjUcmyH2o74zZrN6n7pzVpXQtA9oGOsEPEWh7PEEreRsL/dVkiVWTCdn9fOsBrjxDXNZfBeNjxRVPRfm+bzVlHPlK+POnOdJdMwKVKkhyQwnk7Tq2I6Azy2XQRmpXy1QzajcxoaAaB+alEyJ+Y+OdEkhlEcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKRIP9Jb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKRIP9Jb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35661F00A3A;
	Mon,  7 Sep 2026 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746876;
	bh=EG00Vd88X2ceT0Bq5CVAN13WMC432Kc2z4nTSdVoMp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SKRIP9Jby24xroCmwClUK6rdbKEgRixdSDdZNcASbKB46RrLU/e9oa0sQ6krUT/2u
	 p5ezloxUM+cIgKDgUKQC4jwrB50SbG4YW1RmsBE9GWQIlVKvIbGrf9GmyFtA4qKSwq
	 7eDm3BU5MVXY9e+PzaTDBBELmJ9lWEu8o33T+9tzqpYjatEjGWey4PEBnCuLf7nVPl
	 mplZR1TbhrybzrsQfUu5JhnJurVH6YF/rux0Isqvfu2rMVZhIjufLHeUmgHVneOdG1
	 nYDRSEeJhryRv+XwBxL+UbzEKHM8BgPHJWzb+DYb/p1JaYwow30zBAFvxMi8HZxMW+
	 sDi/Wbfgco+VQ==
Date: Mon, 7 Sep 2026 03:07:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Cesari <fabio.cesari@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29028: fix runtime PM reference leak on
 error paths
Message-ID: <20260907030751.3da628d4@jic23-huawei>
In-Reply-To: <20260906221517.201877-1-fabio.cesari@gmail.com>
References: <20260906131203.125407-1-fabio.cesari@gmail.com>
	<20260906184358.398f3f1d@jic23-huawei>
	<20260906221517.201877-1-fabio.cesari@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 00:15:17 +0200
Fabio Cesari <fabio.cesari@gmail.com> wrote:

> Hi Jonathan,
> 
> On Sun, 6 Sep 2026 18:43:58 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Whilst perhaps not best practice as such, it is pretty
> > common to just not bother checking the return of pm_runtime_put_autosuspend()
> > at least partly because of that annoying -ENOSYS result if runtime pm isn't
> > enabled.  That is what happens with the ACQUIRE macros for instance.
> >
> > Do we have any particular reason to thing it is more likely to fail i this
> > case than any other?  
> 
> No reason: both functions already returned that value to userspace before the
> patch, and I left that unchanged only because the patch was aimed at the leak.
> It makes sense to fix it as well.
> 
> v2 will take the reference with PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() in
> both functions, as Joshua Crofts suggested, so the value goes away along with
> the manual put.

Why the if enabled variant?  I think that only makes sense in places that can
be hit prior to runtime pm being up and running. Maybe that's true here.

> 
> Thanks for the review. v2 follows shortly.
> 
> Fabio

