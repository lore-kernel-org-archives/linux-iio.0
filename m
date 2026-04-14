Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B43B6BE8
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158583; cv=none; b=Gfzri5JCn6GyBMg5Z2mpWfT3zuDCeC6jhnI9BiAsZ/oGMDl6W/QtlJk/K58+gFj0d/t4Yhe7euhRWgpqoPkhFlhdMM5IKTAw4FIX+fLSI/USmA1tSsSmUagYm1Ic5h7rmJ3bYUEPtVOG3MU4gv0NUV91+n/+8KXSfv4g3Zrmhlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158583; c=relaxed/simple;
	bh=EBa225WkpP7jf19Pskvijv3vb1Z2z0O00xzRVUxMyrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DDEC2FNEpGFWFWUKbt0T84MP5rGGIi9zk4Wgb54CYIJ2LkJi4VAPOqh6WTLz7Fh/EYrdtp7sx2cp1mJkUSIBNLgBnGrXkgqE/ffXa0TLWJrakqPjVrsexJ9gMDhb+AhV6tmDK56rM1eSHwRfyNk6WlOZWRCIMoXTluLRN9memQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZUjN3FG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZUjN3FG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d965648a2so4480549a91.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776158580; x=1776763380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kc35dWXG3FzRs3Yero91bOiwUEEbotCxMV+hGtjO5U=;
        b=MZUjN3FG6D3RulcKw0/1JE3DqwuZ81SkwIduUSEJpeOaQNdyp7iYFxOqHEYOz5khyM
         eHGUzrxNmb3GgFhyemmWlpp79yBWS7uKdForsemxUaomWJ4BLJUpNjuVLIkUhyKENiZU
         5n+yVXyAPYnIbuNbCsOcgOAKT+gRdhAxfI7F8bd4OO1nTe3zqPvSU7nga3TfyPM0S7VH
         uHnlWQbn2+vnYnlW9tFtd4OCEy1lZnzDwYmR7EUwNopBu2BimfwNzhQo0jtBqbLzRnvy
         7dhFzFy4g4RlBWbK/fRxJ+KK/+dCESnSEkGM75teX3sLm2kmqvWh1VapX8+IkWW/vo5t
         pgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158580; x=1776763380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kc35dWXG3FzRs3Yero91bOiwUEEbotCxMV+hGtjO5U=;
        b=A4LNfTQnzhct6Yphzs0c2avvabVlc8PgnpNJ8lpH3XV15sJp6bVT7BwfaFbhYOSWKO
         H9NoiiNshhJw1R6K1LHhqD91uoFczugSKiHmavfdy/hPML30idixVmfo+Z7rNWfQnYYw
         gqMOPiIjJ+bWlTFIHWLpZPTdRAY+58n42B56gZLGRWyM6J6EBjG8Y9Qrr1fS4LVKiTN1
         hZelWmOY8A1yMXLujelssuMjc2l4RnMVcF5UK515YFn7cq7mOhk8JPlCwyOy6b/HZ93z
         7pgnwf0b7EHwje7pqcBCbEjMgei9OzbA5QJkR/5cxxW8pKLVHiIyzRaW18AckSAUQ192
         Jdig==
X-Gm-Message-State: AOJu0Yw/HSGPUcOw8Kq66ot+n9k4W9cQOWB3/3LsjpOT5KVmdIRUMZRr
	+EV0lir1OcQJ4mC4UYvrhavvhbOr0W8UCqFPq7KxKdvAw8rbzI1lV34jZLgq+YU=
X-Gm-Gg: AeBDieuEFWo4XQEBqSWHAtuWuRpR/IADDBeDHVAHRQ1Ssmt3/5LJwoVIX+JuMlXR7bq
	6x6/ZP46LfOhy2dZZKjnyvCjhso4DPGidIC9AGKLHIWG8I3DWuNNx5jyhOCT6B3U+J/Q2gpMuHk
	2b/napGYb7Rqc7K9bzTXTfWhmchWa8piywssD47YW+4SeBfWgcCGPIjfyeefDGbnydm9XgFjH3u
	5+iNq6zPEPDrl4tmSCN+exWkF5d67jIeIbvrLDxZAWHS3H0W1zkpZyqzyr78YLtMKeANQPHz3tw
	1cVpc1r18FkV3Lm7E64XMOqGVBzsvYuQxrF4Do9ktXny4f0f3Y62Poo4/cpr0g/RqiI1crS56BN
	jnu59PbCadfMFkllOFxgf9iv4VO8ERK6GiqoudnnkW+XgNIQtOF5tUNJAAsG7sT7zdWFW1rd8mf
	uBaJzSCrugl9jO8wo7qy7ym6qyKtemtNYIIX35MP6jeuqTKbU9tF6BHQupNfpp9eUIby+8xHar6
	oES5kbONLVykykvYIhlAQltS3nadhQrevKDHRameRACW7Y+SiebpGz+
X-Received: by 2002:a17:90b:35cd:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-35e428524cbmr17311858a91.17.1776158580417;
        Tue, 14 Apr 2026 02:23:00 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e75c38sm1448991a91.11.2026.04.14.02.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:22:59 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v5 0/3] iio: dac: mcp4821: add configurable gain support
Date: Tue, 14 Apr 2026 14:52:50 +0530
Message-ID: <20260414092254.34883-1-nikhilgtr@gmail.com>
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

