Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095196;
	b=t4b0cE4QW39S3/RkCrbBeQ8DmgxZKot2Wj+51vkIaPgKq86OBgnRx/h+MkItqwdAtp5y
	 PxdYd0qx8jXDEVos6SK3DKv3kQTDUHLJhW80R7QG9zEXtfcoDnK0hDIcHq5GRRGTZMiHk
	 6TH0m0LJq2rMn5BGEx3w8L4GqDaIMEfVAgDGTKSGrIJaFB8ZNcFIEYWEuRt48zIdFQVYe
	 cjgz5MmO+th5PRopyMGuOR8EXsOfMkItN5uws+18DOk1GzrzqomWEW4XCTXHQ47p61I0w
	 H3YbBuPs5xhatCjPzavymNRFogh3PJQXlByIlxWpXu8M0NIG5AyI/mg3pPynBNwWUBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095196;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zE0i2Pcu+P/pL9LHMkD1/m5a6kLGIAIir+v7KISeyLY=;
	b=OvHM7xIWs3YADVpOZ6KQfOc9WZdb7AujohH67IYe8Z8uSGfGeHdf3QAnmFSyuSXXOt3U
	 EACW7zNyFu+3RJ90J8wBePCfq1LGnE8DbAni7nPzfR4QBrO8t7zKei5ZEWGBHs4IIA8uD
	 qd5NNKrjIhjV6NY467lwkYzZgXlVlW6GE0ODWDU/5HWIqK520kjSJ4dVfvvQC0l4HrlgC
	 10m3ZxRV2P48sIEMsDImVlwqhqFtP4+w+pFFyyZYIVk+Grtl0f55uIh7zmsWcn6sLRaty
	 7QzMNePFh/vBEEiWKIF7tRjRkgkDv1gzaiBeHGKu4vpAsOSErP3oKoMho1a+m8ULfPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQsxzLzf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D5606A326;
	Sat,  7 Nov 2026 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQsxzLzf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450501F0089F;
	Sat,  7 Nov 2026 23:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794095195;
	bh=zE0i2Pcu+P/pL9LHMkD1/m5a6kLGIAIir+v7KISeyLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jQsxzLzf6YaSQdFgPWmm4dUMskGufqEyZNoK100DEuuwVuGTNqRnI6eZWxqQFMBk5
	 TCFDE389mkfnJnAVcIDo9yd+6Gri0zVso1eOr1TbeZJgeibAhqqK+i9B3BhepDfZVU
	 DxJdjOx8tbc/wlnRrxLgeTCrrVGRdJcvSfM+Qf5H/9jMkZwYm57shUc0jNQwZ6kB59
	 F8ijaSZaMasGt6j044fhSZqBGTDxigO6ag1XEuu1ybW+uCaHNy5QnRjjIdvQUmiAPp
	 dTTYtnpBGtZWYtVAw8Lo2U6rM4aCNWFZKpkQRE2dr6dWsm19WNe9eUEbHvKVqnkI96
	 0HI70lPIzTgxA==
Date: Sat, 7 Nov 2026 23:46:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 1/7] lib: kstrtox: support E notation in
 kstrtoudec64() and kstrtodec64()
Message-ID: <20261107234633.280c9296@jic23-hlaptop>
In-Reply-To: <auofLF8TivwJiMwT@ashevche-desk.local>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
	<20261102-e-notation-v5-1-d399e544a982@analog.com>
	<auofLF8TivwJiMwT@ashevche-desk.local>
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

On Tue, 3 Nov 2026 19:51:40 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 02, 2026 at 07:40:59AM -0300, Rodrigo Alencar via B4 Relay wrote:
> > 
> > Allow decimal strings to carry an exponent suffix, such as "2.7e10" or
> > "271828e-5", in kstrtoudec64() and kstrtodec64(). The exponent is added
> > to the requested scale to work out how many integer and fractional digits
> > are consumed. A negative effective exponent drops integer digits.
> > 
> > The digits are now scanned first and the string termination is checked
> > before any conversion. A missing or malformed exponent ("1e", "1e+")
> > returns -EINVAL. An exponent that overflows when added to the scale, or
> > that makes the result exceed 64 bits, returns -ERANGE.  
> 
> ...
> 
> > +static int skip_digits(const char **s)  
> 
> In case we need a new version, the skip_and_count_digits() fits better.
> 
Agreed. Given we aren't pressed for time this cycle, let us
do that change and add the bit of extra commit message to patch 2.

This is really nice feature, so worth a bit of extra polishing!

Jonathan

> > +{
> > +	const char *start = *s;
> > +
> > +	while (isdigit(**s))
> > +		(*s)++;
> > +
> > +	return *s - start;
> > +}  
> 

