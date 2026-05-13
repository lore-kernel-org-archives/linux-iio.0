Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E661A6808
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683517; cv=none; b=kEaDjs9qHIGoYYbcdBd5Pq125n2VdtXYcpoiu2K0x/R02nrIP6OKt3Nti57JnSMO+IA5nMXoeYcDdv7+ZD5+nMonu+uBhVaDTi3zjdwJESVr67S0CrtualldFLJUgSEnNG1soOfgWYT5WcOF28XjBF7DLY/ZT+XkBqLWQ0PX5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683517; c=relaxed/simple;
	bh=0iQin8+HkiJwZ7N38xKjr5xDmWGbGl/90nkCt9tvW98=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gKmwe/QK2SkUERbQYmePrAREpuSW9cXW/yxwl+f7ATTzO3D22KmqZx7DmkFLwjBAOYYz+nVWfuhE1YvKdR6rPGhwP9ycXHVZbGA/KRnfOojLCV86cGA5Sc6XGhWOwHvVVK2UYUJJZLA7F2esygpi1Htvv2c02A1Wy3sbihzSNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9gQT85/; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9gQT85/"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c21049dafso6353914d50.2
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778683515; x=1779288315; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iQin8+HkiJwZ7N38xKjr5xDmWGbGl/90nkCt9tvW98=;
        b=O9gQT85/fBjno1WrqhSGh26aI1CS8dAC2XRhjHkJic4Ksjkj3yFYcelxueDMkLvt4q
         EG4L6ye8pzkMANzNju7hLb21uGVcL30tgSC+m6QYyghSfP8pgXuOGex9ZPuo7PFmuSWG
         lMKVhTxdoDCK699gwSQ1wHKyAiKHUB03S6l1fpxNRLRO/j+Tu4yeD1L6O8hEs+fYAtqU
         gG+mi++83F4xjxbMvNFC56bL7DkIq21sRHkmKe48TKLzZmL36i9zH0YCRiLAgU0IDjC0
         Nsj1GIUAiYDNNnXv2UYs3x/S/o/GSELGRy7bQNvH+sjW0UDT72it4reFRZvBU1o6ltrz
         P72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778683515; x=1779288315;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iQin8+HkiJwZ7N38xKjr5xDmWGbGl/90nkCt9tvW98=;
        b=EF2/KyYi5CgBGtuR1mX1bqDxVURHKIsV2hCD9VtiTG1hewomS+DPI4cYdVXAScWHPF
         sPFZ9RllMQSlYDDPczruxg8q+GL8gwaRHk8Pozs96mmhu4ary+TlWOgDXBdaXc7D2kVp
         OqMHSIaC84OG9lRP9v36/Yzmdtoyh7Sf1beF/HtHdhR96CF2mx0gDvVqn6Tlxu8bwdcK
         Fi4OhiO6regHLpQOGIe92z4exK2OBJlAv0BDf3k21p6XkdQk1c1mQFS+78Ofq14KQ+s+
         TrV/9KwrKzd9F8rL+0vNHxDakginHTedpkufg9ekJ7ibwQGf2gnFRq6OcYkN/Qf2zwLa
         68yw==
X-Forwarded-Encrypted: i=1; AFNElJ8m+vbiydzBsOEtnkIgJmHPP5dfNkilrhS1Px1iCcvUptHQpRulVHd1amscrNVdGGk7qsBfCx9t86o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZTg+PiKkXPQ3QbRpg70bcKoFzmjqFh3WeLbgHL91txWffp+p
	gEKtycIUKaVDBbdWPREdHnCvxvBWiF8/k+4yGmbkpTwOOrZvXdoUwQ/d
X-Gm-Gg: Acq92OFwphgJXIErq6/hfMHStYZOuF7x/Kyo1d9cQPqSh5rZfxGBF32YrwgUzXElgtE
	mWCd94KA8ZSS2LLZyzvUKk3J38CXk/rv4MCmNf4luC8BnOxUBUJHLx2Zyr+ZBoz/hrQYtys27se
	1CJtA8jGKuh7NF2/UxEDnLYmwnOKZJu8MKA2Z2b9t4AArFk1lwj5oQr4uTe7bcjfonmIbBL/W7I
	SYWlZWuT5ZfgTsqPT2cVhs5aYJYy5ZvZKsK+cQ1BlXvgp6mRBGyn49PL+cPY8h1HcTXo1mHMK65
	FEJKrtiwVxcm2W/PTRFzgCTUe65BO1BFaQqbLXoexQsCSv0M8vSEaBQVOTT3r59iJMhCdSIfvqO
	HWdogeGcqrWkaVwht45ax/JOLvZkhWPW9vus2Nn1SsgYBmccQTbp610lCIX29iUUbl9NAE3dE6c
	7CQFsYh18XUmd4kSp2gyb3DC5LxNTOarInztuuvw==
X-Received: by 2002:a05:690e:134e:b0:65c:6f79:1dd0 with SMTP id 956f58d0204a3-65df6245796mr3703212d50.20.1778683515277;
        Wed, 13 May 2026 07:45:15 -0700 (PDT)
Received: from localhost ([208.185.137.148])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d969fb402sm9004063d50.3.2026.05.13.07.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 07:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 May 2026 09:45:12 -0500
Message-Id: <DIHMOLAPN64W.1W0OU35JH5SLJ@gmail.com>
Cc: <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Maxwell Doose"
 <m32285159@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260513020654.168071-1-m32285159@gmail.com>
 <agR4OExvzbhCNsjk@ashevche-desk.local>
In-Reply-To: <agR4OExvzbhCNsjk@ashevche-desk.local>

On Wed May 13, 2026 at 8:10 AM CDT, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 09:06:54PM -0500, Maxwell Doose wrote:
>> Include linux/cleanup.h to take advantage of new macros.
>>=20
>> Replace manual mutex_lock() and mutex_unlock() calls across the file
>> with guard(mutex)() and scoped_guard() where appropriate to simplify
>> error paths and eliminate manual locking calls.
>>=20
>> Add new helper function kmx61_read_for_each_active_channel() to mitigate
>> certain style issues and to prevent notifying that the IRQ is finished
>> whilst holding the lock.
>>=20
>> Update certain returns, and add default case to return -EINVAL in
>> kmx61_read_raw().
>>=20
>> Remove now-redundant gotos and ret variables, as the new RAII macros
>> make them unneeded.
>
> Have you used --histogram algo when prepared patch? Please, do it, if
> not yet. It might improve the diff itself and hence makes reviewers a bit
> more happier.

I *think* I used --histogram, I'm not sure what happened :/

best regards,
max

