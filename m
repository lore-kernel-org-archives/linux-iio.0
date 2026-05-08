Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA02EBDDE;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259634; cv=none; b=jFmHn2alv8GrahVglj30TDyiAxQ7IHu2mgOlVmSTPeSy9bsUNPXOTWdTGlWSy71th4YpumLtYY0QRtewPb3dnVBViRHq4Ipfz9ttoddJ57huW7TVVW9ACZxDe0zgjlKWIb/PZXf1z20MvpX2ogHtJTkmVDkOpnqvkXxw7MgUnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259634; c=relaxed/simple;
	bh=hwFcZ1rYADG5Vl5cAE7VhwuunL029cCrXItus5CFbJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlbgXnq3+kEUJoYKLo39UDXRLFfsuPoQYA4zCcTpYbU7AMZdE6MD7b77pk84xYJ9aUr7OGhOI6zN4aPPQXp2/fYZplDd78ApuCTlcU/8ttYneVDBZHmTXoUqPg7f8xZvH7XFMviTfHcMfKx7D1s7phYk0sZhCtVWigw1FN13H2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwaIEUxK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwaIEUxK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80C0AC2BCC7;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778259634;
	bh=hwFcZ1rYADG5Vl5cAE7VhwuunL029cCrXItus5CFbJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IwaIEUxKuwfFkuYpuWO4zk8yEqUpAhDSeEPvyKN1vhIv5NFUnJ1qVcz8LzbRYNxwT
	 IoeVOHn2ciwGAz/v/4CmxiNEQUrLqveb6B3hOcmCLo/cbE0Ei47AV/NDzrvVcLBq0A
	 e2wFSAkUVe8yIulD3uhQFxhUYYaFlJdljvlh9W47ey5wMIT10w0kTFJiYGA9BptR83
	 ze/LyuTYoaD6SygERz7RMrK+lC5Gu1JRLgFeXpFjpkQGrK5wY+HLq3Tc1fZC/qNiUN
	 6u1JPOz4y2rnuyWrCRjiyZxYKk5Jw2kAl//0UeBsT741Qo6zJY8V2WXVjczRLDqRn2
	 N4/RwrcSeY3PA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E08CD37AD;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 08 May 2026 18:00:18 +0100
Subject: [PATCH RFC v4 02/10] iio: core: support 64-bit register through
 debugfs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-ad9910-iio-driver-v4-2-d26bfd20ee3d@analog.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
In-Reply-To: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778259632; l=4625;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=YRlk/iiq4eVXfrqmyO+o0NNkYu0tyVA5S+8lWtEXHes=;
 b=0VV39g/Wnx+Ah8y4F3SqtMhm46W0xUme5DPPPwUnSzegUyZaFwwhGljivE9L2qlhtG3+Ojke2
 J4FIBcPJvcjAEnLuYOBFDDpnYHjN/U/D69WiNtIOHXBWTRbLToDRpMi
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
 include/linux/iio/iio.h         |  4 ++++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd6f4f9f4533..cb4e2ade25c0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -386,6 +386,7 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 	struct iio_dev *indio_dev = file->private_data;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	unsigned int val = 0;
+	u64 val64 = 0;
 	int ret;
 
 	if (*ppos > 0)
@@ -393,9 +394,17 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
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
@@ -403,7 +412,7 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 
 	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
 						sizeof(iio_dev_opaque->read_buf),
-						"0x%X\n", val);
+						"0x%llX", val64);
 
 	return simple_read_from_buffer(userbuf, count, ppos,
 				       iio_dev_opaque->read_buf,
@@ -415,8 +424,9 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 {
 	struct iio_dev *indio_dev = file->private_data;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	unsigned int reg, val;
+	unsigned int reg;
 	char buf[80];
+	u64 val64;
 	int ret;
 
 	if (count >= sizeof(buf))
@@ -429,7 +439,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 
 	buf[ret] = '\0';
 
-	ret = sscanf(buf, "%i %i", &reg, &val);
+	ret = sscanf(buf, "%i %lli", &reg, &val64);
 
 	switch (ret) {
 	case 1:
@@ -437,8 +447,12 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
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
@@ -469,7 +483,8 @@ static void iio_device_register_debugfs(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque;
 
-	if (indio_dev->info->debugfs_reg_access == NULL)
+	if (!indio_dev->info->debugfs_reg_access &&
+	    !indio_dev->info->debugfs_reg64_access)
 		return;
 
 	if (!iio_debugfs_dentry)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 96b05c86c325..86d17ee69e05 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -484,6 +484,7 @@ struct iio_trigger; /* forward declaration */
  * @update_scan_mode:	function to configure device and scan buffer when
  *			channels have changed
  * @debugfs_reg_access:	function to read or write register value of device
+ * @debugfs_reg64_access: function to read or write 64-bit register value of device
  * @fwnode_xlate:	fwnode based function pointer to obtain channel specifier index.
  * @hwfifo_set_watermark: function pointer to set the current hardware
  *			fifo watermark level; see hwfifo_* entries in
@@ -572,6 +573,9 @@ struct iio_info {
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


