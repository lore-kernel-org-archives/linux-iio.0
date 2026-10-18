Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778F3BF684
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338970; cv=none; b=lay4Ko3BGU0/opiQl9wnwCTwtV2Wyb/sj98EUZKaesn1J75XUIVcDNge7LHNxtlh9yEk8uUr6P2ND6zL85k6XasgW+L1UMDIxiVb9gIQyA3j/5RG7H7Ws6yJOjs9LGY7goyIm0tJ1pyRYfw2qBaoXfra+NzlWRvEgkQo/b1xzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338970; c=relaxed/simple;
	bh=+kCuaqYvwXGbWkpGE6rk6i0yD5km7LI6frQMx6b77q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqlQXKaLH9y4GZxIvdreEn601TZDr6G9jNSiOjUorf3aQx7XQc0nun2Jv/XtS9OZoFNZacREcH97G0JRJVNvl7B+f59yzBUIDCRDS0zEuTPv74ldGBQVX8f4rxN928E6yvkDZfS3aI3td99v+b9+Zxkyx59wPvn+a93GgiMlRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbctBC7i; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbctBC7i"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c247f6687dcso25119166b.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792338967; x=1792943767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6X5sTX/gBkk9ZMFX7ZUc3TThgaRf0NfvoIWKdsJ73bI=;
        b=nbctBC7i4nP4Pz4yUNVHjYaKLCgdcCmsbu9T/0a37D6dA/PF1JQtsrs0z+Mi9wPr8L
         AuOy58guEMCTGHoxOLWxyRjkrSDqo7IdPLR0PSSO371j1zCNT3NTb4XXgQolWhfvY8cG
         eXdPDVMhOgGBmT+0BsFaC+r71lfu4Z4rJ3cR1irBcVv/akrcmlys1k9pF+Axp0JnhMfs
         1MIiKPbSVvb/NYmRJbQ0z+nqoLFDFHC+kp9PhTTQtPP6seUjDB1in4hnwAIn6FlGPl2y
         YHS/X/ailZ9YLIXfcfhWTB2mqo7sFVcVaM96MsaorexQTbudLC2jfYviQSOsi9AtN+4M
         e8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792338967; x=1792943767;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6X5sTX/gBkk9ZMFX7ZUc3TThgaRf0NfvoIWKdsJ73bI=;
        b=LQtQbHBa9leFySyLCoIy7ynFfwHSWF+8k2Pe7TYn18FTv2RmPo9bmSJ0sVl0URqcsv
         yGlzwP8XtCAXmlwe/JjnVEboWzNd9N1rp3KwERXMb+/9Gc6zRDNommA6LUUC8k64QUjL
         aYeJlephfIJvfSYfyNBrt2VG+At6USSXbyyToW+PP57w15P8tS6l2lLqh1shyEY6Kpmw
         zmHDpSuXPZhGug+dNu3FxBIMK6kg3Xj6YPpPhcdHEoKTXv3pvA+LutLEQJiEfhtQj/62
         meOyEo7rg9De2oY5Gl+U46IkuR63rUe6rZbXvrEfCPF8hsLm8N5Zh+cBNX6icwFyNGmW
         YR4A==
X-Forwarded-Encrypted: i=1; AKwUvBxTGA4ojBmxAEVrQ1iY1ijsIJN2QXodyds19LfsB607HSIPwTAsbFUNgsSEqNzQ/HY1FUa77W5QZ8w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKmjHoog0S7rZlJRVEKV1OQSyHX5pWhirtrNnA9CWNglIQ5IKq
	Mlo8j+TMMcc3MEAbQdnbOR+Us0ygGRYUx3wqAnfBDrvGpir6fOVWleBO
X-Gm-Gg: AYBFou32HO6WFVDYXeb1zL5es28+wKkeB6VoGOhSpemTLxQVxyCH3DYrzSzgfxpWIxy
	mbY5DXW0Si7RUk59t8wqi6zIghdUh8K0Z0UKncGaIJBAjBnwnqwAI39+UdGjOdc8hV8M/wzViGV
	SwakmbEjxcQ6gP86fSlIOT5drCQBiqp/r0vkU1kqTqPZHzbTUqhbu0yx2IPGX21Y3KPdJO86MPW
	7OLE+YnbuF3Zex09Y3aOtjszcpzs4cGw8Z9kskVUIwDAft6lS8Qx6d+lLCQ23yiwlmlhnkWhGt3
	5yD3mOEq5qIU2bJ8m//Ok0XfO0kLCo+5yosmzZLMRNhcLSdNw02jyDSXr+SZKdnP5b36cd/ta4A
	m7ChMhKKVf7sM9MJF4sLPECo7vS3mxl0H1BO0hMtBiTXU3ztrsgyp8pk1QxVbysK+LjsPT8sbot
	Sy9vWAt7SBe76XIubq9QDRiqd0PWXppnE88vnN41VXNIMlx3LFlA+OsF3yaeYY4Tv1eRAc4ciAW
	+03WmJv/0X92loOrG6EArJoFBw4iYl0oTKCzuQVqMTKaCCrEJLllci6Zh9F+Vzkcc2Dbg6NcwdG
	p8GbrNqlKO4NYdL0gjFSiBLeR3nPvWGhCRcSvT72yeyM4GUbEoJjRGiru9MeeoIK1qWyPAgbT0a
	RINLf4uwcUs3SNfHQw9vNFvWgS734C5XaawUn2rcBAQXise07Rh5MR1Zw9dvZwiAX
X-Received: by 2002:a17:907:7213:b0:c40:6ed9:b962 with SMTP id a640c23a62f3a-c419ea3724emr380357266b.26.1792338967352;
        Sun, 18 Oct 2026 08:56:07 -0700 (PDT)
Received: from systembl0wer (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb256csm277769866b.78.2026.10.18.08.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:56:07 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:55:58 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Melih Emik <melihemik@noirlang.tr>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH] staging: iio: frequency: ad9832: use guard(mutex)
Message-ID: <20261018175558.71739ebc@systembl0wer>
In-Reply-To: <20261018102604.73380-1-melihemik@noirlang.tr>
References: <20261018102604.73380-1-melihemik@noirlang.tr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 13:26:04 +0300
Melih Emik <melihemik@noirlang.tr> wrote:

> In ad9832_write(), manual mutex handling via mutex_lock() and
> mutex_unlock() necessitates error-exit trampolines (goto error_ret),
> intermediate variables, and deferred returns. This pattern is prone
> to unlock-omission bugs during refactoring and clutters the control
> flow.
> 
> Modernize the locking by using guard(mutex) from <linux/cleanup.h>.
> Scope-based resource management automatically releases the lock upon
> exiting the lexical scope, which enables immediate error propagation
> at call sites, removes the error_ret label, and simplifies the control
> flow across all switch cases.
> 
> Tested:
> - Compiled with W=1 on x86_64 with zero warnings.
> - Verified with lockdep and debug mutexes enabled
>   (CONFIG_PROVE_LOCKING=y, CONFIG_DEBUG_MUTEXES=y).
> - Boot-tested full bzImage in QEMU with initcall_debug, confirming
>   successful driver initialization (ad9832_driver_init returned 0)
>   and zero lockdep warnings.
> - Disassembly inspected via objdump to ensure mutex_unlock on all
>   exit paths.
> - Verified with scripts/checkpatch.pl (0 errors, 0 warnings).

The Tested: part goes under the ---, no need to preserve this info
in the git log.

-- 
Kind regards,
Joshua Crofts
