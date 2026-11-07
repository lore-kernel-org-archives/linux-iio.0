Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794083353;
	b=Zz7kgBLDBmKH4p+IsH3YUaHHEEBybLwUlAQDN/f5obU36HQ9xjfg/ldWjJUT5vRW+N32
	 WWQebH4OpgeuS9PqoP1ifq+ondQLWhYL1WF6x1zI5JLE/Eh4d6o+foVyTVClxSr1PmqnT
	 /on4gKRJ7eVn7I98oOiR7qQBaTqbXiYLUaKK3Hgrdo1bpewtnKxU/8d0SBiKUJ5hJ4Amr
	 9jr+QK0G3vOa+0gUTGt05MMo1TW8Jv7UxgwSFFZxG0lLO94BjHtkH+CDAPVTm84w6Kzrq
	 Cn441x9IEPlK0RZeMrzzQ1nd9csw+FOqcKjRQ6tfnPNhXdGK9eTNxWfHUxrE7HuMvWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794083353;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Wf8LRi7Uf3+oQW7K9E6o9x3Rb0ptS6c5Ok2tb6AzWHQ=;
	b=jA2fSYSMXRG4wMwor84chlJM5TZ3UlIiJ7LDXY+KqGaLvT5tQeibVJwxyQ4RatFh3kJp
	 kBccOVBVIHn4vzdYJgtCPzCBFedQ1onxbMDgNfH6cqYIQrJtjxFNqmCCoGtgNFIIrIOIC
	 q0QWH3XtUqhx2vGpBGxlzVnEJxuUfqtI1aCVrf4cqNFOqli90FxEfLDlHZ6i+Qh2GLmql
	 c1S1rV6N1wQ4L83f8vCErFuCc6mZVlq1eKUHJ4GWiMPvp21WNyLeShNTRZ9TEUZoul/y2
	 Pc3CcWW6XWGKK/uFWwFXHvDSLiD/7YopTLnkbk3NXjBZ4df46UHmRzawsrFFDiejmtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=edNNXuer;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F4606A326;
	Sat,  7 Nov 2026 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=edNNXuer
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B922F1F0089F;
	Sat,  7 Nov 2026 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794083352;
	bh=Wf8LRi7Uf3+oQW7K9E6o9x3Rb0ptS6c5Ok2tb6AzWHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=edNNXuer2i6+dBOSWwbk5rBCGZYCkrG3521+DcYD4chBZjmaFaFlMZMzWptLtHDqI
	 pL4Ip40b13HeTbM5WzDLMLCTKJIrnrsvCHQ3rJBmRtk0BDXIieLy2a+icKRqYUcVnX
	 ImGLItlkOgavPUhVJuGfqdU4uffn5r9nsr2WZQPfT7dpc4c3tjiuzBnLmZGIMyM3I3
	 v3muTTIy5WSDf4whh69/sNWJLHHmSPxOxrkHF2zxy+hc7gyEGRTZ9eQXHBiyxay/fI
	 efAxHA32MxAydnHlWUu+IGYnBOAsUYdMQ7Qx2OPZJg6RQ5Ungedbd/f/CDBP4JeLT0
	 MO1svhtvh9RtQ==
Date: Sat, 7 Nov 2026 20:29:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Joshua Crofts <crofts@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] staging: iio: addac: adt7316: sort headers
 alphabetically
Message-ID: <20261107202904.2b3db8a0@jic23-hlaptop>
In-Reply-To: <20261104183429.20125-2-abdelnasserhussein11@gmail.com>
References: <20261104183429.20125-1-abdelnasserhussein11@gmail.com>
	<20261104183429.20125-2-abdelnasserhussein11@gmail.com>
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

On Wed,  4 Nov 2026 20:34:28 +0200
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Sort included headers alphabetically without altering the list of
> inclusions. Keep the <linux/iio/*> subsystem headers separated from
> the <linux/*> group, and add a blank line before the local "adt7316.h"
> header.
> 
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Needed a small tweak as kstrtox.h was added recently.

> ---
>  drivers/staging/iio/addac/adt7316.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 20f6052cc7fb..515f1fdae46b 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -5,22 +5,23 @@
>   * Copyright 2010 Analog Devices Inc.
>   */
>  
> -#include <linux/interrupt.h>
> +#include <linux/device.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/workqueue.h>
> -#include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/list.h>
> -#include <linux/i2c.h>
> -#include <linux/rtc.h>
>  #include <linux/module.h>
> +#include <linux/rtc.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/workqueue.h>
>  
> -#include <linux/iio/iio.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +
>  #include "adt7316.h"
>  
>  /*

