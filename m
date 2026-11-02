Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793622093;
	b=cD16M0pZPVmArJmK+XHDqsP5hJQdMSO+04CUzdwOuOfiU5tv8ga/df6O2MaGav1u1DvY
	 1rYQq6MuDBU8y3yk0E1SKgxrgmGnrNklIHvQo+FZ0OeOAa8hMui1mi7P7gf6PcARRaTRF
	 dEc8LLpvck8i6ZtKuchLH7dBQms1xce93qwfE7Mzhyoj3td7ha8za5uIXLmo4crPwP5p/
	 G5tkhaBh6uU3Y5lAxpVFMLrDzTkjc4Oh4C6tL6RlQ0xW1z73BRbmSn5CgLg98uTvYJMHi
	 zx4WExljx+0OxolhQCKVy4nmAe1YE6M7laZUNf7NLLMvtXBHbIBF1FnvcScFCxxWlbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622093;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7jY6yOIoDb2s40FcwgAUYkH4icXO6Xbv/NyPwxlalWc=;
	b=DhDTRsrMvVphFXtlvpokgzPHxkXerlaTZaipB628beV2jN1/8OeoL8ydBLKNmxi+1N8s
	 sesHoqnVLGpTfBYR6FS3HjU/CBGwjBJs2kueO/SUOR2qAqSV7WvVhRbKfgqD0BStmzsM+
	 sy/R04cEFq16pL8TTRvA7zXy8WpohwFplA920tPi+jsjrrKAqjBd56ku0LBqnA84v594y
	 eXtqVWzeCaCRClTztWcCOrEx4SYbdwyNgbv+Y4S10hA6E3iQ2TbBjB/H2utRz3Pd5j/eN
	 0DF0fF08yC+Gs/24EE7yzhNQ+5Iw3pyUjoKIEOe1uDbXrRL/zhbJoFpgRUWZ4rQIn2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EzeunGqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.1
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56826606A32F;
	Mon,  2 Nov 2026 12:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56826606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EzeunGqW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L46w++12JV8S1hE/cMtrbccBxDFCuLEszbTR99NXkHSqnUP0JIvdeULvADthUoFVzuhypVNriT5M+up6eePe1KwTGn34H4YQ5YkaT73HedYu5u5lVhalRUTH0IoO31leMjaQjiEcQnoRfmxG6xB+E/e6LvrjKfcazfT6nNpDwDYK9NchAmVnYKdRQjMUbdkTdf8VLa/NpeGHqEGp8UWX7uWNXKkaqjnQrtVuAzlN+nURPHzD5HMzd6EFBc11ef+71IUt9amEkHsinkypiDSSESO+CC2brXR57/+k5psJKYXecL/V4jJ3SuOq2nwrTfs/X7/RMNa4N+wM7urA+d8MwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jY6yOIoDb2s40FcwgAUYkH4icXO6Xbv/NyPwxlalWc=;
 b=ZNO7a6ojC3bIMVBERtC72GEwqR5SP+3yQ4REWFHE/RczwrBjm4jDebKgJP0+cpv4iYlk4TP94D2cdQHrKG7pAFoCmWM5UnWgg7euwbU64xu1+yfhCwT1sOHMBjJlbxcAoqjZHQ0rIX6WaXh0TNji5K5L92Imz8Nwlbqic+50lrLX3XMSV8J/w3gVhRzvTBfUHXPIrssv9L0ZkzRNUfyDAcIRf31RqHvCgOqKiTC9a9LKKXQ6DqJXTltq9fiVK5EtHVefOO+EpU9mPBfdal20sojI6DqZgzKEOzq2gNxkd6ly5R8VZTQSk29Fg2FkffhmbciJabE+yXRvduqJ4NqCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jY6yOIoDb2s40FcwgAUYkH4icXO6Xbv/NyPwxlalWc=;
 b=EzeunGqWdUHtfRN4ibAhlnmYMLwnwzehU9atgTFYtRoF6RXywFnySQ96DuB68iTF+ANADJ7j79v15Jb1ZGQhJZKnUi32go5plqDiMIsGGWs98SoPeV2R9SRaheOHYdkE5eRarOBLRzU4DqJnHZ/Sbno2jc54/Ag/YMCt7t29ads=
