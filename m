Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794645515;
	b=iy6PXErrBzW19AuWNTd1gc1VrigOZ4eCe5gr7gHzItNYg7UdwOmV5DNhtptK6D9I0/R+
	 UIp9VcMa8xd+9jr92JOJU7ehw9eYbf5oQtKDgpKMe/a7QMp6fp8u2Kk3gxIKI9aKHlLhL
	 K2VhkbZKWCMK6ek06kJ5+LlCsv0rJLcXAgV5HTYWA/wUEqWSP0NX8TDBmWRiHMNHbvfci
	 J4MHeKpK7Z6uvhqzAD6LqdPzhCFE7Ux+77o35wO1Apw+RgiKgQ8XBSbl4d03zCWHhGqvJ
	 kj8bqLrOhEDTC+sSxg6Fi2AifZJlphtGukbtxBoyb78XI7EPxbFAWA95odO3WvjgoSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794645515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YYFVJGGbyI9lOzoIR2dS97Q3Ec0TWi5IYxjDhkHBa8U=;
	b=ssMldF0MuiCn0G1Zk3kK0aPUhEdS9GFA1ENAZeK/1+JF8bSAKmafXDZf9Hcf91M/4oYM
	 YP0yOrWn5JBGQaAesB3PW4smLVCRj2AIUMIQQzDMfmqgMeJLomjBq0LOBn3Q7fFECwGeR
	 0/en+KfHMNjS7JS13H2UCfctslD6bJLuLU92VCwbMJEwLLG3QqiAzIRF1Fftxcikck4vQ
	 c2WrmfDB+fqqUHvHv1Apy34aFgBDjOu7CaahiqE1cE8HXKkB0SFWbRGSA21+wLY/xihxL
	 TT0FmWM5ebirKaO2NIk5QjNfmwvUmkQmZnS4u1pRrjd8Y7HQQNyYLRFtddoFj7ssD9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJvV71qL;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827E606A887
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 08:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6827E606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJvV71qL
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c08539c827so1680144e87.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 00:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794645514; x=1795250314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YYFVJGGbyI9lOzoIR2dS97Q3Ec0TWi5IYxjDhkHBa8U=;
        b=RJvV71qLB4A5+TxPVIrOLati6BchBPyqQWwB81OvQdBLtvmVhWmZbposYFQ3X0KQwQ
         ikbJOPNhi+fmRKqb8dxHA2mkFMXyRjVqBlz/6Xn5CEUJqPwXT4kf6N+R2gj4A8aBMVB6
         YrEMvRdiPrvdWeesu775bVTSSEfISf2wFjFFMecE8Ty4W7Bx1SBRCD7tB5NcLihcI0Qo
         /qxqsnsiQ+fid9GjsApiF0LJYm5u4B0MTe9zUGHecVbqVmiMZx9eYu1oKcNtk6hh94+3
         BBUlgxVn1aU1CI4P8qXE3hOc4H7extgTx6/uW4btcz6fJT/6qdTSi/rH6+gxFUmub3Tf
         69Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794645514; x=1795250314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYFVJGGbyI9lOzoIR2dS97Q3Ec0TWi5IYxjDhkHBa8U=;
        b=Y3DDWBblFAsTJHqj3WfnZTLFfMFXvyrOhYfnkutrj/CT0rjvCmOinG+Qr90Q2A5qET
         zvVGWKFEsTKpzaEbQF9BkI1fGLPSbcg6IKk1Lx8OtDIj8jpomNXPnMpn2uJSqEMBCS5G
         CzPHkbC6MGu27siHO9mUYq3o4UmtB8Pbif75SzUK4xO3WAk1RcscfaledoyROyBR9ETm
         /8lBjfzvPgl5tnumbnnVDGR+YpOoaO6KQ71dsZrBEbZGSBtTkk2ydySnHcrUOBhDsZsu
         Lk8dJDqZ3L65CJY0xO42uWE2umMr4a/MG352U9hRY/XAccCS6qG1R4RVjHqqzZFU+ImZ
         TEmg==
X-Forwarded-Encrypted: i=1; AL+hErGJ8EVGYvaQXYWWwN65UEsV8uKMeDQ1Z6+yz2Za2ZyKX+WqaOtWiWRZJ6e4md4RFqhql0c+qw74Qvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iMVmv9FB8ZFbi1eQ7W0MA4YILIBU69aNFOVmuo8nqtgnLs0ho
	4H2xm8W1sW9Q96Y0Mcz5fj+CNl18G8XM7R5h4x3aaFR2fE8rdQKDo35b
