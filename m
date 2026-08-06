Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD341E6CD;
	Thu,  6 Aug 2026 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006096; cv=none; b=bDD4SACQBR4wGtsS/oQ1+Ka7mpJ8laY7/9wlWP0wiiCR0VSD/WezIWw28vYuipT87pVCLB7vUtuNrKvkv0PQry395vhii98nf+nFGxV84gb1PExGCAHpGTjsOeQaZ31Egu+jKV2hiFctbNTCWfByKnHoxC3xJqphqbT2A0VoMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006096; c=relaxed/simple;
	bh=dG6ESQyQOwjAmFrHt474u7r/XzkQZj9i23i/nKYLZDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1khQhiqDjScdKOh8eBVpziHVNuS4EwWWWJDSznS/AcDcGuhvtti7Y5TzGz3f/+gJEHI1Bo2hCb1Jft6Db1wheju/ikXHXKFJsJ9KfshpXc/XahNf5vUeyBSlLdXAalRd2Kd0jurzE6TeBiWINLLTpTAghbzRH2vL6813IrHLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gYhiei+W; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gYhiei+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006098; x=1817542098;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dG6ESQyQOwjAmFrHt474u7r/XzkQZj9i23i/nKYLZDs=;
  b=gYhiei+WQmZDaIyuTEKYmKfKvxjP2oqS1vwm9LF7GIo5PXK06/Cm7KRo
   dC3OtwT4lARzQcVYegMd21mf3CqP0RdYiFO3GkOmxzAyLaT0WKu8DEFlh
   RvK8zBST4b/RE/Xrv7woBu71TTHbHKCzrtwHrJjPTH0lfW7deJqLAgqVa
   upGosZUUrp3LOKMlYvnWOEcmwT4LhRdRWMCZG+eOPQSQbxSQOyaGHGcQj
   nEi55mHcR1qB6SITM01COfprr0egtbS4kaA7dpZ1MKjzE0or2NRk7KNdh
   oRd9aiHlnGxFMZ7WWM5E0B0bii0tWGOefk8KmaliPzMMaEA2A5dkqUZNy
   w==;
X-CSE-ConnectionGUID: 69xNHFenSxiM/ftyCrg/Zw==
X-CSE-MsgGUID: zbiMInBHTzG8RV1ADLVwBA==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="71343324"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 01:48:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 6 Aug 2026 01:48:13 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:48:04 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
	<Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
	<mazziesaccount@gmail.com>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 09/17] nvmem: microchip-otpc: nvmem: microchip-otpc: add tag-based packet lookup
Date: Thu, 6 Aug 2026 13:10:16 +0530
Message-ID: <20260806074024.531259-10-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806074024.531259-1-varshini.rajendran@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
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

