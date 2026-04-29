Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E4372B59;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=BIkOYYqRPlrqx5VnHVMttK1/E9JMVqFQh7v9Xe9oCvonLQ+ubY1XVR7Xev3HNmgeJ6CC4XhDKkB7EwSSb8rnCS3HndTJMCCe+ba8II99NhsftN8N7qyJqxGrxFggEdzOh1RDsWvM9QObtVvQz6tFMaQz1TSFIP9K0gXz/gHE64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=7peLhzJvJ3a6wBH0sLXzb2tyKdVDBqWlJJt0IOsxTBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjq0bNWwGPGBaUu17MVexyEuRRtzXtNeis7AmFnnxP+NYs3QyKSvfTMimD7fC3rh9FDNyL00kwMq3hX/AIfSZNPf81tIYYQD0WMZxHi8y4k7H3hznv7+dbYbRB+SaemY/nx0Z2vSSnKlUu94w0ms+zFTbgqFFtYdtM/98m0yDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l51DEZxC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l51DEZxC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E12A7C2BCC4;
	Wed, 29 Apr 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475150;
	bh=7peLhzJvJ3a6wBH0sLXzb2tyKdVDBqWlJJt0IOsxTBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l51DEZxC6gkhyyml4uSpscdPiMW8Xc6S31D3shVe5bfM/laM0yZiOk+607SZWl6DG
	 GxGH8GVdFIOL/UDKjUJGneD0dCI4vIwxoE4crTmR1k7b+D7Undrk84tgCVs7aF/olR
	 WNkCgzxPagxVyObYvWzaL8LoqPV2a86JjWxubTNuM6wppFmHaAJhjXaAsTrfVamBuR
	 tG+ynWW3HQ5qPeQ7X0MRoDeyUkZNEmEjCyVIBuNoYEyMOPnKpGm6GFbHwPXQGm83u6
	 RzVEXGcmUtyWYYfw9leVXC+DrObkMbhxrDEL/YaftoYZca8LKP9txloxwG5GfHIPbh
	 RR0qJCP7d+leA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95EDFF8867;
	Wed, 29 Apr 2026 15:05:49 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 17:04:49 +0200
Subject: [PATCH v3 1/8] iio: light: si1133: remove unused macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-si1133-checkup-v3-1-469f21d960eb@gmail.com>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=969;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=Ecef6Lis4KUDy5wkginYFApj5UHLvf6O9wthv94jeNY=;
 b=VOfiDrlq/09SWdsT4tH+FwToLIP84cp1zHZoWoN1tklDogUu705H3koPJEFE1QiG7nuhOzDv5
 cMoZM4DNrlZD9bjZVO80h2qUfB+C+2nbEbN/Ry1vfS3HYYFp1QAkWMy
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove unused macros to improve readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 44fa152dbd24c26c97cc778cbe641d92ecd56afa..73b0ce21e017cd4ab6c6b280229f417763866502 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -86,13 +86,9 @@
 #define SI1133_CMD_MINSLEEP_US_LOW	5000
 #define SI1133_CMD_MINSLEEP_US_HIGH	7500
 #define SI1133_CMD_TIMEOUT_MS		25
-#define SI1133_CMD_LUX_TIMEOUT_MS	5000
-#define SI1133_CMD_TIMEOUT_US		SI1133_CMD_TIMEOUT_MS * 1000
 
 #define SI1133_REG_HOSTOUT(x)		(x) + 0x13
 
-#define SI1133_MEASUREMENT_FREQUENCY 1250
-
 #define SI1133_X_ORDER_MASK            0x0070
 #define SI1133_Y_ORDER_MASK            0x0007
 #define si1133_get_x_order(m)          ((m) & SI1133_X_ORDER_MASK) >> 4

-- 
2.47.3


