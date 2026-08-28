Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D521D3E8;
	Fri, 28 Aug 2026 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895365; cv=none; b=TbrPgthQZxHa+5zMlfo8nDKypc9se+2NJJv87G7Pd+ngPbYYRpNBdYBsZ5YDx2xVu9MjQffSBvO3ZVbbBBQlhDEdLNp+CYsL2pZgxuE42+cB1pLptc7Xm9HKvfVHGtWylaBq/ZTmW7lN3HneGSVVig+JD1kZGvTePG+vcGL1EV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895365; c=relaxed/simple;
	bh=JAFTc3+syMXFQANb2UEv4tZvqUBW7fz4QUeTHupRs94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDxs1FwU+K06CYpRfuT3kwEUEJlG6xbKum8koJGeckRzFF8Dz5LNlXRy4kT+76oQZgaQf6BaCGpZeD0vKi3yDLJxH1gKr8h29NX8mZ72wp/2hSTsmRc3ZYLD11oxKv6Ewhsrt0F69XPfF29vU0TTYFhIx1ExWi0vOjhE0WKDiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZWJ90JG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZWJ90JG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907A31F000E9;
	Fri, 28 Aug 2026 05:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787895364;
	bh=b+pI/wwnXOIlwsPkHs0uqcMmLj/pOzZJsPSEf9iab+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kZWJ90JG149RrM+MgeSGzNDn5HieRqPycyObhdq5L9r9tXIN0LU+s01UbGZ1jjOhG
	 PG/L83pG7NzVUFHrRP26J4RG849hFfJIC9w4vPCbXFsPJZTFwuQMCrX7dX5CLTHSgX
	 gufS5+YlKQvFm648FTUawtSxm50H38ihfLBafO+hquaQnDbL84joyuyKWX+zRRYTS7
	 jgBqIKIC0NYN2QmhKKx2N55KPcYvBLPVHv8Fh6PV0LOPBTXSNUH94SezzqSTPRxHAj
	 9MhJqPvl5A+WyVGqB/+o0StXJZOKBP7ucH7oIe+SEbidZrBrmsBuNmLMghrha/mquJ
	 FQgYLYQoIro+A==
Date: Fri, 28 Aug 2026 05:36:00 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, bleung@chromium.org,
	chrome-platform@lists.linux.dev, dlechner@baylibre.com,
	groeck@chromium.org, jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v4] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <apEeQMMn9E7hRBOO@google.com>
References: <20260828021350.1666063-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828021350.1666063-1-triet.hoang.dev@gmail.com>

On Fri, Aug 28, 2026 at 09:13:49AM +0700, Triet Hoang wrote:
> Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
> and pm_sleep_ptr(). Also replace SIMPLE_DEV_PM_OPS() + EXPORT_SYMBOL_GPL()
> with EXPORT_GPL_SIMPLE_DEV_PM_OPS().
> 
> This allows us to drop the __maybe_unused annotations from the resume callback.
> This is a straightforward cleanup with no functional change intended.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
