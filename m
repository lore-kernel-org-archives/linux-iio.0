Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B60308F23
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784945403; cv=pass; b=kkt6pmlDWTj9chUxTZqDKR/IuROEYeu52PlI/inmkPTL4/JlzmuqE/oqdDGdf8f9p939gN2NS5V3EKEY8hsWOfjnQb+KijZ98m8kAQ92tp88W2lJTZDiWKex/YffOOAQKDBISOxjfjkc1IvpTVNlkJjWYAv/ldv7gXUA4MDseW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784945403; c=relaxed/simple;
	bh=Ykz4oN16e2m8UPLH/sIlexJ6ulTek1lnz4lKH3TIRpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCPGVnhAb4VcP9BGElH7tQauL2yoJcMs1vlb+PlrrROmvOh9ms4YD5DVOFQKEiwOjA6mUqLNhvnHzIhmexgFYPAu1Kf+mG3SHaQMdtlJkFLhDLKf7j/WlUUaOkb7gI7qmd68lI0M5Ix55D+BtXfQ7uCSChWNavDhVt8E73X3S0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RStPY40S; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RStPY40S"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-667971437d6so927870d50.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 19:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784945400; cv=none;
        d=google.com; s=arc-20260327;
        b=rtiN3RgcvlchsDP1bmcWMUxvDCEqNobp5t0bJZXKJsl5Bvw8coYWBJe1fj/D2dFvLo
         vZbAmjC24pJ4CKadBBehVGA/sE7895LnOnGfZbLpq2uTAScnxkz2pLTy1v0imvGIuYKq
         VpIWCxgwegh6mjP/VGKfNYwxS9cJDG77Ej2a3WCQFxJ2SE0tVTIW5v7Bv987WlXRuX6C
         jflJ7KJ0Uk0YjDFQRAFOglIAJuZaKWIksAGkRR9iSpBle6smn/nzTCw/sFAtZw/cCg5Q
         jeGUwPUW2fWnRU38ppm2iAxageMktRMlLYTtCajSTPIi9BdDUiRoNyG31NhunXuvD/nU
         9ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O+XtrFxmT+vtqiozFhgCLyYnXvcvZ4n6cvsA7pNOdp8=;
        fh=nsGH5hvenSrVYWAyl46ZdZGAbhQfMnsWwL6/lfpvVdE=;
        b=aAvDxFGDARw0iKPcbrwhsSK080UtqtO3IiBBtItQXuW2TAKB/9IY41bsheie3IAy2Q
         EFCjRo5Ca8HQ4Bhs9n9EAI/9SkaGDtQQDupoc76FSNGh0EMZazyBlYAmjTZiomAWNmOi
         da6vVjrXhqbeXvRZlqQs8aEtOy35J6NzB3BVBl631JwEF0VEOUb6DtHB1vBFBb7+97ew
         5LfE99AUiBZ+kondiho4MtKikGuXvx5B5dC+HfD9NwYROVJgy2znFAazn1ogTyAgMqsq
         1a5pxTT0OuIXdgPCfZsYJti4YlTNy5jYoY+yU4FosKL3ddvt6Zs2SXamRq3X9DClNAvh
         I2BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784945400; x=1785550200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O+XtrFxmT+vtqiozFhgCLyYnXvcvZ4n6cvsA7pNOdp8=;
        b=RStPY40SSA6uxi7oRBGMLGsgKqPtTNw6afehnhqNipS0O3XcILXJ2kXo7dCXyOqHdT
         +HwgSJndZDG7leasakFUYhmX6afIoauWP00dE77TuJX3BaH5pk/vREt4s1dE8UrKHBAT
         6bgLEpR+ATjbaNnY634L8abpBHMzHo33N1VcDYDAYM9Nz65L0L2UOVuTzP/AlNn0ZRkn
         tbMpED7jBzcpYRrTwIpyJ5M84B7n8lNQfBPhXAufBTLFTEbafsRPzbMtg3uOLhYLRGGh
         bcTZ6TI1jRfxk5nXuyKFjPqHZ24+A89ogQLgGsLJ+Gso3N/cS5Z0X94eGSUNxIhX2E5m
         q0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784945400; x=1785550200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O+XtrFxmT+vtqiozFhgCLyYnXvcvZ4n6cvsA7pNOdp8=;
        b=qIctz8/BtbfeSbQ62mAihu3ssSdHZA2hev/CJ+fqBJd4ssNuqQ7/FMJG1E9Hnzni4s
         3UAM0EkAPsUsvMCd3LA2LxWRI1P7GaT195QY62CE80LXy28GECRasLiolTJiVn7oHDOb
         CxAQjvp5wKyf6EZFE/nGJb8iz5bPI+W2id7KV/RDPFVgJBzAwhrylneMj2EmW9d/jzlP
         ZA61nb1Cmy/pgK7VBZgu+84nH0FsfD6wEyx7ybdSs6OJDWVWrYT0v7KjLZ0w6y3I1gSe
         KwNRXeiqfsVjEVKetOGryIN20j7BJm6UP9SvuKBNpBbO4SwacdvlNBXRhhMyOk/nTUn0
         iKpA==
