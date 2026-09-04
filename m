Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282C3CB8FF
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508860; cv=none; b=sxCSkmh0HCQ2t2ky53CGrd+SrHP2gITUP29oh2pvZsjIqY0RjGpPweUlTD8OmqkyiaWImVLREehMXavNbRXXh1g+mN9eAxnx1en6WUsUSiDYoRX6Y3RT4vpW5LxhPXFaEHo5EiuTRK4rvYwO+3oVr5Gx7lvyvv5ARTPcWanG4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508860; c=relaxed/simple;
	bh=vGqVag4wFjLFkMIYJEEnMJNG4CnAqAchWShFvzaeZ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9+z7qVFcBvIxvpZKhdjLDvHNof0PHiUKrN41/EdCLtesdNNI4TbbLPq/YI+27wuocuTDE3VZfk/PxUGIfpWxcsfTXivTsHVmlFOW89wlgREPPGu0rx0O3NAtM3v0P3joue5zwyBIYMpNgTVu96EDIX8DY0ZFnPolU4UZpK8ziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA+C9K78; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA+C9K78"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so5715385e9.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788508857; x=1789113657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T4Gb5WJxXb42aBlO+sk0x3DNAAOhh7DBXxbOrDxV5Gc=;
        b=UA+C9K78Ov1/TNOgpVM9rocKbEDyXucot2KjYqp7Gb2o5at2BRGx4hLGu9FEzqiM5V
         kUmokoNSLdSnezhzup08uwont8lliDBawjeej7EGWyBbvigHg27vLJJeWdB/H4YvV9Bs
         vW+JLLj1W3dsQEFs7Q08wG0LlsLMceIc6xAF9y3uv1BvKeJ8nZH9dQZdDXi4Z9b6JJV/
         p8ftgafQhekyJ0lh/uL7G9O3pR5loDwW0IjPTjEcXWctJW3FrQ+H1JMywszfTY+5PmiZ
         EsQSurKrMWHxCS4DwI3p8fsK8Tnaq0SOpKvv+cSU2s8gPn4SAJt8FjOA1/6f0bY+JDUO
         hdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508857; x=1789113657;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4Gb5WJxXb42aBlO+sk0x3DNAAOhh7DBXxbOrDxV5Gc=;
        b=XPYyVpSD8Do0qjuk0bCZGPUjw7QvWOPYvgs6Eqqavf1o0wJuicI2w/sD1Z8vcbhU8F
         k/QPfn2PmzmYsalqHzZ5cJnzo1K3eIMaiDUsQMUj8Tx6S9CEI5RKwNfgAGkKDiixF5u+
         w2OHnu38GGv5HhOExPzR+A8eLNvXDzRUkTPMydLYYNHIZrqixiy7NKvAankqyDkYKRJZ
         0DR7rhoXYnYilAWSIsp4y4q7S3oNuxmf2jSQxHtAbQrlp8n8uIZBS4fthO2Jag9xsol+
         Jgr0g4x6oQ44t73mwkVbLQO1cpzJwLxdtQpDkewDAkoPPx5V66GK0oUezc95JFsEXUdq
         dyrA==
X-Forwarded-Encrypted: i=1; AKwUvBzPal7VsACoagEwmRYE0OmDgr8TCkuw1rSLqU43Ho/g0ouaEyERqGwXphexZFfFE4I75CCcPkFL3FQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kufx78n/bffklGW9v+RKoXj3mYyiETprXXlHo3WkD3FBTM6H+a
	afzqugoSvLd1aKlcybYAZEVj1C1Ojn03OilWqUxCbfJw4WvNOp1pIEaT
X-Gm-Gg: AYBFou1kYz2o8W78fxsArTGbKin43cuog/upkLgUxLKoNfx11eM2aYV5C0ivRQvARRR
	iThw1YOZASUE3niPXtMy5lnCGSMpNu5SsRU11Xzen+cyLrwVMPKRecOuFNoDlweot/nOqGOLLX2
	rJk+3Fo8lEsyoTYbOxCL/rfBVf6HAdu8zOK9ZhiLkUN6Zb7ScCT1kK22PL77FxafHDNv4nmD2ZM
	EgicJSuygDxeGVH3XPThxrEBxlRk3We0DjHYZeprEaeXdaZyN6Y1PAR6Jxvl4s+qS9+6nV1CdMw
	dvCfN62xkBMun3ka1g8Dj2hcLxM6L2/TeeCVDi7iiZ12V40biUeNVvFilC3P7RiVDayeHgv4shf
	IXWLBzE+8kwYBZQsqtYOfLt1B2KrPFHgzTChWM+Ha4AtfLMy9lXry1wvCDZcElTdcABgRM0tEXp
	/byNBTr9yqjOirKnPXC0Bx6aIQJFp55TMcZWuUs3gOFoCENV4ys+9fJHXKK++ZluK+5OaLMRi/F
	dyjzHAyGsLhvQs/oxNmADNOZn1TpI+XHvl6hdIfoOXaVphMds78EYcGBDofEAWhO1QvBjv1XSQN
	dgsVnddvm2QiXH9ZmNaX4pe9hyKvpxT7P/ArdRaHg4H2JjB1hUMT5dNkk0AQWUaHcGwBxSjXlyB
	o9FHHigBSWLfyRITNqbKsyJ3XeRWdLvQtB18I3N50GCgFzbftST1AmgGTudO/k1jat4ZBpKxfCa
	H8aeeL
X-Received: by 2002:a05:600c:4713:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49cfa20cd4dmr21402645e9.23.1788508856565;
        Fri, 04 Sep 2026 01:00:56 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588392b3esm5387070f8f.12.2026.09.04.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:00:56 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:00:54 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Li Youhong" <dayou5941@163.com>
Cc: wafgo01@gmail.com, jic23@kernel.org, maxwell@maxwelld.cc,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, Li Youhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH v2] iio: flow: slf3s: disable regulator if measurement
 restart fails
Message-ID: <20260904100054.00004a58@gmail.com>
In-Reply-To: <20260904010902.1481157-1-dayou5941@163.com>
References: <20260904010902.1481157-1-dayou5941@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 09:09:02 +0800
"Li Youhong" <dayou5941@163.com> wrote:

> From: Li Youhong <liyouhong@kylinos.cn>
> 
> slf3s_resume() enables the vdd regulator and then starts continuous
> measurement. If slf3s_start_meas() fails, resume returns an error
> while leaving the regulator enabled.
> 
> After a failed resume the device stays suspended until another resume
> attempt. That later resume will call regulator_enable() again. Without
> a matching disable on the failed path, the regulator enable count is
> skewed and the supply can remain on even after a successful suspend.
> 
> Disable vdd when slf3s_start_meas() fails so the enable/disable pairing
> stays balanced across resume retries.
> 
> Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
