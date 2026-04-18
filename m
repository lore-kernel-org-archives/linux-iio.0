Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589772222A9
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531929; cv=none; b=AhqxMqP9gcjA+Eco42jUCWU6OsVhM1fGAYnH0sFdeOOZk5dEuPoNZEllIFs+qqiRY8bm2ylTDZQrQicPEaP4HRpIESuLjRc0Y0PNJHqBxw1DyUUeuLaJKPM0wigXJcw/G9InBgWL7qYQOTuSNDgLocw+vgQizFpk7bt20ovYBeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531929; c=relaxed/simple;
	bh=neIqv33XDkWCxv5AJkbIxD2kIAFYCAOzQOTm8Hy9v9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvMM/XIK3dgbegewu3EShm57GDuieGazcs567Ns4PfUfjqD8DVWWfBkQH8QHn1G0EXE5aMxa8dvP55xC/i3s6dwNfSTLp/9fIo5EBFFO6rjGd+OvAKsJIxmtMeat0j6+W4VeFZoeX7hINquWZ3pbR0XGCfwi0uE2MtJp/5nLbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhJdqZmZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhJdqZmZ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f69adeecbso760813b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776531928; x=1777136728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MR+0rwyJXAQ9d2qblUNtIVZrppwjIymKB9Q8yoxGiY=;
        b=lhJdqZmZnLs53OEoLjtSn9DF6ijKyEQ98W/P4C1870FWCBfIphh/zV0CH5zB6FuKGc
         MKq/CwJySj5Lfa6X04ZQ/PDU5d6aWBeH7lLZLYh6ToP1VfnVOrYrEpi7GGBPWNvGhPqn
         JfYW+iN4n4k/QOTCM1RnSsfx58A7aJ4IIKeTkiwzcQSSzjkItc+wcLxIN8n3FGQSRj6/
         siELZG8rUwnyJZ30VUGeFQa0dp1my8IQCaBbm5jCIjGgbJab9tX66+ZCqNw9IHEkhHKb
         BzFsw2Ge9YrqPTnAx2YTOKbhDHidPWQbiuchfVfRtBUfao9Qiq649crsVw4dLz+dGly2
         1mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776531928; x=1777136728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MR+0rwyJXAQ9d2qblUNtIVZrppwjIymKB9Q8yoxGiY=;
        b=Th/imr0yjAHt4BnACQaaAynlF6VZckQsXvtEX3BY8Iz1jRtJt5jJhhRWOOajuZ6fuS
         BtzGp8yat8jx2zFc6ESljP6bHFOyt2zAzbJdW1d0+AGv6FTw1zsez2FeBISyy/ZZM2Be
         VA+5hGNmW2oO6uhGA63yoHY5mGrfbJXqHY1sfWmkWvSIUp5krhxz9rZCRAzT/Y0PtCR6
         +o1a6mouGKmlEjl+b7VOqXIw9KIGSb46i9RmgcFwGyLnYvW/Gd87d2PViI1hb+gMU+5Y
         a3ZsORKC4cAT0CjulUd/N/SYbF9V1oGqyZvxmPPNdhD/zbVj6T9NyP+ZhBABm6vXZrCg
         Us3w==
X-Gm-Message-State: AOJu0YyALoecJwv7WQ5H0QU59ZWqCRrGbRJMDjsxI5oFp3kmA0Qm8D1h
	/Snm5dH4tsTmC3vaECmX6h3bhgbBXRoA4yzg5qwv0NcbYr6GJwFT+Yei
X-Gm-Gg: AeBDiev42GfE8YrsuVAce+ZsLE4Q8HUCj5Hbg1yjBwCNB3fo4d+ch5QFY+DvQNmNwfP
	KMKDlcs6bI2slI0g0ibPlhT1TkUy+4nQQsTTbjtpJ0EgGWC+9RuOsfc6zItcRM8gUc7BZa6eZ+y
	ep0g9t0onoAwVTLs62FmH+57JZZqO5cdworoCcGVjHDeDdqa3m2aT9ndj/p8nur6bZZ6KGR/q7m
	wO1YnfpklpZv0wnS4SD3B3v0ezVxpGeeTk5lf7YPJ5WcQFLCHyr7G9mBTqQ7VcaH1xq2fZsJc2i
	KkooFnmjOX34pVUXH39NGWXKaNbmnLE3ARpx4shCnqS4gWpCwfvv+RNNlEfrD1r+1OnGxpTQr8m
	Q7MV+gIo2RLH1KmLOlFcCiQsmTQhFdd7LPzi3HKn6f5vaagtS2VcMUAtcK90hRBUce5D0+jfXKk
	6sXKM2kLx4zLSIyer4nTMCKdD3pIeg1u83kzp4x3cqW+wDpGa/Voax2uBdRKDJBY9IxUKAPSwHF
	VMPIXbUuLsu/x7LPqqm1gcVhiBYqfEsDcn8Zp/p2sqpPuvcY8Q=
X-Received: by 2002:a05:6a00:bd86:b0:82a:5ef0:210b with SMTP id d2e1a72fcca58-82f8c8a5d89mr7538662b3a.15.1776531927647;
        Sat, 18 Apr 2026 10:05:27 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d016:3ec3:66e6:8cde:aa47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea02ef7sm4966352b3a.25.2026.04.18.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:05:27 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] iio: adc: hx711: add HX710B support
Date: Sat, 18 Apr 2026 22:35:13 +0530
Message-ID: <20260418170519.312360-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the HX710B ADC, a variant of the HX711 with the same
GPIO interface but a different channel and gain model.

The first patch updates the devicetree binding to add the
`avia,hx710b` compatible and document the variant-specific behavior.
The second patch extends the driver with per-chip configuration, HX710B
channel selection through trailing pulse counts, and fixed-scale
handling for the variant.

Tested on PocketBeagle2 with an HX710B breakout module. The device
probed successfully and raw readings were stable.

Piyush Patle (2):
  dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
  iio: adc: hx711: add support for HX710B

 .../bindings/iio/adc/avia-hx711.yaml          |  36 ++-
 drivers/iio/adc/Kconfig                       |   9 +-
 drivers/iio/adc/hx711.c                       | 222 ++++++++++++++----
 3 files changed, 214 insertions(+), 53 deletions(-)

-- 
2.43.0