X-Forwarded-Encrypted: i=1; AHgh+RpAf9/MZClgwHgAG0o9BKafSiKwD9g6c1Kjugp/Hf4KL8Us/KdDbD9Fe/xnAX1kY7unLxx0vK28j28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZcbYE1fcEOOyQHcd2seTY6hyaaTXEgNlmtO0Mou1Q8i3GAHo
	GKOY4MWHK1ZVo0rst6DipO9rQ5Q0Ntnpq8dc5VKquw8BgtnlrOXIY4HvqUMOMbWmBB7Fphi++zR
	I5Hvnn4ASvTi0wGFqcx1EtOEWfkr4haA=
X-Gm-Gg: AR+sD102OBRmZnG6pXHm+J6Q8BaM/eLjG+P5D03zv33xzXUfgv0fsHUe3DHnS0+fBZN
	5Dlw66Ig+96fkD3rPoVcltzo1Kp2q/gQcI5bRcus4Xwc//zHwq19K+pjbhl7rP7RANRD9X8g3R6
	Lu/mKAxsqyuBeeWol8kg1pqdlsiqi0ZCz0LR8uuiy+67IpoYMFwtR6JG38YB6qasARAokv2RwrP
	sxKiYxlJfQVwpaoEFLgh4ULJpRRlk33pqYuO3j/983hSoov5j4Dkf4HA5uWfwabt7uGwIZEuyfQ
	j+d4SN3U72pqKEwkZHYu
X-Received: by 2002:a53:acca:0:10b0:668:7ba0:6798 with SMTP id
 956f58d0204a3-668c7a023dfmr150312d50.80.1784945399746; Fri, 24 Jul 2026
 19:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713223046.20779-1-maxwell@maxwelld.cc> <20260713223046.20779-2-maxwell@maxwelld.cc>
In-Reply-To: <20260713223046.20779-2-maxwell@maxwelld.cc>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 24 Jul 2026 22:10:59 -0400
X-Gm-Features: AUfX_myR_v9XX_1QTBWzooAI6JW2OyaFYtEL8Dm1CkQrdf5pz5iNvgMPG7_pj2Q
Message-ID: <CAKqfh0Gu-iZ5ucKXWY=wzkUHSm1r7-YjaXExuq=tGcjqg5eerA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailmap: add email mapping
To: Tomasz Duszynski <tduszyns@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 6:31=E2=80=AFPM Maxwell Doose <maxwell@maxwelld.cc>=
 wrote:
>
> I'm transitioning to a new email, add mapping to keep email up to date.
>
> Signed-off-by: Maxwell Doose <maxwell@maxwelld.cc>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>

Ping

I'm also away right now (sorry for not mentioning).

--
best regards,
max
