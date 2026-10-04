Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010044.outbound.protection.outlook.com [52.101.228.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C44746DD;
	Sun,  4 Oct 2026 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136157; cv=fail; b=t7kaoH5DEiEWbu4amBfTGw7rc/GZRKsPCBRPsIYn7aiuaQTVRyXpDyhPFFLLWs0R8OveUn0VCjBB2/roMkZi/7+hSVlvz36VC9me8/AW77s+k3/GPFx/s7xer4wshB6XiTviGfuKrPDEZgomZOIY/uga+CI3Nld8nPGEBoHrvGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136157; c=relaxed/simple;
	bh=pNtWIkPY3mGvxYIXIMhip/3ZP0AeJ4XgkfXAFvWn2Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5BZmnetzP2pZuKc0JromJr8Qx/Vmf+iJ7d4tOO8EFkNuWtFjeq7c0z8WosRpoLs6ZbhurCDflx1xv8mm5mHqc5yHUCYE0VU/ALpOsPCm3tCW7XlueQZll602dWKT4E2qOPotpA3+KaMm+foggyb5+Gj8gBT+0dp+L6+X8nFyLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=iuS0KPnc; arc=fail smtp.client-ip=52.101.228.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="iuS0KPnc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKwj27YG6xfPiNKBQBg7ZuslRUZ9KNDeQKe2jQ6OV5bbi7gA8ae9Bp0hoctIPHE1am+trkPafVI28kFOx/3CAds0Zfkkpaekvi16j2PpkOt15XSkFCVZ1wmqTtLfHlh9VNNk/OkJT2HCP84RcmGJsuUSE8t/pI4AkQ7toaFjmy7Is6PnT2NKr1h7+aZF5Xt0KbjXFhdAtbNNMHs2vXOsp5rh4JSWKMpD0qmJkXOTu3RXr4k7HjmC9kqsNwk4pEth++MhFOYiru9GYvwowABiSrEAPLwWNOhF3zDrGITdMFs0rtAhdNi1vY2QJI0RlvP5gJ0gqEM2MqUaC6RZsEF5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqYN1+90NT77/ywb6Xaph7GVHQMNZN+AcVQigaIEIaw=;
 b=GNt2hEGCm/yiy1F+6PasAFYUHYtAu48XEhaDGCZTNaasqSeIfOjFisabQbso0MLi9e4sOsNo8IBlSZRQH00FiiTwAWphGBaI4tzDsZ/A6ya6YAG7ZknY4vGPqax3ykEaA1CQCnw/dBUPn6bYxGMk0B6GmRVSDoL5geKsu2Wr/Yos2vQYLdIwTfE9E4Nsqxc6kwj1EKAxkx4rfxPu7eHY6+Fthv48XYko3kfC6N122mn5F8uSsHTvSDuty5ESMWIbNTeWu5EYepRgwAMyAiMXD7Io5cKUPE+N3MlIKqIZ2+T2AU3ITDuTZVEm4Y4kAa+ltL970q18ZjrFaVvx+LNkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqYN1+90NT77/ywb6Xaph7GVHQMNZN+AcVQigaIEIaw=;
 b=iuS0KPncmqEI2eIVUhAr+j+zwQgo4KfLFuuz9EXM5JJUd7ukkvGVQa6ufexjtoFPqVLpUwTlCFWy7bNfhY1ftfDjNCrvnfVyPW8hyhG0BA1uLwB9aYu4yF+aHRFzM9wpivsfKFml7JPg5KQRqlnFUSfFO0Sp6Rnk9lL33MS5VH0=
Received: from OSTP286CA0053.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:217::16)
 by TY4PR01MB17240.jpnprd01.prod.outlook.com (2603:1096:405:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:09 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:217:cafe::1a) by OSTP286CA0053.outlook.office365.com
 (2603:1096:604:217::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:09 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 300643000253;
	Mon,  5 Oct 2026 02:49:06 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 06/15] counter: rz-mtu3-cnt: disable channel before releasing
