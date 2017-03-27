Return-Path: <SRS0=6mYY=3E=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Colin Ian King <colin.king@canonical.com>, "Paul
 Gortmaker" <paul.gortmaker@windriver.com>
Subject: [PATCH v11 12/12] mux: core: fix error handling in devm_mux_chip_alloc
Date: Mon, 27 Mar 2017 14:17:49 +0200
Message-ID: <1490617069-13119-13-git-send-email-peda@axentia.se>
In-Reply-To: <1490617069-13119-1-git-send-email-peda@axentia.se>
References: <1490617069-13119-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The error handling is mixed up. mux_chip_alloc() doesn't return an error
pointer (just NULL on failure), so check for NULL instead of using IS_ERR.
devm_mux_chip_alloc is documented to return NULL on failure, so fix that
as well.

All users of devm_mux_chip_alloc() are coded according to documentation.

Fixes: d47598cc669b ("mux: minimal mux subsystem and gpio-based mux controller")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/mux-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
index 900b88526f97..66a8bccfc3d7 100644
--- a/drivers/mux/mux-core.c
+++ b/drivers/mux/mux-core.c
@@ -166,12 +166,12 @@ struct mux_chip *devm_mux_chip_alloc(struct device *dev,
 
 	ptr = devres_alloc(devm_mux_chip_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	mux_chip = mux_chip_alloc(dev, controllers, sizeof_priv);
-	if (IS_ERR(mux_chip)) {
+	if (!mux_chip) {
 		devres_free(ptr);
-		return mux_chip;
+		return NULL;
 	}
 
 	*ptr = mux_chip;
-- 
2.1.4