Received: from BN9PR03CA0652.namprd03.prod.outlook.com (2603:10b6:408:13b::27)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:21:29 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::35) by BN9PR03CA0652.outlook.office365.com
 (2603:10b6:408:13b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:21:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 12:21:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 06:21:28 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 06:21:28 -0600
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 2 Nov 2026 06:21:24 -0600
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<amitrkcian2002@gmail.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>
Subject: [PATCH 2/6] iio: adc: versal-sysmon: validate temperature hysteresis
Date: Mon, 2 Nov 2026 17:51:08 +0530
Message-ID: <20261102122112.1723130-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b77ce0b-02bf-459c-95ac-08df38dbd27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|11063799006|56012099006|261009223027099003|261009221227099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HQpisMmT7tzRYz97NygPy84aItJtj6FefAoPUNlwRb6ZChZtaATlbl1SRnjPNCdMGNZzBWu+pPYAEsSy7uCy+TrEDILfm+IrsrMDt4kyCmk0892mLbOJ2pvhR4oCRiSafFRhUDxYikOAUGDsB6unSSBTBZsQg5htYVdOct6jCFohM0as/Y4X8bwKSsy+hnI3XNwRnvNgsK3E7fX/5LtUErFCgofDuCLP/csI7fQko0IStgoxfgb7RlmYZuSn0Mjtqpdn8a5+gCGzFrTBw7f2rO50PVZ6Clvi8FeifDucaKhBAaZv/H3r28+5zJVEo2+1VyCx39uc4DmbgcpdHqSuLg+QIgOfj+K9U+pcR8twhV+NGURrWHE2KAvOuUfvHvKHmgh1btENvfi7JbIgC60RJAtmjQSHviDo/JrrDclbOYrfGEOTs0skb081dPZro4okRQDx6xxOPUOaxWwz3uqMltAwVgOf+Iu6llxiRu/kO9yClEURChWfYY0VFRyYUtvjyRnDfU3dybWAR4iV0vx3X2fXs7NqJVHF08KCK3rBF0tC3l3NYtNJkCHxJfHtXFeK0u4cgS2p+2Hibjl+tltb9Kf6Z2V1ocLCrrNaMl1TjdKmjeuH+ua6cE81nRx+guZmBA9fCaRwLesqmo4UOftbNCCIRaKzn7Vl3C9l7Y6v1zRNMSr1EHDN1KWcGPwdRAHgnLWe4aBEqDCoXbWJVZMRiQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jlsUxtvmGetFUXbRWhmzQnBGsCWiCc2Doa40ckW3YCaP3tSIAMhXjePAkGVx2DZkJBY/7sNoYbU1p2ddK1M12UIOL4pvqiJMP7E00N+XuiBjhIGUqIM324/isAaBjylIxz17FRbAQPPYOpeABJF+3ChFER9rk1gQzKchpIyhMu9S6bLh+azlYopiqsJuDBUdco9aEv00Ih31spXb5qpcuIH7BRaG5jEuWpnQ7QHCd9FfH1ecIb+MYLXD/afsosL3QRuy/Ocl495Xck+sJIYvWYlXVValeMgwZipp8cN9ZD7mIND5XHJnwfqwlBhkA2x1yHjN8dwqY5ud6jAoqYeEqTkkyeGiYjsokdr9b/KcSgWKc6A7CBKWJXIz7p0VP53FquRUhCV1UM0HK4V7WDH10WjX1ya4dN0p98PbaDSy2R5JiRzd0b0tnU6tgi8GvfAE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:21:28.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b77ce0b-02bf-459c-95ac-08df38dbd27c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621

The hysteresis written through sysfs is only checked for being negative.
A large value makes upper_mc - hysteresis in sysmon_update_temp_lower()
overflow before it is clamped. Reject values above the full Q8.7 span of
511992 millicelsius, and name the Q8.7 temperature limits so that the
span and the existing range checks share one definition.

The cached hysteresis is seeded at probe from the threshold registers
without checking that the lower threshold is not above the upper one.
Treat that case as zero hysteresis, as negative values are rejected on
the write path.

Fixes: c7f7eb10638f ("iio: adc: versal-sysmon: add threshold event support")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/iio/adc/versal-sysmon-core.c | 10 +++++-----
 drivers/iio/adc/versal-sysmon.h      |  4 ++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 6b9a58e19831..6595d07038c1 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -352,7 +352,8 @@ static int sysmon_update_temp_lower(struct sysmon *sysmon)
 		return ret;
 
 	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
-	lower_mc = clamp(upper_mc - sysmon->temp_hysteresis, -256000, 255992);
+	lower_mc = clamp(upper_mc - sysmon->temp_hysteresis,
+			 SYSMON_TEMP_MIN_MC, SYSMON_TEMP_MAX_MC);
 	sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
 
 	return regmap_write(sysmon->regmap, SYSMON_TEMP_TH_LOW, raw_val);
@@ -429,8 +430,7 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
 	case IIO_TEMP:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			/* Q8.7 signed range: -256000 to +255992 mC */
-			if (val < -256000 || val > 255992)
+			if (val < SYSMON_TEMP_MIN_MC || val > SYSMON_TEMP_MAX_MC)
 				return -EINVAL;
 
 			sysmon_millicelsius_to_q8p7(&raw_val, val);
@@ -443,7 +443,7 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
 			return sysmon_update_temp_lower(sysmon);
 
 		case IIO_EV_INFO_HYSTERESIS:
-			if (val < 0)
+			if (val < 0 || val > SYSMON_TEMP_MAX_MC - SYSMON_TEMP_MIN_MC)
 				return -EINVAL;
 
 			sysmon->temp_hysteresis = val;
@@ -838,7 +838,7 @@ static int sysmon_init_hysteresis(struct sysmon *sysmon, int *hysteresis)
 
 	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
 	sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
-	*hysteresis = upper_mc - lower_mc;
+	*hysteresis = max(upper_mc - lower_mc, 0);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index 701ef9b56263..a1ac3289719c 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -75,6 +75,10 @@ struct regmap;
 #define SYSMON_FRACTIONAL_SHIFT		7U
 #define SYSMON_SUPPLY_MANTISSA_BITS	16
 
+/* Q8.7 signed temperature range in millicelsius */
+#define SYSMON_TEMP_MIN_MC		-256000
+#define SYSMON_TEMP_MAX_MC		255992
+
 /* Bits per alarm register */
 #define SYSMON_ALARM_BITS_PER_REG	32
 
-- 
2.34.1

