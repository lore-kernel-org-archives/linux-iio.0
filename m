Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100543E4A1;
	Wed,  6 May 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084733; cv=none; b=sfqoLkrJ446uHiaQB53WTO7vxZTlz7XQ9wfTLEyHCZU1gqFEjzfbxaN8pV2gQ9R5g1Ca7Lt7remcr1zau8XV6+6PUl1rksvr/mILM1TZPy38i9j4ugDQF3n0p4zQxDV2hDIv6vF6HGRFGAAAkFB6xjAY3+q1a9Mnj4/kUiZ2Mg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084733; c=relaxed/simple;
	bh=8lckDYVCHgZcVrPd5vN9cH2Phto/u6iiLpNyQmuwoHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki9MhtlqNeVY5pRWmm29d2FmJdawA9zOa4R7ArKTSzig5a4FVl26j29Fr/yvuhsHoiSevmyqnWA2qHL/QpvgNtwvXcwiT0Nx+UuGPRgTZ31jfLmWNIqUlsqHO/tdbWpYR7OGVN51mdvZwERAXj32N04G804+hrzRNWJBiRgZ538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0hKi6pM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0hKi6pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23863C2BCB0;
	Wed,  6 May 2026 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084732;
	bh=8lckDYVCHgZcVrPd5vN9cH2Phto/u6iiLpNyQmuwoHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0hKi6pMbJDcECW3aO23XQ5KkVhFVYN8KexpIquc6ml1v4ikNf0AKC01hKgFoQZ+G
	 ctxBk59ZF+s1YkMkBKe6ViQgGduOUsDJwXoPJGthThFKOoWWybApcEcXyvwCXw2Mpu
	 73T1F1n36IzdrHKP1Zmepehe7ICnmjeAyvTzWMZ1e6Xdrqenig2yKPDcyMFp2EZ4jb
	 vpwTmqWQkfO77ZGj5SblVwdTr7vZaSPLu6umn3NwsGISxIV+RPzkreBU0sfy3EYprp
	 54qYo4cU8n/aO+/rgPOt0vUCtJxq1n7VegOOU3y6bGiGNGqguC6k+E9GZ5s66tpquk
	 wOXEpwPCqw5Iw==
Date: Wed, 6 May 2026 17:25:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: ad3530r: Fix AD3531/AD3531R powerdown
 mode strings
Message-ID: <20260506172523.77e095c6@jic23-huawei>
In-Reply-To: <20260505-dev-ad3531r-v1-2-2b4cc55f69e7@analog.com>
References: <20260505-dev-ad3531r-v1-0-2b4cc55f69e7@analog.com>
	<20260505-dev-ad3531r-v1-2-2b4cc55f69e7@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 12:34:32 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD3531/AD3531R has different output operating modes from the
> AD3530/AD3530R. According to the AD3531/AD3531R datasheet, the
> powerdown modes are:
>   01: 500 Ohm output impedance
>   10: 3.85 kOhm output impedance
>   11: 16 kOhm output impedance
> 
> The driver currently uses the AD3530R modes (1k, 7.7k, 32k) for all
> variants, which is incorrect for AD3531/AD3531R.
> 
> Add AD3531R-specific powerdown mode strings and assign them to the
> AD3531/AD3531R chip variants.
> 
> Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD3531R")
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable

Thanks,

Jonathan
