Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011043.outbound.protection.outlook.com [52.101.125.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F02DBF75;
	Mon, 14 Sep 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418237; cv=fail; b=lRO+c+8B6jEeryqS6B5QOi3hIFd0IvTqo1zMAZMeJyAYSud7p0OGeTEIIDm7WmR68n2PWphNgdDu24JqqJeHdH70h4XUpTHk6FctW7jvLyhexKZErsyLzA7gizaAvl2thnCJLQa+KNiQdb03Wtpvn/tLrAFYmJkQe+Acp6oV/uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418237; c=relaxed/simple;
	bh=nP5cRycUJdH226FtQ5EWOSIoX+X1mbtbCDAWz6IDJMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WHaGV11v8lIFhEAC5gi/fHqBE/Srp6XvrCGEfshh/zEQMOEjt1Im+iMaoQV5DTHC/+WuIgLlnzgdTteN6RZwAl8b633mvSmDRy0lE3CiDGOMwPsiiPVKA1b8ZHiUu7Bx1+TFZ/bx9tKAtuA2KlhxxMf8xtirV3dzQ6JWci8kVYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=AIgSYnJA; arc=fail smtp.client-ip=52.101.125.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="AIgSYnJA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8b/c9eyNAHv77MKZ+P28IAqBPhsihPQCNhZ6lrPSlm2/6jfUGawQiraAYZF0J8p7JoD0XjnH4CPIYYffTZDvjTEEGtPzuho7gcnetNM+lIDAZr5pEoAvNoFXn780sVYjz8zLTMzfJDJ02Y8j5IK18EsoG0pHhyFhf4kTipBSOSBjb2keu92cMMRJI9RW1oe9WFR4IuzuP1kaU0HSALXUUbJUAMDg0WgDEKt7ZDHpfqxoDNXVcpgQyh+80rAB2Kr3PyY4PgBKM4hmfHSHZDOqVk+TDvCh26M0jGjwal5e89hJrstafXt2+e9fJTL+G0zhTLJrz+DcHsfdgJLAQXi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hePFeQ3B5X/8+3i8iCuADWye+uBZ8GHnbO3cnPSYhR8=;
 b=t1DP2Vy0YvF+o5mTl5O0Jb7etsvWKHSVvXjL2PL0V+6QVa/cw7UEjggElMkPZPkSPtT7VD0Bt5AW0eTOr6ROLotUBLRqHEAZ3A5iSZ0JED12HJgkJJOl0tVMvolLV2FvnmgT6S4Jjw2eSdMe9uXKkb8ZsNbVl3AEWe7MJuOJdxb2pDrg76qNCivziVz8TfVJt6K2LNSr6xsG7o6E2ZVcYLm7fD5EfIHocPwAI3NkVSkYCODC5AHamOgV171u1vgAyt8R7+oRbpbLkyvSSGore5i+sFgeDmIqzdXTRAr6l9tAeMXFb4Y1yK2KzA52RsnOISe2QECTtRxvsp+Lr85pzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hePFeQ3B5X/8+3i8iCuADWye+uBZ8GHnbO3cnPSYhR8=;
 b=AIgSYnJAIBcRVPKfAF3VCsfutBZvSbZaDjTc0sFddsgn7wX7ycJ5fEsEgwrd9ZcVoPMG6QGrCq+7IGaehCGkZ87JA3O/pgK0sB+ZRQJuf/F4L77m6wX9aq1eH3sasjd9btSvJFEi44FxasanXk1IwT3toS5F8NbaUmzhNBU6s2I=
Received: from OS0P286CA0025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:9d::12)
 by TYYPR01MB12762.jpnprd01.prod.outlook.com (2603:1096:405:15b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:11 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9d:cafe::82) by OS0P286CA0025.outlook.office365.com
 (2603:1096:604:9d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:10 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4A2653000437;
	Tue, 15 Sep 2026 05:37:08 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 00/15] MTU3 counter fixes and improvements
Date: Mon, 14 Sep 2026 23:35:59 +0300
Message-ID: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYYPR01MB12762:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a81234c-dfb8-4664-20b2-08df129ff3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|6133799003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	FPEfkiirjd2C8Aiu0+K3WZ3jJygz+ihkkKsR1ujQOsFzvUuON2XMLkl3jPIdAB+7qb9LVCRoYhW4o6l7YXLL2qQaTBVBQLkhktClG7wC6Z/htvpeYQTF59OWx6UUoMOC+ghUW0Exjsc/YuUJQdwSpJ35TKbTlfdnPPz+U4/VXy1k4TfGoHxa7b1o9j7EA2NsNFhw3sUxikEncQPK/DEdE+Nvcm0bBs08fTbG067gw9wubQjlfVnNrAYwtvmpBhXulTT1xGTyxeexjPLf+dWUgdXGRtHYiumupnqSd2wDFTYiWsI16MmsmJNOTmv9/701RdIceFe8Jd6qWlisZi6Ij0rcVd0LIYh6JDHFZbdsLxjelSoBws05cMTInFNCOp6hRdcy9WEn+F2jWmi4DHi/+vtK0e0MSf4VqbQ7nAGpRhFecPbfbynsHIOclYb2gqFCMJgOJlt5Ug8Ry+uLbrmei39JdbP02UUbK8Sw4x5z68EDmMWA/S1o00IAzmXXfe8Jq7e6gnRhaLMIzpYqm0icqkCxJCDNpAYedBFY4JoxKNiR8yEPuhiuw3YPo6u3z05kOJwh5/NQ89+DRTQBXhQLR6rPu+IlgVgsHOlL+33adlu8wDSvbVnFfNVhSH+EaH7F2USlJCFKNC06E+Iqvl2Oa2vKMPZ8gJ5+x5tL+X77bJ0rGrVoxpQDG5twSuT3JCnPQ1HkTP1yj9FGO8TJhdUZhQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4Yo5dbd8D9ohcr7g1yRFAIQi+S8g0poZcX7tWTsY+X11iDGelGX52LO8R5LXVtNQ+q5e+negwA3Ul3ciMndzFgYDLrFhJDYGzpwLbBLKDZx1VQ496YPiSVQfAOsyYr8FynFOSoi1kOPtPBrm38xDQIKKMVMab6v5HNf6oHNSQvj0qhBdL1cEBL6XJhW8aMaBb/Z7IrJ1lAl/FMyPOkDUZusPoldEy1y0QtxABA7uTIHcwFvk1FGOCnEZjSx6SRq1WRJ2SkmTfw7EdLTgVWdkECvYP0piyZjsxwrJyXB/FWZ9Luz1AJwXNbQFuLNnqUw7PJz4AOOjRQ8pJH5KekD5bp8WM3UwoiYscgt4IT3F4TBpdFg41dIb+K95i+cm1VC17UUqFd0pusAxHww33BHpzsQy2v+5NjyhmGhfec1VaFfMLmGVsg8M+wheyQQ2HWQu
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:10.9525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a81234c-dfb8-4664-20b2-08df129ff3da
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12762

This series does some code quality improvements to the MTU3 counter
subdriver, while also fixing bugs and adding caching support so that
registers are not touched when the counter is disabled, as there is no
request API.

Patch 3 relies on the following series to enable runtime PM on the
parent device so that the PM domain handles it automatically.

https://lore.kernel.org/lkml/20260914201456.2018403-1-cosmin-gabriel.tanislav.xa@renesas.com/

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

 drivers/counter/rz-mtu3-cnt.c | 443 +++++++++++-----------------------
 1 file changed, 139 insertions(+), 304 deletions(-)

-- 
2.55.0

