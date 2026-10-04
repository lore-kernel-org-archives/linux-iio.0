Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011013.outbound.protection.outlook.com [40.107.74.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4254746AD;
	Sun,  4 Oct 2026 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136151; cv=fail; b=EFV1dpRZhHRG+CZx6rbjViv47gHOKX8cSRyx1VbATvMwyN1MFeoxW5UYSJ8MNiEoYgTZ/coXijVdvEYo+rj4UVaSEbYDnVBytYJrjo/0YrT72pNUvzU4jzfaRYgJDXi2bQ55UOsowBsSBB51JtJ0gPs1FB7aBU/gL+Ptuww9gnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136151; c=relaxed/simple;
	bh=JOakgJqaKfFQDzTvGgWJ2MIAia5OFSBu770CuusAipM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBJTrORp7QdwuN/el5+039kZS+qKBvOKYTpd9A2Jb9l6i6Q6yBhP9Ac0eynwdUPAAzZuTfXAAD9EN8BOGNCqGQIrMHFV+PKmyyH5clygZ9NJRwlF2/lDkVAaXzExksy40BaYjshsXRIAvCXksKyV4Uv9F1g5Ef8cZyeHJAEI5Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=N5kxhrBd; arc=fail smtp.client-ip=40.107.74.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="N5kxhrBd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8+BmMy2oSztLI1GMLIqywIp+NVp5QU0uTmE45v79R6LLwTwBG/s+ETiwgUaifV72mUj8YkMwAPY3bxNAHfBliZSZRiCpeZOvkUbpmjTlhW/R3cealET5xLN2R8zGWPvsZubSVjSZgqqiElpgfL/k0lfYGzUgHOG7CJDwC7FyT980VuBjl0PGvmJWfvebNYX4236PjJ/czesaQE+vO9uP2MV4QIa6C0ON0bCdyNJWVEONAH6EW3M6oELTamgrOTPVhvBn6Nl6QU7Ny4Cp8VYJI4GEflQV/JhZIfqXIz7bIi4H7dr4vskyv6TGFSa8lL3KupwD+/pqSugUbTKqLjmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oojy5SoFnMl0Jf8UE64ruVMGIA1QnLjGTungqyPcMBE=;
 b=YTVpRGzxf9xtIqfWNXHpTooSPTRVWWQykJMrB2UysakMlcDVTotNgMcZMmqCXPFDTFXGhFHi/0upwaQwAUNiplNXzYyw1jaq8xGw54UWQWTQG7KF4Ilu6EcaYIyTQmaGVlzaPXwwsWk4rQdjoO2HqwkLCyEmL5qKxbgdpHkHBJKAG//eoQDYCWFbthVd/PXTYiMmfttKjCMLbu2sz5fR0bd9zFXMb/0EWCj8wIMStqogixN2+Dzv0pc5eMt8WQGkE8l0VLV099Swm5h6tGaulRHGoe0BTcMq7KYOKZ83wiJ7CArFSfK4LukVUeHywjIAaLx2EkVkG37JMjW0HFmVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oojy5SoFnMl0Jf8UE64ruVMGIA1QnLjGTungqyPcMBE=;
 b=N5kxhrBdfrJlWz4fHskUTveZRR+VSLpagbBAlfSQ0nPxNRS1Lwy0EkMhscJkbN3QBDsUJwOzYLYtbotYH9iQKBn5kOHKwKwXOAWgi0vB/Q5ssKPEwXJQVphafmsxLR61gY2wyLhNnkZ0pYB4E3Id4CcWm6W4V6zh7fD6AjukPvk=
Received: from TY4P301CA0022.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2b1::14)
 by TY4PR01MB14829.jpnprd01.prod.outlook.com (2603:1096:405:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:06 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b1:cafe::9e) by TY4P301CA0022.outlook.office365.com
 (2603:1096:405:2b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:06 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 39BB53000253;
	Mon,  5 Oct 2026 02:49:03 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 05/15] counter: rz-mtu3-cnt: read enable value from cache
