Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022080.outbound.protection.outlook.com [40.107.75.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B21FA272;
	Mon, 23 Mar 2026 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229711; cv=fail; b=uPalQKH2HLToICUkBNfLMeBn6HF1RHaqud3ayuFLW6ms7XoHwL4qt/7PQVlFHR31kTVYCUEeDnkrgHt5AOZl8GSVi4niGLIo8UfwEIPpC4j6Ubo9Ofoio3le05B4ZFXfE1GqADBazhqE6yBaWqqxmod7+mmnd63xEHoTKvEsLiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229711; c=relaxed/simple;
	bh=UpSbnHiWth6F34uWtlroDOPdl0dwej1rds+oiJi4OgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGldYwAk1ZCpm/2J78IgL8gXiDBR8zmA/DEG2xL+hnGmA4EL1oT8+AtXM74wtv5XVDqOaSTHhKaci30MeL+P4xBcq46j5ymCHLMg2d3jRhC0LA3ETN5nqywy+MEdgNUEnNhUQkOoig75CS3XSy8KG9eXKljt7gH+JZ636N+898g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=40.107.75.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyM5ebqHmu+mjVcMxWxbKai8WvdV0iJGxaozXwdSzk9oYe5oH/MoK8yy15OYEw09jhP+2PUF8SshZXaqS29qUHvqD01QEJpwJG7ciqoIjf98Q5PK+hnOqz0s0MWS4EVgp7RvklvqksGroUjO0AHCJFhdL7V98HQKDdbcX0rlRQ1AmMnItEHktPqlHWBKcNIuKp+03T3epSi3FoFhSR2iYszXjkPx7C+r373UGUgTMC5K0BKBrxwH7Vpb9hfDfm8OGjFhGqn7fImXlcBVxUaQIoejDZjV+qs0F8G+0z9iTwBDVjX+F3RGiE4o6rnLpPfMlLIUNksICVtRkBhUvyGZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev6BjyMHQ+Spg8JGgQiSSbgoj6dStlvXRI8YWEH59sg=;
 b=HkSoUh3r0HchhG9saPGcsoRi+9DbwoH6uxccmEFj5s9bXbhYTjQqDMwMbvbpLiojpaSshIJWMBvEReiBiax/UgRqw6jMqDOmuKSzESfJfS040TV7NqXk7aeiPMTtdhfvbQZV2T6X6P3r6Vtr1WhemwXfXcdbMKnTwWWcb3Ch+ZhPYkWxXq3+liPXChOp60N0kiMxTm4loQNVxFZAshXBUR+chFlBVCxi2noOIzM+3PV4xVPBU+9jiDidCLuCpgpC2GX18a16QskEBbWRCveVDIRqm2FB/uTti4nHMS9OsNweOGvooh8RM/xYge7w3p4jCHxbzPYdkL4/oDtIrvqzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by KL1PR03MB8142.apcprd03.prod.outlook.com (2603:1096:820:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.30; Mon, 23 Mar
 2026 01:35:07 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:35:07 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v2 4/4] arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s: add Function key support
Date: Mon, 23 Mar 2026 09:34:08 +0800
Message-Id: <20260323013408.429701-5-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323013408.429701-1-nick@khadas.com>
References: <20260323013408.429701-1-nick@khadas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|KL1PR03MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd2033c-d1d4-4ff1-d606-08de887c6a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ba6KnwIVBy007EPYsLH/1gDX0dMv0dG0Wc8VmqPRVm3Fx16OxKhkVWUDVGV+S91iyL85WZ0Dp/bOlMUgQqbkoxHFup/1nc9fU4Dw3DWSfcS8fPfipnUXU8qmJoq5+bmUbImmG/5bDMpeDxZbfpEV9V5IXZUoDyQPXL/YJrXIEn9J2hI6gcQEkGLBfhwnf5bOylObCMv13tyWlEwYUjKo2le2DmvAcws9sqvd0B9MySQe9nexu/0D/x/LuoS/aRTE9lAbGmdM4eH9zAbuVi239VpZmsjQA4VfhEpyg79z0kvoO77fRhaKJeNITg1s46LZ4e/ovE8Xc1ARPQ8fqRaLtiz6LKhRDvKRu1v2OunK6m84QwqdX+8LKPuSYHCJfuRpfIkUgQP3NtK1R+FkbdyynGlHjclce5tJcpaSArzC+sEL2U8ytYk7bKFYHtbNaJhdiezv+oV4JkTxXxZg+HasMLmyC6icENf152xEZk3FC22kVhxgzC1EPE5o3NvhQxgqz8JNbE2ccKogzZOsvMbUBX+wICw9mtu/Att+ereWKoPlVU904B8WrMlm+n37gzEMLpxRDeXyvWxQbrk25ZQ9DFUyDdyvaS58jWcrlIGB+5YldlRkA8Kz4KjAoTiVLDS8++9RGsoo5T7LckWrOQPy++Nz9y8XHIUpe/s0wdIO315txzQcOLwWw8udh+lggTJM+L3ocnoJupv6s71w8U/B9mfxNDKkeKPO6e5r+3CfqSMvndYFH6ZaCbebNSzG4A906acwo0kiuRC+2o1/6z32scxtjIPVa+6S3keWipccX1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ou0iiGHkWvOsyApWsDzL+sfhB5SbAvhxV4DBMb1cvRgHNqkSYGMs4GIca2r8?=
 =?us-ascii?Q?7XDMKdczlvgkdzGx4PMPzpNFCuu9EobVQZKAJvMIgtqQ4maufjeZnMchzt+0?=
 =?us-ascii?Q?7hT2kRK8cm9Ojkk3pmDXI+aa3d03t4i+9hi3TUP3xUE6DozG3u8YABt3IBaZ?=
 =?us-ascii?Q?yVC18FBbFfM04kRDBOqRJWvLexKnoxjl2XyZumWsh/dXZhjfcu8bUwm2yRDW?=
 =?us-ascii?Q?sv40cxlqZ4ZtyofmiQjKrSTO9KdVKmVv+xm1fLHixS0lV5949DdogOhvKnut?=
 =?us-ascii?Q?3kXqMLKnLCQjD/s+oyYJiiDzmY3gIQncqhoPbsk1oVf4RSAk0q6Wa77TdqjM?=
 =?us-ascii?Q?EX29CUJDR5p4GWaw1p7bm12G+Nx6CbmRVUE2YkJeIevwJfP1m8Avw5OcsNwj?=
 =?us-ascii?Q?HJYgVf4p8iu8v/7Ux02/sO+jHmsUUh68+gcxeylTiWntQWxxOUONkvMjrF/D?=
 =?us-ascii?Q?8+4R8/lOqHPivmIfdFleULxWd+LgHviueY+Cav4BzfOgkB3wg4/tpEdXFpMg?=
 =?us-ascii?Q?Zz99gA9geZ6kjsc3W6pMtxyrAp5HsDZgNR3AgAJluq1jRhB6MjrLlzn9D2zB?=
 =?us-ascii?Q?wb5Na14kVDrNpn/B18pS3kh9Y83Of3Jz2rRPsPJAI9IjnVpi4LCO7MRJdV93?=
 =?us-ascii?Q?bnmu2j4gYtd1mQY+Dlk579lRWZuC5WCvQvHpxJaLX/SgF/iziJdsyWslbtz9?=
 =?us-ascii?Q?BH80ZG1qu9WcfaXXLZXZzk7YxKTDzs7y2/+e9ommvwWcxhaAT1EgTIK8Pdrz?=
 =?us-ascii?Q?/6hsGVUR8XZURHTfowLk4ATs/0PiZqFAz2vmk5/iDQAvekqmarR24Zj7zS1m?=
 =?us-ascii?Q?cayWIIEfPSCcWKB7TdxP1abn6LknOU5TToZycpqBnER9RKoAGw/q5fhFBobs?=
 =?us-ascii?Q?CYfvCvOG4KNx2cFSyPshDu2SCOUTKOUUrTGZytwbL1u8XMdRs/ZeTdBTjVRc?=
 =?us-ascii?Q?fDkcP0snXIAr5BJIKNj3o4Tvb8dLQ7dV8BuzVb+YuhefLxBa5IEyuzKuRTYx?=
 =?us-ascii?Q?IhPPT7FezKLmYMlhJsUhJllF7UurftCHV+fJJeVeAoJOjYSLGDdLo/BSmkgN?=
 =?us-ascii?Q?MKNIkXgsNTmgyAAO4Y/ilse0/AuCWv3x6BNgFQwoVd5Ss4NEsWwiK6I7qSKX?=
 =?us-ascii?Q?ixMlfpIlMrSszNc2HBt/zjS8mP5qimnkrKO8KtxINnhD5LLBO7LLrot8DWqa?=
 =?us-ascii?Q?SAbfngV6TjJR+mM4Q1g11YkC+1itcu8M75RKW2UgKsos76+qPEYFJDaxql/L?=
 =?us-ascii?Q?+zJZZjf7W9Td7ynRf3y0CTiipvBiQFCDOtQ3MNuKbl4WVFk8LfjaWVeoOBRW?=
 =?us-ascii?Q?I8g+7uNUxvgVDp2QYn9ipm+UiHmBd3KlGXIAlfg4nEXf64ddUCwm5Tua0FG5?=
 =?us-ascii?Q?H6aRJmf2puMgljSuovcDVVa8Deu2YK4bQ2/Ll48vqGrKjOc0yVl7C4YbYESz?=
 =?us-ascii?Q?+P89BgickAhXFOori2EloX6QKxwd+XRK4jHeYi/46KzZ/0E2PiPcjPckzoTW?=
 =?us-ascii?Q?+bRKQWBogpwRsGBFxUvs7IJFBbgwzfS0QQU+95RVFl+jUwSQeNNy2WmGZDgP?=
 =?us-ascii?Q?qh3oOh8dGQ5i+qWkguv2XhF1ceNDw+VcBHFwIXxBPoLB1Xwsg3Z382lQcjxD?=
 =?us-ascii?Q?cn43wNA3dtzAS6lo5TdR8PZ2mSI3kiPORrji35VanUEhyeKrUoUE3ptJoPIe?=
 =?us-ascii?Q?pw6CXOYNvYDCKr5N/Rrb6Dz15P7M+HnnLe3UQG+sYstf22g2?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd2033c-d1d4-4ff1-d606-08de887c6a14
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:35:07.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j74KELBHRvcY8ELV1u34UdhQs532O41Ic2gV0XslU5ZUk0JeCMQVr66m6EWxUqGh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8142

Enable the SARADC controller and add the adc-keys node to support
the Function key found on the Khadas VIM1S board.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Nick Xie <nick@khadas.com>
---
 .../amlogic/meson-s4-s905y4-khadas-vim1s.dts  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts
index 664d64a267f2d..792ab45c4c944 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts
@@ -40,6 +40,20 @@ secmon_reserved: secmon@5000000 {
 		};
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+		poll-interval = <100>;
+
+		button-function {
+			label = "Function";
+			linux,code = <KEY_FN>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio GPIOB_9 GPIO_ACTIVE_LOW>;
@@ -278,6 +292,11 @@ brcmf: wifi@1 {
 	};
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao1v8>;
+};
+
 &spicc0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1

