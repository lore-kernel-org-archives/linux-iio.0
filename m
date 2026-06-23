Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185C3D1CC5;
	Tue, 23 Jun 2026 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212444; cv=none; b=gPevrcDA1fKCPhJi8HqoniKk8exR912yyJoZ5ufPWwcBMv0kBr+LSW6e4rOfQ28Bm72erLkRhdcw9LC7DQ5Ie+ECF76gWR6y0Bd1LQuByUuLrwS479Nj4sP8JZTglYQOo70Z73Hel6Raw3hIcQc0Z7Uu8omqawtisLkcPEOrMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212444; c=relaxed/simple;
	bh=ZBEHlpzbmrNFlL9tbvU63pilk927UHjFBZl6jjp6Vqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XghWZ3tHslOUl3yZ9hpucltuCNfmYD5NXMsqPIdjwOHsrhhempJ8lw/PxSUwXmCBQ6TUN4BtOQPtNhWzbRzFi67eDLChgWlShPpmZWufDE4lhPKersjVznqVuHckJLySx5cTzDXaUbwP99XnAc+1mhHJHNpOKq9kgSkq40fQ0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZBp4I/t+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZBp4I/t+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212442; x=1813748442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZBEHlpzbmrNFlL9tbvU63pilk927UHjFBZl6jjp6Vqo=;
  b=ZBp4I/t+XfxMkFqFe7UPdAfjwHpKjVeDkDPP8u5f2OrHMEjtqR3VMEXg
   H4vpWSlZH/gdTw8Ccpud80TTF6FpZ4v9arH6tQUhbgdIV1FtDyCXZov0F
   vfcWa9Yq4u33Cd4BuV0DnifBYnM6kgj/5kT2qBxc484MdEQOeEJ4UFW92
   7a7olCzH7YTfpdHuUGAMRBkQWt7gc/Pf+jJPBg6XalsSaesDMcDmwpjvo
   OfZwr/mUw1BYL3cwrYWa+A5OyIns4Msh7tKE2Eau6Sk3HetNxKZRgaDWx
   UWwVGUQrod1PtzYe9xOSMkQGIuwIToJ4hkR2A/VGwao+1C5K2nicByTRw
   g==;
X-CSE-ConnectionGUID: C7Ed3jRPSiiZMF0D2NfI1A==
X-CSE-MsgGUID: F0ydKSEiT++79+8/6ls9sw==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="59914576"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 04:00:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 23 Jun 2026 04:00:41 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 04:00:36 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 05/12] nvmem: microchip-otpc: add tag-based packet lookup
Date: Tue, 23 Jun 2026 16:29:37 +0530
Message-ID: <20260623105944.128840-6-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623105944.128840-1-varshini.rajendran@microchip.com>
References: <20260623105944.128840-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for accessing OTP packets by their 4-byte ASCII tag while
preserving backward compatibility with the existing ID-based lookup.

The OTP memory layout can vary across devices and may change over time,
making the packet ID approach unreliable when the memory map is not
known in advance. The packet tag provides a reliable way to identify
and access packets without prior knowledge of the OTP memory layout.

Two offset encoding are now supported:
  1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
     Used in DT as: reg = <OTP_PKT(1) 76>;
  2. TAG-based: offset = 4-byte ASCII packet tag
     Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")

The driver resolves offsets matching valid legacy selectors (multiples
of 4 within the packet count) through ID lookup, falling back to tag
lookup for other values. This ensures existing device trees continue
to work while enabling new tag-based access.

During probe, packet meta data including the tag is read and cached.
The driver also validates OTP memory accessibility and emulation mode
status. When the boot packet is not configured, emulation mode allows
access to the other packets. When both are not available an
informational message is logged.

The stride of the nvmem memory is set to 1 in order to support tag based
offsets, comment in the header file is updated accordingly.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/nvmem/microchip-otpc.c                | 142 ++++++++++++++++--
 .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
 2 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index df979e8549fd..cbb4822a97c0 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -18,16 +18,20 @@
 #define MCHP_OTPC_CR_READ		BIT(6)
 #define MCHP_OTPC_MR			(0x4)
 #define MCHP_OTPC_MR_ADDR		GENMASK(31, 16)
