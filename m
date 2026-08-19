Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFB388E7A
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173084; cv=none; b=eW9GMchnqc373kGu//rm8DAHgIOkISa1A2ge438DWP5uW7o+qA4shdQ6Phcyg6B2z60721k6V9q+iWZtdTtndu/HSA+pwUXFdbNCrfF29nG5wJIEZ0F4hi4gHO295HoCGIcHEL/Np3A8K7WQ43Y/D/9m2LbI0aCdnZPy2um6gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173084; c=relaxed/simple;
	bh=GswaseQEJwvFyginRUF58LUdk6xOa2hQn0m4PSIXJ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clIWemwBG+bJDswTKEz+nnelT9o/CiK51Q04nQYQS2qJdRHZ2Q1ejoO83pzHCzJXTAy+ZxH7ancTZfIyIEl20Lc6MzcRFDBAN708hvCnaLBou68/86dHT772YZ2Yx0LEpR3GaCPVNNZLK2MqhXoxQsUXDm2YgIraRD22ulUuJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc9mM00y; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc9mM00y"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9667ea2fc22so461762241.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787173081; x=1787777881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I13XleUZppuMvfz8SUkNT1GjWZfu1XqD5Cn5w8LK/IU=;
        b=lc9mM00yfCS1cWECXPnDuDCqojChl/S2SG9n/VzL7CzY+QepNprsnQ1jTzO7aM4peX
         +rarSbKJwXf42wJN6+e7jbDvbS3roz+8VnWSBMCfRx8LOwLOo124cwuaq+P4YcpXPPC2
         hslDN2W2agMcyHKAgFPABRH7ls7wxB7Qdyfg3tyEyoUvD1wHL+IB0k7XMO2MP4adtRqV
         jwiJo3v2eXKdQkbL5rGjfkzwPlTbvzmdEm4UvElaEz20rl7Ca2GBNf/r4R6oKJKFPicl
         kHnawJ54AkLGmOq95+uuN9sB6aXFh5bQHA1GcYZQRky028qMDDsfVgxLkVRbYZvGLhxn
         qEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787173081; x=1787777881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I13XleUZppuMvfz8SUkNT1GjWZfu1XqD5Cn5w8LK/IU=;
        b=ok6MsvCvDEiLxvYMfeSyW0akP3xaPGzLQ99LOf6+xfZtJYIOGcMyziIJSYd87gUy5Y
         n1b1D1t8x4KEgBQ/k+awJCDHj4i0wdcxJdem0itZg/2mL9XKLvL6AtgFykN1wTHBgaHr
         7KGjPf8PMM+xfwEsAV+1cDGarJWCggdy04szP63Xn+CjDKoGGHd/BSb/yadb1ExWvsuj
         DjIieR3fnuZnM6yS8IWXu07ckyB72ofUuuXZP0HxqjFeJXgj76/xEROZtF/EDtmIoF5a
         vcnPMHHleeAi5lNjL+5dHzstDjj9SgZAhnrnLphhoDLXwa5wUwBFC6JGEm7O1JxHInZ6
         PG9A==
X-Forwarded-Encrypted: i=1; AHgh+Roy/nAgYYGwVO0DBiu1DIbRR1OGw9c4bGIQZof68zL/236sHRSVdkP/1BcuZPDN87qdnwZh/bJ6Trk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmxyvT50Sw53Jmzy2hSoiNs4GsejT13H2e9ekYJ1Qham/lDwW3
	cpdKi8BDjhgAkEvewCC00BvTLwLRwPd2Ogm4xtHDHz5wpTfXFdaG+xt6
X-Gm-Gg: AR+sD12SiHsMd7a7gltEI8VyXLo2LGIU44TRiiw5cK5z4Q9v1dZ8caGQWbK7km5ETZ1
	yhWeOD1hzBeSR8WSd7S8GGh/ZfJChxXW5/6OcyH9G8MwvmmAhW1NdgpMPZdldoUvpb/NJRpQfyC
	Z3hgSvuQhoQlSEk4FaFHiYHuESv5x7Js8VFYoAsr4EOoH2TFjZmNUMEGPtGfC/CihWHCBtNCbm/
	J2oZR2g/b4nuxF1T0CqNQGQknJQwLvBGW2uHYAu3BslTMez0y8gG+bXXKf9EpAJGCABBjt3gDlt
	SMMYxURe9w0Bfe4zhIaj8m2El3pkXmfGqpZcBmLh0mUNhsWhQGgCHAMat+C3fE6T1hs7y4+4V8t
	h3Oi7nEuxm9cXOivzNml1Jq4frJwTJ//YKCSsFV5j5N+QoLg0/6HiUAdCSmwcY5p/b55ZTypBPS
	5L4ISSXgduDjTD+cb0CKqC1wqG6xQp8cu7DxNnp/vt8VBz9vUwWGajWHHGqG5h+RtX9w64KwUXC
	sj+iejFK1VCaSoDyyaXrBOJnsJW4BHkQStgjHkW2sCsAp0o/WkktXU=
X-Received: by 2002:a05:6102:191a:b0:778:5579:c662 with SMTP id ada2fe7eead31-7785579c755mr1511551137.9.1787173081540;
        Wed, 19 Aug 2026 13:58:01 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:3443:53b2:2e07:b3bf])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777ddc844besm3616259137.11.2026.08.19.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:58:00 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matt@ranostay.sg
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] iio: proximity: move LIDAR-Lite out of trivial-devices and add Garmin fallback
Date: Wed, 19 Aug 2026 17:55:16 -0300
Message-ID: <20260819205751.166030-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the LIDAR-Lite v2 binding out of trivial-devices
into a dedicated schema, documenting the power-enable, power-supply
and status-output interrupt properties that trivial-devices.yaml has
no way to express.

It then adds the Garmin LIDAR-Lite v3 as a fallback compatible in a
separate patch, since it is pin-compatible with the v2 and already
matched by the driver, so no driver changes are needed.
---
Changelog:
v6: updated Matt's email; update commit msg from patch 2;
added myself as a second maintainer as suggested; collected
Acked-by from Matt (patch 1) and Acked-by/Reviewed-by from Krzysztof;
v5: https://lore.kernel.org/all/20260810192131.153495-1-rodrigo.gobbi.7@gmail.com/
v4: https://lore.kernel.org/all/20260714215433.41259-1-rodrigo.gobbi.7@gmail.com/
v3: https://lore.kernel.org/all/20251102221643.9966-1-rodrigo.gobbi.7@gmail.com/
v2: https://lore.kernel.org/all/20250801224112.135918-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/
---
Rodrigo Gobbi (2):
  dt-bindings: iio: proximity: move LIDAR-Lite v2 out of trivial-devices
  dt-bindings: iio: proximity: document LIDAR-Lite v3 fallback
    compatible

 .../proximity/pulsedlight,lidar-lite-v2.yaml  | 71 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

-- 
2.48.1

