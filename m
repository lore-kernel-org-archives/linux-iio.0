Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010067.outbound.protection.outlook.com [52.101.229.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B463C1404;
	Sun,  4 Oct 2026 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136135; cv=fail; b=fg9KGY14D41d5c3RPmAQHFEozwzohq8QmhVwRjyVsVWreXySf8t39woKtptttHapTlzxbjx0/QudlOy7I0KCTUaP95aqQrNr1ZtYvVvRbR3/t1M11/swoTrLAiK8meVSBdL0RkFQPM+8xcL5/LCw37ibceP0H3nrev6sH1lAS58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136135; c=relaxed/simple;
	bh=QcMX/NJMIeXfzRDe4gY62DVqSCalqelMc/N/7DoUbIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rGlaXEEPFS6RPNRKG4CNo3UEs25eUKZMiknsL/AfkIT5cTT+xl1choeAJS89VmuQPM9FWASYvB5IeksbYYd5p2G1Veb+WcpyIy6WEkl1DxBx8itdo+ln6LF75zRX/ah90JPxW7v8zUoY9Jt3rI503Ubnmiw1jLPZ5LcVK+rLxXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WfCJZS8H; arc=fail smtp.client-ip=52.101.229.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WfCJZS8H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4dMNP+Gmy/psxuW3qZiyn8hpAi3vhONjcnqCDlrHnuAvaltjSir5s59+q471j2pMJwKVGjQiZ92sk/xdB8xyQ89cmR0vi08UvbCT/JoCwej+f6NTWbnXvUJjPd2U+gZv0587zBwbV2QKakBCgsVC1zMpH+Zm8jO6prJXJn+anPujZ8PesdIff+gTndNvAjx8YZIzeXxi6wcFy3te4eU9KVTFjDjC4f+uc6MH06QnHr9ImwiLXwlAM+bR29hbkgqhQuYbo4qP47kxnfHyI18A5lNKdK3WAamb2n34bELDNMM3wNPJlgITo2jjnyStcQgGzpAgrlvAz/nZPy0q2uZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/28RfmNaObnK8nUhaJkp/yBDEtHGhxaK2BqsrqGjiw=;
 b=sGy/hHakpcu8jkTDlvrHvny31H5VXt7bzSIPMiCbTYuzqfKhPKmqh3phq+BxCKTg6tozQr1J+M4NdSPzHmNQ4h63H3CkJ791AN93NhQDz584MasBJqTPUopwS1OxHCEiBBOqlurblP3MQN6Eyh+kpNFuao27iHYEMp8rj0Jj55Fh9apn0bHbXjDFlQhuLhMAuMqWDxTOgjsqUy5wbCOzvUmRYBbWXeYr14hTCOgL9jcGImstZLYi5PsCYAuMJEBfLMa2Uu+yZYV2upq3WU4RKlw65NuX85vX3ms5vRqntx4lWawsPl8Wtsl/ADAawwHGoCWwcqsQphh4zC1vI4jSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/28RfmNaObnK8nUhaJkp/yBDEtHGhxaK2BqsrqGjiw=;
 b=WfCJZS8HJQveFBZV8R9YcvC5n8y5f9oHmFAOSOk0t1S9N9VAqbGA5fZ/U14XEukaodoYZC3wSdA0ynojgmkc5ddbefEc9HKfau6+GC9/tpw9l2um05LnN0RWFbdqA1Wm8SLIl48CTkuGFEIMaqeCKBIiOmBZoCkd8oz0Ixv5E/8=
Received: from OSTPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:604:220::19)
 by TYWPR01MB10631.jpnprd01.prod.outlook.com (2603:1096:400:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:48:49 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:220:cafe::8) by OSTPR01CA0005.outlook.office365.com
 (2603:1096:604:220::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:48:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:48:49 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id B716F3000246;
	Mon,  5 Oct 2026 02:48:47 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 00/15] MTU3 counter fixes and improvements
