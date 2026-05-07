Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526C39FCCC
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176299; cv=none; b=BvcLri7rhRG99XsAZXZJkMbN1InI3M68uoUv+y7B/qRCVBEoPYtIGeNJTkvuLXKmI3EPwXyLv0qXNx3Vxl9KwrTJqMNaXDK8KkQfNW31gCWmCI4bGOuqv+rBAWWRPcOaH4+IxRx5K9L+CYSuTGPe2HMagaf0XXMAnTUULEvMHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176299; c=relaxed/simple;
	bh=zuoDMQGj3MDbvmqev6sQfQUjwdHu7xOwHAkftF2Y7+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQ6FnsCOF8QA4IVV2jcAkw65PlbTgAIg94eRzikpCJTVTrPVgStah1gkg7gVF8cwv8LQPd95tDuj47xteTs+4yEERlq5XAeK1B5ONsJ3C6Nv4vEpKxuJwKuDY22dMNKVWc2tgcht164Yre0PgxqL/Eq10O/fEh9vmFU9tjbbDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOBD+W0O; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOBD+W0O"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso10921725ad.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778176298; x=1778781098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp+I0appWVNwjeoWaZsZNNHjhUpMSaUWN/psqNBBQA8=;
        b=KOBD+W0OxBPCSqbPnCmSFH95uxDOT46vfERB3uPpPeKjg6x71KcR3koRd4lScC5r6m
         /U7FKgqdqHmek18ImMeYB73mzyRYAwwZBRTU66K+vufb67wvzrP4b2AoV7WP8k2cNpGk
         Sew5Tb295k4n02lokjFooX+EmGo8fkJ0EME1eoOU0xjrEo7K7hzuuybgpaA6g7X3HejL
         rhiwipwGWbNza5MCcYBc7eBEh5QEz1GFE6w7oWv+OHA4k9ijvw7xzgGP8+FJVrOMdk3b
         FRkvQTwUeSj9V88ovV1ulTq6wdeBWuz+5ZNbekslpSGJ37ModbWEgapdYr8K3S6MY59x
         69eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176298; x=1778781098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp+I0appWVNwjeoWaZsZNNHjhUpMSaUWN/psqNBBQA8=;
        b=e5W2hRAn65qVj2Esi8A4Iow4PLWDWmAAp7IC+QAcIhP7e9c2xihVdPgCs4MROK/zKL
         ANicQTkTT/E83ZOX8Qq0Pqo3u9sel/Zykfsz1C2m/p8MXkCe6VxQPUXovqwhc7cx1kTF
         bJ2uc7lGYuZV+P10oaf5HbyG0S/+CzqK08DtWmj2nhcw0ac28HwOkD/Bh0AR/b1f1CT0
         9O5TP9v73tkGq78ZNx18HKTxhAZR8/gbRecOp8iLaND05MtKyHaWqi7RSRScEfmDmJV5
         xrc0wfniMV3Q8GkGlIHtkPDLAvmWyUlqmAuRUVOrjQxb4owkIfylyGq/L1vpvGxwzrUd
         7Kqg==
X-Forwarded-Encrypted: i=1; AFNElJ99+8jhHgpEPFZicMsTtQm1Bh1LbYq0/iNZGmdU+3zRb/h1F6XB8Sc8wUDyyecGFdEj45lrVRd2rS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6gwbpyIjJAMNCr2GQ3W29smCAIwGvrP+t69w/85m/tkgMxQ0
	Gu8iWHikLSSn1L1bw/TQLtzD8G31WdCCbRIg6GfrFVlQSFKcF0nxWbhI
X-Gm-Gg: AeBDiestIY6vswAcCBzAQcrKcYoDNkPKerT2bZ7ltsmoYq89yn9QTpX/DrV2uLrf7Uu
	L5CvdXZtQ92rbYaidcb8KcYvPnw/x9Wkmk02KMDMtIVwmYM+bLn1hwm2U9k5a7Pe0pzwUpHyytO
	iBt2K/Jb9ROB7yux7Dbf+vbWnh2zmcxWJhXZuugZx5sYOZrP+JTYvcpi/LrmH+uKxlt4X7xfy7o
	z2QP19+IT1muF5JnouQIooJWmtiNsj+hX6tcvS60TtjQpqyd13oGmf6E9mZuGng8oH/8k/sUNcq
	aV4rNMWmy7V0VUOfIzAHRtAz1LWhww3PmB6jkCKAyqdrWdG0mLUJKjsesSIvMgbnpvGlmqpky/j
	LWOQiV3omVClwJeo8w1cTIF3nhMMVvDO5bMdlawoM7fdPNcRE32devHSiOi2H/WkpEjrHaI3MxW
	AlhSpO0WRBZSWog33LciOXFABaYM35UZd8PZdaMbGhqikNX54p
X-Received: by 2002:a17:902:fa07:b0:2b2:549f:7d2b with SMTP id d9443c01a7336-2ba794b9766mr61451825ad.11.1778176298109;
        Thu, 07 May 2026 10:51:38 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae7871fabsm3153525ad.71.2026.05.07.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:51:37 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	linux-iio@vger.kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] MAINTAINERS: update ADI IIO entry and drop unmaintain drivers
Date: Thu,  7 May 2026 23:21:30 +0530
Message-Id: <20260507175132.3063161-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi all,

Following suggestion from Jonathan and ack from Nuno, prepare change
to add linux@analog.com list to has always valid coverage for ADI IIO
drivers and add Nuno as maintainer to oversight the same.

Additionally, following confirmation from Cosmin remove ADI IIO specific driver
entries where there is no alternate active maintainer(s)/reviewer(s).

Changes in v5:
- Add Nuno as maintainer for ADI IIO entry
- drop entry where there is no active maintainer/reviewer
- v4 link -> https://lore.kernel.org/all/20260430190642.3434650-1-sanjayembedded@gmail.com/
Changes in v4:
- Use ANALOG DEVICES INC IIO entry to catch all entry of drivers where
  there is no explicit maintainer then drop that redundant entry
- Prepare series of change(s) as suggseted by Jonathan
- v3 link -> https://lore.kernel.org/all/20260421165856.2245598-1-sanjayembedded@gmail.com/
Changes in v3:
- Following input from Nuno and confirmation from Jonathan,
  replacing domain specific maintainer with mailing list.
- v1 link -> https://lore.kernel.org/all/20260418211336.1800221-1-sanjayembedded@gmail.com/

Thanks,
Sanjay Chitroda

Sanjay Chitroda (2):
  MAINTAINERS: Update Analog Devices IIO drivers entry
  MAINTAINERS: remove unmaintained ADI IIO entries

 MAINTAINERS | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)


base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
-- 
2.34.1

