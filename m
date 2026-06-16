Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9901428837
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604894; cv=none; b=gK3mZAbFKSOZz3qZwRewzpNGHXlx0EQIGHmpo28NXdPL8WusiPQJmr4hwf7QdssOhVfqZ5FGiwfQ3ecf8Xk9Cr/mM36WMRaUDPMUq00VHgJAjTq/9Lw/dqnF/2bxeoMz7CEWzvUfkTyNCB5AhqTlUFfL2sQPC0BYFiwwIBYGWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604894; c=relaxed/simple;
	bh=8b70yKWpOsIo+GoNeGTAEHv6IM1G81H2vP9yISmiMuU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jN8t3+laXNxFsz6ruOdJfLz3h620WTiRTAXERwrECB54phrve5oI1NYsi3zK6TJk4NTp1wbtOxnGqUBFqsb+09CQCCvcOfoHBw4YFHY3Va++GjD2vd0Z+RdaKSOEuMAQHX9xEUFxvUTNQaiXx5V+LL3DU9MyBS07KcJ8b/bFG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI9VgRO2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI9VgRO2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so2534952a91.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781604892; x=1782209692; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8b70yKWpOsIo+GoNeGTAEHv6IM1G81H2vP9yISmiMuU=;
        b=nI9VgRO23HICh/jCOilQlvCHU6LvSKC7nwVtjJGBYHe0zrKV+XCPuDZd2LscHPBLuJ
         Zu9jPpMPXSN//mjMjK5psGyWtn/nkx3FfLhvHOoQLfIIZzNjp10RkXYMJVK+75z1sSMT
         Zvx3jGMePyJBxNmtCg8qotU8LmuWQeeH35osSVMKIgiedubfZ3FcPcMDfWixZClFUAIs
         iJLXzpxTJdre8+r94D+YA0eTynG+Mvq8edwkQaZI7NWwK/nvYabWWum1By36TWqZW6Os
         jBYA42wWywmiXZZW7WmKgZibPy8FgU6ybrJKdHbiKrqMMBSzrXvJchGEeB78YpjlNTsq
         lHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604892; x=1782209692;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8b70yKWpOsIo+GoNeGTAEHv6IM1G81H2vP9yISmiMuU=;
        b=gf75/owiEnGvJ5xDsRgIR7gcmP2zkjCrjHw0l1AT90AsuwB5MI5ddrUdf2fv2xGRbd
         dblMHWAn6WKniPTqu/lpbtntlAW25Fz9PcrwGbbLgxMMca4AWWSc8lupILNgzd8RoAMe
         pKoLdOrfdoQDe/dE2a9IGTxrsCtOuwqa1T3tIOw/nv0R/CKngvwlEwFLDLZJOtlvS8Dy
         35iFnafI2JLCw7s8u1OVwCh4Z82xiY+Gd1bjvzx2hpmhzC9A4uV+wSiCZfyJzdjLdEEQ
         0rq9mFnbBFrQJoSXRUHuhgqlBFK99CyUqSHgnVK3gTVUnk0IS6IqtuXNO1u5eW+e36s/
         CO4A==
X-Forwarded-Encrypted: i=1; AFNElJ9VxHpAGUgObm2BuBLt41bn7A1gRaAX+VtW9ElTLYxX5L/x3NKWHxQFO8Bec4EU8VLsXSivnLO66Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkbR/FWeVVDB2cxjCwPuKWWg2Gat/JyaCtE1OtOmwij41atLI2
	ccI8nMIlQQA69nKNS6gf1iRn+bMR+/FSI4hfPaxMXNqmo/kjDPvuTAeC
X-Gm-Gg: Acq92OFqpiTO8KVUtklclOsKwI0idii5BnEGHVizVy9C9uodCpOhk0/jK2Tz6bCPA15
	BtyJ0Y/vG7U+SMdrqq590a7xpkz2J6/JOzqTxXkD1lGIg6Z4GPyUjHooa85PXQe03K9W3RusvOo
	kMrl2AZ8qg9XkTK1EaRDoNwp/vsLSWdicvVW9fZAxwtzSGLUlmGbF9ZYELwPolm9IJ9acK3bm5J
	fwqldZs8GGoN2VvBalDMuv9qn0KWexbJeuZfSEkfo/a2Z+F2nhybqx/K6mnQWY7lA2ihMBlMXk9
	nVfmmydIw20OLmVmtlycptidLRvJ1PzK5M1+/O9pZVnUnqGhuomlitH98KQRbHzdMobQLEo+LQK
	bCGdLYXVG2bUZbQJ24tgdU6zgsSgZadwcifpLCoA+l91Gr0X1PPtjCHZB2fRZQvIIJWCPFXqdYh
	edAWb/Lu3k03dqmJVSZvdfntYwfMfeGWf8FVW8bRfDRE2B7K5g7veiNqhqfLPbWJZsisUPzt/0T
	k4h9OfNY14bFqcPe3A=
X-Received: by 2002:a17:90b:2749:b0:369:932a:2b8a with SMTP id 98e67ed59e1d1-37a01e2e4d2mr17930433a91.1.1781604892262;
        Tue, 16 Jun 2026 03:14:52 -0700 (PDT)
Received: from localhost ([2401:4900:8834:3eb8:533:5f44:73b9:f15a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d156sm11434067a12.13.2026.06.16.03.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 03:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 15:44:45 +0530
Message-Id: <DJAE81LLF9XM.1ANC0QLJWQ9ZQ@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-adc12138: fail init on calibration timeout
From: "Prashant Rahul" <prashantrahul23@gmail.com>
To: "John Ogness" <john.ogness@linutronix.de>, "Prashant Rahul"
 <prashantrahul23@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 <linux-iio@vger.kernel.org>
Cc: "Shuah Khan" <shuahkhan@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Petr Mladek" <pmladek@suse.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Oleg Nesterov" <oleg@redhat.com>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260615111156.199906-1-prashantrahul23@gmail.com>
 <87h5n4uhn2.fsf@jogness.linutronix.de>
In-Reply-To: <87h5n4uhn2.fsf@jogness.linutronix.de>

On Mon Jun 15, 2026 at 5:42 PM IST, John Ogness wrote:
> After the timeout, the driver checks the status. If the calibration is
> not complete, it already returns an error with the appropriate
> information. I would expect that error is preferrable to a context-less
> "wait eoc timeout".

I agree with you. Apologies for not realising that earlier. Thank you for p=
ointing it you.
