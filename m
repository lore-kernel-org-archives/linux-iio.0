Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B285C4360F
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CE42086D
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="UFV/9PiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfBTPLq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:11:46 -0500
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:26944
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfBTPLp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 10:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npdlDahGz0KDmm5iOE+xwHD5DkNyAM37ohmIrOQGax4=;
 b=UFV/9PiQIWd+ic/msiilK0DZJw2Fxdd9bmimfs2AwFma/mwjeQaTY8J7d/w7R5Ut+pP4VRw6kjsBOxGtNh1lFUIhxNpgPHfPymQ9eWPcd1FhWb3VrNQ6Nb68vCXJCKd7Nh08ODaTfhd19S7wyGoyxEv7PvCtcaFgp2iIAgrg5Ec=
Received: from BYAPR03CA0028.namprd03.prod.outlook.com (2603:10b6:a02:a8::41)
 by CY4PR03MB3061.namprd03.prod.outlook.com (2603:10b6:910:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19; Wed, 20 Feb
 2019 15:11:36 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BYAPR03CA0028.outlook.office365.com
 (2603:10b6:a02:a8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 20 Feb 2019 15:11:36 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 20 Feb 2019 15:11:35 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1KFBZol014804
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 20 Feb 2019 07:11:35 -0800
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 10:11:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [V2 PATCH] iio: Fix scan mask selection
Date:   Wed, 20 Feb 2019 17:11:32 +0200
Message-ID: <20190220151132.10791-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(54534003)(189003)(199004)(246002)(51416003)(106466001)(316002)(107886003)(7696005)(426003)(48376002)(4326008)(478600001)(7636002)(72206003)(53416004)(126002)(50466002)(2616005)(36756003)(336012)(486006)(47776003)(50226002)(8936002)(44832011)(110136005)(26005)(305945005)(77096007)(8676002)(186003)(1076003)(356004)(54906003)(106002)(16586007)(2906002)(476003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3061;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15be81a8-9434-46f0-5ea7-08d69745b4d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR03MB3061;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3061:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3061;20:8d4mQOyyb81crLkifgNImJeFD3BMzp1CDDx7YUTq2PjDSZxeIzKLuVHhYFUu6fvd2+JyyZ/MI5JgN/e2QWQ73atMCnix0GQ6fWSCILyE4xKyykdgI4Q8qubIHk4WMWGHGlYwu0tgu7xfQx4zVWocd3y1LWQEYWYMWBgQdmreEiRB7rnD9aQ3o+LiSbdBOV2PRPOKzkYsB84cvPf+N4NSDqpeS/EgrOjLTK8GRYI9oumrFLPhngVNTy6Fi+XDzQQcJSqU60tzVNtT96uHr9Tk48r0vwcx5eCRR+fuJMhbcZsM+X+A3lxMifiA9Q/L2Hq/vl58gyhD4iRH5WSoWycEY9PtFkjPR0ZJ+OFMHOpynTfXXQqSUastqcCoxL1pGYFgITIYN0oPsYUpMmaDA3IdbktzqIGdNzL4NodHveoUutT9BsQT622QUF3PnzTBH1vQl/Nrryc/vdj5ZWnxWm3E65EiKvtdK5A96vVggMg+2ybhurEwO8tHiZHt/WAQ6sZp
X-Microsoft-Antispam-PRVS: <CY4PR03MB3061AE25CEC42EBE4ECD5813957D0@CY4PR03MB3061.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0954EE4910
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3061;23:qojZj6up+haP44j27XRgV4Tl9OaP1mVVltsTwI0Ky?=
 =?us-ascii?Q?m/mhgR+HBXfPthIi00q1Lk68TeAak9vVqSc3ZAh0lS6S4u2P3U2pzLX2+8NB?=
 =?us-ascii?Q?mP7fWG5hczq4hXsbsKOiOrZBm5AEruEt9I9OQ5piHPRSeODYtmwGr/YIj28d?=
 =?us-ascii?Q?S9b9Y6/S63mzm6QvUQDiQoV6TQ54SdZX3LhEZc/q5RQH+AsZ9jy/6Tx6Sswe?=
 =?us-ascii?Q?qwEUC/ObzXrOdkmcjmWYNbaeMAWMBNeF8laPSUBws04dyBfYIUIEol7DGXT6?=
 =?us-ascii?Q?wcKxotaGDrm1C6MPt0gJfG4MFkcvO7z7DwCJOYlCd0joX7B0zR6YjscFUPYV?=
 =?us-ascii?Q?+wawU3Er0a9OMj1fuAPukzvDLNZwWb6hBcxCsntOyA2m5rUpkSt2wma2rq93?=
 =?us-ascii?Q?fUiSOIVweDheR/kxa4XTorqcknN5Ti08bClJMFNUAFbPTMxXlXBTUJOWqkr2?=
 =?us-ascii?Q?n3MK3PFFhbBgOrtaGM/otEil+YOSXnT+rbImp4MDthlsNN4yDnUn4a7JJQVt?=
 =?us-ascii?Q?n7VQhCB70YAr2hVw5MwLrI3VaTuSBgaM8IenOYUehRosWalWvbCeclLgYVMo?=
 =?us-ascii?Q?qqysbl7YYP05jD0b9FeKFKAfQJHIuyZSuoUvvH80EP898RCBjgu/ndZZcYvn?=
 =?us-ascii?Q?X0BQNwt7qP88qIhqQbUhg9M0Q/IqAsewQ1MxMoKPSwSPsLvhaHzvLZLJvZZ+?=
 =?us-ascii?Q?CeLErfzOQZaREdJPQuvSFlI2eFZ5NVNzpQ2D9MStXRtkTls6kB77onJ7gg5p?=
 =?us-ascii?Q?x7Zy1P1nWZV6zhgbt76z89er2lAbxQq+W7Lpw3CSgH3lLqfVan3uNr3OMT9O?=
 =?us-ascii?Q?KRy1xYyey1tZbMUNRucqPGYGQsQhjd4TC5WyAKzECC6cH1WuC2iujd4rAFZO?=
 =?us-ascii?Q?zfvqIrpi1xP6lEwv/I2rM+MwY8KxR1VZtByQbQgjfQPGJkUzcNe7TArhZFAF?=
 =?us-ascii?Q?FtuH2AYI/M51KYgqPkoluI0JHkF9pUZ7rl+xHyumCNqDAJ+17PWcKF7y8QT/?=
 =?us-ascii?Q?M1dDXCK/13F3KrwnDziQMNm++dUc6kPGAc0QAHmKNdCxw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RvNzskoLBrhxIHCSM1y7if4JEOnkMJkkblwT+NpdDH1X3PI65A9tcG/44zb73FLNEYKXg8NCbaLvPYM0JF+og6FWN3CWsqMuV6Ld2LtvV1dCs5HjwdNF0ZOLkWxQ5CKvodkySCAU/PPpGFHLap+J36vWTIPtPJ6s3zvEq8QZqocN0JOQvb5FA2giUum8jEyWKpOwEcyAiZ6zWq+38OzWfVlz+Kt8ezDSAk+Smxw9nQgiSK7koJiEYRn7BwMhTR/C3FDv8/bWuANWjJRzW8ieuCy8u5J/6h1EezofZEYMp4IrruDxksA4phyUMd61oM9xrp/rq1CEynd7RnUSsKjewH4nhMrKV/eou2clXuFsjeIE4noi0La3fXytCBBOKh/8qsR7th7Vtk6jQHkFItdxhdrIGJtl6PZIkJXdasSozwk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2019 15:11:35.8593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15be81a8-9434-46f0-5ea7-08d69745b4d0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3061
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Fixes commit 057ac1acdfc4 ("iio: Use kmalloc_array() in
iio_scan_mask_set()").

The trialmask is expected to have all bits set to 0 after allocation.
Currently kmalloc_array() is used which does not zero the memory and so
random bits are set. This results in random channels being enabled when
they shouldn't. Replace kmalloc_array() with kcalloc() which has the same
interface but zeros the memory.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog V1->V2:
* added `Fixes commit 057ac1acdfc4 ("iio: Use kmalloc_array() in
  iio_scan_mask_set()").` comment

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

