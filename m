Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37D4C282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 09:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF022075C
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 09:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iRMU1a0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBIJEa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:04:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41074 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfBIJE3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2019 04:04:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x198wiZL141927;
        Sat, 9 Feb 2019 09:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=+uARhowKqnNoU+kHBw7ON2mrOb3+CtHRtiY55ghYQqw=;
 b=iRMU1a0stwwZpsg3Upu99bPQBLGMmL6wwQxHeYqfKv6TVB/kz7OmmvnunZhuHNYx8mxQ
 g9OJ1kFrlxupyj2TuI9Z06DgpsUpevELUxxqKiOy1PZ48GMUffE9A7fXAf7ceAl9ExtL
 DaYk7jiVOSPmwQkWPwxe54hIROIeo40tzzHEzuCMIsaqf6qKKgKrLclfQaCy0msjrwb6
 IZ+5y3Ete9YzNy6rSC2V9cofQxjlM/2UUDTQ9AtTx7Pgtg31QamcUulVgtpm8c467gTR
 ZEL1TUOfh5tYl+SlTo8vcDkFjK9HitBkLwzKjAat75W7T4TmCZ6k2snsVBystITCos/X Wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qhre50808-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Feb 2019 09:04:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x199415E005349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Feb 2019 09:04:02 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x19941p1021672;
        Sat, 9 Feb 2019 09:04:01 GMT
Received: from kadam (/197.157.0.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 09 Feb 2019 01:04:00 -0800
Date:   Sat, 9 Feb 2019 12:03:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: chemical: sps30: fix a loop timeout test
Message-ID: <20190209090350.GD4865@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902090067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The "while (tries--) {" loop is a postop so it exits with "tries" set
to -1.

Fixes: 232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sensor")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/chemical/sps30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index e03a28a67146..375df5060ed5 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -210,7 +210,7 @@ static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
 		msleep_interruptible(300);
 	}
 
-	if (!tries)
+	if (tries == -1)
 		return -ETIMEDOUT;
 
 	ret = sps30_do_cmd(state, SPS30_READ_DATA, tmp, sizeof(int) * size);
-- 
2.17.1