+#define MCHP_OTPC_MR_EMUL		BIT(7)
 #define MCHP_OTPC_AR			(0x8)
 #define MCHP_OTPC_SR			(0xc)
 #define MCHP_OTPC_SR_READ		BIT(6)
 #define MCHP_OTPC_HR			(0x20)
 #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
+#define MCHP_OTPC_HR_PACKET_TYPE	GENMASK(2, 0)
 #define MCHP_OTPC_DR			(0x24)
 
 #define MCHP_OTPC_NAME			"mchp-otpc"
 #define MCHP_OTPC_SIZE			(11 * 1024)
 
+#define PACKET_TYPE_REGULAR		1
+
 /**
  * struct mchp_otpc - OTPC private data structure
  * @base: base address
@@ -47,11 +51,15 @@ struct mchp_otpc {
  * @list: list head
  * @id: packet ID
  * @offset: packet offset (in words) in OTP memory
+ * @type: type of the packet
+ * @tag: 4-byte ASCII tag of the packet
  */
 struct mchp_otpc_packet {
 	struct list_head list;
 	u32 id;
 	u32 offset;
+	u32 type;
+	u32 tag;
 };
 
 static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
@@ -70,6 +78,55 @@ static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
 	return NULL;
 }
 
+/**
+ * mchp_otpc_tag_to_packet() - find packet by tag
+ * @otpc: OTPC private data
+ * @tag: 4-byte ASCII tag to search for
+ *
+ * Return: pointer to packet if found, NULL otherwise
+ */
+static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct mchp_otpc *otpc,
+							u32 tag)
+{
+	struct mchp_otpc_packet *packet;
+
+	list_for_each_entry(packet, &otpc->packets, list) {
+		if (packet->tag == tag)
+			return packet;
+	}
+
+	return NULL;
+}
+
+/**
+ * mchp_otpc_resolve_packet() - resolve offset to packet
+ * @otpc: OTPC private data
+ * @off: NVMEM offset (legacy ID-based or TAG-based)
+ *
+ * Legacy offsets (multiples of 4 within valid ID range) are resolved
+ * through ID lookup. Other offsets are treated as 4-byte ASCII tags.
+ *
+ * Return: pointer to packet if found, NULL otherwise
+ */
+static struct mchp_otpc_packet *mchp_otpc_resolve_packet(struct mchp_otpc *otpc,
+							 u32 off)
+{
+	/*
+	 * Legacy id based packet access: offset = id * 4
+	 * Inside the driver we use continuous unsigned integer numbers
+	 * for packet id, thus divide off by 4 before passing it to
+	 * mchp_otpc_id_to_packet().
+	 */
+
+	if (!(off % 4) && (off / 4) < otpc->npackets)
+		return mchp_otpc_id_to_packet(otpc, off / 4);
+
+	/*
+	 * TAG-based packet access: offset is a 4-byte ASCII tag
+	 */
+	return mchp_otpc_tag_to_packet(otpc, off);
+}
+
 static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
 				  unsigned int offset)
 {
@@ -140,8 +197,29 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
  * offset returned by hardware.
  *
  * For this, the read function will return the first requested bytes in the
- * packet. The user will have to be aware of the memory footprint before doing
- * the read request.
+ * packet.
+ *
+ * Two offset encoding are supported:
+ *
+ * 1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
+ *    Used in DT as: reg = <OTP_PKT(1) 76>;
+ * 2. TAG-based: offset = 4-byte ASCII packet tag
+ *    Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
+ *
+ * To use the legacy ID based packet lookup the user will have to be aware of
+ * the memory footprint before doing the read request.
+ *
+ * But by using the TAG based packet lookup, the user won't have to be aware
+ * of the memory footprint before doing the read request since this driver has
+ * it abstracted and taken care of.
+ *
+ * Practically, there is no way of knowing the mapping of the OTP memory table
+ * in advance for every device. But by using the packet tag - the identifier
+ * ASCII value, the packets can be recognized without being aware of the
+ * flashed OTP memory map table and the payload can be acquired reliably.
+ *
+ * While the legacy ID based lookup is still supported, TAG based approach is
+ * recommended.
  */
 static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 			  size_t bytes)
