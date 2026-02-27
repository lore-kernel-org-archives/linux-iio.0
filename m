Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DD3603F0
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174534; cv=none; b=UDtnYukZDQtAMV88WyBOMeieSYm2HkhLT6/y51uBLEF/lYx1L+p8eIdZ8t/7YO7FcnHJcpnBgVt3BqLG4yZ8/xSlmK2JQ/El1fAAmc8yo2r318d9I0n6A7VsoSMulcEfkd9sU5JC0dKYTbvED3GFVm/4FCWp4S5dHr62jqdddEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174534; c=relaxed/simple;
	bh=MlU/NhOGYcbdW214lqr8s1ycuVN6dxQdZPlBV7yR1v8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IRdqyFbJUf05mwol0k22XsaTx3swIm3j9E77cdCtFOKmGrxo1p2zB+t/ROPxgAC6xJcya84rWv7TKuaFDNUJPDprufZhxztJOCblp3qgmoP+t8LunqgL256pgYyl14L80f5v+8/U9WC8gWBIZk7b0oh6w+En5Y94UAGWrL7qXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifqqjpw0; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifqqjpw0"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79800183233so23787297b3.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 22:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772174533; x=1772779333; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlU/NhOGYcbdW214lqr8s1ycuVN6dxQdZPlBV7yR1v8=;
        b=ifqqjpw0PF0hb9kMrFhu0zjmF6LD7id5Sx7ApK4kduVoLqkNGhqSxfK9lDnbRaxrEy
         z64Y6OjMGENOgjKG6YEUbSbiLOMWLUFmQfwWik4tMTw3CUOoUFqE+rRsqSusQYFMMyt6
         NADUnZVoqdYn3Db42X2Em87OQngs6t16IO7uVHS3gq2HdafbITvGrDzPRUr1as+Lbwl1
         JE6RgV587azxdPMra3Nnk5vFVlWNFXYlKfObRnvMWL47L4fLxGIYKRGs3uxo6R2h2bSH
         df190FFZoc+utICCLd9L4s8HBbm47SEExDuwnX2FadFVfVHCyPw6HAjr57730HtVMS41
         PiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772174533; x=1772779333;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlU/NhOGYcbdW214lqr8s1ycuVN6dxQdZPlBV7yR1v8=;
        b=EfIDX+J3te/YZXgSg89KqvPZd0/9WtmiNXz+1UE71Vtzrs9OBOMrv6CRfHSsyTeCZw
         svFcmKxs0CMVnTWkta0wj+A03RRdHjc2wH1XCp9fuNGFKV4wG6tvENLAQwEdkoPriDAK
         idcezyENjj3FfUiDqxJ4gvDxvFGE843zHNzrv3GnHYNi9rddj/pJ5m0MKtSn6+sa+MiM
         7MMCAyk8h18OjNdcVo77Li5ozOS0q38L565ZNm9y3qGuq6SJh+dmMJSuDK2xCj+L0tuw
         hjtiJbPiqeM6ra0M1Uwe1Lt09CCnkoYizVg5eXM0evP6Z3aNbzUqgvXtbt8lwbvCE5vQ
         890A==
X-Forwarded-Encrypted: i=1; AJvYcCVyXLw+jEdPSd6SdjpSGEE1AQyjLZ/gioQTdljuijOMHcZNhKbC+rtqr/wpgv8Y2wQFPTZt7YngDCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhEMR2mukKXodiTPvyODKZmxyn0FD7jLN0KnFy1vfUFGDGqaw
	0NZCajgLPgE9IXfnTKEEdt8J3Scqcw22KvqNM27r5qKEqcNMro6HUdTO
X-Gm-Gg: ATEYQzyMwpu948RYwDy63Pj+c54PB+NTU1zLSouy3OXq1J+4dzsPlVqg5C6odaQ1SI7
	zCxFgOPjH3HsgvnyYQJy49vtYZzXuLRFQmfv1RByRe2kvEWcwzr8+GJ0hr6BQF0Yfp6rFAQPKFL
	jNpvsVc5w9xqvo36xuGo1T5g3MYMDn/2bfF6fh0i+cfJGYOIXAW8vGzB6cIQXo+SWjL3pYW40wb
	5RnJ7Biwr3HpH679nRbKZo6S9oJkZlmhcoizeDnpEffRYuE+fTPZMiPwUFdFdaOOioNGV2dVH/h
	k3OLxOq000eMuMYpFrL8J5FIAPR3tUY+C+lwzaZFu16zZg7YffYkdNT9Rgh/Hqy0VT1l/9SE5Ek
	UN0eCbsi5PHb4av2D8WKgPkrFpRmfpfDlAx49cRObagYNByMqYbHPy5zpdDyZVLB3U3l+jAsfKB
	EpHznRSuuurrXIsWpm09X4KHw1ErWqzWGiQOTmQjN0vY8Qh0awlcpuNfDV8WTYNcfMuzMmZH13m
	MFYM/EFWrPflAqYnsMkPmKchQCGI56IVvEkTZXkxjN9rAzep6b8n4tMCHlUTNgZ0kc=
X-Received: by 2002:a05:690c:81:b0:798:6665:ca0d with SMTP id 00721157ae682-79885ac731amr14280547b3.28.1772174532861;
        Thu, 26 Feb 2026 22:42:12 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:4c6c:c25b:2031:24dc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ac3c0dsm17962127b3.12.2026.02.26.22.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 22:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 00:42:11 -0600
Message-Id: <DGPJFWN3WNIG.1DDAHDOZ7TTK@gmail.com>
Subject: Re: [PATCH 1/3] iio: filter: admv8818: Add missing error code
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-2-ethantidmore06@gmail.com>
In-Reply-To: <20260227061424.1135505-2-ethantidmore06@gmail.com>

On Fri Feb 27, 2026 at 12:14 AM CST, Ethan Tidmore wrote:
> If the macro FIELD_GET() returns an error code the function returns
> with 0 because ret was just confirmed to be 0 a few lines above.
>
> Add error code.
>
> Detected by Smatch:
> drivers/iio/filter/admv8818.c:335 __admv8818_read_hpf_freq() warn:
> missing error code? 'ret'
>
> drivers/iio/filter/admv8818.c:376 __admv8818_read_lpf_freq()
> warn: missing error code? 'ret'
>
> Fixes: f34fe888ad054 ("iio:filter:admv8818: add support for ADMV8818")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---

Just realized I should have used -EIO for the error code. Will wait
however on reviews before v2.

Thanks,

ET
