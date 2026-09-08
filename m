Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F45A9861
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895251; cv=none; b=jYOvmAg3LxQ9nXlR2wFk3AMJJ/DuZnipl18Bo60cvmXdr3Pnhfg6yu94JfsiBL4crHlrscRzAs1zojoRFqI2EB0DQQt9Sv4Ug7rjXCPw8MS5a2h2TJcdfWBc65Kvgt8G3TaBTbUi+pb9//mlB/EI895TKD7Ylu+Oav8BKiGjiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895251; c=relaxed/simple;
	bh=jW/PXYbGXcOsgm/sewCquwvI8ml6GC9OlFuq8dt7Hy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgO/hih/kjyn853qAQ5kTcgLjZdZ6LI830XV4K4s6Et9n4Cwa3FkuVKaIXMSrvXsFpP43+qUgfEi1UlChxJ4g3osR7fF3FcURdEMEeCHs4zPLco/RDSjF9UcyPS4VrV5P6SXZHM9ZAU7dzmSQn/l4mBIju06exhTVUL2dII2gBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYQXQZJa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYQXQZJa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so39521545e9.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895246; x=1789500046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jIYimkqxAApyl39451hRh+TFNEFHTBrpXx7umykIy6w=;
        b=dYQXQZJaFQC3VnABma6pOYmn4hGiB4oZkO/2UnaOhAALvHg+aICLcfJXZzc5QKvPsE
         N7x6DrzMZ44/XexUzEWD3Fz1nLU/Ksa6bHo+osXteHCpnn70mw7JcSIJhbZcWTdIc2M3
         7g3rrKw4KSJ/XYu36hww0jVHt0oi0RAGXnqAwZxhDWrzZYRcy26Bdzxtk7DKMudJGO5y
         5m+uGOLBFsLnI9GYFIsnlXoB6m22KvCx1i9+X68HtZH7uRElbYuNTiBvUJCv8GPNM6kI
         6t6E7gdid8bJ6//HXLEG7tX46iKW6DVFFntvisvLmxpFsRos1vIqWi2XiuTXeWlFUjvV
         uakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895246; x=1789500046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jIYimkqxAApyl39451hRh+TFNEFHTBrpXx7umykIy6w=;
        b=LXtoVtCjIXWJy/8EGUVgaEuwXxWDISaT6mcYt4OJ58F22eBniF7Hw4bQu0bwRjaKyI
         9MWNjAx3uFDVV44K+r30gmJQ1L4H5feSqiO8vyd7gvz/kCJFQesh5GH31PvGkVtRxgHJ
         R+pLfg3elPyXUO3/XW1GcvZM8WSw9HGa9k9hKN1Dv4S8GK0AGdby9HX/XE9wXEqwB3wz
         s5+8qQD/Y3S7g/g3ur2o2ft3KE1ChOxvSsO3t6muoHc9WhEiLW+/r96aYyIP8qJlcf7t
         N2ZbNDZ63wQJ5Ml1/16X/0mANmrT+ROy1F/lzRVIniAnfL/2tRrYWL09udm6xmtHzvJj
         ai9w==
X-Forwarded-Encrypted: i=1; AKwUvBwuVoiWy4QdlfmNHNldYQhPzH/o3ZlTOVkongDSjjvrCbsZx+ZSff+Uz4mTltVCsnCWjzMqtCG4QzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mxCVQyQihmIIMuZLCHiaY2pdUjG1FNQQDRegxYbXIgXUbNo1vG
	qJZBgy2uF7571dwoIqqE/xN79+CLm9Ts00iHZvfrG7mSod4C/2YIVOh7
X-Gm-Gg: AYBFou3SL+4p4KK/WAGnq6dahuI/h/hqsL1eDdgVmqF0nWKFd1SUPJFD0Himz0iGrhC
	XTE/UxhUrEBKq36nKmQAZcTkUOd2dvOHbZqNYnsWehj8zKO8KFfkSKqqo6/ZANz5dljk2W70C1V
	iV8skrpU3b60hmuWe4mc/tlIzH1733okrMJD9l55nU/OunzIlzaQ8WJKpgBA7CIZ/VmytBr9EPs
	pt9Q14AjKLFv/NgOFJLCstMchbBIpMiBrtBsqyiWPHS1FHVUIa4UZwlhkOaFZDCK7SBjhAVWQ2l
	RgVSUHeuLv7zP2SghePLDyELCffHBOfJx/zwgmx5vYGvV2CbDswJvmH6uPx6EAzJhWjGaayMWmo
	W8a2ZXqXQ1YnaBXKRsWpBxcjYU3tJFdf7y3HUBh8msr7rP2weaQN3qabZBI21MnpwltyxGYf1xq
	TnFWoaW7n/+BfrGFkMTLu04P8+9Qx6OJA4k2hPz/PDmYymkiohVSHzddAMvo2O73JKe0pdAp5cG
	NJHGv/1LtI1BU0UrpiUF/ydCZbys7cTH+vkyO8ZDse1mk2GOfTg
X-Received: by 2002:a05:600c:548c:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49cf8267dd3mr325897705e9.12.1788895246167;
        Tue, 08 Sep 2026 12:20:46 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.248.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm407885845e9.6.2026.09.08.12.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:20:45 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 0/2] iio: adc: ti-ads1015: Add support for label
Date: Tue,  8 Sep 2026 22:20:34 +0300
Message-ID: <20260908192036.8503-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series intention is to add support for label sysfs attribute=0D
similar to other ADC devices for ti-ads1015. The patch series adds label=0D
property in the dt-binding and the needed functionality in the driver.=0D
=0D
Changes in v4:=0D
- Added this cover letter=0D
- Use Uper Case letters for "ADC" instead of "adc" in both commit messages=
=0D
and move static label assignment to probe as suggested by Andy Shevchenko.=
=0D
- Link to v3: https://lore.kernel.org/all/20260907152304.4992-1-flaviu.nist=
or@gmail.com/=0D
Changes in v3:=0D
- Return datasheet_name of the channel in user space if label is not presen=
t in dts. =0D
- Link to v2: https://lore.kernel.org/all/20260902172230.5234-2-flaviu.nist=
or@gmail.com/=0D
Changes in v2:=0D
- Implement changes suggested by Andy Shevchenko. =0D
- Link to v1: https://lore.kernel.org/all/20260901184302.8127-2-flaviu.nist=
or@gmail.com/=0D
=0D
=0D
Flaviu Nistor (2):=0D
  iio: adc: ti-ads1015: Add support for label=0D
  dt-bindings: iio: adc: ti,ads1015: Add label property=0D
=0D
 .../bindings/iio/adc/ti,ads1015.yaml          |  6 ++++=0D
 drivers/iio/adc/ti-ads1015.c                  | 30 +++++++++++++++++++=0D
 2 files changed, 36 insertions(+)=0D
=0D
-- =0D
2.34.1=0D
=0D
