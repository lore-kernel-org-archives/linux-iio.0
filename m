Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100694;
	b=1vCYkj3q5aLShfs+9rin+3sL/zaquiOOrs/Eorx28ssxxgqcezG+P67aI0sgBiUMfxhG
	 AB1UvxW46k+U+6QcpxvCFEgvZukhOrzL1gbvKsySCj3LynUf65te8ugs0Jm+e3vT7XF4b
	 yfG6ry9FeZZuW8UF0FDOxQ2CnnqPn1X9By0mEoNzYhtJhqThSL0aP8koV4olLSSdGjkVe
	 0AzN6pphcUFeVpvwwsUR0KC7tF+JuerXKSVznhsd1spwuirZvHedbJb3vZ5ANsRKUjHbZ
	 /GImPoOX5DtqPm8BV8DBA6OAfL58n1AEz1NHncX6RGfi0n12WoAXXkpCABxre2EN2jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100694;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JK7NO1eDXQxSmIN2+W6XYW/d69x6gGMvCQMUatF0fy4=;
	b=Si2YdiSG2iQbjxnhhJJvqZYMPvbaTMIAvpmuz7aRVef/7FjkorK2+rOWQWg+LVEsO7KY
	 hjqVW9uMAwnNqi5bOZkkAbG7SxTSX3tND9f3i+LgOVPzzIHNMGdfTFVy1dvhoGnw9582n
	 lrJEA1H1Zg1RaRGEv+WrwvvVbiUKV5WoOm7jEN5OWtZKO1Q45rFYaxZu1kRIFmtQwRTSU
	 ck77ubPN8kH2Qk//sigfxss9UPrtHvAwev0kg/lp1bDPcYvX6Juucs7sGXKLhSox5lNu6
	 Ma7kEoMKmvdk+Vxds3iMtzlzfsxWaS9+xkx48Kk9l88fmWTAElFuaY/of0ky/j4aBrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixKX2HNW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83D606A326;
	Sun,  8 Nov 2026 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixKX2HNW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA25C1F0089F;
	Sun,  8 Nov 2026 01:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794100693;
	bh=JK7NO1eDXQxSmIN2+W6XYW/d69x6gGMvCQMUatF0fy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ixKX2HNW1LhbWoBlGGGoUi2FgBFdrfzQ8nE8pSnZWPPc0FIunqPUSq+zWdEYWs0oS
	 yHPhZeEZ2DYcXp2IU2CofLfktx68tam1hBsf9rLxhI8qWfIFmM1OxbCObeVqUiwOFB
	 jHwGpy6Ds+EORqQuXUZ3hVcAd61T/Fa/7tve8tChFGUq/0t9v4RvrxeSv3GTLh76u9
	 CT7LWa0b6366gNbjZ7AEqVWkVC3SeZH58T1vB5KcxUH2gVpb8Bf+eV9mjwgmxqGnWT
	 +yaEtxbmeyxnVBEEQAuK7wF0AJNv7LzPcvahjJHnOoTxpXhxhtmry00gwsfM9rpaam
	 wOl55jptl2McA==
Date: Sun, 8 Nov 2026 01:18:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Matt
 Ranostay <mranostay@gmail.com>, Robert Eshleman <bobbyeshleman@gmail.com>,
 Leonard Crestez <cdleonard@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: gyro: mpu3050: Fix the scale list and report
 it via read_avail()
Message-ID: <20261108011805.536075bc@jic23-hlaptop>
In-Reply-To: <20261102074700.63075-7-arka@arkamondal.net>
References: <20261102074700.63075-1-arka@arkamondal.net>
	<20261102074700.63075-7-arka@arkamondal.net>
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

On Mon,  2 Nov 2026 16:47:00 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> The angular velocity channels keep IIO_CHAN_INFO_SCALE in
> info_mask_shared_by_type, so userspace reads the scale from
> in_anglvel_scale. One custom attribute lists the values it can take,
> and that list is wrong in both its numbers and its name.
> 
> The four numbers were computed against 2^16 while mpu3050_read_raw()
> divides by U16_MAX, so not one of them is a value the channel ever
> reports. The list gives 0.000122070, 0.000274658, 0.000518798 and
> 0.001068115, where the channel reports 0.000122072, 0.000274662,
> 0.000518806 and 0.001068131.
> 
> The name, anglevel_scale_available, has neither the in_ prefix nor
> the anglvel spelling the core uses for IIO_ANGL_VEL, so it sits at the
> device level and userspace that opens in_anglvel_scale_available finds
> no such file.
> 
> Report the list through read_avail(), built from the same
> IIO_DEGREE_TO_RAD() terms and U16_MAX that mpu3050_read_raw() uses so
> the two cannot drift apart again, and delete the attribute along with
> the comment describing the hardcoded factors.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Arka Mondal <arka@arkamondal.net>
Applied this one.

thanks,

Jonathan
