Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0EC3F7A84
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831914; cv=none; b=alpILRMnxEVTM3kiCR6VBT6abZktR2cLPSAjh3xIPvLHIvLe3xOtFM/YYejpMr80tKA4yGJ2yPYYwtRlxzQh592Y53mRfkboEk8MClxAbK807Zs9esm2lsINAM6T8RZXpy05dISOY54VMFhRivji+l7ad1Ec6RTPYtsmfy4tq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831914; c=relaxed/simple;
	bh=yvG+iUy2BtpefsQwnJB6MqnqmyYSKf2CEqQs6d1zWOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLhWfVrmzcP2MMNl3HhF2LYcilh/cVQs5D27oYaeljnU1OLNftERWYXjM+OIBUF1rxdiy9kgRTWQniN8RsxJikprdjixg2zqt+TMpYVcQV/ymT9IPgAjVOlys7YrN+G7YeU5ie+me3ijuKvuKj2wBHtQ5dp15stw7/oSKceq9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNs6uhDU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNs6uhDU"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36622412e97so5875429a91.2
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778831912; x=1779436712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbBbu3VFnkPkbAFgdz3fGXOyT9/Bu+8ThEz8Gs0MIMM=;
        b=nNs6uhDUd8KZ3DNSjSRXwDneSX4yaldSuYpM3MFItiFkEsI3fzlIB0BIeNMy/oetWG
         e0viRgtJRS8tW4GpPWX3ZEcdPYBBklLK00FiCgCZzfPaGOT3b0iNwLM23b0kVH9EJLPW
         ifB3LoDZllnuQGYIc5Wc2/TG/MGVBBAwMWxIdYa0L66SNh6Hvj/0gCHwGQy9q2xsgUVs
         THv1XS0MvDooxFdf92nh8WJpIpLX1DKwIDpiSqI15MuRXFWv6g6lY4eDplmfV9AZRbr9
         1rnLAmTtMgsNl+CvLv0aiQZAaJFGuRB5ABUxvKdZ+1nXBhkPKMRyhMOcQlkAzvkt36n6
         OJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831912; x=1779436712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NbBbu3VFnkPkbAFgdz3fGXOyT9/Bu+8ThEz8Gs0MIMM=;
        b=DI9eQA/xObs8g5W5Cky93rltF8jMtH88WUvzlrZ9XVNq2wvwVDH7wDtAl23SLhLKvU
         7/0Eizd+L5O2NzvzVhAil4ybD2KyzhRaOnmljcC6/kPrihvIGddpDPK8pDL3YJVoG3ON
         ccg6DtY9MvPPsncX+yr+70iPfIdEJI+0yqp7xhEI2jl1XQN3sIv71HAm1gV5ueSUTbAN
         OIde8GzyOBhi3Imq9Jz8rmpNx8Q/o94hqKnsk1H8sypAF8q2n5KIGQdGBriH4Rli7EgO
         D0KT/0bjZnsnweBpiB6xaL24qpesKPou3NUSjH37jrJhy6L3x3bHzl75inpd1+gY9xIa
         q3+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+GmV1oOCIhse2g1RqJJr1kErFc1Rr0EonMXKOrwz3axotNU1pscu+Evyt7iNI0o9MJ3TJt91vn2BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7puztsX5RCaiI1ANMvx4Fr8pj/hv3k+MCF4F1R1v8a495dTGS
	CtIXtkdtiyjkp8Uv34NBUHPAKUsWiBiA5hkwL/kKiHstT5Tn4M3AbHf5
X-Gm-Gg: Acq92OFU7CCwZY7ahIA4o/LzggvzVtK8sqmPwWbY0oL9T0JcRKAUZmQiPJOBud7roLq
	agtNpayJtMN1dCQpnwb06Ju3FpA04yFwMg1OIay/ReV5YtGLj1Imc4xvk88jYbZvDRq1WYWC8EF
	iOBPGc2oM9DpKmjESGbZSB+gTO51BMn7AyNNkR4UTDoHnxsyW5SR//TtEo1vipvv103vhzEcNfm
	PcO6wkyDwyQtDfbt0Lp05qqfEV/zJxp1QVvBYXhsYTtpMNNdD2mg26jXBNJjlIMlxV7bRu42kYK
	hQWHdPzEOME8quD7ofgUTTPxZ72wU4vQRb6RAKRxNUIPNYX8+JlDpyNtuYaX2NHl3PN58u98XWM
	XnF+/6TKeF7EyNvtmeTF6/HqzVvbguAiEjWHNYI7diaLFrKDW3UbS5rNxM2u+oG1VAJRlvbHC28
	CTGwH6YJZr3hI5/fccxTxsRjX+7vn6uF26rJeehdPOyOQ1Ebho83kB7p+fDXaMng==
X-Received: by 2002:a17:90b:1c8d:b0:368:57db:784a with SMTP id 98e67ed59e1d1-36951c97b01mr2852096a91.22.1778831912456;
        Fri, 15 May 2026 00:58:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d008:80b:a00:27ff:feb6:42dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36959c7eacesm542040a91.2.2026.05.15.00.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 00:58:31 -0700 (PDT)
From: Pramod Maurya <pramod.nexgen@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pramod.nexgen@gmail.com
Subject: [PATCH v4 0/3] Convert Xilinx XADC binding to YAML and related cleanups
Date: Fri, 15 May 2026 03:57:33 -0400
Message-ID: <20260515075736.172172-1-pramod.nexgen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260510083219.70224-1-pramod.nexgen@gmail.com>
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Xilinx XADC device tree binding from the legacy
plain-text format to a validated YAML schema, fixes a checkpatch alignment
warning in the axis-fifo staging driver, and adds a YAML DT binding for
the Xilinx AXI-Stream FIFO IP core.

Patch 1 is v4 of the XADC binding conversion. Previous versions had the
following issues that are now addressed:
  - v3: xlnx,channels was placed in patternProperties to satisfy the
    vendor-props.yaml meta-schema; dt-schema PR#195 (merged by Rob
    Herring) now allows commas in nodenames so it correctly lives in
    properties. A companion dt-schema update is needed to add
    xlnx,channels to the vendor-props.yaml explicit object exceptions
    (similar to the existing adi,channels entry).
  - v3: reg constraints inside channel subnodes used bare minimum/maximum
    keywords which are silently ignored on array types; the description
    now documents the valid range and reg uses maxItems: 1 per cell.yaml.
  - v3: xlnx,bipolar had a redundant type: boolean alongside the $ref
    to /schemas/types.yaml#/definitions/flag; the $ref already implies
    the boolean type so type: boolean is removed.

Patches 2 and 3 are new additions to this series.

Pramod Maurya (3):
  dt-bindings: iio: adc: Convert xilinx-xadc bindings to YAML schema
  staging: axis-fifo: Fix alignment of wait_event_interruptible
    arguments
  dt-bindings: misc: Add binding for Xilinx AXI-Stream FIFO

 .../bindings/iio/adc/xilinx-xadc.txt          | 141 ------------
 .../bindings/iio/adc/xlnx,xadc.yaml           | 210 ++++++++++++++++++
 .../bindings/misc/xlnx,axi-fifo-mm-s.yaml     |  93 ++++++++
 MAINTAINERS                                   |  13 ++
 drivers/staging/axis-fifo/axis-fifo.c         |   3 +-
 5 files changed, 318 insertions(+), 142 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml

-- 
2.52.0

