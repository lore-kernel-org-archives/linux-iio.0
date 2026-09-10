Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010067.outbound.protection.outlook.com [52.101.228.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DF3C3BFC;
	Thu, 10 Sep 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030567; cv=fail; b=AwzaJrLvlTCfDlHABnNs/CsEP2lZNfOPy6KdC6NXb/TQoTmk/LsBWcpepYMR3Va/Optz/nGYzqRfpXJz84EX7oofT8UquHrzHcqlyiZwdv1/55cQveYAvZjiDo8X16INfFUlcTD5bivp7pt3eOtpuTopKJnfnVEAI4Ff9YnX/4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030567; c=relaxed/simple;
	bh=A95xQ8FoU095WgclZUzYHcD4AKxqfh9gHEZkEgGntMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fp9pOxBq2jTxDSWzg31sL+ZKRxZrXTRgR9fvaRS85EfQCVkZ0uLW/g5GUreolhoui0FlQxG5Ey2fdGUqtxpyjKG7+YYnLeIN6xGp1h49kLrqPo//J2ZPw6WRz2R1caBgw8yrQC6gJHysTyfrvFdeaVCx+sTbuTdFcn+rct31ZfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=gwAjVFJw; arc=fail smtp.client-ip=52.101.228.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="gwAjVFJw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbhatY0KzOKztZkVzxA77UhBZ5ULAeI/20gHcD57i0kckinCl60sYoBt3RevLk5SmwgJ0XqiZ/zAwVjRjsDMWJSm5KhbOgGtnSKs5AtA+tqAu/6hC+o/buRW1Z2sdi2J1vQYOWkdcXjVmI7zW3ANBMKjwYkGKizZNXr6vH3amNx+eCUAAqzvozsYiFLuu2aZ1ccqgMsJ7PuZ4fzb/e0y7cpqQxmN0Dlek6VKBNBgbtzsDMoG0GiHE66dtc6xS+wI9e4cMSCd9lSUmdaGThgiSvhcpll+2oPUwirsrcS8Vu3vELSaekQwvu/3nKyWsbWYKJyzrXPE+j0ghygcA+uztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDVFoaxAdZZKimhYNQK5WwzmRGrnH0ovTie2Ntpfs74=;
 b=wouVUxx06BYEocsVHKeTUieUMo6d9Kr9Oo4398xRHY5IUvx+sNAtxlBfUdrUBX+k1+5zVHlJJJWgOlyw+NfkoCB/2FIONLkGzF1hanL0JbizsCt6f8rirNyePV1sDX3NEis4oGYvrxNQwjz13TIrKsMBT/IkGZ5YA5GDUamNokCMWux6t1YxsX+vXEkBfClMJR1xkYXu7MLv5nCK3yeTSvNslP9nDqiDglxZCap1EoWt21SniJG3bZBkCLJ6sYekwjK4zlqJv5Xv020LmILgWYPCj112dLtooA/ZbJkRJ9Fesx18bvylNhngOlsk3rUvOtgX5lPqYBYN0W+yMq2PWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDVFoaxAdZZKimhYNQK5WwzmRGrnH0ovTie2Ntpfs74=;
 b=gwAjVFJwlPWLMCImK8r2ldqdPpYWXp1cuK5Ln/u02a+SG5AJQaNCa/uFQWJDCDYqR9AlU3CH3aibpvSEEFrZBllk26DeKALaHUiNMM9K0YvlzMaaPeT0g19m/AGkPXllQFnVJOK4bZxFEa6UQDEtoWVnQHIyQeacP0K9HTuL/bs=
Received: from TYCP286CA0356.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:7c::8) by
 TY3PR01MB11672.jpnprd01.prod.outlook.com (2603:1096:400:370::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:56:00 +0000
Received: from TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c:cafe::6) by TYCP286CA0356.outlook.office365.com
 (2603:1096:405:7c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Thu, 10
 Sep 2026 08:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005621.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:55:59 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 49943300037A;
	Thu, 10 Sep 2026 17:55:55 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] iio: adc: rzt2h: claim direct mode on single reads
