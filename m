Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201554A0919;
	Mon, 14 Sep 2026 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418251; cv=fail; b=A5l7MX3Q7rVjzsSz1amHDwJaFN0PVr75Q5g4febeYKDtAf08aB0e4wbDxuHz0A5JpKMBtqJzdNlzbKLNjA25LC9qBcVCJHCn9hAD8HMHfvSM/buNJtnP5w775jSczxYIkRMP6OvxKM868wbs6lDOw0xFzVyuwwjggBbLA0rfm7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418251; c=relaxed/simple;
	bh=jVUzCfKKGgG9GtWIiro3Zfmgb48o8D1y9Afp2lV68Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovwsqKnKiJBkOSHa8CZHK0VtwNvl0E1bV1ZV+oURQ/y0XZCvDk/h8FxLfrVR9vrfjdhZ45pf0hB3+sISpPzCRhqUinaDnKNKH+GfayqcOnj7l6d+N8Gz1ZfmIu99hEAyGuuJ5St/AQ5Ytd/PXJYF6LuTTEBmcXJSmmYMKD/y2Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=a27SRdkZ; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="a27SRdkZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4Q4nxAqlyAUu3V0KPYJA0dwSO3olCd/pgxqA1WImBGzt1Zay0RMvqFI4vparpXb81UGBeHkGyste+12BXbr0hVGlbxDx5TAxyXRm3D0J/h4MAMLasCgpBHypxO5fA/uhOMGCsxpGAv4gMhx052+bRSzCsv+Bc3QDkXYEScAVEAb6DwySQOsAAQ4rCxErCfU8R/qLVm6qNxDTniltNZAlZ0HZQ9wps3Ws8sUiW+ACgqIchOo3kRWFv+NeeYcOirqtoJCj4VBrpK0HpAmGZm4glMjVYnSROUrUidBlV/OxKjKFQQ/pYdAa4ezulTtkX4QUQy9+CKVkzCUQIRbstW6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJO3DfoVEoXriQB/9K3Mx4V4EmKgVkoWBr65P7c8tHE=;
 b=dk6afWAJLSj6V1xiCPQOjOel3r83z+8taRJyVNSWrQVQbqzr4zl2eGEZBeJQz6/0MCoENMQcSJ+xBegxfaAjuXdgEHhyNAf0WuUFBC0cgT4c6UckK7hckO4wQFqgKAMFM0XSifjLeas6Hy7F8+283hUyzNH4Xo1ptgCbwO/mONMOxm9KtZWNIi0hjLscJLZ+tGaC3uMss2jYjSuRSPZ4Fe4cOZ5QG8LQCjNukwvrH/UPMTW+idGwFpZWPknRWXkNDCkiDSoBalKKmJQS8N1RDASGEcmdOa3i+etpbQVQCOCYxh+vqivhuwlkFoJ/R6VDLCd/n56pmCqKN+h9i6SqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJO3DfoVEoXriQB/9K3Mx4V4EmKgVkoWBr65P7c8tHE=;
 b=a27SRdkZBI/MfVGlzf64WdYS3eXvR56R9HNOnyBMqygtMfdduEz0Xdgaz28WyokbptUonchP/CpX5HzPL1YYWFQZSQmKJxbd1m4PkNJEyIWicVlCO9cnTn3qeaKh8BYTglIWWGz/YUeKee0LGcgU+FlP9ywxxY5TMXHnPbCSCFM=
Received: from OS7PR01CA0278.jpnprd01.prod.outlook.com (2603:1096:604:259::6)
 by OSOPR01MB12185.jpnprd01.prod.outlook.com (2603:1096:604:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:26 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:259:cafe::48) by OS7PR01CA0278.outlook.office365.com
 (2603:1096:604:259::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:26 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 33D2E3000437;
	Tue, 15 Sep 2026 05:37:23 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 04/15] counter: rz-mtu3-cnt: use device-managed pm_runtime_enable()
