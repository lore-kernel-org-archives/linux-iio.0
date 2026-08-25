Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F80270EDF;
	Tue, 25 Aug 2026 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655112; cv=none; b=V9/euRPPX3RcDFlhM2VN+JVqr+uQTSdp4eAB3L8FpF/0c5M3/OHKCFHTL1xTvpw0oRbmKsbkcpY2+3zoVt07zB+inToQy4zwmyRxhIRXGLHdJof/HmydREodKHtVr/1/UUgL8mHQ+2T0SyGANYYoWhFnv72ek1N1IENo90J9nFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655112; c=relaxed/simple;
	bh=9kna8nDOBhWk5hX832NGzLBQ8hrjrgGPdH1gaKKXmXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdiEH+ZAGlP+ySvfuXoSpfNBEQkA0BrnczAIN3/YDe0p1U6RAWv63t8FjVN0ochcV4mAL0v4im+rwcp0yjl6C0OGKepawiNhMtzRovs7PWh9CRJiG3aCh/NYC6o8u8hbgMXn3pMnLgDCrGDrS9BVWCDu64geHAECV7KQAG0vUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9ALWvPH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9ALWvPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579711F000E9;
	Tue, 25 Aug 2026 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787655111;
	bh=QMGrDAIOtWZCBXMiOnfGRTif1AzEmPldqj6TN+byTSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C9ALWvPHvCMRPNBYNTEWGi7BwLDGbGge4g4Eysjrp36sekpgcIRiLHIjAD5oy3ji6
	 KlwjR0aY4kMo0xiKQQxivw4r/x6YzPo2U7n/g30bhaJTQL/oqfyzIIO0+bLxBdWd0m
	 GMjv/Fm/m6xBB2zYwgPwhzBbZYgv3f1a7e9yGbX7hboJBVzJ3XZVoIkIqRpnCF2FAv
	 aYXSiJPbnEHgCkq6EP9MtEedv6ifKCo4cuNy1PFqP9jIPg3g7jikSwUxALgGkkG5E0
	 BGV3YIz+6MMNZm1XjhVDX1zsjTc1sNxzc6u7eyEW6zPQ35cS2FJcznEcCNZhW24iAA
	 mQWh2DDmjLBlA==
Date: Tue, 25 Aug 2026 10:51:47 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: andy@kernel.org, bleung@chromium.org, chrome-platform@lists.linux.dev,
	dlechner@baylibre.com, groeck@chromium.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <ao1zwz5VBQkHvYQK@google.com>
References: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
 <20260825093524.285443-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825093524.285443-1-triet.hoang.dev@gmail.com>

On Tue, Aug 25, 2026 at 04:35:24PM +0700, Triet Hoang wrote:
> Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
> and pm_sleep_ptr().

My comments from v2 haven't been addressed here.

> 
> This lets us drop the __maybe_unused annotations from the resume callback.
> This is a straightforward cleanup with no functional change intended.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Neither Jonathan nor Andy have provided their Reviewed-by tags yet.  You
can't include them unless they explicitly provide them on the mailing list.

My Reviewed-by tag from v2 was conditional on my comments being addressed.
Please drop it for now until they are resolved.
