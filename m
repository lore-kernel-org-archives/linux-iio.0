Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D32EDD62
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391647; cv=none; b=Zl9vHLejJ/g/MfgcG5uZZXzQimTqtNLyc48N/VzJ2/QIkV9BK7NrHCMd3gmKg/64ieKdzUzEygu0roAgcu7fici19/xD2ZJdQuepXDOlM93CvkY9PH3dDYbPqEJTCT6epySgaLtET9SmVq2jduU0JjCkoMEseRWy5HhB93JEhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391647; c=relaxed/simple;
	bh=5ccwmQPoqo0dxGX7AU+50K1MLvxXe/aYtFzgjXmS/qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E4t4ffSGW6nSsrkqz4Tl4KxYhULBGMt5PYU8vZxkqhIC5bhDYhHv4CubT1cbYskVCi5ZdQtPx60CEYjPucBNOSLu7Z/mZmDh+V3qzqY/PGH3IBw2UTLEf7G6XEwoRThdUqEnd39MS5j1sp5F2rYqbYSLuwgKpIVDy6qsW0OWef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8naQU5I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8naQU5I"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so58999245e9.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777391645; x=1777996445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9OehboFy1coyrNeS8fAME8o6FJzLBAnEpNhsgwrmGY=;
        b=J8naQU5ItiLg4HQIIeH718ZG1XYUU0alm8G2wFlnoUUlO/oPWdNmUe9kyPaq45NnoN
         QHJ6GQ3JlpvOvz5hkRtF8hgSs3Eh7TvIsG92h0lwVvTo77oox+uBqjJF06oZsR1uRYCD
         JqzOKAPdRcEff9UqzYtEcWAxeY1sSUm+uaM6cTa4dHIoIXHWc1TFgge4Qkc8pbo78kP/
         WKjC328mpM1pZzEzDtU+dDlrdXhnw1tniDpX8wpVSPerlaY5/bNWYuyUzR6afDTJcOeE
         6Sd9Ow+NnaHaHs5m9354nMzxH+MZOcOIDUAMv+MKLNME9fJeOdTJ3giH0OPlReeUOczg
         Fh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391645; x=1777996445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9OehboFy1coyrNeS8fAME8o6FJzLBAnEpNhsgwrmGY=;
        b=Ocl1n4RfYMhb4aSwy0Xesw0sCBqvVxZzUbgutfcbOiizEVoJZ1nvmzcQLiOI70Zqno
         JzRM5BzRHoUjY6T7M+U8ptkTY9d2RfuWaVpiKlCYRM6QzXxWXDKh4Mu0/j7CYLfNIJbV
         YmyTJp5fbFQhdr5gdtuCSVtAjW4RLjAFJlmPksZhvpibFkIDUORAoAE1A2ol6MUs+erA
         pnxFWU11qxipcxWd0oJqAoUnIAk1wB9Mwpcg6iHblGFBbQfjJXsfuvasamgwVpcVW9Zy
         kJ6LpE5z6GtPaN+AJLbnZARvmgUY4jYe6jayh0nIMBolAUpGiZG34NtBzyIiobdQmU0T
         A9Uw==
X-Gm-Message-State: AOJu0YzeMAORtxRVsivCpennnbI/kkGEjtnxlhv+1ya4Y2fufzDGfXid
	BvylJu7yg7ZFPqMxEXnj8Rjrtws+qk9Zk1QWO1QvxALY5ur3TBodPm/p
X-Gm-Gg: AeBDietyAVDeeqDOrgD1RURkmpymGtrPjfPjzq4qL7tSoOKSPi+z5gq7cPqmS1+rY22
	owtmGAPnygojsquKRkKle+hrcUD6cBjtVz5kOnninYX1oosTo3CKIFtgRYJAK3zeHxQPyKvOUO4
	YnMLJpob36R5IIdASZPDjeA3ol/N7hnZlAPakSKfnod2af+WfAWNkYOzyHA2lLlGtiyh9AD+75g
	K70E3KT6Nrkjw+rhl3PEDwroxLw/z4bpMjQY5Y221LHvmk/MrMBGb5dVvu4xdxASQz144HLCzOT
	Nafo9FGqJwoaA2AscEdO1VmqepkF7y51R9XGhAe+0iVpH90wef6OAwBkD9/oJmPgy6rBdUWtIvd
	2/JzZEae73ZhSojs3nxcQOGfCTdaHCoaFed+pQV+6JmpZSbO4R1HGAg9k9EcD/HXxpx+tvu9IR7
	xqMR86lTro19yIQBjWasRTQqIjfrEsbOdr0nh1pQ0/KYuH4lkx
X-Received: by 2002:a05:600c:c16d:b0:48a:5821:6006 with SMTP id 5b1f17b1804b1-48a78922196mr49214795e9.4.1777391644546;
        Tue, 28 Apr 2026 08:54:04 -0700 (PDT)
Received: from localhost.localdomain ([165.51.114.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a774c3ddfsm51036435e9.2.2026.04.28.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:54:03 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: temperature: max30208: fix wrong scale value
Date: Tue, 28 Apr 2026 16:53:49 +0100
Message-ID: <20260428155349.68019-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver currently returns a scale of 5 for IIO_CHAN_INFO_SCALE, which
leads to incorrect temperature readings.

According to the MAX30208 datasheet, the temperature resolution is 0.005°C
per LSB. Using IIO_VAL_FRACTIONAL with 5/1000 correctly represents this
16-bit resolution.

Although this is a change in the ABI, the current scale is objectively
incorrect. A raw reading of 5000 (25°C) is currently reported as 25000°C,
making the driver unusable with standard IIO tools. Given the magnitude
of the error (factor of 1000) and the fact that the driver is relatively
recent, fixing it to match the hardware specification is necessary.

Fixes: 9ee95ae4cffd ("iio: temperature: Add driver support for Maxim MAX30208")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
  - Update commit message to justify the ABI change as requested by Andy.
  - Fix wrapping of the Fixes tag.

 drivers/iio/temperature/max30208.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature/max30208.c
index 720469f9dc36..96f63c4fb2b6 100644
--- a/drivers/iio/temperature/max30208.c
+++ b/drivers/iio/temperature/max30208.c
@@ -163,7 +163,8 @@ static int max30208_read(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = 5;
-		return IIO_VAL_INT;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
-- 
2.43.0

