Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232D31064E
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963115; cv=none; b=fpq1qHmNhP0fFypYAI5Z1hqn+tYOhdv5c8DaSfzgbwsdlxBylAlFfSsKEGSGSeEo1Sf4P7B1EDW2GDxqxnHGH2drid458afYBlDjfZmgXZWXe9Q3BaV+Vd3W0fPWWLE6STD1xDWVjNOnFKTddGQPqu14mbfDlEsYdYYOljmifTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963115; c=relaxed/simple;
	bh=zfnKoToX5Qep+GYp7TpBRb60LAdEmDsHiudoUxCcZ3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faFBlsAV6dGHJAF8oEz7QtKIuZoSFMrV4tW9GgXgpcfdnkW+glGgxaR7Enywc/f3tCAHVmqZxWUcizXTAlnUU2QZ/v+YC8eyeWgu4zBoUdVMxH6iHKz2UbItygGq8W5N4omBmGqkCWfJe1rpBYcvsY+cEHWRI4Aa9sJ82uYWMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/tWYpy8; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/tWYpy8"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12460a7caa2so3926212c88.1
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 18:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768963113; x=1769567913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TMBluTOO1iJxxCpBCo8mF4pvpdslEVo42L/jLf85BU=;
        b=Z/tWYpy858y2gjcX7xDPEzjfeOOoF4bJS2VRThoAFk0W+uJrdbaDouX3jJ/5jCTzjV
         mPRkRJIWR0Aa2E/4IqZUPyKrVQa9vW8DMopTVXIMzdwyk65zQAr4PsjqB0+qY4HhuVGi
         8OKP8NoKhKsZnC2BTmI8GLRwQZkXCN5Tmp7QKFpe1PFwfNIdmlp3ArvDQCNziJewcZIL
         gMgEgz0ErlXyFPfs3T/DvBe/kNXlXDXzL8CXwsTCf+HczZuDHyRDX5pRp45fYdC2a1ov
         0xwfSnwSLhydA9XjTiCwyRGjjiHUtvaeM79BGjRGEQIuvcBIiM/wNei48I0LTIWx4SIL
         Rokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768963113; x=1769567913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TMBluTOO1iJxxCpBCo8mF4pvpdslEVo42L/jLf85BU=;
        b=HkDdxIG9IU59/bhe0Vr2TiQuwp1XM0/Sl3pTiPfYqkyQQetNZdldo7agbKBpUUgh5g
         KURZ/ZkCbMZYt+Srqis+5XzjuamEuqOr36sxRFwsHF42z/KMP7yyJu5zcFss01LWWDu/
         UF/x6HQajh6NNoxoABVG4Van6/34dCX+kogMmrO4qO0gwU+97dht47yoh7he97ziMhML
         LOJvG82LcM0ZSLBNqOPNGVz0R3Ne9FeykCAOpsaMqxZGM9yVQsF33MAqQ32tC3R8yUdE
         ymspW3lJV6sf56oQaAeCx/OxEo46IcmS3ALqykncGhM91kQe//hDaRRbWeh+o6ylpNuN
         sQHg==
X-Gm-Message-State: AOJu0Yy6d0DB6Kq8P/sQDBBiAxx6O73munV7szcsTdWtcB/xkiRHH7dG
	CYinybE/N1jp/oyxj2hSWMfBR9IJqSrRj2sPpD5CzNvT0p0VdJ56h4Fg
X-Gm-Gg: AZuq6aKIzlIi5bSC2E4aW5m+mVuGxEZrBrN2l+kfzaMSpkmJsGh8sVD8YaLowgVYqJT
	XA90536b/uJeDWqKPl1b/llgi+Q9SO9P9rO+tsuQaLonlEyRgVA9BjfCc/a3G89KUjuSxcJL/ha
	ajCqmGx+F7pTKmqT2r6QhUeEWolXPW9b9xlENhK2QLqhr8grivVNuT734MQi3Uj5Bif6CCDi8cw
	5HI2EWVyynUTcCLHRGSbrKN93ORoETSPqtLc6d9DLEa3JsRgORzdY17fGogl/xVTu1QcKIUobkZ
	T0KtxCHLfma3k+w6h8ffXF9tzyXKXkGXs5PGI128jnUPMbK6yzAYbwH1yW4GYtxUr//GqZ0SFQ3
	eqO7kUuoABDT1PTxQiVItExuZG7lZzNWbAT4g/RXHchJPn5kLJVVrhRN2nSWwAlLhMulWYX9EVk
	KRO/eCKkeQSGSKYoKFViA7gr+mnvdiqg==
X-Received: by 2002:a05:7022:7a7:b0:119:e569:f622 with SMTP id a92af1059eb24-1244b35bb2dmr9409676c88.27.1768963113220;
        Tue, 20 Jan 2026 18:38:33 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac58140sm20703271c88.4.2026.01.20.18.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 18:38:32 -0800 (PST)
Date: Tue, 20 Jan 2026 23:40:22 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [RFC PATCH v1 0/9] iio: Expand IIO event interface for
 real-world unit handling
Message-ID: <aXA8lq7JGZEF4ffa@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
 <4a04fa3f-c056-4443-a55a-e8622feb1c2a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a04fa3f-c056-4443-a55a-e8622feb1c2a@baylibre.com>

On 01/18, David Lechner wrote:
> On 1/18/26 12:18 PM, Marcelo Schmitt wrote:
> > This patch set adjusts and complements the IIO event ABI docs making them
> > coherent with the fact that not all threshold value attributes had a _raw/_input
> > indicator set in their names. In addition that, the latter patches on this
> > series update the IIO event infrastructure to actually enable drivers to provide
> > _input threshold value attributes.
> 
...
> 
> Just throwing out an idea here without thinking about it too much...
> 
> Instead of adding a new field/parameter for units, could we extend
> enum iio_event_info to add IIO_EV_INFO_VALUE_RAW and IIO_EV_INFO_VALUE_INPUT
> (and same for HYSTERESIS).

Makes sense. If no other idea comes up, I'll go with that for the next version.

> Really, the units only make sense for these
> two info types anyway.

Ah good point. I was too hasty in thinking the _raw/_input distinction would
apply to other event_info options. Will avoid affecting those.

Thanks

> 
> This would work like my suggestion above that existing drivers would continue
> to use the old enum value, but we would encourage using the new enum values
> in new code. And it would eliminate the churn of having to touch every existing
> user.
> 
> And if someone really wants to take advantage of the new naming for a driver
> with existing events, we could do the duplicate attribute thing I mentioned
> above still.
