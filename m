Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106343991D
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223373; cv=none; b=qvcuQh9yBjH4GFOH03qBSO9I/hkIn3dl5o9VyYhNe+/pYHjXQp9+8Somma2ryTjXbRjD/m5ueBMLcy1o+hmyCEHJoDFoPdDyn4zW7anoFi9nyVeCLsl6Re1NZhEoK99jNJPOED9Hp59zGLiFe8EbyxTCZvtWRPYptlfSRc4oHlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223373; c=relaxed/simple;
	bh=0/os3UGGr9jC5LqbcRUq37OjhSoeK8XI8arvuQdhT5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kAxy3e+UAUiOG4/KA5lSvSmG7B/LjLfGg9MUZhdexHsz0WXyd8XuRGOQ+lPewB7zOjwljKRoRQ0ra7nO9rW17KLvGQaLZu1XdXQir56vdlRKaAOk3AV/uAAPSr/0SxC0Iy87no7RmC3NJyOlCGcBGiKgY0kxFh3GkonOW7Cb01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PedmUxj5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PedmUxj5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493f60208a5so57548585e9.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223370; x=1784828170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9gGq/+o/q+CruwAzUVUDhA87sfX1odFD/Lak8PZz2Xs=;
        b=PedmUxj5u+h9WgdMpdWyL+A/72DdubHMFWVdwUJL1FDeDAEnCkSOUvZ/IlkIvdyj8E
         41BiQFcqwpDa0kaPweXbmP3H86ROyGmxgubYH3PgXmNN69kHlMp5AdcqM1+5wBU2gn78
         S/PFh4pF+qHSHaQdLT+ytJIHVJjd8VFwrg2oPX1+xC9RnbOL67c9+iRrfzwcb06lHUOa
         yWnmK9fFqUUIK85+nxA67ZCBSJcwP9/g3wyp3giSggR/4DYAYZdmJ/p/XXSMlzqSL3ws
         LJQ195OcNxy2YYo95UcxB+A+9hBGkLGLttLWSWV9b/EtaIkQuIDa76s7h54ZCD1ZjxD8
         P6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223370; x=1784828170;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9gGq/+o/q+CruwAzUVUDhA87sfX1odFD/Lak8PZz2Xs=;
        b=bCOHECjn0BBtsS8aE1zp3qxdNLE5GN2Z/SbQ3XhOagV+aC/PABjeGaYOV4fB0cJQzw
         kZ0YD1fXMAFwZ5Dyi1wLyiDuFmiY1ta5eK3I0bHXpUQ4flaTkFSDKdEpTPNHTR86lwm/
         SkMzRiR1WDtz09YUpzbf1W3v3fm/n7eL3DIkZyuqMxqrmnMcQcdq70D+a6WQ9cFrIbEp
         P0Trw8L80abo0D7QgM95QmQfUKr83WYcrkmoVRIlvIXdylUe9L2HOvYRBoXRhsEN077j
         tIPZIHp3adsrQ18pX9racVVGCxYRha47qSi2SikLe9qhJr5FMEdRCuTmyvVbz9jX7wFt
         CzKA==
X-Forwarded-Encrypted: i=1; AHgh+RoVQIHESyx5ZZOtScR2AUqZIT4TVCfTa3lELOEf7tI7leBKWZB+NOSAT4kqiTWgBfNbVfme4RTFoow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4qCcesdOpU41X/WMxNQtk7nGiJr9Z/Zfe4VmbY5XI0nKGph1
	0pvjLDMn7TmAJfwP0LhJpURaIR7sEJYuE/gqjx+NXVCyJju2LjPMxA9q
X-Gm-Gg: AfdE7cn9YheNdR+iUWKnMy+00cbiOOetMwR39FVV+/vcnfG5FFPDoHDg9boWgEJK/Ta
	wvLkPb7WspVN+Wxap7fgQGD9XIc7wvJqlCzzRJWtpCzWcHaHH2QNXxsMIVQqwxRKu4LRwSEBswK
	VISPQMiAwQ1y0+G7wnjKfPK8+23DBc5OThbdqjoL/iMHirJkTOiwlIDmkvJ7Y9Qot4lkVkxw1s9
	d/NhQDiDvBdvOJO3/SyDm218GbbQ7A5G8ov0wSXDuVjDrY+sR9NV+2W7siXIQQNhQx97QuauVIc
	J+9IuhEll2gZ/Vv/86qTtqqD2XVoh6t/RFVb3wu5m8FYEaE2amQ+aZ95c6M+YTqu5kPukHDg/ot
	qW0Q51bPgj/9HWN8S7DEaqfu1gwPCzrjxCW0RAoWnMqRiPIAhsaI7Bn6pzHue8Flcay6tbvJ2CG
	gP0Vilo5zagxmBoWqZW1kzUFssHzGx1u9N2M8JKs5qWd6jE/kjJOSV80DDUmFfsK1duFA=
X-Received: by 2002:a05:600c:4e93:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4953c286bbemr95377425e9.26.1784223370131;
        Thu, 16 Jul 2026 10:36:10 -0700 (PDT)
Received: from izzolab.play.pl (77-236-3-190.static.play.pl. [77.236.3.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954812f0d0sm7983005e9.12.2026.07.16.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:36:09 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Wi=C5=9Bniewski?= <pawel.wis.me@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] iio: proximity: Add Cytron HC-SR04 support
Date: Thu, 16 Jul 2026 19:35:53 +0200
Message-ID: <cover.1784221074.git.pawel.wis.me@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Device Tree binding and driver match support for the Cytron
HC-SR04 ultrasonic distance sensor.

The HC-SR04 uses separate trigger and echo GPIOs. A trigger pulse of
at least 10 us starts a measurement, and the echo pulse width reports
the ultrasonic round-trip time. This matches the protocol already
implemented by the SRF04 IIO driver.

The series adds the Cytron vendor prefix, documents the
cytron,hc-sr04 compatible, and uses the existing SRF04 configuration
in the driver.

The Cytron vendor attribution is based on the HC-SR04 Product User's
Manual V1.0 supplied by the retailer. The manual was prepared by
Cytron Technologies Sdn. Bhd. and contains Cytron warranty and
support information.

This is sent as an RFC because the vendor attribution and compatible
name should be reviewed.

Testing:
- make dt_binding_check: PASS
- srf04 module build: PASS
- Tested on Raspberry Pi 3 Model B+
- Kernel: 6.18.34+rpt-rpi-v8
- Device instantiated using only cytron,hc-sr04
- Trigger connected to GPIO17
- Echo connected to GPIO27 through a 5 V to 3.3 V resistor divider
- Driver bound and registered an IIO device
- in_distance_raw returned changing distance readings

Paweł Wiśniewski (3):
  dt-bindings: vendor-prefixes: Add Cytron Technologies
  dt-bindings: iio: proximity: Add Cytron HC-SR04
  iio: proximity: srf04: Add Cytron HC-SR04 support

 .../devicetree/bindings/iio/proximity/devantech-srf04.yaml   | 5 ++++-
 Documentation/devicetree/bindings/vendor-prefixes.yaml       | 2 ++
 drivers/iio/proximity/Kconfig                                | 1 +
 drivers/iio/proximity/srf04.c                                | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)


base-commit: 37e2f878a7a660a216cc7a60459995fefd150f25
-- 
2.47.3

