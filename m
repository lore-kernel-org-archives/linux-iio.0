Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379609;
	b=eMc0sI3x7sLGnuHc4POW1pYjlt0P18MeSXwsCg7TjNxdxnwCSs1KJMPcy6T6mDIPSvIP
	 k6KQcaPnocJaaLeiTAviF6O1ZwWzE7CZ/xarUsAQKA5Q1Ymwd12SwzQsWNdHlZPyEx5la
	 2fHcJaWkO0Xs37A6fqSAyGGe2OiPniXfMvKhk2Kq+bzJ7u2PkYh4RB3gsjdkCeoLsq5LH
	 2EhfmzkKzz8iVKqmBDw5GKLi3t6meHjlv1ZQnBYykRapnAv0hdKlTq818Qf6DgnDKVMV3
	 ClYMCU+9cVa1H3COTzrRbQvcnNKvBPCYqF67gLCMuShu/GbUHlK2LJgIoYjHfFNmHwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379609;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ncs5s7E8vhxzalQAO8dV1IfWTpuClkjdKm/O3dTYfII=;
	b=YZxRJwM6skuuW4/CE8m2SRf1X4ykDkD71/trzBpkaxoXLIFR+T/OnFeIkl6GZBmvLrZ4
	 uYn23XbeYGlsA/Tk0ymeFnD9YeC/exnV73c7TVs57Musw9Q0tmo8uKJj6M7p7S8yxDdoL
	 SLNE6TqwBViTBO22dQVk7rBk/NiAHCwxP8gnMAitwAlrvfBAr68f7A5fMn7fX7gsAHn6I
	 6OukSKhpAYajKTBD/HuQv0fwj54T0AddZCNiW/hgCM/2hz5tjPJbj3moJDUr5XLPfNbFd
	 zCobW9SmphN60+6ZowfWqbIInu1EDkDYkDxlPAIcxVjIyZr7zYa5wojtb28N9eKVvZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJGy+JRb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922DB606A31A;
	Sun, 22 Nov 2026 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJGy+JRb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D971F000C4;
	Sun, 22 Nov 2026 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795379609;
	bh=ncs5s7E8vhxzalQAO8dV1IfWTpuClkjdKm/O3dTYfII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jJGy+JRbq4wWt4jtTosk92GymrGNTBwfY8MiCeMv782kAIUAt2RlM2lDM1AvTIUbJ
	 bHRcUWlE5ijqx6MIQ7vo+AeNnONdCdMpRAJsVyMhVxVYeXrem11VoCzfHezOZjkfMN
	 qpB+TgI7Siln86ZqWNLR60ySJYxvllBryOEyDMeOxdPKGbldVTVjMJwDv2vaUlm2P0
	 dbiDa6cKSeirRBtPigyFeyy6HfoCg1k849xem4H6RWLlBPNoOIRF6MAx9mKoOi/LrF
	 nE4QuqNDpa0R6/vsJK/4rXuujKYdIrrVeTe7nByv1n84JIWzyCJhxf+dKHTJZELPSF
	 P2bz91inPz0TA==
Date: Sun, 22 Nov 2026 20:33:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Niloy Meharchandani <niloymeharchandani@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: msa311: use devm_mutex_init()
Message-ID: <20261122203324.6298b59a@jic23-hlaptop>
In-Reply-To: <20261115035557.178492-1-kapoorarnav43@gmail.com>
References: <20261115020129.10259-1-niloymeharchandani@gmail.com>
	<20261115035557.178492-1-kapoorarnav43@gmail.com>
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

On Sun, 15 Nov 2026 09:25:57 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> On Sat, Nov 14, 2026 at 06:01:29PM -0800, Niloy Meharchandani wrote:
> > Initialize msa311->lock via devm_mutex_init() instead of mutex_init()
> > in msa311_probe() and propagate any initialization error. Include
> > <linux/mutex.h> explicitly.  
> 
> Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> 

Applied, but Niloy, these are low value so I'd suggest
moving on to something else for next patch!

I normally only take these form new contributors or when someone
is already touching the surrounding code.  It isn't worth
the churn to take them otherwise.

Thanks,

Jonathan
