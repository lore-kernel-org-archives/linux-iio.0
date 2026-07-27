Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A163FE37D;
	Mon, 27 Jul 2026 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155310; cv=none; b=B8U/H/+7fMhIwvhmPpX4GeyT4+D2k1jpnNquuadnpUBWbCgsg3KIZ+miWADNeJ0dmrfY/WG6X9co+0VnQs/czMzoGkcXlnVzhmC1TkQri7mVEVE8V+F61zmYbQe5f/QkCCrIbww+aLlSbouM3L7MFjSv646WnstUYv1Y/QUG6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155310; c=relaxed/simple;
	bh=dG6ESQyQOwjAmFrHt474u7r/XzkQZj9i23i/nKYLZDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9E+l2iJ5Zk4JAcuQevqTZ1O/RT4tPaAgdDHJr7X3dMqOCCnRxi/CYYUKY+FLlXLdbriZApjqwz0ZjIUqNRZW4wy90IE2FygCZQ/j++g3x05F9/DnSKPuxq1dDS5N6OmcHvJS50mm9ApV6XqGUwMID30i0fFguR3EERJISki8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PzimpBaP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PzimpBaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155309; x=1816691309;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dG6ESQyQOwjAmFrHt474u7r/XzkQZj9i23i/nKYLZDs=;
  b=PzimpBaPrP1higCWsPO/YxvJCUBPKa3jrEKE2HsyeTO8BWI2q2fAgbXl
   J7C2yEwMd6IgYwBv/ewRJQGhsvcrn4AxP/Cs+AAwK16fk4UxqHugfPrk7
   yQeMf1WXdeCb3VkvNX5bCWmBmXbA+wOcSWKuA3XUR+bvxmPhsUkyKXOK+
   acCLcKWYIopKzJ4trDuOLLA5+5iip+JTBTiASYXKTLuI0n3gARfZfcF4F
   BUhexba+Fl4cKugq3kS9nlXCJU5pE9lIqrN1E7bI1S8RxeTJ7hkLZrb4w
   sQHkpjkWqxRGTTCicbNQEUmaDguFoLJsmsHFrIzE5diThKkKQ4lk1O89B
   w==;
X-CSE-ConnectionGUID: cXrAsPNPQcyGUabDAyPFiA==
X-CSE-MsgGUID: At3R/XecRrSHUTPBo1RfzQ==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="61530859"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2026 05:28:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 27 Jul 2026 05:28:06 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:27:57 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<Jonathan.Santos@analog.com>, <jorge.marques@analog.com>,
	<joshua.crofts1@gmail.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <varshini.rajendran@microchip.com>,
	<mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/16] nvmem: microchip-otpc: nvmem: microchip-otpc: add tag-based packet lookup
Date: Mon, 27 Jul 2026 17:56:25 +0530
Message-ID: <20260727122633.117435-9-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727122633.117435-1-varshini.rajendran@microchip.com>
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for accessing OTP packets by their tag which is a FourCC
while preserving backward compatibility with the existing ID-based
lookup.

The OTP memory layout can vary across devices and may change over time,
making the packet ID approach unreliable when the memory map is not
known in advance. The packet tag provides a reliable way to identify
and access packets without prior knowledge of the OTP memory layout.

Two offset encodings are now supported:
  1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
     Used in DT as: reg = <OTP_PKT(1) 76>;
  2. TAG-based: offset = 4-byte ASCII packet tag (FourCC)
     Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")

The driver resolves offsets matching valid legacy selectors (multiples
of 4 within the packet count) through ID lookup, falling back to tag
lookup for other valid values. This ensures existing device trees
continue to work while enabling new tag-based access. During probe,
packet meta data including the tag is read and cached.

The stride of the nvmem memory is set to 1 in order to support tag based
offsets, comment in the header file is updated accordingly.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/nvmem/microchip-otpc.c                | 117 ++++++++++++++++--
 .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
 2 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index df979e8549fd..a17f82afdc37 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -23,6 +23,8 @@
 #define MCHP_OTPC_SR_READ		BIT(6)
 #define MCHP_OTPC_HR			(0x20)
 #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
+#define MCHP_OTPC_HR_PACKET		GENMASK(2, 0)
+#define MCHP_OTPC_HR_PACKET_REGULAR	1
 #define MCHP_OTPC_DR			(0x24)
 
 #define MCHP_OTPC_NAME			"mchp-otpc"
