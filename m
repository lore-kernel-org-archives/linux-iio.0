Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459628;
	b=zP16M5wHiPDlpCM/IQu2edogj7NbnHLm8C74RwTBeXjh7f6pBVLhSvaOeJ9T2/FvqHGN
	 CJD2j2CgTQ/G7O1OmEfN36MJaXUldQ6nYQ4XSNcfg6Od9mrPF4heNe6rgo2IyKBzA1wcw
	 iDvmi8Zf22zWbS2bqAqQLOaMXOsbi359fMO6PC0VICq6cXG44XWuq12/xXj+h2EBijIsU
	 ZhbaZ3r0Ike8NEl29F/OinKocC/8/QmDuVkTJEzsUrA5bBZ3m7mS/GHKkKUiHlKCwipgr
	 lzMFJnLyYrv+cFJ3EIeYznLV/s52bT+rUmLgGLWBFzdSeUTx3JTKhgBMLCzkPUbtHug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459628;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
	b=QjdQoLY5J18zDnnHWR9ucjV0dxX0o/nrU3T8lhRj9XvAHG2MkUsMHYv6nngZfZ9PNFWk
	 39S88dmC7RT0b1Xud6dyJj0byDMsxIZH/yB63faoMQ6w7rQ63kyL9MZEspXBTcysOCzlM
	 ST2kkhibjEOYtbH8UIMnTR776pWeyJYjpRKCiba9KUlCbitanpL0jggmmPUDO/+ZrJERA
	 v8EgH+KkNp7tOV1LAvRpP76mhZYqAIC9u46N/y3TqeX9NKFNY/Iy0sR3nzs5fOhUtRc9q
	 FbKPYUp+sGclB1QkLUY68V/slZ+Z0ssnV5Iem+QFioAzX2Gb3aHHIthHI6p2UGn57zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EqgYQwOl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.21
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010021.outbound.protection.outlook.com [52.103.13.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21A606A329;
	Sat, 31 Oct 2026 15:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD21A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EqgYQwOl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPN5dOJfq8QgnrnG3YNAC1EpxLuQQhvxR3mcmgF6DsYxjOi/IGrMXv/dGo3j8TkhmOogg9bU6wXb/juU9Q2qX7MSMO2s1MJrxxeHOiWvly/CmLcUWL6n2N9g8pi1QreJr12X0U1Oi535pwzeDR9IHMkJ0PxE6U4JLJiCzSi5y9tfhHjBTb4zcqR+DiIAkBA4TFFLhq6G5wFpR3biPIE1+TxqnVAyzk54DzYMFKBD8kvrprS/TW/kJPWwxJ5uL40+qX4e0EJNXiK3bptlNAcMb1JMbIRHoTBq/Yz1+tBc/PaJKhtujX/ry6IXeCAaWY7dz4sn8LlqWS7cR1M3x7HfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=UqcZwyLHfZdXy3srVj5fcaAD3ddtGZoS9wcxTv3achWB+dK/8A//cDkqLp+lDlTxinbxVnOtqRvSj17uLP3chC4/RlWwhTTTgcOw0mKAWqyj9RDorrzUao0nEhwZapT9WedXxmrBnAdW+rqFI3mtehx3xa2XQI4I04b7IZqEAwZiN3jaflKtobqpMc3vRKZkG9IXsZJlzx1ezuEVWp8jyYm6SUmyKR6wZtXAqERwmzPkFpgqjaUloOoA70wBpXbvUkJQ10tmzivedAUMt2Tg5n+2QpEiVdiPvBcmWMdo+1gz3C1K9t1JkLbswD7j6HAWoMW0rwjsGEp+MOoeLpb2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=EqgYQwOlFThFpyqEPR9xGfIipElgk/WBzIxyiGA0jfKylFhOwTiAvKSOMWLr8S04g3LO8ViOzYFjH+WSyatnMGQMl9FfXmhWQ5pYWUxHUrPWICdvvYHg3l4vOQ2NyLYdFZOlq894qqTtcYZtcpHvz/bEylf1/Eh6sT3/fwoin1j0tvBNm7zBXNXZYTHrZexM0vWfXyBLae9+dOvt1kvx5mFrq+3KSg+CNfJxEl5e2iB2UdRs+j752wdakIIJNlhTZMVCWmARCSMKEDdJJuj0Z6nzZi/oQbCQsRBAa6rEml8GDIaUaGAQqdH/FG9ZzuhsQBDTkEiDMuoTYW7oaf9Svw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 15:13:45 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 15:13:45 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v4 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Sat, 31 Oct 2026 10:13:27 -0500
Message-ID:
 <SN1PR12MB2528AC1EE9CA6DB258A8BCD2A56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::23) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261031151331.140654-2-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 322c324a-c0c9-420d-5615-08df37618d92
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|8022599003|260925184616899003|25010399006|24021099003|15080799012|23021999003|41001999006|5072599009|22091999003|24121999003|26121999007|3071699003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eecDX7JauSFaJCNENI6QzfcU6f6p3r9RMW9NSZHZ7Ubeul0FFsznLI8hGYWv?=
 =?us-ascii?Q?mK4W2Yv4Dp/aNji6v4WkpFABykuorn4EDfGe5IdFO3r5+rDn55dF6+joETLJ?=
 =?us-ascii?Q?L9heT/n2rOP9/4GaQXPSKSnnbhM6LF9U/M+a3t4YtvAXqap7Mq3yt/I/msmq?=
 =?us-ascii?Q?JKRv2Dht/BEoP11mN17fC4tzc2dJusTyp1VcJG5d3RJGap6oINyakEHAFipm?=
 =?us-ascii?Q?yqwlVe/4qOFYzOwN8ulMShmNjTQbYeh2qxGW+CKM7FD5kzdAvUiL5yN/illo?=
 =?us-ascii?Q?uVi4zTQeHm4UXTZ/fsXmVHUYVqrDmUQLkt8FV2Yv5BYJXOIrIirDo9/UHqwO?=
 =?us-ascii?Q?7TcTZc9Qy2k5BOFFh0EMO2kViMcXjRFZSSjNwDu+Ojepw3Bc1n9o+KRwijUc?=
 =?us-ascii?Q?6xR/aKxxvx0aODttel5TALub75nmwKbeRVHRP2oLi5+ivsBg3vHaP2mpQdWh?=
 =?us-ascii?Q?0YlJNAKs1y0DR0OkjgYQFuzQRovmX6/bQX9GmZOgF8QoBOjt52bs7uxOZbB6?=
 =?us-ascii?Q?eDbSwvUhGfuarjiv9Psn1LBkSEhgtq5Gh+AiqpTdQK8m9bYAZ2JptZdpOUGT?=
 =?us-ascii?Q?IE1JXzfJNjZ1ZDAmaMEXFqBG5/NVQjYF1w4sSujv0uBaeYiuU0PsHYsG5Yeb?=
 =?us-ascii?Q?GxxqNM7X+Pgq1BmEDsSJmfX0qCvHjml3HrSQkC03Y1/hMNGmocLTbqHIjgLz?=
 =?us-ascii?Q?QFiebUqLnXdtITX/wta7QCtglCOq2zcOof5iBguQs5YnBqVuP6arg4TYkC3w?=
 =?us-ascii?Q?6J3SXhBNg3Ub4pwJU0HQKjJo4un2TbwT+d0/UdKnvH48j4gYAyXOO+z/X7fG?=
 =?us-ascii?Q?FJPRqb1x3Q6ZzLP1IKpOGBBOwbxMu4cfrwFliTlqgeMrKsW2G8zNu4I1aXJF?=
 =?us-ascii?Q?nTD6MMfq6bOYhx3TcPFK9GXEGbMINscvdX0yOlDNBm8/5jHsXXGRrIZdIXt4?=
 =?us-ascii?Q?zpIZYmCraTu4uCoKZMrJidSg9dPdJ23AHBF41Yi3h0vPXrmJU1EYNw9ndL/k?=
 =?us-ascii?Q?D+i/MTS4byaOwmLhM8ABm1mlI6/dB9Nn2IdBuJOIBEGrhPpVO+ECdpoizzA9?=
 =?us-ascii?Q?3NW8IUuF5rINAhNNKf1KL8Z5EZOASA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XL1cv9NRRbEE+LIT41GqJjIfMgArbHyeaxPgK8jiGFkuV7zzm0YgfxANas33?=
 =?us-ascii?Q?qoWivuvwRL8AlNCou5UP7cKp+2ZZAHmZ2/7gxwVP3MbigPMhMHdAvjm0+Xmj?=
 =?us-ascii?Q?s/PimdUesenxndIQrRNhg1QQvNSgyiKk8pH11AQ9XVamW5MobklHpAOsNAuQ?=
 =?us-ascii?Q?d1e2SYPRohq+LIqv4mVLLl2yQFOH4PnFdslthYSmHtDH9Rp03o8ZfnpmNSnR?=
 =?us-ascii?Q?OadFjRUcjBnFUdStPyGfg2o5duXWB3FaD9bPGWeJSXGefiaE+sHJeC1D8ybc?=
 =?us-ascii?Q?bq0oftZPAEzLRfbNg7D9Zkae4Py/CdLYVvgrpSce0I4cYmQul+eaTdsnifgi?=
 =?us-ascii?Q?FfBIRr/LhFj3I3irqH+fDctm/Y6WlIHzPmKcKFODAYfV5282Ljh9IVQq7k0/?=
 =?us-ascii?Q?m9T3PBo7xxSXmk2O61u4xv8NcT5EY5iy6H8Ebgv48tyPLjYhhWwjvrqZkmff?=
 =?us-ascii?Q?WRsCdPayL9Zk/ZZeBf+WRg41Bnbrv8i5jsa8sZxLpzFqOLvKveuvb88TSzqP?=
 =?us-ascii?Q?nTAVvyBov5eNTZ/3mwXCpIyiAceWOCjZ3wFUQJapV3ChSPDfSVAhwbnOMoSD?=
 =?us-ascii?Q?Ytqlh/qySFZ/E5rsHMOHW39sqHjlCDBeJ9ry4U7F3mFaac6cAU+c9m3TS/Rq?=
 =?us-ascii?Q?1kzUhFRRjX2xBKiNh6vgkj5TkOsoo1Mw/siN+fsD7WzD7DgidQAqnAhg8iyH?=
 =?us-ascii?Q?MqG8ZljQE5eNE7TMSSv8Yjz/EOj6qqtjl69eIVKz6R2/PJ4RRkDe5SMsdGby?=
 =?us-ascii?Q?S2NkpY7dNEDx3vOwfpgN9IxtiL4iAcjXB+X8CCiNlrL1MKE3/aDnhoJiXiSm?=
 =?us-ascii?Q?B7MAtruFiGLk4/ELtpUN5emaswr8JGMquD664Fpk/e7Vh9gfyGdOs5gyROAt?=
 =?us-ascii?Q?7kAIZoky+bVD503um44c4bsrX8WLwOt4fsSEO5ru1t7TJ9L7aPVlsMEd7Kvn?=
 =?us-ascii?Q?+cmtq3Mny1brMqBWjYJmPVaDeJ4zUJf/8xVr9sdCzAak9c252rM+7C+7vVai?=
 =?us-ascii?Q?lq7jSesT2TArpNK7vsd5xRaZOIwyCP+qX4/tfOOlQPHJUOyiC7RTz1ts/8kb?=
 =?us-ascii?Q?/+M9Tqred8wX4uG91VGYP8jajl51oZpIdf4NCDQORtEnDNTKhLhHilGMEmQu?=
 =?us-ascii?Q?55V8LgDaSXaNHijkeCM5rhmIH4ugy07nFQSrEq7oZXAOjzanO1iI1hemZ/ed?=
 =?us-ascii?Q?V5hKdaq2rnEGakg0wp7eHI+XpYpc7Hdofsc+9Z/3thV0ntvOgggYdauqPLUA?=
 =?us-ascii?Q?vNq8sNb9gZDRx9oBIV/xs1hhi4e4CalV535lQhgYCVtfqqfVV9z6RfQCWZVc?=
 =?us-ascii?Q?hG4Yd0wrhy6zihlB2dQl1ncF0xtsdEW/APAgeXElwRm3vwqNhN8F1Ki36jH3?=
 =?us-ascii?Q?qqYCIBfg0Z58xXO9qgYZNu2VdAnAA0QSXyVcIAe035yvVEIgwg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322c324a-c0c9-420d-5615-08df37618d92
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 15:13:44.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

