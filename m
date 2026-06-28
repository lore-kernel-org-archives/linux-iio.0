Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FB31C695
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618509; cv=none; b=AHojbpQDOqVd2JTqg6lQ5f87RmbGQuRKyrc1OV9JZuz6fDa6hhob5e55pcRVHVbTE0cAdQuF4rOiXp6tvtpH/KITg/IHyy3p2/LkGz5GdCEa4lMfEuJeFfMFlD751PBS6KePc2O+47sQHrR3zExU6M3vPYR2edkltu4sU3kS/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618509; c=relaxed/simple;
	bh=55O0C8kPbb/Kbm+kvEwq8zaAwqD7frc0KuTIOqrVx/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPRskkUmauMLR3EyMzPg+YuX+uGbpAw3tGiHOdKt/RpfULNZ6YZOAAGpXN7QS4tuYYGWoN1Zqw9rBICrpx/edyIvZHwwbQ4msmoM2XbfchCi3frxFAEq1WsG+c5kZ4SME8QUmXFCQHnI0dwRTfqymOdeMMhz9fzvkMMOPRasmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=LeJ7Ryy1; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="LeJ7Ryy1"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30ec1ddd510so210430eec.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782618505; x=1783223305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhzU8dpaCyIXiEyuzJd8xuufkXFBUMVY+bJhlKTgFgw=;
        b=LeJ7Ryy1En6tgPFC47Fmv7rvguP12J/kHfkKZHUAw6t9ysp/X3btMAS8N04Rs3PdwI
         7SBqTHoSW8/5e8jOuPK5DTWDM42W9zONTNjzoxKkzevHlSkLZLqdT2zf4J+gGoShhl6Y
         yNfXqcIVTGGrMinIyylLofDTcFToBHd63z/WztLUkM9TltZcD+T7S++Zs1RcGRJJus3u
         rCxCGFOwucV56Ezc4ctIwehAN54dJzOtIF9H8EiEuFwLxkix7U7YJQK1p6l5rkko14rW
         HcOcDJSqO2bhDUCbhUJ9lsBXitHkfNIxldL+KJUZ7lMhOO2tKOHiuanJ9Qb47zoWWoSJ
         zULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782618505; x=1783223305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhzU8dpaCyIXiEyuzJd8xuufkXFBUMVY+bJhlKTgFgw=;
        b=A9ZBW8L/cwH2uNz6CSkza9sm+GxdwFn24WCF36sMgksgsbvjJORUNwc183Aw0ekou9
         fe0/REMjZ+MYWlBSaBu9GweuKahoeZRJGRHC1HYg6iwM+Hf5ITjCVLQCuy+hWQFgAa4X
         UaDb3Y3p3BKnRZJUbJFyjfbNeY+/3Xr+OyXhkA2tbaQVvutPIc0KAD7HAS1JFdNiB6C5
         mw0YmPkRKuZskYdaq3Jhji1rqMYuph62UznwC/ava9b8Y+ewHvJipYOMhb0NhsiRiteQ
         aLwHNgXm353Pdr9qPFH+I9hJSzkwvwgPAkZS8q0iUExO0uzJDrpdTMzbgJlNVs8PrP+s
         CGyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWculkpvQQXUSBGZaV64+XE4cydvPuykEhcerMIQ88BLryTn1QqoMTjaJvCOxSGcoHDHIACr9sCCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY4SApVY6bJJyVuXWpqXRN23jGmCFi/QBhCzKP8bsOx8Pn9Yu3
	bR/Kjr5YyTSGalAjarLdWXGX5FaimhbwRImyNQq9F7fHaXOZAbVltfKb7SE6bdmO+HY=
X-Gm-Gg: AfdE7cneB/749Ik76c9VjK5n+Wumb/CXv1oFKo8RyTVyLB+1bxpS0rgRxJq2ek1/vnz
	GsMNrRk29qm9HkqKzwsXR84TVeMb2E607shes3g7UctuvqVRTBeH+4WG9CCI+SGwh3iXr2LDOOf
	skAEueuPV885ktfW4FmPlb5lbPdfNRdtDqM1rjDVfOFeoPKE3jAgF/21DAJlrVz03SJtabNcfE7
	32fJlQE4+EEp/2P2lIl+hiZPhs73S2BWxKwpPdhTdtrPdhKz2IohivxGV3kNmumRU0C4jCZfNp5
	MN23GK93jpCwCu9xGVUWOTQjd4b8+cTjSVVDUpYO/2FiVdjguUaTf0Q99Cn53J2Gli/QtLJt5GU
	W/Go64h4yc6M7SW/Ann+uMfzYke4hRtCzFq3PwNPl1t0ZCUSkR9cug4OVloWy8eHxShnD2zSell
	Q6yV2gSd48wc5pNg4NuzQSVkWVN+Y=
X-Received: by 2002:a05:7300:214b:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-30c84630554mr13540625eec.0.1782618504572;
        Sat, 27 Jun 2026 20:48:24 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:dab8:1927:ea27:9d41])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30c7c52d669sm33986317eec.11.2026.06.27.20.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 20:48:23 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v5 0/3] iio: dac: m62332: header cleanup and guard(mutex)
Date: Sun, 28 Jun 2026 00:48:08 -0300
Message-ID: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the m62332 header includes and converts its locking
to guard(mutex).

Changes in v5:
- 3/3: add an explicit #include <linux/cleanup.h> for guard(), instead of
  relying on it being pulled in transitively via mutex.h (Joshua Crofts).
- Picked up Reviewed-by from Joshua Crofts on 1/3 and 2/3.

Changes in v4:
- Split the include cleanup in two: 1/3 only re-sorts the existing
  includes; 2/3 does the IWYU add/remove (per Jonathan Cameron).
- 2/3: drop the unused slab.h and add the specific headers the file uses.
- 3/3 (guard(mutex)): unchanged from v3.

v4: https://lore.kernel.org/r/20260627132530.96680-1-erick.henrique.rodrigues@usp.br
v3: https://lore.kernel.org/r/20260418130322.106769-1-erick.henrique.rodrigues@usp.br

Erick Henrique (3):
  iio: dac: m62332: Sort header includes alphabetically
  iio: dac: m62332: Clean up header includes
  iio: dac: m62332: Use guard(mutex) for locking

 drivers/iio/dac/m62332.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)


base-commit: 4b570552ea4788d49373d3e31c5a802210f4ac45
-- 
2.51.0

