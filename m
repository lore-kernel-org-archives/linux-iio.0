Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A43CF02E;
	Thu,  7 May 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167897; cv=fail; b=Non054Mz8qCKax7RJ5FYrQdllF5qrIRC2aaqzQkKPWvQGNpkqGho/z7KSypJhZDZXc8/OJraeoHZ0D0Ip43cw/6YQn3F09b8FNHyx6faGO8c3KikERFHKm0pyhcLkg8ttIQAvmE2+A2Onfpjh8YN3ngagT4CcnchFEaU44MoLX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167897; c=relaxed/simple;
	bh=MsEBhlAAjbEDppsJUKdgHcqtiGca6i6hat+ZQAwhUvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue4E9RZ5CZAKMMp6rlxQx/566e9X1qDOPKVQzTJPecOaWgQz5jluXGah0ofznExGYYs/UIzZbnJPVzfrnuV0uy6PL1K2pEYr4EMigHOJV/AJMeKSIQzAdtsXFfLQeBUGZB97yxRCFdf9/B2C3UZ13RRkB67VWvKkznR6T1yJmCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vzcEWWRU; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vzcEWWRU"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647FJ6Nr493510;
	Thu, 7 May 2026 11:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r86NA
	vSdUHYQahkC/PRsxCnLZQmqPJVqZG2HTlpaVio=; b=vzcEWWRUTCmaRlclNDp/X
	jEQvC1xjbZ9nC8uzZTQNSV6ER6SWB372meWRGF7g+INXbSKjJjQkzLLSISSU6MQe
	QPIQVpZEAKYEAlE4KUUXcInkIBJgUC9sfdo2bhqoUpclHkYIC4R/8YyeiYwP1tvu
	7lq2Ci1Ghphkd+VnoNrxC1r9hOEH5YBuLCiqQyqYLEw5W++JhhqqBuejlo4oTo0H
	JV7gmTgl/lsyyH5s6tuSYDT/nG0zI57mT6HsMbg6i8emElrte3ZKwnBxay0/KVAs
	jjy0D6pBoMZV6mRW3GkZlPH0MYxSOv6fw4IHzZH7nTY4FFOm3CwDcikq983ce+7h
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dycmx3254-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 11:31:20 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW2QspVq9t0C6I4njH4A485RJOLCLIspxPUnzTwWl7TM/sbhflmcai/aNm93C6aJTJ2jJtvvkt5TMTa0YO8kj3HUOk0FbWqvcXwsVxCuvL+Ax/G8Gw7nEtIp/kg9ljk1Xqa1Z7K4w8YJWEs2RSnViScPinrL6q9AiseRT/0Q6ZkoxQ5lrM1610W5xnkLbDy1K3BtoFFzXCLyhAPIMUsHL+bKDJKsjID2ig1ZP3Wr1LHhNVDB131XPWXv8q2mDNGZqvrQSZ5X27TMGfN6TQaXEb/IaLG4OREjvULx4DuEpCRJZcHWzu4mwvPzYY6/RoYo3Jlhworql6DW1pHohI0wcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r86NAvSdUHYQahkC/PRsxCnLZQmqPJVqZG2HTlpaVio=;
 b=P0uGqbsdyFM0NfHBGlUjDUMu7xtlx6J0OCVEQoa20W41lSh05cp9EhCnVeIr+XvoEB52Ag2mEmdRtUqSHXKtthnASqPc0s+tYzn8MNBIfsgn/ov0qjbpGJxk7gXSvNXh3xwdo71t4LBdVxMYLnDEOAzeTBD4JuCVzBoQFR8RipuvAqSLafLazC5N3vljTjcOU9vSsSq4CnKNGb+g8I+3wRmgD2ehplUkuGrwByqFTZFCmcLC5LhC+lPGXoNLEkFbSgAxWKrsYnPNjX0pEVoOIUrFAC9JoCxXdBk/WQtD+0YgyfTAfOjY3ALuXq9yT5W7TVydZBpRVFW+BhEWU4d5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by MW4PR03MB6522.namprd03.prod.outlook.com (2603:10b6:303:125::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 15:31:14 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 15:31:14 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index: AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbXzOXOAgA9qvqA=
Date: Thu, 7 May 2026 15:31:14 +0000
Message-ID:
 <SA5PR03MB837776014440C2594B811BF7F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
 <ae-pvxKhqmkWwXdX@ashevche-desk.local>
In-Reply-To: <ae-pvxKhqmkWwXdX@ashevche-desk.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|MW4PR03MB6522:EE_
x-ms-office365-filtering-correlation-id: 36774343-b977-4a50-4cd3-08deac4dacd2
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 la327Wt7uPOzUbAWtanwbm/g1dQdLoz7hDwMNyUUhirY6HS1vklTyeeTmME1L8FTcSrmbuns92hfpy5erYADcuGSjIfkyBAI1zDkHpzBeXTcyr7VOZDKL5eppiwMfuKC4ZZQqxEnBE70TtHa1mScx+AYzh4Cl4EzAg+qdmR5aLM51LHOI4HDQEAzPR2qNX2ZGzI/ldsllL9SJ9uxbDMwVHbZF+UhBE/LpKN8+Ef5UW3zNsaR9ll/N5i5T0/tt4pff/2APHSdw/TXuaz11JnqWGuq5bRK3FAh8X7zLRHlTMNrmH1/auloWfw4biqP9nX0XZ8FeUkwqsQHaxr3aeojP5DJP9SvG85Hw1SJU9njKgOXEoHsNtwJedxIXnUd5zyDNq2sYsq3YCId+MgwypfTwTtn+Rwl/IZZTxYLeBBkLMYHrHEWF7+mfXuwbCRgKGraFjP+cChI0dGpGqE0S10HvaY24cvtw5oiZf3Db7yyh5ic65+XFnJZzwwpTvyXpKfIaUdPcMEITXlspJwTysE0DZ3pGGO7cqsVhXhfl6Qx5nwbWfpoyFqLPpxJMndBwzVAvuN3DldMlMDbtcAhAu8y5JsatuPOyVJ2XeqIGFOpcp1g0u1tKEd1Y5VgtRaKtuHNqSs6H52OLf0M4LeUhbEtUhwTUZzz+mRqYL0bcJqZCW7woo2kZm6qVWP1LG9LVLIQiTLUxluKGTYyudr+13SIefzl64gN4LXUkYqdPvMaDzpZ0vZOo2oclWgvy8FPHu+0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xl81tQg/9ztoLFtGoJtHNQKfvCmKdYV3qg8RD7XYZMGBcb7m+4YarCexWoUL?=
 =?us-ascii?Q?FmWR240EUVjHLaRDdsOxzzuKFcMtlKXfqtHztT6gzCf0wywkBCPIYkX4W7bl?=
 =?us-ascii?Q?p3IetHXniexh0+ICK5VlJYVy8xTEQoM+c5OoWisT0cqDA63H7xUlS9YWv9TW?=
 =?us-ascii?Q?2I7vhf0Gt372ITHX4uDx0YJGyf1/Aom/TCIWPQxXdY/k4+ytaEPSM0ETHYKZ?=
 =?us-ascii?Q?jsyWVMBe1+YtEoHIBjgsxIh5fN4l0SINRz+W7jx80PxIAvwB6d8LcBJhkYI7?=
 =?us-ascii?Q?kH9HrvRLSB/ps+rzFBeXbPFvAUIW7zucTfJBqqwGPBFVWDtzkb9i7BE6ya0h?=
 =?us-ascii?Q?DIgapgMKC6rw8bQwU24SSUCMU3K0+FtvEsO5dZdo/9ks03BEMl7liXphuOPa?=
 =?us-ascii?Q?jLl3b4167OcHFx0v5UMRIaFPWJJR8ToA+O//aQY2SJZj9eiJ8aclqlDuYHhs?=
 =?us-ascii?Q?wrcWsAsEKykB3sRbnBbt/KG92opmZ+gLK2gpcOmQDPtpecQKwQ6eqAh9gVmy?=
 =?us-ascii?Q?aJd8boBP5vlGmU0TcATkqH2j90XfvyzsOA8sK01zt1BAgwVEJN+HgU9JmS05?=
 =?us-ascii?Q?isYlS9CKRKjfb5KeFTI62rBX6k2btP6idoTXuzc+mP0JZ/PCbykEdlWdt4j/?=
 =?us-ascii?Q?kXtRp8+y2oPO3zoHcjrHxmWNZCoB1uim1p+3O2TPyfg7xzUIp9hFeNwLCf8e?=
 =?us-ascii?Q?1SwrAFw3w1Q3tZr/tjhwpTy9NNytXfz4U3R0pI055U7K7s3wSHaTT+629uRj?=
 =?us-ascii?Q?sEWRUkrnP/NHpbmt9RZwJWlmauVNhDcXehPl2v/tV9tmoBXNPWidAObZT7MV?=
 =?us-ascii?Q?x+jh9KgqmkKWzzVH93YP1hp0Gi310XVTJ8gWqLqaEuGm5JQYsJmhmix4mAEo?=
 =?us-ascii?Q?7RFOwgOnZwS8D7xPBmPTxk+oVSHPAWIHcXWeHQb0ZXOKdypAVxCXqeW761zH?=
 =?us-ascii?Q?cmPiC07UflE+JA84msLCBPloTNETUAiIjTICNiGRsJ1UmDHwH7hHRvycDrKQ?=
 =?us-ascii?Q?Cy3JZNxxQttVyLtuD0cugJoMlZxHe9qKscgjoJT6WsH4KRNX8EjDMyhcjW5A?=
 =?us-ascii?Q?FEtEKXWeReePEQr2HGs5f/C6cmfwH/zGNqenq1Tk0TBJwmUfAMiiqlrHDZBv?=
 =?us-ascii?Q?Cj+iQ1XmL/xqS0x1pMl1PQDo6bwrZ+kWFNPmwuTq+YBCa662sLQBgNhF8y1d?=
 =?us-ascii?Q?MlIZdnmosU+g2Jrsw1Cyao2TpDZHntzfD9Z+IuF2UAtkoBN99Igjb9nn+h3u?=
 =?us-ascii?Q?oeLGhYse7mjmdX76B//ETJfibgSK0umIZpvKb8Z4+WROBOkLcklARbBG8s1h?=
 =?us-ascii?Q?0oS5wA6G1z1sByFQ81TukWtfueR5O3vSF72pU9qeLkvcA+gM0GovWfH7coL0?=
 =?us-ascii?Q?na+7wr28hoWAo6YmEaY7klBkXGFEi+cKt0j7HKsAVtisiFHc6PUguqMPJZuQ?=
 =?us-ascii?Q?6vOaTp5VgiM7VyZKn2yLs0Vpy+/n+ulpjp0pklJvdswg7y8S2BVSqxva0cqv?=
 =?us-ascii?Q?9K8TLGHax3xe2vP78Mu2j7H/t4hANsZK8zXA+zfMhFWifeQmOK5uTyDjd1To?=
 =?us-ascii?Q?cCRxtKO2HnTlh31rUsZuXn7kKFnqQ2yFar5z8uYlfkuEvtECXbFcfHe4HB5S?=
 =?us-ascii?Q?3+OlIj8TriCsjwPNGoyAYgfYY/aPKa3S7fexAARnsTClTBLBzb/PZuLMIuem?=
 =?us-ascii?Q?pYxRoiSw3EsR447Ig5gKhksSstHdD+g49N2c+VT74CAZyB9bi8fPlq4Vxl9K?=
 =?us-ascii?Q?4qereMqBRQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HVKP0cAu1gfqt8V47QvyCGPG+PiCMce8eY9tOLoXDcLsTyAo1/hdOpvSc1aN/13qWoRrcQCDWmBC8YBNq5LxQzRj2nDETY7zu61LZ0WCPqmnFiR3eWoaK4Qn++KtNsHloZdKB1x/p5O7JYMAYxmKhXU1lYhVbVDeeIf41/lp1Y+XBTJeNed4wu+y9vZlttcpeDy/fawl4CRHAmpQpzvDNEn3LOkXRBtgED3e0UO7nvAnK/FJ5LBZEVUu04RrDOvG1+559L32C/HlXFaZ3fqX/LkYN+dRgDeHHWuqPWTbOXcSd/Yu/KNIeDekv1a1r+GQag3WhVvW3xmviMs9jLq4SA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36774343-b977-4a50-4cd3-08deac4dacd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 15:31:14.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKGEIdNztzr/FIDLINlpryMZKse2x18JzmeP7ohaZaQsTBMRqRcOqLuLFmcehPIbVBB7Z5mRDVfcrCDNKKTBSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6522
X-Proofpoint-GUID: Foigyx5sTQTsrpuSD4AzFleJOLdDExnv
X-Authority-Analysis: v=2.4 cv=C6/ZDwP+ c=1 sm=1 tr=0 ts=69fcb048 cx=c_pps
 a=FnNH6Hr+id3EzXqhVuY+iw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=L9zDHqz6oo0LoikWdcYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NSBTYWx0ZWRfX7edfAYyOF/PO
 X0IqAe9Bp1SDQA9Zz+DZjxLaOxRywH2+VEAimZwuTrCfppvL9Zzc4UkRpY8/tJTdN2ytHVemwAH
 eCsLmS7i34YfksWnsoxoGdx409Udij6hQGRUN0nyr+dN/MCEj6zjdl+XLfOdQ12UI6yXimuMp4Y
 zXp2kxd38t70xN/tAjDyykhjcBnSDp5yMhZGgyiGVjjCYyREVimOf0HvQ/w9JJGSJBvnjTPDgQR
 pmOApbyMbMMuQn+mFpXSL091qtFNU/EYQX+C8NAkI5Clt/4v3ijHSvDdykP0B8ZxWPbbGqzvzJ+
 DFf3eDme2AxfQKApcuRXvPJ3ZdkxhPN0w2Lsi5YpoBUbKJNHW1rq0E3FAZojXj408ueeXHedmGa
 LFRUZXd8/5iJUL7eb7jEuxJThttVEzvZF1TY4Be2nFn492Tt5Aa6Pjy1TYVE2KTvU8GxVD3Nu1x
 2wzMfGioBYQYT7UN7IQ==
X-Proofpoint-ORIG-GUID: Foigyx5sTQTsrpuSD4AzFleJOLdDExnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070155

Thank you for the comments, and I apologize for the late response.

On Mon, Apr 27, 2026 Andy Shevchenko wrote:
...
> >  #define LTC2983_CHAN_START_ADDR(chan) \
> >  			(((chan - 1) * 4) +
> LTC2983_CHAN_ASSIGN_START_REG)
> > -#define LTC2983_CHAN_RES_ADDR(chan) \
> > -			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> > +#define LTC2983_CHAN_RES_ADDR(chan, base) \
> > +			((((chan) - 1) * 4) + (base))
>=20
> For the sake of consistency I would see (base) also to be in the _START_A=
DDR()
> macro.

Understood. Will change in v2.

> > +	bool sub_ohm;
>=20
> What does this mean? Perhaps rename to is_in_milliohms or something like
> that?

The datasheet describes two cases for the copper trace sensor type: < 1ohm =
and > 1=20
ohm copper traces. The difference between the two is that < 1 ohm copper tr=
aces
have bits 17:0 zeroed (excitation current and custom sensor data pointer co=
nfiguration
bits). For > 1 ohm copper traces an excitation current needs to be specifie=
d and the=20
custom table bits are optional. "Sub_ohm" reflects the selection of the sub=
-ohm variant,
not the result units. For me "sub_ohm" or "is_sub_ohm" feels more in relati=
on to the=20
datasheet, but if something like "is_in_milliohms" feels more understandabl=
e to you I can
change it in v2.

> > +		ret =3D fwnode_property_read_u32(child, "adi,number-of-
> wires", &n_wires);
> > +		if (!ret) {
>=20
> Yeah, this is in the original code. Consider at some point to make it rat=
her
> returning meaningful error codes, id est
>
> 		if (fwnode_property_present(child, "adi,number-of-wires")) {
> 			ret =3D fwnode_property_read_u32(child, "adi,number-
> of-wires", &n_wires);
> 			if (ret)
> 				return ret; // or with message that we can't
> get property value

Noted, I can add a patch for this in v2.

> > +			if (sensor->chan <
> LTC2983_DIFFERENTIAL_CHAN_MIN)
> > +				return dev_err_ptr_probe(&st->spi->dev, -
> EINVAL,
>=20
> Don't you have 'dev' variable to use? If not, maybe makes sense to introd=
uce.

That was already present in the original code, but I can have a patch where=
 I=20
clean up all occurrences in v2.

> > +							 "Invalid chann:%d for
> RTD\n",
>=20
> chann? Perhaps just "chan"?

This, also, was present in the original code, the error messages I introduc=
ed=20
for leak detector and copper trace follow the same pattern though. Should I
modify it everywhere?

> > +							 sensor->chan);
> >  		}
>=20
> ...
>=20
> > +		if (st->info->has_copper_trace) {
> > +			if (fwnode_property_present(child, "adi,custom-
> rtd")) {
> > +				rtd->custom =3D
> __ltc2983_custom_sensor_new(st, child,
> > +
> "adi,custom-rtd",
> > +									  false,
> 2048,
> > +
> false);
> > +				if (IS_ERR(rtd->custom))
> > +					return ERR_CAST(rtd->custom);
> > +			}
> > +		} else {
> > +			rtd->custom =3D __ltc2983_custom_sensor_new(st,
> child,
> > +								  "adi,custom-
> rtd",
> > +								  false, 2048,
> false);
> > +			if (IS_ERR(rtd->custom))
> > +				return ERR_CAST(rtd->custom);
> > +		}
>=20
> Seeing so many indentation noise, I think this patch starves for some
> preparatory ones that make helper(s) out of the existing rather long func=
tions
> and then in a new code it will much easier to follow what gets changed an=
d
> how.
>=20
> ...
>=20
> Due to above I stopped here, because patch seems unreviewable to me. If
> others
> are motivated more than me ans see this change nice in terms of readabili=
ty,
> I won't object. Personally I think it must be refactored (a lot!) before =
actually
> adding a support of a new HW.

I understand, I will restructure in v2.

Thanks,
Liviu
