Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C849441021;
	Fri, 21 Aug 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306664; cv=none; b=Od8c8xWoC0AOdmqWZYfafRCWbK/FfGD/HaoeiXL8YDvGg3tykWr9wGlmMV5hnGRPjfSAWt73TG4dcaz+T69UH0IlxNdbsS5pQDqJnGoTqxg9x/RPHlF2CAGRoOYhAIGzv92rFldZzTM41Wm1TvopAQlbnQMfPvRFjMmALsaUsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306664; c=relaxed/simple;
	bh=iZ3IHs2Lvi8ZrtBzrxkUukWL4HhUYLJhBJ5T6Z9Bp6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOlKBzqZ1pxghUut+oCgOeww6iNCrWEVdt5R25eBO5ptWRk040Qh+IMbNhB+tNsYChd7mec24CaSdc0QMnF82AiQLLlx7xGeHSNqNWr1EAfFk0yuS83I3uAwA0rVXqOExmEG6TH6cAAZ3kgcsW6Prt2HsG375551YOYayBN0D/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2731F00A3D;
	Fri, 21 Aug 2026 10:04:12 +0000 (UTC)
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
Subject: [PATCH 1/2] iio: adc: meson-saradc: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:04:06 +0200
Message-ID: <7470364f0d70b6e9c06fd094768cfa91c7784d42.1787240005.git.geert+renesas@glider.be>
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
 drivers/iio/adc/meson_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 000e39ca5c624eb6..7b89e2ecd0248b3a 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -739,7 +739,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *clk_parents[1];
 
 	init.name = devm_kasprintf(dev, GFP_KERNEL, "%s#adc_div", dev_name(dev));
-- 
2.43.0

