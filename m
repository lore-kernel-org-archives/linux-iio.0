Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794695674;
	b=Lys4Y2rxo4XSYnl8I/K4V96EhzFasK82bULjh3ApHPrh4AsNVqwECS1Zo17dEmv/M/jj
	 7ThQU5I2wJY0ZmF10+rVJCkXL1h7lYF7/6JP4r0lZ0LoeZbLwq8P6pHDcvQ5ck3513k7W
	 NMOIQuID3s7Ce8T85fd5wXZsCN8Ut5T2AbQ5SDkT6YETUTEhGLaqMO25Qg6GTebtQ9dSs
	 TWqJtTn088yFsj6LbENg8fpbJaTFjiRAYMNl8NEy3rjZaW6i04d0lhyV8OApgVV5f0I2s
	 nbjwchG5M6QV1plL+bEFVstal1+Q8an7ZX4Lq7m9nNFeGySxzPJ2AfYuUQ7+3Ygw06g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794695674;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9qpzHIfZJYRuI95UP3QUTLu4fdz4ZdV7Lss+/ZZ/Xpk=;
	b=kxvF5MKeG5k4j1GB40+QHESlZbV8BOBBQjTH/wk6FNQvBW+5PDCKDnW99pOKBkla/g2E
	 i/h6b3FHOrWGXW0vvwhyvWdaVNqkd4J7f4yDbSw25GNVY2nvEmHBHAWH1LU0NahLWNJN+
	 tZG2TxdHRR5/SkcD7TJuvizmq6ynn2p2mhmnKzDynCxt3xSXrB3IH+Fr3JhGq3FJH5T/o
	 vg7XXL8+NC/gcX7iWmj7fk2pIqzuCrg/PDJOjOz9Q603jCfVuad5/hVBYvEVfDCVZ65MV
	 UAKtUZE/8kc0VrxId73BkXaWI5/VPgxdYQLhVGk57SK9xFpYcdjO1kEDk2aPcfB0bwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gg7Omb1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8F606A327;
	Sat, 14 Nov 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gg7Omb1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D531F000C5;
	Sat, 14 Nov 2026 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794695673;
	bh=9qpzHIfZJYRuI95UP3QUTLu4fdz4ZdV7Lss+/ZZ/Xpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gg7Omb1BO6mPe6WcNfFLRW/5W+KopW1lrvdKTxi1QvUGDutw1wUCbtmuJ4t8eQe8v
	 Vr5hzqQT4i3qHINadokZAKJFanCpZNsYsNl/hxMqhTUyA8ovcg5N7keo2eTBHS2WBJ
	 ojc4bAT2C7pnBVzuOKTNQyXw5g09OfQcDzoyz2rbZ2zeuDsSr3QXx2MtDWOY6arTRO
	 yZui7ZzLgxaNimBLC9hmMZ8l2n6zArgLkrK6Cseh5OUb5UqN3l4dMaM1fPHflwheI2
	 O6/Z5JUbn53/2KNH5xB77kHUvNri5yfB44R8eBwvyPwB6lpg4lzpZ0rQDF85B2wNKe
	 GVnNGKMrJ42ug==
Date: Sat, 14 Nov 2026 22:34:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Satyam Gupta <sgsatyam@google.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, Enric Balletbo i Serra <eballetbo@kernel.org>,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Use platform sensor_num to unregister
 FIFO callback
Message-ID: <20261114223427.35545c8d@jic23-hlaptop>
In-Reply-To: <avElARDvNGQWodN8@google.com>
References: <au1FF5K9EALuqnNR@google.com>
	<20261106071904.142937-1-sgsatyam@google.com>
	<avElARDvNGQWodN8@google.com>
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

On Mon, 9 Nov 2026 01:42:25 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Fri, Nov 06, 2026 at 07:19:04AM +0000, Satyam Gupta wrote:
> > cros_ec_sensors_core_register() registers the FIFO callback for the
> > sensor number found in the platform data. The matching cleanup action,
> > cros_ec_sensors_core_clean(), reads the number back from
> > st->param.info.sensor_num instead.
> > 
> > st->param is the EC host command buffer. Drivers fill it in under
> > cmd_lock before each command, while the cleanup action reads it without
> > that lock. It is also set only for physical sensors. If the field holds
> > another value when the device is unbound, the cleanup clears the wrong
> > slot and leaves the callback in place, still pointing to the iio_dev
> > that is about to be freed.
> > 
> > Use the platform data in the cleanup action too, and pass the struct
> > device pointer directly to devm_add_action_or_reset(), so it always
> > unregisters the slot that cros_ec_sensors_core_register() registered.
> > 
> > Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
> > Signed-off-by: Satyam Gupta <sgsatyam@google.com>  
> 
> Other than the fact that it wasn't sent independently, the patch itself
> looks good to me.
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied to the fixes-togreg branch of iio.git and marked for stable

thanks.

Jonathan
