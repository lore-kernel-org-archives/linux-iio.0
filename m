Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9C1E5207
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229677; cv=none; b=PZf8FnPOb7zlZm50ZmZagDa7zKshkuCwkJqBobJ6h2Etlic5IP0NrPMIyZENn7sTZDbZK0wxigMcyTzrQF40ugiiL93cq2zGvOOTl3phZ040zLSKwePXarJS0wCdH+prrvfw5D/Siyp7efZmz4n5GwCOFBphB6apedHB0XvXQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229677; c=relaxed/simple;
	bh=qcpGYaAjoWZMDk3gUJniK9BI9Qn5rZCkB+eQVXlu5GM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i5k43jJyowCB8Ash8DzK5CD7h+2AmDPr1G1iq96YINeP53lSHcceRkrlPCNpQsgatbMR7HGwbHIzGXhBrf0Gsb5ipJVfWf2fPAryVH4TlNsrVX/h9LnjNxsP8B+zpeGfrXfRriPCc5/I4Yw8RGc8VWJLeonm4QRyKhFzOIhkVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyDAED4+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyDAED4+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f5dc076ddso738319b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229676; x=1776834476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLD1BRP/gok9Ohl7X/j3O931d92BKJ1ZjnQd79EeekY=;
        b=NyDAED4+ZQxQmHvGHBpH7iom5e4USuo5PEMjEXB2M0nFsw/lSHhYWMZExLbXWSaMz+
         WR/RHbOLjP2TkEx6sDyRa7ucNirax4hxgrkd/qvzlQca46Gpglh5PlFyw4D2nFgzbNZf
         U4xmjNblN5sLu1XutNEU2emOn8kqIBJJwMJbRPQpL2SR8+Ictf9lT6OuTSL3Y86YH3L4
         hcgGu2JGJ7nwRb5caIvfi4E92ptzHmY9jeEFCdIG3m7JjmULyuy6brMxx9ZJhxPeJTSU
         LvR1F57DJrQH+Yuhhvx5EgTu2oQCMfvZU1gbym14frY3WMylan83dURoi1q5aORmEuO/
         EKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229676; x=1776834476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLD1BRP/gok9Ohl7X/j3O931d92BKJ1ZjnQd79EeekY=;
        b=XfYsY0fl96UD3W2UhvLoyhQslUCjdg8i7IRMCEa0M+gEkPkwmfK92gQ2SRC///MHuL
         z02mFJ+iMnLEJ5pfu4N/62MXhcQ+nxs2C7TOUvDfA/PYkwlz3F0V2iR5kawVkpgs5JVz
         lvvb/CREeoLP8IG90rPwe1xAinw8Ff6wRETUtdpcLVtgf2N3DbCu6+1fl7Gpa1ZQiTOJ
         0+RAJqQN73h2QqqF7PtIU1TlnJzYn7/2ZxZe+c4QDcr3sBO3+GRsTp9YtkFzPOHQgR49
         wSmzmamzNCwhfLpevKIlxmJSpzfJzm7EDA+4ZYwCN98LhUgL+3ciilzUyk684tBqwAv7
         BxLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ep8sTk+L+tb3u3TaPOyr01K2/XKAzD5pGRQcOUb6X4d8gS/3DRhVIP2gKceX89EBqxhZJ9T/5hPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxo/KJDkdpD9nuTwrTpSLj6ALT+4opJ6rQKbGc4Xi2xy6zuZy
	6ZRt24UEu4b7DkJVTpmYXL0ROSJdNs2cgqHRJA1OIdcJYI0mWXt/9Eyz
