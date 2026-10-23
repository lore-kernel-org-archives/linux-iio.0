Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781823;
	b=fuiIQup80Zzu5q6Cfqf3QpJoX4qLca1kM9N3PMs9k866IrxPEB07VXtqnIL2qXpt54xi
	 T1+JZ7xbI9FvmLo1elrL6xyqvXRc0X9kOIm/HTFLhFWh579m4FgH91dMxno6xKdo6dIxP
	 IfFi+fBbUcIfdIL/NE84Nr5pED6/TowtPlD6UrDWszdgO3lwa9W8Md7sLS67FyeBAGtmj
	 ZKCsv88Vazx8z9O2Wgdanp/YlnMdxa+GqqzIjxojOgegq42Vf/NRrYX7olx2F2UMZOaJC
	 dAbsKotxPh6vgYZzK5vQLyzq0leWn+EZ/1lgGCx342onFmL49d+ahq5f4gm74PFFVjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tF8DCvJy02dv/dGl/c2kjNebK24DBSFwD813ICPFVCg=;
	b=hA27Z6742fRcanS8bkiEWI7TOqgoVRS53xzjtsNgmcqsoLbMTCWPdJUykEwMCqihi2Kq
	 t2JGxVj2VBFZA9jQbDYKGGUd/fa0F8afr0EUzQjaeUiyVh6wHXH+IbVCuvYK9FVkuDS3W
	 QTgxhT+pmR5QvgbVXQwxpsH96ZivS1EpS94uRCG9KEsnkuoCrTUoQAEgwKOj3nRdi5qTq
	 8MI5/q9hp4D+z0wyB9K3wbpVFYvM8eHBcF2qL8ipYQ5Y32bUudj/0E4EdQUMruZYZGsOo
	 1x7jWos2XVC8Erorl2HLeseSU8a0kYXkc6XI781FMkis2i33rYzWOYznSvh3ze04cNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h1a2HoFB;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9D606A31D
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 18:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F9D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h1a2HoFB
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3550c917fd3so1829814eec.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781822; x=1793386622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tF8DCvJy02dv/dGl/c2kjNebK24DBSFwD813ICPFVCg=;
        b=h1a2HoFBhB90ULo62DPYUdFx0VbproVRlBQpsPUL/4hrs9G6K58Lh2Ifvb2Ge52K9T
         1hIz7rTRHCkklodOUST+fRNVWggtny6YDXlL9u5/CcQIokKPAMl+HqOJhTmyIBQpt6MF
         GP6ny49KGymaaFif6ND1MJM87WE0zs5xhaygHZo1fPb8sJjwgGPKXe0j0yUCAO9nPmvD
         /R+PjUElHFFwInh+Mmcm5iMzDqJB6YXE+a4opx45aAWU5NlsudUk0iCZ+fouI3fETe7f
         eTGdW08XFZ+/UJU1OL6nd+zEOwSXpGvJoqV/5SFZw98Ih29FX5EbGMXswA106nKd6/BY
         HpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781822; x=1793386622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tF8DCvJy02dv/dGl/c2kjNebK24DBSFwD813ICPFVCg=;
        b=lYqHj5IGhEHaUyNIsSWsXnU7FvQW7YxuNk9YL4nISdfTNJMUy0GxmVPBXjDAVS/7DT
         7yLDoinfuhmaaoEI/e1okA4OtapGubs3NZ/1O4I81jzar5PIw5sEJPVOH8Va2ezTy8cv
         i9rJfuKjMHg7pZ/ZbYiquzkOJJy55JGZrnjB+E6ZQ+MpeThvwp5+ozWEb4KmoEHTy0h6
         uP8rBmSRE9JF6HRsTGCSK/C3WYFqR0jsQG+jzoReKWrAbzc8GI4bGqz+mht58q95T7Qo
         XgO4i1zPRgUEwzguFz6to+jnuFHsupOcvlLkhL6VJjmbBiZN7qdvC45NWGgSZ6uDlieM
         ZLbw==
