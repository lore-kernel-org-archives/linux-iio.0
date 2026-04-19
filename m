Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB4308F2A
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776600725; cv=none; b=muU94IdXz0yk0FL83HjEmcmEyDxHeT5rG9/ANOBI8yMpfMgZS0b5PC5R3edBPj9K63DoC+PtAJRhzr+Yg4Y1jCCeKRzAbem9eXpWYGBTaBgb6LmHv0A3TILpPlSICgSGmjydnBTEIVCdWk7LiN3a/UZHUsrdI2LhQQh19aujLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776600725; c=relaxed/simple;
	bh=bQbfGRnd7D/GQfFy7YXrqulg4DJiVTtFmZE4JY8zq6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF7VuInn5Pc4A1gypG0bbnAjTCafwfBvP+Xn1u45XwMAnjkSBCgPbY/YBXzd9x4ATV/TBMpYsk5snGc4EbgknuMB1gH+kWP5ibMgk6cnTHpZI9vkUgbBbAcn41KuP79jQAxquJmy2AYZBiT5TCqMLmbwatl3XyNMnO+3rzsLcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ3rIz4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ3rIz4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D63C2BCAF;
	Sun, 19 Apr 2026 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776600724;
	bh=bQbfGRnd7D/GQfFy7YXrqulg4DJiVTtFmZE4JY8zq6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZ3rIz4u5LQH/OIx2Nw0wSq1lUYzFxwizW0CB/yVsldhrJHRewszmbZvFCS8TxUZR
	 eFgFz8pg+dg2qrTdyddMz4NAW/SsVc+Sqkc/ME1udZyZQZxg4BhjfqcloIrEyejZwU
	 JpySmObOMChgD1s2j9U2ybslvxfOWcRmM3nxjUrJbb+uGb/ot+2OahovqsDto02pmf
	 8VhkGwl1UabEdY3O55X3TWkT3ogRrToVQpiiC5c6XYhQXlVoF47ZBhKpGEC7yLqwCu
	 seLXKNdlTWpEruUjKhVPSmv2BL04uB40WQRJ9f63w5RPrjT/sJvZMSJd9DNfLoJTzG
	 FOsB1yYF1hyng==
Date: Sun, 19 Apr 2026 13:11:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 andriy.shevchenko@intel.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: dac: m62332: Use guard(mutex) for locking
Message-ID: <20260419131156.033faee1@jic23-huawei>
In-Reply-To: <20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
	<20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 10:03:20 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> This series refactors the m62332 driver to use guard(mutex) for
> simpler locking, preceded by a header cleanup as suggested by
> Andy Shevchenko.
> 
> Patch 1 applies IWYU to the header block, removes unused slab.h,
> and sorts the includes alphabetically.
> 
> Patch 2 replaces mutex_lock()/mutex_unlock() pairs with guard(mutex)
> and simplifies i2c_master_send() error handling. This patch also
> adds <linux/cleanup.h> which is required by the guard() macro.
> 
> Changes since v2:
> - Split into a two-patch series per Andy's suggestion
> - Added missing <linux/cleanup.h> include
> - Cleaned up header block (IWYU, alphabetical order)
> 
> Changes since v1:
> - Split combined condition in i2c_master_send() error handling
>   into two separate early returns
> 
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
> 
> Erick Henrique (2):
>   iio: dac: m62332: Clean up header includes
>   iio: dac: m62332: Use guard(mutex) for locking
> 
>  drivers/iio/dac/m62332.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
Hi Erick,

A process comment.  Don't send new versions with the reply-to set.
They should be new threads not burried under an earlier discussion.
Combination of naming and version numbers is enough to associate
the versions though a nice convention is to also include a link
to the lore.kernel.org archive for the previous version.

One practical reason for this is many reviewers and maintainers
tend to catch up with their backlog starting with the latest
email threads (as often earlier versions have been superceeded!)
So I only found this 'in order' because I'm using patch work
as well for tracking purposes.

Thanks

Jonathan
