Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005551;
	b=ejLUkV2KkmbQaaLWTij4fs5KjY5CK7SdCYI0daRcVe9YQINX/GjjGg2VL3S7HmNSCj/+
	 c3Q+vi3GIyM4c9OViNBXN1+FakE6q3VRz+AmP2b7/qjKd4BWJ239ZwAM//TanLups4m+v
	 N1Y7mV3Z+N5a/W8cQelevfPbURCsCKj/UadJcrRo/yOHd+ggCF6F8a6hzHGDGMhuC6sxi
	 zae+M2K4NY1KS28LtCsE2WeBMJdXmawm+jDXElTVAt7AqksPQoxcKd6vUBH8gNumGTKtt
	 FeVtRmw/e0v7KwWB/0Oo/D82Z0uxUpP/vMy+PaUscLH9fakSIY/0H6bp3MeQZppD09g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005551;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZXvTmuM3YioKhPg4Ha++LLuY2ZPOAIzfl+7+aHQczPg=;
	b=t5nJKLD9QOz7J5UolZXmMAOsifQxSTgQTtRgLJAXfZYvk+LRiwB6OxivMKVqfaldcl90
	 xhxAl2n5s1FJiIUczLzQc0X5xVLLdj/kRt0MxzwS+bucLKw4oHMtvEplJBXjn1H1Xpvaz
	 tynhcnzMCnDMWvIr1Q/8h+pn3t1WNLdP74VdoSvJx/UrW9HpFf+RQf4p7GkfdVq1z+HWj
	 vBMYDhgcQ/rfzU36C2LzpK6nnkBRvir4zoOCJR9rENS51dINIRlrIOhpdcI2UZnk3Rc9T
	 OcOkLX7B9InlxUQvWyKBzVXR50m80MrHWQM6hRmcAeP7opJL+2bwl6+HPqapWK2nkhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gG4kCLUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853F606A31C;
	Wed, 18 Nov 2026 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gG4kCLUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D80F1F000C4;
	Wed, 18 Nov 2026 12:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005550;
	bh=ZXvTmuM3YioKhPg4Ha++LLuY2ZPOAIzfl+7+aHQczPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gG4kCLUwF1nF+UgpM5HtFVJ/6QzD8lBYzRrCfgLt6Bqrq4QJ2g50WYHPz4F+lwvHg
	 zCRmrq6EHfNMGHn9ja6EnknBxA8+/TqSUraJ6+He6ep/3/L7Xc4b2PzaMtXlbASVrl
	 BFutM5NQNuAoLrBcaJc8xhF98Wfuqqlj014J+r/aXLwTJkpGtxb09JIZPdRt5qMKv5
	 D7g7W5eHRf/wgPqzmlxhBr7zq40pONta0doreq1MOtTLbxMfKuQBGcejIhBndshxBk
	 9DSnsAmoYIf4jLBx02MAWIiKhEsrqmNqsf7fhRE3TNtj+F5kbu7NnVKqL43h0Q+Z26
	 8+GuU2nHo4rCw==
Message-ID: <dd162a09-9183-4888-bcd8-96214549f62b@kernel.org>
Date: Wed, 18 Nov 2026 13:39:05 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add a reviewer entry for the Semtech SX9xxx
 proximity drivers
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261117094737.15253-1-kapoorarnav43@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261117094737.15253-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2026 10:47, Arnav Kapoor wrote:
> The Semtech SX9310, SX9324, SX9360 and SX9500 proximity sensor drivers
> and the shared sx_common code have no MAINTAINERS entry, so
> get_maintainer.pl only lists the IIO maintainers and reviewers for them.
> 
> Add an entry with me as reviewer. There is no M: line, so maintenance
> falls back to the IIO subsystem entry, as Jonathan suggested.
> 
> Link: https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> As discussed on the SX9310/SX9360 gain series:
> https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/
> Gwendal, if you'd like to be listed too, I'm happy to add you in a v2.
> 
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

How many postings with this are going to send without giving us even
chance to reply?

That's another proof that this is heavily rushed. Sending LLM slop which
was not even built (not counting basic review!!!) is disqualifying as
well, IMO.

https://lore.kernel.org/all/20260621045340.65872-1-kapoorarnav43@gmail.com/

Best regards,
Krzysztof
