Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFA35E929
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970168; cv=none; b=avjzfxOWayHT1HJriiWI9s72ZQvkwjDFVVjo5eK5iiLNLFEpNeLTx6NJJoqLV9hbjaNdALu+CvfmapW9sTihXMFZ3KDTQ3xfe6nnGrhabsypXmrh+Sm5E7eentvWLoo8+fvc0FIGYKBilc2OYZI2hMgtaAnX4z9Kvwbj36+Dbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970168; c=relaxed/simple;
	bh=0UBAs8GFxSD+zNRCAUGHu4PYPrZacqlrRTel1GoW6zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=De3zfaUZOjP7RPgR8EHTnurqkMa3bZ5EK4GyumL09r5ON8sE+QBZLAKkRqzFbK8dLojgUsHrcAVZljJuIG4eMKkvcRR2NbLrHlJMcNoYOu2yinkEtUOc8FILgjgeVAjCiI9sXzmWCHLwtryp0qhV5xmibk45vb1i5jVHt7/P6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5nlS4Ur; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5nlS4Ur"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso1107344a91.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782970166; x=1783574966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ruFjDhoaXJQkokcbjLpD7A+2yXhuFwXH3/7PsBDPQY=;
        b=Y5nlS4Urdu99tUGBXYzwOWRbHUns5ngWRufPh4kbgQdN1JLJExYGAXx1zvBFaxtLP3
         qdQXY861u7FlSX+J9PgFsUZk7/Jzofik59BUeASsTRhHUmpFIAgSZkoykeVy65qISJsZ
         ZFxnnBm13FyhDiywtB46lMT9sib9lzysTzach+1pr/i4Q8QsyWXdTDoUsJTwh+CZ7Wmc
         QXMxPO2Vs6cAujAOk+0tTGaISfVOaohfbZe1c5Yx65vcG4rYkxSe4ozVaz6Memc4oh6U
         WXIQcjX43RPFghYNVP7Fje7tfr3CKBWULTaVUpv0L27Ko2E6nW1z5GdnDgzzUL/KyVsH
         Os3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782970166; x=1783574966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ruFjDhoaXJQkokcbjLpD7A+2yXhuFwXH3/7PsBDPQY=;
        b=nrl8v3EhbAJCquNnZHC/W3O5fbkosTWR483PmXWoTdKhQQRmyThe48Hc2/GmJ/daf6
         JzfXaz9CJJXaprFwXr4S4eRdeZOlBSYgxCCdw2eyhCECR6AYZQdADcsmjN5v03IsmS3C
         pNqET2YITBUMJ6g+W+3eI1Z+18lvkh4NerSYCEWUttPxjHPgEb0aflVJO88Uqb3091Na
         NUQZa/ndEpqpIj60kqb4CtzFPOXJZFnsoeFqQ84E904dWwJm3Iiip1Dyl50VXjpEATeE
         P6eMLAa77NlmhczwLspOdhPJCeT535bS/6+TkNsiKahXjRFU5N3O+YkRO8VFRGbEKlHe
         XrcA==
X-Forwarded-Encrypted: i=1; AHgh+RqZCIfq8b1ekLNUF+5WBI/fXRyvkwvOyxfdSX10LYWgUfVqzHMMupJMTjCpKzAf8mNhEcdOFllP/hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEKaZxrtgQxr4GHAIJHLvVPWeqmhJKNJDe7V9/X8iivnHgItd
	GnQLVsAeWfBzk633ka9A9E0cmWo/OWdG2RvB5sOClvZmk8sn/LAdjWIQ
X-Gm-Gg: AfdE7clwP+nLN9H9xKey1L3zUr4sSVE6eLavFr2GbzJUkvJUA7Lp0/k/ELBJht22b+p
	MxyBvEo+X3YnJ/tEwlB9cbaE1bm36dgobsze42sdtvxH+W1vMLiw9EG/emhdSOaDIiwUVmR823M
	y+ZKRfuPET8GkyT0yjCLOVlsIi8TBsfkSbUZF3Mjnc6B5taNuSZXxk7V7CXG5fjrjIrbqTIgsbg
	iM3Wm75pHfItUYxIfmsE34vN/2hV6slyUjfiNFkiO2/sg0ojvxgmMZ6G1FkSakh4oyYzqZwTAh0
	ncYN9pKdaxMzoEbt5N49eCWilcWtEadrSGFV/lahk6xAJZxxk7tTrauMVwHKDkbKE56ntrxJSFE
	H+PKmpaihouvoJE3grTwTOCXtOyOGNn7tG7ZhNaY1bXJSNUNEAOs2sdMj2kuGA2UW+A6Yq1S8v5
	WyKhSN0ro1t3UOE+VEUx8uNayvRLIUnjz1mcjuQtIQhUv31HdXrXQ=
X-Received: by 2002:a17:90b:2652:b0:37f:9ce1:735a with SMTP id 98e67ed59e1d1-380ba91c157mr2861802a91.27.1782970165714;
        Wed, 01 Jul 2026 22:29:25 -0700 (PDT)
Received: from primary ([223.181.23.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a1bsm4770046eec.3.2026.07.01.22.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 22:29:25 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH] iio: light: al3010: fix incorrect scale for the highest gain range
Date: Thu,  2 Jul 2026 10:59:13 +0530
Message-ID: <20260702052913.114130-1-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

al3010_scales[] encodes the highest gain range as {0, 1187200}.
For IIO_VAL_INT_PLUS_MICRO, the fractional part must be less than
1000000, so the scale 1.1872 should instead be represented as
{1, 187200}.

Since write_raw() compares the value from userspace against this
table, writing  1.1872 scale never matches the malformed
entry and returns -EINVAL. As a result, the highest gain range cannot
be selected. Reading the scale in that state also reports the malformed
value.   

Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 drivers/iio/light/al3010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index d603b4a6b8e8..cc39f8af4ea3 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -42,7 +42,7 @@ enum al3xxxx_range {
 };
 
 static const int al3010_scales[][2] = {
-	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
+	{1, 187200}, {0, 296800}, {0, 74200}, {0, 18600}
 };
 
 static const struct regmap_config al3010_regmap_config = {
-- 
2.53.0

