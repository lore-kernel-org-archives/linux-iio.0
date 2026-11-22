Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377385;
	b=RfkV0A3cZs9qP2UC5LkI810DpVGqc6qqzcXK6YwSaox03B4KsHnOjyHyDzLkBjjo13l0
	 oGAEn8rBv8L3RYUSATAQ8hXiae3Z5xE2bVpyxDfTiuz5+FImO0wceALM5Z5MCdw3gttjE
	 TXZdXE3qIJIFiZrGT+zPZQ07ZLeaBaItUQPofAeGauWKVIC1rs+3SBuZo8C+IF4v/SpEF
	 9t9GqfjWnKi3YXSq2kAW7B6YGps9+gq4j9noAPNrEBOojkbUvz5MTtn9lGVL2xktMr+2C
	 8e6lWNS4VvpalueNtCg1hRQ+osVKMrNE8hS/G4up7qHH6ILH9FJthmSd2uWBoRuYaxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377385;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=liASWUQ/EzWC9g8522NV61YTzcOMyb+TgSkw8DA+K00=;
	b=VpYysXiU5QW5E/0i5K8I0h1p8CLDhvQOwEhMWYcot3Fp58w4sgvL3Ul9+SNTJIXEzKny
	 RfgkdP8kfFGrNcQMXMnky/zxODkNeI9Qj0MbC5GtGaGLtvM6XI8Wq/jHs+V19/QjMsfz3
	 K7NaydJGAsfy2xPqipUpisqfE30wlRk9v6ur4qXt/4QKXKlxzXCORU2bGi4Ge8IH2hAO+
	 wtm3sd+bp4yAaVDoaU6D4bNOcjFubW9ATBNrgCe9XKEGxie0C+Fn6racagbQjBsAKRdVY
	 RR5ZvSdSfRRoP07IMcMHSkkaqyWgWdXHHddHF9p2kJMDHWl/mfVrL0FtGJ3UkO0JlTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdvNsP1q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B8606A327;
	Sun, 22 Nov 2026 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdvNsP1q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE85D1F000E6;
	Sun, 22 Nov 2026 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377384;
	bh=liASWUQ/EzWC9g8522NV61YTzcOMyb+TgSkw8DA+K00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YdvNsP1qCiXwr+e1Xp+Nns+Iw/bmhrArRYoEtTDZPmENOTSP55Fb1XO7iQ7NCb+Uk
	 2nSJaBCOQN+aAM0Zyy/p8Hq5pTSJF077FlycP7jgBYDo68EbpwGSaqy+N/XMhTnR4a
	 NbhGZCl4zj515t1B/J3F4wIP0S6eMrh8sWlRayF2KIgjxGAwKJ2yTuGruwkxAb3xbt
	 U/hy9NP+98sxdrlKnHycRmyFUDz31pypIl5UhWj2ko44aU+awN3IZmx79iBynJodeF
	 o0D+7HReiq7ha12jxQd2XuVpLdRlhUwPjHGUawh5gxbXGeOp902oJSGlWz95a4cvJz
	 cixt3PdZudoJQ==
Date: Sun, 22 Nov 2026 19:56:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: core: Export iio_find_channel_from_si() helper
Message-ID: <20261122195619.238a2f11@jic23-hlaptop>
In-Reply-To: <avsMhZRNo7nJaGDQ@ashevche-desk.local>
References: <20261115083049.46840-1-clamor95@gmail.com>
	<avsMhZRNo7nJaGDQ@ashevche-desk.local>
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

On Mon, 16 Nov 2026 16:00:37 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Nov 15, 2026 at 10:30:49AM +0200, Svyatoslav Ryhel wrote:
> > Export iio_find_channel_from_si() in the Industrial I/O (IIO) core to
> > allow modular drivers to locate channel specifications by scan index.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Normally a patch like this is part of a series using it, but given
on this rare occasion I can remember the connected series, I'll pick
it up ready for that.

Applied to the testing branch of iio.git.

Thanks,

Jonathan

