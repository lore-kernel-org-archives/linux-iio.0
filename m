Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792810178;
	b=z78R9A2HRxrldTm0Gn6QP/dtK0XGWeDLfRuxUjOa/gxEXd12vOV2RwDJRz9dK7Ph3RsD
	 JznwHnuhcX0Q2Jmoc62fvGKbYTexYS/U5B7BO4zT5v9gFtE4MiAQtMSLw30zAlBoqydqb
	 ayXTZPOhRYXaxg4v/xxqseUNCeTF91nI4R/cZZZFZYw0iR5ujcRemirq4b/AIrFrsJS8c
	 G1/mkiSNnNsVJuDG9fpVGpabYgG3SYC8QbZc7ZlxcffD/utZcaGIiV+uzwIb+nPnyvEjx
	 h+sqvynVjtLEHlsuXQ+TpUqOfd1DF//vHFxZ4ptwL3r1ZYatZ+bj1sFF3nXKjA20LMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792810178;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/EJIguZTMW6iZ7OTq0b92hiXt6PDISRoKUL7T3JCRDk=;
	b=sHOQKfhYSSKsJfK8IP3fcOmQ9k5GsrY6cSkYjY4aGwWFqBZmIGnVxvZH58JjUFqBT5jh
	 tg9BZEYYtavra7JXGtkHvafCWJ85nnzuUhAkJlVZzqhZJvwGAgfsbIF/3VVnKKTILkHFL
	 bEXt73p9iOjNChKF3ByFbUsvmvt5vYb3oY4ntTCf1e8ZL4+QAFm/ofGlbFGZMXVpDbbTn
	 ntTGuXYz4UMDt1ScKuLl0LL4XKdTF4lsg44fjJR/Bqj+C+MnmYHHG0DSQHalfeIOzcQUI
	 E3puxd4Umq5B4q9H1G8iOMqc0fNHJ6552pJ7ER73OdEF6mIoYV4fVEmapKMIO9Ir5CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyyy7poA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0A606A31A;
	Sat, 24 Oct 2026 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyyy7poA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5411F01825;
	Sat, 24 Oct 2026 02:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792810177;
	bh=/EJIguZTMW6iZ7OTq0b92hiXt6PDISRoKUL7T3JCRDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lyyy7poAusJgWza7g+AcgtISxHIYS00pjOHBOpbRvGiH41IVQqoQc6z2n3d9vGlZD
	 Pl7JcIkY0qiF2LCISV3c8YMKTHOx6N3Q5DYOiPUyOaySCfor2xYFvamx0M6q54X9i3
	 POuLkXA8OulNPTTZN/mXHwAXNbp31l8g2gUXsRbO/K81uAXikF5FnNQQyCa4ijVpF1
	 Wz6MXIB87CaQdVm4Z4FA34vuN9aIPGjbfc/zUZG6n18Mv6bRIckl7hu0i1yUXcsCpA
	 13FjW2W135vn0GoKNX221e0DDqpGxyoOMbvgZNUsH7mYCiRVg2O6INlyttPPFd6Vx5
	 bMfG7BWpMIsPA==
Date: Sat, 24 Oct 2026 03:49:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wenqiang Zhao via B4 Relay <devnull+berringtoni36.gmail.com@kernel.org>
Cc: berringtoni36@gmail.com, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>, Joshua
 Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v4] iio: accel: adxl345: separate event state from query
 errors
Message-ID: <20261024034931.5d954108@jic23-hlaptop>
In-Reply-To: <20261019-adxl345-event-v4-1@gmail.com>
References: <20261018-adxl345-event-state-v3-1@gmail.com>
	<20261019-adxl345-event-v4-1@gmail.com>
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

On Mon, 19 Oct 2026 21:05:20 +0800
Wenqiang Zhao via B4 Relay <devnull+berringtoni36.gmail.com@kernel.org> wrote:

> From: Wenqiang Zhao <berringtoni36@gmail.com>
> 
> The activity/inactivity query helpers return either a boolean result or a
> negative regmap error. adxl345_read_mag_config() converts the latter to 1
> with !!, reporting a failed read as an enabled event. The disable path
> also turns a coupling query error into a successful write.
> 
> Return query status separately from the boolean result by passing bool
> output parameters to both helpers. Rename them from is_* to get_* and
> update the event read, disable and link-bit callers to check the status
> before using the result. Preserve the successful coupling-mismatch
> no-op when disabling an event.
> 
> Fixes: 66a1af6d8a63 ("iio: accel: adxl345: add activity event feature")
> Fixes: 31f7679bb69a ("iio: accel: adxl345: add coupling detection for activity/inactivity")
> Assisted-by: LLM
> Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
For future patches, please don't reply to an existing thread with a new version.
It can cause trouble for tooling and generally makes them harder to spot.
New email thread for each version.

This seems fine to me, so applied. I'm not rushing this one in though
as it doesn't feel very urgent so applied to the testing branch of iio.git.

Thanks,

Jonathan

