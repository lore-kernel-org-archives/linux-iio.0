Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33176374E74;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=XHc9hs97ApM2v1gC63WA0NkyfpcXC/hFzU5Tp+2FnBISKAl+MO+JlYC+yobC3CjkebKTnAZKGVI/H8ZGYPuMKyOIK3NWckTq5b8jl7PQGummnNXZMR70ywVDLQmrhVBI8rob8fFMVNgkbd6XrQEm8S+t5NGKJhkvKs42AZn9+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=AH8AeEQaXLtKRQyFjBldeZydo3TjoBIHFqCuIF4x9eU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovreIywltNqOKZYUZ57UMEiTJAN/ueCt/P/uNUBAWs4zVhfCaU883pFHe9p1tyf2rADDgM9KSqaHwEcBIQ3GOKoVxe40lxFXUSp7RxxWfye3gE62z9gp30IXhu+Pi3zXHdwaQLnorBSlCDXxWhFeRgygAhnZ0JAlbU3pFJrS19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo3knrem; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo3knrem"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18118C2BCF5;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475150;
	bh=AH8AeEQaXLtKRQyFjBldeZydo3TjoBIHFqCuIF4x9eU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bo3knremdkuTpLNTinyloswU1FwK8hFH9HR18h5+2+ffCzkBJFvRdaiS0MwaKXlUs
	 qQ9TI5o+lmv09dCfTfuqRfMn6HtR6lhPvKbntWRtW9VQ2FN+VR1S+2NfvxhVblG2St
	 BYYy14JSLMvNPpbAcd3rJ/8xIT2NE2yvsxYQ6iU8SoDqdwNwwDFjP5HGnDCjlzJfBz
	 MnxBRM3yZU54Cgkw2paSYksOh7pGn0sRe2Qd9frgw3v+8BDYsaukAHQlv/YSSu5FE4
	 w9g2NL5Ac/SRV3DrQSl5ho+s4IKcC+I6Jz2d4NMl4eZ0x/DkZgDoseySZibKXqcB4Y
	 EwkQhX4EqlIqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102AECD13D2;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 17:04:52 +0200
Subject: [PATCH v3 4/8] iio: light: si1133: group generic <linux/*> headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-si1133-checkup-v3-4-469f21d960eb@gmail.com>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=901;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=GteppT24iSohKJCdd+nKyoBWeY2ILBL0xKsDtQzzxF4=;
 b=A/pF8NeozoIdLXWf6X20ZMSVQUkjWr8Bc2xiNSeE5W1tkHpcpAif1rIgtHHC/OtNlnsoa+QVx
 HHGRZQ3jddMCO1ycnlx3rjbfNxY0XOczlDPrpsWMRErJOyaQbMDVcDi
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
index dabb1aae05535313e77441b7d066bce931de79f9..f46485304877a89eff3616c62d5d2a4459bd0c5f 100644
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


