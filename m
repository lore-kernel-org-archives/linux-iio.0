Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B512F12AB
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411256; cv=none; b=EBNXMvV1NRViVNnTRmQ4ddgEwZCiBB0NUHUscm/XQQFbssknMBAwvytTE9xNDGg4HRRXk6r5HMhsjHK0NE+6o9uSH4YYjn6mdZU/CPZuSVtuZDChwHNvepkBdj/fbCYAo+/4sCvE/qYYlEsrDDA7qa0VSFUCo8MNXwPYULLtg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411256; c=relaxed/simple;
	bh=5fclEXDDuT+sXtJg4ceME5bBs86atFjTAHlF5i9HdDc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZsXkZyhnmcFsyc5OT3hj+vG+9RjzCej7Fj9nf1tvCT3UePfk27ajXGyUpuT65phDfkf6PEeICThU0Lalt1+C4d4IDwj0LaVCtvybAVAAfyBbzbbCynCO6UH2yN2R1co9LvQC6T7EPqb3s9kyHtKocjQygW6ZtfB1Uq2yYpVpdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFOM7NRs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFOM7NRs"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso2321535a91.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 21:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411254; x=1789016054; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ra+ZPy+hnKesC8Sn+un1UOlkqTiaEK8VZmbFv/xFnwc=;
        b=UFOM7NRsG4JT/UbkFQ76RwBRliOQ70TEC8ZsYWx6rOPg0hiFzOGQYgnj5YLm15b8n3
         BD2JPa+tcEfG5dBlSXx5HhdusNCTI0w+z5yQtILD4XTClfZw0RwlMIru1QyRITBhcVNR
         nenMpPO5tPUEUpJkfqpDBL/Vkf1tyaqhb/6iHHaa0eBPwstqB/AAqMy/elbuiteUxbMU
         yt6p05JAGh8la3oXxYmJbsvNCIODD0IKWq6nR5Q5tVokLB/VHCX+LIU7ugbm0nfyT/WF
         B9Tp2m6YdW2g9VfOigCWAsoHtzsV1rS3CfE51Z+w5fCsZP+0ArOpAia2h7pd/sxCd8Vd
         vh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411254; x=1789016054;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ra+ZPy+hnKesC8Sn+un1UOlkqTiaEK8VZmbFv/xFnwc=;
        b=E4uiGQ9vcShyRdz3JYwy06f35L4bk+hbcAXuIPB1feXSr5P+3ou9B5WkJbfNnWwYFv
         w7jnJL9b4ZE4sY5GYzeV0muzaPSMmoeFr/x9YRXXF3UlOp2bqLOLHgNX5IefKQGl6Ym6
         zEEHRgq4LO5AmOwytlCh2oNuS9qiUEOWjwrmzWWq/VZGSJEbrwm6vcYGgryTGAgTCP5w
         2t8kgtPJboKf2b54qAbqPG+pR4o2LO66Kq2iB34l8c4byxuosUy4gSSW3k94XVL47d8o
         d/LpLIzyCcLFOkpXpfusF9HqLtIcjTYl59j9CR8CzD0q4z23tAipd1wflfjTV32Apqh8
         tRkA==
X-Gm-Message-State: AFuF++nTAJLZp4ZPOR2KjEPCRbIkzd7x8RePNAsMd8xGL0A5ETTEbDmD
	Dd5338j2IgL9fuh31wrqpgifjW6U5/OpZgq75K0fFrRVm5GO5RYdmHRVGbFBjg==
