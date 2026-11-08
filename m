Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100346;
	b=5A9HIMjGdq4vAylYdx09EnVQJ2elg5y5aTioTjxA++WGxOl7JAuFTP2HBcXtEGnPGBuv
	 taZxRi/an2GI4H4M3SWGK+guKS2fjsvMht4JRxYvDDqWeQNQWdqHCsLoustmZYkpCTqex
	 oClniXbWC+Jpn9P/7XxTIrXtLH+qm9qbi9iQWs/guHTv8xXiHMZj74xArtOGCoplFY6oK
	 cDFIw6C0fPnOnH4FZC82Ldf+7Z/1Xe3WTbutgDu2U6q4aPHFoUtJDFXXOG04XG5alYd6C
	 mUXvjIPjdVIStYbsaDlqoLp9vfgdgdhvG0gTpsrlmGH42LqGzl8KnZFN2F2IqdePAUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100346;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iwdMWMqlQ02yEmWZxUvQtiX/14rErqQTe8wlPbAoNbM=;
	b=Mj0d4YtTr1V0xxVeDh2gBGU6GqeV8n92u/1J+wJZEmWl2XwjwMiRGbmdtBcToI5HavcK
	 PP5ixGolX2W6Ubrr52ambJiBeCPB4HI1rdYDyGVDNfM/9R2I7ck++meSRvPw3pfl/cVN8
	 qq80iGGaUlwWfQP2kHYgH5F7Hab0fa785nTRqhQwFAdBOEl8GjCGGH4P32jgL/F9dO4RP
	 nqTvnykoZ6N+9//CWGzRqzFhJ/0E2XeBWK8waG4gRMYKYylpXE/2DZDrrlr37uY4fv2U/
	 +d9f7ix26jpnk0fTn7K5eg3JV7vGHFc+L2Lx7+A/CsVkhCIB5LZVlQk8pa7ZE6I9V1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEOOPakg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DB606A326;
	Sun,  8 Nov 2026 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEOOPakg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8021F0089F;
	Sun,  8 Nov 2026 01:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794100346;
	bh=iwdMWMqlQ02yEmWZxUvQtiX/14rErqQTe8wlPbAoNbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hEOOPakgj8YpZY+b/Z3xYgZSjDF1+6CtcSeRbZDg8KscbhqPAp/DxK4ECSq0941Qj
	 mk21/IkBDGYzQXfRcUDhvNyNUHEMhImr4rL+tNmagjiAx7xkw9otvlYmncFcbbcCja
	 K2jT4Wpc7deTs5aEbvChWRepw7tY6ovXbplm563lAjvUvxqBqs2BQWDHQvJDdsjs2H
	 oiSih4ZIFwUOlXamTrMOVUSX7IT+wJgUU60DnO6otUxp2PfWEPfM4qBt0wKTsIN/y9
	 Cy/zaUEyCTACHMQiLPfadozdhmEG+a4h6fg9PvNblgNvvpiFVUJ04RHRv9HYX3KDEf
	 jJIFNiaNhdI4Q==
Date: Sun, 8 Nov 2026 01:12:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Matt
 Ranostay <mranostay@gmail.com>, Robert Eshleman <bobbyeshleman@gmail.com>,
 Leonard Crestez <cdleonard@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: light: max44000: Report the available lists
 via read_avail()
Message-ID: <20261108011219.6e69e92b@jic23-hlaptop>
In-Reply-To: <20261102074700.63075-5-arka@arkamondal.net>
References: <20261102074700.63075-1-arka@arkamondal.net>
	<20261102074700.63075-5-arka@arkamondal.net>
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

On Mon,  2 Nov 2026 16:46:58 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> The light channel keeps IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_INT_TIME
> in info_mask_shared_by_type, so userspace sees in_illuminance_scale
> and in_illuminance_integration_time. Two custom attributes list the
> values those accept, but they are named illuminance_scale_available and
> illuminance_integration_time_available, without the in_ prefix the core
> gives the attribute a list belongs to. Both land at the device level,
> paired with nothing, so userspace that asks for either prefixed name
> finds no such file.
> 
> Report both lists through read_avail() and delete the two attributes
> along with the strings they printed.
> 
> Each list uses the format the write path accepts, which
> max44000_write_raw_get_fmt() gives as IIO_VAL_INT_PLUS_MICRO for
> scale and IIO_VAL_INT_PLUS_NANO for integration time. The scale
> is read back as IIO_VAL_FRACTIONAL_LOG2, the same number written
> another way. max44000_write_raw() still rounds a request against
> the ulux table with find_closest() and against the ns table with
> find_closest_descending(), so both tables stay and the lists are
> separate arrays of value pairs.
> 
> No value changes, but the core prints each one to the full precision
> of its format. The scale now reads 0.031250 0.125000 0.500000 4.000000
> where it read 0.03125 0.125 0.5 4, and the integration time reads
> 0.100000000 0.025000000 0.006250000 0.001562500 where it read 0.100
> 0.025 0.00625 0.0015625.
> 
> Fixes: d5d8f49b6345 ("max44000: Expose ambient sensor scaling")
> Signed-off-by: Arka Mondal <arka@arkamondal.net>
Applied this one to the testing branch of iio.git.

Thanks,

Jonathan
