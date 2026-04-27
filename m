Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E23AC00
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284228; cv=none; b=GlcRA8kV/AkOoI7OMh6YTf2i+TG647o8g290w+NFo5zQ8AKGAE2c9AP27725sSxD8hUKOmuJSruGpW+hS04YBSBSrU0XnNklNy05tHfyNG+iByJbQ4nPgZgo35LL3lVle+aSsmh5CM7YZtWY6CyCMMXIbZgRt0yZEj1Fr7mxSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284228; c=relaxed/simple;
	bh=XYLE9TA0IWpeumy+gSbuXKXmhKHtKngemJgMUFhgkQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGcnA3MKU/7FpHAB34w6J8ItRIc2Vxqu4L3E/gZf7Ul8Zc0ifZ5pL+8AGafKs/1Z+fNgRv4Zm0QZGbBtrZfbnlVbkMC2654xzFb1AVH+DFyEGPSgbVg1WYB7Rd4tOdtdYlYK/BEsnc0gvgwdeVO/eWTvAFOSfCyyfFXZJgdzZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlCflqhk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlCflqhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F98FC19425;
	Mon, 27 Apr 2026 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777284227;
	bh=XYLE9TA0IWpeumy+gSbuXKXmhKHtKngemJgMUFhgkQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LlCflqhkt+ULH/QWfcyI10bsms/b5DLgemMJvCYeVtxujGr4hly024vkJhZgFakjI
	 HTLTkC958B1q1NeO2kCzzFTPABDMwi0c5uvU6lHVo3ByZGJ5HjCb5TyZ9jhwjl1IMW
	 r89vGvgtwd0TwmblGFCSsJf5qr+2NkKDQSnefq4B/cuGeUXKwdULsLzYl7WnvthQWI
	 KutuIwfcMDJ0lcC5f/2S1N0V0lU6flfgLfQYO2gVZqfxEcfgiB7hGvU3Ed14eXCm/z
	 BEGCsbVdgQqdOcZ3EAjTPlMeeISj4rTpI8+z4SGm6lq71LzvkXKgieVz7GBG1iXMNg
	 ilW+2Zfm6n3zA==
Date: Mon, 27 Apr 2026 11:03:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Caio Morais <caiomorais@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, michal.simek@amd.com,
 nuno.sa@analog.com, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3]: fix unnecessary includes and add missing ones
 across multiple drivers
Message-ID: <20260427110337.32bfc6d3@jic23-huawei>
In-Reply-To: <20260426211834.3318306-1-caiomorais@usp.br>
References: <20260426211834.3318306-1-caiomorais@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 18:17:59 -0300
Caio Morais <caiomorais@usp.br> wrote:

> From: Caio Morais <caiomorais@usp.br>
> 
> This series removes unnecessary includes and adds missing ones as reported
> by the include-what-you-use (IWYU) tool across different IIO drivers.

One series per driver.  Having a shared one for the core is fine but definitely
don't mix core and drivers. Tend to have entirely different sets of
reviewers!

J
> 
> Caio Morais (3):
>   iio: adc: xilinx-xadc: remove unnecessary includes and add missing
>     ones
>   iio: buffer: industrialio-triggered-buffer: fix includes with IWYU
>   iio: common: st_sensors: fix includes with IWYU
> 
>  drivers/iio/adc/xilinx-xadc-events.c               | 6 +++++-
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 6 ++++--
>  drivers/iio/common/st_sensors/st_sensors_i2c.c     | 7 +++++--
>  drivers/iio/common/st_sensors/st_sensors_spi.c     | 9 +++++++--
>  4 files changed, 21 insertions(+), 7 deletions(-)
> 

