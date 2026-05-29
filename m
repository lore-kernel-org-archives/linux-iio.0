Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2D3A9018
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051555; cv=none; b=oZ1ljcCi0+4xg/Q8+ep0tqienTpd9ihIlsZjO72K3lwfxJwzmSYEAj/lYFTBlXNkn+QIdSZhQFtxut/XOQYFKHh3AtjTQxq5bai3nui9PscAxlSiTt6i2kl6N4t23M7XsnmOHaWSwtOnUaGlkyLBzsXW0d4zGb4Qn3wR86o9o1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051555; c=relaxed/simple;
	bh=TlwOFJL7HDuGRuusp19t26F5y1lKZgyjWAU59m7tSYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mA46Tx2rvvUXx6CL5qd2iWXtY70cd9R1EXi0hVEyjFqKOFhPBQEfq3lrKLqsUAuWhsWccKk1eVsASXsaqXrafN1bYP00VrudrJYewxzuxrG+mmF+ZBKZWBFsToL09G33XkWV9QSxbEWBX5Kb1gLINp3ibtnEtW2UUthoMxwu7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAX1cYiK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAX1cYiK"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38ec6e3de84so17095801fa.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051552; x=1780656352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpcy2czVripxTHluyLjMSuAtr0VL9lenvzOSbRvXvh4=;
        b=HAX1cYiKqky+HZ8+wyMaWqLObBAx/TruTEvs1vS1rwSZQHLKif+NLc5Io//4bsqgRP
         CxhKTMc8T8prP3SqXpNrh7722/xGiZoDNfM/tMqq9K8aVR/mlW6uJLl10Hr7uNhJ6lKJ
         WXRDvgWsmD9nvvtHuGibopGa0JQ/0uoFPnBaHgmvCRWDOVQVXPxEuQR8+20paAUm/Z85
         QAwNKIZFL42wXyNOTnN5mM9GuIk6abERMpu1uX/e5Hy30R9wqlSeyu8FZGtnHdVPWRwK
         ILyDlPbSv9qMbC6M/Qh1AopRAmS0fyNmvGxtUAr23QTJYU/9b3jeJ46ns0vTsspodiih
         WFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051552; x=1780656352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpcy2czVripxTHluyLjMSuAtr0VL9lenvzOSbRvXvh4=;
        b=N0AO7B8AddCZMfTopiM92y3ssFrmzt+X1ywSLkt97pEy0rnEiGmCnrir9rIsbv5JM6
         M3ASAhYwOYOFKhPKwkE4pGSxxh/VFZB3vgs6rxmBw+rIr7U4HXYzI/ADqcAWBv3CQ/4p
         EkwoGpLspSirLmSw6VoxCjTHZ9ixANNSVKBKd+1V9qQheWTv7rxMe/p43FIQJYRQK55a
         8/+P+D7q5cYpa0LnYUlBuMMlGKl0SUABUsdIPjT7KJv57PSEuPv8eQBHmualL6SmHqoD
         obHKWiUJU/aBb5vbXWeqOlb4TVrj2iWz2ofElBY2Z5jH+9M6QB7QM32kX6SW/gcez8I3
         zV2g==
X-Forwarded-Encrypted: i=1; AFNElJ9vNdgPb1EWi12EFO3pSz4RmfBOfC1WiN8jMWIIEjJA8V0du8XbDHIPBr/kMW0CSfOnlWWQZJbLuXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMoOtLjvmZPEdpYr55X1rg7AKm52DnxQdjTrulutQt4IwXVNf
	ype83yQV9kqn/ChjbC5W2gotgxXwIRq3k1lURpC/rNJdGAdbfudgNgje
X-Gm-Gg: Acq92OHLltn2hgKVRhT8etJG1/uk6qWlCO9/J6+T/H8EyWfW+UXWogpMwcz73YyAFx9
	07Svhs+eGj2E7EEdDkoJmm0LF4j1ht3vrv95ZLYKw75xIXs6UPGb6l7yFm2qhpQdsfLCxWFFUs5
	5lPTs6SHHI4yl3FE6aBZdjCy5sfb+apx6NVavZEKqyjWJ6gcoC45R7gpXh60Y4CDa7YvKN1nyvx
	aG0LF+Pgw0lEEa/zjv1IWVhCFllrKR+IHiIiTNzCk9x8YkZ4JzqZ/oAfxOuoh0Oq+YG83hwQPiY
	TVyk/WWxm5ZL/5dRzvG+39YZOK2en1gWted2HoTvk4MpNB31jrg6dTXz6IWLOkiE8qCZPjYsuUX
	T2zjNBmtTnvacXE3UlMIX0VNpaGMp2SNgekoKHHReSm9Ky+tc/yOQPxtfs94PhpltZ8ehcCRMny
	wEunadVzrU4aKJB/hjPnRIar1GF5wMKdIymwUFcQnBfIVNzQwpA4+jIsU=
X-Received: by 2002:a05:6512:2210:b0:5a2:7798:9990 with SMTP id 2adb3069b0e04-5aa59463bfcmr362923e87.1.1780051552305;
        Fri, 29 May 2026 03:45:52 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b788811sm192604e87.63.2026.05.29.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:50 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iio: PM-enable leak on probe error path (goto-variant drivers)
Date: Fri, 29 May 2026 15:45:40 +0500
Message-Id: <cover.1780051096.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the goto-variant follow-up to the standalone ti-ads1015 patch and
the 4-patch series for the simple drivers.  In these four drivers probe
calls pm_runtime_enable() but the existing register-failure path jumps to
a manual cleanup label (out_err / buffer_cleanup / error_power_down)
rather than returning directly.  None of those cleanup labels call
pm_runtime_disable(), so the runtime PM enable_count leaks on probe
failure and on subsequent rebind.

The conversion is the same as in the rest of the class: replace
pm_runtime_enable() with devm_pm_runtime_enable() and drop the
pm_runtime_disable() / pm_runtime_set_suspended() calls in .remove().
On the new error path from devm_pm_runtime_enable() each patch jumps to
the same existing cleanup label that iio_device_register() uses, so the
manual unwind for the non-devm resources held earlier in probe still
runs.  In apds9960 nothing is powered or registered at that point so a
plain return is used.

Standalone precedent already on the list:
  iio: adc: ti-ads1015 -
  https://lore.kernel.org/all/20260529101011.3030-1-sozdayvek@gmail.com/

Companion 4-patch series for the simple-return drivers (isl29028,
tsl2583, mlx90614, bmi088-accel) was posted alongside this one.

Stepan Ionichev (4):
  iio: light: pa12203001: use devm_pm_runtime_enable() to fix probe
    error path
  iio: light: us5182d: use devm_pm_runtime_enable() to fix probe error
    path
  iio: light: apds9960: use devm_pm_runtime_enable() to fix probe error
    path
  iio: accel: mma8452: use devm_pm_runtime_enable() to fix probe error
    path

 drivers/iio/accel/mma8452.c    | 7 +++----
 drivers/iio/light/apds9960.c   | 6 +++---
 drivers/iio/light/pa12203001.c | 7 +++----
 drivers/iio/light/us5182d.c    | 7 +++----
 4 files changed, 12 insertions(+), 15 deletions(-)


base-commit: 7cb1c5b32a2bfde961fff8d5204526b609bcb30a
-- 
2.43.0

