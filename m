Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FD3E2755
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268409; cv=none; b=KgWGhTUmFoncZVSNixYHvGc4vCjTD0eFFftcMXhHgOhz5/i9b+LINchNm643xV94MJ68YJxXqagq22OFXyzEg1/kOhhhOvBUJWw5KXhJsHdbz0J91a8LJaz2s5hav1kR0rXaKfZ0uVcrXrrwSKhyw1ISXtH44hpuvlTBmfYDsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268409; c=relaxed/simple;
	bh=+AxFDR9s2f5U4K/Sa51Cyqr9XsO4976gs5ZNljqq3X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMaL3kWyHoEiuWB/NclOu4lSE5sKJrV8qcK8caqmPhsHY45sN9wrCCK5J2khSxfjArZGXrNbtcGHl68mE8u+8hOjwYhuqnb1/0Us20lzJybhR2ZxPUeH1vuT4EjcmwKbwn2+S319YAeZ8VdwDTEk17gAfrnF9bHPIIi8extO3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so330735a12.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 05:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268407; x=1781873207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mokoTEvD6tpZww6g3gJhOSnEQ3UgjOZ7Y3EYoksKiAs=;
        b=XNLcMBud3coy2ToQ4bLWX1RdBc24vskKhVzyo3VrERRLOPmdgVJxWULGA3licE5NKc
         ApAudu4Sb1Z6/DXUKCRo+Sr6YPKojI35viHGmJXANTUzZIoFTz8iMk3/Az43r6IPghsL
         QoITB+hMscVD7wK+zSqNcuhGLLN0zHfeEWMkVlbYIG8uMsrK7OMKUhkqGKJsyTarYppw
         h/uLZ0srDY45wKJ7i1wHEld2wHY/xxkQj5HwGOgciRabf1236FyAftF4OiZY2IF6ZECt
         YDXbdrthq+oN4SzwM6PZsXMQnzVhJeD/GM5zDvlgTZxfMPmFdcos8q+q60u+PTp1lmOU
         t6Vw==
X-Forwarded-Encrypted: i=1; AFNElJ/C7RLSaGwOPkYxy+0nspvovxJTCJgiha+DgsGXJIYNPWRWVBWtzbRxchOii2GVvjnzp1MWYCiQvT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKApC+n9tOL7aAFiPnCd/cpR5ojYbw/vTms84eAeW7B2GRCX6Q
	r/WmhsaBmQ35wNUmyFYiSbHG+XrJ9bzT5h4gYTHnM9L8HuW88VFe7+l6
X-Gm-Gg: Acq92OHr/MD0qrG2IfrynH51GUfshMT1tEOTorY3V2QRjPPfOBvlal3uWMFf7SB8vmh
	vhmKNzbEGU5zMcb2uymMboWKRqM3h9osA6pVDfpy0gKVr1aSxfyHNoiYAYIbEOuTO5JSgoiSdMx
	nZ1cFPPRcer3GZQh0wMrtTWwF3vgLKaqHvs/oxCBUSvfZXRvWf/moi3pn65jxEDTz8qZLhpNkq1
	GJA8e+RmqrQr3b3bG3nRpa/lAxExVVKRfnVfQrNXi7OvXIdA1vNx/3E85Ac1HGhFVmjGAQBhPfJ
	ZIrvwuQrXaIQ9GoNGTF3hkjqoS6di2GbaTUKcgqHe54GgBGOPE+bTmW7e1KfIGlqLP26XMZwUrk
	3uoYowxp7GBi6ihFVSwRcq9SjEyww+51D6/aQyQ7Lx6I74AdJbMAOFeQr19G/r+++e2Cr6ZLm/i
	re4ZCeJUESvAem32HvJb7cq39Zg2racHu1FPGW6A8tZXBESxJMvwmJCVShDJOThoVvro5nwpGR9
	aJJSDOIAehcOOxjpZeQMnfAZ0dyJQPcwgt12HR6WCHBqT9qsGfUFscjh7C3qi0oFqWJHpGa2KSt
	qODiMQ==
X-Received: by 2002:a17:903:8c4:b0:2c2:5446:30eb with SMTP id d9443c01a7336-2c411b7e5a4mr30936005ad.11.1781268406922;
        Fri, 12 Jun 2026 05:46:46 -0700 (PDT)
Received: from fedora ([42.0.4.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5411sm21115625ad.32.2026.06.12.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:46:46 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH 1/3] dt-bindings: add entry for qstcorp
Date: Fri, 12 Jun 2026 18:45:25 +0600
Message-ID: <20260612124557.13750-2-email@sirat.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612124557.13750-1-email@sirat.me>
References: <20260612124557.13750-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for QST Corporation Limited

Signed-off-by: Siratul Islam <email@sirat.me>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..11aac47f90ce 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1355,6 +1355,8 @@ patternProperties:
     description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qnap,.*":
     description: QNAP Systems, Inc.
+  "^qstcorp,.*":
+    description: QST Corporation Limited
   "^quanta,.*":
     description: Quanta Computer Inc.
   "^radxa,.*":
-- 
2.54.0

