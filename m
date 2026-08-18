Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE97369981
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089888; cv=none; b=A4w22GH5HCUHjNRFWAhGHc0XcAHE0aCJO74rzu9JPaWWX43sTOp89v3RFE9d8yhhokTh6Wfz5Vl9/yM0t1Vodh3dxB+DqXJXjSZWz1pXXtBatTJWyS6Q0ubCvWcSyb7pnkAYVVqvizXlGlEUQKlsQ8WHEf7vOx+hSP4m+AqIg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089888; c=relaxed/simple;
	bh=iGoBjEHj74GVUVZWigCM9+Hydn/PBR+xV+IR2J87KPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7nnFRLLDQaeroYJ7GzP66Wa6L/g4Xwa1O0wfhRE7q+0btuA6I6uKvFOPE6eNlzscqj5LcQYSUUSni7nf4P9ENFzAfuda1VvRRsWtYtInqEtd5azcbF25Wu3uIYl55oAMYFhl/yje7wS+10ICkYnkLTG50s4O/ilDzyDqNLw45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6Vdybl+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6Vdybl+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472326ca506so194448f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787089885; x=1787694685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8+7URYbJLVLT0IXdG6W6LnRaUXHpCie6Ue61jRO2jfg=;
        b=B6Vdybl+PL427Kec4i+CDjZ8RtGuhpXJaA9uskUkP6tFqlWgWaesbMDVyPprmrEDCD
         ZdLNI57AXSGMx7o+PCMTlWygkB5jSoZ/6BK2tW1lFRWDs0Puvx6Mo+7HGdwjVm2vtyOq
         qJq/6rKNrkf0bioMK4n/ibhTWX3b6yLoxkN0Y4Gfl1xBDjyXCJIyy0XJSHWnEHpVKESX
         FWOHRLCSZJqAFq3kX+qf2QT/I/9COggPma4aEd6dhG+T7tANRMwD+0DUue6NA2USWZ/d
         xfA0x/l+pB4VTLKoun4p9C+I9VCEzeeclIST5pTLqdzX/JKaKabtcGm0o2Y1y4EeUhFR
         62KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089885; x=1787694685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+7URYbJLVLT0IXdG6W6LnRaUXHpCie6Ue61jRO2jfg=;
        b=aTfsrs3m87XjfMpQDvdlaVL/1YRkYXMt0j9bs2x/50daXNF9XXKEZLywDJ5TTqjVBE
         MMrtY1jUZbfyAapGkHTkfqdtuZqUiFIpWJxIUnHv7BZV8Moxcak57zdI/TdEIKTnToFT
         U6BJsSpx0A+jKvfRaRaGcusuFqp3BfgKTQyJyxY/ON/zJ2hhWzzE9lUUnZQhbaCaSvUY
         LrJkbQNQ5MJI6Zu7wSmXhhclmDpQbn4ejH8uWmxAkEu7mbP971dne65MhfHeQQuh9Hkv
         WyjxvCeLu8Z5cnmDmfCgr1qZ7eMyBatUgwVwvDw5vLKpl0//dSi5D3jpQvaNUqSAUM/F
         VXxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYcFSPDnzJurtW3seCtf3kW6lf+J2u2ODdajG2yKHDJBqGTzh0WEv7kSzkJAZb8ym+nzAWYCUsafo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoVkZcgt6n3McO4W5o9+eKvVwiwfdXQREoco65MrhoNYkPowm
	nwWzRyYZTsIb8Ooz5nbq6PfWD454srVzew15sUgUqOm9+zkuArBoaqeJ
X-Gm-Gg: AR+sD10nloSbzFUZC4k2lDx42zIxE3GxmYiqf/8NYmJa3QbKpaijlUGMkvVkcNZOVro
	UAs1NihcIAQ1hlf3tX3Oiw4jpW55lM2bCUAsGk6EcKt7WJg9m7Uk+Xnl0EdzSj+rt4Nh/W2hPHO
	PfT9Dxi1kncGZRfzoMoW82SUCeZUKmAE6lQBxnueGCCAeGg+xv1dsMqk32hGSDCYxGO3Xwl1vtr
	D3TKgu6Nit7xkXEEn/hengyiG6tjRNh7noSXuMHg3HnG3g0ENooffmcoMuhZXV7t6eQ7yL81ZSD
	A/tX4ih+wtBcljj9IWxvcbSRxMdFrU3ErYz56WCQqyLKzJz9cH8KQc/Ix3UNGjPHsE68VCKCXGm
	Auk/nYw36kW3y366/poRQf4ftmyK9XAXKt2q6o9beUaNs9ZGHcJ0g8TmASx2Jy8p/hX0MK56pcl
	z7M0wzjoMc/AP9+3SFOIJwxpYCLGK2IUBK/iOROQJOZv62dT99fImnHFWew6GoLFMyawRfaS1iZ
	jo9HIv5zU+lX2/xhsjkj2js7XI6SKMYI6GvQ4CV2+YN
X-Received: by 2002:a05:6000:2406:b0:47f:9404:5185 with SMTP id ffacd0b85a97d-482b080e529mr1508820f8f.24.1787089885486;
        Tue, 18 Aug 2026 14:51:25 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c33b3sm187546f8f.27.2026.08.18.14.51.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 14:51:24 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: accel: kionix-kx022a: unify staging buffer and convert to iio_push_to_buffers_with_ts()
Date: Tue, 18 Aug 2026 22:51:20 +0100
Message-ID: <20260818215122.52715-1-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 was a single patch converting the two push sites to
iio_push_to_buffers_with_ts(). Reviewing it, Jonathan pointed out that
the driver carries two separate staging areas holding the same thing
(buffer[8] and the scan struct), and asked to fold the cleanup into this
set.

So v2 is a two-patch series: patch 1 drops the redundant buffer and
routes the one-shot read and the triggered handler through scan, and
patch 2 does the deprecated-API conversion, now with a single buffer to
push at both sites.

Changes in v2:
- New patch 1: drop buffer[8], use scan for the one-shot read and the
  triggered handler, move IIO_DMA_MINALIGN onto scan (Jonathan)
- Patch 2 now pushes data->scan at both sites instead of data->buffer

v1: https://lore.kernel.org/linux-iio/20260818155635.8367-1-grondon@gmail.com/

Gabriel Rondon (2):
  iio: accel: kionix-kx022a: use scan struct for one-shot and trigger
    reads
  iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()

 drivers/iio/accel/kionix-kx022a.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.50.1 (Apple Git-155)

