Return-Path: <SRS0=dXrR=P6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36311C282C3
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 09:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D524120854
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 09:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="THGaff6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfAVJIu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:08:50 -0500
Received: from mail-eopbgr700044.outbound.protection.outlook.com ([40.107.70.44]:48736
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbfAVJIu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Jan 2019 04:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0E7J5sgbroGS0xwl0iQLSAw4sbZ95a8y+wXEx3hazI=;
 b=THGaff6vdFUJWOEYnP90k3sNXy3pIFZQQV+l9XwdT2MYLaDJG1YgQxOPthxdXIHn3paiPnckWslt2G24u+36tGtE4BS6Ee75LKhOX9fJsnftMprpd61lwXf7nuvlRFDEasiuZbnjD1qLr/JbTGGg4bKaUU0l70TyOKQuJv6YtF4=
Received: from CY4PR03CA0098.namprd03.prod.outlook.com (2603:10b6:910:4d::39)
 by BN7PR03MB3746.namprd03.prod.outlook.com (2603:10b6:408:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.16; Tue, 22 Jan
 2019 09:05:55 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by CY4PR03CA0098.outlook.office365.com
 (2603:10b6:910:4d::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.16 via Frontend
 Transport; Tue, 22 Jan 2019 09:05:55 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Tue, 22 Jan 2019 09:05:55 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x0M95sqY005267
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 22 Jan 2019 01:05:54 -0800
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 22 Jan 2019 04:05:54 -0500
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "jcrash29.acc@gmail.com" <jcrash29.acc@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Example for buffer-dmaengine?
Thread-Topic: Example for buffer-dmaengine?
Thread-Index: AQHUsc862GwuuO/KTUmuP3Pc8BQXT6W7U42A
Date:   Tue, 22 Jan 2019 09:05:54 +0000
Message-ID: <1548147953.9460.13.camel@analog.com>
References: <CAD8jUXMVgzSEy+LSEkJ1Hk7Td12f+igZ_WOq1eXk6H_-qRB3dQ@mail.gmail.com>
In-Reply-To: <CAD8jUXMVgzSEy+LSEkJ1Hk7Td12f+igZ_WOq1eXk6H_-qRB3dQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.224.122]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <71134F949019E548A772A433B0FEFCCB@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(469094003)(189003)(199004)(53484002)(53754006)(2486003)(2906002)(76176011)(26005)(23676004)(6246003)(7696005)(39060400002)(3480700005)(486006)(103116003)(8676002)(8936002)(336012)(7736002)(7636002)(305945005)(446003)(246002)(186003)(126002)(476003)(2616005)(11346002)(426003)(436003)(106466001)(50466002)(554214002)(6306002)(102836004)(106002)(316002)(478600001)(3846002)(6116002)(72206003)(36756003)(14454004)(356004)(86362001)(966005)(47776003)(229853002)(110136005)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3746;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT004;1:Cuo/O3QGO8+bAFj1QBZB+CwDSCRqULnFKCHf8444XvxDIaOntV7cGDSwVe6NtYHR9V4AvEGmxb/iSOLbK6o7J4JTgURSo4Pc2+nxlROofl8X7pVvXbRsza7so4awH9cP8uzKigV7rZbsTbpgCMB4Cwp0sLr4rSpV3EEw3x+qI1M=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f803ac1a-d83a-42a0-e868-08d68048d127
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:BN7PR03MB3746;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3746;3:f/fVl921HAeI9hMQBOjpv5VAzlY3BKvowEVzkuPM9XkYMfzekT1iYyWXAY750afdvPHDJU/03Rh5gR8ktRTkp1jc2ErUL2cddMbeXIm951QVfgoDYW2DZrA35O28Ld4dwOjspcyA8PFJE+SAKkJ886Z75dVs700QEqrrVM2LOPSLV2pUtXPlV9/4z3SEvbiXzOuYsK6IDTf9H/nIB9vYN7vpcERvlVnTKAtmfO+/fNQOR7SbNKZYLWXjHiUU207+zvcaceaaRYDVeNP/q9XUZfwMTF50jlZ4EVsDih+qCkagVdIRG3hi8TmsPphnHvApZSA8Se+MKzS+9ETAg/f5ITXXmFV5H+hNLsL58nYsqGrgpWFympjXKSJeoipfZwkO;25:Au0dwL8OhYDjThs6ngvn3couDh5zLWh3JSkcOWqzo2S/ZvDBKLdtOyVbnYD0elYRyRdOSDQYJBgO4dz0bT4kmLcn6VMTtXyS1N27dHg1ALk5cLlHSxfc9tFXuR69prF+7GRdGTfhbi97ujMv8s6Gk08ElNIVM3QMKsb3eutIziO/HO22SiOuOh2fh95RFQGnsyZ731IFemsz3O2NWZBTzjx/f2N9uN+2yNKGfY8ZEJ/H7CFy6Z19nNccrHZaFcqE/ukPXp+l18cVzpn1ARsAWuLkbeNPouJbRWJk6VayxtoDDkqg+dp6nLBEoNbK06gdR3lMwszYL9zVe79fvFt6Rg==
X-MS-TrafficTypeDiagnostic: BN7PR03MB3746:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3746;31:8neeLARfey2AvsAhMRFA/yWA3pvit60GOUfF+QY4AFer20aifBkcdhl6xoN/KhNlIBxt5slVwcdUzOEPBddpNolF6hrAq9234066JCMlDCyWwpl46e8BRMv0ch+4i++LfVkgf6v5+CcTtxg7ZOPLDpTaTUMu+TSRMi+Hut5RjmqJMdH/YRjHWePKUfrZY3Ha0Uo02E3wWmozA80JlsdkpYgdM7uooLpacXB85A1n+Ms=;20:5INaF4VoIrPLJkgi81CBuw/jK453md3kXvmFFTleCN5S6xc/JKf+nBrYogX4/jaXVPEVxo/Ibfj7+AuqGdXrLcKn54f7c13bO1TyFItLKR7Hl39gHs+FoigZDTetfCODxHIXLn8XfentFnHBH43OYvFtLNiCDslAYybJ7FZ/Fzv78e7q8fJOECv/RrTBIviMFs4LdOrnZO3EXBMu7kJrqZr+QTcrlKihDmpxDC9Wmp8b0TJThLC1OL5hHd32vzzsWoipCtkrfxCRQFyoqePGlGnyoGrFlK2wu41/4I4wC+breGPkgYe1K+eXBKBJ6KJSnFpSDKe95q57AftpUrbkdCVtSe36Y1tpvHZGiq4XlHNyc2gzaYr9d8xQD/22/eiDRLyAqXTeBOwIrzpD3BbEbS118yOOdaxSM+U2X+YEKLpDpMJkam99wq2eJ9B/FlIn1uI/UdwoQqQ2SbejRINmArttCIBPjjmaHhq9/XH0x3gLbXwlvF10oMytUXUZGcBY
X-Microsoft-Antispam-PRVS: <BN7PR03MB37463660E36F1624E9F8B53C9D980@BN7PR03MB3746.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3746;4:aLp500z0KDsElE6MagU2W4c0THMZuBYC1NlH6M5vpLgN+XsDgOixFFsc60OUTbLCJ5ViIp8a6Y2yl+RIjflZLQeXOaV7RJ4xdXP+eI8mlOtmn2w0luoH6oRjmcipx9cpFDUaPzakWMMELvNXdGAx+soB8QOaOiD2cswDlIds4zWnZNX8fGHnA1H1fDEUq9aVyR3HENNnx2kWp1cSBy7B0bL7iTz5JufYHZ4xd1szqT+mi09y+hXjO5OzypJx/KroKVwjoLswNuznIHqMQyd1f04XHyLo2e86IZD2ZLClgftnEuTgA9pl+p1555vTizke
X-Forefront-PRVS: 0925081676
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjAzTUIzNzQ2OzIzOktBT2Y4dk1RcGZPRVhmN3NweVlsbmg2aTJp?=
 =?utf-8?B?RmhkeHBEQ1B2MnQ2ZVE4cDlFY3ZCL2dFb2J3ejVJekVKam9pMHIyQmV6b0Ew?=
 =?utf-8?B?WjlQNHViQzlCdEtMRnc3b2Q1SGRKcUZndnBlUldkNll5TXdiS3hFNjE2YlJZ?=
 =?utf-8?B?NGQ3TFV2Wm52cnlyKzcvZUF0V3phSitMR2dqQU1lanBpbUZYTGNQUndoZDg3?=
 =?utf-8?B?WUMrSERjZEM3czNjVkp1QnBXUFA5cmpISUZxNEszRW5QMkhhdzFhcFlVM1hY?=
 =?utf-8?B?Y1Y5ZGd6MTVwR2pxUGlmcEVmNE9tN1F0QmNaVjhtS3ord3hiUGhXTWRRekV4?=
 =?utf-8?B?b1E2RXAvYzFZZGgrQ1haUm9aS2NVUmI5M3FFUXRxd1ZpcFhVK201TXE0V0l4?=
 =?utf-8?B?dm16dndoMklnUEZrQzhoNklkdUZSS2U5dHJaVTlnekZlUmZvd2NkUDBRcWlV?=
 =?utf-8?B?cndnTm5HZnl5YmR6dXExc295MVBwNk1KdnFxZ0hyS2ZadjNUd2s5UGtUY3V5?=
 =?utf-8?B?ektEREl1M3Uwb3psTU14a2xzejdJeG5zVVZyZnVpa0QzVGhkcmh4ZlF0KzZK?=
 =?utf-8?B?ZmJOdDRwb3d5eklGZ3lvUExuZlpHQURzdkUwdE1WY3lkSWQrV25XQzhNVmth?=
 =?utf-8?B?MTk0VHBjMVBBaHAyVzVoeEtvUHFZMjFsOFQyU3p2S3l1eUVWMjk4OTAzakZj?=
 =?utf-8?B?c1FHM3ZURHJSRHUvTXJEN3JyWWZjZG9FdGtNVVhFOWw0UDVXNXVtZ0hvVi9F?=
 =?utf-8?B?WThEY0wwQWZtSy84MkxIU0VRdmxwTnV4eGgzWll3QlkvVlZNL2xxSUtNb3Uz?=
 =?utf-8?B?T3lENWlyZUFFR0FKdXgwdWhpbW9teVBRWUNuVzhsemtxVUJwcFBHazlUZDda?=
 =?utf-8?B?TE55Tkg0S3AvOExzNFNEenU1ZkZYakRaaXdVbU5Eb0tkWTVIMmVzZ3RsdWd5?=
 =?utf-8?B?NE9BR3NtOGxRdEZYUmpHY2ZiNDJFZG5nQ2VhbS9JWVgwNHRsYm9scDd4MXVp?=
 =?utf-8?B?YWtIdWYwVUNIaEI1a1h2R21DTDRNUXpjaE5NZzUwSEZybmd1Rm91bE5NOHY3?=
 =?utf-8?B?ZWhMZ0d3TFNsNStwMkZzZ3M3STY2YTJLME13Yi9rOFVYeHFtWEFSWGlwL2VU?=
 =?utf-8?B?SS8xTDZpOFBnU0FBMkdkbVVBRlJwc2FsbUhJZEsrMll2bUpEMkp0L2c4S1Jz?=
 =?utf-8?B?ZkszSk9TR05PbXkvTy9oay94d0Q5bEVySGxjYzcyamd2K2VVQmRSSGpUWXhL?=
 =?utf-8?B?WGRZVnkyeTVZdWk1RjVxMy81L0dVRytPelhVSmZMV3ZldmlRQTBBb3RscXhk?=
 =?utf-8?B?bEJpUmZFTkJnN3pFNEZiY0JlRFRoZ3JtZHZ3RURWYmVXclNSUDkrSE82b1NT?=
 =?utf-8?B?QUFyN3p0K1N4WWZGWHF3Rm5FNUhkQVVQVGZabndSOU5pc0ZXMGJxTlRlWjU3?=
 =?utf-8?B?ZENndFZveGxKSWZ3WDc2YkNGanVWMWxQVXNBWER6QmdaaTJQMkRYSFdHUzcr?=
 =?utf-8?B?UlRRc2lZcXZydkFWVENjMms4NHpBVTZ4ckt6YStVS2NrOGdTbzZRSW50NkNX?=
 =?utf-8?B?QmdNL3hrL2I5eXc0cStlZ0xiVUdReTVXRWRjRG1IeHMrbHlzVVZ0eXExMm9G?=
 =?utf-8?B?d0FCajhKZFNLbmFLOWcrT0FVdXBCbDBwSjhTaS9GVTczWWF5dXJTZ2Y4aTRQ?=
 =?utf-8?Q?lDiAUlWN4kxKWfWHHE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m8yl7H8zF0Do0xihp4z7U01oLAGpnpgv71z8AcMvNW8gFy1YyaTaEVx4o9WTn4tt3EahO3QXa1ffAZs4xHLi1Z1+LsUpckz4TGtpFlhpmsXKsxKflibwDbtnjiVI6UusjRsjGO3QZULW5EgyQU/zoEdG9vRaUcZ+qJVoLw/PsD5VAY6Qp0SjlR07zXmW6ddOpGGiVJHgyWeRHUVkUaE1xxtqdMFzhgPvGjjGw6dSnSOP+6Go198SQ414E+gjIsGqdidYPEXYX4lLekNtxblhPzAuJAn2Uta0bOGVD2z5fPL3PgbJJIylP7qDsixzP/JomrzXIke02CGhjVD3AvhAko9QnEgfCVYB38xP6mpyQbjzfc9FGCcovplJSjbZfGbIWVkBEcIE5Ly3mc0I3iGM8zJPRIvj2Po6TbeQcyG7WLQ=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3746;6:EIf3LkJSIOtFEy/d2r8d/WfmnueTx2fc3ooJuuu83oU7YtN3ZVVHe3WmIEievUBX/0pKfybgR8gBXH5YAM/YRIaL26bHaH08u3zxxDdGSx2WCj5tHfWfZFMQXhQZwiR+ssINcsVfmbEEJtZmVvmyhcIKpb+zmJmbxeHIL8mM6FTwMCNORn35EJLnW0f2Oc75DvmltmFH3eK0fCPjuKVzyC59LPXkPahcu9ILiCRZeux0xzZBUc4ILjwZgD2bNo3OkmRXPoglmocoerI5NlXVFuRlEq0LrWR8IFfJqm7QHKbfLKX6BxRJYPpvuQxTEozZ9CxwR1XN7wx6RjGvbNEkqrVLZ0CB2XyESqzE6guu4bWxkzGLoT6W1BjjtBon/AngoEueArIMlP3Gs5GhnO2gIbTVHgMKE324l64zK7o/tMxM2hy5uKn/cgTAVCAgBdUefYhJozi+IJSFBfDf56uElA==;5:Swt8K1akazMf5k77TOX5mYHLdKHfTm/1DOL/X+PnUFG0C1Q/+xwbY+G4oe9CtdFXgUs63Kf2pblWR16r0qPzJ3WLOjcOH6m7kkm8XU5sUDyPrMUIzwf8mXl/l2aBVG/3sV6Jv9fUKtw767KgI/9JE7OuWXtceyu4R6GJ0DaefnmYsuORgG9bfvawBhuE8Ja4/o6S0CCc2kp1YeULxKVtXw==;7:sOTFvd0NQvPhIbGLxTYclNLGeJi7cB72kmiCgCpE02gvxx5RpIF/Sv+p0QK1gP5ZnW2v5Qslw2CwLXeHNNosFiD+HBljD8Lfcw/Bx2/u5SXwY8LjUB1fz4NN/wLsBjyAY/u9FPvMgxPsO9/RrxxuhQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2019 09:05:55.2214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f803ac1a-d83a-42a0-e868-08d68048d127
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3746
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTHUsIDIwMTktMDEtMjEgYXQgMTY6MjAgLTA1MDAsIENyYXNoIEhvdXNlIHdyb3RlOg0KPiBI
ZWxsbyBldmVyeW9uZSwNCj4gDQo+IChOZXZlciBkb25lIHRoaXMgYmVmb3JlLCBsZXQgbWUga25v
dyBpZiBJIGRvIGFueXRoaW5nIGluY29ycmVjdGx5KS4NCj4gDQo+IEkgYW0gbG9va2luZyBmb3Ig
YSBkdW1teSBleGFtcGxlIG9uIHVzaW5nIHRoZSBpaW8vYnVmZmVyLWRtYWVuZ2luZQ0KPiANCj4g
SSBoYXZlIGZvdW5kIHNldmVyYWwgU0RSIGV4YW1wbGVzIGluIHRoZSBsaW51eC9kcml2ZXIvaWlv
L2FkYy4gSG93ZXZlcg0KPiBJIGFtIHN0cnVnZ2xpbmcgdG8gaW1wbGVtZW50IGEgc2ltcGxlIHZl
cnNpb24gb2YgdGhlbSBteXNlbGYuDQo+IA0KPiBUaGUgbWFpbiByb2FkIGJsb2NrIEkgaGF2ZSBj
dXJyZW50bHkgc2VlbXMgdG8gYmUgYSBkaWZmZXJlbnQgYmV0d2Vlbg0KPiB0aGUgQW5hbG9nRGV2
aWNlc0luYyBnaXRodWIgcHJvamVjdCBhbmQgVG9ydmFsZHMuIFNwZWNpZmljYWxseSB0aGUNCj4g
ZGlmZmVyZW5jZSBpcyBpbsKgwqDigJxsaW51eC9pbmNsdWRlL2xpbnV4L2lpby9idWZmZXItZG1h
ZW5naW5lLmjigJ0uIE9uZQ0KPiB0YWtlcyAyIGFyZ3VtZW50cyBhbmQgdGhlIG90aGVyIDQuDQo+
IA0KPiBBbG9uZyB3aXRoIHRoaXMgd2hlbiBhdHRlbXB0aW5nIHRvIGFkZCBhIG1vZHVsZSB0aGF0
IHVzZXMgZG1hRW5naW5lIEkNCj4gZ2V0IHRoZSBmb2xsb3dpbmcgZG1lc2c6IOKAnFVua25vd24g
c3ltYm9sIGlpb19kbWFlbmdpbmVfYnVmZmVyX2FsbG9j4oCdDQo+IA0KPiBBbSBJIG1pc3Npbmcg
c29tZXRoaW5nIHN0dXBpZD8NCj4gQW0gSSB1c2luZyBhbiBvYnNvbGV0ZSBmdW5jdGlvbmFsaXR5
Pw0KPiBTaG91bGQgSSBiZSB1c2luZyBpaW8va2ZpZm9fYnVmLmg/DQo+IA0KPiBUaGFua3MgZXZl
cnlvbmUsDQo+IA0KPiBKb2huDQoNCkhlbGxvIEpvaG4sDQoNCkhlcmUncyBhbiBleGFtcGxlIHdo
aWNoIHVzZXMgdGhlIGJ1ZmZlci1kbWFlbmdpbmUsIHdoaWNoIGlzIGFzIHNpbXBsZSBhcyBpdA0K
Z2V0czrCoGh0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4L2Jsb2IvbWFz
dGVyL2RyaXZlcnMvaWlvL2FkYw0KL2FkNzc2OC5jLg0KDQpVbmZvcnR1bmF0ZWx5LCBpdCdzIG5v
dCB1cHN0cmVhbSwgbWFpbmx5IGZvciB0aGUgcmVhc29ucyB5b3UgaGF2ZSBwb2ludGVkDQpvdXQg
YWJvdmUuIFRoZXJlIGlzIGEgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBBbmFsb2cgRGV2aWNlcyBi
dWZmZXItDQpkbWFlbmdpbmUgYW5kIHRoZSB1cHN0cmVhbSB2ZXJzaW9uLg0KSSBob3BlIHRoaXMg
aGVscHMuDQoNCi1TdGVmYW4=
