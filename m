Return-Path: <SRS0=iua/=RX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EEC10F05
	for <linux-iio@archiver.kernel.org>; Wed, 20 Mar 2019 14:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E732184E
	for <linux-iio@archiver.kernel.org>; Wed, 20 Mar 2019 14:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="YVvGcCai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCTOxz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:53:55 -0400
Received: from mail-eopbgr780083.outbound.protection.outlook.com ([40.107.78.83]:16565
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728155AbfCTOxz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Mar 2019 10:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Caqpy6mt5/gYmw2qL4VRN3xXv/dF5u4+TLK5nSOlWrw=;
 b=YVvGcCaiPQ/lAskyMcsFDg0cFhdYwikA5qFZFZLGrO0DPyLBNQGgKHwlBEI4pvmtB/CCFVqYpIT4TkBGM3kHjH/iJhV+Ch6AVoAPIvyYExNyX3b8NWqAxMHdBoLBMybN9ZqOnuGK56HVa4PENLBUzptAeNBICiiu7vOVMOlv54M=
Received: from MWHPR03CA0059.namprd03.prod.outlook.com (2603:10b6:301:3b::48)
 by DM2PR03MB557.namprd03.prod.outlook.com (2a01:111:e400:241b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Wed, 20 Mar
 2019 14:53:53 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR03CA0059.outlook.office365.com
 (2603:10b6:301:3b::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Wed, 20 Mar 2019 14:53:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Wed, 20 Mar 2019 14:53:52 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2KErpU4005001
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 20 Mar 2019 07:53:51 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Wed, 20 Mar 2019 10:53:51 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: IIO channel type for status/error flag indicators
Thread-Topic: IIO channel type for status/error flag indicators
Thread-Index: AQHU3yy6U4ZOFSV/8kGchvXXyG7r0A==
Date:   Wed, 20 Mar 2019 14:53:50 +0000
Message-ID: <1553093626.13791.37.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.179]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE49445E0D2DE34ABE2CE6878CCDFA57@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(189003)(199004)(86362001)(4326008)(14454004)(5640700003)(478600001)(106466001)(72206003)(26005)(54906003)(2351001)(316002)(107886003)(8936002)(14444005)(186003)(103116003)(7696005)(476003)(3846002)(8676002)(126002)(246002)(426003)(50466002)(2616005)(486006)(336012)(106002)(23676004)(6116002)(2501003)(2486003)(5660300002)(7636002)(2906002)(6306002)(966005)(36756003)(436003)(6916009)(47776003)(356004)(7736002)(305945005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB557;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f619a506-03bc-4f0d-362f-08d6ad43de5c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:DM2PR03MB557;
X-MS-TrafficTypeDiagnostic: DM2PR03MB557:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM2PR03MB557A6F1C6E7241DC8D577C49D410@DM2PR03MB557.namprd03.prod.outlook.com>
X-Forefront-PRVS: 098291215C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: rSbf+n+Tzwck1p/J9JkARykJErQrURRmRnKT0Wfx2YCr5c4XHQFevod1WqrA3ZcdkXCbDhTHAYaYM7ZMg4K+bOsAydsoLbXlOKDQG5ESWc5rX1NItjUJZ57eVfTil+hQMPPu3A9gA6seQ2BLn619x58DueQ3wBNv46ZEk9HiABx8nI69WeNy3gyCvE7QPW5tVkXUGk6IwTh2d479kZuP9YOrnFhtMl3Q7EtdHDqAVry8y3sPK8KPRfRkqQj7BJpt75G/ZeMhPDJuUzycONRxuxNDrJORHCjpnRAsI3opGho8Y3XyecAQ0nQwWaPKYtJJn5rvd85k64zUmvORBlPCllMcDnxlzJD7oVvsTYx9uQu3WJbBci6wGNeVoecuf2d0mzTvrXw5Y22cAwiDXGTMS8/q1qRohkA2FwGTN5k1SJg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2019 14:53:52.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f619a506-03bc-4f0d-362f-08d6ad43de5c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB557
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGVsbG8sDQoNCldlIGFyZSBjdXJyZW50bHkgd29ya2luZyBvbiBhIG5ldyBhZGlzMTY0OTUgSU1V
IGRyaXZlciB3aGljaCBpcyBhbiB1cGdyYWRlDQpmcm9tIHRoZSBhZGlzMTY0ODAgZmFtaWx5OsKg
aHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lDQpudGF0aW9u
L2RhdGEtc2hlZXRzL0FESVMxNjQ5NS5wZGYuDQoNClRoaXMgbmV3IGNoaXAgc3VwcG9ydHMgYSBm
ZWF0dXJlIGNhbGxlZCAiQnVyc3QgUmVhZCBGdW5jdGlvbiIgKHBhZ2UgMTMgaW4NCnRoZSBkYXRh
c2hlZXQpLiBUaGUgYnVyc3QgcmVhZCBmdW5jdGlvbiAoQlJGKSBwcm92aWRlcyBhIG1ldGhvZCBm
b3IgcmVhZGluZw0KYSBiYXRjaCBvZiBkYXRhIChzdGF0dXMsIHRlbXBlcmF0dXJlLCBneXJvc2Nv
cGVzLCBhY2NlbGVyb21ldGVycywgdGltZQ0Kc3RhbXAvZGF0YSBjb3VudGVyLCBhbmQgQ1JDIGNv
ZGUpLCB3aGljaCBkb2VzIG5vdCByZXF1aXJlIGEgc3RhbGwNCnRpbWUgYmV0d2VlbiBlYWNoIDE2
LWJpdCBzZWdtZW50IGFuZCBvbmx5IHJlcXVpcmVzIG9uZSBjb21tYW5kDQpvbiB0aGUgRElOIGxp
bmUgdG8gaW5pdGlhdGUuDQoNCk1vc3Qgb2YgdGhlIGRhdGEgcmVhZCBpbiB0aGlzIHdheSBjYW4g
YmUgYXR0cmlidXRlZCB0byBhIHR5cGUgb2YgY2hhbm5lbDrCoA0KSUlPX1RFTVAsIElJT19BTkdM
X1ZFTCwgSUlPX0FDQ0VMLCBldGMuIEhvd2V2ZXIsIHRoZXJlIGlzIG5vIGVxdWl2YWxlbnQgZm9y
DQp0aGUgc3RhdHVzIGFuZCBDUkMuIFRoZSBzdGF0dXMgcmVnaXN0ZXIgcHJvdmlkZXMgdmFyaW91
cyBlcnJvciBmbGFncyBzdWNoDQphcyBzcGkgY29tbXVuaWNhdGlvbiBlcnJvciwgc2Vuc29yIGZh
aWx1cmUsIHN5bmMgZXJyb3IsIGV0YyAoVGFibGUgMTggaW4NCnRoZSBkYXRhc2hlZXQpLiBUaGlz
IGluZm9ybWF0aW9uIHRvZ2V0aGVyIHdpdGggdGhlIENSQyBlcnJvciBzaG91bGQgYmUNCmV4cG9z
ZWQgdG8gdGhlIHVzZXIgc3BhY2UuIFdoYXQgaXMgdGhlIGJlc3Qgd2F5IHRvIGRvIGl0P8KgDQoN
ClRoZSBtb3N0IG9idmlvdXMgd2F5LCBidXQgbm90IG5lY2Vzc2FyaWx5IHRoZSBjb3JyZWN0IG9u
ZSwgd291bGQgYmUgdG8gYWRkDQphIG5ldyBjaGFubmVsIHR5cGUgY2FsbGVkIHNvbWV0aGluZyBs
aWtlIElJT19TVEFUVVMgb3IgSUlPX0ZMQUcuIElzIHRoaXMNCmFjY2VwdGFibGU/DQoNCkEgbW9y
ZSBvciBsZXNzIHNpbWlsYXIgYnVyc3QgcmVhZCBmdW5jdGlvbiBoYXMgYmVlbiBwcmV2aW91c2x5
IGltcGxlbWVudGVkDQphcyBwYXJ0IG9mIHRoZSBhZGlzMTY0MDAgZHJpdmVyLiBBbHRob3VnaCBh
IGJ1cnN0IHJlYWQgd2lsbCBhbHNvIHByb2R1Y2UNCmRpYWdub3N0aWMgc3RhdHVzIGRhdGEsIGl0
IHdhcyBpZ25vcmVkIGluIHRoZSBkcml2ZXIgaW1wbGVtZW50YXRpb24uDQoNCkxvb2tpbmcgZm9y
d2FyZCB0byBhbnkgc3VnZ2VzdGlvbi4NCg0KLVN0ZWZhbg==
