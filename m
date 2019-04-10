Return-Path: <SRS0=8vNk=SM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA437C10F11
	for <linux-iio@archiver.kernel.org>; Wed, 10 Apr 2019 11:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854702083E
	for <linux-iio@archiver.kernel.org>; Wed, 10 Apr 2019 11:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Agh/X0Yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfDJLbP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:31:15 -0400
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:14662
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727206AbfDJLbO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Apr 2019 07:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+KlqyxNNPd8Ey11dyfqNWTRZ0xOTlEwxw3V43gVTcM=;
 b=Agh/X0Yb8yHwmigLjYzanGObsig92oxhU4e67QJ8AN+IaNAZzyjX0/Vfr64zy0riBf7kRRoZb5KIrzsKk46m8ls8TzYWnoKKk0Z3HO2F5KRsfZysEX4Etb/zxOydvWLvySXBKPJJjBrUH5LW/y5xRM2Xai5Zq2X2VkfERE0qhOU=
Received: from MWHPR03CA0006.namprd03.prod.outlook.com (2603:10b6:300:117::16)
 by BN3PR03MB2258.namprd03.prod.outlook.com (2a01:111:e400:7bbf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.21; Wed, 10 Apr
 2019 11:31:12 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR03CA0006.outlook.office365.com
 (2603:10b6:300:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.15 via Frontend
 Transport; Wed, 10 Apr 2019 11:31:12 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Wed, 10 Apr 2019 11:31:11 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x3ABVAR9001218
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 10 Apr 2019 04:31:10 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Wed, 10 Apr 2019 07:31:10 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: [RFC] iio: Handle enumerated properties with gaps
Thread-Topic: [RFC] iio: Handle enumerated properties with gaps
Thread-Index: AQHU75DlQso04nH4EkywVo3BpTedAw==
Date:   Wed, 10 Apr 2019 11:31:09 +0000
Message-ID: <6bbbf2db5985ba9943571876ea72ee9762ccbc2a.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6432D7B2CE57C0419F4E7C9045162390@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(199004)(189003)(8936002)(50466002)(26005)(356004)(102836004)(86362001)(23676004)(246002)(2486003)(5640700003)(6116002)(3846002)(6916009)(8676002)(47776003)(5660300002)(186003)(558084003)(106002)(7696005)(36756003)(2616005)(426003)(436003)(126002)(106466001)(336012)(966005)(2351001)(478600001)(476003)(2501003)(54906003)(316002)(7636002)(4326008)(2906002)(6306002)(305945005)(14454004)(486006)(7736002)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e973c04-ad52-4760-804a-08d6bda808ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BN3PR03MB2258;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN3PR03MB2258338747913FDA9DDEEFE0F92E0@BN3PR03MB2258.namprd03.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wJZGPT0W91ywsl1C0c+XN1yHnApZM/WUtk49AkhHGplLWhgV/3JmnJO3t42lIi5NqN13gq+9Dw41f/YX7xmMR77e+sDzQ2TTPNm4Klz+PNcR31aLDjDU1QAZ+ZULU7xbbDY3awjHRA0Q+ACtfDhMp7taOp8YyFUHJKmHjbYMbkgUIJmQo54KZRqnqlshiQWzo01uB5hJ4tFHr/2wBdVLeBh8ySoos89RDHg5/Ozqc2rMlFjc/UuluHljGoeedPuDpojEik2YhwAzauiU+sYAjJWf3aIGYp4vl0eTvVaib9WpmrNGwvZ3arTLvy8oRQ0+wvYOwBSXQUXoUy4MW+GQheVVulxxmckBlSaQSY6T1wYm6LvUclpTLlRTgpjIT9yuZmXV2SNsRbYGfi4ezK0lJbT+WDoYU1LA+3udleH6bvE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 11:31:11.5737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e973c04-ad52-4760-804a-08d6bda808ce
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGV5LA0KDQpMYXJzIHNlbnQgdGhpcyBwYXRjaCBhIHdoaWxlIGFnby4NCmh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTAwOTc5MTMvDQoNCkknZCBsaWtlIHRvIHBpY2sgdXAgdGhl
IGRpc2N1c3Npb24uDQoNCkFueSB0aG91Z2h0cy9pbnB1dC9zdWdnZXN0aW9ucyA/DQoNClRoYW5r
cw0KQWxleA0K
