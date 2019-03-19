Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FCFC43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB3D20857
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="gyAz/c76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCSKrJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:47:09 -0400
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:49538
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfCSKrJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Mar 2019 06:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is5kpzx7ZWfHXxO5/RIsLiT6u7Z6IJHiTwIqtjRbfAs=;
 b=gyAz/c7657KTi0T6GxFWQzcmtbJFW141R9CjKlGkt5yEPg0AiStwwUbvGySf7QMkYDa6gAwBugS+U9DnbyYlOzrEGwmfvIgGsxs+cPyvoTDwJAOpPe2dfoNndKUKllvMJuwgs+3dBiqkwOlCM8AphdSjeaQEOJme7u0JIm8Xw/0=
Received: from BYAPR03CA0031.namprd03.prod.outlook.com (2603:10b6:a02:a8::44)
 by CY4PR03MB3127.namprd03.prod.outlook.com (2603:10b6:910:53::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 10:47:04 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BYAPR03CA0031.outlook.office365.com
 (2603:10b6:a02:a8::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 10:47:04 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 10:47:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2JAl3FK022092
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2019 03:47:03 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 06:47:03 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: ad_sigma_delta: select channel when reading register
Date:   Tue, 19 Mar 2019 12:47:00 +0200
Message-ID: <20190319104700.28357-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(189003)(199004)(107886003)(336012)(6916009)(53416004)(4326008)(5660300002)(16586007)(14444005)(426003)(54906003)(106466001)(2351001)(106002)(8936002)(186003)(316002)(51416003)(48376002)(7696005)(77096007)(246002)(8676002)(26005)(2906002)(50466002)(50226002)(356004)(478600001)(44832011)(305945005)(86362001)(476003)(7636002)(47776003)(126002)(36756003)(486006)(2616005)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3127;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6c171d-5145-419c-6222-08d6ac583979
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR03MB3127;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3127:
X-Microsoft-Antispam-PRVS: <CY4PR03MB31274E55F2B64F6E5859D39FF9400@CY4PR03MB3127.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lQXcGuCZQ1Mvkh/4Y2amEg3zO6/gmHFA/qposaCkEbN6/Wqvr1H1vBpztzuzI28fI1nyykHpExTUBCA/uIlZsbckikAKHPJO08iSqUMUXzZMs3yeKbocXq94uE6BY7afc0P/5Kg6W4zqZIbNyaF9u+J5cMz6DrLP9Qh8UkOfG2WDFVW3zKpW6FFULSZVYmyanUkGWSkWmy5CAYGxlzY4sqRFXBnZ6Gz3o7spp86qSDqKgHZApGU7j8lMjEf7VQz0FyihBVeAKj/M+iz+9g2z2YfNcyDxnmMXLqEOY36RkimSdf59fpqdx5gXIXswLHt7NnVUeVGwHZ/a+LFGQY4dVMtK+HuhfgNO4P/yKxvbIQZHzd/jjHuOrCSeVJY4H6eDAgFpDhMv0HmjCpYgkPkYk+GoBfsFLTS9LClO2i7ZyCY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 10:47:03.9888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6c171d-5145-419c-6222-08d6ac583979
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

The desired channel has to be selected in order to correctly fill the
buffer with the corresponding data.
The `ad_sd_write_reg()` already does this, but for the
`ad_sd_read_reg_raw()` this was omitted.

Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ff5f2da2e1b1..54d9978b2740 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -121,6 +121,7 @@ static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 	if (sigma_delta->info->has_registers) {
 		data[0] = reg << sigma_delta->info->addr_shift;
 		data[0] |= sigma_delta->info->read_mask;
+		data[0] |= sigma_delta->comm;
 		spi_message_add_tail(&t[0], &m);
 	}
 	spi_message_add_tail(&t[1], &m);
-- 
2.17.1

