Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1263B19A1
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513110; cv=none; b=bLaG8it1ebmfaqnkoHcPxV5xiw6vBLPr1ezpiM/cft0550XYgGc8KMipwyAwFqheWwtmi6pBODtJ8qt3exni5eoioX+saqkecoNXC8ihNLhc+QmDWm8+rcUJkFcOezW726/lDS6wxR+P1K7Uc3XjK24NBuQ/bmBJ4goBFUffC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513110; c=relaxed/simple;
	bh=IrfAI15OeYSzF7o8VJ7lq6QuUQJ761yxN1y3FeGgJ6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qic4kP61Rbqi86Y4lxYsqbbBJ5BPayPN8r1YZB3d6eC18g3+0Qas8UkZ86FIktyT6nK48SVpKUv3u3fHV5/e1ReUDMLSzlvAgjTwGFywind5ypWjaWs6gN3xRY6OF+b3mu/woEx92czf65B5jVaO5bkhay8an/WC+LyO55ZSaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0u9RzNE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0u9RzNE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b0c30b517aso1241005ad.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774513108; x=1775117908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWDKafWykqmCst/+PGgYmIJsGhpBN8tnTlfr4qxhHLk=;
        b=M0u9RzNEBdTSSesIz4846gmCH9MkDTkEpkmDtYya2x/Y8oqH6kFAuLkle0Evp6/TRM
         SIMZPaJ5qppWDRB0+6v2bqUpa9TctPU4a/VIyTHbEIvv5i+vQXciBiDR/szCw9aPytR2
         2pHpqja572Q+PAFRVM//nPreIS+dXuVm3USvqPuwDlZMPYAPmgrh1xrJJQoTnyGiRwRW
         1w0PZDMRE7fc3/fSwEEiW7eLuM5lTVjEThZa2X4PP3+fXLLwVqC+oNDM8h20K60+981O
         xKXNRysXYuKEQ3YZEqmwmpt2bc0VluoH74Ae7lEt+wP0zZmnwra1a9Pc7setKSd0nhh9
         ERWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513108; x=1775117908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWDKafWykqmCst/+PGgYmIJsGhpBN8tnTlfr4qxhHLk=;
        b=i+SP89eyX+bVOSdB+EfEIjdu2sZYzQgBJpEMULLLhxNwVeipxPOGUfmXyK6yOE1+Ri
         TlMM2DIDAPFZPgQBMduZC3PBx6FHwjCRGQQHGbJE+juAu13DLOMll+DTR1p4YHnu12d0
         j+5ddxpT/zDfwe0uqVYKrZM64JHkUMMGhuCkcazGauOqDGFl/T08P0inL4J+rECWcoNP
         RhTIsqJG0ZvCzqqp9ayq6tU+Hxw0nE6T4az1SNdtlq+BMMxhsjj7rlI1dPGyMc+D641H
         laP1CVV9d+Q+wq6cvuxs1GeJj5USRUcFSLJOLAnK0jcY8Vs3OC1VPbdgM8x3kk7QCAWA
         gSNA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Z2nzfQlFLSXSBvaj4qADY5BxhNzX8SzTihL4n+CLyxMdQhuehhK1rwDrTzQPqPzaXkvJpWc6vDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0Sq/WjF+bcXckfAObFhcT45MkVV3VKsBNKIgoq5JgILeVhO1
	+3wrG4Sp2QDE87nYolVY4gH0QO4hQXYEWr0RiVtub1lLWgmFzwktQ04uZBfiSg==
X-Gm-Gg: ATEYQzxAKQlkDUOJZbjeirwAwmY+5ZJJvdgWvxYAb/tegGdIji5BH/VBG1uQ6KW73Tk
	mIXOnIJ3UlpITlgA+Be7+7ckLTKZdkAi5feGItbr34ewNhy6pRoAGBStkPSgIuZG78WASHOFfCR
	aRssXHp2V7f+YMqtiUgDt15xqPmcMj8oyHXlKPtfRMQfhmKGHw5avPG/RjVim2zqzp9r3o+sfM6
	VKyYYXtLIvx+IzjPVPnwcLr4khlgnwFcFKrLPb6Bz5+f/3gcrDXAFKG0QQHFchR7z8ZjsV66N0T
	rWlopHtc4lFCPu0lpDppm0i+hLJusHHDzIv+jhF975EuNHWqZJ8JiGEpoFm2f8fR8vQCon1a2if
	u/yk93RRMWW/0FlaUHF6n83n5h80P+FxfvGgYYKu1nTyTXP5ExDdLFBGc2hb+wg6EqSIQnFG/50
	CjR+fqRMChf/grv3Fwv+97bwDP9WfLMYIgNDSkI9abLWGzXp1I
X-Received: by 2002:a17:902:ebc2:b0:2aa:d5e5:b136 with SMTP id d9443c01a7336-2b0b0af3befmr81291515ad.38.1774513107988;
        Thu, 26 Mar 2026 01:18:27 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e6cfsm21855535ad.39.2026.03.26.01.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:18:27 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v4 2/4] iio: ssp_sensors: cleanup codestyle check
Date: Thu, 26 Mar 2026 13:48:13 +0530
Message-Id: <20260326081815.925373-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326081815.925373-1-sanjayembedded@gmail.com>
References: <20260326081815.925373-1-sanjayembedded@gmail.com>
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

