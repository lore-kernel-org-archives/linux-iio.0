Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C833D506
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468431; cv=none; b=puJOJi+WOCwUmjlisJ+2jj/QpHRtfoe7WFyEYTmCJDTbJpVcU8nQT2mq2TpfxficUVm/1+keEK+ZjyBniGsz0GXeSggRb1Qt3r3ygS5bZCBldxyMbOwMgOtvO2eIaJS9G7AsfBx68nnY9Dpe/62Cvb8jDHZ/O5Bm6YrdEObgzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468431; c=relaxed/simple;
	bh=1mFJwss2uddOemB0lfVnj8btYhgYyzmfcfvPotLmuZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfIigegHjlutBe///KBvxMkW6tY+j7wrvI+sWhk7YJyB4LK78S/tQ3/wkD3u/WOzfFdPD7HHrxlAX3oUnVxAC/vp0juR/r/FPQPe21CvmXE240HTk0n61rVj5AdLyeDKPQAC+qyc1/nrLXmhD0BoRXtXkf3IzvopUowJmYEieVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2JvzBEw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2JvzBEw"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-beb7f26ed62so413926066b.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 23:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780468426; x=1781073226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8okQsbU3P/WBag+XtfX7e4+WVeyaNw5gsz4Ik6CGEOs=;
        b=Q2JvzBEwoGOvedZqVYEqmNLavOQVlLnTyp5vuVqRH4s6IO4uxodamqR5TDJavO8iO8
         5QbiB8XW464mhwH1JWFXFQJLtEtNBXQ/0OkS7LYZ8+GX1rEvGVmARQg1gT++rtAiEXjr
         MFW6vhaaFFFxz4uz8ijkPss4LHsg0qap71YgHc6lXZOSfkoRYbvc3OTXApYO+ZmmOMVW
         PsQxmbPOlOKNzs7CUWL3e8XY/GFezqLkB6Ty2HY8v3HCX6oK72nK6UDD7MPuwGGCCwdU
         2k5A7zYwlc9N7U3BJvFLcfIwtiU18Xe+aXMTXtrTFjyV4HRJ+9bL0/tka8tnxkdFIhq6
         Qx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780468426; x=1781073226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8okQsbU3P/WBag+XtfX7e4+WVeyaNw5gsz4Ik6CGEOs=;
        b=dmIvSEXd/w0DOxub1skk7l5tuOUTgwEm6hz4ntSCVQ7sqWzlaB+XDjq/pdMQWw4QHC
         KlqJD7ax9BMzpDq8QNYH9y29pzzqpYlNx8gCPExUJgz/XVBYMiJS+CNyMeiZI//c/JEf
         uqlWdjNHvYZ+hMHq/h89R4lSC7tXKsUmE5UrLsWAdyZR64BfDpr9H1GgZvW/m0CUsqUn
         p3mcpnar2NEhze39byDDsUKn1nuN20u8diru+4vQRvyrS+UzHEjZS+5MQbPE0vJnGmjh
         0E1iTmQ4ufJx8yIBSW6CVNs0Ucwk6B8OVLx8bOsqo8VXB4ngrqP4ukdbhrnRWI7fEvBg
         cgdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SPrQ/FrGBnuNi/EAEUr7Ydvrs3XLKBqI9vjFv7oPQnxvxbA8TKDtVoSgWFU9XpF1t9FUqG/b1C1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2qW8dinAfsu7Upvk59ZLh0qSAay3BSPLZWN/NJCVsutOOiNB
	TYDxfxrxIC6Y7rq0VEPepsHmVsOuTbJQSRJG0bbbsJoV5/AUMGBByP/I
X-Gm-Gg: Acq92OGTAWLEj8qCfofk4IPovrbvSRZAtVVmGp/VncduvESxRspFR3r8PvIsLYslq3M
	PVlr2jCNqC5b12QVxnGnUQoHJMZYHnZGnIx/G0dZQRS5CLwvqROw8kkqrCrDS1D0pVX51Ea2XPc
	FySTtH33XC/+fxywM8jYE2caUGQF0mIWrOOPBh2Dgm6aJE4sXqoz+2IY5GoaNtmYuenxXN8r6cP
	ZtMhU6jG/Bqik/aV5aAs4bbVVtCZRRJe+X1fbRMl4PV6rzs6Mioj+wJrE1krW008lwZlQ2Bt6QT
	f8644tsU+QOQUEKTTJqRYC7LNRQ5Y+xVX4ophW2EJHKB0pQqRy/2mCWsClNLQdGeMAnEGwPeLHW
	wUdloSwOZ+vhSlB65um4AXyO/yUK/bnT/nwkR33hbignMscDpyIpXYV2YkX7x81An4NNGJYfCVG
	GTX7LOrDxxcdvAigZABmax7bnw4I5zeQ==
X-Received: by 2002:a17:906:8446:b0:beb:f976:5235 with SMTP id a640c23a62f3a-bf0b1bce8f1mr51527766b.18.1780468425538;
        Tue, 02 Jun 2026 23:33:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051b0sm89899566b.31.2026.06.02.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:33:45 -0700 (PDT)
Date: Wed, 3 Jun 2026 09:33:42 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jad Keskes <inasj268@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: impedance-analyzer: fix CamelCase in ad5933
Message-ID: <ah_Kxh6A9YaArwrU@stanley.mountain>
References: <20260602201428.213890-1-inasj268@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602201428.213890-1-inasj268@gmail.com>

On Tue, Jun 02, 2026 at 09:14:28PM +0100, Jad Keskes wrote:
> checkpatch flagged mixed-case suffixes in #define names: _mVpp and _Hz.
> Rename to _MV_PP and _HZ to follow kernel UPPER_SNAKE_CASE convention.
> 

These are scientific things.  milli vs Mega etc.  The capitalization
makes it a million times different from each other.  We have to be
correct instead of following checkpatch.

regards,
dan carpenter

