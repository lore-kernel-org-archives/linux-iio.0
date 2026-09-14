Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519EB4A0130;
	Mon, 14 Sep 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418268; cv=fail; b=Mn6qGtffKneQ3Tyj7yNKpDb8WCaBW5aTVIWsd9vK88NADCDXSeqZa3JU98q3K5vTCU/GdNFItFJUo2cL916IopFoqQR3/9LM9WlSFzX9YLqthPz22Vqt6A3xgt1Qg3I8KzGQOHgLHX1zeigMr7ct9T6DS758O6XP4ilbQc6g0ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418268; c=relaxed/simple;
	bh=DLBB8sLQXuqNjFqbIHFyfPckVop8RoOTUhfMT1wnmVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTFhKyIKaoXWBYVx4SHm8f3kYysLqAhF7mDHc4GUMMGSdUub0mwePljLwwODU0V35x3TMkkd8eSTvF5pAGim1KjLplVcx4oG0qxYRmk4NjDtaIaqSNatAGVdjOo0/Fe+szF9x88tscokh5RUYz59vvw7XvcJVyS4NVKpJOK0Wkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JuSngejo; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JuSngejo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrHD/IuBDdE0Vpyo1Kel27Jeh3RLrJCpVZ1zD36HOE2/1fHepLL76VISap8mhrSd54nmDeRN5eY7J2exbmF8gXbu8A9t4bMPO5jiyfF0wvOzQ4/x7x2nxxd3YuD6DCW98moV/ftmCg84szfceMQCpsFhqHaasMLK+CoGVjn0HTbdAPAwbtRiOOrmLLFmY42dC8MmRaWrUrvDv0EUp/ycOawmcyw32GXSE5JnONYOTgMPZ9vF0nJzALW0vLP9I5ku20npAeXOXwiXARbViLrRoXFmqQ4LkDnvirApC26ag5bQgYJ6AU0fmNNrzRoFuo645Iui05q+DiXX87tHui/7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7wTed163jXea4r0UCgqkOu+cX8+FUV7CGy/W2MRTzU=;
 b=NVK2A8a9vX3TdDKofTSb9pvdkJIq+01eE51n6zFW1m8f4tfL1OGiOkbBnfrzAR+Ng97kYREDiXidoz7GkbbrfwLOzdwzr3sVm5nHiblSSHJa2a7LqeGQUjPOA8JaBEwPy+YtW3rj2I5BxcuyPhKSroFDj40xCgnDSfxPpr6YHKTHnI4MOvRUCXp8zqjFuONxRVskMZlg8i45LDwEB6JiNlM4quCzjSZFZpvlwxGVPgjDWbMdw4zj14E0FHvlABgyX4btkmswwRd4ocByBhMRwDSSqUa+BOC0ctwhqa+/BwnrCF37o9g52kyIgReQ0dYvOXkpyhVcf85Hr42C+EP61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7wTed163jXea4r0UCgqkOu+cX8+FUV7CGy/W2MRTzU=;
 b=JuSngejooi+GgafGPjwp0qHO/qm0Wi8BvhqokqodLAWGwVWQSZptX6AZKMeoYmM8D4vjjF3yelSbdtNegVYMcR/dwsvWaVtfVecpj7yUViKiM09obfm9Yn2mNXMNiZY/+Ph9VGDknrP8ILYHTz2GCdi40n7YM7W+1QaQh4NNqvc=
Received: from TY4P301CA0060.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36a::10)
 by OS7PR01MB18397.jpnprd01.prod.outlook.com (2603:1096:604:4be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:44 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36a:cafe::a2) by TY4P301CA0060.outlook.office365.com
 (2603:1096:405:36a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.13 via Frontend Transport; Mon,
 14 Sep 2026 20:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:44 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0CC1D3000368;
	Tue, 15 Sep 2026 05:37:40 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 07/15] counter: rz-mtu3-cnt: unify ceiling values
