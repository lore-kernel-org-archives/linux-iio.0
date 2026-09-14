Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011036.outbound.protection.outlook.com [52.101.125.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A944A0907;
	Mon, 14 Sep 2026 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418301; cv=fail; b=cKOl4YyVFt1KxXHEdXCC23v2fnhBAXSQkcyTpTMgTha8cNev5bBYuuH9ym/uzimhNYcZHrUwvR86rJC8wSohphuuWjTUVmg/dcAtJAFYkCZcQ1XRZKerBbfeT27QfCCbnbb58gzllEn/1zZ1X0hxqKfyX9JZhRKyE2uY8vyWi/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418301; c=relaxed/simple;
	bh=OH4GzFenZk20CNwn7D//X59P0s98zUHC+Id0xYL2cV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxfhxVQ59+G7JCE1y6JPvVBeoiTBND8vo7DjQITUaxjUreJ/2YATeFVRtaJZ4JrQWPfIw5InKa8i4259L5nAV4wbmgfJJknKwwntsTP/aqMqB1C3XPezI+mwGXL/00t1eeyCioOmP9LeIh+SJQ7WgnnEg/oCEn0zHby7tQf3/k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=g2lRp19s; arc=fail smtp.client-ip=52.101.125.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="g2lRp19s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0Hv7t1Lcm/5jMaNd3jC+ZXVPmMa6h7+asQAsbRocpP2D9G6V0O8Xxc5Do8fnTbWUCvCTDWWMb30XxBx6dN0uFkFaQni2IaBIqL1XESj8zoYm4Z+aDC3/Rs8KYCyQv2zGmevQWjoZbwFnK/TJK74KJKGJEYIgS4B0JW0BhNTNCMHLF5PAearQZGCqpGa6O8xLI7gTyEFpdD9oD3u8MjAByylU5ktwpPgF8/8q3ATvUBPm9YqfxfhyZnlZBXtFyeFpxFgdkt+MXGdD/Nx4vdiG7HoSMk4bebsWoLrSHflxEZHNjgFHmrgT1VCVgxQN/9jnGYyPmKoloxG9bU9JOPZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbrHNcKwJnH819dmwPOhYHLkU2FtSPBvC6rXJIWixeQ=;
 b=Deg4QnHlnCZSk3+quNnn+MUm3cXRVSy6Jr/P2+WkZ6ypfND4+9ckDfT04JtVQIW/ZoiRusSpIP/zoIDlHr9ls1rT8LD6ZtI0M1mdtmKI6NaseDsJBL7IIdLP8Hlr5laC8+Zgs2qSHALZoDhKoY0d6Rtulw/ZMqYWYNq4yuy+nno6wfz3wYaDJLEG00Wzz5vrBnnAnoDS2IORtnq3WE4xgJJ1QrCUAB+O8DEh9wr08MIZBw93nt7khcadFZRxkPyKbnpjGyidPinaVJqDYISXv7fT3/PQVOTWBfbwA+pwOId6oqtcbe4VI3Htfe0x4gHHsiomfpGpAtB2O/z4FyROmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbrHNcKwJnH819dmwPOhYHLkU2FtSPBvC6rXJIWixeQ=;
 b=g2lRp19sBaCPDZrL0S7kChIYjKYxPU3QdkGQZhNOYoDV4Eq9VGbZdwUo3M4pfHv680w/UYGG+Y0d0yxTx+T1QeybOJrFWQid/vFk79YEhLjxciTn21IU3RG7QmbnVKxYS9dmrAicX96CAtWDZLprrHu6G1++Ju9BDFe69rcc/GU=
Received: from OS7PR01CA0276.jpnprd01.prod.outlook.com (2603:1096:604:259::10)
 by TYRPR01MB16382.jpnprd01.prod.outlook.com (2603:1096:405:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:38:14 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:259:cafe::8e) by OS7PR01CA0276.outlook.office365.com
 (2603:1096:604:259::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:38:14 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D9EE53000368;
	Tue, 15 Sep 2026 05:38:11 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 15/15] counter: rz-mtu3-cnt: use pm_runtime_resume_and_get()
Date: Mon, 14 Sep 2026 23:36:14 +0300
Message-ID: <20260914203614.2035277-16-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYRPR01MB16382:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dd487cbe-6032-4c1a-9151-08df12a019c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Dst0ZmmVAsgNOCM2J+xceUW7UDL5v6r2mBsE3blWz27p8MmHFqH7UiI+uEJgaqe7jwNG/EmBCRc7eX4nQCVUJcape+7dd6BAtTQnKbd59XoLj7chwTwCen6bReEtQ0MzPRGskWe0W8Bzn0lczrbkC0fuSITfhJpAd4HPDMNkZPbwFEpaVnXw9zja7+VUOjgQ0z1pmTMxezm6NAHQXCO9fqgFKLumrinhqUZ5AD//ZkjSWRweDnSYFdV34nfdmQK8nMxh+FcDUYTx6oWwmSv5C4t0OGGfK7B2xJAzQIOWlWlxw9i1LtmkDxh4ikxvz1uLZBV4zbfCHkK622UebLgydZfxNKbydS8f5qyZ6rlqNVtfL8N9srU5C3x3P7ZqtsQD5hVD6Zez5EFTAt2orbvQy7Goz1h+rudo5lQTz++tMVS3z0/U5N/s9RaVQfzPMfPoXA9B1HposDpRYUMXRFEbLTM3Q8nbXFYgHIV2izGM3To+PUXbGc9FZE6ONssdpieVmRxmUVeuBH2rvaY7cVa+O5NRRKd1al5Dmr/KaVHmrf6DdXj+/2AbhktpitlIJPq+GYgqoVoCr9dZ4Lb9CEi7XcA6Zzqy+PZmBbB+GZGd5nzFZb7GMNz3O24IXenoxRUB/YGwXoQbggAhyko4aoNTVm7qwVhjMTgZC//LkxYc2v9pt3AnCAEHlRX0X26R+2vnSsx2WKolVPzFCFB4uJ5awQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	InWXoa8aKj013xTLcokUOFk9fMsBdaggS3jkJARTNVrajsO2zP0BdqDnGpphgk7uo3miYHX++MIaorA+NYzFyVbKp9WTC+tCc5HTqyEwwsGcGC/WUOlcJ3IPK4UcXyptgk+uWvS0leQCOy+FevVGPTKAQnVlUD8MHbgNOeC1wYsOGpUL/ZCNN2exaQ1bGJHKryjjmUugz08kk4t/x16nomCm2thvYrGgzU1MMisv+likiCuRjsZ+uPF+H0DDVIvX7BQq9MF4zqkIAdoFKDVciR1TZNrNhmG3NVfKlBtsyrxb/WbZWAv9BZQQ4VgjTreWEBTqF7BreRVMGgmnHxxO+Fgbjw+M/VG7phZ/f6g7VzgiASHyja9//oF8UAS1eA9n/eswheQmdJQmGgxdl2bRVFeupztZC7FGEcW3E61AXgqPBNCWZ32Mvj8+NPeJvXhz
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:38:14.5518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd487cbe-6032-4c1a-9151-08df12a019c2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16382

pm_runtime_get_sync() may increment the runtime PM usage count even if
the resume fails, which requires an explicit pm_runtime_put_noidle() to
balance it.

This driver ignores the return value of pm_runtime_get_sync(), risking
accessing device registers even if resume failed.

Replace it with pm_runtime_resume_and_get() and handle errors properly.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index f3e8fe5cb818..c6877f988b8b 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -430,7 +430,10 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		return 0;
 
 	if (enable) {
-		pm_runtime_get_sync(counter->parent);
+		ret = pm_runtime_resume_and_get(counter->parent);
+		if (ret)
+			return ret;
+
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret) {
 			pm_runtime_put(counter->parent);
-- 
2.55.0

