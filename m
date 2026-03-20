Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022089.outbound.protection.outlook.com [52.101.126.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B3283FE3;
	Fri, 20 Mar 2026 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773978081; cv=fail; b=OpFRm7OwStua++0pqqwCyv/8KDY1DYZMuLtNfJUUWEFbpqbrkR4jbtlYr1vMGr3TVLoq64s0eeHGNt3pq1hqbZmQ19W5xWOCWIsSdrnrhhHp5HaFsWsAo6tt8KPOyuiEGszeJl5bqBc9kniDzsk2pnzNvEbiD9rsTKMW19/tZ9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773978081; c=relaxed/simple;
	bh=hsfIpu1t0AwVz+aZX/m5T14wnVmu8sQM6TdbYqtk2Hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NcsTw/gheLCHSiV+o0ZElyleS2VYkHeY6ZOhVFnWohpqkq/ubLjxremS2YX3tf345UjyQJJtaCN38f8UwosO9JgJYFEoq7auBQ9jlwBYeVfqwUnl1cyV1FGNJ/ZnAZWgg4qifpBneJA42EhZS+GQsxHCdIibeSKatsK1iKvTPqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=b9Yi4SK8; arc=fail smtp.client-ip=52.101.126.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="b9Yi4SK8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBva7NuRlnnZpW75X9JQo7Mb+25xrxzvwcu/mlUWJfF4/kPrX+U3P4wq9JO8s9EOfBQR5Xzl5MAb9OI0ulYpPbBuodLUkUTtktr+ShA/C6nSubzsfvTNHhp2ymJpjbD78eQzJ7PdQUVuW6UVrZAp5QtTsUxsNPwYac3d3eqxIIpPDT+sqW0TxugbgBws8X+Lz7bhAZGkGOxyYCrz/i72NSbS09UK4naqViRoWVbDyDg53uruJOVz1c5KP5tRH/TAlQIENc0NZOQw7B47sClV231cOHj2Uxd+KDDNYOkj1qZbxjRiHdMN7hzCItsNb2yVCKGPo0Dz+tRfAxqfSTpdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufqC42t8O7CwcnzDpis8UqpicTXbDg+GqJ2y/7660ts=;
 b=dYHhU6tiGLvLWo/d+EYQi8300fgqNbrhLTkbfGli+VMrgIM/RBvpi4TAzGm6VcQuwOgBH4C9RGY1h1I9iHHRvMo1ikpc7QDjYybULqmHOeaVq7cpxSD9/UvEcKgGO8dv9Hol+o/DQ1apa8forI7MTTJsifylL6IHhaqa8GpkmJTl556r5IfZtbDaK+YTYKDxu58rdjxeVf4oMb4pI3Bd7892CPzoCn1aJTTQOHC9B5nV5zsdYfEV8pprZnhfbtjKZzozE/MOs74dycXTYgS0kiWHuwrqWKfRErwe9kurtX+WNVe/HQOIO9WIZCQYyaX1pCporUHsN++jlfJilX6j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufqC42t8O7CwcnzDpis8UqpicTXbDg+GqJ2y/7660ts=;
 b=b9Yi4SK8Gz95FH0oY1nlXjIiL4mpHXXny3fKd2aqz2Cukp/Ug/3H5ROwiPCXqJShZRaWmHsfxCaev4/oLsPI40yayPn/TkG+Hlfo/4tEyGSkNeC4QQo0HqOT6+0hbQ3UdrA1wpAsmJjMciSuZ+oZ6RsUEdbhly0seI1Icz7oWGnnFUPmRL1Vho8lGNrkLPSidy7thrf6Kj/NkxH32RM2BZppPVGI5q6YsgVFSd8EMRsYDT6tgsDjiI21fNjwj3NYzfUOHijVfSt4LEgFpYxVwnlkTAVgT8cYvIeQphLUmavRQm6AZ34ZToWVPuMq9/4vepl3yzbinmBtd9ATWt0LQQ==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 03:41:17 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%4]) with mapi id 15.20.9700.022; Fri, 20 Mar 2026
 03:41:17 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?Windows-1252?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Morris Mao <morris_mao@aspeedtech.com>
Subject: Re: [PATCH v2 3/3] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Thread-Topic: [PATCH v2 3/3] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Thread-Index: AQHctPEbhVwnR3N2p0WLf7VfGNH5G7WxN/mAgAWSry4=
Date: Fri, 20 Mar 2026 03:41:17 +0000
Message-ID:
 <OSQPR06MB7252EB6B6933E2925EA51FF48B4CA@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
 <20260316-adc-v2-3-21475a217b09@aspeedtech.com>
 <abgTKzfiDPFQJPVo@ashevche-desk.local>
