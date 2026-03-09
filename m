Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527F41325B
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086331; cv=pass; b=RAG3Z5tNflyE7MyDerp78o8WDR/Sqvb3TnIttIX9fMBzba709C97tg+NOuKQHKID0hd0kM0kxRtizJqa2T1x5mmYSJ6oskUdu2QMfVZ781QArJ46R7kCWAyBV/F/3XIIP7K1UJeplz9xIWZH0cC+/inoeLyZpZ2VV5jAAhRqQaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086331; c=relaxed/simple;
	bh=CA1oGizoUANZBUNkB4o7l2KHcKAooGdG+sT54ynCIy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chhpqb4cDywHrjNDCd25I4RuFYH3hVYcnk0s0i2bG5gsQNQzqnUkWNZL+IyPLPOpeR49rE76DHFqW5BKIHEySW0qIV5hZjx5Lv8mtwuqZjKhTbZ+qAydFpO1T5Azj4CWX3gMcYHCebCX901pBgXibkt475et8eet2eYaogGQhOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqPokTEv; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqPokTEv"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-662b42ca0daso1056608a12.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 12:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773086328; cv=none;
        d=google.com; s=arc-20240605;
        b=P+HMMYCMIjZlW1VOGK5y2m5gAP6H6Q1VITakK6fOkPOaVitLJGbw624M2ZqOYAdOSG
         Z2AyUASM23xTH+8189PhoOD+4onV/Qfy7hwvx6mLI9ALiDbrYxsoXKMnFlJWRK3AZ3XU
         U9gbbLZPgwufK2IenT99te3jk16vBsWMGoKxCflnd7Y5h8CdHyu7KnASC/GDjtaCbsDv
         huVP+ZKtOR0yaIwGQ8Jps0eRPqW6n8awxiAik8WnyEKe5CnI0Yh/hk7RILTrk3JQrjZG
         6wpuVEuWuJ3ikR06/CpwNhmT5icBpyd55FizxvZIat1FObvLZVuKab6IZx0EMILr6x4/
         Uk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G6VmTEw/fQ7f3SzdJueKVbKvGg5qHjNYFcZLopH6Gls=;
        fh=mBJqlc1qL/63frlGqn471PFcKUCt9CtqLQZuw0EGqbU=;
        b=gSf5fPwVlZk/5n219kGc873hsU6ufDyjMl6uo8Z/A5WoHjBd0Xp0Q8nV9fyUyd+iKZ
         Fozl9MO5YRsnhlnpD/UKdzYogViAWkSo81YYlDUCAjzIK8ncXWqe77phgxNgm24clDuk
         BgJnQE+HR5+HA2/JnV+u5lKXkoK5amQTtQK6QxfUZbP75H5aIEsnjIjSNEwOitbUffGo
         gsND6s5sDyS5axjszAmL1/23/akkIooR9SfrJ/HaAR8ZTSTUwqdihX7F9NQFmPfVuGyh
         G5ScbGA9ahqMDqkWvEo69Ok4DPLpX7L1fKV3WQIC8LMHtaiNVo6fdFQX0mV7AVU+Dq/c
         p4Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773086328; x=1773691128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6VmTEw/fQ7f3SzdJueKVbKvGg5qHjNYFcZLopH6Gls=;
        b=gqPokTEvZGWRHzkKV72AagZxpcP/eI25iithPbYI+8x/Iep1A2Q5/WcOFG5r+UnJlk
         qb/kHdNSsGvX2/fpYGfVSGYF9zke3HwL/ZyLEqsJC3R9M5+sgandE7+mBYxDx+aKrpvU
         yo4M5t3ufS5g5gFK5AkNnzOLKaRbURDvoLhKx2ErhyoqVQgwhcD/dyU26oec/L15/nzr
         fDNtPvLCS0c1LWFrO0AaPVQZvRQHLKdf+Pl+JZfdxmEoTM9aeEiA2GFDyutKNVcqDW2b
         9fXttht+Gk0qDA6tJnxTzMIdv+ggMApL0v6CaiebVBw9WphJi6rjeRp4ajL6PlmlIiHM
         re8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773086328; x=1773691128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6VmTEw/fQ7f3SzdJueKVbKvGg5qHjNYFcZLopH6Gls=;
        b=QZuyp6QwFqOJNMgxgPShYG+FZ39wgZcerGb5p5fvqg6zR0FzZvNKIqHlpf4n+Cb4ro
         InIzOKfn8z0LJxdOSp3aI5whF03dqgRDbveZZnXvKviUYCo3iKBGUtxjHxEDfICQCcMv
         Lr8H/z+SoUrruU3Sr470tceVc1CK1tvSHPPZoS+u4ZF68TY5uUkC+Se1YAE+RANuafNe
         +cYbTRhRQZrrHElnSrlMQ6r6aCJjRbAT7+mW7Q8OAlZZ6mNph9xMQjDFTyNJEYQo5xIP
         WD1LIZc8XjMvSS8HxntEl+K4+eaFkDJMkA2Plo5KzYaDtMuWvR3tpFFTF0cfcJ6ABI9v
         n1sA==
