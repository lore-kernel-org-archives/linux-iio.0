Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B84438FF7
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605631; cv=none; b=pV06LvJfuod/luDmAYWaiqe8C+C6X7SmNfZRv62RYldYhpai9MgqP4CJlCxuo+MXan0RLytydtsyvgnQfM9voXGlzMsmom/7gUBt6AWPAim6w3r5Q3OTMA6M5l9Bh5lJI+c9na4sK28lkQ4bPF34Z5x/wj5dXCGEqVdOCKIB4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605631; c=relaxed/simple;
	bh=aW+PXsX+6KeImEBx+dybVaOovDoHX5ZdBphCv42nK9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TupUUd44QenEvICSCQgGecK1u3Ge50RlKg0kVeitzdjey2C/HdSCmTFUS8sg0OAnQsazkDMCO9s3HEiuLuKg6Y37EA6Lq+pdc/kHGA11ZrRVE6+qwRleOF7oI+9L6UDllum925BfbbsMSCSlFzHhWfJPOhKu2Sh4ALfafvQTpaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRv5/lae; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRv5/lae"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso2319908a91.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605628; x=1782210428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ihskKwTjoW0FSUSEV6CPpcECpjKDSFbZW8iDqF8sUE=;
        b=QRv5/lae8AfALIcQFzPOP4NoGGUcyyAuMNUJvC/Pb2CRsj9e0cd8b8oa3v4zKsFiS4
         T+zXMsZWgYlv6WkkGnI+sZULKhCJK0aWwKtl2OKYktysIgz1MWeXBLWITnPcFK/pfMns
         TdnU86B4vAEBEhfkeOwn2DP+YeeTzcCUHqY/aIO7B1Ih+G1X4zPSmoRp2+whNJGDitv7
         /qcFUAfSoaDIENAtegIFk9nfUwt6yF/TVS6AejQDIBid/nu56YTxmkTXevQVpmCqd+qC
         617etWI4Mju5/wz9AisBmZQmnRdhvyk+xWw52rrF1VPQcSJw7F+cbuP49iUAS4Vr8iC0
         bZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605628; x=1782210428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ihskKwTjoW0FSUSEV6CPpcECpjKDSFbZW8iDqF8sUE=;
        b=tQDvJEukHltTTXf1P6oW3hUlRlw18/OaHfOiVunGhf0KJGxVi4uL/EYXjzw8juZoEc
         HWvP3q9slfbcFsOKfiXv92tpfi54orJpD15ewFouqNi0dPAo9At1LW5PEVZrwSydajLh
         v7gixM9OED7T5O0UX5RkxIYu0cdjT/LQdwjwhixy1mnEFGgNGvt9pRdWlmVa2qejm+wY
         YrWXLL4HLj/mkwL6ZjufWTMmPbBgzkYPW31IqNVMiSJbZwEqoQKmyI0Eh4yfDWbFwWRX
         yMaKVuRqwQRbisD35xQbV4HVrulECfKwFEbS1C7fMFT7PbqJJmt+il3va1MzJE5l5Hk0
         BUug==
X-Gm-Message-State: AOJu0Yx2jVaSFddl2huHkR3hAxOilgdV39Bx9jItRc2l9QLVsw+JoF26
	A8MnVQswvoaPKZg4N6GD6uPFC/dEggJjllx8z9QYfSLvuiihgL+/t04B
X-Gm-Gg: Acq92OErkl9h9QzWOA2vaqLn8OQeF4E60wmxmON2RqQBXCM7UMa4IJ6/81T4xYvmtqu
	eTtslOwCvij8S2HoeUJ5qoHzkVY4ZBkK3aesHR3zmcThGErYKx3ZIuEUDSnm7W2HszHvGv6hpum
	uUFA4BczopVjN1+Ui8P0H7sNj2jgL26kpKxDPJ69xeHydc/V8liI9VOnrQnGM7vcVRd5ZQ/MpQK
	t6uT/wBr/eTFG1rsP+GUL/kQrDcl6njPvHEzJ1fqBHFdB46vaf44ccTl8IMCWy36j21EdJjX/VC
	S+2EI9JPWevxJQk7d44gOitFV3kuOY13a/utmsLA3BfsSAgMEpMkrxtHkV3ZC55wGPDGYPhW2f1
	WsMFEkK6sbJEdKCJErsmO8WAm9q6F31c3HQtHVhJ0nBbIIINpBMCG5I0IiYtbdhLptfXwWZtdSl
	1tC7nOTNFmALC+m9gAPqZGztl/mwgsL9ejm2Hbvtp3EDoDbeUf
X-Received: by 2002:a17:90b:2d05:b0:368:147f:bd2b with SMTP id 98e67ed59e1d1-37c5293df35mr3124659a91.23.1781605628298;
        Tue, 16 Jun 2026 03:27:08 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:27:07 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:14 +0530
Subject: [PATCH 09/11] iio: hid-sensor-rotation: use ! instead of explicit
 NULL check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-9-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
the preferred kernel style.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 20563d8efaf6..fc925ec12d37 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -278,7 +278,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct dev_rot_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1