In-Reply-To: <abgTKzfiDPFQJPVo@ashevche-desk.local>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|SEZPR06MB6871:EE_
x-ms-office365-filtering-correlation-id: b1066ac0-0fb0-49e4-09af-08de86328af3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 hM2ZeG7g8EomTyZnS934SSa1I4QcS7q7hqZFSvFQM3TWUqjsOa6MiUzyLV5ZqdV/pqyxdfYfgWQbr/ckjrKrXj4QWjOLVGTzRrKMOKEg34xISupqO1S9xWQVXDlgzEVXgcXiaS5Tt0esZHyPLiQCyQIbrdJOtMaV5Rxy/8LrC26Hgu2SXthCB1Cv3E3f1WlCD1C4EiNgGPR3VTGO71aOSkHe63YCofAIJevEv3LvmLvJyUx1RGUA5q0SzYdUkd2f+k9d4QLcaSmh7DEtLMfH+6tmFBoYdule+j1f6gyKWL/NVR6mWVldSvyLyLBp8nqegn+lRY/0LLujE03r+68AD9E/BpfxoUtAicETSaHOsQE3gmw87CuFAk+VDdohwISZTlWCzYs3HJRI0LE480mnMXV9/h9ApTytGT2ekQ6w+gMsNrWuyuZU5OuxvR3NAHCDh0OTXv0mfqaHJ64gH5HenHmpLkDgvq4sftAKfG73NgMhCjtB3RdnSzI+J8akFv+YVlK+ntly3ql2mqiPo9Ivo+Wwjt/94E9JeMHC5Fjl4orf7UpQrGZXILunbzDcXvi7fOeNxh2ArkpbfvFlmk+r3+NNn9rzr4yqeJRnDpCB/K18Yi4yJpes0V+W6mT7WAa7T7C34myWOBEu76uUSajnnm5KJBqbFNCfAb1rSIhVA7mVqRLINO7qr00HFgQ1g9HGluTg1UQovYZdkx81eTb4zUn6jaNRt0c5Psin75jjhY3l2iuJ5IHYH0z5xB8fkhwDd3rD1+J7D8Dgf92nnwLShkeJDSmqV547hok3on3+svY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?LMegXT7qcvEpRSVWkqcmfiCUber3QplJlHbiB7/Zd1mKIhPQapUNRo6a?=
 =?Windows-1252?Q?uyKeg3pVnsP/xusJPYuJrxfDpBn1S+CpBo0foKJQMeQi8tLZ5OfjdNK7?=
 =?Windows-1252?Q?H8CImAaWcSIE1/4TwUtLTIClsOtIKUyLeYKhQ+DOXDvDqQyWA3Asv2ik?=
 =?Windows-1252?Q?bbUUX2fCRSOBSEfrOX2tCJ22zO5JfBVIXuFoVNlZH13sv7qqMueHyT/Z?=
 =?Windows-1252?Q?Mqh1FVFN2w81kbYlGBzXYstpQVpTU1OYxtQRZ51TOcw2Xg7j2kjj2uQp?=
 =?Windows-1252?Q?Duz8rT0+sAHpSLqe1fsS/5RFAtOfmMrbJUyeWvpAPzy78mi6urvbXwXA?=
 =?Windows-1252?Q?5PqmM9SzyT8Es19J9krUibAG1Iy+iuk5Q6dnMM8f7TH60vuhBIcjuF4c?=
 =?Windows-1252?Q?ea/HXp5rpdPEV9RM8kkM/QfRy2DgbcLLYPbEnLifH9aId8/tb62I658q?=
 =?Windows-1252?Q?OHeWQ61AciGI95fJeNVIAoxFWnKKUt7zC2i0HsDkt6Pb4ngFPgPJXcWa?=
 =?Windows-1252?Q?mOPxnBbYieC2ARtvnlGGOQxhvfG30mh6/oRFAmRU+R4aJHlMcnVttPWq?=
 =?Windows-1252?Q?QjARJ6YnI6qhkhNd9SZelayT4Ekt2wSQXRC1P86a5Sj3u0YI27NCsVe+?=
 =?Windows-1252?Q?10WkWgBwQcSFKDTcjheyWqTs/4YKXmQRB7E/E+oP5sRRCnYkR1CqSxiS?=
 =?Windows-1252?Q?AvM1jy+CN4fpz3ZAX5AkG8NEl6lqWVJMkIUfzjX9fgMinafiY+8pnrVW?=
 =?Windows-1252?Q?3fqvoXyg8WbjfIhuyO4Bc82aLezfih66DsfQq+lNUGDasx5j5QtRsM8b?=
 =?Windows-1252?Q?6add5gz9KM0ZruJsyeot1f7BKwajbTRU4JUqNyof1i/2DciEZJqvwVyJ?=
 =?Windows-1252?Q?cWVyiRkR66/6LrJbB7BFwAFkhw+fFCfjxs8EKJGpNjQR3gjeV/leMAce?=
 =?Windows-1252?Q?O/SfK0nMoeLpLTdKYkLmMEJm5XRJMcFNqaAHWJtIGFpcFydIAOlbd3c2?=
 =?Windows-1252?Q?IawBC0AcyxwaMhaOgO5gHz+GhPtoejfqHMZnT2p2V+WFNTkTDXt9SA3r?=
 =?Windows-1252?Q?IEv7fs8FY2F0er5QDOCQsGCg6ULbPMcB6re2iMhi7CYZzPG6rsQ8lD25?=
 =?Windows-1252?Q?MAlrzBmEtkrLmA/7AWVR1rvenlLJnTsrrF7HSWb8Ih1Z6lmIQufSVGU+?=
 =?Windows-1252?Q?dbIkQaSon83hD8EInCp3DHuEwOyiKQtOoVDQrNZKYckAb65CvSbQVPGL?=
 =?Windows-1252?Q?4OdijCL9u8Cyt02nUpDmZcYUoPaSb7kAIqqohWVbVrYfzNQ0p55KkUe2?=
 =?Windows-1252?Q?mcFFtVQaIgkr+sB64n/aULwRwS21DM+TQMgKB0I1DPgJb1zmLQPKxfMJ?=
 =?Windows-1252?Q?6hZXMAolwuosn8Q9/9d1+An6jpYqldOPyLsxAJGNTTwR9lb/cs2eaCj7?=
 =?Windows-1252?Q?fb9SG7WXBHcjGBSo2VAsWi1ayL2FFKrkQzbbbDuGeN/Ev1oj35GVZvPO?=
 =?Windows-1252?Q?yPUWbZl93xPYPOFQNCC2Ek5eUiQT89pN7Nz68mbKnQfecHPDZQf06Epd?=
 =?Windows-1252?Q?ej2pWNQRBH1jd22GhbGVfekIwc+SgFoWYnEp75/i1ZTgZ/YAUgykFuha?=
 =?Windows-1252?Q?jrc7NxGoakTj9XG3lF3a79iXearyVCTpKocN8GYbqW2jPQWnotQ7wPS/?=
 =?Windows-1252?Q?2UnxbP4EsPRhhHBpvtNQ+8UfllQDjLYcceT93mTc4nWb8wqOqrI7Oa9t?=
 =?Windows-1252?Q?I6SYlWtrG0Z0G6k0M6ijapLZLk9n+T83FuvggO/mYqZtee2JbFSdsuIU?=
 =?Windows-1252?Q?6wuKfXDhzLyUjQr1Jzxt6gs4WYy39mb98hWFdDsHMksUymBm+GAnFPGL?=
 =?Windows-1252?Q?n7b2EX1ngk200g=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1066ac0-0fb0-49e4-09af-08de86328af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 03:41:17.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIL8j0FTx9JnoNjygP6EECFm+USD/dWNh/Wtk1MjzQLM6zv6ARuZY0jSSlds5RkPvx+wK4GCc5yZQ1TVNDH/vFuTT/Wwr3lz2aq7ATr7NRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6871