@@ -47,11 +49,13 @@ struct mchp_otpc {
  * @list: list head
  * @id: packet ID
  * @offset: packet offset (in words) in OTP memory
+ * @tag: 4-byte ASCII (FourCC) tag of the packet
  */
 struct mchp_otpc_packet {
 	struct list_head list;
 	u32 id;
 	u32 offset;
+	u32 tag;
 };
 
 static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
@@ -70,6 +74,52 @@ static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
 	return NULL;
 }
 
+static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct mchp_otpc *otpc, u32 tag)
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
+static bool mchp_otpc_is_valid_fourcc(u32 tag)
+{
+	int i;
+	u8 c;
+
+	for (i = 0; i < 4; i++) {
+		c = (tag >> (i * 8)) & 0xff;
+		if (c < 0x20 || c > 0x7e)
+			return false;
+	}
+
+	return true;
+}
+
+static struct mchp_otpc_packet *mchp_otpc_resolve_packet(struct mchp_otpc *otpc, u32 off)
+{
+	/*
+	 * Legacy id based packet access: offset = id * 4
+	 * Inside the driver we use continuous unsigned integer numbers
+	 * for packet id, thus divide off by 4 before passing it to
+	 * mchp_otpc_id_to_packet().
+	 */
+	u32 remainder = off % 4;
+	u32 id = off / 4;
+
+	if (!remainder && id < otpc->npackets)
+		return mchp_otpc_id_to_packet(otpc, id);
+
+	/*
+	 * TAG-based packet access: offset is a 4-byte ASCII tag (FourCC)
+	 */
+	return mchp_otpc_tag_to_packet(otpc, off);
+}
+
 static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
 				  unsigned int offset)
 {
@@ -140,8 +190,29 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
  * offset returned by hardware.
  *
  * For this, the read function will return the first requested bytes in the
- * packet. The user will have to be aware of the memory footprint before doing
- * the read request.
+ * packet.
+ *
+ * Two offset encodings are supported:
+ *
+ * 1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
+ *    Used in DT as: reg = <OTP_PKT(1) 76>;
+ * 2. TAG-based: offset = 4-byte ASCII packet tag (FourCC)
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
+ * ASCII value (FourCC), the packets can be recognized without being aware of the
+ * flashed OTP memory map table and the payload can be acquired reliably.
+ *
+ * While the legacy ID based lookup is still supported, TAG based approach is
+ * recommended.
  */
 static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 			  size_t bytes)
@@ -154,12 +225,11 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
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
@@ -190,10 +260,25 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 	return 0;
 }
 
+static int mchp_otpc_read_packet_tag(struct mchp_otpc *otpc, unsigned int offset,
+				     unsigned int *tag)
+{
+	int ret;
+
+	ret = mchp_otpc_prepare_read(otpc, offset);
+	if (ret)
+		return ret;
+
+	writel_relaxed(0, otpc->base + MCHP_OTPC_AR);
+	*tag = readl_relaxed(otpc->base + MCHP_OTPC_DR);
+
+	return 0;
+}
+
 static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
 {
 	struct mchp_otpc_packet *packet;
-	u32 word, word_pos = 0, id = 0, npackets = 0, payload_size;
+	u32 word, word_pos = 0, id = 0, npackets = 0, payload_size, type;
 	int ret;
 
 	INIT_LIST_HEAD(&otpc->packets);
@@ -215,6 +300,20 @@ static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
 
 		packet->id = id++;
 		packet->offset = word_pos;
+		type = FIELD_GET(MCHP_OTPC_HR_PACKET, word);
+
+		if (type == MCHP_OTPC_HR_PACKET_REGULAR) {
+			ret = mchp_otpc_read_packet_tag(otpc, packet->offset,
+							&packet->tag);
+			if (ret)
+				return ret;
+
+			if (!mchp_otpc_is_valid_fourcc(packet->tag))
+				packet->tag = 0;
+		} else {
+			packet->tag = 0;
+		}
+
 		INIT_LIST_HEAD(&packet->list);
 		list_add_tail(&packet->list, &otpc->packets);
 
@@ -236,7 +335,7 @@ static struct nvmem_config mchp_nvmem_config = {
 	.type = NVMEM_TYPE_OTP,
 	.read_only = true,
 	.word_size = 4,
-	.stride = 4,
+	.stride = 1,
 	.reg_read = mchp_otpc_read,
 };
 
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

