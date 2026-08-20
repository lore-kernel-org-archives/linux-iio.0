Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A513546EB
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236348; cv=none; b=Ss41FiBe5RU+NxvRsRPgEgyVW5BUm0UuXLEqbNLKNZ2Tmo9tTZiy30szqBa/fFIW0DYuSmGjQcpDGtj2tdfWiY7yrn8YrqkBUDUEmluucQlyaaaSAZ8prE+l6tSJNrcPypqhqZGwjvvqgwR38EWCMivGgnm8eMycKmr0wna+ftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236348; c=relaxed/simple;
	bh=oIAsE/e03p+TOGVzlvCWR9X1duR52+pknj+r+YshhDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j2+ltVCS227o6hmvxca1blcC2Y35B81FP22DJPzmETKPKtLGV9jibuQNfvq3VM4rRanmQJZDHNoOiQeoG/E4okh/aLVpDQkiGB6g4fUnv5G1vQcdMdQGMDZYgQ8hnyaJBM3M14awrl1dl+tVQ1igk9PmU54Nlbij0jzXkW93UuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip0itOWo; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip0itOWo"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c2c0e261aeso903677e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236346; x=1787841146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gm+SgYfIRbiDZdeJlutFSVssEPZa9jM7xptJ+k84VM=;
        b=Ip0itOWod8TCkDrqG38gr6Tgg0TpQLNhkdKubId/Q5wbGUtbJ4ujrAerpC52sHXwb0
         tR+565KV45tSQjbpgvTxwdUXcmdY9KxWalH7cA3I/OpCla85lcJGhNbrb4bMzzAKmY09
         YASSKTGjGtq9BLfRWcqOx3vsaULH0QcP5i671CHT2L8FUh4qiirNuekvLDq/pcnK1/ZL
         sH1wFDS6RwszBDeX7fWcgNBpxtRN0aWwhYEyctlcLJOI+4znbnqe89hDcky3cRqhUt/r
         7F6RuLlwGyL4nHo75G3h5mwKmfQ2LOFVFGEsLzV210eZIeOXIvoi1bo/IfiipWrZi3Yj
         k32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236346; x=1787841146;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/gm+SgYfIRbiDZdeJlutFSVssEPZa9jM7xptJ+k84VM=;
        b=kt+w5/Tap9H3FihWcxuwboPk2m1ZrDVshtyfN4HpphWIoGY9dur+rzQYzQ3X8wWLqF
         S7p3F1fffFqwqCQTpVthya10+P/5/wt+hJpnX1nL1gMjDcu0FGAGc+tUIZtffK5Hgcha
         dtYPuxNfzAfGAYYHRxcdNLbnRDJcGDs1AsDuCfkEt1FqFGM8SLdOTDvPrutiVIyrWPl0
         0Mncla6iWzkJd3Ce8Asd+pcsDh4VvD1q2Of7XTBLr8zuh4bFZLfSz/8nhzBktkcbeuQ6
         36yw6s4s7ChCsFS+nsx7M6uIcutNV8rb5jKByGtXFL6yG6RTGqSJpDu486ILGAgzylQl
         f9fg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9B0L07mzYUbcjTo9RINvVJgZeay/sIyU2wcR9l3aPGoG7/BqlEdcFcav+Uioa3yHC10UYenRtCkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrDZd9HhvGKqGlpphxj14dr9iI5XdFB5q0kqVwn5b6W8z48S2
	8+IBkhHZRfwTqbSx88fqaXF5qDA/Vu4J1B7JRf/HLDkzUxaglKDVvSo=
X-Gm-Gg: AR+sD13POV4+xHgV48MiEJQCjQ2vhi4tq+1tPlMIeOYpN+M3iooieEc3JVSOSvKRlCH
	a3Ed3w+aGaUhwnNaR37+hUMD2ZNQ9I0gmM33rSmMrDGZ5oat6QxJcP3aEPoqtEkatoezywkayo8
	0dmIl3qtdmxbjowPDTNBfudivBRFUrVPsddp5qnYEHQUDk106W3sDvN5SncQVpYFreecX6zxhNK
	qeqi/Snx4/2NSvq+4LsCXB98jmrarjl1m+lYQILt907/WIVRJXwEVebD7ifG5/c3+2xkc+2qW3P
	UmBrbYUheJ/PrWl242l+bkwhX6HxTqQWHXdYY+HkS/I8/gUjD/lmqPGNPkPqINjy11gJZeeTY1l
	EZsbnNPDD3Ry6esz3OgWRO12ACgqKTX6KE6bOb/Jx6XaSmbzmhYJTNQuWnoFa6GZ3oF/34F1avC
	Nj2OORzllpUMKm0zP7c09tiOlBQPsSajxeZH3Xv1fSWn5R89VlIpUYDa0gZZi7Nh8ZHE6KsKRo7
	trgePfh66a/TXT4LMeC+naiBwOaHxSMvSowdTMP
X-Received: by 2002:a05:6122:3129:b0:5c5:ac11:9731 with SMTP id 71dfb90a1353d-5c5e3e4c415mr4869914e0c.8.1787236345866;
        Thu, 20 Aug 2026 07:32:25 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e25e3459sm6393922e0c.4.2026.08.20.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:32:25 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v4 0/2] add support for Aosong AM2320
Date: Thu, 20 Aug 2026 11:31:08 -0300
Message-ID: <cover.1786973355.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
communication protocol and measurement conversions.

This patch series adds am2320 to the i2c_device_id table, creates
of_device_id table and adds both am2315 and am2320 to
trivial-devices.yml dt bindings.

v4:
- Addressed minor styling issues in driver's C code pointed by Andy Shevchenko
  (carried "Reviewed-by: Andy Shevchenko <...> from v3)
- Adapted commit message pointed by Marcelo Schmitt (carried
  "Reviewed-by: Marcelo Schmitt <...>" from v3)
- Carried Acked-by: "Krzysztof Kozlowski <...>: from v3 dt-bindings patch
  since bindings patch did not change.

Note: I carried tags from v3 because reviewers declared the tag after
pointing things that were resolved in v4 (and the dt-bindings one
because the patch did not change from v3 to v4). If this is a mistake
please let me know.

v3: [3]
- Added "aosong,am2315" and "aosong,am2320" to trivial-devices.yml.
- Added of_device_id table.
- Replaced using a constant for driver's name with chip_info struct.
- Separated code changes and dt-bindings changes in two commits.

v2: [2]
 - Generalized KConfig description text.

v1: [1]

[1] https://lore.kernel.org/all/20260805183733.1000550-1-nico.antinori.7@gmail.com/T/#u
[2] https://lore.kernel.org/all/20260810183337.451812-1-nico.antinori.7@gmail.com/T/#u
[3] https://lore.kernel.org/all/cover.1786725567.git.nico.antinori.7@gmail.com/

Nicolás Antinori (2):
  dt-bindings: trivial-devices: add Aosong AM2315 and AM2320 chips
  iio: humidity: am2315: add support for am2320

 .../devicetree/bindings/trivial-devices.yaml  |  2 ++
 drivers/iio/humidity/Kconfig                  |  8 +++--
 drivers/iio/humidity/am2315.c                 | 34 ++++++++++++++++---
 3 files changed, 36 insertions(+), 8 deletions(-)

--
2.47.3

