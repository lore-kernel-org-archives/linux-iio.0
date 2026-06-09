Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15914383C64
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000770; cv=none; b=f+illkmTR551Mfc4m2NX6DloL56MdSXiPy7NlmJZKXJ7/LJrYkiVNFTQzFIgp6YdSdjLnXlcjfJGAIctX9xWpau2hMvA7pjxAtNajzkLOTUJwNbQIN4VZQJNVDbaC0VfXavoYkBlOI7hxicjyq5/voGFYIPTbl7vBjCxaKH2jJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000770; c=relaxed/simple;
	bh=CvjWP4qfaUy4Vu+fDzXdcGiVNmiLKemDkKshBGQW93w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0vzwiUI1MtYIKJIs+5prK9/yx1sgLOUbi+BZZK6JK6aQXsnRiPQ88Ch7lYv5vvZnF6B/LVS0RV8ZRDrvjresEG1qEyUFbkve/kVgggu8kDOlVdGKYc+C4u6oeGqT0Dal1NJiy6FNuOPbna12Bpdwrd8wUfKX/sR853psyPLOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG5GqU2M; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG5GqU2M"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3799026f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781000767; x=1781605567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7DTan2GpF6A2ycsVVtBoKDWhROO13NhyoThWfu3oNA=;
        b=lG5GqU2M9gegkg9vFEFFMnkpnVwp1jbANzRWvLajAMLdRMO/9Hhc3V1U1cEKsLCK0U
         S1xaig0sweqAdOVpXG7wjQp+/9NVR5wEsevopKt1+x4E+LfXkR+WolseLKDfCbDvPFIi
         UozLQpUXgmlxdSw1+Bu5IMpEC2gg1G37UMom+vaTY4OMhfBwIRVUH/diMxMfC6yOXLl1
         qbQ9pcpDCwuJp7l1UnjW2mc8otAej/rzHDGBpCYyfBGRjl26ZOPqN3WvY5glzVuHzYp3
         MQCFhQtZ7KMx0DW1WBqxAKVOsrws6F2/Ld4rgzUK1nxo56/H6sFhivbfbuNPdEJ22eWQ
         ZKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000767; x=1781605567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7DTan2GpF6A2ycsVVtBoKDWhROO13NhyoThWfu3oNA=;
        b=mbh7l97OVyHPk5dYmaayRxDOm1SPB29WUzbvjgs05nkLASuszbGK3Kce7B2zftGSDm
         AQGolTbQZs0X8fZndLMFfjw45E0tFSo1N2dU+FJOsUoNbHUistFcr2TRy/+D9KBUeyKn
         W1Qmmx0+LjvQHvjm1DYheSVqOdARudXJf6UZUyOFuEUbRLMolouVK7ZFgiNS8GYvKq7D
         bn3gAR55KWR4nW9uG5usE5WKkLZyReem94sNySgGdzp01S7xwje/j1bVaOBHj3nc155+
         cdK+csKhUhke/b1er5OlmtxRfiO/LRdaSWf/mJgYx/F/DxHh2Gd1E1iCrNUXXQCUy743
         wKow==
X-Forwarded-Encrypted: i=1; AFNElJ9TT5O3G1tizwlNwf/YqZPzYfe50mXX89/V652iQTWtpUYeOonWI3Q0kqXHlZOxb0Fi+zujbKEd8aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5bF5tms1DZSOcHRNBBD9UN8EmwgXGxyz4q4bzSrFZYpUM/Ij
	J125hSVtQHBoSStQj4rXqZf60t/9QOItvy63pqDbTfVbeL2WVgEG+hlY
X-Gm-Gg: Acq92OGJ+hzl58Gs0Dr2LPGEi6w4Tj9YB20hqbrwokEG0C+7W+OLgsteBEIlS80ZqYn
	2Eno34+gFiUoIWpvNlDyywjXoycEdZebGBfQggKx68pfCmyAWWM2+PdpIG4LBahbRz12ycDQgxK
	SUi3yqcjwaWtOJmla1+d8p8V22Z4bCh7OrDBwhj5y2xaFFpMIt0oxi7+QGfvPe6+zs6Rh7HgNw7
	pFyODzjN+5dILjxuITNeiNtT2fzqvgce9no6rf0NOdPLG5U0+wwHSiOwwg+5Dw/so+xbyyteRoX
	kxKhLZw3gJqjfmjUkD037sr8vjMRFNLZL8v+Ha8nAC+EiV7arj6ySb/ANHukddNMjhBTdRWzfQJ
	cJ5rJrN7Imeov1o2K1pHcufwXINHlb+TmY7gxtx49JqbseQJ9UNBAiDaLEBZDJE19aJDB7wwtB0
	0GZprllXx9kPSjILComINuQT1MNrdmQRuPxgcDhcFL4ANrZ9/1ipjGWJ8oMTgAGdR0FAD7ZY1gB
	qiy9QEP0rgOx+2aXFOmMhFNMrd537vSTucWw1J/Js3VK3AbQeSoR2InckFj+FZ3rJ+yPs+Y8ubq
	1/CLqWfm7RNLWNq80ThxtyAWF59SGSeBcVUhePQT3Udt5MkeZHFKwC/hSavbN3CRiMS7tUJzQ1b
	u
X-Received: by 2002:a05:600c:4e43:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-490c25d24f4mr315035765e9.30.1781000767236;
        Tue, 09 Jun 2026 03:26:07 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm543448335e9.1.2026.06.09.03.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:26:07 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:26:05 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 11/12] iio: dac: ad5686: write_raw: use
 guard(mutex)()
Message-ID: <20260609122605.000010b9@gmail.com>
In-Reply-To: <20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 11:13:06 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use guarded mutex lock to facilitate code review when adding new
> attributes. This will allow for early returns, avoiding error-prone
> locking and unlocking in error paths. Gain-control support will add
> the scale attribute.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Althoug <linux/cleanup.h> is included in <linux/device.h>, it's better
to explicitly add the include for it as IIO drivers are currently being
moved away from these catch-all headers.

With that fixed,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
