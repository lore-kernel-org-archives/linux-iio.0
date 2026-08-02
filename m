Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE3C8EB
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785639124; cv=none; b=JtaE1qAWFEZ5F8VeNDq2I6HOIKmI1SvhyHkbR9k74ezXsDBKVXDUmGkgtHwnlh4ugFNcPvfU6aiaw4tu8cIPeC2WjkM/MwLvJVoeBiKEijkKRLgRkYOtRT3C9/Ml8OrjOChM4ZNrkYe1UFKfzRJ16MOnxpEyNqx52JqtFddiLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785639124; c=relaxed/simple;
	bh=UPRI0r3DoBTzPZT1PoU35E3d26DOutcvNUNGRfbh7TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoMpqKv/dJR0MnJRP0jYsZR6z8BXJDPjBdb9Lk3oV6grNjNgObi3ylQpAIG2f003TGeoCnCy0GJrGHT6dlM2Dy6zk7BHeKAL4asFL6Lj4XXdMNmLPrJfkpkLltr6aLzx3Th02WrFXWJZaz+QdPU23qAgR73EXUI8aUyXf+kXPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ8f2uFK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ8f2uFK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so2086133a91.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 19:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785639122; x=1786243922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elZkS/aYURa0ZPHqh1a/2YjlLP3po0YPtp2jV5sHCWw=;
        b=lJ8f2uFKBhlHPdRWGOYo7adiNWKkKMess4oeaKGtYe/W/7gPc7MhZR6Qdzx8L6L11q
         OgUDtb7BkAlepnodRxAz2w4oFyHZMmlOOOPuF5xmnobAFXyjnC9a9QBSNehV36dctHKS
         0AcKJWoonpPpYYzJxR5bM0Pfc79lebaiMTj2uhfG1IDzXvfH9cSktizFEmih/TZX2RiN
         NapKTSTtDcRptd2K+L3g0oiuQUwYQBEDkOIw/I3jJ04s6nciFdW9NJhA9Cch88pU3pBE
         h3FD8kdri9p9BFqRpw4Iq4no0XYHEcAQoPzGpqsLcYxkvq5u0RVOWO4a/KYb4W8QuVMp
         iPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785639122; x=1786243922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=elZkS/aYURa0ZPHqh1a/2YjlLP3po0YPtp2jV5sHCWw=;
        b=RS9WsvsQUYefCh5wDFAiGcCiSTEnQqu2wpn64k98VXwI8nr/94lCrFnR9iOh/ZC0Vb
         76L0M/ynPD37cEkAB7unFCvF7z2EfP+AbGo22IYgs1KoS9VICAH3dLO/eaQhDjJT6dMJ
         JAXyHlZ2lod8jAmvE3ejYPHZlvdy9hdkEZqD7tceNgebh+hrdgz0EEtY+jp/rxxjLoY2
         Z8DUG/+AZXQYJo1k2mEYAww+TGj8+9IJwHF9aKDdOf+TvcimyZXnyeufrkwYP0wafEtz
         ms8bOYrSfzsdoJOMa84WO/KvX1HmcIvg1rfdXUuBDr08yvOwol/zG245eNYEGwx2PKim
         HIDw==
X-Forwarded-Encrypted: i=1; AHgh+Rpivi1WCcg88//3Zo0Rd5mTiofFCpWl2oWltX7nbCfZW5/2Lnqmk0ngnwXVbMiuqTILo/tljgiWASw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Ca8fkhb7snyoJzJyuI5VsJeRwX7w5K/Dm7vU8qvy+JS0Erfs
	iHTvQXzHmei+G/1+g3Q/5Pj0bCH0+Tc5nuqbXJdfKq49AZwkvlFKGI1W
X-Gm-Gg: AR+sD11pFBKr03hUKHrinb6NxuRReNbXJpyjqKKmBe9yNyyNKOsvad1c28L5louwWwO
	Psuzay+bHJByV5xvEOfaFZ3njfe60j/uYUjDWkaKwR+67D6TzdSugzN2/f8/q1qlJMMR7c/VlS0
	jnDABqPHKI1IcKcDLMb7TH4hkxCrKrL3LD/iv+cUZjrWmj8mh08ols/hlaW7dRMqQSvsP9OIO+O
	4b84aIbYZNwNVIP58py4zo2O7F6OMoDnyXB65y/csqrCvEXHO+r6WBwkovs0WUWoMEp36hjtvRA
	TTKaD32DFxTxPFn+z6dl6c/RS33W/g3FBKhnUTS74wUTFjXEVTrFMSrWLZQz/hQFnMl8RV3AKeX
	aM4fkdevsuv2TLgJmSy7MOjnKBfOKg0hl01WU3SJIE+Al80ZlgmY97kBXLkyTOp3o4ua1e7dVfd
	l17IGzjkfErjh0Iq9GsM2LBjAD7XNy+Z/KIe9n4lA+iFtyidQG1LuJrBINwME7RBxdXSc0hKm+A
	Or0dnKF6xYe8eoks5MjyAZfQEYcE6CViYbd91P8eQABwx91yjch0m1b4sltVg==
X-Received: by 2002:a17:90b:5305:b0:38e:5dc:af03 with SMTP id 98e67ed59e1d1-38fbc5b51f4mr5664911a91.40.1785639122499;
        Sat, 01 Aug 2026 19:52:02 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb51asm27904804c88.9.2026.08.01.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 19:52:01 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: joshua.crofts1@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	email@sirat.me,
	bhelgaas@google.com,
	mazziesaccount@gmail.com,
	adinata.softwareengineer@gmail.com,
	krzysztof.kozlowski@oss.qualcomm.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] iio: chemical: sgp30: fix checkpatch warn to prefer __packed
Date: Sun,  2 Aug 2026 10:51:31 +0800
Message-ID: <20260802025134.25319-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723235542.152a6a25@systembl0wer>
References: <20260723235542.152a6a25@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change instance of __attribute__((__packed__)) to __packed per checkpatch.pl warning

Reported by checkpatch:
FILE: drivers/iio/chemical/sgp30.c
WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

v2:
- Rename commit title and message

---
 drivers/iio/chemical/sgp30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index f10bbebc29e4..c33592a1e0c9 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -82,7 +82,7 @@ struct sgp_version {
 struct sgp_crc_word {
 	__be16 value;
 	u8 crc8;
-} __attribute__((__packed__));
+} __packed;
 
 union sgp_reading {
 	u8 start;
-- 
2.47.3

