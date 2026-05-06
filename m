Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DE33AD82;
	Wed,  6 May 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098036; cv=none; b=q361N2vF7WSMga8c8bpTwJ7+iZw/s0WrUY0sguMiWA7dVgDjdflD9ubXb01W+fdEBhUOJbtIvpUkiEDGQ0ODHUa0DUxJqAAPkkQrpRP9r5mvltzQ/hk8r5YaFVlcH/t+O1x4wNZQfa9t4rqBB6dK5jI2uUAcg3jYy+vr71vq/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098036; c=relaxed/simple;
	bh=vMAyN8jM5c4Y+fWqXrT/h+mKadyBN/iUQerXtAUc05g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pxe8lS1tdzroBwwJw20XwLVZTNwFblFsqJcAsc1y8hWPdafdArM5ExQDvdDwfdp7sf6XOKxqlTWiTkvhpeB/H6TSpifJ038I9HhjW5V9XBscsjj/yNXYE/beyPLoJhSRUasHwYbEPKgJpVJQPMRLpnlEBnrleygAVTru1jDAO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iy/Uzv4G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iy/Uzv4G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=f6o3TkOrPcWeRpAykm8nvK1XxkHJ8o88V7XGenxW3Ew=; b=Iy/Uzv4GOFywPBE+tsrOU7Rc5k
	SIFz9ZD5hplntQ7DPma2h9MC8+hv38OWluWNXnBx53gx8xAh4ldit1Kbd4zJEHl2Ep3LLBqpbi240
	ZEWRjfYIQDAdRY8VaiYIEMxmd9UUSfghkXLH3rvhtp1JwnnMWVnPHnsPSSOUvQGzWpS4cnZ9KJeEf
	mvGaHD0u4quaXkdM6t6iU7IVnHta6xMi9StrlxxaBn6xnLJjbn1sYSLhQaCWaAkK0i3eW9IAeGmmn
	RuowDNTtwiIUKJZ+dCzmkHsa1/oqZQKa+yKPwYSdbnFKMjI7CVoLrSikTEAzkzRDXUnNUYmHWtMt1
	a7WYKCzg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKiWO-00000001wlP-0HFa;
	Wed, 06 May 2026 20:07:04 +0000
Message-ID: <8d9b760d-95f2-4a1a-a9d0-65ca66d5ec73@infradead.org>
Date: Wed, 6 May 2026 13:07:03 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
 <20260506-adf41513-iio-driver-v11-2-2b7e99cfe8f2@analog.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260506-adf41513-iio-driver-v11-2-2b7e99cfe8f2@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/26 7:08 AM, Rodrigo Alencar via B4 Relay wrote:
> +/**
> + * kstrtoudec64 - convert a string to an unsigned 64-bit decimal number
> + * @s: The start of the string. The string must be null-terminated, and may also
> + *  include a single newline before its terminating null. The first character
> + *  may also be a plus sign, but not a minus sign. Digits beyond the specified
> + *  scale are ignored.
> + * @scale: The number of digits to the right of the decimal point. For example,
> + *  a scale of 2 would mean the number is represented with two decimal places,
> + *  so "123.45" would be represented as 12345.
> + * @res: Where to write the result of the conversion on success.
> + *
> + * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.

Use
 * Return:
or
 * Returns:
please.

> + */
> +noinline
> +int kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> +{
> +	if (s[0] == '+')
> +		s++;
> +	return _kstrtoudec64(s, scale, res);
> +}
> +EXPORT_SYMBOL(kstrtoudec64);
> +
> +/**
> + * kstrtodec64 - convert a string to a signed 64-bit decimal number
> + * @s: The start of the string. The string must be null-terminated, and may also
> + *  include a single newline before its terminating null. The first character
> + *  may also be a plus sign or a minus sign. Digits beyond the specified
> + *  scale are ignored.
> + * @scale: The number of digits to the right of the decimal point. For example,
> + *  a scale of 5 would mean the number is represented with five decimal places,
> + *  so "-3.141592" would be represented as -314159.
> + * @res: Where to write the result of the conversion on success.
> + *
> + * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.

Same here.

> + */
> +noinline
> +int kstrtodec64(const char *s, unsigned int scale, s64 *res)
> +{

-- 
~Randy

