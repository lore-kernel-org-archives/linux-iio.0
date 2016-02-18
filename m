Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32180 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426448AbcBRPv1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Feb 2016 10:51:27 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, daniel.baluta@intel.com,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
Subject: [RFC PATCH 8/9] i2c: i2c-mux: Allow for NULL select callback
Date: Thu, 18 Feb 2016 17:53:13 +0200
Message-Id: <1455810794-3188-9-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Adriana Reus <adriana.reus@intel.com>

Add a check in i2c_mux_master_xfer before calling the select callback.
This is necessary so that NULL callbacks can be safely registered.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/i2c/i2c-mux.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 00fc5b1..74d1700 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -46,11 +46,12 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_adapter *parent = priv->parent;
-	int ret;
+	int ret = 0;
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = priv->select(parent, priv->mux_priv, priv->chan_id);
+	if (priv->select)
+		ret = priv->select(parent, priv->mux_priv, priv->chan_id);
 	if (ret >= 0)
 		ret = __i2c_transfer(parent, msgs, num);
 	if (priv->deselect)
@@ -66,11 +67,12 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_adapter *parent = priv->parent;
-	int ret;
+	int ret = 0;
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = priv->select(parent, priv->mux_priv, priv->chan_id);
+	if (priv->select)
+		ret = priv->select(parent, priv->mux_priv, priv->chan_id);
 	if (ret >= 0)
 		ret = parent->algo->smbus_xfer(parent, addr, flags,
 					read_write, command, size, data);
-- 
2.5.0

