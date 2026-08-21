Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC73D952D;
	Fri, 21 Aug 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306669; cv=none; b=amdBfGCNbbj8DkCkICT6oRfjLzmsURSiVxOLZo/kCyFwdUG1BsWkO0OVKRHvDI96rTHdXmuAukAJ0y2Z4P81TmTXkZmcvQ63EMhHmUVPTfWQLAXSt4dPjhB1FqxV6v+r5F8tsrXoyxWgy1nTfWHBdhZCESMuWfRnf9dJPnD05Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306669; c=relaxed/simple;
	bh=WWm1xuY0hGHBT6giAZ4LDCkztIgcorN1wa3PjyMroC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGX/IAUiXatPQIAg8MsWNi//FLtF1aSYzmEWvdmoOcT5PAdvYwj0lwRCwO7k0Q1LrVoDav6GVJfp+p/9ch859lXe38OcehfhZ+vJUEuJLbjs3Li0K2haA1YfZMntqUGhC2a5KXEKxTX9/nSTA1j2hrg0YQvY8RHjydeMWTTVxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907011F00A3E;
	Fri, 21 Aug 2026 10:04:15 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] iio: frequency: adf4350: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:04:07 +0200
Message-ID: <a9cbab64882734e7b198eb4f341dc8908d5cc394.1787240005.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787240005.git.geert+renesas@glider.be>
References: <cover.1787240005.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Make sure all members are fully initialized, to avoid such bugs, and to
prevent future breakage when converting drivers to a different method
for specifying the parents.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/iio/frequency/adf4350.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 315317d6eec412f6..2e1f55d652cb14e6 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -461,7 +461,7 @@ static const struct clk_ops adf4350_clk_ops = {
 static int adf4350_clk_register(struct adf4350_state *st)
 {
 	struct spi_device *spi = st->spi;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	const char *parent_name;
 	int ret;
-- 
2.43.0

