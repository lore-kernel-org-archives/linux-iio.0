Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BB4EE84E
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535357; cv=none; b=pBclgmLsWed+xAIOFqynV8hdg+ZD0u4ivSFD107FOS25RNeeFQoqVMO79Kn21ElerO9MOczdcBnr3B4SCs4qRdHnla877NopKoqYtLbJNPVLlia3l9J2dO1bVfp50hAh2cgKwLNEmkYtxa++EKYePzzj4v32rZ+HAxOdFsvr72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535357; c=relaxed/simple;
	bh=M4+ki+Py0psA74hqxlO+alXPMyKGmPPSW1IzTNtzjz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlImw+cI5limC+YEuZxmP/OD4LtEXG4yUQRnWOtopsWJssB/FytuBelE9CHdXSZTpyKRs9758cGmkaHfXbA4Awd2HvtVBhnLDzfwvoNWd2hVo9ZVLXd3s2plnwhhVDO5oAm9OfcL6mm/tBV1iYwcNo/CigEK+cA+PPlPHuyISS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm057xqo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm057xqo"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48431648f33so1564549f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535354; x=1789140154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vs3gmdekTNn5iwIXejCrVVf7IaQmTpkBLLWvv7YBNgA=;
        b=Tm057xqowst/FOp+M6pHPuoCOsg6pACoXsuk3E0X4A3bgKnOEJFnva3s9XNMXZ21OB
         HLtbqVYEgIu5kcqVstEqO5r0FzO/3/V8GK4usvIAu0J8zx4E57pBUaiV6ZoqsxkWKknB
         pnT1jrlUINt4m/2R6CxyIW5iIyRCJbxvb3rw9sgRrZJmnVnDTiBSRT9XZSHvI1zXUqsR
         0GXazLlcuoqNcHRr7riB49FdUK60lmJnEqWq1SQgtNZlprc0mOKd4g6+Qmm8CwIPij9a
         JUyJU13fjyQl2GZ8FDLIj0iBleyZzwZCzTAyO1N2C82bhWx/6KZLwYxK5eXNC3hAVpvR
         KkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535354; x=1789140154;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vs3gmdekTNn5iwIXejCrVVf7IaQmTpkBLLWvv7YBNgA=;
        b=HnDlHQzpsNssIRuLZKBBSeqVoXOMEgbowJ17cHr+vGvjbI2ehPf5FBw2DI1gjytfja
         c26m2RqM81/olfxN7KV0PlFXrQL6YWk2lQaLPrV+/TrKMlvgRqtYb0Y+7ZnyAQ9UPE9X
         5q9uCetZAEWJTMqjdNZWS+CDl21CULbeHhNi28LyKQFGbcPwmKNifKzRjqrwlxlxK5+i
         GA8MolXIxBgFTVMCl8bunD7q+bzY4ABxa/8D7N8LbrcyyVMAkzRF6mciLs0fFL2ZpBU2
         JCpXmEqCU6tm6VYN+MZzajjvQlgxP4ixpo2fxnOndkUskICTVlS4/ooQuQ6pTJbsCA5I
         35hQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW2D1sZ/yxcZF3Z3aTXYe34GcxrjQwLi1+DFDiefe1oJF6+cEhCrDhoGB+ZALZnpsAYB1TAc2rphk=@vger.kernel.org
X-Gm-Message-State: AFuF++kzNkZn9f9aZgV0Mvr0+PbWC+7ijBHxdHyrMeppeXAgHV3WObRj
	wCbqTMpDbINcNndNv+8GoGmvQfiw1xY15oXKaWu6Y3z9TiuImCPjyoVx
X-Gm-Gg: AYBFou3S2LbXsWbjwwEQbMq0gGK94md4hxfagIZHHPYUcBBQfRvV4+If1iZaADy3EYP
	YM0DXY2OWmvK+LXMm04/WtmQ/ybTlhcUxgSOgfcFyJgfrEU8ESOpKTYfdU7fF31yVHZ5Rtu/dDQ
	olRzN5FgR5gQQKLnTtvUKuwgMgxwAaon+PdhhcPUSkhL8dqjBGmGirHoPqetbHASXgVOewVOwAe
	zGsY5V+SoaOZVpT7HfWH/WwF5+uG+6/1NcS11uLbJkFeXb6OrhdND+7NLhcnGj9W6UlfBRRRFIk
	8k8Nnb/LLpP3APpxriXoLq0OX166NM5Jgbg/vLypiWLGghUlZ/T1GLLQRpWF1EOl3H2PLqsIruD
	4MtOt/2VhVxGLXtyhERRy2o9sGy88B+O8UPhlR4ZI+7O/Z5DjO2lqZJsEbnI88gT7XzPBY9ivHN
	k9Tv1J1mIfr32hH0GQvzJA//qVhLvVtW/KuL7eHqsTpzrQzrEapXFrphi6M/tfdo9JnwTZLJ0yd
	PT9BbuJ5NRELS5V5RPY9i08fRm5PL3vVUKRB/tyGCQL3HOxy1jmXt5MXHZZDzEpyKujqbtkaGHN
	sbsAuDSoorBKAaBe98O/lHgl0hCh7GfR8+5RqBKb9fSSEDYXee+Eo6R5R8EFvpshs3dW46iSNd2
	CC8WCSL1fQrvIUBGiIV0yP8ZawPi29rzLALMbGXDcdgQ52TpmOKPvwF55+7F6J83TcxTvm1YQhr
	BZ6UXsk/5VSXIjQhty
X-Received: by 2002:a05:600c:871b:b0:49b:4eb6:6ffd with SMTP id 5b1f17b1804b1-49cf82cbac2mr58224775e9.5.1788535353501;
        Fri, 04 Sep 2026 08:22:33 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm160442515e9.15.2026.09.04.08.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:22:33 -0700 (PDT)
Date: Fri, 4 Sep 2026 17:22:31 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, linux-kernel@vger.kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: fix typos in comments
Message-ID: <20260904172231.00004b28@gmail.com>
In-Reply-To: <20260904121628.25537-1-hemanth.selam@gmail.com>
References: <20260904121628.25537-1-hemanth.selam@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 17:46:25 +0530
Hemanth Selam <hemanth.selam@gmail.com> wrote:

> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5

FYI, the process now is to just add 'Assisted-by: LLM' as to prevent
free advertising in commit messages.

> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
