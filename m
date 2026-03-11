Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983B324707
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193395; cv=none; b=F+vYhmcPLERJZfS1sd0HsQQVEHz7eXSBoDKPg0lAVIzDvN88zejFbBVZuNThjZiM5fYt7h+PMrTZAhzY7nGyGqDDx69diXFTSvHfLM8n2yFf2cnD0c6jgT/rgjh5177gT+j2G1BTD9F+NErz5A3Gz2ZiURJ+cXaBC2TC7NM/DWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193395; c=relaxed/simple;
	bh=9LUdXfBARsaa5aGSj+H1I2RjRXfeuEeD4z57PoMbr/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nq/e3PR0zTpu8A3jQgtb+JtP8+XwZpM3KOp+MxGhU16vq8VZNhooV4Z2qvVi5F45Yf027GodVwxTyHOsTRTCZiq9d6CJVaBb+kb0u57wlirboATXekcdcLDdPYjp68ul0BGDH8tcK4q2W9M/oApFnySsijMIXcmTpxTO7IKRl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+HUCLZ3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+HUCLZ3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab46931cf1so3776945ad.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773193394; x=1773798194; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SsEmlKrghwdfIHl/EnFksbvwKHzbziypfGsIUQMGG08=;
        b=X+HUCLZ3YgoDkSkNs0y35ZlKKa4ubnWe8Ba6Wn4ekeJ2qh4agm7o8tr8jmSCc3wmwT
         F1ZzCjWag5oJLasRxaadL51H5wID3oLjCWlsQqRmdbJnthK/Y7UDen2J0gmnSsEqQWMt
         AL1EDuxKqUDbeJFlSNYk+XiPTxt09BisFWnh8YsnfnDEMc4yRKc/as3V1NdjGdwL6MZD
         V9Q8E92uCowAA0rWI/6RN7WMcQzVzLHPS/PU+vkwJ0ATLdHiPbFvvkbVrbMmbaJMDmQc
         2Et5CDoaJuGM4N8ckQ8vFHJp4S+yI2vSOPzH/vB6hzJ4qRwWg8zpRWVTHZfjGhI84sU9
         nh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773193394; x=1773798194;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsEmlKrghwdfIHl/EnFksbvwKHzbziypfGsIUQMGG08=;
        b=K6qE8YOETn7A9QrO01amAFVfpb3pt9ClcKLoaePrP/VaPFSdwLx6xUjWEBbclH7YgV
         8tqKx2XFUb4kj+/fdLV4GyaaGwO0b6N3ihTRhoUKJa6nExCpk9t1MZ1Wls5lP2zmWIng
         CFORJbvBaZ1vuzc26vBrpAB8QTr3EtaEDVDMOCnMfUyiN/56R+aOJZ2hvkHHs5iMXZoW
         TMjtn+i4HB4+PGbCHHvXRMDBP0SQeOPn42y0g5KcAjX00WjjwBWgG1BqGGx2YEo7q323
         RuaoW2KA37NBVKNZLkLNKzyn6FIydCSj848ZjYkJgSef7r4ewPexApD9Vnzlz0xy5FcE
         YlJA==
X-Forwarded-Encrypted: i=1; AJvYcCUOCGZ6UQeDpALO7O4yvV/Lc9yLl5OMnyFz4p7vi+YF3bsZJjnP1Ql6rcYm0te/vwRpWPxQVn7id60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0hqFEghByxvNS3hEGLlRIJnhCOn/XbLuA/oH3ku7QyUhyazz
	WCIjLUCRHt7L97g7n7ADjVa/CFDZjW6rkIis4namw4NwsKFkHWYMCxP/