X-Gm-Gg: AYBFou2We2KoxhFG/DSUlItjNOpYYzL3WhDlNXC0OkcmHETNzhj9u7XZHrAzqjYChnI
	nBI2y6odqEYhoEjoF85CE8gtjDrP3xtLU10T7IyL7Ux/KLjhkh9/K8wmfk3VaYT/gf2uvKe35Ln
	FXsQIUqNwwW4g5Rgr7soyhroWRKnoiZjCx9cZrU5obRudF7EnIp9oRHdjHV3BU9nHeFnhTtfF//
	fvVdkqU6jOyyZ1yxAFA6SYhwB65Mb8lM/kIX1Gi3z2rIdoqgLe3iKUkGr5N5gSYB17TxsnLS6PG
	ltUfZphvUwEc3CO1IAuCcWh/FZCtv1M2QNSbw6cFr53okyij1DJ6zcQ8o1Xi2bjsyhV3kRWvLx1
	IY9rdkTG2dMzDQ/i0YePeivYH5VF2TUt0BqqXWMsCJlJzgaiOSnmv1zuuXnFkgtgmepnE6jsM1V
	xaT/BO/5xjr+q/6196XTQbYyxhjTs+FJZk6zPWZgrNRd8FRehy9+Zmc0Ncy5KCmgSKw0tHuIw6A
	qG4ped7akkwXXqjPZ2mGiDVldlomuLK/6Is8pGS+tHjdZ4VOYVBC7T2WZ8N3GaxI7B2hxuhYjt4
	uc0PXilYWfqATfSedpsBPPusmpqldVwcHc8dutcDfuHI8We4ieSr9kxa0oCWFWyTgof5OOgDpxc
	6BTs39YtTQBTKGNSw3IU+mz16EdM6oxt9O/yu+3rpeQ8rUGhn1S4qIDQrjD0=
X-Received: by 2002:a05:6512:401b:b0:5be:516e:5728 with SMTP id 2adb3069b0e04-5c170774474mr1723810e87.32.1794645513336;
        Sat, 14 Nov 2026 00:38:33 -0800 (PST)
Received: from yantra.. (nekmmqusxj170dz200l-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:b551:8edb:536d:8395])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1713565a6sm1527803e87.78.2026.11.14.00.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:38:32 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v2 0/2] iio: pressure: dps310: data-ready trigger
Date: Sat, 14 Nov 2026 10:38:26 +0200
Message-ID: <20261114083828.18059-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
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

DPS310 can raise an interrupt on SDO for each new result. Document it
and use it for a data-ready trigger, so triggered captures follow the
measurements and are stamped with the interrupt time.

With pressure sampled faster than temperature, scans with pressure
need the trigger handler fix [1] to keep up. Without it they come at
the temperature rate, as with any other trigger.

Tested on a DPS310 breakout (0x77) on a BeagleBone Black with SDO to a
GPIO, level-low and falling-edge, with [1] applied: one scan per result
at 1 and 8 Hz, also with the rates at 8/1 and 1/8 Hz, stamps steady to
0.2 ms. With pressure at 1 Hz and temperature at 8 Hz, one temperature
result a second comes 2.4 ms late and the stamps show it. Without an
interrupt nothing changes. Not tested: active high, which needs SDO
strapped low (0x76), and ZTS8032.

If the chip stalls, the case the timeout reset is for, the trigger stops
firing until the buffer is disabled and a read resets the chip.

v2:
- interrupt on temperature results when pressure is not in the scan,
  so a temperature only scan no longer waits in the handler
- limit the trigger to this device, as the interrupt depends on its scan
- local regmap pointer in set_state and probe (Andy)
- rebase on iio/testing

v1: https://lore.kernel.org/linux-iio/20261110154254.39092-1-zoone.rupert@gmail.com/
[1] https://lore.kernel.org/linux-iio/20261113230241.82046-1-zoone.rupert@gmail.com/

Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Rupesh Majhi (2):
  dt-bindings: iio: pressure: infineon,dps310: Add interrupts
  iio: pressure: dps310: add a data-ready trigger

 .../iio/pressure/infineon,dps310.yaml         |  10 ++
 drivers/iio/pressure/dps310.c                 | 139 +++++++++++++++++-
 2 files changed, 145 insertions(+), 4 deletions(-)


base-commit: 7c054db85b5a3ce4d5465cc5cc682cc44ae9eabd
-- 
2.43.0

