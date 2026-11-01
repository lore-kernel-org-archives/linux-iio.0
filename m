Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554218;
	b=Grwn5cceGNHyZUj7RHvE2NuH0i84k4B3SXmvCKxXipAXnST2xiicOEh3GzGaoJt3WY3c
	 3a18KkT5maoN82gXD/vnJmm9HPkmOyDj9ebbt6ayVDTJe7CAyQWqGJHivnGy5gbdb75zW
	 D22oRNjWLhtSgpUAS0wMHQz7OnTkCBJdqt6ejsFcJUWz7CpDrQySNCd3J05eqZg0xed9i
	 0p4bscAE88/YNyDlcxEk70SnygvRNohFu+6ioWzhslvUYQjvP1j+08JlGelPDpQhvxCrp
	 BWuNCm3WOYAz3QuOqYxBsyER6Xy9A5LDF6z0Jptz+g7N4kp0b2BgC9BQo9nq+zdCsNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554218;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MX3rQtix3+DDixgHo3LU/+2TjC41WR3Cz31kSiIgb6g=;
	b=d72JGH6wYORsoWJKiqAZQVOSEMYkdQyvbIyvoIeV+MynQSyZNCTKEKNt1M+ETGX8aLFU
	 LdimBkn7suiyvSsdmgeyLaZ9Iy5WA/RDutOmJrJRvRI8nOMYyKnUbIdaYYFHqFW0ZR9Q8
	 bG9Ftrl+pUwBN8wZANf9GxlRoi9OaiNwPoCQchcA9kE0jVLCyY/qFOK1Hw+vmbHjiPJGf
	 y8/dZBZqYug/2dy0ZNIbSniLmhN7+yjSioGOwXHrsnQvYDOE3ibLuwvMT+4PKe9zQB5wa
	 4BTVRytr6WoWrl3A0msKFfadX2LIaz3CjyArpPxFC1Ruc+Oj8122yitcewX70XI09ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HszQ1xRw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356D606A326;
	Sun,  1 Nov 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HszQ1xRw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226331F00A1A;
	Sun,  1 Nov 2026 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554217;
	bh=MX3rQtix3+DDixgHo3LU/+2TjC41WR3Cz31kSiIgb6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HszQ1xRwhWZdSGZj1H2uUBKo0tXN5UF/Bp01yPK+sLH8M/YW9CXBqH/ylVNSZDkWS
	 3PHOssbTeCOnkPnobsvSs7DC4g6nYHd+7ABrMs7Lvk4aioVuUVerK0zre8kkyqwbnZ
	 0mupMpKVd00d2uBVf0rY/+GAlZIThY+b5Yybpxa0YDBGJtC52d4IXkjsirQvwea5qd
	 D3XdxXBsPHKY0R/NGIqp7BF5v9hQ9HBfKQGq1JyA5d89Z3cT0MPKzFvI/38TbmhAqu
	 CTa7axTrnnVK7aRP7zgRp2wSchrfG6CVk6PdtF6Ok0j35TRNT92PE+lYiNrZ9qx3M7
	 HukpCOdb+/AZA==
Date: Sun, 1 Nov 2026 17:30:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley
 <joel@jms.id.au>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>, Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: dps310: reset the chip at probe
Message-ID: <20261101173009.3549f50d@jic23-hlaptop>
In-Reply-To: <20261101105855.55716-1-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
	<20261029220635.18816-3-zoone.rupert@gmail.com>
	<20261101010444.2803dab4@jic23-hlaptop>
	<20261101105855.55716-1-zoone.rupert@gmail.com>
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

On Sun,  1 Nov 2026 12:58:55 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Sun, 01 Nov 2026 01:04:44 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > > Reset the chip first, as remove already does.  
> > Why do we do it in remove?  Does it put it in a power saving mode
> > or similar? It's fairly unusual to bother resetting in that path
> > given as you've seen here, we pretty much have to reset in probe.  
> 
> Yes, in effect. Driver leaves the chip measuring in background mode,
> and soft reset returns it to standby (datasheet 4.1). It came with the
> original driver without a stated reason.
> 
> Writing 0 to MEAS_CTRL would also stop it, if you'd rather not reset
> there.
I would prefer that as it would avoid the need for documentation
to say that the reset is there to put it into a low power mode.
If there hadn't been any other way to do it (unlike writing that 0)
then I'd have asked for a comment.

Thanks,

Jonathan

> 
> Rupesh