Date: Thu, 10 Sep 2026 11:54:25 +0300
Message-ID: <20260910085430.3173166-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005621:EE_|TY3PR01MB11672:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 48cd436a-b903-470c-8bab-08df0f1955aa
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|10067099003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	Ra1NQYOtPrRKhZtSyAgoGxWXjxQQMwQIcEFyTrwH20dukFY39EK+gDN7hubrXthTp0kwVFrOU2cBA5NERqQLdXAIbHljB6AwiEu9sdRWUKEZisnTix4wn7WAANyLyZMQ6rWfwBBF1zxjyG+iDD4Ow2dAI3nAPRMF7V2DLXbd6ImZw4OpN8ZwzjXY8thQaYhYGp5At9j1oREVsWYo/sb1R6AOOmeB3NiuuFC5h1TPOvPQrala3oUZljdyusLM32bxDX3xogeoc6aobnImsz4TEE7+3lx8bgzQoxZt0XFtqCe7wEh6hJa/RZILzQBt/lJxwiWSPkZrBcl/t3bv7UpX9jS+Vs8BAM5obo+kLonLyw5tU5DqR6f3qMxTCGym4QzAw0MJtenQ56UgO1O/JXCBvwBYC3D8lRGPGcMASDoeMgn2Elk7XYrFlbt9BsnKbJVWhAz7g/ny2PhqSHLFSI8AVTH0eXq327ogWySG/smwcQDDjWSE8euyWkKcsYjJpyEipdqyVgfyEj4JHCY2c3vJ19aeX2Eak78sB3lOqMJBLA68cffPN/e2lPQyy0+waKxYgQjWvpSdMVlDvxQgkf52EVKoA1t+8GvM4YfTrZMV/xTPuVw0dpS5fAI5B/4KdKHgKyNcgVM3sNQEBBvFFkmGYtuNfETZVGmK+BGeY1qjN3QMxSKTWGGAE3o1nUBz5WAdA2lRkaOZyFUnUlLL3Da4NOnFniCFtCPgPkbt/1jzrN9OpcyfxhWJMvl5U+9o9ikR
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5kwnWdK/buZ++7taFFAyf5OZZUJpOtgpMWltwMNgP+u+Y3fI350as8oQn6HgMygvwuCSpClfovgtjnxg6ga8V2HEJh4hWQsIqTHoEAwg5w5DBWcdHDgZty3D/31vdqfsFopoGYJTJZTqUDysYeq6e5kwxzCZ7Lv8fTmNlah2R/Tvs/+3ES09PdHVsDhfUkfe46lN14rZ9uFdqPZCK5y92r+aOmaaLQG7xUOTeq5H+n7nIigVXnA2Hk84Pk5npp12JJ8Qljy16abiV2y2KKEcDvGLWFuRaHnTYZSDXiaxH1jBKH+5sAB6yiDLEqMNOZp/CrqwqZW0/QT4Mak/EUpjUfkDGkcD8YwbzF96svoLpiRNw51oJPjX7z+VeCtWQeIVDUr6p22vG6qsaUFLYuILp7MAC+WGbO7mJ4k+mzJWKerRIDUpMyus4HkDIDcI8Dro
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:55:59.5241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cd436a-b903-470c-8bab-08df0f1955aa
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11672

Claim direct mode around the single read to prevent it from conflicting
with an ongoing buffered read.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/iio/adc/rzt2h_adc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 995308a419f1..95bcebdc02cb 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -158,8 +158,13 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 	struct rzt2h_adc *adc = iio_priv(indio_dev);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
 		return rzt2h_adc_read_single(adc, chan->channel, val);
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1800;
 		*val2 = 12;
-- 
2.55.0
