Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52663469FC
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583767; cv=none; b=Xn03O9Bwb548gpuYeYdWEVhR45dhhTiWSzJYOfrCBv7PDGfPvbJtCsodCUMYtLPwfPz1my+P3fu/+Qoy2hOquO6DySogltbMVe6yDj7Fxe1G0XwXVZnuC8/OsPPXJQk96k5dLpWR8+tFJoiVmYvq7idfZspCKx91Uq4BTN8Rh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583767; c=relaxed/simple;
	bh=N2kFjKlbE9WU6r3wDdHF6nerFyB/aBWhVhhdRg7x15Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=G8wg4TCO/ij1wCoQ7ROAvKCwxysykQdfF7wFKUZceH6pPR+Gqc8AESu4/6Pqa7Xz3PtXFdvZt4LR2VKRFLWzrqcneV3Jq3Z26GGH3Ihsmd04z41kQBUQ4a8lSTVO27ZMWhjvFMoY5mPLjPNPNxfDpBUeUF6wjK9SfY/bFLMueaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d10Q+eE/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d10Q+eE/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso3792816a91.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775583764; x=1776188564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N2kFjKlbE9WU6r3wDdHF6nerFyB/aBWhVhhdRg7x15Y=;
        b=d10Q+eE/3cChsbmw2LasEk6iEleUx63636MO3yv6x+mDeZnIA+3JN102M6mzH6ce74
         tLcxOOPP6PmpQFjE80fOyEY//M4FWNq724wBQOoiq4Ivbe0XWewiFylR+GRuZcEorMBo
         4FYq7uR5x5mVRU+4S4lq+xFW82mabNc4gdWGbz7695UngLOFuaYULXqNwVY2lD/7jg1J
         M/6R1cNusEuVKSk3b1/G/YxIX4WfOvHJ03HxdEkckDd4qMPS8ffu64bp7+fT1lYOOEOz
         W0sgCNlQxQoI5JE4lBY8Dwp/JFRXmKQna853B40VjTUxUvYDlL6d7525O4gixhwt/nwD
         VqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583764; x=1776188564;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2kFjKlbE9WU6r3wDdHF6nerFyB/aBWhVhhdRg7x15Y=;
        b=WQTg3Z6B2sZBl5X4PKWnBeJxGu8hY1IL5Lpj5KGRZfaK5vzqv7TJOOLDusX+0EhHBZ
         BITGtFPFRG7CWohEgN3nDVJsuQxzSyBs0lrrH1wZ5Nyh2rrMO/Nf4CuHMAIEsqJ698xd
         ZfafVDIH6hFh3L05y9hSUBP8YaSuHfGJLgZiqMKQ2RxAtIJSVV5GQPT/83wfmazbNZa4
         2QfACWpfQJ4kugac5R89k4iRHJvC3YVd6ts/qvYyU4qFH3LEL0RLAU15SyPpW69TEKL4
         3wWwt6+GwIubBek1uTuJeytihoG1yDjAIIDxjKeT4XwxXeP0g4fUDolIYBYQdxHkaPrG
         lIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPTjZP0WFq2EluIPKqmP1FAnvIyTcLP5KcHluGfBZ41x6Ta7XpDcThd3qM7kBn4UEI9aMqp4f4oGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWN2oxUXapRBLAyVxJXySKthFtJj0MW9wPpU/sAT4vJNgyv5U
	JA+jnBx8SB+xHZdHD42DErt25eudRMIL+N5E+dfqrsHYS/nY3udZd08R
X-Gm-Gg: AeBDievQ0U9CYcLFZFI4/DvzGvK/lPdaGoyAO/q95Tv15GkTaHM22KhrO9KKPKsETJp
	qwxSjLjVIeEjCNI9vxCpZxY6jKb4245O0beDYCCEUP9SOt/1ka/f6wLbrSV+MlNxszR646GgsGv
	I1Cgw7LY5kHIIzK0ua7Ir9PLjGod3oCU5eMfbiOkdW5mixtN0SwKdW4HFNvwIsPav6fLFXS7Wjm
	qDhBW5+jIEskO7CwrT3Uw+aIwskWn42HKhwB0QTmFG4JORCgTG1NTEmKW3LyfN6xBsAY2EpK4Il
	JWARQA3UnI+V41uBjgpPXBA3ylVtvic47p/trLXhTlV1oMEwcK1izSPvc55irZBqR3e898Njh6k
	tIxdgNrg9iiUqZq1yKO06/mH+yP5SbcKRQAHe/g4vxL5DshNUA6sLoNfH8DAsLekctyRUlpdqrn
	LIjP/svVT6D+C1kUe9h6g1T1Kn/sIcyEFwd3atgE9LrXNM906svxLNNvL31w==
X-Received: by 2002:a17:902:8f91:b0:2b0:b325:7491 with SMTP id d9443c01a7336-2b2816be210mr160228635ad.17.1775583763409;
        Tue, 07 Apr 2026 10:42:43 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ae30:a700:31b3:856c:f304:d107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbce2sm176710485ad.79.2026.04.07.10.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 10:42:43 -0700 (PDT)
Date: Tue, 07 Apr 2026 23:12:25 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] iio: ssp_sensors: cleanup codestyle warning
User-Agent: Thunderbird for Android
In-Reply-To: <adP8g8rYuXbfT3Um@ashevche-desk.local>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com> <20260406080852.2727453-2-sanjayembedded@gmail.com> <adP8g8rYuXbfT3Um@ashevche-desk.local>
Message-ID: <2D18BE15-3AC7-47DD-9430-E3ECB201EC84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 7 April 2026 12:03:39=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Mon, Apr 06, 2026 at 01:38:48PM +0530, Sanjay Chitroda wrote:
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Reported by checkpatch:
>> FILE: drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>>=20
>> WARNING: Prefer __packed over __attribute__((__packed__))
>> +} __attribute__((__packed__));
>
>Do we need __packed to be there in the first place? Isn't it naturally al=
igned?
>

This structure isn't naturally aligned as in header structure u8 is follow=
ed by __le16 and __le32 fields=2E
Without packing, compiler inserts padding to satisfy alignment requirement=
=2E

