Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60F3B28D
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773614730; cv=none; b=VyNQhR5PcZma3uaml+MMHXK05PKxnbDj5QJ+2we5foOslrUi+OF7vGodjFZEAwpQrZgRxPX8V+c3/4oPUrhFu2/rN01hKJNn7fFg5kxI0MGLT1AZKA7Sk0gmAgXh8m9lCUQF1WIMoEtIUwQTDoOQ1RgL5DFzXLlawHcpP9rbSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773614730; c=relaxed/simple;
	bh=SeP47jURJ5GcqZkbs1mdEQtG5+NfFXpOgY0pOWIWHy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTisrCSPE5JnJ184yKJui8s61Cvk0l2/aZbjMTStInrcXq9ykshSvHPNgS1ZTdmwYMzQnYwbKxfPtpOsq8YQ9Ye8sq1/WLUQ3ZYIDgbcCarvdkYMEEBQ4QcpATBLt5qu1ufFep56Czaoj98rXNr4bpNkWf+RD4q38SXaU2HudF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxUZFG5w; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxUZFG5w"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35a1230c60eso1982176a91.3
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 15:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773614728; x=1774219528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XgV+zvtNacxGNDWXOWURDnYoBBzeUFufHazWy/5RAXQ=;
        b=gxUZFG5wUFujtmAXdHtCRmTTX5VjdHRPJyuwlqqBqepQl6LDYXHFkOZFJrcms/Nf+D
         8G8YKNI9JyScByi5XJTdn4MNC68WxXBRPU+vgqiWReW2YEOW1b/ovEX+Y+L7aMyf22Ar
         h4Iib8OaspBU3NHy1yuWbN2JYe1hTywSDqkUV8usoaeOglH8UWZRfXzfX4nS/dHYZT9e
         EMCwBTSChe3uQOm6fDbT9ygeuFHOCCTUsuyDUBxTUlktzErt7ARrfv3jryS+MXHdCrOr
         vNpFABfV+DFzRF7P+k7O3jXoW1wNP9COTLu9PQoXZwOjsadWLWvf8OdKUZnnfulGG470
         R/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773614728; x=1774219528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgV+zvtNacxGNDWXOWURDnYoBBzeUFufHazWy/5RAXQ=;
        b=qiaw7GXOOnpRBIiTA0wC9/0oTAtZ0sKy81dCyztmInfliFBa/7/0tUFOk2PTyv1PhU
         CoFlCuHGNWxnBhVTqblHaigWxazI9oiXOYe/c5hNFLxIOPuubBAXhmBZ+p8r8KFscnJ7
         LTBmuotPj+YbssyFehEwrLHbhiCENAlt0vzbyRuhFfoO6kpMfqqcFzyQKYgcolQRb/TY
         qH5dDKAbqhnK7rKpnqqFxfbtKbACyluLwXxKOlMZn5exx3xsNVQ478gtqZeuBUJsFyzd
         PwyeBbbu/30giIWDU99RZZFbSDOdw8lg7OHdMoMXegtUQ22UIpxyBynowEyPVuPWJave
         JtAQ==
X-Gm-Message-State: AOJu0YwAwmkTze1uXNn/5L5/apLkJOm2yaI/2cgqXdcOFhSmHa5DbULS
	Me5kEldfyPty5TF/AylnydL2ddJ9j0QXGNhNVi0SjP/zB7Vs5EPqIH6kH5sQjA==
X-Gm-Gg: ATEYQzzntH99vEQayn24Gs24T+9KC/DCqwhpthlYbP2zLQhSSm+zHSYw6+KQggj9j3P
	c9FhPG95ALK35ij+5MrX6hIER0j0DCzDxzGRUKvsa6S17/dFe2eQFBiyPvcauD16UvRV7LuuCZC
	zgN310xxkQrF8HYfBf1yFIxHWFS9IlutUmK5E6un63vjOpGaFA1UPABRsm4dXJv3KEMDzzqCj4D
	eh83BvGXaTnwG3nadl889fv6efgHy4ezOo01D4x/R+vUeZS4PLzO5j82qP1zqgVla10Zm4QbDcZ
	e/gzIMLaaCZH9sQkB+tXwGv32AvSSf5cJGF99VvFGQnRHMkC0Slwxw90ttARva1o0KprPQ4nqLH
	lhAyA2RRZnL6kLjPDblKzNRXoIQgycDLUpJe/CkSxqHy7pBBhGcMrXZ0Rc2KwgT2QjhpbMW1QyO
	XkcU8MdTN5El5z+cNTfBm2kwBTjKbbjG9ux2R7+Ndbm90saGHFTkzIXSw=
X-Received: by 2002:a17:90b:2e45:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-35a21e1b7d9mr9533807a91.3.1773614728401;
        Sun, 15 Mar 2026 15:45:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b8e1cb560sm2175401a91.1.2026.03.15.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:45:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: iio-mux: use flexible array member
Date: Sun, 15 Mar 2026 15:45:09 -0700
Message-ID: <20260315224509.48111-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows using struct_size to simplify allocation slightly.

Removes a pointer from the struct.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/iio/multiplexer/iio-mux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index b742ca9a99d1..8db061413829 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -33,8 +33,8 @@ struct mux {
 	struct iio_channel *parent;
 	struct iio_chan_spec *chan;
 	struct iio_chan_spec_ext_info *ext_info;
-	struct mux_child *child;
 	u32 delay_us;
+	struct mux_child child[];
 };
 
 static int iio_mux_select(struct mux *mux, int idx)
@@ -380,8 +380,7 @@ static int mux_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	sizeof_priv = sizeof(*mux);
-	sizeof_priv += sizeof(*mux->child) * children;
+	sizeof_priv = struct_size(mux, child, children);
 	sizeof_priv += sizeof(*mux->chan) * children;
 	sizeof_priv += sizeof_ext_info;
 
@@ -390,7 +389,6 @@ static int mux_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mux = iio_priv(indio_dev);
-	mux->child = (struct mux_child *)(mux + 1);
 	mux->chan = (struct iio_chan_spec *)(mux->child + children);
 
 	platform_set_drvdata(pdev, indio_dev);
-- 
2.53.0

