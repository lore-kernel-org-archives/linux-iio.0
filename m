Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6562F84F
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748277; cv=none; b=PnVDG8oY6IyTjuXrnMgQNEsQX8IT/cqWiFh66f+WAMZgjRCZZn28/qpZChaOw2y3l8z+KCEb6/4C4lZ7jPZVDCxhEIFuvtpW7LmDr7ywX9UTjbIJn6Mg9bSTGbbhjWaNrDNn6T/mzPzjmJczUjteM+K3yE4C6DO8Sx+HXhTlQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748277; c=relaxed/simple;
	bh=4Mb2sE0t5VHj8KrN5qm/La79m5mR/fH48E1nduC3sqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uVAIUBERedX4m7kQ0uqWXsBQVu4ultiEW1mKg7HgE5qrUZqlDaULRXXfW/CCOtgaDNJS8Rm4Qv++OaTW7jFw6NRDn9GW4Wzz0AGbUtAcuicpoxdmLYQYR+251c6OEofLrUBjIc7W0cP0fWkHgvtrblR2tnlG/seu4t6JyBQHNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvXscF4c; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvXscF4c"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so1518596b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748275; x=1781353075; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ciD6JDfZME6lggXRo7tdfg+t9RkhDLMdFtncMXFS9nI=;
        b=qvXscF4c5k58FWYTC9F/6uyszlJhRI3Ar/wJ7diMJxipgsgGfiGsWumsPltmax4UHk
         14tGAUZSOyuxerYows+S8X5zFjlRrkcx7jq71n084QEYEiAbt07Iip/k1a90hB+Vq0Rq
         VQe6F9zzVxuAn52LaidRus0+egs8KtSL2FyG3lHUzEZcuqk52OXEgS+ts0+9Cfxggmqd
         tM6xLoDXTmffEpW+HzoqbmoeJeuqpNuTJA9MHguljsw3JLoscycONvwN4Pm8h4qCnrBt
         oa7P5ecMOzFoOVFP3dH6kZtw396w0c/Qq9xeIakZ43PAHx3x8JhjVXkycXhB8CUiXl8r
         6njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748275; x=1781353075;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciD6JDfZME6lggXRo7tdfg+t9RkhDLMdFtncMXFS9nI=;
        b=Z8SubgXIdgBwPdQd0Crg5pQesc4EILcbzFemUozQbhBFvkhiWJKujw/asi2SADksTZ
         ZHOEBEKn4wp1IK5KDn3CnJPvpPTgiVy9fMA9zwQGY0ABbyULjqIYprvHy9hUC4WYviQs
         dpOezrEsDvv6EDnP1TKnKT04AhA+hR658pB3uhXBZ2u+KmrAYqXhTCfq4/COWYG/S3sl
         MmecGVUfqAmQdONAnxWJtrEUqA22XSdE4DNuV5zqBZNygHtVA14AJsheXIZTIw5v3rUp
         nCH6nDjWAtsdQuiymdHknLfTv8JCwdkiPSmb1H8/XVCGNtFZc7/pGfuJLLxjnuXUE9E0
         Zp7g==
X-Forwarded-Encrypted: i=1; AFNElJ+AyX8zAg9x+fVOwoJLbZgbQ3db/68a2LRrSRPepwX65n4LU9y4iiBkMAY+DcFQc1B5zgwfz1MZR8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxdIRHbPvfTGF8cDtegPLY+rSd3i4T3vKKQk44bWRv6cjEg9t
	5u/+QkkrbwxHBGrpny8sq0HJzpyMmLqicxzVyyuNSJ6za389An5/8g0M
X-Gm-Gg: Acq92OFL6nMarrOMM5ex5EmSfo0qCnM7wsdAas3xSOnJ/K8QmTIn0fOx98bz7gaBeM8
	ZOqBQBP6jlhH8ZIH0JfTe1bN8Foqv2rb7TPS6JESQueGDDml/xlPFYSH6v7H3BSJIAPyyD0HY4A
	K7yOSa2qXW3haMtMrje1Ol9VWrT6/tIgK4y7HcqSOVOV5eq/7Ewl8U9swvrnBWEQmuuazpfKm4m
	qu+eoZ9HfLct6SiskiU9SG3eU1y4EomZrZVjaqy2htTP5+Hjyj+gghpylWFaUCkUaJiOMssjdKp
	BdzLvr+dd60w/3mSqTG26iwafpry7nmdmL1ZTc0KsQU6l6ll77AsPnNfeB7k/JE7c+pxXvKIPsh
	kTF7PtKpQjKKbdfWe1iSslEyn+T0AN8/s+j+WHbZILLH89UDiR+Y0skopJGm2pQSL/4WJD8woYz
	S6eTvTpvA4jYc0pmetUn8+TeraBZyA0lz/YkSK68p2cC+NqXRUsMh/vEK6OeA=
X-Received: by 2002:a05:6a00:4c1b:b0:834:e24c:3f9c with SMTP id d2e1a72fcca58-842b67657a4mr5631697b3a.22.1780748275139;
        Sat, 06 Jun 2026 05:17:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:17:54 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH 0/7] HID: iio: basic clean up for usage_id
Date: Sat, 06 Jun 2026 17:47:41 +0530
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUPJGoC/yWNwQqDQAxEf0VybmBdqKK/UnpwY6rxsFuSbimI/
 97UMqcHM292MFZhg7HZQfktJiU7tJcGaJ3ywiizM8QQu+DBDreaGVeZUaQgFVWmF1abzi5ee+I
 hUmpDTOCWp/JDPufD7f5nq2nzzU8Lx/EF4Yi0wIMAAAA=
X-Change-ID: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

Hi all,

This series updates all HID IIO drivers to use 'u32' instead of
bare 'unsigned' for the usage_id parameter.

This improves type clarity and ensures consistency with kernel
coding style, as HID usage IDs are defined as 32-bit values.

No functional changes are introduced.

Testing:
  - Compiled with W=1 for each patch in the series

---
Sanjay Chitroda (7):
      iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
      iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
      iio: light: hid-sensor-als: use u32 instead of unsigned
      iio: light: hid-sensor-prox: use u32 instead of unsigned
      iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
      iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
      iio: pressure: hid-sensor-press: use u32 instead of unsigned

 drivers/iio/accel/hid-sensor-accel-3d.c       | 6 +++---
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 6 +++---
 drivers/iio/light/hid-sensor-als.c            | 6 +++---
 drivers/iio/light/hid-sensor-prox.c           | 4 ++--
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 6 +++---
 drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
 drivers/iio/pressure/hid-sensor-press.c       | 6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)
---
base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
change-id: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

