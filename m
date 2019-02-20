Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6F3C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7921E2075C
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 14:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="o1wFYMr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfBTOOd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:14:33 -0500
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:43648
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfBTOOc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 09:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3/C4z+/3UxWP1FKNernIKKLja+SuA47A3x7psmZgIU=;
 b=o1wFYMr1t86lR4ibtK6gcx4xYGBLLG3Kt0LrpLta5eW6CUoMUQ7ZM4QAq9yqQ4RDiRLQbwJUYs8WurNYWtDhRUbWEsH4pIDfEUE8rxew5fx9gS/WU+EzXoT84s1vx6BcpsDqfA1uTlqp3yx6k3Kcpnopt9OHihiMDo3YkTO7WoQ=
Received: from MWHPR03CA0032.namprd03.prod.outlook.com (2603:10b6:301:3b::21)
 by BN7PR03MB3507.namprd03.prod.outlook.com (2603:10b6:406:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.18; Wed, 20 Feb
 2019 14:14:28 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by MWHPR03CA0032.outlook.office365.com
 (2603:10b6:301:3b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.15 via Frontend
 Transport; Wed, 20 Feb 2019 14:14:28 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 20 Feb 2019 14:14:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1KEERnV025484
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 20 Feb 2019 06:14:27 -0800
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 09:14:26 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: Fix scan mask selection
Date:   Wed, 20 Feb 2019 16:14:03 +0200
Message-ID: <20190220141403.11571-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(2980300002)(199004)(189003)(48376002)(50466002)(426003)(336012)(126002)(486006)(476003)(2616005)(50226002)(44832011)(7636002)(305945005)(246002)(2906002)(107886003)(8676002)(4326008)(8936002)(478600001)(72206003)(54906003)(356004)(6666004)(77096007)(53416004)(1076003)(7696005)(51416003)(106466001)(110136005)(186003)(316002)(16586007)(5660300002)(36756003)(26005)(106002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3507;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49ea940a-2bb3-4159-93f2-08d6973db998
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN7PR03MB3507;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3507:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3507;20:kcV+vBmh35r84fwFffG6sYx3yZ90iDZ7mPRQtALLvTjW9rrHYZbhGZeSBgdotY+aAXxiU56SVKbQ3u6Yst7yGOoqhqEwJ2Rv0nsl+jk2I3S8VxyY7dlM50LNR+LqqIYXcL0m2q0/rKuP8kB18oQCFiJFd/520yJIGT+f8OdikDY7yHz9+95SFI6+yHu4Fg43wAA7c3iDw1FOZ09ikaTHhMRVj9voDtwZ6KWX/tO4ozsLmrISmafXxZpmwd3fM3US0co+MOT8wUxv8Sz26oqLKG28G6As7VPTImoBryqHLewxzrJZPFGOegq9twifANRWdKLlc5WrIWs4aof+1v/V9TJt9qO4j6rhTtgTOdh85kvNSLLbAaKbpZOsiMPkzjF6FbZ4kvxmWayigtdod9DvWpZ1mD1O0OASbqYgtYNrxXcqY0eNhc6RkX7zR2dJM3nDknp50dMz6RyLO9bolJPV35rf8cu6dJB7EbzkdbYPFvG08HCyOoJUys5yxpyReDOr
X-Microsoft-Antispam-PRVS: <BN7PR03MB35070F19C78A46D478C55801957D0@BN7PR03MB3507.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0954EE4910
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3507;23:wvzbKYxrSVNvqmwvuq+4sFGOziWKwWj9Cod1tzWMQ?=
 =?us-ascii?Q?NU/gqYv4dmIkToFtFEMZEjY9tooG/TTzVh99os30zEhb+cFU2AXuTiFfvnqM?=
 =?us-ascii?Q?QHcc2tC1Pj3dJi2VgoChsCWG+MFTbjYutMPugrXZr15oC6seuA4Wicjs2h93?=
 =?us-ascii?Q?uvQOqGn3Qerj4TSREh2wK1JVs5wTsTwc3qhCpUQgnE4EoayKnkH4quaiRP2f?=
 =?us-ascii?Q?G80upsmR2bZYIyK/TiHR/rVo95GCx6MWXDuZQMPZSIE3QvOSl+VUqIFXCl42?=
 =?us-ascii?Q?fG6ONVii/llC2xL7oEUG6zdi5LFp1oWx0nrI2VUlVVf3/2+pYqM532EEi6nc?=
 =?us-ascii?Q?obQ4SHgrcLJd3sBj/AIETGtqdpccT6sGgYdvrIQYZNrljZnhcQUol+rLWbwC?=
 =?us-ascii?Q?01Nk8gaBmEFz6R3zOG1IFnhlz65f4uzTbcZ+nIrTOUrWAXyZwDhQRE6MYiph?=
 =?us-ascii?Q?o54D6f1abENL1nnNTyIDh8eXTilwiu+RB9gOOdFy/mpqhnZNMESTNB4OQsMn?=
 =?us-ascii?Q?rzFdw8pVX9W8qBCfZSMuSASveg1kMCMYkamKLV0dZoIbEtcfsDUHEyUFLe6y?=
 =?us-ascii?Q?mLCpWLiaf9Nb4KgwZ/16yi40nhPYS4xNH1urog5SB7OikK88U9kZ1e/vQnMk?=
 =?us-ascii?Q?dSb8pWZxXfruSDCTUhzS8jtFRbxIY2FnmveH85AyORLB3AAJXtr3BvS4kjCv?=
 =?us-ascii?Q?5rLJqyD8YVqyXXTIxTKfdOHOsOSNC4gb5VbFFS1xdIDRWtiAvJX93J1hdc/H?=
 =?us-ascii?Q?JnHUDIsIR2U6qhF3BMoFBnpee0cW20v1NECtlJi9XP08GG+VaTYqjZ9jxiWt?=
 =?us-ascii?Q?eNw3KUmKBO9WLX07RBFq9fRNRDX3AUzmoWu1tyL7+yua5F5HuC35XWucgF2X?=
 =?us-ascii?Q?yp0e1/QhpNKMTVHj6QWcywdosN92RQmdWzg1Ga4Aq6z9sKVsqTOyd72Q+g6V?=
 =?us-ascii?Q?HjWSrgdFOfA/21UXEAf55Awcw5JbaQjUv2TElqKmUgcpEOT+lK1vOMnQWfNJ?=
 =?us-ascii?Q?+C395vMjgBCXdtWLcomHJSNEgQYT5LJq6sjgr2Pve0LHQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BS+376jEqG9CsLt9y+VJP8BWhNNzqc77rO0LzN4rLYWLxdKwxibXpoDSWFbPoQPXfH7qx7glZKVy/ypF/LA/wh+sH1MdW4z02DDLMWw9o4oL9SMHn3RDWDk7PFVKdeNj2C8QShncq4109eK4oAg+7PhKY62UU9aozFpMuZASTpygDYdH4SIGQPiPC4yP6udfd+QEZjlllXVTjqYYOdB0eQERGWd4n6vaBsop/845aBvQurRdZTbvF1O0joxrp5/Y1UkkC7LU7Cm6Adulmlu+UpOlf7/8eAfaAvBYhstqDLo3Hl4A4FhMxTlKXKg7gqlF0T3ufIJ0u5N8/XxqClteRSgLrmQmv+BprIa2aYxkLt6uqYrNothA6FJxiBOQHzVgwf0gOwEx8ZfsHmM9za/zbFUmIvlCihlbxb5ychN5Hu0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2019 14:14:27.9805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ea940a-2bb3-4159-93f2-08d6973db998
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3507
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

The trialmask is expected to have all bits set to 0 after allocation.
Currently kmalloc_array() is used which does not zero the memory and so
random bits are set. This results in random channels being enabled when
they shouldn't. Replace kmalloc_array() with kcalloc() which has the same
interface but zeros the memory.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cd5bfe39591b..dadd921a4a30 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -320,9 +320,8 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	const unsigned long *mask;
 	unsigned long *trialmask;
 
-	trialmask = kmalloc_array(BITS_TO_LONGS(indio_dev->masklength),
-				  sizeof(*trialmask),
-				  GFP_KERNEL);
+	trialmask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
+			    sizeof(*trialmask), GFP_KERNEL);
 	if (trialmask == NULL)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
-- 
2.17.1

