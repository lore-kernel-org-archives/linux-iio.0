Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993513D53C;
	Sun, 13 Sep 2026 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337320; cv=none; b=pkBAvW2lJbclhL4EnkOjuLIs7hG7c72BvTBAhP9KQumDjz3gjuRpXfu7dL0SzwV48Qt/BXwDkuAdRgfFkC1Xa/DtTZO7HMDFDyvF4ic9xCVEJpTdm52JApbW9NfF06J7+rBv92nGE2w7sxmebdGIY+YZBdVDgxaMTCK4C7cKkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337320; c=relaxed/simple;
	bh=SiZWEyTxwkMY1R9KijotVX8+/OrLQiLNkpTZQnUergo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbZMksE4wkSjSNP8+xM49DlJkrL3dNYFn187hLPiK2HboZoW0MyCWjHdFhKv0T3h2nBPcfMeYVwXNREwpzzWi82uUdgb52b6xpGSIwAMWf9wYSm04CpMaajF3+KahSR9jUmjjOwxvVhPC0QhIiA+Ncc86+J1Sp06SVooA+H4AQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlY3YVC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlY3YVC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F77A1F000FF;
	Sun, 13 Sep 2026 22:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789337319;
	bh=+L92HwGfP9eRYuyejKWuGy6wiuXszoOVwg0V7KWtv3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MlY3YVC7HISjUgpZfLwcFPNtx5aa+e//C2MVO+vhJcHWht+5ErfAcSdT1KdVbGVEc
	 aRiF7dRaPkqJbbaUGO00n+WEzlxbw0DsiDBP8/8T7CNn1veJhuuR3tYnA20kD6PqBV
	 zuh8l/oTm6lFVAeUsdpaoALOtgHwS90ntzflOEtVuXg6vwAz1UzRdaDCSs3oFJIwkU
	 F+iovRBg1GFoeY+SiQ9FFehV+jAQaCcZCpUDmWJqQDpOj4Qc5IjZ06oG0hgsS9HiJC
	 Hgd4c5s5b0HnwhqotbpySVHjx1j5ZRqddkkUREfDNbiKeZ4ZoerP3WQgdDnT5Ujivi
	 gYoRqcKVGnVXw==
Date: Sun, 13 Sep 2026 23:08:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <linux@analog.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl367: resolve interrupt mapping before
 device setup
Message-ID: <20260913230835.717cffd9@jic23-hlaptop>
In-Reply-To: <20260907165637.0000348b@gmail.com>
References: <20260907082313.3054-1-antoniu.miclaus@analog.com>
	<20260907165637.0000348b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 16:56:37 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 7 Sep 2026 11:23:13 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > adxl367_set_int_map_reg() uses fwnode_irq_get_byname(), which can return
> > -EPROBE_DEFER. Running it after adxl367_setup() made every deferred probe
> > repeat the reset and power the device up needlessly.
> > 
> > Move it ahead of the regulator enable and reset; the lookup only reads
> > firmware properties, so a deferral now returns before any hardware access.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

Sensible little optimization.
Applied,

J
