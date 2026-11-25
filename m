Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638154;
	b=Q3b7foQdsP8vQuhPqm7vLARxG2PqNeU8o8sioR+0cKHE6Pv6P51WL9ceRrdiHq+nOtSB
	 Z1hspiN3hdOSybasF1SRTuYZ+xSJ0EuB/xBW3QS0L0PyAVXHHPjIJdGXbX0IFiW1lxB7O
	 YXk/YNzs+CigKZxwNqh1Ef9aDPFvM9JAHQt8kbpok+MHO6CCV2lUvxqJvrTvf4Nmfz+dU
	 1NUya/NdbtH+MYovxrg2g8J6XIZWjARAsf+VqWNqUlh3IaVzcvDOEQaGbF34RMZyo/Rjd
	 2afIOZkxqajFdt/dTEz7ufyx6KRpRtquJIbEBhJgyVLvMlG21jxvJOAd013PGB+/Uhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638154;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=Lb2D2tWbP9xpFGNwCPYhXighNPd8wZ8FSIPXRSIeOMM=;
	b=1PQQr72Q4CHyGFGWy3oxhY5SF9vc1+49uFc3qFwmASxeYnG3+alGVhueNe7BLJbLSXMk
	 585iJr4YrpaWeb0yDtoCI14bzCVIHE+0JJ3QgzT7P1hXzvqjxv6rsBA10MYE3NAeUo7F2
	 6qeGhFs8FW1Xv+ihCJ1SGsKVjxJAHXVRkjygbZ/DdOYWwAATOoRw9/8H2KTnUuNmfaBwM
	 FW6kPoqyYluksJwOKmS8Vim4gayzDgF5IgoXQ6G4aHCZaOtpMAtBuMV/ErnggBtXTQCg2
	 AYjgF3W9lrOEfy3wRAaEvmz0Bb6tLSnOYZIMuY1GtnDxyySlvLZ8fkVL1iwVVkjeLJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56430606A323
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56430606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0d126f631so55094817b3.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 12:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638153; x=1796242953;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lb2D2tWbP9xpFGNwCPYhXighNPd8wZ8FSIPXRSIeOMM=;
        b=VlCB+KGAjrkDHhRkMlqAkiyI7hXBSMGJKwapZOFnRLxRFGkWvLUNeTaUFVX+tTQW02
         4hNDr5uBdnu8x9T6ae4wWRmaUK1xWjba+LUx/7Eh8V8IiYlXWk824nybASaZZ53SfoDo
         kQuFTyGKU4UylVO5ArQMj6ZThe3ic5kxUH0+wQ3jCXKM9gK0sv3H1WG6Eqd2hKwU7nTG
         sDZKaAyvvWvPuheJroOlJ+nEp15mlT3+b6J7T7wwyTvrZ+1EA+ba9+tb7TTLzjMjNZm7
         EvQvL0SVzroK0d2u4pzHpIHQ8T17tTB72X+1Tmizh0VHy1/PMVHJIcuKQpaia4fAL06G
         Fpmg==
X-Gm-Message-State: APuU4Z+7BdgLTfS/FKTcY5moZvCusPuN7BQGNFl2pZO16AXAoQ74ylXX
	K5nvBkY4BMHmoW7vllEg5GQKifpERzatfrXOw2EvPXzrKkmnX8nVvcj8
X-Gm-Gg: AZFdTZfujarOufCM+JJ6FThiy47YkDr9rBBxJMXfbJN7iit7PurSw1rmP6OnEV8336x
	5sBGnkdoHh189NahUQ5FUKzREBH03tz2ZTkSSHrAC87/Nzuk3IQiSPko6A6lvLXqYK3DwXOpdbO
	7VIGypaO2dCH7CbIYeFt6bYO15oW+X1qvS9wc9u61A18Y25LNFkGCXnMjWRwsZj5syHuJ29svou
	KAnWmFAlw6ZRPh4i1YyefTJd6t0NKDZQncDfX2PRgd4OzgPwwv9rMEIaffk0KNc+woyEAfXoK19
	WCe6GEPQpdpHMhyzzpg/9Z2SEkFkb26PgEIqaLwrp5Yris1YKAv+ICMtIogW022T71a7ZfUYgcv
	G19SlJHb919rdN4aV5YIjN4rfvq2tVnFE/jYCkoCRPep2jPd7mEQekACZ3tD9r7ToneBzkQJKPt
	Agd1oIuwEcrjxAgPTaN++4X6fpuJ8fJpJcppoLXvlXf8y9DzT3MYl7TIQkOQ4TgZEDOWAXSvfCR
	dpebheCyqTFRCwBI0onQL2f0/x7zARB1tdLWpPYaE0uohDfkge/Fr7hdDZXAOx4xS8OxhwVdjV4
	vHbDZSiVfOVQqGWHe2ByjjUlkNOjhMtRmGr8GdW6B0Tc+VoRKDtVz23t1mxXvlEdmPagC8rLZTB
	q8msNzOwTAug1stk0g1xC14FcBJPBJx7zk5vyfZRwqxm604Nyf6DGD7AULs6Kgkvk8+2aIPUHlt
	u7NX6xTvV+AIqLMzxXzB5psNIu
