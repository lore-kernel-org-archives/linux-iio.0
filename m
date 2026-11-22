Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318101;
	b=4dz8OdqwOtDBb54okzNDoSNIuzJFirl4ABPZlMTpH4FXRy4ZWbcX7FNrGaaz7I9ZIV2D
	 UtaZwccwbhKEOcf/X94GASlDn4gLseVwdSxtQ4SLm9+67hP5qew344J07GDIZr/gDvgTj
	 7Xe8YNTfee7jzUmLkMrBVHlE0iX3PFrS4mKPihH/xcmZl4RU91P+MFuLiUgxmAZ7zL6lX
	 tYPVqsQxNd7tAve24na7wuczpnEL6oPNGzFvDH1JFJ96ExA59nldXNxjyxJ/BzCRbi7+I
	 DGJWEnt6BXyzfU4zr0jBT+CrV9mjtsHyxQGBRwwYcfSvBim4+kejOix+5PrDGhae8Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318101;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uyrZsyy6Aeoky9OP45kMgfquTlObH3vpxf7jxRnUhHo=;
	b=o5APfhA2uiBlb+eEv7QRINm1VXmaq6SW4DHRlGn5VugYRYED4BDYbbqM2r0gA9e/kn6l
	 7e1zkO6GLMbQkGbySuopEI+0ANs1RtK06V3JGk4NdNG1lNfXJW1ZeEcLv3iELXQ8MciPC
	 PuXsNz65CILCDRJXPNPdqJAaQyanRu7kEjM9+NxIL6mv+WzaTEbXLYAERMvUWitM8w/2I
	 Yv6f5fXWBQAi5exqpD+IsABwluyjXzBBU2uCQMT0mHT6wgHnfdrXAACX5cPP/kOHF11NA
	 VC+0hCxK4+td5e1zkm9I5cFPUAL6XEJEAmJzuSTdOtB8kMy5jin/JgdpbG8RgzHiInQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djNjRPOE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36025606A330;
	Sun, 22 Nov 2026 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djNjRPOE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2741F000D0;
	Sun, 22 Nov 2026 03:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318100;
	bh=uyrZsyy6Aeoky9OP45kMgfquTlObH3vpxf7jxRnUhHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=djNjRPOEXwlMBsORXvA9dPMvF/noXRqwsL0m2PBy+DWbW2PyQtRxuXtfSRKcqTYtl
	 l2+ldjAqnbH7pSa3SxoTQ9W9u1GHAEQqqAHM3g9A7Y+LUv8aQuumMi5x9dkGECoCBc
	 8onZlqmW6ykZcufPmUa9x+ZtT4tDo2dAWzLSbEPPYbU7WZowy/quNhAuqfnRoBsS+5
	 r9gORN075rbtz4vMWDB8kskz56HFUu+BwhVoWiFZVKryH1mAP0xsPK4TXYvTIYR/ny
	 tlQQm3CqSfRWktMhCKzqRPv9UHaZUr8kU3/O+n/VCCLbtna1tt5aQuA/xg9HBJzix0
	 N1RCCVy6L6GJw==
Date: Sun, 22 Nov 2026 03:28:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: proximity: sx93xx: fix raw reads, thresholds,
 hysteresis and gain
Message-ID: <20261122032816.49171917@jic23-hlaptop>
In-Reply-To: <20261116205320.26070-1-kapoorarnav43@gmail.com>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 02:23:08 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The remaining sx93xx fixes I had, sent as one series and grouped by
> driver, as asked by Jonathan.

I briefly looked at this lot and the discussion you and Andy have had.
Looks like everything is heading in a good direction so I'll wait
for v2.

Thanks,

Jonathan
