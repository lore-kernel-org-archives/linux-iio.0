Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423431ED81
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368775; cv=pass; b=QA49NTf1sIe59z7Orm8gf3I9cuaniNvbAT4j/Vi/gmExa4ns7WlrZE6bCIcykBunVIaiDpbmRif0fLdZzo0LPF8GJFDyoCOlLOYqQdRiTjue2siueSJDT4uMRL6XqnGSYOh4J/Kpc/NrEO50uWREJvfDGYlKuKJVq6t60KO/fqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368775; c=relaxed/simple;
	bh=7xgTZFRbQasdfUAN/oxI4ukp4B4ZjyvZJl3R0aWNiYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHtlrSY4QK4RHMESlL7PBGNKOa4sC1YiZm5Mwu8gpk/U1YF9b4extq8OXEA2pC6Ec4VfsUGSAMGBsbHfp/s4RkEG4hbpsJqm0vc5+Kzpu9VUU+LZLpUJEMiCHIL6fg4vA3/aNqLGGG4RS0xyhag7RPkpchNJdNkOew7qpFmx2lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMhXXYpt; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMhXXYpt"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bab44440so1276855e9.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 13:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783368772; cv=none;
        d=google.com; s=arc-20260327;
        b=LImtpykAXyChtUB8kw5sjp61CHKo6t+tbEou0CeyqHcsgnEbc8zgiubHRikjPPNqX9
         xfghqMLnaW95EzDC2zSRba3ySNW+3L1MWQRXPR8VlRJiTq+ETNcXzC4QOQ4h3v9t+oaa
         M8ZXdshhBAER00ZFsrKc3lCqL6VxwEKqiav3io+Bj++SWhfRd6t1TD+efx3WlfHpK3rW
         lQ2WgcDf0//lABjNzFwgg4F9rEfLevRXMWekt2fvSCwAR2FRuqvgNNMgZwBcgX1+ezGI
         5PYp8Vi6orCELiyPb8TeOnyWoTJj0vsabnYS64PIqUbSWYSpDW9qnQ3i3XZwSYM0ToRN
         0W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aDvYEoqJubUL1xXWscQEQX/r3sKA7/DX7CNPpGcmAVE=;
        fh=v5rJv9aKEX+WvQ0IsGfHxyl8b8AF0jr8OqrJ7ictzSE=;
        b=OX4YI0tLuQDacW8Y+Bbc8x4hjm2N068uACaP+jRlgKyEHxIC5Viv99I7b5cpg2ztps
         jIKNVYHIhsb5L0hVjc5qj3zl1EStmlEvJm38pFVk2GUFBKB2L6Bg9Yfwjjh7EH+tAXMp
         LYAIa6FIn8IjIf9ZttYLVfrrLgpHuUJy5TnusraJCZ8FC//s8KJOwuYgvBRuecYT8Z49
         XfB351/PzyT3118OSARW07loCG1bgpKC+tZy2sHp1byFutPmi2+slxOgw7FXAvbPq+qy
         82MO0eGsJArjTtlA0Q0i/PUShu1F9mLZEQLKXZEUrYLJx9jAkwNX/n8qvUDO/MPMHS7D
         hSzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783368772; x=1783973572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aDvYEoqJubUL1xXWscQEQX/r3sKA7/DX7CNPpGcmAVE=;
        b=AMhXXYptrguI6utCR3ay8BNBmG0hvlICM/iHZPB15xiAxX4EXFoFOybgPmKFdsdaN6
         nwvAT92q7bXqCOAMOijVPaTdgIz8hqR5qvfnLT01qO//ZHUkt1u4szRV1bAHATR+5qu1
         hX1QWalBYUIMKwz8c47/de/Q91eoqtHJAb0phVvyRpxSzF/tRoM9Zd623HWYwMLcAmNP
         rbpGnsP5c/LHtBdL9TPMJasI7jj4UinC3P6pOUxbAIBtc0wF6CPVXfFGubmXgeewjv21
         ISna3t+Jx5MAN9E30M0WUq7RSZx7BWTL7pjtMW/47LO6IamjmSWmPsQk22xwAnLswTuI
         0Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368772; x=1783973572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDvYEoqJubUL1xXWscQEQX/r3sKA7/DX7CNPpGcmAVE=;
        b=jEUHmMTCRzCV/JfqrCJVgqQfv9jZjajfkytv0FQ6dG0e5ewC45vqJ/5wipW9ZcgXJG
         P6HIY+o1EOlXiLMdBleeOMZOpiCwBt6+K5ZlYT1uH0AN54aSLQoz5JcIpFfXh4sp04FA
         28LOluvQQ610Pejk2bvPzhkHMNRdcLYhMHqrrEjfcliaHAVneAVQBOt4UYHhHq4fUXjM
         ESyIEph5JMml/cDI0vqC9tgMznV/RP3Z9cUq8zTW+5NShRxedLjZu9ZDBub7SK9JhD7N
         vHPIQM9BmB59kAfFjRo9OhSTkmNOjpaWiyyMaH/qX/uV1R8grkU42uC/hyPAdW4RGpFF
         fzgA==
