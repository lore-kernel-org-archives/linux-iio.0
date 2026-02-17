Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150F3242BC;
	Tue, 17 Feb 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323811; cv=none; b=PCeT6cQxr4z7iWBaYHDPomudrPytD8KdvE7zxT1mr5wUKZL5qaHbJxW+NpGKh94fKHrguhPhX1uokK4+fpq5njYFlj7mgzqjasquNQdtxfYQcJlhOZgqsqCRmjgo3ylkcX3rfm6yup1oO/auilcgQ8GYQO5KvOoaqId0GOlXRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323811; c=relaxed/simple;
	bh=3OBvj/BQDbaPGFFl/kIrB7KUIA0fjprmv7Ti3sv84DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/av9z3s0wkoaaY5VSKId09eqPAT+erUKLZfMPqYuCUdKW/DdN6mdxp8j3ArQ5xVXUk2WQpkx8dFmeTr5QsF2Jg5o6DfUH43MQc57B5A6MqBiuNYKrtV44O5hmAgwyobAWh6atSS5U5awLQySZFRguERqaeOStXW3EjMnwFJnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmRqbBLz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmRqbBLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323809; x=1802859809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OBvj/BQDbaPGFFl/kIrB7KUIA0fjprmv7Ti3sv84DI=;
  b=cmRqbBLz0BGnsUYzSbavyYR84jtPuS4/+TWY9CVBu2Z5brhznURPbJNe
   iwvNDsKoFFIHGx8Y2/5QQ+A2yNE0jQuCP5RHJoHPiyvO6Iqb9bnAtE4mo
   JbHMe6GO9QBi/XaViy4PHmpyet3mmhK7fnm+ZC4at8/n/7BtoBLbyYlwo
   s4vCErsvO0/NroqZhuF8B9yMys/lJxk5HbWqiDmXk30PSXEM444F78RoY
   DPZD83V1YGD3sUH+ELVHecfctVEe4TSVXPTc/GV3XgsUJjzzkMr2zbzju
   r4bWuJ52WU3RXTVIffGF9kGcieZ/1poUF9Za0DUZuB7DwudrmNt66v7Si
   w==;
X-CSE-ConnectionGUID: 48E0xAklRIKy1U0JeXnEug==
X-CSE-MsgGUID: a2ni3mxiT6ipWRhJOAXgXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72099192"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72099192"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:23:28 -0800
X-CSE-ConnectionGUID: Dmf5qDUxRPWBkev/Sl2Keg==
X-CSE-MsgGUID: nBn/AEfVSWOoJDEnUqQVEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236851657"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2026 02:23:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 68299A1; Tue, 17 Feb 2026 11:23:23 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v1 5/7] iio: light: gp2ap020a00f: Explicitly use string literal for driver name
Date: Tue, 17 Feb 2026 11:15:15 +0100
Message-ID: <20260217102318.1354103-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
References: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver name should be easily greppable and clearly spelled.
Replace a level of indirection and explicitly use string literal.

While at it, remove useless blank lines before module_*() and
MODULE_*() macros.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/gp2ap020a00f.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index af5eb77cb8c6..95479154b6a4 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -55,8 +55,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define GP2A_I2C_NAME "gp2ap020a00f"
-
 /* Registers */
 #define GP2AP020A00F_OP_REG	0x00 /* Basic operations */
 #define GP2AP020A00F_ALS_REG	0x01 /* ALS related settings */
@@ -1543,10 +1541,9 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id gp2ap020a00f_id[] = {
-	{ GP2A_I2C_NAME },
+	{ "gp2ap020a00f" },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
 
 static const struct of_device_id gp2ap020a00f_of_match[] = {
@@ -1557,14 +1554,13 @@ MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);
 
 static struct i2c_driver gp2ap020a00f_driver = {
 	.driver = {
-		.name	= GP2A_I2C_NAME,
+		.name	= "gp2ap020a00f",
 		.of_match_table = gp2ap020a00f_of_match,
 	},
 	.probe		= gp2ap020a00f_probe,
 	.remove		= gp2ap020a00f_remove,
 	.id_table	= gp2ap020a00f_id,
 };
-
 module_i2c_driver(gp2ap020a00f_driver);
 
 MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
-- 
2.50.1

