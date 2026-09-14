Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010008.outbound.protection.outlook.com [52.101.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F904A0EFF;
	Mon, 14 Sep 2026 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418289; cv=fail; b=KnbKIS0iADqHziUO6ZGPi+8l+3/+I+IYzMfga3WZDIB20p59F3yj9btubIw7dSY+ARhrfqJ++f0XBFDzkNDu4U43ljzUhbaHC6pAOHmAP1JhagYFyxfWuFInDG+Q++BAwZcz1W8GMZD5dicdxvrEVLnKaIWgyEG0znqlDTwYQpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418289; c=relaxed/simple;
	bh=v/ugR+pLVNXBj4P8Ao3JGpwG+MABQ+eoJrz+4UbrD9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0n+5+c7XSyR0P82uHl9MHXnpEuDPhugkkYFgnLy4MG+R8esg8PLQkt4gRvGLOwJqr6+PKZ9otBW4dKixOU/e3WywKQ4zlgix/Onz6Yk5QVEJHq7DQ317EpWuqtKZ+BAgizw7Uou0zgMDimFmlBBbcTMXrbJF/YTGL0/+8KxaAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=kjM9yFul; arc=fail smtp.client-ip=52.101.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="kjM9yFul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4739iSnBii68W4KYtaBG7KDF7gJRAok3M/q8oSGXcLd8Cdfn0+tunW4kyuJDph5vCs4LChoGPCKtK64q34qcQCnaBO92xkBKC02TDs+icSPfQoYcp+2+d4UP6iRkOoRREJ8OOn53/JJu6LIuFBlWGrsMeihrYrThrJsZgfDVwP9bh1MXPAmosyk8osdc8ofsP/DuunS37khdn8M/UqI35CeNItBTxYBbU+7fkJP0N+aasqLYn4W5RXDbht096lb4hqR6BbpgBMtjIyEHFIoQr+MHW1hYfSyeoIqqTKdfoJ1tu1ctRfWKv/EDNHaSS1xfyh7ZY7BTpOv56zZheF9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JueEWBFVCj1ty0G5NFmocceViYfMGgByRrrUdGo3OAM=;
 b=KYjelrl88XghZl+5oMvgHF4rbwzVEZso+tqZkKv2d6PNtDTcSbEbctOdXcRDTGJ/PhAhvV5b+aquNpk6cRwsvbkVAU8NiXAPyR2vBWQpxUemIjm/ZfvucvroDqdGnZ5yVaZxUVaqotoruvndzIlSBO0W6rMLRcoZNmC5zjcGRIQGK+CUxBWSo2WiPj8FkW4cLKPHjgMVUrB0D8gZfucfxgcqz78yWqiz3sydqN03ffClsAUl65nMjnpc0cp5pAUZ7Gowt6J3a5arWjUvfZvs+iAZSZSbAyJUFkqVBntGXTwZNC/lfZKdPxiOmGga59UX//Dox0IALJWRkTvbeQkZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JueEWBFVCj1ty0G5NFmocceViYfMGgByRrrUdGo3OAM=;
 b=kjM9yFulIMxdbM4VKeVDmDrdcoalBQEwbZBd88QSh9KbAQqVLHzdWHYRb0wXa30+anMEwFwFFT+u9Irn+HqwmhBF+i7gZdj8UaHN7wYXPU15lt4z2T1QT2ou4a5baB6m56c9O1p6ZDwKbGV8tqtHJIPHfEaoap/tC1roKnGMyMQ=
Received: from OSTP286CA0023.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:216::14)
 by TY4PR01MB17802.jpnprd01.prod.outlook.com (2603:1096:405:34d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:38:02 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:216:cafe::90) by OSTP286CA0023.outlook.office365.com
 (2603:1096:604:216::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.13 via Frontend Transport; Mon,
 14 Sep 2026 20:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:38:02 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C1D1B3000257;
	Tue, 15 Sep 2026 05:37:59 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 12/15] counter: rz-mtu3-cnt: cache direction values
