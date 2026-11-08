Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131806;
	b=dGcUEo3wLZGA1drkl8DHD4/XCMcxXNmPg0RxbfK0ab5NLxIib8Pp6PWpMALJkcHM9TEh
	 4jtDAurya1tTL8Gq6LShmpDWuVZPn/9BawAWW8KQ6kNmjqvZnzymtFottmfjSXSx6Dn/F
	 ZMyRyK3TRMSnTtNYHemSCFzN0OEMUVq3NLtTCnZvdIqXCC3yS0cCDd1hvrYJU+Qni+odi
	 n/kqSbamwO06qVL4zjm3uVl0K9oSOpHjv11DQtvxITRyzuxoacJSeR9XFlNhEp+kr7sxU
	 q49OL8d32RNUbY84obvTw5AaPHSF7JtoGtpevXdICShEGXfVjwAgzDItkd5/ZyDUtAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uKFGtUNuaI75fKMjBlQigCXuvmnu+j2Ar9uMYNWhR2Q=;
	b=WM7Pgb4dsPdJR9SJm/7zjgqNirWR1vLkwNcf5dwRE+tddX3z1kfUI4vVo62C6KAOcw2k
	 K2+CkGS9awasV3vszkbvJqlkWjxRPiwlWq5GTFtB7iAsSS8fq82cn2GX0fs1e/PGlgJeq
	 v+BtaWvPCwZzRYtd54DYmdmk6mg1CxzUUX2SzV1dQKzXKG0MIZgI/CZTCxXLjPNacr9OY
	 eJp91xCw/MBDlrRNK0gPo5/iTbzUrkXiDFedFPRKxK8L6jMa2C5m7OYPK7024pPGQKc/1
	 QzLRaqkyJ0fGdXm6usU9HZMMiJdL8M2bngxxX4p9WDCUQWV8/7iStXLCa31PRn8Vt4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lUjqusQa;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A09606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 09:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lUjqusQa
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d7d591607so1695166b.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 01:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131805; x=1794736605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uKFGtUNuaI75fKMjBlQigCXuvmnu+j2Ar9uMYNWhR2Q=;
        b=lUjqusQaj8Wf2o/nv1+PV+497UA5OYJz0uJeVO9W8iBalJ5xK9HWhRAoNlI0QQtB/k
         QK9prBkdbacVPTr6Pfgz1JI+U6arVkz/DAN8ba4s2/SXkd0vDiL48v3TDsN0gOycR7r2
         JO+uXyWzoHeoa4xuEetHbpHmLOy2KsrRldJWXilK0SNfuTktCahmNG0FjiCPm9IfsQOo
         YrB0wiFGYaiaGWW4V3ypnNmR5A9ZF2k/24ghOGMWplFv9V7+wtS+MSpfKxajNWLACVq8
         2JF8TK0vVGpIiWZ1jnPoeKUfFQi9nNguJgY2Gd27VYBRH4S8rCkpEuNUYfNWn1TxxsEL
         tAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131805; x=1794736605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uKFGtUNuaI75fKMjBlQigCXuvmnu+j2Ar9uMYNWhR2Q=;
        b=RQY0g5mLkoweM7qQn2ULHByqZyFoGq6Ss6CDzjxd+R6qPiPnCoP+nWtGZ7+OCz3mwi
         Mg01t+glWGkxNLGtfvKX1TkdDPIOwrw5qBYNJJyXxTOKqap+LWJ6kOuHGrPLrgO6NIDB
         MiP130l1eQDrKe1uSw+ihSLYDUGK6pLSSKioGnm1wm5ITuzGrODzu3DnkvCgrLp4t3IC
         Kp2y93v7pJ5aL+W6dSD2NL5yt1ctBUwHhRrMtpQxnLRKwN7cBbR0jbtood8Uil6my5kw
         7ZNgH7MKEhtDcZi8sLWx30qHfmyUp3K8KwLugWpwebRFka4tfxdddGoHmgH8TA7qItMH
         ziPw==
