Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733892;
	b=mRPPIs++W1tQPBjbMWclYHqawJNMyBtmFgviyJuPw1600W7EBTvpvbH22GGi6hDapPgU
	 J09nseTbB+1obtz8pO5rq+Bfp2IYVNoVW+NEUGK3IwlPggFPGGRJmUO+GIVG1kTF5USVj
	 41vrKbY8dzMI/rY5CjNWPkHZcGNqjC01lVMQ+VmNrEWhFSKsq50VHOmZUvtD9C/K16dyM
	 GzzyuFFcSZuAGPJDVfACEFAceiAc0UG4PqomeTqxJp78Lj7Re0pIVyY0zHaCDEqaXK44i
	 Yxe7KxWaFmpE/u1y/dZNIFbO/qTSOvqH/u/8tlGHtYIoCOXYmspQp2OBgQJ836IQQBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j40ibOKM4mRf4qD2apM+zYLryIz6pOPTKlMB8WE+osk=;
	b=KoPY9DkS0qhQiB0Pm9TCATdp6OXiZevefh1aX4rEJWovJUobeTOXjpBCG6942t8g434z
	 J+baarIE9sVZo2hpyBuPZQS7VndgKXlAL/x7tiRYhLS9xlVPZU/2vMsG6NGCJ06CVngWn
	 6hLJjLjyQY8C8fruOlM1t/vaEdULjnk7590JayXqRM18VR10xsBhb1eIGF/rbzHJW8KOr
	 nKH+3VKmhJEAuBFc237UzcnSj2AE/KGs1HoXQNwWjnJy7aI5YtXE3iVoUUBV6pm65gQg4
	 CzLm2nblvjwZI27vw7VTPf4sMMuqchwwO+0P6ROHVEK16wReJ92uRUhaaNUzgo5UNNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ndht/p0t";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14B606A31D
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 09:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C14B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ndht/p0t
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so189577066b.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794733891; x=1795338691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j40ibOKM4mRf4qD2apM+zYLryIz6pOPTKlMB8WE+osk=;
        b=ndht/p0t8qzPcRCOk7ccV7NMJ0aBn5qjhK+k0s7XUYFCqoS9bzZHxRR1qN/xgeDfsL
         E6/Sf6PNlDF1X1BQXrcYiBXlZ+4GLcOEp1c12bIHqSLtfR2YXxMyHbZJ98z6ERj93u+R
         FR4Qe4j5xhltHAUb6ZRtMHSBttLlZkSHCWbmlNCMcmrH5Fn84HZa6zNDd3e6bGAjN69C
         nWXawJB7gkePvTobYFw9qCja34OCVO+rqyvTPMvo7D9zQBce7nXm5vfZ/v3p8+vIa4kd
         nakgFWlEPbxaIg0T0RyqqsN2vSJ8lsrr71fizH+flVDIz1xLClUJLBo0CY4aEXJZn6Hh
         pHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794733891; x=1795338691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j40ibOKM4mRf4qD2apM+zYLryIz6pOPTKlMB8WE+osk=;
        b=1KJMP7bmwG8cLAxfZrvd+3YV2ilSDtMeNrkkQ0HuZ8aP/31d+X3yMpjuaMcaXXO+mE
         JMyO+5x+jly4ACT5rBn0dEvKMBKpVYqyLLutdvebPf/vW86rgabztd7Hm3YAebeBFtsx
         HetP6xOHTkBR9QdfrYOKlYHBbnzawT376hI9kc7P5waP5ZCCwnIi17u0b39rJI8UPGdX
         fu+7UJqdJBBzyjbsxLQtQlzEfQAX8hRZ7oy3D861+TU81/uggRkEVaga0jm8Y7KtdMrV
         k5My6pqIKHDyt/PjtOsP4BW6YitbaS4KQr0Cu6f90iK7O9ipfghCJYWvXJqlUTanKPQF
         ImxQ==
