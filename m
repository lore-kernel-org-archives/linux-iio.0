Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1683F23B5
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814853; cv=none; b=sXKpwxQwydbNBB45ttqgls4zl6RdNVDEd8XCSpX90z7k7vZBdOHNA2S0yvMO74cJOJOPIsYeXqo1HfUgmbN/7f0OZ/fARuJo0BAcD/Bl9uBNVlVYNZLJ/vKIP+TeEkRmF43nd1mMa0WhVamnrEaXvj2g4BxpjvDNGWplJB9ORUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814853; c=relaxed/simple;
	bh=R3zDQ8xU2MgwP232Uwo0QTMTrPn5Pt9Q7i4NRM7VQOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ic6/aDSx/ireFPHqSp86VKu3ih2hHb9I6vpb/6hXAbBXFOAMLoeWcUTArRNbFbz4yJjEFxPW0zH22+dT4jPgWzBDcKvkllWv6OAMTzstcwFlK+zcre20VhDhX9QJM3t1sv37O4oMvZid1g+QZmDOLkCy0eSU/aJtfq7sWbDFDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pBGcwyHA; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBGcwyHA"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66f883abfdcso3214328d50.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788814850; x=1789419650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gojEDyDfYLvhRqOvL4tTAlYlPBK48sUhaWTtz7U0ImA=;
        b=pBGcwyHAElwUxdB0iRO9SdrGc43rjWWzkAwp6COw1rSbh8yOMphL9Fz6CHqfW+tk5G
         fXnUmqiQUjHqlqiZ7OoslBkCxEVQrQ65zCNV1PebGTZvya3uC3kvJFLjo+g+3badfj/Y
         6ozzfIFAN1qlqaDeX9TBVH+QuRAf5NpuIx/lnBzKrvKiJuKxOWlsvm1ekLtPiQ7brRRW
         FlPt/gSK6KeAUQSOhmxHLooNlAYQbS3U6+Ew5kHJdbLuNiL3jgcb0SbPEt/7KNUnRdUS
         54bhety5s+1wF2wQ5mHqJ5i34Qzytg7UuOWWGqBJwq0IQeS8B3HQq6h0WjrNI1uJiVLI
         zgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814850; x=1789419650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gojEDyDfYLvhRqOvL4tTAlYlPBK48sUhaWTtz7U0ImA=;
        b=JdmHLxIvtW8Dif42HHHB9GCejk3grb9KSRxUAevW5Gfq0IOASq/DoZN/eUA3FVoM3m
         TkFdqpNUotYg0pH29Nl5Xphku+ZCUausvewhlY6RGTWLS7WzgLkURTwtsLg8On5Jq433
         EC5cCa9JGiczVp0g9hYnOWJBy3PqQIly0E+QzQ86L77edZk3ShjnvoxJPv+AT1Pfhvg9
         GyHtlKXdBHVcYFNho5EMseKPgHhl7qW9yICGN2CKqQGvBJcOv4Xx4w5wm7MjPnjSn3Xw
         2OVQ2EOkcS3pDrBOVnJoUX+RamakBN2KNnTx/2/mSYA5j6myCZabOtF48K6inw73oXZz
         tqIA==
X-Forwarded-Encrypted: i=1; AKwUvByl9QTDG9k/k3IBNQg6aI2dVTIrWuahtyx7peCzJe00inf8T2b1s1zziEa2VHthpZSCRAbJaiq7VYc=@vger.kernel.org
X-Gm-Message-State: AFuF++kKcWhuW44aSHAHlQ6rZPtFsLIaWWaCdnJy4NyBbz+g8mszbYOE
	Mn6bcSmgcxeHFs7l2QWkvGSoZ/Fr1iI2gfJHef6n+ya2hSk3vLWEmkD+3ARN/+YXRoo=
X-Gm-Gg: AYBFou3Fro4mVIBMAU2XbauJ8rqB6vQ1syg/9VVkBOmDZDg1IpNxG2UtJEBEKGaf8Kx
	hFKmvn2he88At/6ZrqbqBp1P2RrW+Ib+DHTbEVyP4whsM6k++8mKS9pRpXn0m97hpJmkfgTFis4
	gi9V9LlG3PDOGmF2AL8SRFOMZKCBq2U8N8Uh9KGMw32Ll00oVqzWPZqBnFnggxVktWKwOSjnpC+
	dLgbuLm5cJWiD/qssvwBrbWdOLMYMf3vnFu61S6GrcApKFDBozGS7QVlBRdCEpHH9xcm0FwEnrK
	HEK8H/XM9LbaYAxNdaaVn6bhQk90xl9ivyHqj/u2uHNHd59ixVDUma/5ouH3CtCCK+J5bqLs3uQ
	B3C3PfI0eQApu7Dm7GJdC+jg8L9A5rWzlJSW/6NZkOFbawISff66ErVhuqqLsbS3wHhB5d/FvGt
	K5aTkXNOHgwMQgy/l5oWN7bQAc6ZJ4sMJ7EweOQ/rCToo=
X-Received: by 2002:a05:690e:b42:b0:66f:c1bc:4022 with SMTP id 956f58d0204a3-66fc1bc4989mr4613793d50.79.1788814849738;
        Mon, 07 Sep 2026 14:00:49 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8894sm8855998d50.1.2026.09.07.14.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:49 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: [PATCH v2 0/2] Add support for AS7343 multi-spectral sensor
Date: Mon,  7 Sep 2026 14:00:40 -0700
Message-ID: <20260907210042.32552-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds initial support for the AMS AS7343 14-channel
multi-spectral sensor.

The sensor has 14 optical channels (11 visible + NIR + clear +
flicker) in total. This initial driver supports reading raw counts
from all 12 spectral channels (11 visible + NIR) via sysfs and basic
power management.

Not yet supported:
- Configurable integration time and gain
- Interrupt support
- Clear (VIS) channel and flicker detection

Patch 1 adds device tree bindings.
Patch 2 adds the driver.

Testing was performed on a Raspberry Pi 4.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf

Changes in v2:
  - Add the LDR, the interrupt pin, and the GPIO pin to the dt bindings.
  - Adjust the default gain to x256 and integration time to 50.1ms as
  recommended by the datasheet.
  - Use read_label instead of .extend
  - Remove all unused scan_index related constants.

Chang Yu (2):
  dt-bindings: iio: light: add as7343
  iio: light: add AS7343 multi-spectral sensor driver

 .../bindings/iio/light/ams,as7343.yaml        |  69 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/as7343.c                    | 372 ++++++++++++++++++
 5 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
 create mode 100644 drivers/iio/light/as7343.c

-- 
2.55.0