X-Forwarded-Encrypted: i=1; AJvYcCX86ZRF3/mGRhWDcCJNqlo/OE6p7iqXPu4iH1IfRmOl7Mm5vClR6HSjdUb2WViX6kYg5FYyy/o++FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyadfl+T6t7IkmnVGtoSLAIMoyMozyPL/MYg1v6S1xST6LAD/1
	HrAnOlct6JEVvhQopK7M2Mh3XaNEuqOJKCrpneFdzVaHi9GRR4DdR2bjZ/n0TvqTe1JBHKR2e1e
	/iE++EPpfCEaW7gqtlDgsclSWhbeF+no=
X-Gm-Gg: ATEYQzz3Q1h1/cQ/Xhf08vc6vE2SooE8e2IQ0pwDMyISxxtvGv/kg1iI9lvFldXLGJN
	alNHLjgL35eoxpc+2CHdBMdas6OYSRtB+B/6RwgZB8KYMyp4Wzp9Wrg7M/w25IWq7QAv+cPGi8v
	GhAXEoRe9znte4yQ+Vd/jnG/zHNRNVhBH6r7/dAdiJZ6FIlpEyRyfAHLEzAigMMXdXzmjEfYc3r
	V7/sHDUP3tYj2ijClVsWk3lZHUvmGZ6jwURqjoYnrxUE6L98Rm/rYOjVPCkm/GiB3Pp8+/d5ItP
	F0/2jBNYVhGf4P+ePesSNZMl0UxRVmjeZZzAz5OrylMXZsllwDzbcAAcVWaJMIwinq6QLDSkjrF
	6CzqVvfDrdTKau+YY95FqzgX+M8U=
X-Received: by 2002:a05:6402:50d4:b0:64d:e1c:4c0a with SMTP id
 4fb4d7f45d1cf-6619d2f1d70mr7223667a12.0.1773086327413; Mon, 09 Mar 2026
 12:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
 <20260309153408.71512-5-rajveer.chaudhari.linux@gmail.com> <20260309193010.104159cb@jic23-huawei>
In-Reply-To: <20260309193010.104159cb@jic23-huawei>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Tue, 10 Mar 2026 01:28:36 +0530
X-Gm-Features: AaiRm52Bwrjch4Pxau4YC0YuEVAMy6Wl_rdwPbnAhD7GlLlEp-OPWXNEFNchnY8
Message-ID: <CANS1UbiJgvbbzOAbi1TM5=N-Gj-LQoOFRyBUf06qkZRY3zw+Sw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: accel: sca3000: convert to guard(mutex)
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	waqar.hameed@axis.com, linusw@kernel.org, sakari.ailus@linux.intel.com, 
	harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com, 
	andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

Thanks for the review, I will add all of your suggested return path,
indentation fixes in v3.

But I have a question, should I submit the next version of patch right
now as you reviewed
the whole patch, or wait for 24 hrs as instructed by Andy Shevchenko
to let others
have a chance to comment, review.

On Tue, Mar 10, 2026 at 1:00=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> So I think we really want to head towards something like the following.
> Probably break this up though.  guard() patch first, then flip the logic =
in
> a second patch.

Yes, I will prepare and submit a separate patch for this logic flip.

Thankyou,
Rajveer
