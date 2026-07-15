Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742F9460
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074803; cv=none; b=kBu8afpX3hn1eVinf0JQHG5q/DAKZhWbWqxJj0Ky7Nz4dGd8vGicFkiZsV6Sdodt0iqAmQiE25/EW2SY/mLq3BWcRWMgQu9zk6RTfGuug4D8RAAx9unXLBpO7rsxsIoHy+mWoRihAZbmPUseDIj59e7VqSUbf81LCGSxS89cWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074803; c=relaxed/simple;
	bh=aeKW+KeLL4Jt4ru7TjOuiMj8iD50qe5w7FMDtSuphn4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=byvDOP5nHdngJ3WkK/AwXjRBGuXHRkj6r+RFNqCzVaPfTh81zuB0xiHGgl3oN0qcyGyXTJihN1kZSHtFPjuGX7wVWCV/OnYidjP8kDVkY4Mj1SrDCBv6/0Fbqz31TupeL8PtDEEK+0XkJ6iU46Ln4bfcLpNQI8VHM0X1xdbuy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=X0gZ1q6a; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="X0gZ1q6a"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so1158250a34.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 17:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784074801; x=1784679601; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rU20W6XvfSPCBzbWZbkiSmQvJpVuLqqunLI/YJm64A0=;
        b=X0gZ1q6afAo3e6aAfbM17a00cMV0Lh62q3QQquwQK7lOGPBHLfRCq2UjLcx5pQeA9B
         EWrE3IRRbet6OP8ziUeaYeHGr20W01kHAwHWW726fn2HAdsQc9zktlYX/QxqeTCl2EVA
         vmoWHWJFntdVCXth+xFnbdwIYkUXstsaFJ8VWJ7yQ6NvE0o1iKUH0NBj8cMhdATPArWD
         Fo5JUWP3HwbJZ3A9SmEAQyOLf4B9r4AKXFcIQHampKVsy59yBvZkQOd8rgP5oeq90Lh8
         R9bxylZdCx2YO7cpfs61rrkge0feplfjFBLnRGH9yY9esXAGcqigN4prq7cd2n+SekUZ
         BtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074801; x=1784679601;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rU20W6XvfSPCBzbWZbkiSmQvJpVuLqqunLI/YJm64A0=;
        b=VLQsSYgJTpNqBvDuSQ7a2JTLeNCI/IVifISdFRYi3N5IAX4hs2voJ2un1rxnDOPGXl
         IuQzKuL08JTZ3znih4ThCpDqxl5QztVijG+ET0TaV9e3UjMVIOC4MtC5KMc1iHHD+/02
         yiknmhK3jPasz3I7sWiWEeZz9jmk3m+m1HHKZbWjPAEbssm8lGBJhDQUPLQgCQz3xiuK
         ivo/jzx6cnDrK5rOjJuCTDizH+ufy2DqevsDGp5Fiv+Zr2pkLrRHpv/O4ZzhsQDRdRnD
         TgoTuY+p6MIEgnclSMlz0Pgz/wYtvd3KdekbakR5oujaE1CR1dPQ5gOgJ3aZg7ceK0wr
         xX4A==
X-Forwarded-Encrypted: i=1; AHgh+RolkgwnjyQ2n35lxHGsEh3Ht2jmjcyvB0U6bG3MhDPnAZTTSh4J0sXWeHO/qlnakuYwvBxGYplj5NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykkQfLqMPhX8k9HDV+mbz//DBbrht0SEmL3jaItZ9FH6wSq4h2
	Y3JSIBtOyp+c7KXCVpK+0BSahEkhKmy+jqn93afkAu1twfYMM94rRxstfcl9GzjypfdN0LQLP+n
	ZRqE+
X-Gm-Gg: AfdE7cnzgD+19uXfYsqbPZpM/wdAIu2iDExUi+67G2wAq4j6btP/jkojqk7kwsmACK4
	OkKQenVyqhG7HwHOMJTJdyGtfIlZt5Oy9IRb27lqxzPvBtXaQ49hP4G8V/7hbCbMpPY0prLHm/H
	DegAOaoSs0YFI5xDgtsV3P526K/C4Iq+Q+9pVRVDPoqa3YcMoNQeLIe00CqqYT1715IH1u0bw3F
	IVXVR/+L7dI5n5GeOJdZMsvFXrXmPEsLHU4O5p9szxwBD/gAeoSurKs6f4cDrWfeAMceeOiq8ST
	QMpMp6XNxL+zjsi8NR1KcVGkwZ8z42BQkln8nJ8BnqQKRbFopGuObyxDEQ/Hp7QTJjbyvb3lAzz
	YwoYREiV9QAzQcknMUjzlyAlGoyDraVLwpkw98qPWpt8SvvIX0Q4+9D0nbIzHshrzcmTerZLCYl
	FaXd+uq5KMGQDw2aXtACl3iL1PS8+m
