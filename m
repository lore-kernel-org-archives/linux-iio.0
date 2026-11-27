Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804003;
	b=2j1Dd7j/LfZ4G1NfmwKSnKhwChy2hkmF+CLx3N+07d1C5VlnHqq4wyYjufh1M3g9JcPA
	 AFqQEkLaRUOoQgiX2r//8rF9yizzXSo+ygErxNXQlhuA4f+p7RlX1X4TjwKFz8q1PIr7s
	 on0ncohgs9rsYG456r/dEzqLJlRf1sqTM9/KqBHfsVFR9pn+xisMcSblqFYyGFq7yQnWZ
	 So64OOElMnWU2VpWjQeSlucCJNvmuSqZ7BRG3BI7xPMrw/uOAGpu6QvRY5dqc29MbMPxr
	 CVJIjyCnRoDu/JoBA4t9T8SLc0NlWPZ55SRG5MBDvV40eW7X2vGUH0dbYvDnoqDVUEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JUIkJDYEkx7nTz2oOBs8uKitK8ANRmBUsBm3gZYTVu0=;
	b=45GQOnoT3gxDa+xwu3yqkfGoFRpbY+wrGXMHKYtcWGhc+jO7KNVvfNgfVwkSrceVEQkA
	 G5IdhOHpl/v/fxF5/gatBSCF4dpzji7cW7usQFx25PSrtP/YHx3czBZH59cMvNHe0Fo6d
	 QRrRnIDyn7suY17v4BSDtr1D/1QsVK9Emv8pP6n7jOnI0ssykivv+kaETX/obFCMRDcAR
	 dbBppX+vGFyWF6/Uk+SAHh/NuOpK8XfhCTNQ33KS9IvKKSF0PTdt/l9FmOA2V2xDssCN5
	 0AkPZXWNgEw4VuuMxX9h4FHRgXXdnQ6T0R7S0IuNxyr5jPrYV700cjXcvoIJva8r6pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scKjForM;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C97606A32F
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 18:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C97606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scKjForM
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-94965745d92so818460285a.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804001; x=1796408801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JUIkJDYEkx7nTz2oOBs8uKitK8ANRmBUsBm3gZYTVu0=;
        b=scKjForMyMCNBTCUEurAxDY/3EwMt/oA/zkJdNGd6I97dJjAZF1l+GRpZMtuWGSCGs
         AGAKCPFgA4jiH08vzap3RvR+6VRN4lDcGKWIRhLP0Wmw6fm4R9zWkmvCicZ/VPeerQo7
         GHk50Eb5ykRVYKTbeEFCDMXNDOBev2C+EffTurrpZ9yK184OtGWZzMAyZobQS3OgCj9A
         SgZr5xyxMBwhn+K/Raebsvg/P5XWiVwOVfg/05/Fr43aGHzd0Y4Nh5x5PJCjwdj2GgIN
         WzOcnxBlWrpGQtiCZ3CSucUPrPuaFZHLYfgMuGJDgKZcvKbQw/c82zso4yc/4/W2LmzG
         tjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804001; x=1796408801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUIkJDYEkx7nTz2oOBs8uKitK8ANRmBUsBm3gZYTVu0=;
        b=blxM4aMXcU1JtV2Sg+Q7KiQD8loO1NFuGMLRrCu78o+iLT4e7MvDv1RFbTt1kO5B34
         y51xxmyRKoJZhtL46OON9RgtJAF5xWNVakhJAqr5xQTvcRygtng8SlccHtO59K2+ddWf
         JyOejLUtCHzdVWja1MftplEJshOJ5x+MLLPQ0uL7toH0Mpx86ANKyAt09onFMtXItaF0
         ccMyUUUMkNOZFQUUNukN0d31KLyPtFqg83Has10/LTa2LQCbvlFfrNa3M84JQyMqw654
         j1Xe76Ynz3nq/UQFxif2Nwu8b1ZuAyatVtNG5H5UVO7HKr35L/TsS9prVihy7+ZrDUFh
         CJKQ==
X-Forwarded-Encrypted: i=1; AL+hErF9U3YTnoCuA5/4JmXQQK0yl+DueQaQXF6RUsU9+NS5VUJ0DWBTDTjIwAkYiO6k5wucvl1dw0NSPsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UeU7oELF0nMzxJB721cjxziTg+Js9kjrLRMiYCMfFOJzpCIXv
	m6AeDeihg9LhcOfbFskdlhJ8CEuqhsB+y0SsB9S8xWtk4UOgknN6Xc0d
X-Gm-Gg: AZFdTZe37mfSe8A5InNI3R4srnBYN/pNWfhZZ9qUmLL1WEbCYTk/NiUoinvYwVC+yp8
	KOM/8+oW/LJFIrutF3USOMyojuEhZ/Sbqfa2XDWMNKteYd8D5SynAN7fvo8JcjU+JsP1lRpEo/d
	oWCDIwqxiBj3jmHjgu9nkt8U8od27hgT+fqIuntayZc9VOSkrzcV/VWAS2hiJKd0oo9MJpPKy7l
	AUNqd7Vgt+wGj4vcdX/W25CDD8ibaD4OehxiJqkjfwSeBfxqenSrtfPZj3JoxxtkiSl4r2frLhr
	TMfcKd6Ry7Lejy89DU3bS3mUyFRqIE1wiDJqguoxhwSIeSPWIEe/pjgcr0mpZnfDPyS8uMyT8XE
	em8QpSas8IjFwOMjamAMpb82WaNY332XR/4Jo69FLsNKkgYb0YcpR3xJavAM/3cWJX91oXQ61fd
	vgQ7blAxMSPlXHJQyd3rMKhN0Z4fbVGCbuvQi3MVLocSYG+XEG3aahjTxWeIUFsCfFpJTs4YUAS
	YOa4prURVD7QZN6eWOdhb8p0VQ4AgKWNkGR6VoE8e64p6t/5cPIVfYr2M00orgPy9mKSEDUT77D
	MecX5GFuj1Nhhx2kId/mvtj9rX6r+4hZrXs=
X-Received: by 2002:a05:620a:1332:b0:949:6193:acd0 with SMTP id af79cd13be357-949bab4d91bmr4566002785a.81.1795804001385;
        Fri, 27 Nov 2026 10:26:41 -0800 (PST)
Received: from localhost ([2600:4808:5693:8201:394e:8b9f:994c:b59f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ad6dsm1889062885a.12.2026.11.27.10.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:26:40 -0800 (PST)
From: Marco Chen <marcochen.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	pmeerw@pmeerw.net,
	matt@ranostay.sg,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 0/2] iio: health: max30102: fifo_ready() rename and I2C error propagation
Date: Fri, 27 Nov 2026 13:26:34 -0500
Message-ID: <20261127182636.83803-1-marcochen.dev@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 follows up on Jonathan's comment on the NULL-dereference fix
and patch 2 returns the actual I2C error from max30102_read_measurement().

All patches were tested on a Raspberry Pi 4 running the IIO subsystem tree
testing branch with the max30102. The module was reloaded and buffered data
was correctly read, with no errors.

Marco Chen (2):
  iio: health: max30102: rename fifo_count() to fifo_ready()
  iio: health: max30102: propagate I2C read errors

 drivers/iio/health/max30102.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)


base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d
-- 
2.56.1

