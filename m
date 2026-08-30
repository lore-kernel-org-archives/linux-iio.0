Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F223EAB4;
	Sun, 30 Aug 2026 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788057829; cv=none; b=Gek/N9k4xTw8U4cN8WA2XPMV5ICv0Tnmvve7XW4k+dOG/xpl2n89qoQFMQjcYx/PJNbQFNfFkcwoFVJ28egrlc+2LyFakVimz2vZao/RNgPQp6rCaFJJ4jMhttG2A608Rr6w/n2je8JAP215TbNiqDSk6b0QkIAsLsn/yi4knyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788057829; c=relaxed/simple;
	bh=7UZKvLAdm6Cy1uerj4brTuQ346jOqe+rXvjsk9cO/zg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPcHXd+HoGAD0ggj6TDWcvwPtU8rzt0+4nd2sygG32RVpRztInqJ2pe6eKPzoLSy5s2Qhc3d5o4KFH8PqAUVgn8hlfUWRtDIRX0KgzfTC/CB2d+vCGldyzLL9Hb24A54hl6wUnLlEx33UFnk9EZkOvXwrsPJ7xfyDL1PQ45LwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+xntTBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+xntTBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD8F1F000E9;
	Sun, 30 Aug 2026 02:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788057827;
	bh=gi/j1OCnaHsVUjhQumOVcfe8lzq/EZcs1OdCEkla/0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n+xntTBi0rAzxFeaXQaJIljkCbmetcVADqVt3aqzMLPA4BjXCRuRE3WkU6QS/ToZt
	 M0L7rrmki9Ay/OzoICfsN3ppvMNVYa92rIErfun3rKV4U8PsuzgILwCifYtB7EmI3c
	 ugNpTfxHyiGV1pJNZ4GEqVjzSpLhJbAOQODmnT+FVAbV8hKz4NVOo5ppCT0baTpLws
	 VqBjGDAt7pq9b1bAs8QqNQo/sCTkNbOQ2Sjp7tFZO4ZPx/EGreqgyKFWDt/kDFo0cu
	 TrTMFKTCobSomFRI2Q/q8ive+14Z9n+6l+g4LMOmynrGKqS0edZiM/vMC+matGWCxi
	 u02xxA4ZE2L9A==
Date: Sun, 30 Aug 2026 03:43:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Triet Hoang <triet.hoang.dev@gmail.com>, andriy.shevchenko@intel.com,
 andy@kernel.org, bleung@chromium.org, chrome-platform@lists.linux.dev,
 dlechner@baylibre.com, groeck@chromium.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v4] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20260830034344.66af9be6@jic23-huawei>
In-Reply-To: <apEeQMMn9E7hRBOO@google.com>
References: <20260828021350.1666063-1-triet.hoang.dev@gmail.com>
	<apEeQMMn9E7hRBOO@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 05:36:00 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Fri, Aug 28, 2026 at 09:13:49AM +0700, Triet Hoang wrote:
> > Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
> > and pm_sleep_ptr(). Also replace SIMPLE_DEV_PM_OPS() + EXPORT_SYMBOL_GPL()
> > with EXPORT_GPL_SIMPLE_DEV_PM_OPS().
> > 
> > This allows us to drop the __maybe_unused annotations from the resume callback.
> > This is a straightforward cleanup with no functional change intended.
> > 
> > Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>  
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks

Jonathan
