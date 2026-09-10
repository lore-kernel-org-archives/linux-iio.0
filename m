Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011017.outbound.protection.outlook.com [40.107.74.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080F3AFD1B;
	Thu, 10 Sep 2026 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030552; cv=fail; b=liXzN4lPc39RzMrGBRWCpXSlopqclvaXXxQo5d4Eq6aXnDTSZJk0AUnEN4K1o+F6Z6c+igk3pnlgQLidF75Fm1QeO/2yR2bbNk1VoOwMpnGuRa0zqImfwoHrURUJxtMYxXoHJ6ZsgrjepMkEIp6922rO7IfOuHJ7Oi/yNgyF950=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030552; c=relaxed/simple;
	bh=6HlknFV9/eZ89aaKxVP/Mevlf71JiR+1yq1jXaM11F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pub+f55JK/YXWFfz67zpeH7bcBdAzVxRg+MVYUtDx1i10YgdiruOuvRsMjDgSQCHlM7f8AyzWmKuwiJGUZcEG/mzlA6YtjLZv7VWVi1KjU9uvxVsnSKBUO+ptPPaUQ92Nd/LOXHtp3j4aP+oqd8rrDLJbZybhcuIFFIdV8E2ijE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=l6QtrFeg; arc=fail smtp.client-ip=40.107.74.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="l6QtrFeg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wR+vCmGalRoBza4T70kt6o8e77GzDa/pIz+XHS5t/W9NpcV+7j1RdWEYJfwcRA4Z5GF4UdvEUfHmWVIcoa4Ez2fZIQXPAQOL/stq5o5IeaP6r5cwIf1Vruf267RcDA6JFpae7jq1SiwJqGDL/9qZyqIoUzK+mi1QSvblkRZZxhWMLQwnbzIpp4W038R7AtJsD54kflmp5BdQ6u68RXdfIoP5yDCMalttYWq9paio79da79WHQXoYHbicHSkwXb1ro6O68i9zLXaswT+l4N/2rmHElb+wA6Nh1LF1gwwaSGJRnZDlbLnprFadJaawJGBzXs3gTEeB/RPgVCR4COyYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d+5E091pJ5f0JWSgbdimVAAKqhW8k9nQC9Tw/rEa2k=;
 b=VzYJ/3k3J+nX3RUoEXz9NJXP9PrwHfJyBLNxKaX1TgmllUPuVMzAMzyFz9EShozXOmWvuFprNHtMxtMMYhuiYItbrvZ5Yu+JQBGHmXWn0x1qONMuxfW2aGuXIWdKeVn4lBi3r2MgQx78IUEPcdS+zXdHXQFZXXuGZl4X4Hln/hnwGAKI+/sXI/UGTiwfFmnPy8cFnj7M9UPbg6FGdSucDj7/MQgQbFHcbzv4Z/X7Bpw7rDBaQ6RAg9b6d7Sfqa4P+TUvXn1DSPl/8RuY/Bgn3wbj+RptGZ4uLq9L75SG5bxKMrOzxjFhYlIOQikYvzEHVZaK7h1IWpIK3JZDmXoZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d+5E091pJ5f0JWSgbdimVAAKqhW8k9nQC9Tw/rEa2k=;
 b=l6QtrFegiHB/c90n3POusoHTMNpFuj1EUTE/t6kihRtodLE/zYQK/V4C19wAbCFcofpejc7laK4RCP8A5+Xszyl1+8F9Fzfhwcrh2r9mpGu/8f/G09RkRGnHsv6PLxsCyOJwuncoLBF6U9t7KVDUgHg94WARk4A09aUUFpM5oLM=
Received: from TY4P286CA0030.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2b2::8)
 by TYVPR01MB11170.jpnprd01.prod.outlook.com (2603:1096:400:369::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:55:44 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2:cafe::5b) by TY4P286CA0030.outlook.office365.com
 (2603:1096:405:2b2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 08:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:55:43 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 77C293000203;
	Thu, 10 Sep 2026 17:55:39 +0900 (JST)
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
Subject: [PATCH v2 1/9] iio: adc: rzt2h: remove unused struct rzt2h_adc::max_channels
Date: Thu, 10 Sep 2026 11:54:22 +0300
Message-ID: <20260910085430.3173166-2-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYVPR01MB11170:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 632a9866-4c09-4be1-459a-08df0f194c5a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|11063799006|921020|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xHx2gs3xOlI+UGp/5PXJi3bDmmObDzwpBQDp1us4ae6UBJgxUtqYV6wZaQKrTR4cgF37TRGIRfmajlmzuu2qajd2mM9SE6+Z8NqHNPgs+Ap9AZIW7J7SDIWlUbXGea776ZFfVVPW1grYsPG0Ujs0770bia+79zsEotMQeywU/6tU1ihXsQPqX41dMPFk2bCppPohHQw/s9nMIoZWGHNCr7qjrKQsf02cBtDIqLeJpZwvqKe+oFebDR9x5Nu84RFrvfYX0ganHRiRVb1QUcbmB7SZQ+cX3yU5oq3IrLEOxLXnvkjABh1/w8DLWFNLvWN0/A1RBsV4ilZkLKyx8CkPjJ0Nifg1qymmM3umADs0Ex3XxkZ6reifDl4WlPjxW8jNTgjHykv5rjvpzs1V41NvxGijDSnYpHhg2R3RBfvCI4etn7hyx+bm7ccWOFV1ouqKgDwRF1kjV4OvfguBaciC4pzCluRx85XfAaF4dxpTLcM9cTUe5XR7WGmzKRZNPQZIgJ5vjqxZefU+aazH244h2maD8RfQJhTWW3puD/HeKtkLCc1wbDqjMKcAUlbOm/uZ4hxRS/LBfb9T+O+rc5H7f1gH/2pS8p36dTTMLOlXoWCOgjp1q2zFQ9+Va0X8o67O8+jwQD0j1ASlf4+FMZtJIBB6b6diqKexVWVfFBPWbx3H1RTTCLZfGdnccRx34s3eu18jRADRZPDiMHvAWMHQKo0qZGEATpzmY+WeHXH7GXe0iRAUcNtTbQHA0JqndBS/
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(11063799006)(921020)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/I5JO2Mo6Wz+s25p9ckVBoKKrb2wfQmadAL7FQ0sElJsE9GLeDLslyolrFdfzX5GDK1KDDlyjXQgh6J4PEggXqa1A5WDHAOXvQ6oPUueQeWqYbJRqbRKkrqwKeyiBmGlK3d8rEUM8XDeaHlbm1W1jJ3EXQBr3fW8NDf5Oc8/o56KIhX40YiSt/WnDoppugOmF6wb1FYyegaZcdbWiTbBbTR4062UQRjXLtZ8PM3nxYyWPDvJYMYkybIk/7UKASREj5ryKPwqlZCOt/2koTwacq9tPnB7eMzyGeGa8E/FJCRt7rNF0hRIf4Bxp8MxBKBIgXoEyrH6wwBrFqaFMJp6CTxYps9+nuRTb4c7mc/Ww7lO8gb1C6aXkXaTy1CRQbozGFufm2cf9KuGlgbylavNmyKS8RGrGQAIYoF9vRqtacRjXd9g9601vv8SI3VQBD1M
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:55:43.8976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 632a9866-4c09-4be1-459a-08df0f194c5a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11170

struct rzt2h_adc::max_channels is unused, and is probably a leftover
of the devm_iio_adc_device_alloc_chaninfo_se() conversion done after the
initial submission. Remove it and the logic used to set it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/iio/adc/rzt2h_adc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 4e0eb02d3d14..42ff6bf2ab08 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -42,7 +42,6 @@ struct rzt2h_adc {
 
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
-	unsigned int max_channels;
 };
 
 static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int conversion_type)
@@ -190,7 +189,6 @@ static const struct iio_chan_spec rzt2h_adc_chan_template = {
 static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
 {
 	struct iio_chan_spec *chan_array;
-	unsigned int i;
 	int ret;
 
 	ret = devm_iio_adc_device_alloc_chaninfo_se(adc->dev,
@@ -203,10 +201,6 @@ static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
 	adc->num_channels = ret;
 	adc->channels = chan_array;
 
-	for (i = 0; i < adc->num_channels; i++)
-		if (chan_array[i].channel + 1 > adc->max_channels)
-			adc->max_channels = chan_array[i].channel + 1;
-
 	return 0;
 }
 
-- 
2.55.0
