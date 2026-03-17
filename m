Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2857C9F
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773729089; cv=none; b=ruB2KjLmt5TXVClcRkYaSmueYFLkZMqnwH+nlGHuXNoTMBnlUIt5KhEyfNIgcyG165C2VWGE2kGwEf6ToSM9g2GD5elFVhum0A6Gw3SEXHf/eMwh7yaX/yCgqUx4W0iDXkjhXSjLNWwss4Cl/wB8kO6C+PfLK9+aW7RtRYanYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773729089; c=relaxed/simple;
	bh=LYumOcJs6m1nQWsXh1246wQDZ9OGH9qxj3GsRHlpJWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW5ss9psCq3skdIT9n42MaKHmeRrBmFCd3msewLdF7yku1vCTV50wn2AHrNhR2zXZueBQ6KqXfwgJiORvQx1k31Tf+xnyQ0STH0R8IOma9BiqIYfFHInIyuI9sA2X940FAuh1vxF/eYiMX+/5JFvu797uOFoO8R03m9WYG+AD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHVjBSM1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHVjBSM1"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so5967224e87.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 23:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773729087; x=1774333887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIMQH8zc7VIdUFpj4/7m+6uukNPXgZczjKkJB6uF5po=;
        b=LHVjBSM1zx+c9wG2jo3Nwbt29OvzIHkguObBWb8Snn6W6LAfTUmZeLiZAgG/IC/9Gt
         q5ieVRfxP2vs6rGCh+fZv5euTZvVlhF3Bjg27ZU1deYpd+q+xNQd4FdDEe5REsclLnzB
         MIhNNsrUzVMqcuULtOX5xzkrXtus6M3UzG340mn41Nqwf9SwG9qjpcAJZEpyJk3pI5N/
         YsQqbBiedzJ+9lTKIc2y3+7RsyXg6dDAiRrOk/6uIF+NNQGeREA72pU1m0uDMv1VxTHc
         dveSWPpULfGp14QioEvTW4fyGTv6hjcd3hsy6/uQgY+t86+CLUbjrgEVFW1PtuA5+IUe
         K2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773729087; x=1774333887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIMQH8zc7VIdUFpj4/7m+6uukNPXgZczjKkJB6uF5po=;
        b=B2pIHNw3RsbGBqWJiM4ZtyY+xzUoluADh48+fsF7TNyuubV5ZcJQ1VA6cdfUpGXCxZ
         CnLjdcPQV9Ojv3pEU3pYlfD5bTryPYHIv71qmF2Trcqm1Ll6riTBs0PHJxYD13Psc4EN
         UYiOA6PAB7YZv62ABT5XeM8XLoKfUEXWmNqL46/UupOC/AeqGRe7bfEwtDfJXXsql1uy
         W2Ni6t0mLkjFzrlmzPZoNYXhUVTutKqCRYHyGpTNH64eZahpYQJvDZErEWTQJaUSmJ1V
         OXkFFwMBoklqLDAkb9xObfBn6vE06BS6eFKL+m/c3FX7+sLJR+AMWD52jiNmvldWhFpw
         EsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6MxmZquqjXBbtU/FzpE8a6Kl75fugtJuLUuijyeVUNLF0OOR8DQmZeLFnGq+X44NvPG7Uetl3Bi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNrDzJgeqaCROf8EEUeHdUp6/vSPAPieglm+yU/aoYcQRVDiK
	SYD39y3FgWvStD0ztlfVVaQMBw3bBsbRhjq/03A26vS54yTjRWbNqMAV
X-Gm-Gg: ATEYQzxNA5LiIEjEu+Bz3ocSAlB1+mUtXXxpUsOUVmRfQ8xrsoaMRU1AqKqPF2xXRXd
	hsovpjMFFesxl8xvsQ9qq9G/iLBGQGrsuSCbemLIjyYv576GoX4es/C7LRn23gdpSpR1XQeJNYs
	wW2XDUPYkA+8um/AKsWz6srM1BCOKqwwyOQxFt8ikuQP3xtB6dIqNMnN54MBYD+FJkjZeqO86uh
	OPI0KOuSebQD8dtBnYecFe9nQ2fnGZf2gD8KpMzYBCG6yy7vjUXKW45oLQOdLSGCa64cAmtVQBW
	cYXV2HWOvRGc7i4JabTHbUaNnIm2uiv+PWeqY9s/3YsopMjjkJtv8PGaPiUQg6J+q5fDSzihOn0
	cTVcHyJAFkv2YvSVzeNZnlYwCgm5WO3coCHWwO54/wdJ4xPT/WrP/B+NTxtjHD3k7yrOgNXPcea
	7Xds652bxaF3WxTHeF9eAlkhAg3IIEGq1icBgyQpStIP7j57F9bIUrnCa+y6c05m4goGEFnHiuR
	3b13Ocx
X-Received: by 2002:ac2:5d2f:0:b0:5a1:3153:82a1 with SMTP id 2adb3069b0e04-5a162b25c90mr3615063e87.26.1773729086313;
        Mon, 16 Mar 2026 23:31:26 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e630sm3842709e87.26.2026.03.16.23.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 23:31:24 -0700 (PDT)
Message-ID: <f1fb26c3-a7bb-4a02-aa73-ff73d295731d@gmail.com>
Date: Tue, 17 Mar 2026 08:31:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/14] iio: pressure: fix spelling mistakes in comments
To: Shi Hao <i.shihao.999@gmail.com>, jic23@kernel.org
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <20260316090023.14691-7-i.shihao.999@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260316090023.14691-7-i.shihao.999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2026 11:00, Shi Hao wrote:
> Fix several spelling mistakes in comments.
> 
> - opertion -> operations
> - transfered -> transferred
> - usng -> using
> - externaly -> externally
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
