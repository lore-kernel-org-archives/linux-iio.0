Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A8352C28
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302904; cv=none; b=sak5ozuMmYf8o9hTZQ44u9YOUO7pKqssNL4DrvMM0GaKwX4tAV48RsWb6xmAXWIc9nmLHz3czgloV6XEa+GO1vWwyEGYYuk4nOXwGJCjtxfMaMBUTQ4axeokwtmMND5GqX7j3L5jAGU4WghT6hfsb7TD3m+9EIjMt6YjlaJFq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302904; c=relaxed/simple;
	bh=iHpAy8fkyM/QA1Vv74ijv9i3B+ypLwMIsR8l8z7OzTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkybwZ4PejIQ0BQ+kwbI9p84UxP+vaMFYEQooo5qjlI9+bPe5HZce07auCIHrNwQ0FWIpZYnML8CMA3DUTuEDs6JlUuAF2sqHK/SxR/WP/gw1BwOWrqomcVV7NOE2xFtI+Z79p8UctzarNPyvS8+e83tl6HdB6KJh50kHfgQshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDafS6m1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDafS6m1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4830b67aa6bso389145e9.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773302901; x=1773907701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Iu9lFTg/05Tday1tDko50WoL1SWtLKSWWC87xwK5cY=;
        b=KDafS6m1F6rfH92zKiG1q6RGIm+xDIkL2cVS3gMSi0rMm7py7FzvASpPH2b5uIYYD5
         nQi7Bx5AgPG4wFLOYeJSLfNfcqVhTrnYZCatb0qEC8d8eguSw+MTYof9IdXVLTrJkMQZ
         JlVemH5uM5RfMyhH+XQVvQKNg9aOs3nA05Nv07esSWhjJnEDYC58nkROvvvMGz4p7L9U
         YbTRgp1wkLtx7x/6zRlq52JJRj/x81r83Ek1J4gTEThhm2UYn8Wg3lxmHoO4tVKPqBPW
         BV/KcEv3fXxZEVe5Jl0SQ5y3owTi39/RNaBZoJR3xmt629nefkA71nnqGMoKaYwn9+3+
         4C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773302901; x=1773907701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Iu9lFTg/05Tday1tDko50WoL1SWtLKSWWC87xwK5cY=;
        b=Pd2GhrYMyYcJavB3zqdbkWIwtX8eMKY9Z2SNAJGdSN1N+yFX9Hky/5RNvrh0lgJt8D
         XWHyILLqa12NSH5Hi/uQM7M8SfbhoSmC3j4tnwBHd4dOOhqWRgsovlnNmN7rUyCYzGJr
         rA0E7G8PZs6ojSA90UFv/rYvhLHK/xkqNwQmsJez329DNbGMhbimA4JgO91A90nwwgZi
         7ZFils2aqkXNIl1dtN1LIWMFVsR+TR6VsVpA3KnOVWP1RsGZdh8G7Gg8qeXQNZP046W3
         /jbBBYfaQFXoEhY0L/vksLSFHha/9pa1A5lVAeA8SJXCJhYIhC7hosDU/11zfWtEbTGT
         u+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVhXJfX8w6bJwg95Ucar3GKxuJcaNFe2egee8AxdVmZzUaDE7q1bNOmd10WxkGuiAXreuRUU4LhCWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+vNfUhY0yjOecjAr6H9vgi3enlQxvjz08XaciyIpv7LAq+uH
	a/v+Lf23WOxpxCQYd+DLu/DpPJR+UtMYS1mqVj10ZcfMOZ2VVTglKwbg
X-Gm-Gg: ATEYQzy6TKsCicpJMufMsCo+5rVYo6eKDsUAAKNVrZBuEXhkUtbC14VTvNhRbmx8nfA
	sXH45ACqC6JAI/jqh0qM+kae2abKl1CHu5zKsPfssat+NO3pturh0zaS8qeTKjjFMi/Hxdei+Ct
	94eaw5rn3N8ib52Lg2SkHpOeRKjqiKP6vd7JJ6EtpwQXtFBVDRYWcLO9vGT+HyMx05dDrDPqCsO
	301h8YFAuzYQ3nccDAPLC0xV8FU+Nfeu+GpqHP97AX2FlvEkXGFkUkkjGlqlUq8mu5dhuBN/CaH
	Kc2whd55iTgOipnblSVBPM8BPQCKza2tmia/j8UP1joY2/3Jj8ptJWY6H1h9dUbOGe35EMjYwz0
	htv9vPxOT2/nLlVUjhh4jSM/OwDi+5iIKgICTre906eIcwqH3DIwZf44MewhtTTM0p4nPLZ4lJI
	pMIrW75FTujKWoM5q/hZjiin5qD7GFC+8Kg+vkG2yqhxzjt1+qwug+xaUgQX5TG0kAKNU8IZPIG
	d+xL4stjC8fdgQ23oo3Ld7paUu5HZ8mjesDjAa+NargZxyGv9Rb
X-Received: by 2002:a05:600c:6297:b0:47b:d992:601e with SMTP id 5b1f17b1804b1-4854b0cc0f8mr49794955e9.2.1773302900778;
        Thu, 12 Mar 2026 01:08:20 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6b95sm106160155e9.6.2026.03.12.01.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:08:20 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH 0/3] iio: adc: Format block comments
Date: Thu, 12 Mar 2026 12:07:50 +0400
Message-ID: <20260312080752.48091-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix block comment formatting in several IIO ADC drivers so the
trailing "*/" appears on a separate line.

This resolves checkpatch warnings:

  WARNING: Block comments use a trailing */ on a separate line

No functional change.

Giorgi Tchankvetadze (3):
  iio: adc: ad_sigma_delta: Format block comments
  iio: adc: max1363: Format block comments
  iio: adc: twl6030-gpadc: Format block comments

 drivers/iio/adc/ad_sigma_delta.c | 3 ++-
 drivers/iio/adc/max1363.c        | 6 ++++--
 drivers/iio/adc/twl6030-gpadc.c  | 3 +--
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.52.0

