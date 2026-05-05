Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A63DCDA0;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966308; cv=none; b=H9btBX+XIUyl82CjDYuvYXxOvW7Ddkk1FA4FUhFL7s/xi2eGhWpZBRW3D2AXQCaoOcLjcorblygDe4NmSa1+tA8pe12NTLISmgfVKso/2SW5qLLsl7+DBviROgvXto3nrrLp8H8VjELBDp3S7VVIg2ihH8wMfavJNhQO0lvvONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966308; c=relaxed/simple;
	bh=9nPDJMjD5krGbgW/NDTBmSr6zU+lGhs9sW3ch11JrR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NN00uC9jpqxqKmAyGDbjzrprKveigCbr3qFV9Qh5u3CUnfmGl2edQYoxRfbHYohdelAMYh3hQlFSpOHy2mz7EdNcQiuC/OzBcdpZhzu5nE2GnNfTxbJ8TwIhfkx+kWT4HD5gngGCBCge0pyQ6qsF8UhmfCobBcds2AzmcRzgBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPcyxC0Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPcyxC0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79225C2BCFA;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966308;
	bh=9nPDJMjD5krGbgW/NDTBmSr6zU+lGhs9sW3ch11JrR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CPcyxC0Q18KWWy6vdruZXKB/jc9yy0qf54isOmfhCRS3FIDGZecFys2Ty2ZnWcD21
	 U2pYKaxdeIn24s9N6Q8h482kDoHIQBD9Kx9f49c4YWFK9D8Q6/G6q3yK1gdhnL3OOb
	 /EhLJq7XhdWvyOlIx8O6hiA08r6GBxai6cVWnHbU6kI5b66c85OiEZFOE86cQZMJAh
	 ZkNq+f+G6TF+I2qUfIsgX06YndwaNrpcWE1KWARwDji80KUUOMPeS5225Fx/uEhmt+
	 1NVqu3KsBR9/4A/3Bqd0vk22nM6ZG/xrif7kwnQsHV0DiAUXjLSAb1PzPGnNzVdMIQ
	 qoOBlpPQpVDlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF94CD3439;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 09:31:28 +0200
Subject: [PATCH v5 3/8] iio: light: si1133: remove unused macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-si1133-checkup-v5-3-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
In-Reply-To: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
 =?utf-8?q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777966306; l=1112;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=rX7kt+GWclRAq56MxMRYvzG3J4ijOi/XQxyRJ1r3WFc=;
 b=nLuZ1+sreBH/jHGa0mPLFZ909O4YgL6om/lKIUQv9XIi6c4Ob35BgKLLS1PQKi9x4tP0qE7TG
 N3JEEY/F0jKB2Lej79CA4bJWTC6IieS/R8PE1YAHG5CcxUk8mVascLI
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove unused macros unrelated to hardware definition.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index bf7bf0f1631d49a1d04b89f172646e4afaf46438..ed9b3e0a12d66d749f09f570de1ccdda2174b6ba 100644
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