X-Received: by 2002:a05:690c:9a09:b0:8b4:c2c4:bda1 with SMTP id 00721157ae682-8b5205201d7mr81799737b3.67.1795638153094;
        Wed, 25 Nov 2026 12:22:33 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201bb6c7sm77074377b3.6.2026.11.25.12.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:22:32 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH v2 0/6] iio: potentiometer: mcp4018: Add Analog Devices
 AD5246
Date: Wed, 25 Nov 2026 15:22:27 -0500
Message-Id: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/22Nyw7CIBBFf6WZtRhAhMaV/2G64DG1o6Y1gETT8
 O+2devyJOeeO0PCSJjg1MwQsVCiaVxA7hrwgx2vyCgsDJJLLYTQjGhiNhyl0qwN6mCMkK1RBpb
 BM2JP7y126X6cXu6GPq+F1Rgo5Sl+trciVu9vuAjGGfbaGc91UI6fMz6sve8DFuhqrV+fS/jft
 wAAAA==
X-Change-ID: 20261116-iio-ad5246-8d4377128747
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0

The AD5246 is a 128-position I2C rheostat that speaks the MCP4017/18/19
protocol. This series adds it to the mcp4018 driver, so it can be an IIO
channel provider for an in-kernel consumer.

Patch 1 moves the out_resistance*_raw_available ABI to the generic file,
patch 2 reports the wiper range, patch 3 adds the binding, patch 4 turns
on the vdd supply, patch 5 moves the scale divisor into the per-part
config, and patch 6 adds the parts.

---
Changes in v2:
- 1/6: keep the moved entry's Date: line (Andy).
- 2/6: include <linux/array_size.h> and <linux/bits.h> (Andy).
- 3/6: rename the binding to adi,ad5246-005.yaml and say in the commit
  message why there is no fallback (Conor).
- 4/6: include <linux/dev_printk.h> (Andy).
- 5/6: new, split out of v1 5/5: the scale divisor, now unsigned, moves
  into the per-part config (Andy).
- 6/6: name the driver for the MCP4018 and compatible parts, list-style
  Kconfig help, AD5246 sorted first (Andy).
- Link to v1: https://patch.msgid.link/20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev

---
Joseph Telaak (6):
      iio: ABI: Move out_resistance_raw_available to sysfs-bus-iio
      iio: potentiometer: mcp4018: Report the available wiper positions
      dt-bindings: iio: potentiometer: Add Analog Devices AD5246
      iio: potentiometer: mcp4018: Turn on the vdd supply
      iio: potentiometer: mcp4018: Move the scale divisor into the per-part config
      iio: potentiometer: mcp4018: Add Analog Devices AD5246

 Documentation/ABI/testing/sysfs-bus-iio            | 10 ++++
 .../testing/sysfs-bus-iio-potentiometer-mcp4531    |  8 ---
 .../bindings/iio/potentiometer/adi,ad5246-005.yaml | 54 ++++++++++++++++++
 MAINTAINERS                                        |  2 +-
 drivers/iio/potentiometer/Kconfig                  | 10 ++--
 drivers/iio/potentiometer/mcp4018.c                | 65 +++++++++++++++++++---
 6 files changed, 129 insertions(+), 20 deletions(-)
---
base-commit: f2cbef9101b9fc979a324bb1242b8b802a2484b6
change-id: 20261116-iio-ad5246-8d4377128747

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>

