Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610538;
	b=qrnxr+Ub8rlahsNlyyJa0h5Z9im/FqcmOk9UVATRc5ssvqWgzAOV2CbNOPWsi6FtG8+N
	 kpob0DEN9Ddr72YYXW7ux1ETJT8P6OznOEOf/lnFuHL1jhBo6XOWtObzbmHpd9QRxc3+d
	 g6xU1h+0TmlsQd0MQBqIlc0Oq8qFPLk8q3d06EeI5Wgu4jHK4o74JeOXCoAlQ2VbU8zdl
	 Wrd8Xd7BOxy7h60OU+z5vc7bkNoyHTRhAmIJjFoDFIbYyIq2Mv7r/1iicY9+o3Iwd3Oyf
	 XaOYL91ZIZRs+hRGscKoO422REzNcbmgZe8xGTYOjCpkhqnAZBfTccNKgdDsPu4Al9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610538;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q8aWe+ym/B+qVtPpDaCvqQXqyZeVsHrlmAXXw0ZAdow=;
	b=GNZuK1U5cfHhSrawCtZc/R3OoEdYyQ+yWSfsrw83CfahMriORRS9u7iRP++HZrpppRyw
	 agGANYJtJg4tQtmVBLe7JywR2AVklrEWgNyn0eOCKV0dC68lOU0pH5MHZJOJ61Eq7wpo+
	 Rd1jZlYrI8Up9LXJxpfiCrbZzwUw61HqZqg6j6MVSWBmnyPegTjfO/OGJNs/uZtNravzL
	 QhKqvRl/9xQZNlDgBN0nCPjPNFGn+ALo62tNiQJNea+mmzBO8PonbMaw+JMhZwvRJDQUb
	 T6zyWDx76d+i6pVjQn4S9m2cjPP67CI70LhMJlE6D8VTdKee5VYV1DpQZ/c1+diX2aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ci5+dYs1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFC606A319;
	Wed, 21 Oct 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ci5+dYs1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF6C1F000C1;
	Wed, 21 Oct 2026 19:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792610537;
	bh=q8aWe+ym/B+qVtPpDaCvqQXqyZeVsHrlmAXXw0ZAdow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ci5+dYs1BpJJyoRmYQ8k1K3/KlTeRgwCpFcBnsHb2WGabzhzN6vfM2ZzUaCYXQoDw
	 jSRO4Ey4d+UvHc2D3u4LCndTbHzTVpiBrBkH4Oe6MIG6moVADqlPW8PHvSPnP5RVfp
	 55/emvZCC852WjgDT3GzgGtQ0zy0i/4+sz89G88IyZhQs8ufV6TeIQmV3k9QIwjBxb
	 Zs9ENU7/SLUkfJOKuQ2GVaGN3WVE2y0LJqvtY1HhUzBbJSKva8NIn8eHUFJ3509G+Q
	 180M9qf4B2XsM8zufFeP4qpRYpV2CvwtHJxZ0uKFtZGkVU2d5Pxi4SGDkTuZ26SxXb
	 4qSlKihUEmzOA==
Date: Wed, 21 Oct 2026 20:22:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: iio: add documentation for ti-ads1015 driver
Message-ID: <20261021202210.7d70429b@jic23-hlaptop>
In-Reply-To: <20261021063350.7984-1-flaviu.nistor@gmail.com>
References: <20261021063350.7984-1-flaviu.nistor@gmail.com>
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

On Wed, 21 Oct 2026 09:33:50 +0300
Flaviu Nistor <flaviu.nistor@gmail.com> wrote:

> Add documentation for the ADS1015 ADC IIO driver, which describes channels,
> IIO attributes, threshold events and ABI usage examples.
> 
Hi Flaviu
This is missing the 'why'?

We don't tend to add per driver documentation unless there are some
oddities or unique aspects that aren't described by more generic
documentation.  The actual features are all discoverable so documenting
those rarely makes sense.

If you have a reason that it makes sense to document this specific
driver then state that clearly in this patch description.

Thanks,
Jonathan


> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>