Prepare iio_format_value for an upcoming patch that adds formats up
to IIO_VAL_DECIMAL64_YOCTO (a scale of 24 digits) by avoiding
computing 10^scale when doing so would overflow, and by avoiding
undefined behavior due to abs(LLONG_MIN) (which couldn't happen
previously).

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/industrialio-core.c | 24 ++++++++++++++++++++----
 include/linux/iio/iio.h         |  3 +++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 767a7794624a..42e92a79d1ee 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -653,6 +653,16 @@ int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
 }
 EXPORT_SYMBOL(iio_read_mount_matrix);
 
+/*
+ * Regular abs(LLONG_MIN) causes signed overflow, which is undefined
+ * behavior. This variant avoids that by performing the computation in an
+ * unsigned type, for which negation is always well-defined.
+ */
+static inline u64 abs_s64_no_overflow(s64 x)
+{
+	return x < 0 ? -(u64)x : (u64)x;
+}
+
 static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 				  int size, const int *vals)
 {
@@ -720,13 +730,19 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 		int scale = type - IIO_VAL_DECIMAL64_BASE;
 		s64 frac;
 
-		tmp2 = div64_s64_rem(iio_val_s64_compose(vals[0], vals[1]),
-				     int_pow(10, scale), &frac);
+		if (scale <= IIO_INTLOG10_S64_MAX) {
+			tmp2 = div64_s64_rem(iio_val_s64_compose(vals[0], vals[1]),
+					     int_pow(10, scale), &frac);
+		} else {
+			tmp2 = 0;
+			frac = iio_val_s64_compose(vals[0], vals[1]);
+		}
+
 		if (tmp2 == 0 && frac < 0)
 			l += sysfs_emit_at(buf, offset, "-");
 
-		l += sysfs_emit_at(buf, offset + l, "%lld.%0*lld", tmp2, scale,
-				   abs(frac));
+		l += sysfs_emit_at(buf, offset + l, "%lld.%0*llu", tmp2, scale,
+				   abs_s64_no_overflow(frac));
 		return l;
 	}
 	default:
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 711c00f67371..7cb72ae282b6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -1132,4 +1132,7 @@ int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
  */
 #define IIO_M_S_2_TO_G(ms2) (((ms2) * 100000ULL + 980665ULL / 2) / 980665ULL)
 
+#define IIO_INTLOG10_S64_MAX 18
+#define IIO_INTLOG10_U64_MAX 19
+
 #endif /* _INDUSTRIAL_IO_H_ */
-- 
2.53.0

