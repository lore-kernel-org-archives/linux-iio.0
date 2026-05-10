Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504D31F9BB
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439319; cv=none; b=EddR/vZFUMsO39y6HroJfV/LRVsh0/sCRhNR/7VJUafxVUCYTaPC8id+Ai8hNwkamlHcF/xXaB7SJ6kYqHCwo2SUsDFULBN2G2Wni9zXHBQQCdgGQplX0RTcXOCBe2TzKnBaAv8qgryrosEdWj16sggyTz/bGDZXgcJcSU3Gw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439319; c=relaxed/simple;
	bh=vXksDUqOfT2TNT5oJavkiFCnZLc1jOw+gPIiOA2H0D4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UGh7USifWPVRWJoPB503tS1FTcxk8zsZWNCS0IXInsAAYfryU04eH42MVEWLl65KW1KlBrJq8piW2N56A9DplBi1CHH8hCAeyzq8NmSesjKntikL5AhGZo7l1djIhNgNp8SV6wDMXiSuwLkMR+LSOIifWLEr6tyMI1/L6xQdhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cROb/suI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cROb/suI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48910865133so2714545e9.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778439317; x=1779044117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDP3SGFZgAvo2WOHfeUfGa7/tAWwDWkMPD7hGumcLIE=;
        b=cROb/suIDkiYG25k1ZsXLVBD5b2vDS3BHQ6wOKTC4vWQNHDUIlRLki8VplM1vCsz1H
         Ax+dg9TYYSm5kSwA0WYPQimvhmUep/pe6xU7aSYFCfRwztIuE7AzSDP7O77fUl5SkaWx
         XjQ9iObAqi2xUvh8LNRai4z49y7mL2MM8cCLiaiDZDktdAsI1qNLpHLZr5pPNNrMv7zx
         zUqbw3w67+zA8SVKOIqzkjArgVPjZ6uiKqfgAdHH6hSLiUrvkGPVtKbzJgn1uUciagAJ
         y2FvpU5whw4y2m8WVGjQHFlQInSF33y2rKQ+4+sBdmYzWpKNtBI4LuLQUGWQyzvpOs3V
         RPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778439317; x=1779044117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDP3SGFZgAvo2WOHfeUfGa7/tAWwDWkMPD7hGumcLIE=;
        b=LFYfFnVhh8iE05hg67VZlqqly+P1FAO0X+5AnJhsA/NwE1yNFBkgIT5UCkYQg+aeDm
         KmMYzPMDtTM7DL7Q1fxrCcqzZ6sTr00zkVPiXtTb7qVbI6DLQ2fyyIb4S26vJN9Q/JA2
         7cl1ONbqe6+BqKwPjBb5eQ9SVK+Ej9CqgbewN6/uEMZN1Qssf830kVCvQVQZreRu4euu
         1po7H7n3CU3IToLbbfoBpXRzLyhs8LVmtjeDEDytRy3rZyYaTQSdfprBW9/r8RU7x4t2
         hrmYx6lUhQ/RQBw11wQeMMtx/lv/zQA3yzt+lsezBdIRDiiHgrLKM3FSlX2UEo4jnKz3
         Tj/w==
X-Forwarded-Encrypted: i=1; AFNElJ8pfDby6f9La2HVL3fuGXfzz9a9p2gmrqL7LEmbNMGzpMsQWu1QS7uZMiEfdlyZ7yYS6xWF5juF/ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8XMvLGWxpTaK+O1Py39935/fjjftRfhoPMTOcHHTqWc7NBwIx
	tBeRdqH48kTXLYaFlDA4+eagBvC6B554ThivE8i4JAo52C3t1rbnbjtF
X-Gm-Gg: Acq92OEK4OqESfIn1+1YNkYaYbVTIePKg0LHeL4vQK/uGbebNm8Vu5bK3s+pzaEOV9J
	40zlnbE3tLZe4uJv0QwXJDj5EZI5RSKdF4rJYjUWEFOJMg6mf9RbZx5iZp3JxiEekvprV78cEvJ
	F2S3NmuLcK6rD/uFA0/1GuZ5cqUkrh3XcjGhOu7Zhfs24Jcxw4qWeTFljEBDMIqfBPzfrve4c8A
	5wbX1gFHpHbeOuXCSNzQpxF+z7X5if0EPi2eNYb6BrzeYq3NL68u9kqbw8IhYtgDX66lqfviiZz
	+UZN4Cmu+iTdMtyBGEtuM4zct3pYP9qBoskUBNBLT7KIlvUyx0dvWUyCFJtNQjSmaRDLfBVNdkT
	4mQeUMOo5GWeEDMYXTUEYHs83MUJVXtLRvtcxEOTVANbwU5L6Xsv1B0fAVp7D532fISLz/F31Si
	M7MPKjI8J8t3MlqI+X8+YGO4D390Kq7f7HO9hvD7tqafrI
X-Received: by 2002:a05:600c:4583:b0:485:f1d6:2b1d with SMTP id 5b1f17b1804b1-48e531fed9fmr150399765e9.0.1778439316567;
        Sun, 10 May 2026 11:55:16 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454916df968sm19967712f8f.25.2026.05.10.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 11:55:16 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	alisa.roman@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v3] iio: adc: ad7192: replace usleep_range() with fsleep()
Date: Sun, 10 May 2026 16:39:21 +0500
Message-Id: <20260510113921.50133-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD7192 datasheet (Rev. A, page 34, RESET section) says:
"When a reset is initiated, the user must allow a period of
500 us before accessing any of the on-chip registers."

fsleep(500) expands to the same usleep_range(500, 1000) and
keeps the 500 us minimum.

Drop the redundant "/* Wait for at least 500us */" comment.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v3:
- Cite AD7192 datasheet for the 500 us minimum (per Andy)
- Add this changelog (was missing in v2)

v2:
- Drop the redundant "Wait for at least 500us" comment

 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8b1664f6b..6bd9cdaa6 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -576,7 +576,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
-	usleep_range(500, 1000); /* Wait for at least 500us */
+	fsleep(500);
 
 	/* write/read test for device presence */
 	ret = ad_sd_read_reg(&st->sd, AD7192_REG_ID, 1, &id);
-- 
2.43.0

