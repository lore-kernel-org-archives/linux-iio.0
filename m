Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35B3A6F0F
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338104; cv=none; b=kyqmki5iAJk2CI7cUx/PcmjXv5TGGNcboSjwOGXJEHW7wwn0sxz2/p5fK6PM1ZVZdN5vfyqrH8THev27ZqHcmtDOBkL0cwL1V9gYcPCfRzZc6shO85tVcBpFxRobp1lhOuZktwnX4draCuzGAeCmp29lD0v3z41KW8wSoT975AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338104; c=relaxed/simple;
	bh=qY0CqK5eUOKnK+/FVHIcIdFFdqaZIJTn/SdAk2gmNQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tn0ec5uYIt5fM9f+KSQ0+w4AhPkTBjWpTaZrCywbcRcy0a9RxPe8Lc1+V6mYNJCj/6gzmnECDL+xb9VY/EDnpN13Ea5wINLBNp0uz/2zxZkHQssCWnjuGbepFEoHJUHEbT/HYFMPtAsbZaJ6JwnISPrtF0FWw4li3B8zT+jTG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD6S+Qsu; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD6S+Qsu"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso40080591fa.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776338099; x=1776942899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLryxNRenriMro2Z4ejqmOCO3qrLI31Euj9MDAdT+Ds=;
        b=gD6S+Qsuzk+r6q0m374hna8mS66Oz/hznHJRXTU3iZtIupRDDOSUJ5S+eCQmEElrL+
         iMobH1hAf2A7DMWXmlNWLm8v4o6/skKBhG1vKuXLB6jivx/sC2UOJ4LhCZbGLAG6I8Uc
         1Jn8NzNLXKbRfaNaIkB4/qSlldbWf5kt62QoBFKgADEOwO0nM6gXLWEti/FjArh3AppG
         y1XSMjumdhnBMPuKnJRABG0bDAmsVY7tMAbSHMm3gHo73yFsEUdHMJm/Vv6isGqypwAe
         UKnChi/M2zNUVTZZ1SoF37d6khqGej4rCI7zJ567qPxXFhnMrKjw0FpX1Js8IjJC23h9
         n1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338099; x=1776942899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLryxNRenriMro2Z4ejqmOCO3qrLI31Euj9MDAdT+Ds=;
        b=AFsOXcFef4TIZeImWgXhmNlttCQKJAb+SXGATluejuZbQLilE/B4JxwXQtM5R37PKc
         OzkKdImaIXrM5p1jgvddboYqz9M8J6ld3G8SR84+sT+0Q91gVZaRMkdcl9XZm4I+km63
         tKFiYhkTVoQkISyQT6Qzz632JhscaH8pCF1eOrRBSyIMdxMQm79oreLgrSFpe2c8sCen
         T/JmeQl2XeiDGNKkhO3jQtpTqmJtJLqDoPKnW0l4RPjOKDxYJvddYTdf7rhLR/VDvzF6
         zfQ+tKNz+IdLJQvXZs59YgS5ct91ZhDlHpnHmviPumWXw/Kn54LerxOOQKQbAxPRwCOQ
         /Y/Q==
X-Gm-Message-State: AOJu0YzKcfzZRGRe8OTZVJ+bzKSct2pLh1cb/veRi+4vtIqszd70jmN2
	m+gdO5bXt4rZ/J0zf0n+wPoBBCRPuRsWQnLpnx/JmkIKiR4VLb0ncm+A
X-Gm-Gg: AeBDies9sl7MO4EZ22CHr/RU9HMuKnSJQHYiUoig94btxmCJRCctoNsWyPaNDKxCB4c
	vRqhqcb4VTWNrmbORYYInsjg6OeRsQPr6jEUkvnebviitp3n7ZtrT7Ccb2nIGOHhb724mFCnuAb
	l7S6LbchLSdMGvb3TUfXJ3fBi63N4+FimCDmUkdmVGymoz7xZFi1M4YodY+5fNwnrT6ASOS1TH0
	Xw2D9MNeMJLBZma7aT79mInL00NzaQx2B3MErtuSrYhZJI+sqiQpsND7rGn7OcNGTouzLHDy352
	J35S5YsMPgTrUmhTSMOlhYthiTkt6mmGjOISl2p4TlxLmHU5f2IKLz5sbm2uvrlws7QEwEH9IRe
	dStjMg8MOZzD52N520Acaa5VpTDSqOnU914MtE8uMBAAax/UJ1qNH2YcH9UHu0NFl0Qs5NHN4qQ
	iF7qTHZ/IDR7iaUcx3LSugaE0=
X-Received: by 2002:a2e:bc14:0:b0:38e:2cc5:d196 with SMTP id 38308e7fff4ca-38e4bded73amr95126561fa.1.1776338098664;
        Thu, 16 Apr 2026 04:14:58 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e9ebe67edsm10734831fa.19.2026.04.16.04.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 04:14:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] iio: Fix iio_multiply_value use in iio_read_channel_processed_scale
Date: Thu, 16 Apr 2026 14:14:41 +0300
Message-ID: <20260416111442.61932-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function iio_multiply_value returns IIO_VAL_INT (1) on success or a
negative error number on failure, while iio_read_channel_processed_scale
should return an error code or 0. This creates a situation where the
expected result is treated as an error. Fix this by checking the
iio_multiply_value result separately, instead of passing it as a return
value.

Svyatoslav Ryhel (1):
  iio: Fix iio_multiply_value use in iio_read_channel_processed_scale

 drivers/iio/inkern.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.51.0