@@ -154,12 +232,11 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 	int ret, payload_size;
 
 	/*
-	 * We reach this point with off being multiple of stride = 4 to
-	 * be able to cross the subsystem. Inside the driver we use continuous
-	 * unsigned integer numbers for packet id, thus divide off by 4
-	 * before passing it to mchp_otpc_id_to_packet().
+	 * From this point the offset has to be translated into the actual
+	 * packet. For this we traverse the table of contents stored in a list
+	 * "packet" based on the access type - packet id or tag.
 	 */
-	packet = mchp_otpc_id_to_packet(otpc, off / 4);
+	packet = mchp_otpc_resolve_packet(otpc, off);
 	if (!packet)
 		return -EINVAL;
 	offset = packet->offset;
@@ -190,6 +267,29 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 	return 0;
 }
 
+/**
+ * mchp_otpc_read_packet_tag() - read tag from packet payload
+ * @otpc: OTPC private data
+ * @offset: packet offset in OTP memory
+ * @val: pointer to store the tag value
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int mchp_otpc_read_packet_tag(struct mchp_otpc *otpc, unsigned int offset,
+				     unsigned int *val)
+{
+	int ret;
+
+	ret = mchp_otpc_prepare_read(otpc, offset);
+	if (ret)
+		return ret;
+
+	writel_relaxed(0, otpc->base + MCHP_OTPC_AR);
+	*val = readl_relaxed(otpc->base + MCHP_OTPC_DR);
+
+	return 0;
+}
+
 static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
 {
 	struct mchp_otpc_packet *packet;
@@ -215,6 +315,17 @@ static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
 
 		packet->id = id++;
 		packet->offset = word_pos;
+		packet->type = FIELD_GET(MCHP_OTPC_HR_PACKET_TYPE, word);
+
+		if (packet->type == PACKET_TYPE_REGULAR) {
+			ret = mchp_otpc_read_packet_tag(otpc, packet->offset,
+							&packet->tag);
+			if (ret)
+				return ret;
+		} else {
+			packet->tag = 0;
+		}
+
 		INIT_LIST_HEAD(&packet->list);
 		list_add_tail(&packet->list, &otpc->packets);
 
@@ -236,7 +347,7 @@ static struct nvmem_config mchp_nvmem_config = {
 	.type = NVMEM_TYPE_OTP,
 	.read_only = true,
 	.word_size = 4,
-	.stride = 4,
+	.stride = 1,
 	.reg_read = mchp_otpc_read,
 };
 
@@ -244,8 +355,9 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
 	struct mchp_otpc *otpc;
-	u32 size;
+	u32 size, tmp;
 	int ret;
+	bool emul_enable;
 
 	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
 	if (!otpc)
@@ -256,10 +368,22 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 		return PTR_ERR(otpc->base);
 
 	otpc->dev = &pdev->dev;
+
+	tmp = readl_relaxed(otpc->base + MCHP_OTPC_MR);
+	emul_enable = tmp & MCHP_OTPC_MR_EMUL;
+	if (emul_enable)
+		dev_info(otpc->dev, "Emulation mode enabled\n");
+
 	ret = mchp_otpc_init_packets_list(otpc, &size);
 	if (ret)
 		return ret;
 
+	if (!size) {
+		dev_warn(otpc->dev, "Cannot access OTP memory\n");
+		if (!emul_enable)
+			dev_info(otpc->dev, "Boot packet not programmed and emulation mode disabled\n");
+	}
+
 	mchp_nvmem_config.dev = otpc->dev;
 	mchp_nvmem_config.add_legacy_fixed_of_cells = true;
 	mchp_nvmem_config.size = size;
diff --git a/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
index f570b23165a2..5f72e75ad091 100644
--- a/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
+++ b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
@@ -4,8 +4,8 @@
 #define _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
 
 /*
- * Need to have it as a multiple of 4 as NVMEM memory is registered with
- * stride = 4.
+ * Need to have it as a multiple of 4 for the legacy id based packet
+ * access.
  */
 #define OTP_PKT(id)			((id) * 4)
 
-- 
2.34.1

