Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5573D9DDF;
	Wed, 16 Sep 2026 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556022; cv=none; b=PkOJLpFdSe1CvIdzht7Hzv4ri1MY4VoSp7/+HQG+DsNoG1IiJD4Y2Xp8+SNqqYRUtvkN0RT25KB+i6+rdTQqVkQpv1Y2rPxEI8BzcFymU1mH8OiwvJMRBcerFUPAJz7ZPWYdragZUzKBe1SZl79sQlTMprZAbxEThiYYvjZuxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556022; c=relaxed/simple;
	bh=xSr8Uu2oKidqPxzSvVxRAoaqy4vM4BfWRXbMmHienkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeF3PkYZA0tUEbjdJ8fzxSQX631UOZCGFt/+F0H4qeYt/CNOC+y+yzhBjIVm3DEM/hYh4EpRinwZIYi2dMmOQgHBGYjnL0r9BC1hMe5EOItElOCNJRjoGI1bVuGbv6reAzaeqIcUjrWsLV8HlxQaNACyRnTOxkBY3AMcUqo4XPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG4O9Br3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG4O9Br3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA071F00893;
	Wed, 16 Sep 2026 10:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789556004;
	bh=pefdrnbdIECiwgYAQfU7yIbEiMypmMVgKgxK480YuaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kG4O9Br3WAK1PzkhJcbWSwDnlox1pO3Huy0+kgqvdmn0YwdK5CMq7R2HO2g6txwu6
	 VxiqTD1d5EKKLa01nKWU4YdD6FPxwVPMpcOO53Hkf8/XtHkx6qFn0Q+YG/BVtqO/hY
	 LRRuGSfrCvcFsl9Qo3ljdm2LGRlbTpYepVXarPzfOI9ag45xml/XrG17wFZf9thGBU
	 brAAKIqQvRfi1MVPgO7Y1QevCiIlbjml2RJAl7zYhqDRsKruVIHyHYrAhUS4MemnjK
	 ZY5/lvjQwOb7zzUDyURspTeAyPYSotuP8JGZQruN5SukZX+Tiy1C5RTpU/cE/FtGVM
	 L4UwoDIt9ws/Q==
Date: Wed, 16 Sep 2026 11:53:20 +0100
From: Lee Jones <lee@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] MTU3 counter fixes and improvements
Message-ID: <20260916105320.GP11487@google.com>
References: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>

On Mon, 14 Sep 2026, Cosmin Tanislav wrote:

> This series does some code quality improvements to the MTU3 counter
> subdriver, while also fixing bugs and adding caching support so that
> registers are not touched when the counter is disabled, as there is no
> request API.
> 
> Patch 3 relies on the following series to enable runtime PM on the
> parent device so that the PM domain handles it automatically.
> 
> https://lore.kernel.org/lkml/20260914201456.2018403-1-cosmin-gabriel.tanislav.xa@renesas.com/
> 
> Cosmin Tanislav (15):
>   counter: rz-mtu3-cnt: put runtime PM on initialization error path
>   counter: rz-mtu3-cnt: do not assign struct rz_mtu3_channel::dev
>   counter: rz-mtu3-cnt: remove manual runtime PM handling
>   counter: rz-mtu3-cnt: use device-managed pm_runtime_enable()
>   counter: rz-mtu3-cnt: read enable value from cache
>   counter: rz-mtu3-cnt: disable channel before releasing
>   counter: rz-mtu3-cnt: unify ceiling values
>   counter: rz-mtu3-cnt: cache ceiling values
>   counter: rz-mtu3-cnt: cache count values
>   counter: rz-mtu3-cnt: cache function values
>   counter: rz-mtu3-cnt: cache external input phase clock value
>   counter: rz-mtu3-cnt: cache direction values
>   counter: rz-mtu3-cnt: keep cascade_counts_enable in sync with usage
>   counter: rz-mtu3-cnt: drop conditional locks
>   counter: rz-mtu3-cnt: use pm_runtime_resume_and_get()
> 
>  drivers/counter/rz-mtu3-cnt.c | 443 +++++++++++-----------------------
>  1 file changed, 139 insertions(+), 304 deletions(-)

And these 16 emails are in my inbox because ... ?

-- 
Lee Jones
