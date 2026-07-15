Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013017.outbound.protection.outlook.com [52.101.127.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182B30D40B;
	Wed, 15 Jul 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123456; cv=fail; b=mOcfE9uBNAKV6bmTvZMJj1shzvdOWZQo4BoSxRFGO5erJn09Dj7U6yz6ELCtQfYlU9VxE3pTbcQmngWVryOf9Mr1rQF7m57kYZ9fS8D6CtzaNiYWor+SyN1H7nEZYvARxswTolovAmOOB+98iQ/juXJBTzvv6vE3N29g5J8QIyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123456; c=relaxed/simple;
	bh=vbOCVwhhWfdXqTEVxZ/OJbU8SJbxeZ+vPuwOMb+kTa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pZS5Xx6ldEMjr0WXEfXA9K+qf+jyAjWDd1CAvphu6xwO1IPSxeuVMWmb5LoJmF1q6x2D3YuZfHKgwon5cPMUGGLRiCpWvvS2UeiJOcHW/66mr11IDjqaBGTKIgZmjJvIc/lwjf4A6AisFDja3HYk1Z9UgzZa+kr0TW8O/VvyCYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Jz81x53P; arc=fail smtp.client-ip=52.101.127.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Jz81x53P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXp5/g/8z4nWRq19GOxYZv7mnPBvyMYKNBTlME1oQOIGImWNSBwvuLGtFPe2WIWanqHf68vuQzEYzRNlzvq3Z0oE9mLFZ8XeWqwEucLbF2rHzGqHTzeJNVO/wyYDAwCa9E6j3fkaNKd/jMg4i4YhVeHzBUnI2uezdQqPXlulK6dhvYfDT+P3wlfYoI07IkqyBimg43Ij7XN0BtrmZ27Qly5y9o1Odv7rgptxGOOU/O4A1WxdXkUfHy4ycpSy6qYe0ujF4Tl3PtwoodSP9+1Foo7nY74kr8P7jzfGVFL9n5gtvESsWoggq4XhbkBmEDQaYRl3ehbAZ7JXxbrz0YkeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAaVvW5ouIO8Ps/jSanzgTy02X7eNb61pQoegWIyJ9g=;
 b=SNtGpdk/mQUkpOvueHr7po7YJndsCox7I9jPv6/o7Lh2sRqLHz/IeyZS4ZQ+dTI+WKq3I1cWc25HC4CMc+BrLA+96Dwu/rzT+1IMj1kw+djOroCNj4XUz2pT0pg7a99yu83lU4PKg1L+ynDgwCuz4EZ0rQ5HIBwRf/sABp74+5JDeUqKp+blj2AVGRGDas1YhjQVjqx1Z0XVQc78pWrDcHTdr6+5g2zMVOA2zNFjcDV+lkkHP7OPw4GZF1mZD6MnZLzJz71SL5iMMkPetUHRX945riEd+fUkH18wY4De5hkBqqLP7fBYiLXCsrT7L/kJS5lDUxb727DcieoqMqDs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAaVvW5ouIO8Ps/jSanzgTy02X7eNb61pQoegWIyJ9g=;
 b=Jz81x53PZt3FQu348it1a67RnGGWCoT4CpHAuuBr1G28dQzPkTxufSjHRqXZNvSqL1ZQ62/ma5TpY2QZrvczjCOpQg5YSkwTqqn2qayrJFpmYrjSPSBAkJ+KZz1JO6Khy4DFFpCl99BdbNe5ZsDHT4lHw/2pwt2nHzmAY4ulNoKfydBioOKiocs9F96YTu4otidvngPpYUBtnmSkVMd/QRHhGRcJ+L96jbAyNoeqTZ0rDjY0rGC4kVD8oYhFJUCZuHbNDlGQ1jvvL2syopMQU7jynazbhryRGADbZU/OqQOtR1+SOzo/JON2tduVKyGnYBrqhdsGhH+WCxdDDGMetQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI3PR06MB8658.apcprd06.prod.outlook.com (2603:1096:4:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:50:50 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 13:50:50 +0000
From: Pan Chuang <panchuang@vivo.com>
To: David Lechner <david@lechnology.com>,
	William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org (open list:TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 3/3] counter: ti-eqep: Remove redundant dev_err_probe()
Date: Wed, 15 Jul 2026 21:50:30 +0800
Message-Id: <20260715135030.326290-4-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715135030.326290-1-panchuang@vivo.com>
References: <20260715135030.326290-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI3PR06MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: a28ebf21-0bf2-4b6d-c2a0-08dee2781440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|52116014|366016|56012099006|11063799006|38350700014|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XquO7M2RhVgcSlTL/rP7sbNOfNcZl0WpL0n45iN1EbdE4zAoR+f3/CoBi7dQX9lBf9gjNF/WS0/sCTfUQ682dr+XhMkXGu2whqYT2OGXQhnSonfQ2AFPOMSsqJJ1UiTxSApTJj4MzLgAmsRDyTsnhnErhofFAfKsPG/23K3IJXvrR8DlW9g3I+o0oY4EFWC+uoQAV+iwu8z9F7MqZPiAdKjUWGnSAXl6LPD7PeK2Fb7K5qceOM5ROT8dOHnad6AsH988I/pJ4EtRFXhTDKGUHlIDxNCsq/siy13R8BuhKPmQrL9t91UAOPWAvB9gLAUS40xgScyFGHPOJSAu6vSWvc5rROFh9FJG5oqE6JbweWKaqScYhFJEQrAUAsWLJVAvZcKKxYTJSIGfjAf15aE/T3Qb0TJ/6R9EbuCk9RPPYNBhjIHAP3GJe3tJGaVci1ffh8151Au9gctGEyWgFnjHJhwA9qt9eM/Q24Mnzse7x7RsYp6ZxYDZsrOU/E++rrtUdJ7CgQOrqKQ5D1ZeyKISQYAP4sh5/zNcV0xQlixn2olhE7OMFHHRrrbD1y1FuntDxSuPf9UOYRLInQxEQajLD5IPtnPkX+lhGgCnor5vYS3E74jxKFlwtkgE2HfQ7IlFwHJjm+DSspCID5xB2yb5yozFJ4WbMhNIoj9Kq0Cci9eyJCfS7d6Bu6zPS69WoUc8lBLgERg/ZuyjEJ8OQFG2Neb7nvvfWRhw24omxaNpjwU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(52116014)(366016)(56012099006)(11063799006)(38350700014)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QdMy33N+N7UMP/121cBXEL+7KWqSkLYhTeeH/nCAquwYEWu1o6XVdK06kSr0?=
 =?us-ascii?Q?6U7KOjbZGQYLe3HFiwBZykcX7NvZN6X8RNY3m08UFK0FBIQu/9q+YkI7lc41?=
 =?us-ascii?Q?wk9t2yk0zyZCUD/ghS2Dpv4qtlf3KIM+Lo2keAis7axEjkoxEFURSBtOrjZA?=
 =?us-ascii?Q?zOI2SnlH5jsMd9KUtapCNCMfNS65uAVpvgrign1yL4TlCRTw8TKFu8YjA3Mi?=
 =?us-ascii?Q?D7wJMqVfCv8KJRRqkY5hZeK/zjQdUcCxPkJjB2v9EGj7RL3fZtVKA2qpu8ZF?=
 =?us-ascii?Q?qq4ZW2UBRT1XJMEwhm8ztpfTdmI8KREfqeqe4aHY4H2mXLi0pWCQAQrG4VOc?=
 =?us-ascii?Q?FISRt3R+KnHqR/jpuEiqw2j6Tx1v3dSyURca6Tx8Wiekto0H32cBTAKa5Tmo?=
 =?us-ascii?Q?UJCSpkutFiEKx+eybnycL+7VbJUSjIEJ7MtmERfOBJkXiu1EJongrQ9ENZSr?=
 =?us-ascii?Q?tT1Kr2xmYivj5XZY0uiEvC4LhuymzsaTK4atg6MJm034eYBM2+ofQUrlqkiv?=
 =?us-ascii?Q?I/0wxPSJ9Zr3vCWpYE26+E23KWTlp1hqwC0f4VtNC8p1xputT4PvbRHp1/8D?=
 =?us-ascii?Q?3btzMGl/z1li1Q3Xk4TBM7VkZeT4gHZYjEnwwVVlos6s8ocq0Ph1zq6sLKr8?=
 =?us-ascii?Q?0Z5tJFPislWEjocgh6iDqqWubuMqNgboxFFKGfCI+KkqC+dbxDHN29I2nOuc?=
 =?us-ascii?Q?qJ1SQ6AeQajrpVcIed7dhQhIP0qwosrh3zWOQRiWN4NM/u7kkKOUWGT4U3MB?=
 =?us-ascii?Q?POtZUpIQ0HEva1FgC55xcF3oYDgnZNBYxspOCzYTqhMjVVrmTn4iCJ6bOu0Z?=
 =?us-ascii?Q?B9MbXVkZ8VZPIdKz77xSuZQ1jLmoeacGTNOR8QXU/T4E9ooum6W3eLuBhG+e?=
 =?us-ascii?Q?Z9/MjDTuKI4FG8s2BY+MBKzOOJjfSOwIr/2240O8ONJx4h2J/ZvTFppPLXCz?=
 =?us-ascii?Q?SSrLvPciJuYuIj402Jtyhk0Ih/V9BaDb6ugUZfE7GbG/3nRsJJC26qkspBpX?=
 =?us-ascii?Q?MsstPAcZASNWrLUMLjCLfRuTjRCYl5rfwHVwF5898TT/u71tLZ5uQbyc/b6Q?=
 =?us-ascii?Q?bdEMDf3e1H2VAU5RzZEscrmNHxaCHuy8jFkPa4O3l25i1T3AVMnldoSf89k4?=
 =?us-ascii?Q?ZRvqeOISe7TKZrdFrrzFPhvXaLMJr5Yamx5gYM/NHtv4WjLMKIMJ+rYYg4D4?=
 =?us-ascii?Q?3NEd2cKVEVYZefyyAzhVBGuXemTmDk4TUjvZy+UmRwZm29V75dRSfLj+Ec7x?=
 =?us-ascii?Q?+oq3UXWLsO8/jLeIhNhnhHuLC5Z5q7iHpDqu9rr7wZ2/aKHKQVe98bMo3oX/?=
 =?us-ascii?Q?ybdf/F9wK5UYPLFCnyLEnVO+NlAHnYDk2/RluzlrIKCNMxj+ZNY33YtqKWxH?=
 =?us-ascii?Q?Pcvpa98/C27zUXPERJRTXMaVy4NTsVbNpmCZO2lhNzW1BxYrwr440NRmEUA7?=
 =?us-ascii?Q?0tQ4ZcvLxnDPKi97NNuaN4nO0L7pp5FsSU0BcodNRIKMxMe8LPX+jeo5HQQg?=
 =?us-ascii?Q?du5US/Ux/6aC9DSS4UGze3k/mK1K8Zpi8K8Jd2q3baRpOPkH2xaUF47EdQ5O?=
 =?us-ascii?Q?NvmPVTeorsYh5aUHWgdSFb59bibIR1dsntpmFwSKF/cWXrVYkmWWIc6z8jfc?=
 =?us-ascii?Q?40QI1fI7FWsIG1zrlFUESAAHf004g2LMOWFT+XZEWDpeezQvB5x/2fbl8hks?=
 =?us-ascii?Q?3v3XB6zkHgKAaKz1JCKOnvup9K7R9Bgkh2hOle2lwjnB2YjAtFr82Nn4JpSv?=
 =?us-ascii?Q?XSjPAh6H8A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28ebf21-0bf2-4b6d-c2a0-08dee2781440
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:50:49.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrkl20PRcs7cOztISPRh+yeFV4782bvR3tLLuAWuI9ZOtIU/5cCFAuBCm0/94/dFaReyUiFMJCc1O2ofjWMTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8658

devm_request_threaded_irq() automatically logs detailed error messages
on failure. Remove the now-redundant driver-specific dev_err_probe()
call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/counter/ti-eqep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index d9302ec21163..0dda3f2b14c7 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -526,7 +526,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	err = devm_request_threaded_irq(dev, irq, NULL, ti_eqep_irq_handler,
 					IRQF_ONESHOT, dev_name(dev), counter);
 	if (err < 0)
-		return dev_err_probe(dev, err, "failed to request IRQ\n");
+		return err;
 
 	counter->name = dev_name(dev);
 	counter->parent = dev;
-- 
2.34.1

