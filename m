Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404E9463;
	Tue, 25 Aug 2026 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787622745; cv=none; b=NmHuKu3qRvSSbryTTnsSaU3FNj8uWVZgqWK+0n+RMGGncOYM50OoDot4jxLagiaV+eGn2TlN+FHV9jMFz19jU6XvdaNIQ2niYNrXdhAn+LmR3Du0WHwaH5vcDFclNUY2Gp8VmC0JwPaYDD7Mb/OUj4IBO0ALtFMw7sVAy6GRLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787622745; c=relaxed/simple;
	bh=xvWAoaWYc/4JZihKhFfDRwfA7Q7SK3upyBB64MaVJzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL7/vxHh+JvbMXM5hhz4mCHXSZxpWC2kr3OcqO/InDhh5WHyJuO6jX9DGwPVBH1jy2GsHLy4mAQ16gU1JsYAyYFgMnsVcHgBuIfQ/cgBdciOOrsJ/9xQN9fH0JBKK4/vVsrsUI5yK1micgdq4oe5S/CvB6246U4g5Uge4rD+0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZVSKgD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZVSKgD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59291F000E9;
	Tue, 25 Aug 2026 01:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787622744;
	bh=PnKZ6+q8Ppf+CDrfPDQzn/+ICAwxmwMk8PGSMPSepXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MZVSKgD0IViBBmbcSnC03Fth73QZNmNVAkrHga094nzdboNG4ROuHW/RJhkAodK86
	 R0/NfJWV6OABeCjfP1z3YM4al+cMJ+kA40VOpDwPP/vZkk9hF3T8GKEQMCA0QzUuPI
	 sjVPz7Y0ty33FzrO1zTB0fcjvYZcM4uXNJuULsIAMgULt/ZVCLbahGzBLWYDFsClzV
	 XGCMELO61ASY9z+jOYyox5e7uZTgtDX3J0LlDGXRvc/sycQn5SdRXYBatFMC6w1lLt
	 zLVGoxaYlAmIaEbpFIDvjcX9nPeCBafUYb3K+VH7pqJVvyfPJztReRKtzEGaIUw8td
	 gTCnCiN3V56tQ==
Date: Tue, 25 Aug 2026 01:52:20 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: andy@kernel.org, bleung@chromium.org, chrome-platform@lists.linux.dev,
	dlechner@baylibre.com, groeck@chromium.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <aoz1VN62zEuKPePl@google.com>
References: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
 <20260825012725.8908-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825012725.8908-1-triet.hoang.dev@gmail.com>

On Tue, Aug 25, 2026 at 08:27:24AM +0700, Triet Hoang wrote:
> Convert deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS
> and pm_sleep_ptr().

This needs to update accordingly: SIMPLE_DEV_PM_OPS() + EXPORT_SYMBOL_GPL()
-> EXPORT_GPL_SIMPLE_DEV_PM_OPS().

> 
> This lets us drop the __maybe_unused annotations from the resume callbacks,
> and reduces kernel size when CONFIG_PM or CONFIG_PM_SLEEP is disabled.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>

With a nit in the commit message,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