X-Forwarded-Encrypted: i=1; AKwUvBwC1Dele63PxU5CDSTZggJfwSWtTNKnU+Ciy7C/B6MJGx7iUN4tELGqtmVYaMuI3IqdH0cL9LU6IWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LGwsKcsLbWFfZ+zh/cxLg7TT0qUdKUiJ7lxPk4u/Srh0igszR
	KzPzWhVwQGWqMNiVtCamQu7K46Oa7H8qn22OlKJKGGIyROxx4v9gMCKH
X-Gm-Gg: AYBFou2BRo1cNQvRNFREgdRNlVEaKTMYQZ4lU5dNftcKTGQ+MNxmQ/ifomvL4kSozj5
	oK5XJrWnoVO5ZThbbo1b1Ea8GEin+25AEZ6Jwy+AKDt0dUKwt0OBmm297B83or/VkqmLFed2CAP
	9yF5GEVUitcORGBq2IycfUvVDD4stYKLifqUbsNkMtvwIwmp/rn8acMxqoVcKWoEICNw2jKA6MD
	975Aq7jJBI1mK56pKtrgBrR8j/jZrqbrrDzgsVMVLPNxFGkEgygkTG/jsSQHNQyt/F2JZ7IalTO
	j7s2FbLXhf8KoWvFCKvd473780Y6FO6GT5pEqIw6HZGmEH2wAXvH4yLXwk4ARr4AKBX+fpOOc0r
	bp/JJUVJFNT8C8DYAOO7K27PgOLGDLtUIy1s98LMA1W72P+VDgGfDuoKQcrN3crm7xkkzVZGAYA
	N3N43ATEtbQHbuQnVZ7MLjUjUvFWtDFa9FIlMa6VghNXsXRWd+IEMq9OwXHwGDw0hZWai/4usv8
	+alWF1I/4rH4roWkhqobqb+K5ibgKNzBU2oiKJEvtu6Xv0at4z3qszB/R7kkOdXZGUEba7p4IsR
	miwLiLh+TLJUQFITu/Lju26i/z0421uUKoAtEdyYYZPfhD3f+q66OxwLaWGARIrd/9Y3TtRpy5K
	t0l2573tzCr0p3JMfkixIuSA4Zkox8ac=
X-Received: by 2002:a17:907:94c5:b0:c4c:eb16:b567 with SMTP id a640c23a62f3a-c4d6d4e45b8mr82837666b.19.1794131804580;
        Sun, 08 Nov 2026 01:56:44 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a9bc2e2sm48920866b.83.2026.11.08.01.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:56:43 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v1 0/4] iio: adc: Add support for MAX8907 ADC cell
Date: Sun,  8 Nov 2026 11:56:30 +0200
Message-ID: <20261108095634.100517-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The MAX8907 PMIC has a dedicated ADC cell, which provides 8 ADC channels
with information about different parts of the power system, including the
battery, charger/plug, jack and thermal readings.

This patchset has 2 dependencies:

- patch 1 of the series requires this patch
  ("regulator: dt-bindings: maxim,max8907: Convert to DT schema")
  https://lore.kernel.org/lkml/20261027114634.79706-2-clamor95@gmail.com/

- patch 4 of the series requires this patch
  ("leds: Add driver for MAX8907 LED cell")
  https://lore.kernel.org/lkml/20261027115006.86032-1-clamor95@gmail.com/
  Or to be sspecific, part that adds max8907-leds to max8907_cells

Svyatoslav Ryhel (4):
  regulator: dt-bindings: maxim,max8907: Document io-channel-cells
    property
  mfd: max8907: Add ADC client support
  iio: adc: Add support for MAX8907 ADC cell
  mfd: max8907: Add ADC cell

 .../bindings/regulator/maxim,max8907.yaml     |   3 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max8907-adc.c                 | 195 ++++++++++++++++++
 drivers/mfd/max8907.c                         |  75 +++++++
 include/linux/mfd/max8907.h                   |  53 +++++
 6 files changed, 337 insertions(+)
 create mode 100644 drivers/iio/adc/max8907-adc.c

-- 
2.53.0