X-Forwarded-Encrypted: i=1; AKwUvBzSx9+UzHZgMj0217YDdC656lrSes5k42P3mXQUALHcN1Eh17+Mg7k+NP7CtE+YcU9mNsosz0nQW2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYL36To8Us6GbazzIsRSUGoRK9+eZDZ/fSzg/iFrQNhRrEMDH5e2
	pnBZScmPyvrEt80XcmTCZ6/QIOfvWr4q1V0q3aSkqGZg8A+Fm/QPqqQ6
X-Gm-Gg: AYBFou2eqVTXjFw38lDFAhNcpyqhcITsflH9cAe46uxIPVMPlOcVO0QvMKTv+s8LNjl
	yMYUzi+JhkrDu6EEfHmST0+dWlDPBgX3Qwizfe1dQ22qs+v8lZ5m96HH27jnPt9TdMEKjPG+ex4
	UFpipCsn7YIPJt3VMa3th1U70I9usRTn6rtV8MfpvEWBAv53XkBnOYr/6KN+DFwQXYMZ9gjoDFi
	AZR7WbVbCPQeitU5T3nuoElwPP/Qb9GXm6XIgWpF6mdaUgeOUIVPqpxOy3NpzySsmUXFJ7Auafc
	/RYZXLLOqLohNaJSQWv1qBDXcWQt6cH+JSNcBoZnKnQOFj2GuPAQuzAqrOSCNdVzxZSn14Anq+C
	MxqYuA60atI3Jk6huELliVWI/4JyhZbMCI6VzjFjkgvoCyVV0x7QBvbshU9wU4nJMBBhtw11jf7
	W8snQzN6ddbhh2kx/Cvfnbq28aPe4HTNQEOuE1/lox6mvLQrGVm3DMvBgT6WJBiiEKW97Au8RGA
	V8/lbQkt+Pi3V3DBHi1HbxH9yecwa4LW60JeenxSLRj1ev9KC9sKW5jFfugTvUp8Dld5t4lSQi/
	IjfS/orUoqM6MmGtXxPaf1qt+BBwb06IYl7YA8yoP0PDW3pV5ACsn21ZJEGIIaocr/aLPP/FnQA
	ob07ID8i1TqU=
X-Received: by 2002:a05:701b:4587:b0:195:238:b632 with SMTP id a92af1059eb24-195c72d8a3bmr3336033c88.38.1792781821511;
        Fri, 23 Oct 2026 11:57:01 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm308388c88.21.2026.10.23.11.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:57:00 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Sat, 24 Oct 2026 00:26:48 +0530
Message-ID: <20261023185652.195025-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
channel specs and lets ams_init_module() fill them for the AMS node and
each of its children, without telling it how much room is left.

For the PL-SYSMON node, ams_get_ext_chan() appends one channel per
"channel@N" child after the 10 fixed PL channels. The binding allows
reg values 20..50, so a PL node can have up to 31 such children, i.e.
up to 41 PL channels, while only 31 are budgeted for it. Together with
the 13 PS and 7 AMS control channels, this writes past the end of the
buffer. Since the modules are filled in device tree order, the fixed
channel blocks copied after the PL node can overflow as well.

ams_get_ext_chan() also only checks the upper bound of reg. ext_chan is
unsigned, so a reg below 20 makes it wrap and ams_pl_channels[] is read
far out of bounds.

Pass the remaining capacity down to ams_init_module() and
ams_get_ext_chan() and fail with -ENOSPC when a module does not fit,
instead of writing past the buffer. Also reject reg values below 20, as
the binding requires.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Fix the truncated subject line (Andy)
- Drop the paragraph about an earlier report, I could not find that
  thread again to reference it properly
- Pass the remaining capacity as unsigned int and drop the casts (Andy)
- Keep the ams_get_ext_chan() call on one line (Andy)
- Rebase on fixes-togreg
- Drop the bouncing @xilinx.com and @huawei.com addresses from Cc

v1: https://lore.kernel.org/all/20261021225356.625288-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have ZynqMP hardware.

 drivers/iio/adc/xilinx-ams.c | 54 ++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 158e6133abf5..7f0f7778d6aa 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -144,7 +144,14 @@
 #define AMS_PL_CSTS_ACCESS_MASK		BIT(1)
 
 #define AMS_PL_MAX_FIXED_CHANNEL	10