Date: Mon, 14 Sep 2026 23:36:03 +0300
Message-ID: <20260914203614.2035277-5-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OSOPR01MB12185:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 24c55f2f-c104-41bd-27ba-08df129ffd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/RVLbpUkz5Ax+dB4CxTM7wKkCJHen0oLVy/HZxtLwe/DZ6FB9GWSNHh7258NvVYAcFDO5CjdAeEPxAIQhea6P3ohHHxj1A5lwQcVWfzfwCtl8vVdhZGd3/paFXNyte9P55VpwqWTsnRNx9RpAiJoJmmK+Sv4/h02RvHz/kdCh4EyKRRqPlUGkE3/tHNZ6QGiHiBdVmfFye0gyY1ybPWsDaWEQ6ZiEhP5h4RHd7bLdP/Tet2QwnIOnSNKfTheFPQgv/Zq3QDTQcsBGrfXQoYyvC1R2IDFASlc3M+FEk4SGbjLfUTsEZ22QdCQoN/jExNZYmlSyAtlFAe1F54xYdKvotN7ls6lS4eYLmgqHsUGdQxOPNpI9O03nF9IanafnVEfqgScvdjbxDySt8LNaRMmDv9v8eIwM4Oqs60sjspJVjQnC/jLmzuEDN5GayydqYk/zWOici2qAOWPuMWYewYMGbesjNOTHG7tF41R1ovqcyDo+J3CYIZ/8oXkJRtrJTMg7eZBHS+oPCS7+vOxfeggKJcGYEvQFLxlrdA68OoIxmqBlQxlIER4vRk2FuyQxBfcRo6gqJrNp817KJ5+y3rtMb5i7dJGr6qvURGTHQ9F1S4nUh+DvwtCFHEHKjFtMP16zyoJELDEuaoTv3g4RdJ5wTnZNYnGTEoh4ngFNfAwDQHoMPBtvCLPJ01FnZx4qOYbDhwcWjb+mDRh0WF8F5xQbA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R7nlCo6OBo7lmsDJQPPVsFH6Sh6uc+5WOh8ClR7D+ArCoNY4C53yvQopgkm4/xxhm0AtHI1RqO6qSOhBxQhgthLmPyCeYyySPlY8WTXZ/Mq+SYN+/Kqg5nL7fwYIcMlFPInthddo6MuX9jNOBjXKyhDS52Qo7oQ17UiJfUx6s6Zkbkf4lSct9b3RGNl8yYP6dnLomdTe86aZPmdAVqd0L+sa2y/4SGr1783bcR3H7acMnfeHuRgHlYfBJ1b2tCkfpe6uR9xwu87yMFmtQAqlITR1Foo6Ge84cypA2lpIgidVoxs4NUAWtjsofxFR7RbSkW1Pnq/N5eRk9PxQvV7dHL1ihB6PnE4YgYdQUTF82YBJISBpYc4GgdvguMrUh52r/9GFJec26SsMzcQmYArt7h1rI9mUdd/m4MHP13fIm2I+bn8JNCbNxfSzuiDvwWB+
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:26.6083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c55f2f-c104-41bd-27ba-08df129ffd2f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12185

devm_pm_runtime_enable() has the same semantics as the current logic,
use it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 6c171a741cc3..b99dd67703df 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -807,13 +807,6 @@ static struct counter_comp rz_mtu3_device_ext[] = {
 				 rz_mtu3_ext_input_phase_clock_select_enum),
 };
 
-static void rz_mtu3_cnt_pm_disable(void *data)
-{
-	struct device *dev = data;
-
-	pm_runtime_disable(dev);
-}
-
 static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 {
 	struct rz_mtu3 *ddata = dev_get_drvdata(pdev->dev.parent);
@@ -834,9 +827,9 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 		priv->mtu_16bit_max[i] = U16_MAX;
 
 	mutex_init(&priv->lock);
-	pm_runtime_enable(&pdev->dev);
-	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, dev);
-	if (ret < 0)
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
 		return ret;
 
 	counter->name = dev_name(dev);
-- 
2.55.0

