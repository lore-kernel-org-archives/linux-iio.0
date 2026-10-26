Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975588;
	b=D3u31dcjwSTUcNh3VV9KMNTNLPw5+CDG/HuUPpKC3i+7p1aJuHJmlatbyv9EAAV1mIhp
	 9w8jCZ6CbXA/CdokhTBpl6s7RK80b2eSA13sWcwZop8V1/z7Dyszstj5Uj042Wz7ybcjE
	 B0RQ80nhTtGx3L+DXTASGiMh5jraBkarIvY64FrQkTU6P6C8iD7uytQ+po/plmxmm0NJI
	 eCPsztBJGJp50P38oVzhCYLPEu2zd2ligA9uYVfW0safYWQNJAGLkF9bnAqPGF5B/8hLr
	 kPIR59boM8J4KZLub5SeI361K9UcepUd9jSFOGDDQH4GHZfQKx/Fqjadb0wJgoH6gAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975588;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g27xXTBcmgXuFkZ0PIascCszUPkj4I9PwS3AryVBM+g=;
	b=FMzhTFvvh9J+3eBUZ2It4glyJ/K55E5LvCMnGiIJ4lLYBi+cfBk+iY1dFY79SU6x4LRF
	 I7DJ8LzRyesaXHgV5suWmHXZWhWl86TC/SgAPEaJX3Rqvs0pAzto6vQHbE+bbKmJ+gGbI
	 8Jg8zTN0W/pA6MVJLDmm3aMnXyWiI9g3CAoK6wv6w3oJhuzKo4JysTvj4lx4nPw+rhENU
	 nz5XsTlD/fwHGDOBiV+xVZymiwLqSa3on+C9woe+WEGDqX4ZV/+ZcgQYBQbWEJQl2ENLE
	 S8XzitKrrhcpEo84X2OLt6U+B+faCi8L5MrZx+qmDJytE1debUHGFAjMCYgiOuzACJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7iZXs+k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9B606A31B;
	Mon, 26 Oct 2026 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7iZXs+k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F871F01825;
	Mon, 26 Oct 2026 00:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792975588;
	bh=g27xXTBcmgXuFkZ0PIascCszUPkj4I9PwS3AryVBM+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I7iZXs+kQkQ9A/D2AcQhszyTc70xh7gKrZmE8XIUBzfWsgkvMS5D8bv/mbjD3+Mvi
	 sS023f7sTP9MgBbIgaKSKmJZUuoxCIn5Arf2gptBN3IYvdG8/cwLkGmgYA4mfSRphN
	 ci5E+1vL7K3dwCpxqWJ9V/Z04zATozKBKPAVVQ8JyP8IKWuJH63ffFHY7MJ1rl9+xB
	 rnG0OWPlGpWZP9BYQ0FJgfKmAnOE2rFI5Ievdp03ZN0RRdN3QcZkYwT/eFCvLJmeHj
	 EUwWS6rDH5ROhVIAlzOM4J5a0+p3f9EtqsiViJp8GSyiYd7AorBWJ9VOox7F3v81Nx
	 9ok/va3mUTk7w==
Date: Mon, 26 Oct 2026 00:46:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici via B4 Relay
 <devnull+andrei.stancovici.analog.com@kernel.org>
Cc: andrei.stancovici@analog.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/3] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Message-ID: <20261026004620.16bc9020@jic23-hlaptop>
In-Reply-To: <20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com>
References: <20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com>
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

On Thu, 22 Oct 2026 12:58:17 +0300
Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org> wrote:

> This series adds LTC2493 support to the ltc2497 driver, and adds FA/FB
> line-frequency rejection for the LTC2499 and the LTC2493.

FWIW I took another look and nothing to add to Nuno's review.
Looking forward to v3. I'll mark this as changes requested in
patchwork.

thanks,

Jonathan