Date: Sun,  4 Oct 2026 20:47:42 +0300
Message-ID: <20261004174752.507499-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TY4PR01MB14829:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea773815-9f24-4e1d-b254-08df223fc92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zv6X7ugX+SjuG0g0J1DJ6pVKpZtOdmbQs81AXHLi5BW9jL/fbVa1eE0nPhI2fNCNYmHH5FHUFw14rQLqGg94kXfriYI1fb39Wpu6ql3Uee4EYMHGcDZDT3ZiN2S4a4vGH5CuxPx/yr0E7zla8YF4xd2gfsr6V4cDdJQhOEthdbQle+BeChXS67Umr48eB6Xc/sSr66aN1A+wuJe1PfnYlr0nBh0ri+9BgQLpQxbYTQee/jj8nTbLBPOB6p4SjmF7z47WxSNB1fJiXyhNzTOXK6z22rM12OG14/wP454zFJGHKeqTiAeDXiu11DtbJ4uxLql0vpIq6ety4x15Cu37BMW/jeHZ3cBc+pFYAwmJ+W/1Q+uiXu+IbsL2DJmiZ2FStn+to1oZ/bj/HK9t1SlCabcSCjId0P4yRnEmAkPL+MEjZ0G73/fU8rugWHfM8HFbaoHuMplAYDm/x/iTnIbxOV2FcCcZy7/8D2qUK7rj2WZQIabV+EbxGooov7Y13VAWJrz87RR7RrOYF5lFNGY5WjzxVzvB0TFyWix+eTwWPiYyGsj07RJ8yRb9oAIul/twlU3q8UceG3mwKOx5dh5pbnMRcTT2kNV4692EqoD71RSrVLpdpNrmT5efApz4g85Ov86PqZrH7PZYwVL8IFKWgzgQ2d4DK2nCAZRiXCSLTgBhDQrb3hadRAtpd1cVqyc4qfJytOAbxVgXUJZLBjkL3w==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pJsVFOzmNQYQLxOEY0Ki3iUMJsC/nezMCB78VHZm8mUg6aQDrePISbItxmBKeIQ99NQ1/h6ThsS/JS60A7in0Is/E+VPnkvpjBgmkH0I6n04ef6dNSEJ5/2HlNSIHysQWIpjMkvVy+kB51bsRZqfNNIZ4jmCnAXlI0uxXXDyZJSyeLpm0fogOzLCoxW0jTXBRo+QlGUBWca8Me5FkNFpXbxc4BE3hXx0hy+fxdV8iB4cwrE81rzKpMPG+7BbK5+Wl7NgBSAtGGRj5KEsaVSqvPMpxPpm8JjuwzsEgMzLa08rug6YN0LukepisR9YeOLkHM0NXXSR4wDfngjPlwwVN/nw6Iz/72NJD+jn17UeVEJCBU7JPaV08xuQONOGHtchnlWAaXHOI09Nwa3A4fgyqAn0Vt8hUhheR+lQMLE4JXNlwZb/H3p0oTux+4zWIjxR
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:06.2764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea773815-9f24-4e1d-b254-08df223fc92b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14829

Reading the enable value when PWM is in use returns -EINVAL because of
the checks inside rz_mtu3_lock_if_count_is_enabled(). Reading the enable
value should not be an issue even if PWM on that specific MTU channel is
enabled.

There is no need to check whether the underlying MTU3 channel is enabled
when determining whether a count is enabled, as we have a local
count_is_enabled array containing exactly that information, which cannot
be wrong.

Use the information in the local count_is_enabled array and allow
reading it even if PWM is in use.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index cc64ac363fa0..3e1323d40dbb 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -469,21 +469,10 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 static int rz_mtu3_count_enable_read(struct counter_device *counter,
 				     struct counter_count *count, u8 *enable)
 {
-	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
-	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
-	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
-
-	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
-	if (ret)
-		return ret;
-
-	if (count->id == RZ_MTU3_32_BIT_CH)
-		*enable = rz_mtu3_is_enabled(ch1) && rz_mtu3_is_enabled(ch2);
-	else
-		*enable = rz_mtu3_is_enabled(ch);
 
+	mutex_lock(&priv->lock);
+	*enable = priv->count_is_enabled[count->id];
 	mutex_unlock(&priv->lock);
 
 	return 0;
-- 
2.55.0
