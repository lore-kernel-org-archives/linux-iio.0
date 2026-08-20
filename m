Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AE2E7396;
	Thu, 20 Aug 2026 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217602; cv=none; b=AGx53XgNi5LftsqkxtZZrdBBfInOUGn0eQ5mz+iLSYL9zpWl3WRkPQawI6TJstNmk/5K3ePTH70o8RrpNDtC5OU+hll+OShR7kv7W6wxAK/Vk40WJI+3FnutDJ21UcImDsfIgY2Zd+ZK9uB3W3UVlGlLNbXOctDl37EDZ75heAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217602; c=relaxed/simple;
	bh=GDkscfBlKTe9zRPq74kQKsmDf9WeV+quGRygXCTYRSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rREW/thrDlqN/3PZxTT0sfR911ac9WHMH1UVDk17HxnYPL8exy886H6f9UtySEzYmWWDyPdoIpmRCXTNoHmJJ6wRxt7OpM8bVvOUisVnB8pfOh1S4IXVofhLFAQCO4XJiEljKQ+bvDcl/rn4V/e5sW9wfiVr4iUnhI+psNYIK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7901F000E9;
	Thu, 20 Aug 2026 09:19:56 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] iio: frequency: adf4377: Fully initialize clk_init_data and clk_parent_data
Date: Thu, 20 Aug 2026 11:19:52 +0200
Message-ID: <ae48ed1dc6b1ad9e10cad0d9df28d9fab213f653.1787216909.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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

adf4377_clk_register() fills in init.parent_data, and assumes that
init.parent_names is NULL.  However, the latter is uninitialized, and
thus may cause a crash.

Similarly, adf4377_clk_register() fills in only parent_data.fw_name,
leaving other members of the clk_parent_data structure uninitialized.

Make sure all members are fully initialized, to fix such bugs, and to
avoid future breakage when converting drivers to a different method for
specifying the parents.

Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

v2:
  - Extract from series "[PATCH treewide 0/5] clk: Make sure
    clk_init_data is fully initialized (part 1)"
    (https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be),
  - Fully initialize clk_parent_data too, as pointed out by Sashiko.
---
 drivers/iio/frequency/adf4377.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 4dd19a9aa9943c57..b8c31665857c5201 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -988,10 +988,10 @@ static const struct clk_ops adf4377_clk_ops = {
 
 static int adf4377_clk_register(struct adf4377_state *st)
 {
+	struct clk_parent_data parent_data = {};
 	struct spi_device *spi = st->spi;
 	struct device *dev = &spi->dev;
-	struct clk_init_data init;
-	struct clk_parent_data parent_data;
+	struct clk_init_data init = {};
 	int ret;
 
 	if (!device_property_present(dev, "#clock-cells"))
-- 
2.43.0

