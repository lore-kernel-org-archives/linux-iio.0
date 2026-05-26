Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1B3AB480
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821846; cv=none; b=HJp0YMtQ6Bdj8ReehIl0Vm1ABArCsHwYS/XjHd21ki805sKLb/26MU9QwFxvaesJDVgXaQ1sdmxDhAJpf8J/SPuy38+AKJiE9qS68jnOcCIIyUBahGdyCtxf7qEfWza0EkL0voBT37VVwRZyVhMA0K5q3N9+9APGN8vYxOHuss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821846; c=relaxed/simple;
	bh=zu5lyry1qrP3qfs3fVodruMT08WVp3EVlHd9Zc023F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W22iwwkIpqFI4DqaNeQdaf69C/ZM/4yGjg2YsENsOeOL150nwaShjybWbENbc0nHxZkCae6qpUtV5MYmARopWzL9Kfn0PbxRwawiVGvte711aPAD7PKvI0ui+O3irZdwI8+IQWp3dhYlDT7Prr3LZcsMbJQ6+3rVh1xEm9x1cAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aej3BYdB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aej3BYdB"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-516d0119e4aso48783471cf.1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821844; x=1780426644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkSDyFZcjJZsQMwVGJUiLhIghU/tAJc7dwgGx/meZWM=;
        b=Aej3BYdBUFW1zWfg2LP5qR04yLXo2lg2kuywnrZIWZVIQDd9WVdTB1TfQgz+NRhZ+o
         w+UKIWpPXkWZN1WCB8hD3EF/+QyNgHyva+8AH8yZRRoQEN+7HNOMmH6ykwFbTMhmNwWW
         Npqn+j6ICSHsoDLNTgQ0GN2YaYMqX2lvH2sYlr2ozx5l/iR2DO9gPIZoR1qKdQMdjxMO
         da9wwgE+s4aa8OjqlI5B7VbF6xj1iixCc8rnYH83MgkQo6VjD7cD8LJvZskWkcyjkuqh
         r61mkoOexnGbPwz9+9nuB8CdFvyCxSkXRlj4Z0fW2YjOWaTlv/xkMTIG0rgMXnUrXS8o
         GzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821844; x=1780426644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkSDyFZcjJZsQMwVGJUiLhIghU/tAJc7dwgGx/meZWM=;
        b=SZzNK41ASgJL9QhGIxYqk/Ux8R4NVH5kTxwxqomZmnrung+t72Fh/PYvmlZuFljMzN
         hHMKbrUVYAilzEZ0M4zqLv9m9WSWdU+EYcEXCAjxKNSqKThrpM95UOIVD9j91utwd6zb
         Y679/A4eQgsuYHlQppz2hSZmDHsPtx/9t9Of3vFSxCK/tpL+escjplzC/yfq8WLGRfSS
         UcjECjY2bSTO4LFDbyz6tHdlAD8wI7XZRu33SMqnMTCOLMPuLeoKDwvmoGo1s8ddX9Vz
         3QtPHXblEjWCk84TPnzv30RXSTZjjMUzqWx6hXTqLf5MSgL16mB0mOICsGUwXUGQy+fH
         ZmGg==
X-Gm-Message-State: AOJu0YxSb9xewCip0t8cNnaSDcKdkjY06JbpS9Ph9veHWqxQK/oqlzfp
	to+gLkvGS4pGUlInquNxiDVoIlRLiDrIcuqFnr/zyyAtcu0HFV97YRHWPGJ2L1Ou0DQ=
X-Gm-Gg: Acq92OFETnXvgj/NeSbIVY3ljkuN2RzYO51Ej6tQWgiTAGnOcEALdsgFNDJcgly2Itc
	QmC7UAoKT+GVVdbagHy3s16DNsXXLqzTKTC/nub6EIRykd100KF4y+LQA4/crdllB3dOLq1Oc6V
	rEEM1PLmOJurvzPX+uu4Z1MCO2WIw5Q3QngnlPW132zv0ZpzjZA6Tzxau2ThE3j6uUJvb9UHHoA
	AYxDtUaGJ5Ka+tsD5XMzw92ycutJWp5z2PHK7gAqP2lHnblptAlWXe7+apSHGgRswab+twKtAtq
	YXfGztg+MsPs/5oCBHkfRyK1nq8pSd0q8Z9oXEy6tnVIwSyI82zSHnY0hC2V9IeFzTN9JIHQ5OC
	aM70UInBnZSI7cobSsnbiNxTTiKh+Pjg3ThYzuQqYs9gAMSQCpXc6PWGHk4lDVlLPnon1uCtb8q
	V43iOKDTuA5XJmzs8VTwVanLzRr5dw4/Dq
X-Received: by 2002:a05:622a:8c3:b0:516:e6e6:63cd with SMTP id d75a77b69052e-516e6e66935mr150804561cf.2.1779821844291;
        Tue, 26 May 2026 11:57:24 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf797sm150619496d6.4.2026.05.26.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:57:23 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	Louis Adamian <adamianlouis@gmail.com>
Subject: [RFC PATCH 0/2] iio: pressure: ms5637: Add variant specific compensation
Date: Tue, 26 May 2026 14:40:29 -0400
Message-ID: <20260526185612.35048-2-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds correct temperature compensation and pressure scaling
constants for the MS5637-30BA, MS5803-01BA/02BA/05BA/14BA/30BA, and
MS5837-30BA pressure sensor variants. Additionally, it adds a Device
Tree binding document for the MS5637 driver. Without correct
compensation, pressure values were measured to be off by 100kPa with the
MS5803-14BA at room temperature. 

Note: MAINTAINERS has not been updated yet as I am not sure what to add for
the MS5637 driver.

Louis Adamian (2):
  dt-bindings: iio: pressure: Add binding for MS5637
  iio: pressure: ms5637: Add variant specific temperature compensation

 .../bindings/iio/pressure/meas,ms5637.yaml    |  52 ++++
 .../devicetree/bindings/trivial-devices.yaml  |  10 -
 .../iio/common/ms_sensors/ms_sensors_i2c.c    |  81 +++---
 .../iio/common/ms_sensors/ms_sensors_i2c.h    |  47 +++
 drivers/iio/pressure/ms5637.c                 | 273 ++++++++++++++++--
 5 files changed, 403 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml

-- 
2.54.0