Date: Mon, 14 Sep 2026 23:36:11 +0300
Message-ID: <20260914203614.2035277-13-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|TY4PR01MB17802:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc1badd7-2e84-41af-1405-08df12a0129b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wE6Sc1iqUlQZpnKsIPd65dNUFC8P0E+rJKs8mtOP2VrTYu1aEG+HF3uID9378Ou9gnhnVOvkRGeiY+9CwF3rzb9pSUyJVJgTZk8GEsEI95GPaupazmBkIgHGV/eZADyDezTeZHclAMj5EG2bUpuhoZ6RsENca+o/ThZezdbqpEwr1xgmbiERn8IocfUOgfcpOFAzyBdnnTtzQbuKhy9WADEVl0vFhIZGB638UJ9zCK576xRasak2M84Z72YBtSvQA6gsxRYqft5yc8AcfPeSS3ELMVk8/b/KLv4ygOikSm4IuO8og45YzOL1q/E7fq6d9KKi65G60h58GHsmFso5D+OqxWdA5Rv9XjPF31tQJr14tXYLDWIW8Q6eWNX0T5BbsecaCyGI9njCFRbam2qLgSNf4thkhPKD+Rf8yyj8t9FRyfoYmzRGBUyFcf5ADXHSCUbHlPL8bZDrUj9oRJ6MWp9h/hECtvSn+OwNflSu6R83leLWjjZ3GHWCvhJAelhBqAWknSST7J+1ZsuVnjVl0bqPAb2DSgToIWF/8btk66KuwNuWL4rHsr5X8m4Q22K8dO4iB2mEOxXKF8tehQkMar4Rje+gSryqzsMZfa7Fnl/a0KjiS5S7KK/Wf99h724Q14lf9x+ZU9OhkvQWNhSnRGVdGnqa/ir57vpG7wGZUBOQI7TsOXMH5MWOzg31n6UOu/2KVarOzH9WbEFx2UBN1w==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	56gLi+PUmkbcv9T/tAJYuP3ExkgY5X7fzG1VlFBkPGpv/x4hWPhtXr0RUXt6BVBuKmxVLB7VLBG5ZN0DtBB1l+VJJ4+AqPIYMS/MZcR6CpKLp28dDymt+sxPFeOevu1kKDJ5uFOzyp9UqtwySObSFjWStgulzZRkElGo1vfvN0598Q+Bl9r69ugChZBkyI6e+FTBTaTVJ7NumPTOS0dCw9QZd+tug5RUxxXxr3Q+wDWw4OxdvEFO8wUAZWOr+bbGGPQL/GRioDgUfnQomVFDjHuhteln3ps1e7CED4dGyPwKC3zc7fG7W04BLEg+dPiBJtUuaj6GpUzBoEvZD8p4B2SA5G9iQLAz7dFeohtb7QweT2ztLbL8mozB4uEHqy3s3HX/ZEa2164RNL5E2YAbWx74E3c7tLIFFRwsAuH+a5Iyzg6/hAAOYFCdS2COUvPm
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:38:02.5481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1badd7-2e84-41af-1405-08df12a0129b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17802

Reading registers without the count being enabled is an issue as the
ch->is_busy check inside rz_mtu3_lock_if_count_is_enabled() can race
with PWM operations.

Cache the direction value on every read and on disable, and return the
cached value if the count is disabled.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index a26b8b71c9a6..5fd12941df4c 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -79,6 +79,7 @@ struct rz_mtu3_cnt {
 	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	u8 timer_mode[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	bool direction[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool mtclkc_mtclkd;
 };
 
@@ -187,6 +188,13 @@ static void rz_mtu3_set_phcksel(struct rz_mtu3_channel *const ch, bool enable)
 				      enable);
 }
 
+static bool rz_mtu3_get_direction(struct rz_mtu3_channel *const ch)
+{
+	u8 tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
+
+	return !!(tsr & RZ_MTU3_TSR_TCFD);
+}
+
 static int rz_mtu3_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
@@ -315,18 +323,17 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	int ret;
-	u8 tsr;
 
 	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		priv->direction[count->id] = rz_mtu3_get_direction(ch);
 
-	*direction = (tsr & RZ_MTU3_TSR_TCFD) ?
+	*direction = priv->direction[count->id] ?
 		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
+
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -469,6 +476,7 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
 	priv->count[id] = rz_mtu3_get_count(ch, id);
+	priv->direction[id] = rz_mtu3_get_direction(ch);
 
 	if (id == RZ_MTU3_32_BIT_CH) {
 		rz_mtu3_disable(ch2);
-- 
2.55.0