X-Gm-Gg: ATEYQzx0pGroaGXTxLzNyRZEusll5iTuX9j4e4ZaVmfX2NEBV6zsad1kRC8mzgFh8x4
	NEvR37RrawROBg50Ru1zyAHWF4pamQ3iZOhE1MT38HiKe5mSh1Ftx8LtUeJF2jxC/LUsP9+1zsa
	yCungMQ+l16zhhM6CXucsHJbVVThn4YY8ab15Z5hoVMRp3GCahQc2huYjZlu08/0GaiP8d18NOd
	uBEOOwAUXUJvKOs3WYCZCHNABiltfXXgZPqOGZlzm6jBDr78kF+v0jmtgFrV6+1XfXnxAKnTouj
	Jz9Js/XJQLqQfUpUdDD4fugADr1iQSWgpPfOci1p+f3LYkm2E44S8UrbltKlNfm8I886bpBDIiN
	grpeCVP7bAvVKgoUS3kgXAcHWuJ+8PFUhfig4GzIW5jgHcEEwZUbL+283JYWi4m58Eaic32p+0w
	J94cKs6Dtda7K4PKq5tkq/2yFqIk16jqux6uPUDQOQA6/Vywpsj4Qg8ZvkgTEDBRg=
X-Received: by 2002:a17:902:ef4f:b0:2ae:4fc2:d95f with SMTP id d9443c01a7336-2aeaed01c8emr6386825ad.26.1773193393652;
        Tue, 10 Mar 2026 18:43:13 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378980sm5219545ad.84.2026.03.10.18.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:43:13 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v4 0/2] iio: adc: ltc2309: add support driver for ltc2305
Date: Wed, 11 Mar 2026 09:43:00 +0800
Message-Id: <20260311-add_ltc2305_driver-v4-0-bc350d347f33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTIsGkC/33NywqDMBCF4VeRrJuSTDTRrvoepUiaiwa8lERCi
 /jujUJBinT5H5hvZhSMdyagSzYjb6ILbhxS5KcMqVYOjcFOp0ZAoKAADEut625SwEhRa++i8Vh
 AaWVFOX0ogdLh0xvrXht6u6duXZhG/95+RLquf7lIMcHaSlKCsJoDuTa9dN1ZjT1auQh7Ij8kI
 BGEUytKZfNCsl+CfQlOKPBDgiWiKijLK1kKW4k9sSzLB0B4/H06AQAA
X-Change-ID: 20251223-add_ltc2305_driver-728fa9161bc7
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=9LUdXfBARsaa5aGSj+H1I2RjRXfeuEeD4z57PoMbr/o=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpsMiu6ISH7e43zyj4n9jfFOpNujq74w1rCW06t
 QzuulYDW2qJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCabDIrgAKCRClg0K3CVbE
 gXwcB/43sAs76T9QYx2/+O3+hdNFFIR3lu0Bfge4vkyf34/+uEqJN82WsmZLqO6ex/zAWF/R6aa
 yuqnZFm9zaoiiIUVzE9TfGl21mp4z2vme7H3gDTE8sey7KjWp9kdBqNZVyPqjW23FKBBRTPQOpc
 5shAY0vzQBkKvZfyveIvg8pVqsCBFpAEieddsjyJvYy92mNGIU734QyAthjFQ9jqqbO13PPQAAd
 K69CL9J7ENokAz0qhBaxDTodZRVqtw4GeKo1WJjwLOp2i2IriDgNr3UJ5zKp1vv+AL60c+Rvu7S
 DsSU76O46OtwinBcEo1of6TBGQ+c2A/Fq4av32oUe2WyX3E5
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

The series add support for ltc2305 controller from 
Linear Technology Corporation(lltc).
This is low noise, low power, 2 channels 12-bit successive
approximation ADCs.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v4:
- Fix build warning in ltc2309_probe(): initialize 'chip_info'.
- Link to v3: https://lore.kernel.org/r/20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com

Changes in v3:
- Modify ltc2305 channel mask to compatible ltc2309.
- Link to v2: https://lore.kernel.org/r/20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com

Changes in v2:
- Reordered chip descriptions and code from low to high order.
- Renamed chip info structure to use ltc2309 driver prefix.
- Switched to i2c_get_match_data().
- Removed unused variables.
- Added chip info to i2c_device_id table.
- Link to v1: https://lore.kernel.org/r/20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: adc: ltc2497: add support for ltc2305
      iio: adc: ltc2309: add support for ltc2305

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  7 ++++
 drivers/iio/adc/ltc2309.c                          | 49 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 5 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-add_ltc2305_driver-728fa9161bc7

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>

