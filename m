Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463387;
	b=y/Py8lLAXILWBkgmPSzoJfLc1HvMF30OOoAQGIGuiTtY6XkiBzl5nwz6HjkPH6zTjenU
	 Lqti8SgWpIshKUl0oZSBqqirFUWnz2Mzqc7Y8iUokvJ/Q8JVYVCXxPJS5LO+F+VD8bX4j
	 0URYSyLXCSGkMQEPjz34ORaV4Kig1rpMqab9y7QRp8gY50RkIuDJ3MIAG7KAUkS2oL7aB
	 U6t4EXhRBnDzNt0GdvQYNpf+QaQgWLgvolMvYO+Lrm2ABE73JZ7zqSc1o5x7iyWmEUbik
	 0cGSAXPCCy+ciIvgYQIyZMgszdAFBXKpk15pCFuajmMEhhq6jRVoaI4kMY5RdGeHW/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hsLJ3XQTap9R7Gjdm3eQnj+kLtAheZctWZoqset7KZs=;
	b=roOlJft5V4x/7+6TUV/GikD0yTdJV1UQQnwqXKcoBuGlk6uyRfbW4jDVDYaoz3xIWHoP
	 k7EvOfGpjvMlVqx90EbIY1BmyUuilUgh4CpO7kiQ1ZSOv2PHhh2VTLIdvBbaLLS73jyCw
	 VWzQiggF5zvPtXE3OW3Cg6OI5Wlt/KM+a5ttnwUzOEfN9kHx+OEjOTX2It+NoJ0sI+llF
	 0h4Z8ylhrLrBh+hkRbaOQvEnm05BCk59bjymn294CG0ts3S8ppNnek3a2EI6sK8+lOTPa
	 TjVs6qLcM7qYZo7xEqyGYI+6rlDZplPo2yZN/ZOG5qlwJi7KWT85bboBldTq6F2NExA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l8xQeIIz;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F592606A33F
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 19:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F592606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l8xQeIIz
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso27815665e9.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795463385; x=1796068185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hsLJ3XQTap9R7Gjdm3eQnj+kLtAheZctWZoqset7KZs=;
        b=l8xQeIIzFArZziZL+1bnVi2o7RS9MXn8eXCWEYC4mE8UL1BZ8z45IrMTvhXnCeq6nt
         16zDktO2aX01T3gIMZKzyCez7IqB/NQ00ssGkXIR3EWqR5XZjlcOFWQCzD/cZCcw3qMG
         Pynk8hoPH8X2eB5clmZcV8OIUmnpsXH+6QLgzYx5DnQpYEDIcBZIUCUBE2DWiGzzcypG
         xM5lqVzbxdtqoYQupqAM3cpTSXouyn/pA9FtBohKx5/CQmCOboICji422c8jpcH935RE
         PwUJ9W9S4Pg/NUwlJEkfYi1EAJ9XTLeSM5ZXXsLKfhXiiUVOeDUPC7FjYxFPxZCbJf/l
         bxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463385; x=1796068185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hsLJ3XQTap9R7Gjdm3eQnj+kLtAheZctWZoqset7KZs=;
        b=T/XWyAIbSfVx52t/75VslGUAOXNhh6/uTxxjg1DQlB+fdy7qfn2gJfVa7SbEpVOVxs
         1jQn1iOqKNqChLoLSMUUBsp7+P34KCiQwVPuK4V/BEWdWM2VKBpRRBkXWF8lYe/jM37J
         DJ98+ZP0B5nPsFxPosSoTMW0P6wbR9yzRbtk5wnyb3IVf4EsIUlc1/z9dQZFbSWSdvRD
         V0OCqCJfGNYicf7aeSa/MnQm4OXbtRjXfL7TLxAUhAGhNqNmD1pwBH2LPlYNUtEmURf7
         H4skdfXk+v7M1Zlv7WiRs9Lblt6k41MHWuOBSc13sgsWzyAw1MqRo/no2ZIOiQt2PD6y
         zM0Q==
