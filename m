Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023136.outbound.protection.outlook.com [40.107.159.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C5313E00;
	Wed,  2 Sep 2026 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788322323; cv=fail; b=mGQAY5hQasBBntsbl9eL2ILROW4S4oygByLxOGRUEYQ+5Cv9uaOEk5AICw2XMyB3u4ZdIaZCns81pRUBHzSBP37wGO44NlRXvTh5R7eV3s991SZz/jqOuD+VNWeGAPPTUba3y+5IAy/RGnwC0vW7AIl3z2DhN2vAJ2WqPlcJvzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788322323; c=relaxed/simple;
	bh=E/Z3c852RDCovJbFUQ42IvMifRQ/dr7iwK9+CnzyuiI=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=N7Y9qM8CBRDw4CnFTQlAm8hRLzta68yXxFdLydRQ8iH3dGqaNLA+FdXeK+LOZJVUhDsHu/1Sffq4+bmhPHvNJjPy/pilxu4OEfCG8Tatnci29HtAJ9JFe/NmKvLGiCUvxEKpcp/N5uW3Q8ayaqnpQfWMa8dZfoWzwyokKzBDmSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ls/D4LRA; arc=fail smtp.client-ip=40.107.159.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ls/D4LRA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZSGJ9L8aGrGe8vM7mLsfEUsZ56D/t8m8EhtskLyp0HSgXN9TLThoj5GCoaGL2/Q/5cvAXvmuwYsVl+PNvlRTgY84fZgnCNNURy4yCR+G70knh6zVHoezEKlZnsnkmNPyyb5c6E4nToi9A6b76AvkIITDi7PhWQ2wwhKJPUFnihNDQrkdi3N3BcCL6rAAhOFeAbdEdXZNK+trQIIuLUf0H896NYahSl5GkGnJYMktlKSu5sQEBFlKrrjp4veoNw4WDvLSq9O4EIhOndwF4HnQj1x2kHZiolPVQXTpyUXa1FULMzyUEgBfu2d/abjTAnH7CQMlp/91DN2i8ptUOdgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYc9EPjgxlTATd7ZSmXLZ3NY2XzwGBp8vJWSSMYey9M=;
 b=J3KkbczvFhbvjtMnYL3ZDtyvfP5v+Jqs4yR97Vb/TML1fyZG1T3Mh6ekodaoHqrZG7G7w8rs0yfbjNhWdxad739XgCtVwwHnqh/BxBz7Ou8arQx2uhhF48kKtiWd8ta9SfRp1/TpMdE09XOxM/fQnJg2LNOlWl0IYxYC8s8KzBZdBBvcDgDzyP9mqIuQlzgNBn8lwUSsTffoiik0A23qsUduFWSrH5LFn0ZN59aMl8jsRnE0bStBdoSR12TVh11w+8L8GTXewjm9AyIWLmdx8bHVMOtHkSXEDpP0IExwqamVJrLR2yavzUIGKlF+4t1iOrlMdvYRG4VjBAvqEFXzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYc9EPjgxlTATd7ZSmXLZ3NY2XzwGBp8vJWSSMYey9M=;
 b=ls/D4LRAnXdlGXksf0Wy40IP8cRSIEkVAOWwAnizo/I7+H2tEgL5BZRdCEUljckvTGcPH/3UErVI16FwNzFJ3iBzlaa7bLdY20lrRH9jp8nFy9Cfm6pOoJHOXWGgNIXISX5iX/+ww4PvpN0Nvq9uyZmbX0M3lUvwo4Lmh/pP+6qFF7oqw8U3rA0m28vBGgVsC04x5bqqQH2gAHf1iiRqC+2PSPKWpK0l767CiJ+xLicgafpfV8uWTzryvZ6KWwYlhRGbGf0Siuem0Nn/jNAeD/fqj1w/tMxFC8qEws56x779O2AM+wLTutW0wyI4j/Lquwgj9OOtRwIc8U9mybPIBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by AM7PR06MB6533.eurprd06.prod.outlook.com (2603:10a6:20b:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 04:11:51 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 04:11:50 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 02 Sep 2026 04:11:43 +0000
Subject: [PATCH RFC] iio: ad_sigma_delta: support four byte register writes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ad-sigma-delta-4byte-v1-1-af43e4e045f0@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAP6hl2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC2ND3cQU3eLM9NxE3ZTUnJJEXZOkypJUXQujNBMz07QUoxQTCyWg1oK
 i1LTMCrCx0UpBbs5KsbW1ABacuv1rAAAA
X-Change-ID: 20260831-ad-sigma-delta-4byte-82f465fd2d48
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788322310; l=3419;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=E/Z3c852RDCovJbFUQ42IvMifRQ/dr7iwK9+CnzyuiI=;
 b=pwFjr6Rm6Ojwy7Umg2tQ2Z69+s9uRFbUrkZXET4W82IjUH/8tnxdOlQXdMJL4g6nyVLUM31+z
 xn7AO3kr4qfAXxjRY1UV+0hWmpq+xIgSeXFemWqiIOUx1P9p6zuTtIk
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF0001A32A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::696) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|AM7PR06MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbd63cb-1726-4a01-b2fe-08df08a85079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|23010399003|366016|38350700014|3023799007|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	OfMI/IMe8iAVZLX6NiZg5q+WHkNrsrglp19xR6baqzYelMwOMURmA2K2GRa5evB0CW4IoAFoX302WIN0bJOV4v0Y4aenYIGN35qpXZbfh4LulcJGwbJ0Zg9utIk9R1bZHEOUVneBowpYVcDlufKYxCfYH0Y+6OWcaWNwpnCzcpzmcklMWsHKhUr7vkSPQEFXeL82qABEyDjdMXbTdKnguksM3yd+HFNnUp61AtcXe948TNuLZ2s3jj0oE+foKTVQBJiwuzEHWn1x/fE8lJo5ga+ePM5YQPH7IicFDyoTS6w+oUVH1bCGZdju4oDcLJWtQOqzkbLExNDYk0gMF3aNgoPlHz3OVcOZ5QEERKQ8wy7OnJ/KZxZO2VLIUtrNiK8w1YWU7HML6jTHdcte5ZxswTC15vx+S8yWNKS9sO3ZB2UjhtN/eIVJd/pIcCirfSUZdgdbf0BqZ+DVbDfajBHOQ1dfAGq0+p52ZBjOGekZtrlSah2ODxbATiBedNxsUTQOs1xZIb5lpGk2jiRmQ+lMHFTjIvr9PD6/iCn4Xq6fPYWZI05iihdJzBIO4OGFDyFwQ7xBbhcuVbclRVISWVivj9aQiNTPWsPzbnCjcPmQa8HtbsTkRDGH8isDDCmQvwbye3rRfbbfKkAzjaYAg2UhpsnpfRDeSkZukn0Qx/NiIZmK6oN7bi4dxJX8klgeo29e6X8JSdNM42aImq9QkLJxFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(23010399003)(366016)(38350700014)(3023799007)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmMxM0JGWk5kalJmaForNlRiSGtDSm5BZkt6SXpERW5NaEFoSERCUDN4VEJR?=
 =?utf-8?B?cm5TNmRJVEljampZWGMya3hnaEQybFhzK3RuRHNOK3hlUW1HVCtERFR0ekJa?=
 =?utf-8?B?UVRUcHV1dXRma2JSbmowWWJGcFFGQWNZY1ZIcmJuWm1vaStRM1hxbTJtQkt0?=
 =?utf-8?B?OU9PQ2RtZDNtMkFSSmVHR0ZCaUgzcFdNRXlXRkZoV2prd09ZUjdFVFFhSzRw?=
 =?utf-8?B?bklWQXpFQkRyVE5HdmxkaTVqaE1nTnBocVJtWmdFMHpMWnNTRThSRkJWRzJU?=
 =?utf-8?B?TG05eTZIR2c0aVBWNzV1NWhhZTVUQ3Q5RG1Sd0ZndHRHcXhxWlluQXFUSkZx?=
 =?utf-8?B?VUU0cytrVTBLeFhhNnV4aXhSWmc3WDJmM21DVHB3WXMvczdUOG1idXNmOFBm?=
 =?utf-8?B?UzVkTnNVYWhGVVdQSmNodklnaFdSaXdYQlZnZ0wyejJMdGZnU3RkZ1JZNnlX?=
 =?utf-8?B?MkVEM04rYVhvRHJqVE5ScFo2N0l4MnBNb2U4dHFITEtjK2trZU9qU3pFR2JM?=
 =?utf-8?B?KzlZb1U3REtEYzA2aVRrVUY5dFJxRnNaWFBMbEVGb3hGQ0MxUEp0S1hBS0Jy?=
 =?utf-8?B?dGFGU0NCTnA4dnFSb2NBaVo5QmlRMWh4c0RsQVpKdTZ5NVd0UEdQTnJhMzUz?=
 =?utf-8?B?WHhIV1ROYzRuYmdvZTJEdHhhallRZ3MrcXFlaTIvVEFETEQ5WHZqM2s4OEhP?=
 =?utf-8?B?bHgyRi8vSXcybXpOQjNNR1ZBOXFLVzNrclBzWFAwQnJjMmFNY1FLUnFOLzh6?=
 =?utf-8?B?ZFVZZkVxdEhFVHovNC92Mlk0SmVTM04rbDZPeFFJa2czNUFyQ0s0QVBaMXZs?=
 =?utf-8?B?ai9DTG1odjNXcHRtZWx0eGhWemYyN2IxQ3hOcWNnUUxuM1kyRU1vc3ZRcDlL?=
 =?utf-8?B?ZGFMRUhDUmJpN2xMTUlha3hveHpXTWM3M3dWK0lZV0pGbGthc21qdmVaZkJw?=
 =?utf-8?B?dklBYTNLUVBxUkpNQUhHRTBKZGhlcHQ4eXZtR3RLQmRlaGtCMWd3UStoTG5F?=
 =?utf-8?B?OVd0enZIbStmeVNQQjZBOXA3ZW9FcnFWZm55YWV1OFJkMDhabnJjMUQzVGRE?=
 =?utf-8?B?MlRaaERrbmllTXgzeDdDcmowWW1VeU5nSXZiUU5zV3N2cWZuYmhrakIrYXNG?=
 =?utf-8?B?aDdSVGw4aUcza3g4K0FqRUhtdFMxMXRiYVpMSW8rb1libW9ta0dhbUZETm13?=
 =?utf-8?B?T01mV1FJNUNUN2hOS0JBdEt6UFIrS2p3ZDU3N0IzMWYzUXp5eHdXSEFDK2ZS?=
 =?utf-8?B?ejEvTUtFUERLSUpzd3R3OUJhL0NCNTFqcUtIdTlEUyttMmlHUS9ZQ1dvMXpE?=
 =?utf-8?B?djVvUWR6MnIrNUFaUUZqOGFLZmVDcVBKWWZFN25oN1huVzk1OFRrL3h6V0hC?=
 =?utf-8?B?eDY2UUFBcnREZEhoZ2pHazFHR2VDSm5WdVdFNU02ckJGd3RDM0dHV1VqYnhC?=
 =?utf-8?B?U28wRFg1SmZLUUl1YmE4a1krOEF6YitoUGNDQmIySUF4SmhIdHVhUWEvc2oy?=
 =?utf-8?B?QklvNWtITUlFUzlEMEhBOEZlZEpjajBDSWNqY3FaQUpLeUlMT2ozK3hMTndn?=
 =?utf-8?B?WFVWWnJrK0VpdjFQOXlGNHIvWDdlRjdPZEw0dlhXZ1FTVGIxdlZlc3Z4dmNs?=
 =?utf-8?B?akUvclVVQ2h3Kys1bDFCbjhQWEdJV092aVlkYUJWeU90c0s1ZDJMOHdEYkJR?=
 =?utf-8?B?ZjdxbHl3OHVrWG9WVDlSUUhoKzlhcEYzNGZqV0IvSXFobGpsNTZRSk1zTE4x?=
 =?utf-8?B?SnRJSld4WXY2NGMvbG9oRnRNQXVyNHRtRStPT2Vkb0VIc3BqZzdtcnAxZHAr?=
 =?utf-8?B?R1NOeGo0dDVtUWo3aU9NNmszb2pxRmFQTzJzZ05RTW1abXBXUG16RUtML1cv?=
 =?utf-8?B?T2hmdlBFSlF5THJXSjZ3OEhaZTdDN2hWakFBZVRCV0g2SUk3UHpvdWs2WFRa?=
 =?utf-8?B?dkhUYmJzUUZMcGdoUmsxUzFiUFJwVlZUNHZSc0pPcGI3NGFIVktsZHFwa29k?=
 =?utf-8?B?NjluT21pOElpcitlZ0MrQmdpM2RxOGYrelRHalJuQkJJSHNNbkV6K3drc3hG?=
 =?utf-8?B?VERnVEdUQ3R1YlJKUlRqWVVYcWdHT3Y1UkNDZjM2SGxjdEN2VzgrUHp2QTl1?=
 =?utf-8?B?b3FkZURiSjRrQ05PcDVnVEIxSkM2S3BjQ3FROGdReFRVNmhWTlRHbThOTkty?=
 =?utf-8?B?bDhkMkI4a0c3MDkzMVlDWGVCUkdvM2ZPZW8yS1pBZk8zQU5UWmNmQjV2dzV5?=
 =?utf-8?B?b3dvMFo4aTVxdXFhOGZxMnhmZmhoVHpMNEs0bzM0dFplQ2FjVmRzVFhyZ0NV?=
 =?utf-8?B?S2U5RU56ZXZlMm4wT2RuaERxSzF1cjhBR2xCK3g1M0J1TFpxWS9oSWJ0bUZ4?=
 =?utf-8?Q?0S0ghdxho+9JLetE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbd63cb-1726-4a01-b2fe-08df08a85079
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 04:11:50.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGwbfAYuO2pm3xs0NVduuHkYN2nWLnVK7+SEbThjYpJbRThVcLZCKzKVLgcLUztZzF09BW9eDpGQdSrY8hECHsIUHZYzEQL/tCUiMVxvavE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6533

ad_sd_write_reg() writes at most three bytes of data after the command
byte. Devices that protect register writes with a checksum need one more
byte on the wire: a three byte register plus its CRC is four bytes of
data, which the switch currently rejects with -EINVAL.

Add the four byte case, and grow tx_buf from four to five bytes so that
the command byte and four data bytes fit. The layout of the structure
does not change, since rx_buf is aligned to eight bytes and only the
amount of padding before it shrinks.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
There is no in-tree user of a four byte write yet, so I am sending this
as an RFC to ask how you would like it handled.

We drive an ad_sigma_delta part with CRC protected register writes
downstream. A three byte register plus its CRC byte is four bytes of
data after the command byte, which ad_sd_write_reg() currently rejects
with -EINVAL. No mainline sigma-delta driver implements the protocol
CRC these parts support, so the four byte case has no caller in tree
today.

Two questions:

- Is the core change welcome ahead of a driver that uses it, or would
  you rather see it together with CRC support for one of the AD7xxx
  parts?
- If the latter, is CRC support for ad7173 or ad7124 something you would
  want at all?

Note that the buffer growth is not optional if the four byte case is
added: put_unaligned_be32() writes data[1] through data[4] and the
transfer length becomes five, so tx_buf has to be five bytes. Adding the
case without growing the buffer writes one byte out of bounds, into the
padding that alignment happens to leave before rx_buf.
---
 drivers/iio/adc/ad_sigma_delta.c       | 3 +++
 include/linux/iio/adc/ad_sigma_delta.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 1b410291da5378584347231fcdb328fa5633a68e..bfdf28348e226a3b2311a8fc707aa4f41ed7e848 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -84,6 +84,9 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	data[0] = (reg << sigma_delta->info->addr_shift) | sigma_delta->comm;
 
 	switch (size) {
+	case 4:
+		put_unaligned_be32(val, &data[1]);
+		break;
 	case 3:
 		put_unaligned_be24(val, &data[1]);
 		break;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 6e70a412e218d54bbf9bb6861b1a4cc89be868e8..866355789ef0923c28fe8b61cfecb8b29fa9fb42 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -121,11 +121,11 @@ struct ad_sigma_delta {
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
-	 * 'tx_buf' is up to 32 bits.
+	 * 'tx_buf' is an 8 bit command plus up to 32 bits of data.
 	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
 	 * rounded to 16 bytes to take into account padding.
 	 */
-	u8				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
+	u8				tx_buf[5] __aligned(IIO_DMA_MINALIGN);
 	u8				rx_buf[16] __aligned(8);
 	u8				sample_addr;
 };

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-ad-sigma-delta-4byte-82f465fd2d48

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

