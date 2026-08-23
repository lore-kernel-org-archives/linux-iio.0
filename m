Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9171E1024;
	Sun, 23 Aug 2026 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787445519; cv=none; b=Cm1OFl9vRBQ9xbo/Taz0GtqCQkglQKyJohWi2Cb48/F06cUYvcPDirXDnTF2asIEj1Q2NkPuITLvY8e2UiJGhhPFULQF0zlvEhxG+TWCSAPuDRtJXjC3UckrUkbQNmbevJqQUEmW2UpAc7ZB8ON+9PXgjRep34J1EzONNEC33k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787445519; c=relaxed/simple;
	bh=jDqbHjOpgVDNiLRhulyZYL1OQVjnk7ZZ88VlNhh2Fu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gthakknveQ8pmOEVVwHeLYGl+gElzjBUnaE/s0erlsqOvpGyCqkSk9SsGZotoOkvpNx8fBzKq4KjHHWjaCSy+ILsbqBuRRt8EMBX8AO4wSOqecaGonp2h3PXU3NmaBSKUriRI66RatDRmOIXefwk0kZRc3LQqD2AYkadpEKZGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPGxPwYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPGxPwYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A11F000E9;
	Sun, 23 Aug 2026 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787445517;
	bh=53PSb32ImZdZprYGGXVAklTUU1cmlBqdwRn/UH37mj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YPGxPwYagePeneT22yqjZU0nqMjksfKqru4Rk7rwSScWrR6WORLpBrcZqlSCC+crZ
	 U2W4cTG5pRim3Cs53mrJwLqrVQQvu991k/9MWdMzxCY0AvDEvNOag29gtODuEzjRhN
	 HToQq/91yvg2B5nvv8LhCaIDqB+Y6Eh5WSvCqT6+1GLGBYx76SrqXS/I4E8lA/YShv
	 2A+FidYhhNRR69TMztr+6wWx14Tv5yEuyCHgMNnfHrstyPlBT39js5sAwoD5J7s0H+
	 Sj1AuyBpcjIm1ReaPa3VORyKwO0dzVl4w7TG4QbG+Fyvz9iWqCjgCltNmmC7LzWaOV
	 JmIS+krici6NQ==
Date: Sun, 23 Aug 2026 01:38:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: accel: kionix-kx022a: unify staging buffer
 and convert to iio_push_to_buffers_with_ts()
Message-ID: <20260823013833.6dd77e26@jic23-huawei>
In-Reply-To: <20260819103747.31722-1-grondon@gmail.com>
References: <20260819103747.31722-1-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 11:37:44 +0100
Gabriel Rondon <grondon@gmail.com> wrote:

> This is the kx022a staging-buffer unification plus the deprecated-API
> conversion. Patch 1 drops the redundant buffer and routes the one-shot
> read and the triggered handler through scan; patch 2 does the
> iio_push_to_buffers_with_ts() conversion.
> 
Ah. I didn't see you'd posted a new version with the changes requested
post my having picked this up (to fast as it turned out!)

If you are going to do this - which is fine - then reply to original
thread to call that out.  I think we ended up pretty much with the
same thing upstream though as I went ahead and tweaked it in my tree.
Mostly once a patch has been accepted, it's fixes on top.  Things are
a little more flexible when I haven't yet pushed it out as a non rebasing
(ish) branch like iio.git/togreg

Give me a shout if I messed anything up when tweaking it.

Jonathan

> Changes in v3:
> - get_axis(): use a local __le16 *buf and le16_to_cpup() (Andy)
> - Add Suggested-by: Jonathan Cameron to patch 1
> - Trim patch 2 changelog
> 
> v2: https://lore.kernel.org/linux-iio/20260818215122.52715-1-grondon@gmail.com/
> 
> Gabriel Rondon (2):
>   iio: accel: kionix-kx022a: use scan struct for one-shot and trigger
>     reads
>   iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()
> 
>  drivers/iio/accel/kionix-kx022a.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 

