Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D323368A9
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229686; cv=none; b=UA/qBKVCKFEP9y5B8DCMNEc2YWS5tLt/18LDE+JDwjAmZSXFrvNo9Nd28CIh6ZNPm7C6lyY7rMTd78FcgIWDLdGienx/K11CKcCtXt/r2AJusf9FVPwykiHscd5+EbdcjXVVDHjn//iyAA1hhszrRY4m5jbztk9kAIE4ZyU/NIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229686; c=relaxed/simple;
	bh=IrfAI15OeYSzF7o8VJ7lq6QuUQJ761yxN1y3FeGgJ6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0qftRTVJuOOiU2EEcotrHoD/bJsYESZ0AblRXS1+ledWuRqn0HOTvc0zxoatHOjxjtf8Df+AnEojftthA4bsUWeWzw0Wq6BFvNCjEJBkgyw6BgaVbdynKtfytSHtfYtCbppYOJV+3Y0n1AT01fUknnyH4CEyQTCAV2COuCC5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/oshrV9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/oshrV9"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso3132625b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229684; x=1776834484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWDKafWykqmCst/+PGgYmIJsGhpBN8tnTlfr4qxhHLk=;
        b=g/oshrV9f6FIlTWrRwABn3EYZ6/sDkDYwboqNEfdFhGkDWGoobCnE0mcqBo4xfzZ4t
         ScwnDkS8+GPcCA61NTPxcVjy/rdJcdShDDH6dZhoRtsyLA0jnQsJDC9+8JuVu+WDhE+D
         Plsws/HaJ3GUriQnuqPqoaKo9+YAJdMKHx1OeEjk902JjWyplcBmzBUOV70ZvTGBWM79
         pF8peWzEONN7xO/t/eC/yCICI4F21Hapvtp0dJWZesS891NcuwctnIinb3uE2WtDKhjc
         boGaZahVVqZ+VTpHchN6h1NxYuIMYDWm/1U3AdC6DAC5bXMZcIL0zfVdLuqp85YS1mqx
         DKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229684; x=1776834484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWDKafWykqmCst/+PGgYmIJsGhpBN8tnTlfr4qxhHLk=;
        b=DbXoF4Sy1++LON0aKZXwySsNmEl3sxDSlYZ7ng4DVElZg2SQmgTE4OG6dcIe7VQbGS
         2yyy6fv8Z6dZwX6C2R844e2ccgm3WGebZ5s/hWpl9FOd/PNvpt+sKnoBVD3Ghw4drqvg
         NWRtuZp0lBkdTfXc3P27pRe/5WYzBUpKB8+//K1esOPUAepWw5dxcf+B3zZz8mcme/55
         yMw0MZgbMAMORpVRF1R+k5Q1O0IAqv6X15nt8iLrG/VTIO0oKeKWsLq12E2qg/lnmB43
         Ldo4GChBVSZmrN5/aMjn9FQYYW/rflE6bC9uVMqHubwAHwbZXFT6MS4EuMjB6uw6s1J0
         RbyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KytePcsu4GxTwbmst4weWgaaaWuCj5WaMpQcXPLuJphV6iClyb3xMfwoTipEru6GV+gRvC7JLlcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRQdWNoxwoA9moh0oStV1Ec7iwyrxbM3lq3N8Subk8dTczDOy
	WSXB/+5sObqcZdIKJn2sEbczCT+wdPG/Mh2Y3jOTlcnc11leiRJCtCN7
X-Gm-Gg: AeBDievZreDX1H5z5DnUYrhQUA5xs25EvIHwz5u65TZMSj5VdrV+7RztjfKn1rwEhUI
	gKSxAtcox+Jd55qAnRUnylzQorghCTpa6n2U9er453ziyL0uxLnfYTsBl00a/k8R2Yi4LXHkJ2d
	bAfj4jSlUcOwDW4I6YAgvpTuLfgyIhdfywRBGjBlAZT522EBOxxbsBY68WuOx3BFFN1b05Kcd1V
	ZRGNe1GpWjxiUhLFCwVEYH3PAiEpgB4ihRVXhLYJqG2jnnckcMSPeV11kXuHC6+KXClRwq3TTpJ
	x+QutOtRYQ6twk3v3HXT/Bx4fnQ8rgedAh1oWvXnKpvSdArUWwJzb08yZs1mZMoYBCLgYEk6NLS
	m/oDlnv+pq9Qr80WO7lwMheLgfTAYTjpFKsa5fuD9FAnknBPb7ZLiCKSpOxhJfYt73eFDGOlLJV
	dNETbzsZ6fuRGJ4NfOeFeFPmGWecXSTP3G9X7RJ1wJsgipyrXOiCJxDgbWw+eNa6zsSZRfxw==
X-Received: by 2002:a05:6a00:bd08:b0:82c:1cd0:2f7e with SMTP id d2e1a72fcca58-82f0d23f825mr16349417b3a.20.1776229684189;
        Tue, 14 Apr 2026 22:08:04 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67469dc3sm763706b3a.58.2026.04.14.22.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:08:03 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/7] iio: ssp_sensors: cleanup codestyle check
Date: Wed, 15 Apr 2026 10:37:44 +0530
Message-Id: <20260415050749.3858046-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415050749.3858046-1-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/common/ssp_sensors/ssp_spi.c

CHECK: Macro argument '...' may be better as '(...)'
to avoid precedence issues

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 8c1e15d61db7..08ed92859be0 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -6,7 +6,7 @@
 #include "ssp.h"
 
 #define SSP_DEV (&data->spi->dev)
-#define SSP_GET_MESSAGE_TYPE(data) (data & (3 << SSP_RW))
+#define SSP_GET_MESSAGE_TYPE(data) ((data) & (3 << SSP_RW))
 
 /*
  * SSP -> AP Instruction
@@ -119,9 +119,9 @@ static inline void ssp_get_buffer(struct ssp_msg *m, unsigned int offset,
 }
 
 #define SSP_GET_BUFFER_AT_INDEX(m, index) \
-	(m->buffer[SSP_HEADER_SIZE_ALIGNED + index])
+	((m)->buffer[SSP_HEADER_SIZE_ALIGNED + (index)])
 #define SSP_SET_BUFFER_AT_INDEX(m, index, val) \
-	(m->buffer[SSP_HEADER_SIZE_ALIGNED + index] = val)
+	((m)->buffer[SSP_HEADER_SIZE_ALIGNED + (index)] = val)
 
 static void ssp_clean_msg(struct ssp_msg *m)
 {
-- 
2.34.1

