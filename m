Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59926ED3E
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504400; cv=none; b=klRYT6dGq0SwIHruAZVKYT+beQkCdkvGSs/Vlx6q5cmnUOQz86iwtRDc7AhWhrnUXRAfdcofbbNs10OSZuf3gLHXbyzW0kFfoowNQmuW8NjKcAgyvJLOgteOF/yAkioF1zgBfvdtimL8pXWv5MjxOEoh8D/+/5XvAOnKYOi/hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504400; c=relaxed/simple;
	bh=PVNLhKnuvnLq5lryTjPze92pjMzYxlP0inllyDZUJLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pkLwzh6GiKJQnlU5lpgz9ObspqyXipOcdqqHMsr4iajwJe4jkon02XpDbupSBTfRmJRZUTlpOtjFnng/wMI1buMRrjSeKR7JyxMBrtFsC/OJsbhTOVuoOP+Hvno/Si/oc7+d5GQYO/lP4PLxBJ6pXSl+77+MkAmDQepWdvageg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0FENvpz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0FENvpz"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9773abf811so245094866b.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773504397; x=1774109197; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u2gE4AmHfyDdJk2rWgz4dNOtkVHCWBvMjN9Y8lBsN1k=;
        b=f0FENvpzkPEGjHiCvfvsjqvC8KFbPozoLU3EQJLnxV6kbHgZDIAzOdVXnTFHe6VaMs
         F9PGz1IJ01sn0xVK4iHPO4q+DtnoiJXkmX6v0DwEC2aeGwwUAoC+soHV7Y2c/Zt/LuRP
         uVQyaaU93lVUFoPsATnuuWffnjliwqIrWiVIj6rZMQlZ32k7JOmU7KDcYnsiShR1A04+
         sEr7wXcxvGcr9loDgnfT4wRARrAHdY2earvQgLut5i1YOu84r+DUWvb8w+MLjCFoqaGk
         sEoOQIOpdysz5YXjfdzwFnY/6Bb7YDH6BdTFtgolHcfueO1AsnXeNoGhJIBMHwH2Yszk
         uG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773504397; x=1774109197;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2gE4AmHfyDdJk2rWgz4dNOtkVHCWBvMjN9Y8lBsN1k=;
        b=SkCozODK9RAfyQuN2//kuKTAktIElHLzjRNx7sEKSwaXa0P9/tKAt0hiWa0gCaGF57
         FCX5xKKNMUBsbNefS7LTVOGYHcUjyFmzmEWCuwc1RlnyBczVoM+MMLNMON6XTFcDmQBb
         WHq50uqE8NX8zzXtyZLVH9rW9FZ0IjZpAbY7ShmOdGm+sgy/n46uZ3FGcGvJI9K2iHcc
         zlgLMOO/TDak6vTDgqUQnGr7RZooWmbWWwDnoMBKQl8oRxxzmYTGNW00OMwkMkHUpS0+
         0IDqnHqdzJKP1aDPEPQcZWds3d8l9MJbr8p2kq5DhDLbn8UcVdlpVUfLz0OPf+dH3WCz
         WSpA==
X-Gm-Message-State: AOJu0Yyvh9XEs4sGsaEHQtxiPfOpEEEiwuOdv9NrgrNqQRJaolSiIT2i
	c5V0YS98kavG9viZ8clFHwZdbCMe/BlNEYBWgeZ+YlTEIg+YL2dS4NgC
