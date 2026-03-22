Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D540DFB0;
	Sun, 22 Mar 2026 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774180128; cv=none; b=GNUquFC5rBkE6dIXo3TQFZUIyLLHaMVt82kdkR78/IeW4Ds7NIjttFaVVeed2MsVSJ5c4v9mV91t2alO3sylzCGof44a3jrYVGVEbPub8+hRabWx2yGnWJEUvatdtzbdfN/2QEYvUu40KZFCoXRNwZchscCM5kZGnSRW32xOkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774180128; c=relaxed/simple;
	bh=OdsYqloqzHCirncmhCqHMYnNzN+ADoPtoqcWw3rGpfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgcZJDjcMY3DginYKVAs4yA/JUf/eSKnuFLj5enDuL7r6OoqEXwmosoNfM9B/NRulaKrpZg6IXBse9gRkkWqetTZO33+QnNOiZlJQ5wO2+x2GGfW3Iz8P06PZyZC19tDDP4eVt0ketAl3TWrAR+ybvaT+wyAuXPmCmUZBpoEMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA0HWJZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA0HWJZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F88DC19424;
	Sun, 22 Mar 2026 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774180127;
	bh=OdsYqloqzHCirncmhCqHMYnNzN+ADoPtoqcWw3rGpfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iA0HWJZnFihV4Jg9raTnAuIyWXzAAl+Ax8F6/KXKdpBdYbrLsnD2wvN9NpdBS9867
	 TJ+VPYd6vZUEeaLO/ZK8uipO4bInct9CWYNQvpQdPeJw3NhX8AwufhcErPx573+i2k
	 K2BLZmOMM5CuKpPOviwrVRLpCU/dVwaj6yvNhZUExGPdWhFoc7S+YoWHWATbaDmGbv
	 lnyvdzdkQiPJnCB91YhoeuIsb9/FcF1Dwxo6gPwyVo1y+j3cb9CtT/P2zpT3yaWbrc
	 i45/aeRTtCFRufjbvsmNLzTpwYjzwb3udqqpta8g4orkeCbTndlrVsz8ZKt2d7b5Sv
	 x+PwBYK4WC7qw==
Date: Sun, 22 Mar 2026 11:48:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Lucas
 Stankus <lucas.p.stankus@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>, Mircea Caprioru
 <mircea.caprioru@analog.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl313: add missing error check in
 predisable
Message-ID: <20260322114838.0356f47a@jic23-huawei>
In-Reply-To: <abPb3N1wNUAa-R8x@ashevche-desk.local>
References: <20260312112025.57554-1-antoniu.miclaus@analog.com>
	<abPb3N1wNUAa-R8x@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 11:41:48 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Mar 12, 2026 at 01:20:23PM +0200, Antoniu Miclaus wrote:
> > Check the return value of the FIFO bypass regmap_write() before
> > proceeding to disable interrupts.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied and marked for stable.

Thanks,

Jonathan


