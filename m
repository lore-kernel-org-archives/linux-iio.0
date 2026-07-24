Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBE3033E6;
	Fri, 24 Jul 2026 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862412; cv=fail; b=egopRpI3iMf+TMhSVo6MYeUoflzEub8RuJauUy4Nz5ZGD74P8FqclU7p2/yKXui4ujkcuuC8AcdT3YmYiS5XK8SaAiHy7x6bFD21cGxnZiLCnpirCP3ju52Pwu2UEOYl3hwJG7KpD2WP7huj7dB/TheYXn5b2hjETD8g813rPwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862412; c=relaxed/simple;
	bh=SDnwLFzYA0t8awtE4lA0kD4FGDfr1jqXx4vYhRBLwPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BodJvYrwnb8A9PaDiiaJUAs3Y5PLSAiovKNfCHJzZ3hqASO2EPAJsGDhrSO2W7JrzQsZSk/pSydkc0DwtHeYdaPk6dPPJUImvmOPeVY5/i4u1cQ98em+kdnSA1a0SquMROoV1jmwEy4xJXlB2uwueAOdwfyQfhuKVDPvjFBkTF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=k076wm9i; arc=fail smtp.client-ip=40.107.44.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="k076wm9i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEue6o9eY8P7yjLQ7BfZNtbmPcVrBQYRNgK1juUjezuHDCPrzc5VeqyvOz5pun9YQkwA5gUYKQoG28UYM8QLrTUTKh4uUNRbbNxRH25RK99nYtZ/VM2rJFM9MqhTnwTK4wvBhGqXksMjAmxplhdObdOGWNkxUYGf0esY9mzZRaaJ0ejmpzbPwWuGDtKnbn/V+jSldPtLXlQcGU7SCUGIYMDOsS7aESm2RL6bJ0jKiFy8oFuuSXfSzuI8/6lnDxfQzHyup0JkjyC2bPVuqPaMfScNNCYWcbV9EN8Wd+L2nUgZ5WAx79NMpdmxtiO8Q939lnHfC1XEheIiC9nxAb7Sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95m7U7AEew4vUQ/bX4P+maUEN4/RODxRrczg//Q1AUc=;
 b=eIYt/W36y/Zbe4Q/W3F77J3Zc/he9N8DoAt1iBunaY3Na9nBwKHhEUcyf73FtZ6hoCKOJ/ob/HUvsoiEgPM64xQHZtbZqoWX943NRDZw0HAfkzQ5GWGOuYrtE+RocGOCYafkqFnS6zKNAdUxp7Y4jgljp3v5HEg4fj/qzMeJJMjk0q0iZpCxwzpfJp3PK1QGRcpfVuToCm3RYtte6eHHuJYSOS1CUyn9JBUDgCJgl6yuF5IVTezxnPWHNYG9CrkIXAmlAKN85rA7cubgGPnyGOpsVm+Myj1MiUm7uHLx5gAxwVh6CB3KO80tzMVSVwE33g/fN3YjSms4ON+H1uVx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95m7U7AEew4vUQ/bX4P+maUEN4/RODxRrczg//Q1AUc=;
 b=k076wm9iH8LVplzc6gqdPkd+CYT/AodtErkNbiiCku/GmahpCKYwV0+7yUDqnExNo5hyGJp/flAbqEgaWxny8Qd3p+YnNUHg3sf8zqtJvcQvb/CuD/xego2+yVGl+mIiXOhR+5taBy7e+gow1v6qyTsdoWXawcTy5pNSKAFG3cW8imp5bIbpNCx9YEfJ8j5NZCZtuzQCc1+U9CC8BubHTSAaufDGAWVBy9TiDB88KWrmaZDzfZeeBwhIa0IVZPdG+XixvQqXHCtIjwUa2XHbhKfRTYvXZzZnJt1XPbr66ncDnJzol88KpBZx5SZYFD3vbENKwadSDPziPqwD665Axg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8717.apcprd06.prod.outlook.com (2603:1096:405:3d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:06:48 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org (open list:TI HDC302X HUMIDITY DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 07/13] iio: humidity: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:42 +0800
Message-Id: <20260724030524.607185-8-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030524.607185-1-panchuang@vivo.com>
References: <20260724030524.607185-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYNPR06MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 5657556c-5c56-4dfd-26f8-08dee93099c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	NuyUEFBjdsyCo6Dudzt2th1x8e+GTsEvliPkv5/9ICt9Pij7CxOkah+D9bsOBFw3/nv75RqEw2mGN4Hnpo0bhpjfCTV2CnA2ly+DORz9ZWGl36rl6yYorFSLDH8ur4NWKhKebNQY4vZ+vp8yVCYvaqhwbtH9Aekp3kVjP/uG3RZXOGWWLvK2zdwMjcmtmF6pNFhQhsLlzDEg5O6q+fHnjgz+EHnNhPLUIy497BDhPtJqz11FnfesqZ0FAW+GaPO5W/YuOHsUUlRRpul1NQMt11M7i5WhCAfJL4+7H0IkVIwxs2/9SS23XupTfhROD80KbN8BcKmJXTlCpkzG2VAHlzb4D1Lp9E5/3qAptxjLTugf6qxKOUnO6Iktj4MaX2FWaJ5MJRcNKRVqCrm7z0Y5Xu1lWUvAti2tU4HrsFsjUbteLh0xBWgb8DqAqmjLUB2s8y37GjoJf35WneJQMBM/M0M0IMGWXptjjUOpcDYZaKl5ivGEhctl1wj53gj90u0GMFjAYE+hNOOse/rG4w8LpTCJxgk90h5/GER3zXsawtTm2uBHpAizX9F/z3pw5+VutxK4Wa9dEXHn05A5lOEkKCgYWQhrF+3aK6EP2qOY7G6yPpI945cXA+wK579iAq00O6CmszURtgjA5aywl8WZ0k/MHU5xr27vpcxwnn0BcXu91eUXyb42vhWhQo6KKmZWOW3eccJcCyQy0pPXVPzF7T2CsVGtXqmvz0gZbwPjz/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+mmCJuDngSHDIAjLBVvXUZM914iZgghNggV/TR6OPjYaHH0AFli9W/2dg4ce?=
 =?us-ascii?Q?ZaE+W2xNn4XlhWmnn9RVxVFFofgqiqYrJdV1mf5W+ka+tpe3OF7OUNw57vFI?=
 =?us-ascii?Q?ObJtDfF5eD6s554AcMYnayyZfnRYru9n3A3ustDV/x1f5xZOR47dZ/Fhfotk?=
 =?us-ascii?Q?PyGQwsi2LP3kDXbDBrwL93dcUk7b7RwipMs9p0g9DIAf/7Es6HoqlNKb8rBg?=
 =?us-ascii?Q?kzB1lLjpkhfgwLInoSyv6Uh9rVEx8sdqjvtchqI0L+1BOSaxpwbYmArVTYms?=
 =?us-ascii?Q?WI2MaXhFB39U9VeCjPJSbvxA/CQsRtMKvCYXSlrQo24Y4jUX+j/IdYyxJkRX?=
 =?us-ascii?Q?8GttLi5l/vjpbLHY/KhtIRbVz6iJ2bp/B2glv3u3Ybe4m/2iAnjhw4WN0jPm?=
 =?us-ascii?Q?fA/m24SH4Le5Q9vK1eSjrahdC1/hC+TQKPno52BESzwnlV0U9fkGY6wqv3HH?=
 =?us-ascii?Q?+O0VHQ30bH/rtEGt+UAFpqjPK7AFe/8Xexig99IjVb2gyPLEi93jJgZpMGpD?=
 =?us-ascii?Q?5n1USsDvJArLasvxUP50iUERpQFsEhTHsazBMVRA8ML+REfr7ieBJ038bvjZ?=
 =?us-ascii?Q?kZbaryRj06OG8UEGw4+48yfVIVj1ckMrLfYd3RJOgu3TQnXJCGHeJpCpIeXK?=
 =?us-ascii?Q?w6k+3vIuDh+T6nc9lUksFI52WLeTmhxh44NggIVxiBvWq5vCC1TRVPHmsq/B?=
 =?us-ascii?Q?2WydWV20zlasEFTHTZra+aCYUGVXgh2FT6bdu4r3yL9oh+0jL0GTV+bTeGO8?=
 =?us-ascii?Q?wUDSTrq/yQF47BHzO2eFPD0714F2uPWtrrWjr/Dn2FlZA2KWW9mDdfMOak3b?=
 =?us-ascii?Q?rEJjm+d3/LEcrhTAITq/qbzlANrZbE+iNDAyEqmcF84ZE+UG1KlLPDVcHRDi?=
 =?us-ascii?Q?aaV6VOgm2aNyS3jPJI0BJv+EJ1DDHtKRnOhJQ7lxO3Jh+FfbHEGcjQwSvjJT?=
 =?us-ascii?Q?DVek/eCGG8olAHy+B0e5ZLM1rkwS4CMgybwoKwv1YfkfomjmSGQbd997zw3x?=
 =?us-ascii?Q?l30IY4v5ZLpDlllnYJ8G+H3WHXRAo4DRCFhfRJcr/34OTYF5xsvRO42K04Mu?=
 =?us-ascii?Q?Zznnr0/3rz9F6sJpP4FRCSnedFxJquT4V8chAYytJ09oJmCIQZObMKWhroqW?=
 =?us-ascii?Q?HEWaMo3CJtyR6t5j29DOzsfObMPJnbzgqULOkZMkoWxa2V2oPCNh23M7+TD7?=
 =?us-ascii?Q?8RtucoMmkLBnT6Z31+KCS6XyXpzHAIau8/Cp/4c9Z27ocW0BNbA63tF0d1+X?=
 =?us-ascii?Q?RV7amAEEqbfdZwa9gu8053xa7pIsW9Wz1ThTfauiRipxTWl3gcCokwa8F5ZK?=
 =?us-ascii?Q?MOmgqr0MWQEVOKy9Y+Ia7oVv/Tl+i+dfM9hH4F0XrymK4OBaMKEkisnWT0ll?=
 =?us-ascii?Q?4F3YwKtUoRS8cCePNhlRgnQ9+8O/cstHlyaG8ZWW9PW84drZ3N2wjswJaMHj?=
 =?us-ascii?Q?jbyyYtcd0O3KcFQS7KV1SPpbUJQfgT91x1OgWt+lu2L7kYemI0rBnhY+7rDu?=
 =?us-ascii?Q?bv7eYpYYU9ChxSImJ5PMlOHCPI8ahu9uoksWWc3TVR2iNUvnEERPqHAinqUa?=
 =?us-ascii?Q?jeqs8CV/KyP1nr/0Fo200EjlPLDDAaoP3YQqf8Pj2hZhr87GAaH8HKLbBlXp?=
 =?us-ascii?Q?42khUvq3ZjpwrBt0qkSDTOAJIpGnjSPc6FkXyDDqj9WK7tba760bhKU6j/8M?=
 =?us-ascii?Q?Xw3gvblyhWAlsGWXan5XLbkZtFvLW3VjsUO+BkvHg5dXm9+SCmgmIRyPaYcZ?=
 =?us-ascii?Q?8joiOGjDqQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5657556c-5c56-4dfd-26f8-08dee93099c1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:48.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBshk/yHwTzSi+5R19QChUbL6nqsQnp9ylvieaBbC0IxZnfZLxfz44CT/02N53QKs58xWzlla/aTpvnPwsdE9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8717

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() and
dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/humidity/hdc3020.c       | 3 +--
 drivers/iio/humidity/hts221_buffer.c | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 1ae8702ada54..75971c19624a 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -843,8 +843,7 @@ static int hdc3020_probe(struct i2c_client *client)
 						IRQF_ONESHOT, "hdc3020",
 						indio_dev);
 		if (ret)
-			return dev_err_probe(&client->dev, ret,
-					     "Failed to request IRQ\n");
+			return ret;
 	}
 
 	ret = devm_iio_device_register(&data->client->dev, indio_dev);
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 4d03db19063e..df12c7a25b2e 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -122,11 +122,8 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
 					hts221_trigger_handler_thread,
 					irq_type | IRQF_ONESHOT,
 					hw->name, hw);
-	if (err) {
-		dev_err(hw->dev, "failed to request trigger irq %d\n",
-			hw->irq);
+	if (err)
 		return err;
-	}
 
 	hw->trig = devm_iio_trigger_alloc(hw->dev, "%s-trigger",
 					  iio_dev->name);
-- 
2.34.1

