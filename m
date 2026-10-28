Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225095;
	b=OxOb+Mnz74T3tzUdVTCwWrWbpu+yuG8rwW5Je5dIqyanMM6jWP0SsTebGUmpLAi6ReM7
	 jOWvoAvJhwo2IF7j3ApG6GoAHGbOOlLZM3rg8pETuR0+y9suT9aBPSLGLHaCAF8pIVeJU
	 klvZ8jsaGnnCKa4mypcPDpUCR5NdXNhp/GiLfN+JyO/qnelOZCMJlSbPsfnS/syg1/GyA
	 6RlwjK6sR+NgqVoPEraCDucjO3jzKFshB7gbDpw2jc0gRMFznIPJPyocJ3ColQ5tDIX0s
	 df4pVJ77xkxwZ0/ByJ2+vfDbfveGPFLZ/3VyZCpX6Kon8TWEGWWEytudPjzue2y6itA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AC/NTXhZ+S+m8y68c6/Vu48pKA1QTXyP89dRVEtMCT8=;
	b=EhYxLCXX9eLp2mh3nE/k3VeU3EcmwzQYKt7d5+D2inCC7MR3LB51r8h3FFFeJFyDNfBg
	 SDDVyREOgUtDjNwTfgerUkFyGZqlnB2pQaRjkWgdQNPnluSmDIoC+8v5SZQ06C+p85/M9
	 ExDksS6q9I7/AoBBtmaoA+1+fuicdbQkr5RdGm4CqFoeeZ6U6BBomwYqh5Ne9ftOw/0Pb
	 J9kwqP+A3Ua/mYP0ZjXg7Ary3RY0xgPnuCbZKZk6nBOIiVjkmeP8Zf+ivGKBvsmqPhtR3
	 2Kr3GpOvaJQWnCqCusc3TqtWR44LdBvMRSxu5KbprMYduj3I0WXodrcsf/6aEHo9bBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NGGtDifR;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6029606A31D
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 22:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6029606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NGGtDifR
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35829219da8so184896eec.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793225094; x=1793829894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AC/NTXhZ+S+m8y68c6/Vu48pKA1QTXyP89dRVEtMCT8=;
        b=NGGtDifR9sNw44R0ROA7kqnA0Xt6LYOirzfzWAbw0/0M1HfwDspOlf6AuvgISgDOga
         0BPxRerL+TEwUoKbexw0Dc2FRuW+SGkU6yjRVDe+t1IBKeFnlCt3yQU8LZt0kov6uYQK
         6RtM0IuT/NbfITfXwMqnt9gBtY89InE8N76/ReSEOSj7ioxoSbHFY1XFDKxcUTM/QODS
         iLp6us3AyLU3R+NQQ9CSh9CuK52rSU+BMpw4lQVQYh7wLSM6qfH7DkyNJGDu/JxF4kUc
         /uLVF0avUt5YImDOixdx5dVPWN0KNS1Se7Mz+ly37DbI7hKkQ14Vn2661NjSgzfS039q
         s9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225094; x=1793829894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AC/NTXhZ+S+m8y68c6/Vu48pKA1QTXyP89dRVEtMCT8=;
        b=Nxb7kgm/hob3TPnbF0RmIj3h2hT3wjxOZgt+WuyLBVjHC2wpNn6xod656RCcml6dYc
         sFuCTizJNpK6/qB0HbjJfzCnl3yeMy/WcKVaWYApb98YKKU9pvAuTuLSff2ks4jXsepd
         w/6dSP9mZMSlIgtN9tjoIVqNpsqB9TVaby2ap8g7QGX7rNAnj2qPkKL7h1k+MwDCzx4B
         EIWi3GHja0NpSyoR0mBuoUKMrIjXQLP8U4mZ2FK4Pnp+7H7mq/7paa8qP8KTEryPfEdN
         aAUTheucfyfVZxIfIwyybamTO3r7YzemcR9Ssw5zp9Tm3D2mrOwNzMscVrVGH+HqhPNL
         qwdw==
X-Forwarded-Encrypted: i=1; AKwUvByuVouWfNgvBC9V+icDTPaQjeSxcdlCoyXNkDqFkFLlSzj55KiNXIUrKWxZG2p2qGNBH3eSEEUfKz0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlCkG8FFblVg/3jMHxhrS2Z7n1clO/RzHRk+godQDt7+GXq0dZ
	zeJDH9UtVWJlcXzsIm953Y8VzdBwIWZgkpZinNbUxqTMCrbLprVWLlSy
