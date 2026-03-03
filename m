Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE3200110
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544396; cv=pass; b=Oa51Z7Hyo4KyCXAGI1Q99pFwvoMzw9BY4D7S4kqWabkry9nDiAs1r6xhnzAnWwVoApAxtkrTODXuQUsMqRyqtDkROWQmNSxLTWEw8zJnvP/fXdHUbA+h+IuOFShe85fTU7666dltXXy7wEMzjJl6Is+UU/OEbBZMKDGXaQJg/NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544396; c=relaxed/simple;
	bh=so3210dXMcR3VFqshAkaNYEFczVCUvIeNURNgEKDndA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0aZJ2/A+YvQ+Pi2UeWikhj/1vbuCrOi08enVG6B1kgqnTLRK8qCfhjXFccWy16X+990J2XAm7ITF50f6u1yaW0Ofr/0kwKdEZAghTP025FwBjqlPevv1R8a3qKvuykzb2uObSDeqvU4FmKQA0yUKJjHmYHhi2p6Ebeztax/bbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzsIpx2d; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzsIpx2d"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3510446a91.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 05:26:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772544395; cv=none;
        d=google.com; s=arc-20240605;
        b=hvhh/ZhxDjOvOJU0FbponcJya76r2L2/rW5Odqr2PqWoyJon/N/WuJUtOM86tylI7y
         US8IywEZuXJojyIXZhQdHddFnlzCJ1tVr7FJa/beGjKKEd+0o+tQxThzc4X5N0zlRdlm
         fv6THlbe7lVRsoZaiwixCFWkBUKzGHV/qoTcngaV5glY79ExPE+goNnbjaYCGOm0R457
         PmgTRfCR2VsMfHIxW3/EVvOmnUMk5LbQ1h9DUGIwWVXLsK03s7wj7BTM5UGNoAKDZypA
         qS13OQ3lnicpeV0ktp47SOyZJqicrD6nSg7ZjMn5PSyKbXy+TgSKeqd4DkCEzRFfVpK6
         Du4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LD0deI7f4VkEqYBBBpja/0uaQYkXRj1zQa9YGHQ8R0Y=;
        fh=TL9E+fUjioStsWwdGTkgabfcKW02VqIusGIj6wozaEM=;
        b=GrCdBUJfHKAZUYhreDU6rSAuNUFkOhZq3I/05Q+QVZvpnc3GJE0YvBkqQb27EGy6ps
         8YR7dQh6ygdte9qa+UleXcVcVf1w+fK/xSWlSOUsQTVT5UNjdeh0q4sBuax5SYWn69mW
         qDUgtjWKALTwA3UBKgKsNrwAUZI6dhqMWDSVH5s0r2LcbASXtI69YKob+pdaLhghwYwg
         5/XUDXaKIT0k5IsdG9WmXxchvvH+imgNb6haCrG6zkTJcoZBCQTQvYnamCndpBwtTQjh
         m1MY8p0Y9AWVc7P1kZnP0e/K0Ge83w+xH8MieL8mo05qiNqS0d4p5CwU7qnBozNu8u76
         Uodw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772544395; x=1773149195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LD0deI7f4VkEqYBBBpja/0uaQYkXRj1zQa9YGHQ8R0Y=;
        b=OzsIpx2dtOWi4Hy1k8Ho95lUqDV7W97hNFW8ygOZ8unevpkh3OBWAht24IN4aZc1tF
         GYmyBR/kX7snQXXB+r5jfmWXgG5UN1hMXoukXUTGbR9J0+2ap9WK0UQO0mLoj6/65mx0
         lj7/K5ZhNU6xEYPx5ezvd9AKYsZZCDqp9ojpaaQYbzTNI0QI0mQQVMQzsdH+EEEzh1H1
         X+C6p8SR9IjKDXkU1jDneBydhs4pXgwN7YgLfGYo4QaB1+1BMK17/Mx++44Mh1zZR20m
         SVkkoEPNfNa6R0VAvFs//+jW9IPlXH6jyt2E4FhV0DvroDKIAcDgv2S5nYNIBJ7FAs96
         XCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544395; x=1773149195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD0deI7f4VkEqYBBBpja/0uaQYkXRj1zQa9YGHQ8R0Y=;
        b=B8eOCT1cY7Vp4/qOIztWlmgoKijP8nQIt6FOmur2kZbXBE1krgd0NLtFLg6IV3fx4P
         Mq/1XVB3sHkzSWtP+jQsSoysR05/PJ+SbQdHsM9ZC07eekzg2bZmEap7z3EOpxxtzma/
         SQs1ZHZMTTbZMdD0Z3cQ1CD8v2+yS9qX/HXO2M++ssjQTQYZNYuazJI2tsxb8AMuGFpU
         0YCBIPhE+jFv6T3/hEe3qOLooRmGRQv9OONOhA2Xl5fFWDNbfQPqPly4KX/uw3igTRiz
         w3odFjrAtKnyeEr0ZYAVS5LEdymVtO7mxtCtCApbgpzPkxHEvHLT4VE2hWeBvMKND2UM
         fjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK7Ygn+Q1jNfeLUOS5j1S4GtrJ2pR/5UmfcoYgy3VF+OGLcHPFeiBx1Bu4R4WHFSlFEcqMwhEh4Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRv7/Xeypuzf+Hi0Shu+n9eoMkyfbAiIjy149INF0mUxQmHgKD
	MTKgD8Wp5VWhDFeQIZ72fcQ45TLmRkBxEQr5WS7Ft/XhDXDxjX8Zg0PHx1bDa93+19Fy8cnvD2C
	k0IrsUhw05/S+gqNWcETI5rF8jPSSdaE=
X-Gm-Gg: ATEYQzyBscv7QwW3zrEjTxKQYsdQB3SOnX1k5Wz4ibJNWCA/qcPT7tOGhIL8PoK0EMS
	bCfbv4LBR/rHnBL30xKEnKc/Xx0WL7s1D9bGq2e0K2mr1yXar/dCpZy1u+sqPbRZ7aDLi5AcHnq
	B7VucuxledR8+m2kIHuskOeA2wVFUa9bqA/QI5KIN8XOMGHy/ZdwRI4jMIlzOYHVD4/gjTOU0U3
	G1UShe61lXL4qvBQO80Lw790p9cwPLkcJIOLaUDJCgVlx0TnZxU4b1ozztDD2YZGySJ72pKMK9c
	137sg7It
X-Received: by 2002:a17:90b:5408:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-35965ccab15mr11588287a91.28.1772544394763; Tue, 03 Mar 2026
 05:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-ti-ads1119-1-v1-1-e3fced089a44@gmail.com> <20260302195426.11b4ce81@jic23-huawei>
In-Reply-To: <20260302195426.11b4ce81@jic23-huawei>
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 3 Mar 2026 21:26:23 +0800
X-Gm-Features: AaiRm51WbVZh1w3ZueT4deGevOA8cwBt9lsTG30mwrNf0aeAn82pim6epFwmQ-I
Message-ID: <CAN4SLj3GSLbe_uMVVzXGH4vJH6fh4gKZN_thFR7bmx6CqoJT+Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1119: Reinit completion before wait_for_completion_timeout()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What's the reason for doing here rather than a few lines later.
> That is before this
> ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
> which the  naming suggests kicks of the actual channel capture?
>
> Jonathan
>
Hi Jonathan,

I think both positions are fine, but the one you mentioned is more precise.
I will update it in V2.

Best regards,
Felix
