Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A83334681;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433068; cv=none; b=fiJm+oOi/sQkCLrePqDzCLCU52jkuD21PetGTvpQfQptE3KYRt4DQ23vfaYRxK+TqSkK+6QDMyWAuZ3ZBL2kJww+IoCysGWhjxEigpnUMEOCAFh3TobTIB0RZ8lcIwaXQ/kruU06yaZkwAIz/UcSgN442/6OzZIJ0lwGuSSwss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433068; c=relaxed/simple;
	bh=8MhduG14jsXaL5k4h11ocWyrck/47G7XvTTKiN8VDTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKEeFm+eQZsg6VJ6mMdURPDxbZV+9qm73zDB63sC716xuA725Z5bSpvsX1OX9KGVvrL2zt0Z7JoVMeaEQYOKjjEzf9XEKITV2JRQ/swkwgNLsXiEKhnd1boQx/V2M2J7LpsL0DriqRrQ64GlHyA6ZCv5SMkQTY9JipnlxdAn0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P59DkgHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P59DkgHF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B501BC2BCF7;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783433067;
	bh=8MhduG14jsXaL5k4h11ocWyrck/47G7XvTTKiN8VDTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P59DkgHFy5gVzXQfL3n/ORibFCSiEzmB1Agsf+IAokkRAUctcjlCrQ0nruoO18jmm
	 65StfRi68U6Ig0PHAnjdbqditDA81IsoKwL+9xDkCsiJmDF1B6/L1CUewysbNaZ+ne
	 7VfBG9xlBffaKCCi+ghV1s96LYHeC8zv4cMng1yOqH5EgiiCSJVDqXi8mQMyQ8+R2s
	 jBFqSyQHvKxjzVtKbiE72lfEvcdnK79J4oWJ+ShPqif0MN8AyTmA1o2++diVcNCyUo
	 Q7QI/TCgD5yvLjzfbVMrysaXnZq6zaHc3GNoKwbzuXLWm7N0SEu/GNx/BjouTf5+Nw
	 Fp7HOxGNYGVQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23AFC43602;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 07 Jul 2026 15:04:26 +0100
Subject: [PATCH v7 05/17] iio: core: support 64-bit register through
 debugfs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-ad9910-iio-driver-v7-5-a4ec30f63700@analog.com>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
In-Reply-To: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783433065; l=5286;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=rhtJXuF4mkm1WH5HBYUmnTDdQ7mLzj7pscCY6q7WDzI=;
 b=YKD2fD52ikC2xD02F3OCaBynrhQPsTigzThcUw62C4jYIPHti5EqAIQciYYX/us8gandw8cS5
 kWLi/Sx5W3/BV1CMPXzLWwpmVkgRHuwqsegLullwvpRXimktwEeXFdJ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add debugfs_reg64_access function pointer field into iio_info and modify
file operation callbacks to favor 64-bit variant when it is available.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 33 ++++++++++++++++++++++++---------
 include/linux/iio/iio-opaque.h  |  2 +-
 include/linux/iio/iio.h         |  7 +++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a45277bc5d99..98fc00343dc5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -388,6 +388,7 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 	struct iio_dev *indio_dev = file->private_data;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	unsigned int val = 0;
+	u64 val64 = 0;
 	int ret;
 
 	if (*ppos > 0)
@@ -395,9 +396,17 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 					       iio_dev_opaque->read_buf,
 					       iio_dev_opaque->read_buf_len);
 
-	ret = indio_dev->info->debugfs_reg_access(indio_dev,
-						  iio_dev_opaque->cached_reg_addr,
-						  0, &val);
+	if (indio_dev->info->debugfs_reg64_access) {
+		ret = indio_dev->info->debugfs_reg64_access(indio_dev,
+							    iio_dev_opaque->cached_reg_addr,
+							    0, &val64);
+	} else {
+		ret = indio_dev->info->debugfs_reg_access(indio_dev,
+							  iio_dev_opaque->cached_reg_addr,
+							  0, &val);
+		val64 = val;
+	}
+
 	if (ret) {
 		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
 		return ret;
@@ -405,7 +414,7 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 
 	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
 						sizeof(iio_dev_opaque->read_buf),
-						"0x%X\n", val);
+						"0x%llX\n", val64);
 
 	return simple_read_from_buffer(userbuf, count, ppos,
 				       iio_dev_opaque->read_buf,
@@ -417,8 +426,9 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 {
 	struct iio_dev *indio_dev = file->private_data;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	unsigned int reg, val;
+	unsigned int reg;
 	char buf[80];
+	u64 val64;
 	int ret;
 
 	if (*ppos != 0 || count >= sizeof(buf))
@@ -431,7 +441,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 
 	buf[ret] = '\0';
 
-	ret = sscanf(buf, "%i %i", &reg, &val);
+	ret = sscanf(buf, "%i %lli", &reg, &val64);
 
 	switch (ret) {
 	case 1:
@@ -439,8 +449,12 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 		break;
 	case 2:
 		iio_dev_opaque->cached_reg_addr = reg;
-		ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
-							  val, NULL);
+		if (indio_dev->info->debugfs_reg64_access)
+			ret = indio_dev->info->debugfs_reg64_access(indio_dev, reg,
+								    val64, NULL);
+		else
+			ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
+								  val64, NULL);
 		if (ret) {
 			dev_err(indio_dev->dev.parent, "%s: write failed\n",
 				__func__);
@@ -471,7 +485,8 @@ static void iio_device_register_debugfs(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque;
 
-	if (indio_dev->info->debugfs_reg_access == NULL)
+	if (!indio_dev->info->debugfs_reg_access &&
+	    !indio_dev->info->debugfs_reg64_access)
 		return;
 
 	if (!iio_debugfs_dentry)
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index b87841a355f8..98330385e08d 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -73,7 +73,7 @@ struct iio_dev_opaque {
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned int			cached_reg_addr;
-	char				read_buf[20];
+	char				read_buf[24];
 	unsigned int			read_buf_len;
 #endif
 };
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 711c00f67371..cd17703274a6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -484,6 +484,10 @@ struct iio_trigger; /* forward declaration */
  * @update_scan_mode:	function to configure device and scan buffer when
  *			channels have changed
  * @debugfs_reg_access:	function to read or write register value of device
+ * @debugfs_reg64_access: function to read or write 64-bit register value of
+ *			device. debugfs_reg_access() and debugfs_reg64_access()
+ *			are mutually exclusive, but the 64-bit variant has
+ *			precedence in case both are implemented.
  * @fwnode_xlate:	fwnode based function pointer to obtain channel specifier index.
  * @hwfifo_set_watermark: function pointer to set the current hardware
  *			fifo watermark level; see hwfifo_* entries in
@@ -572,6 +576,9 @@ struct iio_info {
 	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
 				  unsigned int reg, unsigned int writeval,
 				  unsigned int *readval);
+	int (*debugfs_reg64_access)(struct iio_dev *indio_dev,
+				    unsigned int reg, u64 writeval,
+				    u64 *readval);
 	int (*fwnode_xlate)(struct iio_dev *indio_dev,
 			    const struct fwnode_reference_args *iiospec);
 	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned int val);

-- 
2.43.0