X-Gm-Gg: ATEYQzwOuthJOAG/U8eigV6hmdw6ljJU6CAIeeAXJmlqxo3ymi+Ig4pbAajAoTQJzZZ
	3LK0GC5F23XYJqicXtgg+PrHmh9a3WqS62zD7xF+crJiko3jOmaEe/by6B+K85WpHZ6K4FvjTS2
	7rpRn2JIRHynFpPKH8MFlR3SxsaK1aQACZSwz/XYLnLrI/yiV8t7NlmETsUWs+LR4Q5gN//hT62
	jdKxi4kfj6FfTHKpqF/xZX2JNbSR4W5Ls+u8zzDf3CiwPlrE+xg5dkfBAmyIRl8ndikvjD+/NuN
	WSU4KM/pps0lu8RX697NWAHhdl9OA/w4L7n3dQFx7vOtjgJTCqd0FvJ3TMp9MDMRHd7fcvEyQD0
	n2OEj1pq73wr0vtn9EoRNYSyzHebUxmevAhjRBXFrwbwmN//EU+eoXImJNEP4WHm8Af2Uu3Q77Q
	9nMAT0hv2sodH2PDdjOG63Dglom5qmuQ4SBqT0
X-Received: by 2002:a17:907:3cd2:b0:b97:3734:8d49 with SMTP id a640c23a62f3a-b9765145762mr437909166b.38.1773504397154;
        Sat, 14 Mar 2026 09:06:37 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b978b8625d3sm151722366b.52.2026.03.14.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:06:36 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v3 0/6] iio: light: vcnl4000: add regulator support
Date: Sat, 14 Mar 2026 18:06:29 +0200
Message-Id: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQqDMBAF4KtI1k2ZxBqkq96jdJGJYxzwpyRta
 BHv3igUXLh8w3vfzCJSYIriWswiUOLI05hDeSqE6+zoSXKTs9CgDZQKZHJjfwEAGci/e/uaQpT
 oWoW1BeXIiLx8Bmr5s6n3R84dx9z7bk+SWq9/Tx16SUmQxmBu1I4qU978YLk/u2kQq5f03tDHh
 s6GxoYQHWJV272xLMsP2sEiRfoAAAA=
X-Change-ID: 20260310-vcnl4000-regulators-bcf1b8a01ce6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>, 
 Raymond Hackley <raymondhackley@protonmail.com>
X-Mailer: b4 0.14.3

This patch series introduces support for voltage supply, I2C and cathode
regulators. This fixes an issue where if a regulator is shared between
the proximity sensor and some other device, and the other device is
powered off, the proximity sensor would be powered off as well.

One of the commits includes a Reported-by: tag without a Closes: tag -
the report was done outside of LKML.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Changes in v3:
- Added a more detailed description for supplies in the dt-bindings commit.
- Separated sorting includes into a commit of its own.
- Replaced all occurrences of mutex_init with its device-managed
  counterpart.
- Moved client->dev variable declaration into a commit for adding
  regulators.
- Removed redundant dev_err messages in probe function.
- Replaced all direct usages of client->dev and data->client into usages
  by variable.
- Link to v2: https://lore.kernel.org/r/20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com

Changes in v2:
- Removed double quotes in includes.
- Reordered includes alphabetically.
- Enabled regulators before the mutex is initialized.
- Replaced direct usage of &client->dev with a variable.
- Link to v1: https://lore.kernel.org/r/20260311-vcnl4000-regulators-v1-0-66b6038ce563@gmail.com

---
Erikas Bitovtas (6):
      dt-bindings: iio: light: vcnl4000: add regulators
      iio: light: vcnl4000: sort includes by their name
      iio: light: vcnl4000: replace mutex_init with devm_mutex_init
      iio: light: vcnl4000: add support for regulators
      iio: light: vcnl4000: remove error messages for trigger and irq
      iio: light: vcnl4000: use variables for I2C client and device instances

 .../bindings/iio/light/vishay,vcnl4000.yaml        |  7 ++
 drivers/iio/light/vcnl4000.c                       | 76 +++++++++++++---------
 2 files changed, 52 insertions(+), 31 deletions(-)
---
base-commit: 6e03baeeb160e6cfd72f2c39f26c50bcd925c7a0
change-id: 20260310-vcnl4000-regulators-bcf1b8a01ce6

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