=0A=
On Mon, Mar 16, 2026 at 11:00:48AM +0800, Billy Tsai wrote:=0A=
> > For controllers with battery sensing capability (AST2600/AST2700), the=
=0A=
> > last channel uses a different circuit design optimized for battery=0A=
> > voltage measurement. This channel should not be enabled by default=0A=
> > along with other channels to avoid potential interference and power=0A=
> > efficiency issues.=0A=
> > This ensures optimal power efficiency for normal ADC operations while=
=0A=
> > maintaining full functionality when battery sensing is needed.=0A=
=0A=
>...=0A=
=0A=
> > +                     /*=0A=
> > +                      * After enable a new channel need to wait some t=
ime for adc stable=0A=
=0A=
> ADC=0A=
=0A=
Got it.=0A=
=0A=
> > +                      * Experiment result is 1ms.=0A=
> > +                      */=0A=
> > +                     mdelay(1);=0A=
=0A=
> Why atomic? If not required, use fsleep(). Otherwise explain.=0A=
=0A=
Good point.=0A=
=0A=
This path is sleepable, so mdelay() is not required. I=92ll switch it to=0A=
fsleep(1000) in v2.=0A=
=0A=
I=92ll also take a look at other mdelay() users in the driver and clean the=
m=0A=
up in a separate patch if appropriate.=0A=
=0A=
> > +             }=0A=
=0A=
Thanks=0A=
=0A=
Billy Tsai=0A=
=0A=
