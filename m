Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017525D53B
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290682; cv=none; b=rpPth+XGLFQ1LQyTda3HZ0p+83xQXfqp9lOzILubiJviF8cGSJNTvllEcn7NSoaKkvtSue5zK6o/jTSlatWj8BKPuVy+zOqh5foRH3Pq8ctisw4jSH2kce6Jz4pKTe9qsVtOBNp8RfVS7RlSozgAKn0WL+EYjlY1JznsQVziP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290682; c=relaxed/simple;
	bh=ZafSK/ffN4O0S95cmgYFO4DqFob5YI2zLrZF+3z1VYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f6rf2ahPtY3egfplPKSbqjDOb2bzUsnhOjNtnwLPmzNfR05tLDlMyBiDbGDR8HsAvWwxQ/4thlqfnnYTAIqwpauoAbDv/Pcw5Z2tvHQzuMOgQjoEZNM68GNOn5VJoNHPFKAnk4CQ5bCfmW5J87j5L0VIEB+wNlIL7x4YTYW6WTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSQOygyO; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSQOygyO"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2f00a567cfaso2268448eec.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 18:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290680; x=1778895480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0amy2Ap/oF/82M4xJn8jCwNeFxH+1UppM6CazgFzx0=;
        b=aSQOygyOt/HIE2DKVbwnreNiRxB3AYNQUDL7s1TuzIucK1r+Mv7Yqoih9K52Hlpyfp
         6VTRueINgtAgOvXhSKKpWG1rh6dR08BkbvAFskiA3kvZGMV+ACtHj7oDnFKgfbSBYwkj
         +v4Qn2AGY5sPO3Lpar2cRLonGzlzQBiPtjmXPIMJrtw2FTBUWogm0vG4ujiZbr+Kdgwu
         DCWmnE5DOrLTCoGM1KXq18KGF+FEliVUvCJ4hhnE0qI+sz4yqPqQeMnZgVw/kB9zpVbD
         KX0XEluAtzc3K+45K9bsiMPqOz+Z0QdpX29inQk1vwtRXjK6oxLNTmIYXDVa4QnAXu0K
         AdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290680; x=1778895480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0amy2Ap/oF/82M4xJn8jCwNeFxH+1UppM6CazgFzx0=;
        b=CeJHlVC1gxBPkKIwhOKS9Zqnoc0/4ISbYVFx3R3Du+ZtOJQJwZr1wvcWIq8ttSemwX
         zCmWzLsyC5y9dpIWm+3uw0gOQk8gTTENTKRx3KN7KnVzIHwv7qnoRGFEzsPs2pu56WYs
         RXWg/tIrG76aErEq+MI5eUSKB82cWZqBJLhkYKNwo6+6aaJ4L99l6Fq9rfFqAZPqnBIU
         qtq/24dWKH3nN5Rs003wHSU0j+BQIexNa1DNA6hLFKvf2AO459pJsIVRtQS/3lv51VY/
         Ll2cchoGJ9BC7Sa+wACfVFPOrLJg2rpovk+6wcpUYNwHjNDNMc9w1CnaBhqd8gTU8GV2
         sPgg==
X-Forwarded-Encrypted: i=1; AFNElJ8pkZk2RLkNsdoNQCDxNZM8slPFQxEA6sNJOEHc58XQjXmrEt3EEiPyfaam7p2FUNDfgtUX3vIgLuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjOwBFExTGK2qNbkIUx1LiUZJs9ohWi1lNT11HOW8Ws5eaXdB
	5Y7f/6WkJ9sOSsIkSbSsWDkIt4xVMcTX3IJ4GUyC+5w06WaAMCNdFMRG
X-Gm-Gg: Acq92OHB/f3Zx/DuMd7rctg8SQ5wEwZMjfTOx4LJrLaE9TV9pRhUGFSbvEUTOjuFRZ2
	5aPdSxa/7Q2PBGX+F1I+1Wl0PANAWshVYGdnjioR2HsdBaFNSS6BgACIE/O4yS4uLri9Ye1BcB7
	4McoRZ8eMxa1HH9gyh02RcxRMERa5u/77dzk/hNdMWey8QqCpcAURPTj06RrrHk0Q236rUWMOaE
	S7s6zpgv7HgO29LolQ0Zx5MN3/3LrPfpJSXB4DV6DEE2Jorv0uWmTEpUBHYIbYVBvS4cucld+e5
	0aGPTuUUf2yW2m2hksFIWNeLh5VCMT15tElDfMA74TBXig5TWa/9zjIeon+pFPlrLgWLlQiuplF
	QmH4dPshjk4mzX93Fj01BfUe7CqIC+3uv+Zgjab79Fc802w4Y9wzMwKQ6KNzDRW1Tu7dv++O9f1
	/nxhpfDgDk+jU98B5u2HCLuwWuMq8DVRUY9/XkclX7JYt9/4k0VVKqj7YsEWfBgO0d+A==
X-Received: by 2002:a05:7300:148c:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-2f6e4374892mr3977101eec.13.1778290679860;
        Fri, 08 May 2026 18:37:59 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d43b4sm4503230eec.11.2026.05.08.18.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:37:59 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v3 0/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Date: Sat,  9 May 2026 01:37:44 +0000
Message-Id: <20260509013745.80478-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds devicetree binding documentation for the
Analog Devices AD9832 and AD9835 DDS devices.

v3:
  - Require spi-cpol in binding and example
  - Use generic node name (dds@0) in example

v2:
  - Add SPI peripheral schema reference
  - Fix example by adding clock and regulator providers
  - Fix SPDX license format

Hungyu Lin (1):
  dt-bindings: iio: dds: Add AD9832/AD9835 binding

 .../bindings/iio/dds/adi,ad9832.yaml          | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml

-- 
2.34.1

