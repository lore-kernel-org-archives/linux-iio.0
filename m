Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F323CE49E
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087752; cv=none; b=DOaz40Og3iyUvNDhHJPUm9wSQHg/Rp9W5ngXEi/1+qqKT2nVp0wAQOzWqfw2nTn39xBN5muhHJ4Owo2BIBcZm7GewsrfZhk5gsje6rGJ+upMdzBxe5VkMq5CSjB8d4QJdZqV77JJEKYdvSjHT0Cx2vUbUqI7VOW0yN7xLUlboCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087752; c=relaxed/simple;
	bh=wEsLy7sIov2p8gIOho9DrRb8H4YGvPO0nduyD5Ijkvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rwmHYNI+O4HQ7IfdTuiA0x5N5py5SlIvniF8W0/BQCMPjOmdUhGmE/9XpAZT2ppd6Pl2Ig3YTMIe/GO/nlJ0Dw/Ie0R6HijgHVdVtIxyULsH/YZPfk9saUCSkFLfYuiwMULYvL8lhxWenFEXEaC2+FSuapVe1BBYRsTEnfreX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbkjiV12; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbkjiV12"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso2836352a91.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087749; x=1776692549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmGJ4CH8PehbDf9XBzAbwuYfOv6xeCE0wtPo44tkIWE=;
        b=EbkjiV12UpyiIo0N5Kvqm86m7OLAve+5Sw/+GAK8iQLo/e/grm0jPkqfOjAbN3mlMi
         WC55ofelQZvkV0hfBVkg/xpgXLK4b8D8dO7U9UfxdSRo9B3/iIVV1L3rCaBR++7XZILD
         4ROPb1Ee1mfQjN8Thl0DgcDZcOnTtU0v2TcBWQZIJ1/xLkF1j3TfZ8iFRZwiFli2CbuD
         ewct04IIeUhhVaIrJEY46dscQY4P/KpcMYwJCTtarAsgqtb7I9iyzG87Wo33pnXCTW0C
         icrL4qkxjjtEjTbH2kHq8XcBBq521CuvrGo1uxB03Fb7lLt778gdY6snJJX+yt5c5z6p
         FpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087749; x=1776692549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmGJ4CH8PehbDf9XBzAbwuYfOv6xeCE0wtPo44tkIWE=;
        b=Wqa4eiqhJSqgQni0Aqzf0asg06D3dTSPyrBsq7BvF6tVQJz+48GcAzqkpxOhYHwhAg
         2r+MpYKLtkwJN3tGajBlBLNPS/vIbJJOcHU2xdHh6MHg873xKodr26EzR0HK0rqD/Rhb
         foY+2GFtMMT03t3Vm/MaDpJYDSz6pUrgJC1m8ANfmLr3a63ddNQAN2MhIxqPorIWOEGO
         Bu4CoF7h8bgKM/fjhzyR6Ez/N5+n+uY0AdMgjXcOwETwcMUy7MrkxQ+C5ye2jkL1DYq3
         DZL4GeYJx8N7hGqVS5GTmVKTsOESawlHP67ho4oXpIb/SRbafuC/w4y703PcuqMXdZGO
         +eAA==
X-Forwarded-Encrypted: i=1; AFNElJ8D16xQMR6W9OjUUg/1D+KuyQ7vwRgHeMvxdj7QMpFCRrFQQ7n/HeMWqbJbdckDgLNBxpM6NsSD5gU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jxHv8djaCDWYCQqII0pSzPBuHrKstrCSOuJwBmbA8b0jsp6E
	aQ2gvAcILHByMGPBO/HD+evDthrBqNJBFFCmOpOZQ832cbSNhM9J2T5N
X-Gm-Gg: AeBDietuQAfDYeUwWtG0bTeCfXWmxTMEvtFsODmaFpNjFpJh/EW7BPWIhrxOhcrfN7f
	14A+FgNHPrQUD8xeHvWKGElZdNG3OKLkIVodvAqq9Y+/ZA2R5CFElqMNclQD5oPuv0vr1a7xCMB
	Bt5Vo24w/6VMpqcM3+0OYg2kmNOUL9oB6adDsX8r0jQJyvAyvSv0nF+AN9ogdzDP3smcrswA7yQ
	MS+P328tqGbZRccmRNZQL3JHak6Tyg62hCQ+0JI7uNAm1/4FMYKkQiNKoNltgwkvxU1B/AEK4BP
	9Qlz+NIC2Rcq1hb5g3Om6UubbcozY4B8jH2jIanahiLmn2yxQelPqvC3uLf9fqFLDLciYUaI+mS
	s9DFIEhu2l1JWs/0RYYrKP3R271G7dJsfrbMyScqzrj+GE+uJlTv6qsceeHtvPqUFRQAgl+J4Ag
	TogRdxXkyXvpsiR/WZaQphk6kgOfTe+yqjz9KCPsAA3uXV6+Mw
X-Received: by 2002:a17:90b:3c48:b0:35b:e551:e776 with SMTP id 98e67ed59e1d1-35e42869cbdmr14841877a91.27.1776087748630;
        Mon, 13 Apr 2026 06:42:28 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb0dbd953sm1832186a91.12.2026.04.13.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:42:28 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: ad7173: codestyle cleanup
Date: Mon, 13 Apr 2026 19:12:20 +0530
Message-Id: <20260413134223.2331911-1-sanjayembedded@gmail.com>
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

This patch series clean up error, warning(s) and a check reported
with checkpatch and no functional behavior changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Based on:
  <linux-v7.0-rc5>

Feedback and reviews are very welcome.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (3):
  iio: adc: ad7173: cleanup codestyle error
  iio: adc: ad7173: cleanup codestyle warning(s)
  iio: adc: ad7173: cleanup codestyle check and spell correct

 drivers/iio/adc/ad7173.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.34.1