Date: Sun,  4 Oct 2026 20:47:43 +0300
Message-ID: <20261004174752.507499-7-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TY4PR01MB17240:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c742afcc-b616-4daa-8937-08df223fcafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0xcSqgUdT+XUn2v2xuWmH/99N0S1gDevA3mYTxgNFfxtGNFBwps1CQFoPpcAvo4rm0w8RYxHTBO5yF8z6fwSgd64r7QBQGU+CLJzAJ1yzddpv6i6MTQJA55Xu4yI1MZo1b78mEcYs7K9TJpD3YIhue33p2q18qzHSHjlFEe8o696zMAVyAXDNU1NkKzDPgsYyzM5Gg8ZYudpjh/+/YxvcARDY2VFdpru7sES9oTIt0i1SIW1gFKoZbbi2AQA42oBt87VdSqDOQQw8SHLflIRIBG7xcqOmHmASq8wjlRkI4x/f+vrsGwcjKDVPWApX1zLxU4SsyxnnyP1K8KswsS4RZw4obiNA8io5cVyWIfhrhpnI3Py4kan3v7yXaTpqXqpawqI9J/KSzYj1au0zMqN7R2fgJ1YqYpl3/zVyPIRgTvbhQRlSjdPjqu6VisVuQRlxnYF73YZa3BYM5dOVohgYnhLQcdtHBdsQPGo/SOc+Pu4VWfOHInhsH9YdZbzWeu/YdA7kfcz1zGG6gqi/sb35ThAcbc/PqO3PwHEevaXnTqsLmGzuhgXbj+dlQvPonG1ikzg08O9b1pQ+EuyK1XBJwe+EnJFi10UIJ+KlEF+QqG/ostrvZ612SmxiEw5kmwakFABnKd0bYWGWp4pS722lbLr/G7iW22dZSDF3euCC481T25/LP9cWJZnGoEgDGXsgL06tLgjD3OiSk0fjXt1JA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w5jYebdHes5epuYCtgF5wqOkCd0uLryHdtyvoBcl3OtNgOxht4xc1njg97i7dVGJ372Veoh5R6bZ9zc/juqw3sNN0JRyZu2sTTUerr9Pvm7lsVDayv9jj7jxwdfY6vEZjJKgFP2vMYrgX9kWnBFoMc2I6B0xZeD3+GvOUOkNC5uzC4Sk29YnKCdQNK/Lca+7Xf7wC7popA0noKMl5WavVdUQpyqjGcF7XgfdIvetDL4d7qCEdHdQkY40JPBkCEA8WT4SVb7OKi/9RyzDgjHlHJ5GnM7tNGhg5Q95GnY1cOxj3IMOOIrkgJezt9KIvSAdSwRrfW0R4KWxwF+9O5buLD9kDaLCkt+GAJQOg2LIUODOQO39UFRMahofXnJxcrQqvr5FGv6fLblgBMIO4g57+9kv1qLdDU9eqjM+DSFlB1lcc5NfiIMHcQ/xVYQNovfP
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:09.2960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c742afcc-b616-4daa-8937-08df223fcafa
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17240

Releasing a channel marks it as not busy, allowing other threads to
claim it. With the current logic, it is possible for another thread to
claim the channel before disable is called, since we release the channel
before we disable it, causing the channel to possibly remain disabled
while it should have been enabled.

Disable the channel before releasing it.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 3e1323d40dbb..f3c4d857674f 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -456,13 +456,13 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 
 	if (id == RZ_MTU3_32_BIT_CH) {
-		rz_mtu3_release_channel(ch2);
-		rz_mtu3_release_channel(ch1);
 		rz_mtu3_disable(ch2);
 		rz_mtu3_disable(ch1);
+		rz_mtu3_release_channel(ch2);
+		rz_mtu3_release_channel(ch1);
 	} else {
-		rz_mtu3_release_channel(ch);
 		rz_mtu3_disable(ch);
+		rz_mtu3_release_channel(ch);
 	}
 }
 
-- 
2.55.0
