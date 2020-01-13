Return-Path: <SRS0=tKUa=3C=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220CBC33CAD
	for <linux-iio@archiver.kernel.org>; Mon, 13 Jan 2020 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF63F2081E
	for <linux-iio@archiver.kernel.org>; Mon, 13 Jan 2020 13:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TGNjHycr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMNP6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:15:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59818 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbgAMNP6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 08:15:58 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DDCaGo007821;
        Mon, 13 Jan 2020 14:15:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=O+MJ9qBjNJqJgFNGVwTg0BXY0E/KsooKUuDgdHOTWEQ=;
 b=TGNjHycrAY30719TczLelyFBJzsNKGpS/wbYvNgDeX1YVwBQKnPHlgN6sH87SAFIsgup
 bz1E2ZHRnnqxb0BhBht6Cmzj6rOMkiKGOm+DKfWYV5+8Rxbk2DJjLJG2YR8xh21cOVH3
 j9d4x/iRjzFv176f12F4qUN4wqjlQ4aFxmYkK5H38nvLvVz7KAM158EYZz/pw3NjZgVV
 bAJWMdWgsc8cEJBOYgQgAv5RTwalczpUtJeuXnTjyiwA8y/3ju8uf/fcU2Ypd06buhQC
 NHVlWEIZtE/Bf88PFcYDxVaUBY51tjD6N/mc9nS1J661WokJTaEKtlxhcHPSgzYoV6Dv 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf7jp85wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 14:15:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 64FAA10002A;
        Mon, 13 Jan 2020 14:15:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51D7F2B8211;
        Mon, 13 Jan 2020 14:15:33 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan 2020 14:15:32
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <etienne.carriere@st.com>
Subject: [PATCH 0/2] iio: dac: stm32-dac: improve reset controller use
Date:   Mon, 13 Jan 2020 14:14:24 +0100
Message-ID: <1578921266-6025-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_03:2020-01-13,2020-01-13 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series does some cleanup on driver private struct (precursor patch).
Then it better uses the reset controller API to propagate errors to the caller.

Etienne Carriere (2):
  iio: dac: stm32-dac: use reset controller only at probe time
  iio: dac: stm32-dac: better handle reset controller failures

 drivers/iio/dac/stm32-dac-core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.7.4

