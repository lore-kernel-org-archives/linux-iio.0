Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B83FE367;
	Mon, 11 May 2026 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511480; cv=none; b=j/bsHtwogdLRweHsKOdF6uMfRZkEFi4ersHolJKauujvoykomIxDYwFN3xTG+RFz7409VG7qeNoZUWspQyxC+M9lWPnSwyLpq3BWxaddejMvFWylLsthShBqd+dnCtGqFYSIWTZVSjyzsoEyRYHIUti0hmm4YVh3HJNe9Mb9Ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511480; c=relaxed/simple;
	bh=p0R0aAvlTNm5FNO3vjBH4lhlvSyeMwGgpZgOsfrZ0sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciRh3SBP6W6yg9NW2KKaL9vNegYB2H4AMBdbS3FDwS5CXpEIg9NBt+Z8jKQlY41pPOeA5fq2TtgyrZRrpxhyQDrrG2RJ3o60fUyWklHHlg6pbOSEDFc4PJOh0lTmbljP6oHQLy8uq6/o6k/lbIzzGawgcVGSpNZqdWfimVe7ZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqgUb3QY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqgUb3QY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF15C2BCB0;
	Mon, 11 May 2026 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511479;
	bh=p0R0aAvlTNm5FNO3vjBH4lhlvSyeMwGgpZgOsfrZ0sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqgUb3QYyDMJ8VExeT7Mlntie3LUom3kmOQPWY+vLFxIgkCUC5bwBBuq1+dn860/+
	 5ciOp0ES+TAGyzI9AUi6bwimGT8PSApgEvA1H7iheiBPpN117r8PlghCnUD92xqLxQ
	 OVvcVSvtIuv5fQXNic7WcOO945hz75jLxh9oss8ko2StG9LqUUZPhpxHtL+dl5mvbT
	 p+49leccRKkHZsH31zsZ8LralYu05Uymb6GH3lmmEbCTRQGSqHQ/bM3w8gdpn3DUU7
	 KhiB0k6IPQgyAMV/OUPAAHb0of5A8ND15NFr/E097qa2NELV7iC5oc0RMRcUPHEsA6
	 P75x+E5/b+GpA==
Date: Mon, 11 May 2026 15:57:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7793: replace usleep_range() with fsleep()
Message-ID: <20260511155751.38d8f66b@jic23-huawei>
In-Reply-To: <agHX4-C5xlBqTK-y@ashevche-desk.local>
References: <20260511053043.229-1-sozdayvek@gmail.com>
	<agHX4-C5xlBqTK-y@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 16:21:39 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 11, 2026 at 10:30:43AM +0500, Stepan Ionichev wrote:
> > The AD7792/AD7793 datasheet (Rev. B, page 25, RESET section)
> > says: "When a reset is initiated, the user must allow a period
> > of 500 us before accessing any of the on-chip registers."
> > 
> > Use fsleep(500) instead of usleep_range(500, 2000). The 500 us
> > minimum stays the same; fsleep() picks the upper slack itself
> > (about +25% on a default config -- narrower than the original
> > 2000 us).  
> 
> > Add a code comment with the datasheet reference so the "why"
> > of the wait is visible at the call site.  
> 
> Unneeded detail in the commit message (it more appropriate
> to have this in the comment block, below '---' line). Up to
> Jonathan what to do with it.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
I left the comment on the comment.  Not needed perhaps but not
harmful either.