X-Received: by 2002:a05:6820:169e:b0:6a3:809c:f6f6 with SMTP id 006d021491bc7-6a39a59fb7emr8841280eaf.26.1784074800982;
        Tue, 14 Jul 2026 17:20:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455b767413dsm8047305fac.3.2026.07.14.17.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:20:00 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH 0/3] iio: adc: ti-ads112c14: buffered read support
Date: Tue, 14 Jul 2026 19:19:29 -0500
Message-Id: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQqDMBRErxKybtDEWNGrFBcx+dpf0LRJlIJ49
 3610EVXwwzDeyuPEBAib9jKAywY0U9U5IVxezfTAAIdda5ydc0rqQWiF8ZZkZAiSqksjd3c9xD
 AiQDGCS2hdNKa3NmCE+gZoMf3Ibm1Z49z9wCbdvL3EeA1kz2dt5+8YYe6/FerQ+3yrla6qotCQ
 7PondaZCML6ccTUMHLHLMDoiZwRIaNMOA283bYPUiYjsv4AAAA=
X-Change-ID: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=aeKW+KeLL4Jt4ru7TjOuiMj8iD50qe5w7FMDtSuphn4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVtIVaqP31KnXKNtWqEZuDhzZb80WGUUInNqs9
 otIxppPKXuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbSFQAKCRDCzCAB/wGP
 wFgDB/9Ic4iL22CY+GmyYtl/x6cv72iYhcMbvkBRfCfWGuC7Tr/bE+gDwXO+2/pEw5LsOoZcD2H
 X41dXhrfMtF9UELiVR5BjgjRBxgV2wErIto2gfLpZ81KCQ2EKGkKuSy3whXqv0EnMhZhSd6qEjD
 L+IGaokMJAKSWJkI3H11Cgwa4uzx4E2NxGsJs1gtqrbqShC18qn8lFyjjdOj2xVhiEQA0jEzv01
 xFLrOVCMtYviwPIMni0rbz75mZlQ7CFCSHweYqqHX0o/LeLd5lqTbHm2ADy62pTjZUWrA3h2/DQ
 twhygGgtdGbVu4n94QwKRZiMH/WjseDWQGZw9ukvRzHTOAit
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This is the next phase of ti-ads112c14 support after [1].

Some design decision notes:
* These chips do have a continuous mode for sampling, but since it would
  only allow for enabling a single channel at a time, we have
  implemented buffered mode using the single-shot mode instead. We
  may consider adding continuous mode support later if there is a need
  for it (e.g. a need for higher sampling rates). It could be a bit
  complicated to do that though because it also changes timings. The
  timing issues will be discussed more in some later patches for adding
  settling time support.
* We wanted to enable CRC checking for data integrity, so it is just
  always enabled. This way, the buffer layout is always the same. I
  don't think we have an existing control for toggling CRC checking
  anyway.

[1]: https://lore.kernel.org/linux-iio/20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com/

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
David Lechner (TI) (3):
      iio: adc: ti-ads112c14: add debugfs register access
      iio: adc: ti-ads112c14: add support for I2C CRC8
      iio: adc: ti-ads112c14: add support for buffered read

 drivers/iio/adc/Kconfig        |   1 -
 drivers/iio/adc/ti-ads112c14.c | 262 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 253 insertions(+), 10 deletions(-)
---
base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
change-id: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3
prerequisite-change-id: 20260514-iio-adc-ti-ads122c14-d0b92479334e:v4
prerequisite-patch-id: c1c08977625bbf2bbafc19e53dcde79dadada9f3
prerequisite-patch-id: 9f9caedc1d3f82b572dfdb6599403802b0dc3954
prerequisite-patch-id: 32f19f729d27a1f3b3b4bf864f77a9a28b958e73
prerequisite-patch-id: ee6122649d9d716c023021058a1cb8ea7e94d58f
prerequisite-patch-id: b8e99497e6e6eee077330c6acca4f02baf2a6a18
prerequisite-patch-id: 10640e5e6b1414fd58124180a7510278f6315cc6
prerequisite-patch-id: 0c2d694a901eec7f25b2945b270cde91108c0beb
prerequisite-patch-id: de25580ebcfb560cc094ec3fa37c4eadc6ffac3c

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

