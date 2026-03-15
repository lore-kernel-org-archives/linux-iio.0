Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540F339870
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773579318; cv=none; b=VYALuzOJ80WWTYluG0hAPQ+algriE42Iqu2+tEiuZECX6tcSoR8Yker008qtJwACnvJE0+l06Cf2a7vGTwI09biHRm61aKqtsu12laV4Bdjl6nFRp0r9+HYakIAp442yT8Fw/IdS5p0YmVhGJQbGehY8OPp6WIKs+BM2DwGNGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773579318; c=relaxed/simple;
	bh=SqqF3NHdDutdnp1KJlrjX1XbtQX4D8rl5VcVEd7221k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=obCuV2nCceYIPuNKwopadNF+SrfDeBAp8THbm1X2jzT7vhBHfVZ+s5czapxS8m/TL8bQBpZO9dilSavE4Z0J3f6WH3g5iFxuxgmtEu0tli5VA6kNtleGO1Dc2b4x3bRm1hF+Pr6HIZZja01N2uR/Mm60RbMokFBoif2eE+czCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHd3f6yI; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHd3f6yI"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c73d251b93bso1512935a12.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773579315; x=1774184115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/7N6qFL9yCwYr0yebdLpbXvbTBBPGQnjQk9NtqQ9VI=;
        b=QHd3f6yIdbENyaptLYckX+yM67tlLPiXxDnmPWPxU7aOCqCYkO0VxkMYAePxWpSYqj
         qfMChn8fzYcjSHeDt7JnBy3tfP9bgKqc3SWLdrUPCscu199BgcKakMR815+2U9PUHWob
         J2YNlMlKbRAHnJxzox/ghDDZAPZlmk9K+OioPROV2bvwfCEYhhU4cnNTYmqR2YHTPReM
         xQ1eZu3tQTKZOu9EeBk1iWRPokXw7HJNXoCWxyQUhLkHfa9XS6qszkzLMdnXWVfDuvZ6
         nGYn6H00WJtFknnzgEzB14iQNJUllrxWZmyl9YhTBgNCjjWbDvohCBJW55vYSlTINGz5
         JOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773579315; x=1774184115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/7N6qFL9yCwYr0yebdLpbXvbTBBPGQnjQk9NtqQ9VI=;
        b=BNGhNqHDX8aV3JlhKjxBARzTX6bg4qoAtMySUySEfMq52Wi3pW5gm/nmKaRccf3H4B
         DotcPOIsqJ6r6bX8xANFjuLSPx6YjGVpiJcWsO8844CknHG/OQr+BhIr43uuIo6prycL
         3j9mNjI7e/r0NQoyl5HRxU/zhKqk3gNk/rdX1xVXMncFwT+VQ9vVHrUzBTl53KwKRoBu
         +ja08Ge/sm+Qcev+eICffPi4+6vTgSsrvREDVz7Y+gPZrPSC9VzpBrTxgl76Apf60K6l
         d2kGDKfoyL1kpflZW9Sq5GK+vGkKyEvHsjdJbMtajryCN21gM6ff2o7juaGHIUF5iMUR
         AIvg==
X-Forwarded-Encrypted: i=1; AJvYcCU3+tNfYLybdas2Lqq9cHTFSDG0rHMtucezkBg5Y/Ad+ctQx8A0c4j3moBzut5Xod26VuaQ58j7M6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBN3KNr81C0ng5fhqyQoXj8yQnfqFJPxVhU8ZVjn9zetaR9FYh
	vKw+heiJU+Hx3HmBJaMP1z0D/F0VE1iiuEeCNe/Edkvhvbmh7WsNvadb
X-Gm-Gg: ATEYQzyupcTcX8UwE1nhC6J+PJP2Nfn4WzsYNrIsMV5pe6nTKDh6uvy314uV+e49ZJh
	wDH4NCWjhSqbhrb6GkpNp8Ll89kgh03TCRVfvzhtN//F5QB7gwckVkxc//oODEGgmM2eZiKMHQI
	JLin1jgJrabopmJ4Xqr5hjfDZbhgzkVQekxz+fcMmc7PlVjqP5kJ3sCdTUhwLrJQC70Je7phW5c
	Yi7q7p7GDMWY4Z6dGMou/j72tWpN93F5ikuxZsTV401W6VzDX+WtxTp8PPTHE+GaddmMKis6n6m
	YzxkYO+1WeVHRPAh8kHEcysfI/snJg4+fpETcqaDT0Z2gg8BBKQC5lQ6TFujOHGkiBB48XK8ZzT
	k3Mf3eJlT9j2VFukErbvhRlpLLqg+EpM1JS4EaBoPhD3ffJuk41nDn78ufhJFgv+K9zOeJAfgZU
	0nTIhi/f+BuWHHoabWuYrkBoH0KKwAv5vMvF2Ch4B8kiXma3oK
X-Received: by 2002:a17:902:d501:b0:2ae:4ef0:168e with SMTP id d9443c01a7336-2aeba49a83bmr138025815ad.13.1773579314933;
        Sun, 15 Mar 2026 05:55:14 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece594b4fsm72931565ad.20.2026.03.15.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 05:55:14 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v3 0/3] iio: ssp_sensors: improve resource cleanup with cleanup.h
Date: Sun, 15 Mar 2026 18:25:06 +0530
Message-Id: <20260315125509.857195-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi all,

This patch series improves resource cleanup and error handling in the
SSP IIO SPI driver by adopting the recently introduced cleanup
helpers.

The changes focus on making probe/remove paths more robust and easier
to reason about by reducing manual unwind logic and ensuring that locks
and dynamically allocated resources are released consistently across
all exit paths.

Key highlights of this series:

- Use guard() helpers to automatically release mutexes on scope exit,
  avoiding missing unlocks on error paths.
- Simplify memory and resource cleanup by using the __free cleanup API,
  reducing the need for explicit goto-based unwind code.
- Address minor codestyle warnings introduced or exposed by the cleanup
  refactoring.

No functional behavior changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Based on:
  <linux-v7.0-rc2>

Feedback and reviews are very welcome.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (3):
  iio: ssp_sensors: ssp_spi: use guard() to release mutexes
  iio: ssp_sensors: simplify cleanup using __free
  iio: ssp_sensors: cleanup codestyle warning

 drivers/iio/common/ssp_sensors/ssp_spi.c | 76 +++++++++---------------
 1 file changed, 29 insertions(+), 47 deletions(-)

-- 
2.34.1

