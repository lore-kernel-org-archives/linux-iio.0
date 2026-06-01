Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10A360EE1
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340923; cv=none; b=uh9Kcp9p2af/tD9tXENzSMdgVCEQeDSA0PgbFVw0xqX03wl5BPMgja7QRcdee+Ho+P/7PYahyCTQGHHcl62c5LcwwVKXRuvBbF3UyPDE0YaE4AZZrvyhyYmmbi6Oj8orzXC5qNC2FG6CgRV5dKKEmL/SkKOD3Ewen+35tpTPPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340923; c=relaxed/simple;
	bh=M+dNFpPXrFRPmBsUEie0nmc+YUFxy/WQwbXHXetnt84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=glvNGJZkELCstIHNxrp6th4GwdojuVFAku+A1tMDQxlcHm6FLr7nGhyo4RcwAlbVjEr+IBbXyDvqaHZegFLzEcqCJl58B6aPk3TSakj/EHomfTHFGOFlexdpNS12eeUUkWtQpswWTw6FYbp8QwOa5/Z82DGUcT71xgHds7y5OPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJR48QyM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJR48QyM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf18c30bb2so28652075ad.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340922; x=1780945722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3dkkwysLFrkBSQxMcAInCtRdNyAQqtX7kURZC+lxbYk=;
        b=RJR48QyMU9cX6mE21ZyK6SycPSZ6fvpW6SmjhnbMqsWT0bBKmYUjLva/9iqZ8Fyq7+
         PxU9Q4KBLtA3sH7x+W0SJZmuDktCVsAXBUj7cGkcf/r5ZB+4RCptQoiI+xigsg7mLMZ8
         bhihNsS12WfveLoF+ty6UhHi+NwcKkeHS308GOFAzGcPg7Ntznv4hF1oqkksX/f83XsO
         x11qUJ6oXAFl13nIjjRcRBL1wb/zNcvyJVDG3KdcUUrPoVP+nJl79jknECdYVYLiwzpP
         eZtG5mgj24f9/fxxfTFiK8XqbfON77xZOQbj0FuEMl/wTQaNONIvXQvrfaKY078WJzFa
         +3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340922; x=1780945722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dkkwysLFrkBSQxMcAInCtRdNyAQqtX7kURZC+lxbYk=;
        b=nndGqlfNkyYcZmOvy6jq42OyQkF84EP34aoQGkm1N+Z6xjOshhlJGo7zNmBsB+oKzj
         V/1HUogtHtW3y9KmvwugdAw8RuDSi0l65e/4l0Fvx5WQirH2OmIb6GI/DmhKlUAj/kA3
         ljTR8wc5lVV2tpHzGLLxPLJmPrb0WpkM3tzXPx6JtPhh1yHdBgehq8/GSnxZeXDwoItJ
         0htb0alRUgAiSgqhtGf3txZxJ70MpAI0J8I0f3iLfhCRrStURC86Z+9Nj55tAEkyKO83
         kU/1Mh9dqA3KBAu8tO2whKtMMtIR+ZDp1IA2nLQ21lHEuqvDTWDws668CtXT+0BJqONN
         mo1A==
X-Forwarded-Encrypted: i=1; AFNElJ8g4LVlpI6/vNp7nU5vntfm7ih/hJurMihFawQley13Cxj4os5iztEGDswX9n1DM2pmW+2jIyUHQcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Kol/Nro8f6nxaq0965KJrCz4DOe2+gAXME+tpZPPQjGfSeOe
	QFjuXpnc0DB26mfyVOzp/M68Tl5rUjVESjCgoUeXK0p7zzUJcO6tvZ3h
X-Gm-Gg: Acq92OE7Q8gjvJBSr3JisXD5/M7nrLTBTDI5kkhWzPeM7Lxqnz78s/SNNdoiW7sXWgF
	qCvTtZ/S8yvANzh1O+YCQQqs2gF+a4lTnfAdldoEYT24PUozRa4OWevP9aPgcxbAb5Y9htsZ4e8
	ZcqT1aYESnJ/z1nhpUvIMW47+Wif/4qlGqqgES9dDw63Pgi6KBHX6jrviTPYa99/eGNCV+54Kwu
	DnP8HX160tYYKc/+8eAuEm2ul64klS2/rxJnDCGZgNOsOhwuDu1dzEhKmKZNlfw7AsT8UxWTOL7
	RkFfimmrTN3m7KEaTMHN+OKsvcH1T7e6iewhPIqun8w3WYbZLC5r+oG0xBuWqm8veY8PM6hD3Ey
	K20q0XcG6zudGtZfYUPiyjugwl8lP5uAMoMsfWB0RS8zx/Zxr4TO7zC1GIajXv3M9DydxqsyPF6
	ncJCvHBy3jOaUjNXOeLySn6Vi7soTJ+OPpyUiVgNCaomNyI/2eieipbTiH+e0=
X-Received: by 2002:a17:903:986:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2bf367950ffmr128794405ad.8.1780340921865;
        Mon, 01 Jun 2026 12:08:41 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a0fea7sm108187045ad.29.2026.06.01.12.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:08:41 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: todo: fix typo and refine resource management items
Date: Tue,  2 Jun 2026 00:38:36 +0530
Message-Id: <20260601190836.2766703-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Fix a typo in the staging documentation path and adjust formatting of
existing entries for readability.

Add TODO items to track conversion of selected drivers to device managed
resource APIs and evaluate usage of cleanup.h helpers for simplifying
resource management.

These updates aim to better reflect ongoing cleanup efforts within the
IIO subsystem.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/TODO | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/TODO b/drivers/iio/TODO
index 2ace27d1ac62..17093cc6c61b 100644
--- a/drivers/iio/TODO
+++ b/drivers/iio/TODO
@@ -5,12 +5,16 @@ Documentation
 tree
   - Yaml conversions for abandoned drivers
   - ABI Documentation
-  - Audit driviers/iio/staging/Documentation
+  - Audit drivers/staging/iio/Documentation
 
-- Converting drivers from device tree centric to more generic
-property handlers.
+- Converting drivers from device tree centric to more generic property handlers.
 
 - Refactor old platform_data constructs from drivers and convert it
 to state struct and using property handlers and readers.
 
+- Convert selected IIO drivers to use fully device managed resource APIs.
+
+- Evaluate and adopt cleanup.h helpers (guard, __free) in drivers where
+  manual resource management is still used.
+
 Mailing list: linux-iio@vger.kernel.org
-- 
--

