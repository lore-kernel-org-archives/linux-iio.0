Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1E39B49F;
	Tue, 24 Feb 2026 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938621; cv=fail; b=BdExzcRVdcsy4Yu7xectmbvMSN0/EfR4eP+/2+/9eXp3xLW9O5ZB3I5X2EHKmGIfgh5QIH7KY76mCRDCuFwfyZwlbjhMVEdVcnoy7/p9lcxF0lOt7AlVMP8eD5Eb8ktPVaAuXOnc58/QJCZJ1iTmsc1PmlEIXkywVpTeL4PhZqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938621; c=relaxed/simple;
	bh=yKuGAmiYSfG/uopmIo/OptgBXrTS38SMR2bpZCAQLds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZKhqavStPKvc1+rKtlv0ZSAKBqy/e9sZarZwVLMyzKIYrJBjLS/MEBimn0kwmwcqUWEdj4/xqsJWUt/QYk++/DmXJol2gV2hfe8rQ+zaXVHKfjRqvLaITSjwm4az+k7kXL94KquUJDma2LtQS+tm2PVyR17TNvktQNSe+I4PNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kfF9VEpa; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kfF9VEpa"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O5r0Wc3494215;
	Tue, 24 Feb 2026 08:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aS0yZ
	yoSJFgjC0qnsG/K3rh4HmobiyV94T8YSRZGjCo=; b=kfF9VEpa10BVYbkqa7w+x
	WR+qa/XFmdKtDG7r5z5dX8USiijKnR8c6wdYIIsSkhpb+Vlw4fXATs2fGap/b9+O
	g8ZX3JdKYkCl34jIXdNEc/ntkkDuvIERIqtGgBzpu7o2wH3rN4i3l16czgRGGfFS
	hpmUqslr+sw0sGzuGyX4cDPz/Mbb1f2FF2EVvT6h7cthqk/cN+FyAeXqbUW0PiL+
	QmIzF8HFXnstgy38eFWZHR8x3vb+HHQifSzuZrcWAv3/2ty1zlK0HFWj+4qPQFhB
	hwjRO94Lw8F8cPgGcqFx4DEQ7hTRxpv694Ad5CwtOC9wXNH1I2+1UWV49x/lIHF0
	Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cf7b99u65-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 08:09:53 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bObefU1/WzGFq2u+GI8eMnJ/KQpq+6ZeVv/7ZoulkcFS/qD2KCHH3PbFWA8Y2rmQeZvBnqkPT4n9bGXVO4QiZ/i4BEaT5gabu7dyWBsR23mNJT0OZof2F+AezgRsF7AIoM0rwcSW32/mT6Kg9gPuij0Y0+w3fBxXsYs5moxcheGjosUIi8zl4XbLjg3smNWmja4kf48H5gU094Z3DpOCQg4MZYOrlNdX9c/sXH29iHnEEVAtrcMblFRrn8U4nZ1WW4+A+UotKT4QF/9DjBQEeV+uLeMF+RXI68K1KpxY9pLui4Rej9ncC3c+mIxBYv27kAve+XYP3kvJSxbOf849og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS0yZyoSJFgjC0qnsG/K3rh4HmobiyV94T8YSRZGjCo=;
 b=Qgg0taLrTE0Agy3GiZD/62kBkrlcXYuNxxx+v1CodUKEGXLfYNfj0EvIXuFRaG7dTIuFKVALfQzy0OIOf2D3L8YpsAKjC+UA9MA1qnxp+koMAAkB7U2q7BbWHENl0OYGhSFt0nrVg9cFDEsls8EdtkVbSIQjLYwHM61F6LC4OCjoHEYAbcgHlA+mh7iUSEWJnFORHUTGpYL8cCeMKYu23qR0kav4gcYC/zv+O+flRfdEIMu2hpZ8rDa6Y6KRgxN0XfoO/Z49WUAPf+uhsxOTrP+sqeyiU3RgJ55moU2BUM8ilkUs9WEb2QJl2f+KMlR+BNi0hrlYQFx5brQlVOHQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BL1PR03MB6040.namprd03.prod.outlook.com (2603:10b6:208:316::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:09:49 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Tue, 24 Feb 2026
 13:09:49 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: ade9000: fix wrong return type in streaming
 push
Thread-Topic: [PATCH] iio: adc: ade9000: fix wrong return type in streaming
 push
Thread-Index: AQHcpY2JZNAZey/bu0mnAtJKhUdq77WR0ZAQ
Date: Tue, 24 Feb 2026 13:09:49 +0000
Message-ID:
 <CY4PR03MB33991683F0E5E5212987359E9B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260224125921.70946-2-giorgitchankvetadze1997@gmail.com>
In-Reply-To: <20260224125921.70946-2-giorgitchankvetadze1997@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BL1PR03MB6040:EE_
x-ms-office365-filtering-correlation-id: 5ea2df3f-92d1-4b7b-a408-08de73a5fdc0
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Tv1CEEbUtstF6bWlHbOfpj4DJQIv4dK1zTIoWisyp2sdErRiDKEpuoelZJjY?=
 =?us-ascii?Q?1edrY0FpyS9xmfbsdSB/wfhyChZwyHKOnyN7AUHbIsXreOtnk4FaVCdqo55J?=
 =?us-ascii?Q?/tZkp5Yy/DQjNOuK/9HATHcxD030HQ/flrVAKfJePAZTO1+nNZujAFlbMFCM?=
 =?us-ascii?Q?C6N2Nu5rAh+Cw5btE8V1PZpjBnBkoPVi6ln/PWpOfzdi2f9mNWC38IJKZynS?=
 =?us-ascii?Q?DIF3cGxg2zlWEw2rI0xz5N/p9t1g34gQ63Qm6svEOSr1oNEI8rHnyzVC1NQS?=
 =?us-ascii?Q?luZUBUfAxLyrptN6mGmlvA5a0PE5LwKZRcXjAMvgOkmvOCRjyoDvRT0Ji07J?=
 =?us-ascii?Q?78L/gAFsPv07VWoqEueBnqn0gxZn9WK9l+y0T5ePZtznGlTeNzWDiKhii4uS?=
 =?us-ascii?Q?m87/EWyrWf+0C82lLG0d5jLfO+jD+uvOmJ6gnHwNTZBKNK3clD8uEruCZWDT?=
 =?us-ascii?Q?T/Wy5A8U4+QQdYYENrMQ2bgTNn/aQQyepm6GqYzALuv2dbfcLxMwko6Ag2rY?=
 =?us-ascii?Q?2MS9VaI38U5NFxQ7F3qe51T+vsQWmuZ6P25zvxoGhipjONR49cj/Pt7npR/x?=
 =?us-ascii?Q?N1zJQmzzU6FFj7lwyw3rBOZhpyVJKk+roHosF4+esDUX19jTHfm+ZJy4U31Q?=
 =?us-ascii?Q?4VTtk785XK7PT10o5tYenNpyQq5p4PD3BX0uQcsCYzchoBO+g9gZAaz5WztZ?=
 =?us-ascii?Q?Cvxy7P03no/H0Xbu3jkGp3r+JsM1y5ISqtFAUwkJzCzkicyqRz8Agm9IQzyC?=
 =?us-ascii?Q?+dx6rDDKfBSHrg51XGsogTzRI0pzjgQwxvb16W+HAgo7lelW3wYBe5UpdU72?=
 =?us-ascii?Q?k2mTeYODPI/jBZRCOt5umBlZ1r79jyevDvVaILLBtqrr7lNxVsWxuTFnA3+W?=
 =?us-ascii?Q?jXFGb5nMgsl8Gmb4XOhFVzoYMmQOqomfbMef7Sq0eaFQHGKHgfqJ/zk/SkdI?=
 =?us-ascii?Q?1/7z6n0SUPQiHNMal5mb5I0K7BTqL2DHCRiHcJJ3aMzEv3eIJ3Tex2J4Eufv?=
 =?us-ascii?Q?KAv5h1eUPLA4EZ4iRgX6/wO6rZyHWjdruaEe/r7K11SIKqR22amuPZuNh7rX?=
 =?us-ascii?Q?v7k0Kyz8moRFNbl0mSPMJaeHAZO5hTxyc+KsUk1rXPxGZjvEZJCPeVV9Eais?=
 =?us-ascii?Q?kA7FMFGztDPP8Zo96w/7la+jvMAAfuOs9hJC6IXcBaFhnBu3tFp5+kQQ4kqe?=
 =?us-ascii?Q?JswJDqBmz1AIABwa/x65YevZBWdlzBDFegIapUFcJoQJF/7S18SEdUfo2dem?=
 =?us-ascii?Q?TakvYLB77tbYzL3R+wF7lzSjek7UwyG+Y87axC9/HkHQyP6FCba6QwZLZjvq?=
 =?us-ascii?Q?wAO7s8ifb0/nsIz2OGW/PhdNsrDg6oxnwPeFVN5U3htnQTUD+3IU2EAdMsBf?=
 =?us-ascii?Q?mkhkmxzWaMDJqzxi/JP9vcMIpOJq6VDmxDYOCzR1t7vRqjIu/llvms1KkeB9?=
 =?us-ascii?Q?DvgdDWhhyz1m5P59R3jkpSxKzvGAbqzx3KDowJGgmDHSop7+qhNhXhMkYdga?=
 =?us-ascii?Q?PlGYg2WoVGlWlcqF0adibX+oPdJv1gqYeDRen1PaXhmwGsFyhFvIhH0D/6Rt?=
 =?us-ascii?Q?qefNjdy29sKIcqQW1AMq6VBpWD9SEFqw/Z/oCALgtK7SfiSpM6fLSoKhjIez?=
 =?us-ascii?Q?NByCUioUShbKrxVtpDsTQPs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L2jJrHadZVwlQPeC/qUpvbBUbQABYpudy+VL9BtE+Q5EMG++6THcBvYhaUnj?=
 =?us-ascii?Q?rWQtSBZNNU8JqlMG4Yw0oOMYr1Ku8KS/OJWvojn+PVhv+IwAF77nLJ5sgf1y?=
 =?us-ascii?Q?m+CHwA5tTEciKVJ1L3PmfRByLBAOs5mHstMgL5ioVcGf/zGDD7CgFB4JUZnL?=
 =?us-ascii?Q?xGNDwvf7Gj3cnFlnb37sjjJ7rSQPvQr7BtYerRDHanAMYUrZ1YisghpUzEd0?=
 =?us-ascii?Q?nmbwYhEvr5v79BCHADCJ4VBqPFRLwSSr5+GYp+t/GVPOdTUevl7pVmWVDyi+?=
 =?us-ascii?Q?2NMrPVMGLiw7BqrK1nGnR5Mk7lZfe8ZqKh5Mc3ke4pnNOPUewB8SFjkqnFjW?=
 =?us-ascii?Q?7y2we+f1fTi6JvGONEkfNu9e+LGxou32ehFt54Eg7c/jb4db4n+5e6is10sA?=
 =?us-ascii?Q?x3oGSDlqhCZffu6H9/gTZiIG5rbXW9Zci5WDcuqN4Yc9BQQTOAXXFdqPu5jW?=
 =?us-ascii?Q?C2wCuWt1L4aDSYYJumTgbqwGuMJ3EKP8a2kyFObKWUnfdEDvVWlVVfNXaX1V?=
 =?us-ascii?Q?4bFbY4Q51dLpmL2n+jnud7VhWmg1HLNKuPKTYg3i82gUPONeD95doU7U3NEC?=
 =?us-ascii?Q?1nzZRjqKL5lWiPlYX5mT1MfOGi1o2sUTQDKMBbXcVIP/C3zPua6kY/KMhFU7?=
 =?us-ascii?Q?AYJkjYxkg9qt8frIxokPyjAx3Q66gGXemmgHF8dbIx59HwYfcd8QZEtG2lyi?=
 =?us-ascii?Q?axj/MwOKyRx5nrYdqYSba/q00f5BbSWIwI2LEJFylILpvxIsPN9g8WNtACGd?=
 =?us-ascii?Q?6/qIRns6JphpaPe76sKhPl8e5bBCVL2OEHKfZVoKXdJOq9CXXRWR+EhVmRie?=
 =?us-ascii?Q?DzGXOBJFFj0hI7Rb71swNum4x1y/OSObtRIKS5blCT2VIyDNE4RTnAZCL14z?=
 =?us-ascii?Q?48n/AFIF6yxwZLYOH2QSCPxiTEnOSsqrf1bgB33stPBdVfFTjwwtYu1tP38g?=
 =?us-ascii?Q?vQtetRheUxBkio+Vml7XyidoViowePgL7JNvrDP7LepaXSE5opbBK01Y/sLH?=
 =?us-ascii?Q?QHaP6xkOA5cUq5k0xC1PTmlZSVIiS+CoAYG3re2CRZN8FwGN/iJ9liZGCp7k?=
 =?us-ascii?Q?iCexARLdOgaGk9aEbYCv0gugEio4gPD1Rl0vMJjQ7hQ0lxrwodZq22ZKebV3?=
 =?us-ascii?Q?dQoEeuj/k8sW1ZKQ/sACglDOv8RiJQean833bBmWt9aFQItQ9BMTlKF+9EJ7?=
 =?us-ascii?Q?x2rDHRbwp+2but8Fc5rnuQ47ATQQS1mtF/i5s8tQsRQftJtf1Q8oGF8/P+VB?=
 =?us-ascii?Q?TgJOlIdSP9RXOvhR7TVMiS4DG+pUgEy1MxcvBHKHGdBzLxYo6EhZsEg5/uwm?=
 =?us-ascii?Q?EMUWDDKfLRSGV3/pPWzR4f7qY5mRpehjjADEZlLcmBnn4JDji20nBgUkzOzl?=
 =?us-ascii?Q?Vj1j9ac6cOsxrqil79zDXzOxNR9CcbWbj4mNiv9qDG2ahq2+NebGSgNwk1Ys?=
 =?us-ascii?Q?2uWIO3iCKPFLzllkkZb2QQr5LT8GQ9UEmH0NRWLg6JpjB8ElK+kPyQJKXI8T?=
 =?us-ascii?Q?ZohAApXGx41srl47wVtD7m/J9Fhx8bco4EhQDZ04FkXAauo9iK51a2VB7gew?=
 =?us-ascii?Q?hsy9xG3rr+8re0x9EjSrlWGVPQyClJGp7KsDNE9h2pwxC+whabigYmNX8Mt/?=
 =?us-ascii?Q?3+tNcxFMl1WCDKkw9dRVmVwlfFCtshZincB9ejpHcR5WXk4GdLsVbBu/+2ZX?=
 =?us-ascii?Q?kzZ3ZwpJ2SDcaXYLmHn9yCD2hz34UfcHIOQ4AT38cXvyxJQ377YwvonIoEPj?=
 =?us-ascii?Q?qAgChRoQmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea2df3f-92d1-4b7b-a408-08de73a5fdc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 13:09:49.6728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLZQeFI7DuNFSA13SVvFJduqBtU7nJadMlFeyRrFBMPQM+EDLX/UuA1Kx69IZXEyZBd5OeCob+75hed1AzeZ5MAQV1As4XVZzoH7CZ/m/rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6040
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEwNiBTYWx0ZWRfXz2+mQthsoBuw
 Cs/VrwiPvJeHd7gTinGsOq+7coz7BFpQiVoXtRY5kQVEL16BLCjxuvqynajnh/jTlJA3QC54Vzz
 l/VwV+D0t+IFwJ0HyijosMElimC8K6IkjDrs3Zqb7QAQxgStRceJVFzcKAsBV2IBDDcUlt/IdVg
 bUqlVyIsOnM15WVcKd0z2tQBhM7DKmjQFDyBapRZ7ERag6d6PI8ou4qJW0RxXBVnNZAflh7gqDk
 gR0h2zvzxYRiFx7xqXupvP542MTfj1kmz7zjTdI1PMLPJJnDk0wxI+nuZH1unC0OpSnrEC/5n3i
 veZVsOh5xjS9xolf7MxLtXvMG+LdmqH5P6wUbsxBDlOmzLjtSffJ5qI4jMCEVzxp/4IJO15Pk4D
 bqpin8k+ZyTbXgLYzRKwIEBzjjuin6gAGISA1dH0jwhuagsDD20yhxJ2ZX7DR6IgTBBFVl6NyhX
 IjbYQcPBrqWwArV0kLw==
X-Authority-Analysis: v=2.4 cv=JrP8bc4C c=1 sm=1 tr=0 ts=699da321 cx=c_pps
 a=7NCjPUurWbS4kF9YcBnZ4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=CgFKw0sba19lKsq6_qYA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: uE9aWaObnaq2VjqJIKNdHXpGwMHqo421
X-Proofpoint-GUID: uE9aWaObnaq2VjqJIKNdHXpGwMHqo421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240106

> -----Original Message-----
> From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> Sent: Tuesday, February 24, 2026 2:59 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; lars@metafoo.de;
> Hennerich, Michael <Michael.Hennerich@analog.com>; jic23@kernel.org
> Cc: David Lechner <dlechner@baylibre.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; Giorgi Tchankvetadze
> <giorgitchankvetadze1997@gmail.com>
> Subject: [PATCH] iio: adc: ade9000: fix wrong return type in streaming pu=
sh
>=20
> [External]
>=20
> The else branch of ade9000_iio_push_streaming() incorrectly returns
> IRQ_HANDLED on regmap_write failure. This function returns int (0 on
> success, negative errno on failure), so IRQ_HANDLED (1) would be
> misinterpreted as a non-error by callers.
>=20
> Return ret instead, consistent with every other error path in the
> function. Also add the missing newline in the error message.
>=20
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---

Hi,

>  drivers/iio/adc/ade9000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index 5dcc26a08970..07e84c6257d4 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -786,8 +786,8 @@ static int ade9000_iio_push_streaming(struct iio_dev
> *indio_dev)
>  		ret =3D regmap_write(st->regmap,
> ADE9000_REG_WFB_PG_IRQEN,
>  				   ADE9000_MIDDLE_PAGE_BIT);
>  		if (ret) {
> -			dev_err_ratelimited(dev, "IRQ0 WFB write fail");
> -			return IRQ_HANDLED;
> +			dev_err_ratelimited(dev, "IRQ0 WFB write fail\n");

The `\n` is unrelated to the scope of this patch. Also, you are missing a F=
ixes: tag.

Otherwise, the fix looks good.

> +			return ret;
>  		}
>=20
>  		ade9000_configure_scan(indio_dev,
> ADE9000_REG_WF_BUFF);
> --
> 2.52.0

