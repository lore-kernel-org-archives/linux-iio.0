Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C883C2D0E4
	for <linux-iio@archiver.kernel.org>; Fri, 27 Nov 2020 09:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FF121973
	for <linux-iio@archiver.kernel.org>; Fri, 27 Nov 2020 09:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgK0Jkz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 27 Nov 2020 04:40:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54760 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728865AbgK0Jky (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 04:40:54 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AR9PN7S032714;
        Fri, 27 Nov 2020 04:40:51 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y08varpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 04:40:51 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AR9eorh046023
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 27 Nov 2020 04:40:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 27 Nov
 2020 04:40:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 27 Nov 2020 04:40:48 -0500
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AR9ej6n019064;
        Fri, 27 Nov 2020 04:40:47 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <colin.king@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] iio: adc: ad7298: check regulator for null in ad7298_get_ref_voltage()
Date:   Fri, 27 Nov 2020 11:40:38 +0200
Message-ID: <20201127094038.91714-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127094038.91714-1-alexandru.ardelean@analog.com>
References: <20201127094038.91714-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_05:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=983
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270058
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

'st->ext_ref' & 'st->reg' are both non-zero/non-null at the same time, so
logically the code isn't broken.
But it is more correct to check that 'st->reg' is non-null, since we make
sure that the regulator is NULL (in probe) in case one isn't defined.

Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index ecdb01bd5b2f..689ecd5dd563 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -214,7 +214,7 @@ static int ad7298_get_ref_voltage(struct ad7298_state *st)
 {
 	int vref;
 
-	if (st->ext_ref) {
+	if (st->reg) {
 		vref = regulator_get_voltage(st->reg);
 		if (vref < 0)
 			return vref;
-- 
2.27.0

