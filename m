Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793160994;
	b=OhXnH+QrmrLO5jO3qTGc/zCInt/pLKkXCOPmB2oUKqun5ExLuuFOF1jbiybZ4RsQVfcf
	 tV8RwzRvjJRO+Y6GxU8Dmh2Rv2agTaK35N0bDaslt72jAvd5zkHA7eXO0UCYHI1x+D7Iw
	 EIwFA90FN+KdKj8EVUZ2AHQcfAf3B5yX7vZIWAZR1+1AjYXbVxjK+MJ1RQBmtlbgTSkLF
	 YZY7F1LnFDCVqNaR2cEQsAJ77+ooAKnbED+lMwa8HF06NCKzUbJUosyL6dGbIniKfKzgD
	 euWhAiYM1yCDZMru/n/IPQ4At5oW5yDKWLghY512Q+LKdsdK7w63mr+YUCoCzi9oJfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793160994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bqr5LFlLDjohW6x4hgPjC4WeE9jd+dhVprKk2d3u/uw=;
	b=5ilz1BsUSfRQVWwx8KsX/3wBNbJ2PLQ/NMt6kcEend0aF5eNLAuKjeviJ2lOnJisXQLC
	 JexYkPgSVgcmGuj3cOyOw/JGJpjiEc7GJiDZjqz1ZHbLWuRaSfXp89YS/HjFICtRiaWYW
	 m2hMPxIp2i+/EZ62fjCVOG1DcwVQx3l0AyCQJuQj3PUfoBKjm4Q5/qeQ3hEZCNC0E7Dlt
	 V0tQ/eQVXy5NPi6UAZHTvNMhpPcq4o02JOEBYGxcrSFN5dtpVwtm9rs++M6yFIR7xeCBL
	 UlZkDk0tMNK4FbxoPdY5umKNfbJqQyZJrsFt8GsYGIJOxMAihphD8wjlUu33l18NDqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=h1aQrZVx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D994606A31A;
	Wed, 28 Oct 2026 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=h1aQrZVx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C7D1F01825;
	Wed, 28 Oct 2026 04:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793160993;
	bh=bqr5LFlLDjohW6x4hgPjC4WeE9jd+dhVprKk2d3u/uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h1aQrZVxyxe0TmJfBWEKi1I0hu12HbFZVbvb0Fu2dqrM25TDfwS5BuRtWMpOS6wpn
	 D7Af/hR346lhzoS8+H05jgZXYhI2CnDqEo+s2V8rCPB68pr0Twlslc2VnwBDLEs4xu
	 9oox5eKcQbrVkVt9UScupxzxSEMI8iI0oqBehX6k=
Date: Wed, 28 Oct 2026 05:16:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lucas Rabaquim <lucas.rabaquim@usp.br>,
	Matheus Silveira <matheus.feitosa@usp.br>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Joe Sandom <joe.g.sandom@gmail.com>, Jan Remes <ciakval@gmail.com>
Subject: Re: [PATCH 10/15] iio: light: tsl2591: don't divide by zero with low
 gain
Message-ID: <2026102809-untaxed-vanity-856f@gregkh>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-10-0d818334f6c7@linuxfoundation.org>
 <20261028021302.0430a947@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028021302.0430a947@jic23-hlaptop>

On Wed, Oct 28, 2026 at 02:13:02AM +0000, Jonathan Cameron wrote:
> On Tue, 27 Oct 2026 17:19:14 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > The number of counts per lux is the integration time in milliseconds times
> > the gain, divided by 408.  With the low gain, which is 1, and an
> > integration time of 100 to 400 ms, that is 0 in integer arithmetic, and
> > each read of the illuminance divides by zero.
> > 
> > In that case, multiply by the coefficient and divide by the product
> > instead.  The result of the other settings does not change.
> > 
> https://lore.kernel.org/all/20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com/
> 
> I have first few of that series queued up already.

Wonderful, thanks!  Proof again that people keep finding the same bugs
at the same time with these tools :)

greg k-h