X-Gm-Message-State: AOJu0YxMB7x3+IgwQewrVmD3gyhmESg28EdMsZBkq9Ga26aIrHjJ0u+F
	C78Mo5o+0hD6I6KUZX7Czuu03uu5NAa73Pq1wIhaXH3ttw5gKkCZThDZgaZ2xifk2oL83v9CEJo
	41I2rdLHLHD8qhqT/KuA4i6nwkUgzg/5Idu9z
X-Gm-Gg: AfdE7ckAPvlzt3P2YytwxS7a/WS9au9Kk8ezqfWI0Zk2cVlRCxKOlakT9X8JEX8BUyn
	T+ZJYgj5DeNnkuYoxYUIP7f/3wroNPi+YUszNyPg8M/YmodfaCHbO8VPfI7p5gNzbigt6+hclTv
	8+08hxszZZPd3yUfljUw27pzOlnKkggmIy5rp+VqL5vHv/C41Nz22gHpMncIGMqRz1SfcWkIq57
	3kS+4kvSQmFNueFS3G2gM/1Ygn2ik3UZ4dDu+kEmOkoYrjvfabq0xLbXGaNhn+cYNnUpX0/VgD+
	GeLbLy0YEAmMfSUiNm2/0QaW6B1u7nSX2nNPmfFCVtefJLxolUIV90JHLuPVoY/I9mGmS/+gMUz
	AH+lsxjwPk68E89wIFVsJWSTLJTYIufLGaTyb0GHeXbU4Zghzzou1rsMjj5Bg89dJORD6Bg8sdJ
	lzNnc8ovX1nAxUH1YK9SZIcUC75fkea+uuvulv9rPAu4VLB6LPgQWhtdxBzpA1Ip/pPB5wQ2uf
X-Received: by 2002:a05:600c:628d:b0:493:c2ac:58f with SMTP id
 5b1f17b1804b1-493decbf152mr23335925e9.8.1783368771910; Mon, 06 Jul 2026
 13:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706173541.4f25ad81@jic23-huawei>
In-Reply-To: <20260706173541.4f25ad81@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 6 Jul 2026 22:12:40 +0200
X-Gm-Features: AVVi8CdG5pyZ7NH_3EtTsJycgVKIjOv9i2kQLB8db7a-sdNFm5KzLvJNsPbXzik
Message-ID: <CALoEA-xH0CLMm+CTcyQDq3GLxJgTVEfyjxPWSXu38KSK5CtdtQ@mail.gmail.com>
Subject: Re: IIO: Merged in v7.2-rc2 + anyone have comments on whether to ask
 for sashiko emails to the list?
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jul 2026 at 20:19, Jonathan Cameron <jic23@kernel.org> wrote:
>
> Hi All,
>
> Note that I've just pushed the testing branch out with v7.2-rc2 merged
> in.  There were 3 conflicts due to Uwe's work on restructuring the
> headers for device_id tables.  Note I haven't (yet anyway) updated
> the 7 additions of mod_devicetable.h that crossed with his patch set
> as I didn't want to complicate the merge.
>
> For new work this cycle please base either on v7.2-rc2 or on top of
> my togreg branch (assuming no problems that will have this merge sometime
> later this week). This should only make much difference for new drivers,
> or for any IWYU / header improvement patches.
>
> On another topic. Personally I'm reasonably impressed with Sashiko's
> feedback. However it is far from perfect and I'm a little concerned
> that new folk might not treat it with appropriate caution.
>
> What do people feel about me asking them to enable sending replies
> directly to the list?

FWIW, Sashiko has a feature where it can use subsystem-specific prompts.
Perhaps we could add a prompt that advises on current efforts in IIO,
i.e. IWYU, cleanup.h stuff etc. For reference, hwmon already uses this:
https://github.com/sashiko-dev/sashiko/blob/main/third_party/prompts/kernel/subsystem/hwmon.md

-- 
Kind regards

CJD