Date: Sun,  4 Oct 2026 20:47:37 +0300
Message-ID: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYWPR01MB10631:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d793310c-43c4-4ef3-22da-08df223fbf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|10067099003|6133799003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	1vkQ9my+9rlVYXn/jPqrcwuQIdaDkxO3TNzA2kxQFD0Nu3hzare3AcbEG/hsL7iqr/6pokMI9E9TWHWjOtRT8u9VLAmWkt/lpEpaJbnqFeVc/xnCLJJr5UGIgE3XckgsliHVa57Cgpp68NU2vRyCfc6RsLREPwy1Vo42daaLnOiVKOgxWCVOvqUe4yxqnk3bjIPRhmB0a8itZVeLy6Lwl1VBZyglyEJXb/3DP+xcxonbhle743vL16ZM2FBGZTAcqf4yfoRU+tNniqARKkvhyBoNUoQ845NQwTdYRnoRJvaFhj+3WaV096dz0j9zgh/pH1yK549OUzrewjx5z5leq45ZXFOqfPh7Zgfur3sv2YvVm7dusdUu7jam1ZeTDeH5QtXJcl1nQO1KtyMcRCN8pq+IBp0nJcgTb2uQwuTRZ/TBmb3ZCiZJ8U20XecNaqBsSH1pMRfRhhs+dAxO6bFS8VhpP2G/aNA62VmJHoMM5l6OljuJHTMvIkFWjNC96KSJG7BrTBvVHZxPgCjwj0U7qRbSvYn9FlGVLs+5kHD8wfcFS8aE/jKrsH2Tjhr/nUCJN0NT/geRDc/lwIhnLfaa0Wt9dLCKXIHI5dZY9uIvL0B3aGFyvUxxuIhG9FAVKuKjmi8nb+3NOw0SY/LGxFppyZztC+PmMZeuUyap6KFW/hJOovLqfCNgZgdlhU7RTDV8LXEAPW5Im5TjueTl9eb1fQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JaMUTVIAYzoG5io9O/kV1Nm7m6Uf3tgtbBxSgRcsmITjwWrKEKbu8qcM9haDenK+ot+b2XbwfNvEXHALrqfCWS/vg8kr1xs5YfUsp8j6gkHVDEKRULjgl4y+Y7BA4Z3yG/drRz9fBs+sz03FaQ4YmF/Jm1JjwNXQDVKRZZD/wdI/7cyUSYgCS4AQrygaoW/nZ83UMedngypBbrvMJvAEP1X7ROejoxuhVQi6TOXmrzZjnup0vrrrWMvxcQLkwyKWiiUg8v5e6BBqrA/hyItxMGJh3tQsts1DXjSMLp+5UUNViCXdMWbhiIH6sDeR0hVamSciYyV14z+n1HMbnS0qhHjenPOUsBibAsYqKcQv9YU8HaDHyhUjlHamduCdkoUhYx++SG+oUKpwCtLZugcT4qpgzaX0q+UUI0f4pp4pVguQB+sh6CQxHs+v+BpNkk2z
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:48:49.8753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d793310c-43c4-4ef3-22da-08df223fbf67
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10631

This series does some code quality improvements to the MTU3 counter
subdriver, while also fixing bugs and adding caching support so that
registers are not touched when the counter is disabled, as there is no
request API.

Patch 3 relies on the following series to enable runtime PM on the
parent device so that the PM domain handles it automatically.

https://lore.kernel.org/lkml/20261004174024.502949-1-cosmin-gabriel.tanislav.xa@renesas.com

V2:
 * remove clk.h include
 * remove struct rz_mtu3_cnt::clk documentation
 * fix struct rz_mtu3_cnt::ceiling documentation
 * add struct rz_mtu3_cnt::count documentation
 * add struct rz_mtu3_cnt::timer_mode documentation
 * add struct rz_mtu3_cnt::mtclkc_mtclkd documentation
 * add struct rz_mtu3_cnt::direction documentation
 * add struct rz_mtu3_cnt::cascade_counts_enable documentation
 * remove now-unused RZ_MTU3_MAX_HW_CNTR_CHANNELS macro
 * move rz_mtu3_set_lwa() call after rz_mtu3_disable()
 * mention the removed busy check
 * mask 16-bit counter value to preserve behavior

Cosmin Tanislav (15):
  counter: rz-mtu3-cnt: put runtime PM on initialization error path
  counter: rz-mtu3-cnt: do not assign struct rz_mtu3_channel::dev
  counter: rz-mtu3-cnt: remove manual runtime PM handling
  counter: rz-mtu3-cnt: use device-managed pm_runtime_enable()
  counter: rz-mtu3-cnt: read enable value from cache
  counter: rz-mtu3-cnt: disable channel before releasing
  counter: rz-mtu3-cnt: unify ceiling values
  counter: rz-mtu3-cnt: cache ceiling values
  counter: rz-mtu3-cnt: cache count values
  counter: rz-mtu3-cnt: cache function values
  counter: rz-mtu3-cnt: cache external input phase clock value
  counter: rz-mtu3-cnt: cache direction values
  counter: rz-mtu3-cnt: keep cascade_counts_enable in sync with usage
  counter: rz-mtu3-cnt: drop conditional locks
  counter: rz-mtu3-cnt: use pm_runtime_resume_and_get()

 drivers/counter/rz-mtu3-cnt.c | 458 +++++++++++-----------------------
 1 file changed, 149 insertions(+), 309 deletions(-)

-- 
2.55.0