X-Gm-Gg: AYBFou2dB1IA1eReSikjKAmRZMGM7HVSv2+UD7T3KQNL9juE/krtm9vdj8Zduqr3HMO
	B+VX7pjt4/tnu4nti/pO2AT43e9ZVV0XZYQaQLcxuKTOMz6ZMQ8r8YOdfpoFBeicW0oAdvLoasX
	XiV7SONNaRYLjUqs0zAtvImfgEeAx10Km/ag9RO6skuyGdbluf6vrJjH1YSsjnu5fdNkDX2kP4B
	ZjtZy6tHLPmheWWvpzFKbTvEKtR5m6y+AwjuGUwucCkMLy0MrjdQyRur/hOnwmffEufrxJIjpiT
	4cOshcH6BztO3rC7a8D3if9jtLDWSPpMw3eoydD3MqczeiiRPtEEFcRhG1hI71TKpp6bRrNlgv6
	/IOA1UsLzg3qQ6VN2UIYb+xEKCk4/CLefEGRFd6WPJ7aKT7WnT2S/4TSXUaCnDn2qT2tb9x1SvG
	5WrFfidPbRdcneQwZvifaiFxqGZc3ducnv4c4Ih6VCqw/119mEuXUsW9FdEjJiHaILvPaUAMPBJ
	ajjb2swpttr6wGUtCwiREEbRwlbmS8eJPdUlhCcAX2eraDxCv7U+BFXw+/+XTCZye1x5in3GLAI
	Qv99URDyZ2m3f1Sny8XNU8Bkr/N9tzd2BoqfMMiVQCi6wHCnms0Cnr/EqoreYw9D92xIJrYQZ4l
	WzsmRc0jUI8wNC+qwsd1jlVYVUSGzgkc9zfRSUPxV9z7cWANG5ylesxX+n7ljeVr6oQXkn1D824
	jz+Q8t6uxwOTv11YeSZmycOnGhFaeiWx91AjUIF8rlKQ==
X-Received: by 2002:a05:7300:d20f:b0:353:5d7a:cabe with SMTP id 5a478bee46e88-36a3002ea6amr1020590eec.13.1793225093667;
        Wed, 28 Oct 2026 15:04:53 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390a812sm9924429eec.14.2026.10.28.15.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:04:53 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v3 0/3] iio: proximity: sx93xx: keep the IRQ balanced across suspend and resume
Date: Thu, 29 Oct 2026 03:34:36 +0530
Message-ID: <20261028220444.70121-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sx9310, sx9324 and sx9360 disable the interrupt in suspend before
anything that can fail, and don't enable it again when suspend or resume
fails. Without an interrupt line they also act on IRQ 0. One patch per
driver, as the Fixes tags differ.

Changes in v3:
- sx9310: blank line after guard(), and a local regmap pointer in
  sx9310_wake_up() (Andy)
- Add Joshua's Reviewed-by to all three patches

v2: https://lore.kernel.org/all/20261026112342.65917-1-kapoorarnav43@gmail.com/

Changes in v2:
- Send as a series with a cover letter (Joshua)
- sx9310: move the wake-up register writes into a helper that uses
  guard(), so resume can use the usual early returns (Andy)
- sx9324, sx9360: no changes

v1:
https://lore.kernel.org/all/20261026100322.16720-1-kapoorarnav43@gmail.com/
https://lore.kernel.org/all/20261026100408.16874-1-kapoorarnav43@gmail.com/
https://lore.kernel.org/all/20261026100450.17023-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have the hardware and haven't
reproduced a failing suspend.

Arnav Kapoor (3):
  iio: proximity: sx9310: keep the IRQ balanced across suspend and
    resume
  iio: proximity: sx9324: keep the IRQ balanced across suspend and
    resume
  iio: proximity: sx9360: keep the IRQ balanced across suspend and
    resume

 drivers/iio/proximity/sx9310.c | 42 ++++++++++++++++++++++------------
 drivers/iio/proximity/sx9324.c | 31 +++++++++++++++----------
 drivers/iio/proximity/sx9360.c | 33 +++++++++++++++-----------
 3 files changed, 67 insertions(+), 39 deletions(-)


base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

