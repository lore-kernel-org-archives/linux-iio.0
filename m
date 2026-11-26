Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684500;
	b=euhVQc5OJpCg95X9jpTGUxU9OD/Zz5JbwFGL588YCd+4CS67lAqwZj0SRpFnBunnsA+Z
	 2Lkp2RJCbzT2P9Jgb9fKfA6zd5ktbBM4Zvb1avYLTvr3tWy5+ckdOZWjeT41ZOVCMB7NT
	 T88ECcIepy592l9LnIGRm71mmGcoTYXkeVvANL/ipmOqAgz9KZ4pDsjDT2LDoHm00Cdiy
	 gAIJYWjzDk5qGqoQfi4Ml4SMFKSON9WlYFutn5/59O9ovTaixSC5arrbd+d/YQchI7zMd
	 4yZKLRpr/aJT8l/isMWkHGx3x0uYXQBHxLn51U6XOGWoy3oZCaelb/ZTjwuGWKJRJHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684500;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zdxkVKL9JdQvZ0j3hJp9JYWpC9BWal2BzS1RegsGTQU=;
	b=KAMfRfiPwrWwOxKId44CwiD9OFqz9BGfF0QVLLQh9b0MYU8lCi5S0UVmkgiuGANdEJUP
	 L+vjtefzQ6p1uy5/DkhorVd5PZsdkcWsUnazcY8F2fsoBq058Ad7M+BkpnoPtEjlg+rY5
	 KVEqOO5yHJrmfHeS7J7RfGfxJfQqLTKQUPeRIC42w4NRbOruKpf9PAg60N3GFzR6mwmfj
	 k3xLUPugZjAmAL71rdwuaI58mx2mZK8Z/+47cgjRj4XjBI6evllG2vDNVTkFPYOhR0sjq
	 Ojm87dRu5/+wJHvY/kCkpy/nlWPZU5F156p/2JwcTJ82hqKGBLMR8BaW2Kpn6/M4ezA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmftPjnC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD1606A323;
	Thu, 26 Nov 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmftPjnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59DB1F000C0;
	Thu, 26 Nov 2026 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684500;
	bh=zdxkVKL9JdQvZ0j3hJp9JYWpC9BWal2BzS1RegsGTQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cmftPjnCCRrkACKCS4O2CKDuXU1xv4XUW5EOo12qUuo+8zINlDMtopO9qZT1QZWAf
	 Y9bIIvwIqaPtAF7xNne+XFZIIsZLTmq9wIEqcyGtgOvRlQbNelFRYARZlZvFiaSg9S
	 7wWWQzFkdOX7SWXyS0lOKX4TWb4ISfXCdKceRGvCEjN3fWgZQKR8EyKKCnn6Ha2Mpx
	 R5lS4fqpLjoqAy5W8Ao+XuDi8HrzjIEN4kx5hoFWTMBo1jMPra/qJKvUfrLYR/Ekk0
	 vFOggNddKRWfF9wxzGDU9xpzbCPF/KzxYYEDYVCPFECpuN7V0pPXWwhK6Msg/f0JL0
	 +esMcerRUAHZw==
Message-ID: <9ab635a3-a786-4bb2-8ac3-131ad62b5426@kernel.org>
Date: Thu, 26 Nov 2026 10:14:54 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 0/9] iio: gyro: header cleanups
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Nishant Malpani <nish.malpani25@gmail.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
 <20261126013331.0e6bb05e@jic23-hlaptop>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261126013331.0e6bb05e@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 2:33, Jonathan Cameron wrote:
> On Wed, 25 Nov 2026 20:24:01 +0100
> Joshua Crofts <crofts@kernel.org> wrote:
> 
>> Remove any kernel.h occurences in gyro/ and update the headers in
>> accordance with IWYU (at least loosely).
>> 
>> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> I suspect we won't get much additional review on this lot
> and seeing as Andy already took a look, I'll pick them up now.

Ah, well Sashiko had some remarks to patches 2 and 3. Alright if I
send patches for you to fixup the applied ones?

-- 
Kind regards,
Joshua Crofts
