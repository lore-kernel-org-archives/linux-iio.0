Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214722BDC0E
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766050; cv=none; b=JGiJP5WUlmZKUUOCjCEZ2dUsc9Hith0vjyNXD5msWpbnZB+fW8IdIEAOmSok+jzzKOoqmG0fEllgIq4prSzwaDpZaqQXLF+rOFcevi+4TYutarvId0y+58j3TcRohtuxf28ROG7/F2yHU1E/gVsm1p/LCpVhpGgLCiLxTxW0nQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766050; c=relaxed/simple;
	bh=Dlksx9CsphuLrHBFIsYSDBsijCGGvNivvglF7yf7xt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jmsa6mh3X9xPiY0olsj1DPmDaiu529YosCtOIzlcFUjDpT7XoVYGzVbfq6KtO2dnGxn2jvwBAXpiAvgSkGTE6ZawE+oRAd6FvMTmK71E1qMaUt4rmzVL+EOBBnZgCzSNMZ8J9EqDzbJJy3eDu0m9qU5Ej/uk2mfA9g7/V6+GMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S02HdQ1X; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S02HdQ1X"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso530270166b.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776766047; x=1777370847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M07yxNHtWmwHVHc6LYsU2GWd2kNotFi1z++xpS7xv64=;
        b=S02HdQ1XVuTdHaVGE8Vu9tEcgD5VLqzIdr8UtX7tqooFBO+0kiB0kY+vYXYJXWEK2/
         ejYBZxEsDxQlMtCjq+tU1oFkfsUQtUUrU8V8rqhMLNJQ/J4yklSrVBaIGtxhcXav7l65
         PTW9tskw9nFkXrxXfdTBmnSHjP/1qWrGk0sc0TKbMP7QzogjYx3I3W3mn0hyO/MrdUBW
         fMETLZCVcqm5h4xLRNH2LhWbigToEDO5/Q0Z9QAsWBqu84MgSTttk3ZU4z7VPIn+r0YM
         FX7n5MmcQ0R3qiqHSVRqGQcntbLZkryYnmzDSzPSGHaxcfsnJRgcQY03T2AD/5fLC6Yz
         MNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776766047; x=1777370847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M07yxNHtWmwHVHc6LYsU2GWd2kNotFi1z++xpS7xv64=;
        b=AHYeJevZ2oojUNdoVtcPYUc1es4Ne1HHK+7OmvlGNFZ0SS/5Y6mNbtKXsCUlI/NyIz
         2FfRURAcrvL3IANmImkJQbWa4ynRyr9TaqnK7HwR0vIrI6IyU8aBDPOyuKz6lML+gVZU
         wpYaf0SsW5wY9pbUkzwMCf/TMx2oD6lDKboR4Nr2KEeQgRz1+iv9OQxzQjjHTzt5F5eT
         JI8hTdWh+5wA5rHBiayFvAEp0mW1YCRWHPn2R4FrrA5VKYgOro3EMWShUL/AYKT6Mq6+
         dn2RtXVVQqv74XqWOy+5IoEpUmPjlINP9hixYl7A9I/3M41MoltSYLaJqqa1x9U/CxRr
         CmXg==
X-Forwarded-Encrypted: i=1; AFNElJ+isLtfDnU/7H0w+T7OgOu1NI7skP2rKYiW0kAIrA8/nWlvrsdu/9QMvd60/bH1Od7oc5mmnTbcgDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQbl6le4Aa5odlphu1UazUQ4XyhI75OhHLSGR/9Tm7kocQjxw
	7ykE1CQfgTpnCsLSitQTWw2WqGMSYf4ZYWPqFd6USgHREQOJoJD7bW0P
X-Gm-Gg: AeBDievIlNeIS7vb8YNpsSjDCwSM3zmr2whmxv+tutEIREJ8s9eL8R6xQJPKr+XVPYH
	/DgrmFIiFYcG0u7pPsGRPcKq6Kex6cS7Kss8REzHGvDGXWCXmwhqlv4NTJmiD65VGRrfkM6HQ74
	hFRuZ0Q0WxOK6wyzbBNq51LFtqKhg6DQW09JUd0BH6LiQ39uxI85E3oR3jc8+xej9R8+UpnPDgi
	BZ8bzZ3DNc7dbxwnUbxi5W56iey/XwGd3khpQy6HUqvh9V0vXbiD8rESAvNIwoa2prcVYJ0ThEl
	JRomZKAaX/2c8yMUC7sQgvKkIs23PNhFTgt65t02yvqLGpzlnjZ2uq+10fTuB+5iBfmadp72I+z
	vrbgSqv+1pFZI344tShQTMLK04vr2oDkAWyga+vi5ltt+efCCtW4S7WRrYVQzQQGWoveezNrS2n
	vFknCRAagJCh/o/CLM9hptzoUmJciy0PhzHpxguoONBogzd0kR7TNHxlvrjeMWPuENVwXlFxQNr
	cThRF555TZbgLGrwNQslnAYq6k4UJkybU3mrjpSM287dw/94RTU+aZ3UXn2Fpzkh/M+BL4NFoRk
	PKJjIHbHIaS6ajZEv7xHrqpFRYsi1ObcPApaT9yVHBWTOhd8xqCCtSAgPCtq9ywKL8Wolqx8tbo
	TcXjafRC8u4zvGdXuRayH/1YMrp7BER85/3sAD3bcWIEch9RH1EHudBFcGbntO41YWvE4wnizsj
	cQUXeORTA=
X-Received: by 2002:a17:907:934c:b0:b9c:1089:47b8 with SMTP id a640c23a62f3a-ba41b3e12e6mr788155666b.47.1776766047251;
        Tue, 21 Apr 2026 03:07:27 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (238.77.147.34.bc.googleusercontent.com. [34.147.77.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4550468d6sm428078766b.52.2026.04.21.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:07:26 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 0/4] iio: magnetometer: ak8975: modernize and cleanup driver
Date: Tue, 21 Apr 2026 10:07:18 +0000
Message-ID: <20260421100722.1296-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes and cleans up the ak8975 driver, migrating to
more modern kernel APIs and cleaning up legacy code.

Changes include:
 - replacing usleep_range() with fsleep() for optimization
 - migrating to iopoll macros for better device polling
 - removing unused headers and adding new ones
 - checkpatch.pl fixes

v2:
 - PATCH 1: reverted alphabetical header ordering per logical change
   separation
 - PATCH 2: added newline between fsleep() and return
 - PATCH 3: fixed open parenthesis formatting
 - PATCH 4: fixed whitespace issues, added <linux/time.h> for
   USEC_PER_MSEC macro

Joshua Crofts (4):
  iio: magnetometer: ak8975: header cleanup
  iio: magnetometer: ak8975: replace usleep_range() with fsleep()
  iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
  iio: magnetometer: ak8975: modernize polling loops with iopoll()
    macros

 drivers/iio/magnetometer/ak8975.c | 70 ++++++++++++++++---------------
 1 file changed, 37 insertions(+), 33 deletions(-)


base-commit: c65f27cae0deda3316ed49899df4492a3896e38c
-- 
2.47.3

