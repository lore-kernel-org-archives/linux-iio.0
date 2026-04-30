Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E42D5C68;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561517; cv=none; b=VK61qv7uc5leRxp0mBzp64oJ4XSfEnn6vSXRI/QWQjNkppjuaas0z1331jtpv4Myyvpb1QSqopnjn/3Z0Ci56LY2+MClz/pwhDPy9x/+RaUJzCblYog3jtzFJ4TcNXkpKPTnCTiBeXuYsBHg1V6WefECFM/RVBzB2QwddrDG6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561517; c=relaxed/simple;
	bh=diZe+qoz2LFdYgLV/qNHK+XefMfyZ8tKUWW54qfvSCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUBZyDspMVojCNuykuptFH1hdkoJfeOXmMcxOV+AsPUgRLMsiFG8mDg+dyLLalM/Qzxokqrm+R+TATR1HcLf+hX5IH56wNORSaRX54/lA41xvm1PsQgBc5gRXntzIKq2ZRbyagqgBe7QOO/MnrbMDKjt6k9nvZPFXkcXeZbc8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkxcGQUa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkxcGQUa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B8A6C2BCC9;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=diZe+qoz2LFdYgLV/qNHK+XefMfyZ8tKUWW54qfvSCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jkxcGQUaa+p/uV1SIUVXIQQ+MQcQkr0DtFtsWny1F3EjZRGNZpP0lXpH7Z6fjoJ96
	 7UIDd7VVNmERwf8ZjCbBNTscDPCYEm5IPi2DD9GbWv9Zb6IJdLtEBEtDvwq4bCwgRO
	 47EOG8irL8RdfFI9c4pdifCV1+pV8NIusJgmduWC+YHoXVnMT5R9fvEAe3Ha4u+T2y
	 clJDYOrp+b1HH6dmw5z8TLs3YtgGZ8P6yofHp+QJsZx+h9CVMMlDOAg8TFyfwdkSCC
	 AJxiJ75YQM42BCjFm7quTFqJUDAqliZkbPDg0DBv47/X76gvKrHQgdFKeZur3FItw+
	 DABYxPoiQnqag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE67CD13DA;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 30 Apr 2026 17:04:23 +0200
Subject: [PATCH v4 3/8] iio: light: si1133: remove unused macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-si1133-checkup-v4-3-fb3e9dce41bf@gmail.com>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=1046;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=7K9lqxMczl9Rl1iwkxbifs2o+8+pT5IUZAPJUPkp9dE=;
 b=RGBqxLa2//dYpN21QvMHjOUEJCtWMfCZ6+bysFAEKKbNizFuvdmLGd3wNluu51lvaSZ8xTX1k
 gAaI/DWlOTOCbSO/gQcce0xL/uIhpl7NmyvpQuPh/TU8CF1KE3/Igab
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