Date: Mon, 14 Sep 2026 23:36:06 +0300
Message-ID: <20260914203614.2035277-8-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|OS7PR01MB18397:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 510ef4c0-b326-415d-2648-08df12a0079f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rPaxIXcLhpSpxKMYOLycg+GQ0GqA0AxaIoiszXhWN08IS5mUVhhI6qPfilsQEuCf4L62OkAsr5uaP8zLuIMN0wX8Wqh1UD71g9/3zqZEpnzO4KyIfeL+ragRbWyhuLFiCAl9Jvp2CYwlO0TAzVZhoOHxvad0mUkAGdWCuc4a6zHqMKq9EA3+vuDmLwikfrPKl14rz8Hz/Ov7/3g4uGYMeONWv1x8t79JJkc5MA6w9WQYItg91INAWilosT4hEVqWdRxIQqIatlpDXPx0xgiheyEygqkUrsM7x0OND2b3wOrruJYuNVm6b78k/CqHq286i8wrX5+N6Fsh2+WDhGh9/nAIBxdg8DjG04V/g+zhMYrZBrs9LE32xLJkaEcR+N7gylc3NefiAUGjIoLEwFgTIu83HFQZt4cDfRnH6WVzKZejIWcVJ4oDYyTROBqPV54BDsd3zIsJw2vIVToWDQbI2SwJ1/6jRrJ5q4cc1nsLKO8Xm2eIFWmxR/YsEwCunPUsWp1Izw4H0OhkO2M6eDyxD4GGEpDvtEbWZ4YmJ+O5GVqndj0OOiXL0NxXXDi38MFOhOrVP0nyqMbT055F2/Tnim9Fvfgl1Lx/veZ2z94jEafKK20waoG3tva2QYuSP9KCiakQyyjBYhHUBlowHzA4CzQyTxiox8jXnSJv5wrKupaGE5nJiLQ7y9kufqtuErmd0Za6xRst28s9CAOSYZrYpA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n0b1lIjKqVlssC44k6lFkAMqnsrcHugVTZvqHvXJYaeyVl5Q7aoeo9G+297Xuh0CCMCC8sW5+7spwo3dedkz3ygHZQO6osMFcDBsCXhPJQTQdx0jAmBTt9bcf8fPmYvUaxGNDElIXSvPpBEt6VtZuVa8Ynzpcf5xEgDkzmmTV7lVvPnHzA9c3xjsKyiQAYPwp1Z2CI7+nCN4b9VcvFgN/BfdgCv3MYzoWjR8ObHupr1Py0ICgCN2gdMgE5CZFuq/ss7tIVZQxKUWuq36IRoi72BYDMfiFmc0x9gF/CghNflQoeyuSI6z3kKbet1c7ig0BLyAeKFWtf1RktZ/vSipnfVoVsL3gaIRTMpbg7FrIfW7rQv9OhKqjcBFK1ErOkW0k0jROOqOvrAiJNGSPWS0INCu//MHwUU0l3op7AnNe7Xtzse3DuxCuvplwH5um6Fk
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:44.1326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510ef4c0-b326-415d-2648-08df12a0079f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18397

Writing to the 32-bit ceiling value clobbers the 16-bit ceiling values
as both are stored in a union. This was probably done to save a few
bytes of memory, but that memory is then wasted on code to handle the
two separate variables.

Move them out of the union and use a single u32 array to hold ceiling
values for all channels to simplify the code.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index e200a6548dfe..f9bdfaf7bd42 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -75,11 +75,8 @@
 struct rz_mtu3_cnt {
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
+	u32 ceiling[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
-	union {
-		u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
-		u32 mtu_32bit_max;
-	};
 };
 
 static const enum counter_function rz_mtu3_count_functions[] = {
@@ -316,27 +313,13 @@ static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	const size_t ch_id = rz_mtu3_get_hw_ch(count->id);
 	int ret;
 
 	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
 	if (ret)
 		return ret;
 
-	switch (count->id) {
-	case RZ_MTU3_16_BIT_MTU1_CH:
-	case RZ_MTU3_16_BIT_MTU2_CH:
-		*ceiling = priv->mtu_16bit_max[ch_id];
-		break;
-	case RZ_MTU3_32_BIT_CH:
-		*ceiling = priv->mtu_32bit_max;
-		break;
-	default:
-		/* should never reach this path */
-		mutex_unlock(&priv->lock);
-		return -EINVAL;
-	}
-
+	*ceiling = priv->ceiling[count->id];
 	mutex_unlock(&priv->lock);
 	return 0;
 }
@@ -347,7 +330,6 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	const size_t ch_id = rz_mtu3_get_hw_ch(count->id);
 	int ret;
 
 	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
@@ -361,14 +343,12 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 			mutex_unlock(&priv->lock);
 			return -ERANGE;
 		}
-		priv->mtu_16bit_max[ch_id] = ceiling;
 		break;
 	case RZ_MTU3_32_BIT_CH:
 		if (ceiling > U32_MAX) {
 			mutex_unlock(&priv->lock);
 			return -ERANGE;
 		}
-		priv->mtu_32bit_max = ceiling;
 		break;
 	default:
 		/* should never reach this path */
@@ -383,6 +363,7 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, ceiling);
 
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	priv->ceiling[count->id] = ceiling;
 	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
@@ -802,7 +783,6 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct counter_device *counter;
 	struct rz_mtu3_cnt *priv;
-	unsigned int i;
 	int ret;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -810,10 +790,10 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = counter_priv(counter);
-	priv->mtu_32bit_max = U32_MAX;
+	priv->ceiling[RZ_MTU3_16_BIT_MTU1_CH] = U16_MAX;
+	priv->ceiling[RZ_MTU3_16_BIT_MTU2_CH] = U16_MAX;
+	priv->ceiling[RZ_MTU3_32_BIT_CH] = U32_MAX;
 	priv->ch = &ddata->channels[RZ_MTU3_CHAN_1];
-	for (i = 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++)
-		priv->mtu_16bit_max[i] = U16_MAX;
 
 	mutex_init(&priv->lock);
 
-- 
2.55.0

