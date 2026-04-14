Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDA219FC
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186210; cv=none; b=liBUMzPbCuPRVjS8RvnI4tBgQPEzKnsohs2hsupuekDPYytNNcJvEZOCsqlfIpoBWSK2nVTC4N6s5+PoExouvmqcd75aG+5+NhKHlha8dY+Gwmrr8Cu9baw/6Vv14WLR9alLX3yeZ31TJ9F99gp198ofjx0ijGR2ATHNPl4TX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186210; c=relaxed/simple;
	bh=fA1zSS/YfZy5J/ZDUZDzzJueIzF54dPREImGKY1ELMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GmGIzx82O41iMHoxUSJ+CBE8mUHOD4Xw1bOVw1OwW8y6MOyCuhhbfDbny5tdL059hY4zJUTR4ylL26XoafZkRl1PNnPnAn2BIuM+qrUjqRSJZnDWDp47mDHJjjREmrfZeqU1RUL1cy7+aS92mS/sJmv3MebWwUAfgFw3LnhSVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp03Yu4c; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp03Yu4c"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so5234804b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776186209; x=1776791009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrIM3j4OEk9r8/vDxvoQFFVWgkNZQBR8pEi7sufEB4Q=;
        b=Lp03Yu4cnT2oxtOATv9mhGHT9vWHMb681pqaDsucknqI+XsAp5Q1Cqjnidvxy2vogo
         Ne2MmIrbKs3Z28rqOhlYb470xAflYns/Bo2937ath/8qytZy0UPebf3xnmYNlSpczSWD
         1/C7KorZVTSYnRxO2uj4lq+F/NovF1uAyXv8KTSiE8hJVX4hMnxNgfqHiKDGaHj3Yfg7
         jM5XBHfl/q4EZ66oR8enGMZQWp4YRvNa/Ajz67zvsuVtytUKH3Dd7Zrx464y0joFSAuK
         OD7beK10OFTtEnYhpRtgIPE/P9/8rRJGnInEIXi7rtfZIu+YYR0qwrFP3DFbb1p0hQ1G
         sjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186209; x=1776791009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrIM3j4OEk9r8/vDxvoQFFVWgkNZQBR8pEi7sufEB4Q=;
        b=OXHIhFeM3sP8X9+VX1DAvoPY89m8e49r24wr71FPkzHfK6iKRR9x0f9zJvtf9uoupv
         TfO/09NM9QjhFimwR8ZwKM77UJ1Ob1SXiot1ORAxvPW5pCOgbLNZLJZiIRkvSwzVOdeM
         YUaxm3C4MJpCfSLsdFiQIJPl56y4I/e+Y24AuGeKlNH2M9cFdNVoTt0MJ5ZWbwADgUzk
         v1KojNVlWuSAsb/KotVnEke9+4i9LL/aS6LbVLjNeBNrJumngbH18mq740JIx8nFAE4/
         9Y6QN4jqhNBKFon2MwqTut+NB673SU1OowoBK758220WBhfLjqT8dICaWcolVNSiIero
         DOxg==
X-Gm-Message-State: AOJu0YzGWJkxRfiloH5XHx6Qwr/PNHGu9/odx4s7Ut8tRJAv0hj+Yb+I
	E1LbYeybC/jDcPGsalZsiztypKrxDCpuXLzaxo6IzQqjgGsfiYew3e9Uo2Pmztf1CxmD
X-Gm-Gg: AeBDiev7mVSDQLDA8+FizqvpGdllr+vVmhdow3YzBtmTo4YaXsZvF5OPRL04mc42PI1
	XKYCdVvcJJD9W+88Dp207Ug/ybbVRLEO287LK7owiW/M7rT3DTCODnnNp8Z7fhrVkPjLWaYY4z1
	/mg/v9xRrsehryf4Nd09t35Ab1i3Q35c23cqaiBkZRVS2Mi93+1bhFPyjbxUPH+e0Dit1afsNj8
	JZjEByOpbRtVVvFR4wIlv/QNEmKE6zi3emQ7i1bWeLmafzONZDoNfz6qBBNRcqVIA70fvIlGCq5
	uXFH1+8qZrBA5qVIccMLG+5stlY/7SSfPtfHu9VsiG3a93dT7j1pw1nM+wfTFjIGdVyG8b9iNIm
	I/hNUord5YT+Fy0IkmZkXLaPn6J9Hpc6BGrz8daS0lqCDBnO6sgyltArO052yc9NqsxwcJJy+zR
	Q1FKvB6P4EDg1+SHIk0ntxA0EuBoYey+pYFYCV7Z2E/bc=
X-Received: by 2002:a05:6a21:9983:b0:39f:5ef7:f0e1 with SMTP id adf61e73a8af0-39fe40e0554mr20466640637.57.1776186208483;
        Tue, 14 Apr 2026 10:03:28 -0700 (PDT)
Received: from nik.. ([101.0.62.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e3d41sm19077474b3a.48.2026.04.14.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:03:27 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v6 0/3] iio: dac: mcp4821: add configurable gain support
Date: Tue, 14 Apr 2026 22:33:05 +0530
Message-ID: <20260414170309.6151-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series updates the MCP4821 DAC driver to support configurable gain.

Patch 1 fixes a spelling issue in an enum name.
Patch 2 performs a small refactor to simplify state handling.
Patch 3 adds configurable gain support using the GA bit and
adds support for writing to the scale attribute to select the gain.

The scale attribute is used to control gain selection. Writing supported
scale values selects the corresponding gain setting. The implementation
supports all variants of the MCP48xx family (8, 10, and 12-bit devices).

Changes in v6:
- Removed enums of supported gain
- Fixed commit msg for patch 2
- Renamed avail_gain to scale_avail
- Used MICRO Macro where needed
- Addressed comments suggested by David Lechner

Changes in v5:
- Fix commit message to remove incorrect "fix scale" wording
- Clarify that scale is used to control gain
- _Scale_available is only getting the supported scales
- Make scale write handling generic for all supported resolutions
- Address review comments from David Lechner

Changes in v4:
- Split changes into separate patches as suggested
- Ensure scale_available matches scale
- Handle sysfs write inputs correctly

Changes in v3:
- Restore NULL check in indio_dev allocation

Changes in v2:
- Use IIO_CHAN_INFO_SCALE instead of CALIBSCALE
- Fix error handling and cleanup

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Nikhil Gautam (3):
  iio: dac: mcp4821: fix spelling mistake in enum name
  iio: dac: mcp4821: move state initialization outside switch
  iio: dac: mcp4821: add configurable gain support

 drivers/iio/dac/mcp4821.c | 137 +++++++++++++++++++++++++++++++-------
 1 file changed, 114 insertions(+), 23 deletions(-)

-- 
2.43.0