X-Forwarded-Encrypted: i=1; AL+hErFzeCrMSWqLlRM/fKWb+zNIzPb6Fav6bMvWjW7zKk58jG/dodk5NLB1JOYIm0I4uc1R1QnSePPsEvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UAlm87GEYU5jaQ/F3Wx1sftaaPti/ba5WjVnc2XgkOA1SL/Yf
	/T7Jx6Rln2YNxcuPuF2rOoU3x25YjxRH/oxpcKk59ZrOWomML9uovSo7
X-Gm-Gg: AYBFou3ntlJ35L6hk5oOKMq4CSG9+vmAmhsZvR/e0xfBFYyOYqjcN41ZkaKRY02Tkyv
	Lctz1QsEFBA261IJof+jpv5NON8CMfudDWdNMpSnZGlg4U6oblnrAT2kI7ds57pqRwxVmAGVExp
	vpeIWfiYBP48fJjRPYvSim2ktK8Y7Ic19ZaMzwYIUYoOO6q90UWvwFVPp0FFtkfF1UjDwcKQCyU
	Aawzk5hXyPGQnVY3xtU3BEgfNAgWHVjHgTGNxYJPZt1kukOT4QpfWA7tDX3j3UUz6oYanN73kTv
	N3TSoRxQyxNeE4dmwt48B9iC+5nmaU6nLGr2wPN9J/FTa6l1JivDAUe0bs2yWYKH5VDJbBFLU/2
	0jXizkNUk2cmEEtZu7K71mMwYcKTwJdowUhOsdFygym+CCOa+zGsCplRvcZewR4gI2B1tDowP/Q
	eezNlmIwfPNeJpzQdVbPnHSf2LZV9kVOlGuQupYMmD2nSIbSJgjxEtOZO0k/TVtPASTvnO8yqkH
	4eSO/cxfsD1ZppqnCDNRu23R0ejmJnZjLzNqq78nVsR96mytaMzuf0kT4HUEJ2it+6xzsgijwP2
	qQ/tUlh7uJbllzonrhjqAVf9uPGVHXe9uVKLdIwGuq9WCo2SuSu6JOvzklRFcZvBo3ne1INN/X1
	4ZQIQm/8Rpg==
X-Received: by 2002:a17:907:7b96:b0:c50:62ca:6f7 with SMTP id a640c23a62f3a-c50963b3398mr628172366b.25.1794733890485;
        Sun, 15 Nov 2026 01:11:30 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm289392366b.32.2026.11.15.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 01:11:29 -0800 (PST)
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
Subject: [PATCH v2 0/4] iio: adc: Add support for MAX8907 ADC cell
Date: Sun, 15 Nov 2026 11:11:16 +0200
Message-ID: <20261115091120.108684-1-clamor95@gmail.com>
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

---
Changes in v2:
- remove unused register fields
- add prefixes to used register bits and macros
- default reference values indexed off the enum
- swap data array to __be16
- set bulk read size with sizeof
- return directly last regmap_update_bits in the max8907_adc_init()
- added comment for iio_device_set_parent()
- MAX8907_MASK_RST_CFG_INT_REF_EN > MAX8907_MASK_INT_REF_EN
- dropped kernel.h
---

Svyatoslav Ryhel (4):
  regulator: dt-bindings: maxim,max8907: Document io-channel-cells
    property
  mfd: max8907: Add ADC client support
  iio: adc: Add support for MAX8907 ADC cell
  mfd: max8907: Add ADC cell

 .../bindings/regulator/maxim,max8907.yaml     |   3 +
 drivers/iio/adc/Kconfig                       |  10 ++
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max8907-adc.c                 | 169 ++++++++++++++++++
 drivers/mfd/max8907.c                         |  75 ++++++++
 include/linux/mfd/max8907.h                   |  53 ++++++
 6 files changed, 311 insertions(+)
 create mode 100644 drivers/iio/adc/max8907-adc.c

-- 
2.53.0

