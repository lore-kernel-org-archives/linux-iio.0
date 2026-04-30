Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124242D3733;
	Thu, 30 Apr 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561517; cv=none; b=eYPHfCIVxo2tNOu/CVsobMh2FJL5KvltpYENu/BEtm9NTR/UR4TOjafIisFNo/vuVuD5UbT62xHRWyFY14MVhBKF/BsSIxQW6ItVmb+vjRZ9wo2m7XQu3VqA6jSDuCUOQMQwe27MDwuyhjWzJSytam/M6zLHh0Y2hXgLD/aQXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561517; c=relaxed/simple;
	bh=CBh93jUwqVx1FmHtn3QU1AlavWYn0QlB7aV3IfarJZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwdIIIbHrj1m/DxfNcw+l2Yks4u771+7V5R5wusczkFqLSEy1W2lhcQFolEwD8IUVuB7PnkCCLQQZa5lzzpv4+Yjs/SCk9uu7A5PpAAOHis1Gov7iJA8LdFFpLkZzQb2evS8QCqCCVWe97nDzqFg7+EJxncGEkD0eB65LRtS9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPtdk5zs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPtdk5zs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B618AC2BCF5;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=CBh93jUwqVx1FmHtn3QU1AlavWYn0QlB7aV3IfarJZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HPtdk5zsgUBzQeZqXAvX0Nfto0oKVO6aC6j6kvErJ83z77Ioay5LvB/yqN8iKbjeX
	 VWdgUzfQ83+99Mc6qOrbSn8G5aCaE/ofPju/nbiydHiNVU16Kb7SWTC6hfHJQrdCr7
	 /oON0IQKZ2gUtPXulh57LrVxNYD8OtVAVgsnsEPzffM1EL9NqlO4uQWh4TyQ24lJQZ
	 p/NlNZbYn8snNY9eUCT31J0CKFMaSGbVweqnMx8bfnpCPk2JH8fgUmOawhEuY6VsGV
	 GSqjNo2Vt38D+ZNcPsTaxuEp/cqpxLFUIGdzHLK0Nc+1hjk/p0/KG8nSNZgfatwcQE
	 +PlSBwhvyT/1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA5CD13DA;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 30 Apr 2026 17:04:26 +0200
Subject: [PATCH v4 6/8] iio: light: si1133: group generic <linux/*> headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-si1133-checkup-v4-6-fb3e9dce41bf@gmail.com>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=901;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=ONajTyOwYWFLpIXERWtWPSYo2OZuZwtQVCrvlP4IvVA=;
 b=zFQ9q4yHzYzchaZOHJ0HpqICQ+p88AI00TjJdoTLw5icaEP6DfGiKfK1hsrfjbDjdi6MGht+C
 mq1U5aXqqi/Bm0uAKHMXplGuaj7r1J60acP1QUw4qmX2izffuaf0pMm
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Group generic <linux/*> include headers to improve code style.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index ab66a5a9ffb4a89bbba7474b6e984ddb61cfeebe..fdffdee16e493277d95c369ec2f6c0678cf9f61c 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -21,14 +21,12 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/util_macros.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include <linux/util_macros.h>
-
-#include <linux/unaligned.h>
-
 #define SI1133_REG_PART_ID		0x00
 #define SI1133_REG_REV_ID		0x01
 #define SI1133_REG_MFR_ID		0x02

-- 
2.47.3