X-Forwarded-Encrypted: i=1; AL+hErGuDGtu7peozsqTVjUxQNe67/lYX8KOuLy76T+HFHkC+mfz/440KxHYcOPg7/Q61Jh3FC6hPaa/Svs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Acu+9XIxgB1yjgygUxTSj+CNsnHptZO1a/mKF0CDLdwrWcM04
	fQm9L/sxyEAbglaJj4vrrqBSN5AHt7T45ZG2RTbToRX5GZSxp9eMHVu2S50xVFdaqH8=
X-Gm-Gg: AZFdTZdmoj+2G0GIaxzRTwsE9xfewxidt51YaFl+G3dmpfqT+jdNY5wHyGWgakNLBW6
	cqKb5fygzYD8y6D2+qTUTyEe90jlRak5gqlV8vHc7aqSeAvS9aWnGeHTLWQaoYib4vd9rIniwNw
	BXKaqmCr2Tz9OEh2EQwjdQTr2X2gQGcDmIuuCKuuWJpBHiGekepDBzH+FazVqVcUu4n/MuJELa9
	1YhTEJy3D1O2Js5F9szu5H8RclBSND5zDNmL0ffa8PxFXcuyKvlvH22x0BeuzHhEMFMnrAC1cKt
	6BvwDfpwmPMhZlft0eBOLM88nQVATSDpWLTEzKSqYc2FtMJ9k/kAKKLVp4iUGlMisG8g1GWWQwS
	6NpIrjLypq4b8FTu2f4CuoWfCzMPUb+WFSP7uthsuzti0L7hIN7JsHFvLKGaAH6R4oscz7Xx6rk
	dwobwn4ix3LMbCL80UT55IK4gM1lnqv0sy+VNEvNfgKyvH7jxnYmuZQD2BB+zQeLFCipBgqycKi
	JsbA9MOWI7RDM8vdOz1xlNqhvPMyvzVEaO9o5w+JKrIXzzc9fke7IKBO8txa9itpzP49IErHs9s
	bCme67CHPNvaOgksKcOoc1WF4QybjaXhxCoLw1dHN9RZ99hQsl/5174/4PkYgG+foCHSTBdT5VY
	MfJMwXEvqAL+K
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr263589535e9.34.1795463385304;
        Mon, 23 Nov 2026 11:49:45 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm300924125e9.2.2026.11.23.11.49.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 11:49:45 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] iio: magnetometer: mmc5633: Binding, supply and mount matrix
Date: Mon, 23 Nov 2026 20:49:39 +0100
Message-ID: <20261123194943.57601-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMC5603 and MMC5633 are listed in trivial-devices.yaml, but boards
need to describe their supply and orientation. Patch 1 gives them a
binding of their own. These bindings are also used by PebbleOS, which
is where the need came from.

Patches 2 to 4 add the matching support to the driver. I have no board
running Linux with these sensors, so they are only compile tested (W=1);
feel free to take only patch 1 if you prefer.

Changes in v3:
- Reference the datasheet timings tOp and tSR in comments, with the
  tSR one in a new patch 2 (Jonathan)

Changes in v2:
- Cover the MMC5633 too, including its I3C connection (Jonathan)
- Add supply and mount matrix support to the driver (Jonathan)
- Drop the mention of the missing I/O supply (Jonathan)

v2: https://lore.kernel.org/all/20261122190836.66111-1-gerard@teslabs.com/
v1: https://lore.kernel.org/all/20261122093412.71604-1-gerard@teslabs.com/

Gerard Marull-Paretas (4):
  dt-bindings: iio: magnetometer: Add MEMSIC MMC5603 and MMC5633
  iio: magnetometer: mmc5633: Reference the datasheet for the SET/RESET
    wait
  iio: magnetometer: mmc5633: Enable the VDD supply
  iio: magnetometer: mmc5633: Add mount matrix support

 .../iio/magnetometer/memsic,mmc5633.yaml      | 61 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 --
 drivers/iio/magnetometer/mmc5633.c            | 30 +++++++++
 3 files changed, 91 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml


base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.45.2