-#define AMS_PL_MAX_EXT_CHANNEL		20
+/*
+ * The external PL channels are addressed by their channel number. The
+ * binding allows the range from AMS_PL_EXT_CHANNEL_MIN to
+ * AMS_PL_EXT_CHANNEL_MAX. AMS_PL_EXT_CHANNEL_MIN maps onto the first
+ * ams_pl_channels[] entry, AMS_PL_EXT_CHANNEL_MAX onto the last one.
+ */
+#define AMS_PL_EXT_CHANNEL_MIN		20
+#define AMS_PL_EXT_CHANNEL_MAX		50
 
 #define AMS_INIT_POLL_TIME_US		200
 #define AMS_INIT_TIMEOUT_US		10000
@@ -1142,20 +1149,31 @@ static const struct iio_chan_spec ams_ctrl_channels[] = {
 };
 
 static int ams_get_ext_chan(struct fwnode_handle *chan_node,
-			    struct iio_chan_spec *channels, int num_channels)
+			    struct iio_chan_spec *channels, int num_channels,
+			    unsigned int max_channels)
 {
 	struct iio_chan_spec *chan;
-	struct fwnode_handle *child;
 	unsigned int reg, ext_chan;
 	int ret;
 
-	fwnode_for_each_child_node(chan_node, child) {
+	fwnode_for_each_child_node_scoped(chan_node, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
+		if (ret)
+			continue;
+
+		/*
+		 * Anything outside of the range of channel numbers allowed
+		 * by the binding is not a valid channel.
+		 */
+		if (reg < AMS_PL_EXT_CHANNEL_MIN ||
+		    reg > AMS_PL_EXT_CHANNEL_MAX)
 			continue;
 
+		if (num_channels >= max_channels)
+			return -ENOSPC;
+
 		chan = &channels[num_channels];
-		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
+		ext_chan = reg - AMS_PL_EXT_CHANNEL_MIN;
 		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
 
 		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
@@ -1183,7 +1201,8 @@ static void ams_iounmap_pl(void *data)
 
 static int ams_init_module(struct iio_dev *indio_dev,
 			   struct fwnode_handle *fwnode,
-			   struct iio_chan_spec *channels)
+			   struct iio_chan_spec *channels,
+			   unsigned int max_channels)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct ams *ams = iio_priv(indio_dev);
@@ -1191,6 +1210,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 	int ret;
 
 	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
+		if (max_channels < ARRAY_SIZE(ams_ps_channels))
+			return -ENOSPC;
+
 		ams->ps_base = fwnode_iomap(fwnode, 0);
 		if (!ams->ps_base)
 			return -ENXIO;
@@ -1202,6 +1224,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
 		num_channels = ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
+		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
+			return -ENOSPC;
+
 		ams->pl_base = fwnode_iomap(fwnode, 0);
 		if (!ams->pl_base)
 			return -ENXIO;
@@ -1213,9 +1238,14 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		/* Copy only first 10 fix channels */
 		memcpy(channels, ams_pl_channels, AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
 		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
-		num_channels = ams_get_ext_chan(fwnode, channels,
-						num_channels);
+		ret = ams_get_ext_chan(fwnode, channels, num_channels, max_channels);
+		if (ret < 0)
+			return ret;
+		num_channels = ret;
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
+		if (max_channels < ARRAY_SIZE(ams_ctrl_channels))
+			return -ENOSPC;
+
 		/* add AMS channels to iio device channels */
 		memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
 		num_channels += ARRAY_SIZE(ams_ctrl_channels);
@@ -1245,7 +1275,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	if (fwnode_device_is_available(fwnode)) {
-		ret = ams_init_module(indio_dev, fwnode, ams_channels);
+		ret = ams_init_module(indio_dev, fwnode, ams_channels, ams_size);
 		if (ret < 0)
 			return ret;
 
@@ -1253,7 +1283,9 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	}
 
 	device_for_each_child_node_scoped(dev, child) {
-		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
+		ret = ams_init_module(indio_dev, child,
+				      ams_channels + num_channels,
+				      ams_size - num_channels);
 		if (ret < 0)
 			return ret;
 

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

