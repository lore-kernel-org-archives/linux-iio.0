Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3632B99F
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279767; cv=none; b=nodYpmI8qzIQYVJ1zgUgRPyXvqEPq8iwa6V3NcCEDn6yhXECxbGYpVrVAxRalHcB/XxoI+Espz56ltLHDqt8t9z29Hr6mkrgOgGoOtMF+92RIXdol57+e2KRSmr6qnq0Q96BRn93Pn1v2a6FIjRFTdEP3nzRO/GOKfl9PLSXhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279767; c=relaxed/simple;
	bh=S8ThS3+nLqk+4kOOG3B2OuJ+lsSctBbP4+JTMPPVSw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkVj2zljZe08ZT5hb4/JGE3bSlMvcQeVp2mAHOg9SJniL9PTPGojDJjx8ARAWVeag0z+RADuGA1QNPZN9yFUrIMAwQkscSWuI1lI2QpJCed0ic9g0pSaLNOR+ahGZlYGrwq/jnMne3csJfDTjznnpeQ28oSTL+O3GLrnjCisEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REhW/kA0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REhW/kA0"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3938b4b7656so4508181fa.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779279764; x=1779884564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8ThS3+nLqk+4kOOG3B2OuJ+lsSctBbP4+JTMPPVSw0=;
        b=REhW/kA0rxgY1bnLZMNfBOVtiCHkMz85qAnNBEAg4ERNdwnGsuz8mqz0EAepvYzj4A
         7v3DORj123fZyBztqiXVizud7mUDQyzQe6XYniEZRE7zetVbMIAvFxqcTlRUxQRlcPT/
         pLWbKCKNFlZn3rBRr8X7GhroZS7ZJaowT+4aVtEfiMArFa9ExmczZqMi2zzBIiGHk83m
         SIxB0Zlsrtv18/ez1Th2PiffKHmFRWIVo5kh+jw6LblPlAcXuO3WMBXzmpfqV9Beymaz
         OlIxj4SfQ2ETI2BgJEV406fcgNouhRFJNZr5MInQi5lMfYay+ApwKqS1VdgcOVruzNfj
         1p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779279764; x=1779884564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S8ThS3+nLqk+4kOOG3B2OuJ+lsSctBbP4+JTMPPVSw0=;
        b=RToqB8tzgmrh1SRlv40PpV5qbzO4F5Gnk2LwoIZz470CjwD1iWks4vfHAD3VqrTqS2
         29MZX2PYNkuriWZ0p6ah9AERLCuxGm2QkHGtAP5OUJmZwG3ZxPtFHVb/drLxC8p9ULUs
         gf87hkfhQtbSxRHQnVWWWcTW0uVhYmHGfwmyfDNospXv8BecDhJiq63t0bGfJNn+dZ5P
         WbZXIguRjKHAFVXszoAGluP6r3j/KZrGdK5Bmq1ZdgAaBwhLRMSw6sRGZuMEbZmfu6cE
         LY/hlyfjspitzs6rEeZWs16LuSILs1LymK0PTNjn0teQoFdLWPc6nvMpKowFLNsUL5I3
         x8Sw==
X-Forwarded-Encrypted: i=1; AFNElJ/SssbUR5Uk66cyNrjHgUMa2QIEzj2f1YpNTC3Jnd3dM+B5b7vNGZfaxJUNa/6ZZxrqW9Jy3r4149o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWFcBNmOUqoIlFJUbOyXf6HvCqN9GsFRFrkbTp7AM4wEnO6fa
	MKm/h/JcYl++wSw978wDw5Psrp0SOw39AXyoHFx8JFd/84/C/5P5UZ0D
X-Gm-Gg: Acq92OE6Okt7HYm38ELhqghYen9JKZ0qmLt0n8wQRdtB5MBqLXKSjoLA0GH7Fuh5eRP
	M6S3Ddh2b6wLCzXRF5BlmyzdQl0aKZaz0fN8tOF5aAfVADYB3qYeSZPO7p0GaNnSm4ljipqRo/F
	rS9FK7L/khoXL2DXQUzmGCAs+RPRRoTfSZt+gZyU3ostQizBaKES91RzB/nS8C8zU0x2OKqsiVj
	EcYyh4f/yXr03Hx3tcjYT/aGCGTBKPNi5ngwDG0Xr6Z9gMSaH+2GauS6BffoD0R+6FgxXuov/B1
	nuy2BGiATBo4zqp9DRQ5wuVxIz+eO3DPQMfiM4loWMzTUG2B9cBTB+dAJKLov0mW1A0hXqj9Rai
	qD5IFbTX5F3DF18fCam8MTLMpfREwgrJI1l6V0Ted8eueYKn0Jj1H+g5+4MBgmWL+2Pr8lHRaoZ
	XEH3ntK5Ol1MMwHZl4GT8/SS/CE4kzuIpw23tSw8O13VmdqaNuMnHwLt0fUw==
X-Received: by 2002:a2e:a9ac:0:b0:38d:ed1a:a135 with SMTP id 38308e7fff4ca-39561d3e0c6mr32794361fa.3.1779279764225;
        Wed, 20 May 2026 05:22:44 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958874ff29sm29034171fa.22.2026.05.20.05.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:22:43 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: m32285159@gmail.com
Cc: jic23@kernel.org,
	tomasz.duszynski@octakon.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH v4] iio: chemical: sps30: Replace manual locking with RAII locking
Date: Wed, 20 May 2026 17:22:29 +0500
Message-Id: <20260520122229.15326-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260519212602.30541-1-m32285159@gmail.com>
References: <20260519212602.30541-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hunk in sps30_read_raw() adds an empty line before "default:" in
the switch, which is unrelated to the RAII conversion and probably
worth dropping.

Also, moving guard(mutex) into sps30_do_meas() changes its contract:
previously callers had to hold state->lock around the call, now the
function takes it itself. A line in the commit log would help future
readers avoid the obvious "I'll just wrap it in mutex_lock()" pitfall.

Stepan
