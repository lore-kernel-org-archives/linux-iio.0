Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011060.outbound.protection.outlook.com [52.101.125.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B294746D6;
	Sun,  4 Oct 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136148; cv=fail; b=osPJPZoS2XKCVgEmGazTZgxfoW+eZoW2eS0iFCIIraijtQczMkayfEoD6BQeQVBnZxLnD3r4c8MWAHGwdD7zBJlgrk5IC5jvEAYSB3fLPGyM1FqjpKFa/FqfehrgrPoJo3VDg6kcunoZZG3UdG6suR20K8r2cedOQXFyWnUc2Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136148; c=relaxed/simple;
	bh=q1jLnRIXMAoqPXcqBdCJ91laf7bxU6CofiBcJjmtij0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIdYKicObBlky7Vyf2i+dt17vy9MoXhVsygp3KFpvsoYB3zOEK0JJJkzlqTDMJfU8G9mxDuAWTZC9sckqwEKCNWZBRobr4WsQStw8MXmqO/n/G3Fkm5XaJsRf32ddrlMK6s/DF9oDJFL8u4N6czkrHUxvOyyNxka6aTBTc6aRyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=FmqdWQ8o; arc=fail smtp.client-ip=52.101.125.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="FmqdWQ8o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj3u8xDM7yAMS0et0edxtwSezNwW2PyX/wGeiai+/Rhifcz8IPRAl08QqBMxZqbpLnkYGt/QKb2uWOUVpdC+PsqLYXC8QMHEU4BfS3cfiEAfDbINx7bMxlEGMFCwJocPojNkpZMLFnOcamWUsh83WYZzf6tcbQhAZJGmKXOOG/qfA5Q9KsRbE3VyJQo8okFW0UwVk7IfJfxsm8ElXjPwaCaoVHUor9uHX3TS93nanYfXhED6BRWdMfvt/oWdUNQj+0VHS1Kv2HPdX+0AHOY4aXgpkGNUb3CJMPXhevBS7EXdRLRVESCL2aGoH7Wg0J6YOaN70F+3GaQM232XgR+cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73+8Pc2qfoXgQ/ySHMBXOUXWJaQvtccxuDXynaa4utI=;
 b=XPBpwMhrYDau5GB+Xij8V8BLi0IE8bEBB3oaRHfxWRmOfpCxhOO0lHD5VsZ57+EC5Lq0HI+yBduh2+pyzi9/YgS4VS+IqLYG2Nk815DtTCXy5mzBVH8uqgvbNDmS86GsdL7ZVxoKyYWcdPYfIdyezpxFJUB5sNkjDr/F7Cv8IZt59Gs+N+AFFG+WXEEYzGufoKMKlwvvm11N0HQj0Erk6ol4cMmPnFWy7e5hd+W/RD4GQCrqLv7MMKre5uCOg8myDmLQXswaf5AQP0cJM13hlIywfYPEJ9/HOqRhZ3wo5H7c0y0gtq051RnrbfpSZfeKR4xJNdQZmJaRnfIkDZl3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73+8Pc2qfoXgQ/ySHMBXOUXWJaQvtccxuDXynaa4utI=;
 b=FmqdWQ8oag2L2iHzfZ78FP4+zEUHZI756hXw6+eUQCDIPGXfIADuajBeJTveNXlBXmEhelNWdiiS3wt71BS992SZXxyp5qSGk+VKgZDv4ycADJfOxuX82Eb97A3SDcL9q5ZMIO1H7+UkUMmU012tdvdAyQa6RkjAKX9a4UeBKrs=
Received: from OS7PR01CA0244.jpnprd01.prod.outlook.com (2603:1096:604:24b::15)
 by OS7PR01MB11742.jpnprd01.prod.outlook.com (2603:1096:604:239::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:03 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24b:cafe::74) by OS7PR01CA0244.outlook.office365.com
 (2603:1096:604:24b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:02 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C72003000246;
	Mon,  5 Oct 2026 02:49:00 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 04/15] counter: rz-mtu3-cnt: use device-managed pm_runtime_enable()
Date: Sun,  4 Oct 2026 20:47:41 +0300
Message-ID: <20261004174752.507499-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|OS7PR01MB11742:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0a2db98-de1e-4fde-09a2-08df223fc72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bcP2PNLrPbMZs9F6d7Ca7hkJZVIMGXKrephL4H/YySlYfczCHJxQd7GQX9G0nM0ZcJrCv4jqPAkopx5LlXIpsTUl4MIoic3uSkuJkKWez/n/ITiyyK4XSTzSxa29h2wgM+c0riqCMX6VWklW5LH0W62y2JWXPh7moCqkduvyVhI/eV6Ryz57I9d2KuPGrSvGSeTpJuHqH6FkHjVwk5UQ01UPLennSYOEGVdOELGjcwZXii6cwof6TVFOFUtscV05EzKMLEbh/r27ov08/MG0bA0RtMGZ5MV1kY1Py3idI7QshPUA9kDORD+/+U+/9jGymkv90Cufkc7krcFMLvJWTRhiuPFcXwGnRuTQ+WHqRHZ6PUkVKAwyml0ga3VNGqRoB+SPpZ4jA3SXGHWhijKjJkPH093uPP2AxWWW6s0M4jGoMsNInfUVCi9ve9v5OwWqQuSoxZ+sKZsma8afgU9laQ788Wnn4YtlxA0AiBVjBddIhlHKqUCCDmqnfM5Pnr+zuOvlozdOplBFfu9ueUtWC50MG5B8hwO9K8WClGkC2S1bp5iYYSWnEC+XtctKuZiQXztSjl/lUO/uKgsjumJj2hJj9tqWq1lNQ4L3Ith480h7pGqY000SX+KDXfrwXoqxLNQofwLtKSP+qvIb1MDHZRfDPystyKbT0qycDkZmFlJ8k5iDwsQKHWxKe1QZCXAT
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c4SspArK8znXOEsJtrRYA8BDdu4oLD6BQLIMcBUxwb/lxg7B9q+8aM9ER5LEqd2chUsvuaKKnvAC3qsdw/rQtjRAWNzNaF7EwyGFPb6soO55kR7HtE18BJIivHAi1R1eMusx9G9+mMA1eEIUulRQf83cLnNW++gjMb4YclqnDo0IwtNNWCLF9WzuE4tVLIBsq2jaDJ8V3D12XRoqS0/T6sdlrnC0Hj9XW6M15xv6HUS/rAOtcA5POK0v06xBz9Qzju43mh2folKkdUr7Ag4wTL+sNLNUd3HtDLUtUDipK5NcDBIp0sG+f9KdlHkjwilCrZcnCXah/T/4+/Q+yhTco+KnqfSBNlyaUrOGekdVyDZ/ilo10Z6/ltg8dADhtbEcadaCDSUCjUzAhhoqm7/CMuKePcDwqTQLURSsl70wCVumYsJuwrgTKuo+r5iCRDAp
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:02.9161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a2db98-de1e-4fde-09a2-08df223fc72d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11742

devm_pm_runtime_enable() has the same semantics as the current logic,
use it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index ecbb89c7e14a..cc64ac363fa0 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -805,13 +805,6 @@ static struct counter_comp rz_mtu3_device_ext[] = {
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
@@ -832,9 +825,9 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
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