X-Gm-Gg: AeBDiev3eKMJH6LE8yNu1Idd9Rhvfh49Ft9262+VSLSrrU6UjAs0JlQRfPpAMrv7swS
	w3wpjVsQvCWLU4ASIaHiNP6UM9+l9Oijd2W/9TTRc57HzQL8NPhpmStiUEbHAzBsV5boB6FEnIV
	3EdEJU7P64ZbI+fxxm9DG62pMLlnul5G+TYw7p7P0OyEcTHhvnTye5FdFByv6D/HEK+kRgXn+6s
	IMX4x0PLJT/5i0d49NXH4ZqYUyD+kafDNR9X5St6kWufFyL9N4uRysNJSeAzIOp6qMfgXr2Q+ov
	X+gLeKu6yxoeINiGZxgI6nBnAorzEFFicpVyMKBguze4j0dBYOP4YSrsFj7p4vXWpsIfdqucZwD
	lAMy/1u6F2XmIV2B7fhgYcTz8F26WYEhitmC9hrj3Kq3phYqgIYj7ci35GoTuvj9Qj8xfymsDvc
	xl2tEM6M6gvQBqihILKyG4BLuYRt3S9535UlHcLtDnIlZjLWXrXd9hK8DKhWg=
X-Received: by 2002:a05:6a00:6906:b0:82f:c9a:d335 with SMTP id d2e1a72fcca58-82f0c9adb55mr14329234b3a.40.1776229675901;
        Tue, 14 Apr 2026 22:07:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67469dc3sm763706b3a.58.2026.04.14.22.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:07:55 -0700 (PDT)
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
Subject: [PATCH v6 0/7] iio: ssp_sensors: improve resource cleanup
Date: Wed, 15 Apr 2026 10:37:42 +0530
Message-Id: <20260415050749.3858046-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi all,

This patch series improves resource cleanup and error handling in the
SSP IIO SPI driver by adopting the recently introduced cleanup
helpers.

The changes focus on making probe/remove paths more robust and easier
to reason about by reducing manual unwind logic and ensuring that locks
and dynamically allocated resources are released consistently across
all exit paths.

Key highlights of this series:

- Reuse embedded rx buffer for SPI transfer instead of allocating new
  DMA memory in interrupt context for write transaction between AP <-> HUB.
- Replace dynamic resource lifetime management with device‑managed
  (devm_) APIs to simplify cleanup and error paths.
- Refactor common helper API, improving readability and reducing
  duplicatation.
- Address minor codestyle warnings and use dev_err_probe in probe path.

Changes in v6:
- 0005: Drop remove() path using devm action with input from David
- 0007: Replace dynamic memory allocation with embedded fixed size struct buffer
- 0004: new: drop duplication in remove()
- 0006: new: Use dev_err_probe in driver probe()
Changes in v5:
- Drop usage of guard() helpers to avoid mixing mutex_lock() with
  guard()(), based on reviewer feedback.
- 0003: Refactor shared helper API, reducing duplication.
- 0004: Convert resource allocation and teardown to devm_ managed APIs to
  simplify error handling and probe/remove paths.
Changes in v4:
- Update sequence and make checkpatch style fix in base change
- Split WARNING and CHECK change with input of Andy as 0001 and 0002
- 0003: Use guard() instead of scoped_guard()
- 0004: Use preallocated buffer to stash memory allocation

No functional behavior changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Based on:
  <linux-v7.0-rc5>

Feedback and reviews are very welcome.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (7):
  iio: ssp_sensors: cleanup codestyle warning
  iio: ssp_sensors: cleanup codestyle check
  iio: ssp_sensors: factor out pending list add/remove helper(s)
  iio: ssp_sensors: drop duplicated wdt timer and work cleanup
  iio: ssp_sensors: convert probe and teardown to devm-managed resources
  iio: ssp_sensors: Use dev_err_probe
  iio: ssp_sensors: reuse embedded RX buffer for SPI transfers

 drivers/iio/common/ssp_sensors/ssp.h     |   3 +
 drivers/iio/common/ssp_sensors/ssp_dev.c | 119 ++++++++++-------------
 drivers/iio/common/ssp_sensors/ssp_spi.c |  83 +++++++---------
 3 files changed, 88 insertions(+), 117 deletions(-)

-- 
2.34.1

