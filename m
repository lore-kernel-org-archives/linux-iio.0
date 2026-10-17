Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC65347C6;
	Sat, 17 Oct 2026 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792281155; cv=none; b=RYaEDXAPGKTASdcRO4w4+2CZeEsn1SBMSKGDgHG3if9r+wX7OHAMdyDuZY3ooJuYbwCSIOlCP9s89fPqR6b+FuGKjJmR+BlBLMmtpEKzC+vop/o06EEXa6MbzVZlzwKPG/ooVwSPYOB2vdkuFFGN76YtNxA/PSE2qiIiRkIP/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792281155; c=relaxed/simple;
	bh=KQxRgMiC9eqfoxps45u3C8FRTJSV+Wus1W6p3YPA5AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLqncsGBuLlDCn+D77wjGr1e5W63dsE6lN2rVUvMUXxwcqFWwCpZ3TpWwllIADcZyPsF9w8hHwSFLREUugTLDLcrQTALIUP7KfiuK4eh73XZnOQjbGGpagxq6e4M/tVA8eYEpVNAO7w4OOGOAYkeG3rohZjNFihqxdBRZM5YTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtTgdnJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtTgdnJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC281F000C4;
	Sat, 17 Oct 2026 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792281154;
	bh=StFzcik7Mp3ZhvVi5JfQWedzYDV64DGFpPQvRvZGGVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QtTgdnJaKeLronPOyT75NC3l1+vd0AHb1RHOFWqVSZ8LIqRqJVesYHg6P9pe6TCeW
	 HxIhHTaivr2u1vZoOchTzuufBLhDIzPmaNAVuneMkakM0TZQq3lukqZ6lymHh2XYj2
	 sNcE1VjoC0rruYkzekNa5tzEH/W1P6M3FslGfElMt7KwhixXuYW1n3Q3eqR+0D8b4C
	 KMtVIyDJNhai1PEdoa3Uu5JRlnrQpgyEJoP7J61W1zEw/0S4HQ/iy5IqLxKVQR5tqG
	 yjlf5l7pwJ0BF8yD3UzSjREkqrH6h/B9WpvonM+y/OS2pdRjO3mjti3sdIclkXazoo
	 oOYYoXqG/aZHA==
Date: Sun, 18 Oct 2026 00:52:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Mark Brown
 <broonie@kernel.org>, bui duc phuc <phucduc.bui@gmail.com>, Frank Li
 <Frank.Li@nxp.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: magnetometer: fix the register restore on
 resume in mmc35240 and mmc5633
Message-ID: <20261018005228.151cea5a@jic23-hlaptop>
In-Reply-To: <20261012050055.48850-1-jain.sm@gmail.com>
References: <20261012050055.48850-1-jain.sm@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 10:30:53 +0530
Shashank Mohan Jain <jain.sm@gmail.com> wrote:

> The resume callbacks of mmc35240 and mmc5633 call
> regcache_sync_region() before they take the regmap out of cache-only
> mode. Since v7.3-rc1 regmap refuses a sync in cache-only mode with a
> WARN and -EINVAL (86fc3483a4d6 and afc8e3ee8307), so both drivers now
> warn on every resume and no longer restore their control registers.
> 
> The kernel-doc added by 86fc3483a4d6 says that the caller has to
> disable cache-only mode before the sync, so the two patches change the
> order in the drivers.
> 
> The Fixes tags name the commit that added each resume callback
> (553a776b7908 for mmc35240, 6e5f6bf2e3f0 for mmc5633), as suggested by
> Bui Duc Phuc in review of v1: the wrong order predates the regcache
> change (86fc3483a4d6 / afc8e3ee8307), which only turned it into a WARN
> and a failed restore.
> 
> I have no hardware for either chip. The patches were tested in qemu
> with the drivers bound to an i2c-stub device and a suspend/resume
> cycle through /sys/power/pm_test; the details are in the changelogs.
> A scan of drivers/ and sound/ for other resume paths which sync before
> leaving cache-only mode in the same function found only these two.
> 
> Based on mainline (a5ebb76233b7, v7.3-rc6+); the patches also apply
> to next-20261009.
Applied both to the fixes-togreg branch of iio.git and marked them
for stable.  Seems harmless if they get backported further than
the change that added the error.

Jonathan

> 
> Changes since v1:
>  - repoint the Fixes tags to the commits that added the resume
>    callbacks (553a776b7908, 6e5f6bf2e3f0), per Bui Duc Phuc's review;
>    the code change is unchanged.
>  - note in each changelog that the ordering predates the regcache
>    change that exposed it.
> 
> Shashank Mohan Jain (2):
>   iio: magnetometer: mmc35240: leave cache-only mode before the cache
>     sync
>   iio: magnetometer: mmc5633: leave cache-only mode before the cache
>     sync
> 
>  drivers/iio/magnetometer/mmc35240.c | 3 +--
>  drivers/iio/magnetometer/mmc5633.c  | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> 
> base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b

