Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4394A02
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776547292; cv=none; b=btWQK02zBwbSPDf0svA1rFHs9ZGTzKlUo01INKw4NcN+OMdfEQolIUdCuB8WTGCUkCad05BandDeObU4KLPJblC7xt9jWATCH4wRkwAw/anTNFCNXHUDvRvlPnBIZ3j7LdaW56lAdus5KJl/RlA1Z7Idc3jMPBYf69FysD8UrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776547292; c=relaxed/simple;
	bh=Q0SLlBPnb6nmFUOZSGbrBB30HzbmKUI86cOE3Hz9BLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDhuiJps5lC9m0hnBcH+3PXfKkmOyQLwIlk7Deu5wzj3+fD4CqET3vamPU435NFn5dFXsDEpJlhZqwIFFfzg9XgR+getXUqDcg9AFYXmEGvEQyqeCHaK3ZBttSCks4dZN0BbYR0GeRVtKSEyNlqzlSdzFwd09IyLmv4PhsL+meU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=lS9q9ZrB; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="lS9q9ZrB"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f387a688dso1458384fac.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776547289; x=1777152089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRfKGu3Ox/77zoofS0Nh7wP21jYiThZ67G85IowYo28=;
        b=lS9q9ZrBaee6r2yfwYsFJbIzDDTnl3FkvlIUKbSzlrs+tSQYHxPVXoZJZKnxPOBN+r
         lfRQ25db9tSOSQbyM/NWpJeUwNgXyucnyLBLc89GeRxz8zKCs0cpUY5OqATaeSnj+TYN
         9lTOFlZdt8kmJMUAm5U9F5zy3SbT6ahs1P85LSF/3mVgvUVLy7Bf380fIO2M9YLN6YFF
         z6r4nlW6wzZQkOYkHjzPYRua7E3dOLwrPQaGidS6KY1HARjZdaqY3kaTAcPFFGqcbm0k
         zAQRbUZBf1uHjSyLVvkiiN+PWtsHEfFMw/leebjNXYVRNHQYdgpDfLFjo7CABtfLMyWG
         2gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776547289; x=1777152089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRfKGu3Ox/77zoofS0Nh7wP21jYiThZ67G85IowYo28=;
        b=gEVDbw70+aTrodS24yxKi8K3J/XgLU7KBJj08JqHNHny+9Ohjw2WoHim7Cz4NBp5e9
         iELfjWBS+C+PWn2XD1F54/DT18xdDDTqq3Dr8FccQIK6zjUTmeN819bq1+leVM2Wrgsg
         w9oTL+UNOdWuEpY3fVSmvWPRKq7e1gvVEYwaY4uhihPxoi5J4ez2GYAKcBLxHGd7PBoo
         S1BXBxqJ5Ed6OgNc2gPGJwK3dfawY4qIdYvplBlIrlqBznOIFUu3pkJ1V1MHsncXEv+u
         6WPqpgorK96GN/UNJRpZuNXaAflTgdUVvIHEEWPgSpLD+IfwFeYh8viavyBzB6OE9m+U
         OSgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WWfxX7tdKdbfwU+X+asXJNVSiMISrLszcZfSneeN8xlDtMQYRe8dJNqUbB9sxSVg3DLx/SGgxx8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEkBF0iEsDNZJhAmaybF4RoIoMEY9AVwJFtl6r2g3k7fqng0e
	CbrwdNneJwGMnxsVULiNNDv4hx0PW26NH6ins8Go75ywVdCuDo0kdm2HytXGi88teZ0=
X-Gm-Gg: AeBDievZMMatNMA1kn+Cu75kMk8BYGDHyjuH2huFOsj9XNJ7d3IznAAvQGfSeDjyj4b
	QGwPgLUWqqOztxxYqVg+lJHYFMD+XBGrCW6EqgHBs/TAGvRF7ZGZBYsRf7JBu2MZI0eEbJaEVA0
	j69mMmwfFIjpyra1NuhLVuPOlaeT2RpG1S0rxnK0IZ39hGoBAVewMvq8ebsJMSTQVtIYqPYrnwV
	4+9kE4KuoQu+2OWRLuuay4mSqxECSEMhRxtJ+YsFoRA3dxYHvn9KuNMcfeaIuqsdzae2Q/7an+h
	O8Z7SEpDczpaXDHO6/4Crt0i1WN6eeK/hqIQktcjHO8CYo06+G27EQwBt/66jjTbLHAHjsRW4Cv
	uazOm2NFuMHTPeCyyE2JqC2srQdcxLfIsB4b8NaEBcMy436qFdY1SAyuaPB2TrGMhOhxh9UI5wX
	HgRgGKLhdiifUOaw4YGZcGqxDNgnv1qQps0Qvuy5aDS5YTc8B9eXos+ZZQACYKuki77IOerdb6x
	6ifD7hAJUHr
X-Received: by 2002:a05:6870:d8a:b0:428:2838:223 with SMTP id 586e51a60fabf-42abf2eb022mr4709688fac.9.1776547288785;
        Sat, 18 Apr 2026 14:21:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b930bd9f2sm4302062fac.8.2026.04.18.14.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 14:21:28 -0700 (PDT)
Message-ID: <363f9a39-e535-42ba-ab5d-faaf9920a8ae@baylibre.com>
Date: Sat, 18 Apr 2026 16:21:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: tsl2591: reduce code duplication in
 tsl2591_persist_* functions
To: LucasRabaquim <lucas.rabaquim@usp.br>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Cc: Matheus Feitosa <matheus.feitosa@usp.br>, linux-iio@vger.kernel.org
References: <20260418185422.166542-1-lucas.rabaquim@usp.br>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260418185422.166542-1-lucas.rabaquim@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/26 1:54 PM, LucasRabaquim wrote:
> Add tsl2591_persist_table as a bidirectional lookup table for
> tsl2591_persist_cycle_to_lit and tsl2591_persist_lit_to_cycle functions
> 
> These functions were prone to errors in the case of adding or updating
> TSL2591_PRST_ALS_INT_CYCLE_* values. The functions utilize a for-loop

Isn't the new table also prone to errors? Neither is very complicated.

Seems like the advantage is rather the reduction in verbosity.

> like in the function tsl2591_als_time_to_fval, allowing it to compare
> the cycle value with tsl2591_persist_table[i].cycle and return lit
> value with tsl2591_persist_table[i].lit as defined in the new type
> tsl2591_persist_entry, reducing the risk of logic mismatches.
> 
> Signed-off-by: LucasRabaquim <lucas.rabaquim@usp.br>
> Co-developed-by: Matheus Feitosa <matheus.feitosa@usp.br>
> Signed-off-by: Matheus Feitosa <matheus.feitosa@usp.br>
> ---
>  drivers/iio/light/tsl2591.c | 104 +++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index c5557867ea43..86483f0b2e01 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c
> @@ -170,6 +170,12 @@ struct tsl2591_chip {
>  	bool events_enabled;
>  };
>  
> +/* Persist cycle conversion table mapping register cycles to lit values */
> +struct tsl2591_persist_entry {
> +	u8 cycle;
> +	int lit;

Why not u8 for both?

> +};
> +