X-Gm-Gg: AYBFou2k0p2Ic0ZY0xXnijmn4Ht2ojDYC+8U+BMZYOU6EPHgPO7/WQNvOs2hdR/5dJj
	PEvn/mI2EvMNXDT9Q4zqh63wNYswwWQc1tgzybL/e2VLCopm/PS2ZBgAPeg8qs+CNXGRDPD79/U
	isM3xd6tWAbZGe6fjYHbqmRqT5+lOD4Q2DRgl/A4TqCyD0hnC4QV/QTTtv+Cl3w7dABoK7fORxY
	j9xvOavPyCgbSsjEbVvTRFFrpGCwHv9Wd/jlQz1i7NgisE1G/3ZQlclCDvFXBTII/is3zrdr9h8
	Weu+HvoNbEQDSuKL7Frtgln0sx/IBfk6ZVuEHM778t0uhOWce6XKgA+oUCNCnEZ8kywxAR5DCZw
	4p2xut6BwKQMCB4uKrKYfNnjdUsOIEImuKphXON+iXRvBgeX4+fwM6Asg12EsdaJ3itiR+XrV2k
	BVdnr99P0H3BYgneZkfOmTODpLba20I8AB1C1CTfxXqzB15vKCweai76mol2AsXemrXw==
X-Received: by 2002:a17:90b:1e04:b0:38f:57f0:1f5d with SMTP id 98e67ed59e1d1-39aee16ffd9mr12393903a91.15.1788411254557;
        Wed, 02 Sep 2026 21:54:14 -0700 (PDT)
Received: from [192.168.20.42] ([115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8f1cf6dsm2300801a91.3.2026.09.02.21.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:54:14 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Subject: [PATCH v3 0/5] iio: light: vcnl4000: support shared IRQs
Date: Thu, 03 Sep 2026 14:53:45 +1000
Message-Id: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMQQ6CMBCF4auQri2ZqdBaV97DuIAySI0WbaXRE
 O5uITGSuHyT+b+RBfKWAttnI/MUbbC9S2O7yZjpKncmbpu0mQAhYYfAo3HXAgA4CELdKiAFkqX
 3u6fWvhbqeEq7s+HZ+/ciR5yvXwR/SEQOvExGW8tSSS0Ol8o8Bgq56W95NbBZimJdF6tapFrXS
 qHQYAw2f/U0TR8yjq6P4wAAAA==
X-Change-ID: 20260810-vcnl4000-02e19f70e706
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

This series contains changes for the vcnl4000 driver.

Patch 1 makes .num_channels match .channels for vcnl4200. vcnl4040 and
vcnl4000 channel arrays have the same size, so no functional change.

Patch 2 prepares the driver for level-triggered irq by making sure the
DRDY interrupt is explicitly cleared when the iio buffer is disabled.

Patch 3 refactors the interrupt configuration help functions. It also
standardizes the hardware disable order (clearing INT_CTRL before
COMMAND).

Patch 4 adds a devm action to explicitly disable hardware interrupts
during driver removal. This prevents unhandled interrupt during devm
teardown.

Patch 5 adds shared IRQ support. It changes the trigger type from
falling edge to low level and adds IRQF_SHARED. The IRQ handlers return
IRQ_NONE when the device did not generate the interrupt.

---
Changes in v3:
- 2/5: Clear the DRDY interrupt when the IIO buffer is disabled to
  prevent interrupt storms (sashiko)
- 3/5: Refactor interrupt configuration and adjust the vcnl4010/4020
  disable order to safely stop interrupt generation.
- 4/5: Add a devm action to disable hardware interrupts during driver
  removal (sashiko)
- Link to v2: https://lore.kernel.org/r/20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au

Changes in v2:
- 1/2: Clarify in the commit message that the channel arrays have the
  same size.
- 2/2: Drop IRQ trigger type checking and use IRQF_TRIGGER_LOW directly.
- 2/2: Check the interrupt source bits handled by the driver.
- Link to v1: https://lore.kernel.org/r/20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au

---
Tsz Shan Chan (5):
      iio: light: vcnl4000: use correct channel array size
      iio: light: vcnl4000: clear DRDY interrupt when buffer disabled
      iio: light: vcnl4000: refactor interrupt config functions
      iio: light: vcnl4000: Add IRQ disable callback on cleanup
      iio: light: vcnl4000: add shared IRQ support

 drivers/iio/light/vcnl4000.c | 173 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 130 insertions(+), 43 deletions(-)
---
base-commit: 940de590b839f71d6dc846160534bf202401b8b7
change-id: 20260810-vcnl4000-02e19f70e706

Best regards,
-- 
Tsz Shan Chan <tchan@jacques.com.au>

