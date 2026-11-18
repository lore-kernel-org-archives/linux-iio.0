Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795010800;
	b=a7ZidXDzSG40LLLixEGCFI6A7ttDjJdLDUcatEjrqIGrIkLJkSBSm/foT6OozwAXX+r/
	 N1iOYiy1ALZ827q/5eZgPe8PJeAE/avByZXIQv4dNHIXm2Z/FSj5UfoovcMyDovWR6TCS
	 pOm9HRrQ2JOVXmmidZC2rs8GJTNYttOWj1fBZWYLmwCF7JP6/9Km6vQqDUEP3ZDGmlMiT
	 mffuppOlxP7Vd5h/LHJteVnSy+SXZgeH2EzbcDm1XDD4ppzqKeiE2bLJ2YqHJ++ScjdVc
	 HUbj1MtqnhG3vFxu4Ovz8b5+ch8ahbYOcAZyObotMIkt4Y+Au95oEwJ6y4Dshv0s4NA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010800;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qCRzV8KTztS/HwaBlu/2PlfmzVvDyQcnE4sAf8VUPWA=;
	b=fDhXGxGdHeCA3uI7TTnQ1OL5C2Ga6okGgyY6FPl4xfi5hKKSLKx498ELOaxhlDP7gdSM
	 APgK7rOw6qLgGk6OKowZcjMlbfZRt3jHpPUK7cx/0rzJL8Fbhls1tqojno2VtTSXw/35C
	 46yWNoUXdUBS4ekMtpV7PXDoue5BZ7Oe+vQBBVcsfURoJrT1SgDjA9PPXZfqJ+yamg5yJ
	 ASmz3414iFYfGFRhFKoz0DhNktiG+yqsHCYoy0/Yt29Q3qA6vET6hI4RhRP97LR4onsk7
	 FcKFSmR7KXJhPd61Kvki9+SUGdFxZ2wfM2IORaG+y6fYrJUscqp3NAK3iBj/cpTCAkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tdk.com;
	spf=pass smtp.mailfrom=tdk.com;
	dkim=pass header.d=tdk.com header.i=@tdk.com header.a=rsa-sha256 header.s=selector1 header.b=gJh3Tw1g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.134
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D95606A325;
	Wed, 18 Nov 2026 14:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D95606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tdk.com header.i=@tdk.com header.a=rsa-sha256 header.s=selector1 header.b=gJh3Tw1g
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDS61q2413259;
	Wed, 18 Nov 2026 14:06:21 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010067.outbound.protection.outlook.com [52.101.171.67])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4j0ytcgucu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:06:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deyx0CQyKACWoXYRi82wh6X5GnLnhH8HiyXCHTdfY8E90sL+d7W+LLCkn2b43Vh/djB4d7SJNJjh0YpFyzz7fHbkN7Q0o+4iDuNo8lUJQC3zz7ccOstlFDC5G+2+ls7ek9dtMy8qnnmvcvjuB7yU1zeiYNGM+DgeqSMiDu0A8apWDrJsGZ9fyKt0i0DCpDAOaCYRcNeUYWU7IX/e1ThQOAwo60/A2YhFf9jC6Iz4VD8tAbAmO248jyXBspKvzeEjRTMDwZtoSU51+Qrlb7wkDedzqhBvyIA2ED1Bl5rPIZJkNaQnuA8E9+AxmSIRj7Hm9kX9PU0NvnSF9PG7hHxOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCRzV8KTztS/HwaBlu/2PlfmzVvDyQcnE4sAf8VUPWA=;
 b=wNkvBghxEHJhdvRmRWbfnRUkMr7ghg58tIDV2PtVR/RGZKCkIvbykupJTppuBxhhE41h1hTYxa7Ik45wsA8OhLWj+R7+5elcq8vpTm2ZE1oSFHcU2fgYs38I7F0Su0zheHxd7FajvYsndMqh2yYzJ6s/YcQ3AdSrps4i9vIZrgzrHFhZnHYYMZauXf1WsIGH0P0YxM5fiWeLGUlNxVKRiZLX7lZg3EJeVhohBsXDrnlIB9/EwH9bSXul0bwe2eLgxYuixDt4D9XqdoBAQpxWKmsoFyokfPZBlcm4Ex3apJdMBvk3FHX1a2Cm3ZmGltf3opfwVNthIkCb4+rIamcQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCRzV8KTztS/HwaBlu/2PlfmzVvDyQcnE4sAf8VUPWA=;
 b=gJh3Tw1gCWANbciDxBM5H3C4LhlxNU43avUYhHIEbzFqz63s6EwwQSPHpMeYLG+QlJ24WRhJ2bVvuyk9cnbgkFBRIoEmrPNGjQWfVl0IsRyKd7ZCV3pshwAY1PJ+DDgcsCYvHQqdhu+UICqblNR6d7HPkWVecQ2i13HJjb/dfGTEMQ1DrOhLVZ6n9Av7tE31IJhKpkb6CGXGv59l3yynK8h8lbiqt8o9wkBGsRLeAj9+IPsMLrAQBcwPovMu/pRN+0JqsocU7iE9Qg55fJKbdInR/dHvyRHPvtr8ja81gdujYabFjtA+37v7ZS6tNIIfJGa5EdL4cngoMw6zfDLMaw==
Received: from FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:62::7) by
 FR3P281MB1630.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Wed, 18 Nov 2026 14:06:14 +0000
Received: from FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5b9c:5d9c:df1d:84af]) by FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5b9c:5d9c:df1d:84af%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:06:08 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Josef Bacik <josef@toxicpanda.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        stable <stable@kernel.org>, David Lechner
	<dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 12/15] iio: imu: inv_mpu6050: don't disable the IRQ under
 lock
Thread-Topic: [PATCH 12/15] iio: imu: inv_mpu6050: don't disable the IRQ under
 lock
Thread-Index: AQHdZi8GRNAfVBbbQk+1Za+nbltlJbcYgQwAgBXijwCABZvOgA==
Date: Wed, 18 Nov 2026 14:06:07 +0000
Message-ID:
 <FR2P281MB31035CDEF5D0D4351E93BB48CE7A2@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-12-0d818334f6c7@linuxfoundation.org>
	<20261101021422.0c9e0815@jic23-hlaptop>
 <20261115002642.7f7f378b@jic23-hlaptop>
In-Reply-To: <20261115002642.7f7f378b@jic23-hlaptop>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tdk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB3103:EE_|FR3P281MB1630:EE_
x-ms-office365-filtering-correlation-id: ec5c7bbd-b51f-4309-2fcc-08df457d17a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|23010399003|366016|19092799006|1800799024|376014|3613699012|261021123027099003|38070700021|10067099003|261022075727099003|11063799006|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 NJYBhXq42B9ZA5tZGznDKUOir1dQusI0PyxIdGqe2oqIYnRgU12kMRXMm2TKO9gS8/GfB0YqbTP+7kzeZxDmBPmUBAuoGHntDLMjbv7na3aOc8GM77hMZBO69aRtipWYZaY6tpAbWWrAOoWo4PoAaQW9bYf9pHwj6aLI2m8nMhOjAORMPQib4x6/QIQL0Cz2T2mcbdpLbl6M4jS9KzLYI0l1aNokcImXqolEesipptuae8rlXQEbXl7smcb8lzaraeQTbWJtTvMrRzJvl90uy2kIuXP8CNNNje6xW1WU2YGuuQNKR7N9EeHMcsWXlV6yNJWL40ICmfWUSkWc/E19dUJ+oT79EVPpBU6Ez5KHg/sQKqQy0HEllri4wyCGV3+AVASqw4h3Plkmf4LsnuxCPxpN8omofXOYE3PtMlqr2lK4wnGzkPojiceCC6dav7PO3UuossfOTpS146ki6Q63WDkUXRjEwJ+4NUD1iWeKgPob0C8cOXdkUhXsoYk3cacmGTKZANB1Shp6I6PUl8h1t6HxD0q4knVaokedzK7TwodZ1KbNZhOUIzmJsRx5fETYlRWOAdh10WZ/p4elxBOkQqw2Kcp37royAOlcf1N2vmVb/6lqeg87zGHwBGFhfq7WJ0D5VtpY3i5HCnZf1dmbmX/GUcHHEgUIj3QOklb0HAvuexUySth/+nl5x4bAX42O3Of8wcjQLOczRIvoz8X4XkrbEsu/f3TWm3jQSCIhuVBisLPPqh0o1PxgY6LIqfgr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(19092799006)(1800799024)(376014)(3613699012)(261021123027099003)(38070700021)(10067099003)(261022075727099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oCHa/+GamfhAkUvm+qjyDNxyE6RDnET5Xh4T+glZsxRN4UqIwd1qmF5OdL?=
 =?iso-8859-1?Q?ffq18qdgC//W/qF4i4ym1NACVErHQ6jbbO1AY3Ig4q9tvRdC5CpRQvjvKp?=
 =?iso-8859-1?Q?PV3Jaj+zeggORxj3p/SxgAd8NoGCW0oQwg7VnU/HbQ1cqEdINsLRdgvXLh?=
 =?iso-8859-1?Q?4agueikxJsZgve43QmbnQXfubcWQyEsGB1/PJLG+ZyQIsxwrJ1C4ECbha5?=
 =?iso-8859-1?Q?i+wS+vYumb8S7RVsE6m0KfeorA3hY42+cf/ANweR6yhLbGPUa2lNM2tb/q?=
 =?iso-8859-1?Q?ALkJlF4D3GlvUqmPMn1+JFLAYxzd39aUAuKaooPN3ki3fqv06SDFxLpNcG?=
 =?iso-8859-1?Q?mrXF+fjXx3ym9HnQ+dtK/fWeIAGqqrp+lsWCzC/FHNgazk07u3GlNXhPPP?=
 =?iso-8859-1?Q?a2AMWNPCVsm6b0iGE+u3V/CJtN/53RtesI1bbcKwqeHzyTs1+SeLdQT11w?=
 =?iso-8859-1?Q?yEDLdvZoU5zIY9pUXFnQhNQm3+BknCiMQSFkecy3/AW0G+F7n/3YOVasV/?=
 =?iso-8859-1?Q?9v9sZAYVoR6jE7qLFjBZXDF0pEmf7isgkOO1ApTrf0obsCr4bcCH/19DMC?=
 =?iso-8859-1?Q?/Zt6NkdVKQmrtEs28CQB4gyQFo8FoUPBV0WpHm3G60jI2a0+AL3UM3yGzb?=
 =?iso-8859-1?Q?jDqQ5z6arckmN0abQ0PNdjBtsvmdR9xmtXUlZIWV2huUeFXtwUbGwmZJ9b?=
 =?iso-8859-1?Q?T6EWu+1ZQ54qUQgR+/Pyi8VzCwpn6+2dbyNbiUg5afRCtXCWHLiaKC3w9F?=
 =?iso-8859-1?Q?BglsMJNyx6fS6RvH31O8n6MnDU7U1RUnfpHwvpv+8X6KHD7pP0P8Y33l2s?=
 =?iso-8859-1?Q?3Ot10IlAd+yV5onYoPQm9ADCtFoqV/GhJd9vm0O21MimDVi9/ILsffZBQw?=
 =?iso-8859-1?Q?D6VDCysitaNkGQf3STWcVKUNH12+HEVvmQRfn60k4SV0erEE/2gxl7h+Gr?=
 =?iso-8859-1?Q?Wanq6JAEQozGaeKIKkyIMwqdBUCaLak0QNpgAdHFp5oOgZE9BK8L+tYpvp?=
 =?iso-8859-1?Q?H52TMIJyDluH3IHy3xUNWE4++8Y3POLqM4945ozKGS+r/mtd/GEIOzsN85?=
 =?iso-8859-1?Q?Dg1klcTiODcXrU9ez2aD4p4LtnQxXppv6X6Bl5XnPL3kNHPC6hb0oUG4U4?=
 =?iso-8859-1?Q?rVvwAHmPvzDUka/P1egUGfEFEf7QOIQCBVj5GxO7d2Nkdw96c5HI5N07FP?=
 =?iso-8859-1?Q?Ao1qdvJI/3GqXsvfnldH642OAU0C3aS0qERS+OYqRTYBKCkGMs9X1xjyv2?=
 =?iso-8859-1?Q?lUuyUnCY1ZhbujQrmK5w9JYTvsjc0892JajDhJ+ppW06TxbFrqk240fo52?=
 =?iso-8859-1?Q?mebH7JAimMQNQ8xndVK3EPK+TACo3C0EYt/LV53o6wIDJ6DSN1qJBfaFeW?=
 =?iso-8859-1?Q?TQ1yrkUjH8N5d0YQUybRNFuHDREam7lxuavdUld2XlNUrRB29BbnVOcJ+T?=
 =?iso-8859-1?Q?QLx+ZXt6KMdz+eTRzMGJwCVSl532A3h/XXDugeJTMUbcYDHABFp8ohuOQ3?=
 =?iso-8859-1?Q?1/1hfVNCZBuGkkMAddkNanE7KrkpwTubMJsx6apdmmEA7ryxHpmUomcoRu?=
 =?iso-8859-1?Q?M5S+z166H7c4AXoYeRHZgfi8nCj4yuYzfFNBjc6UZusNyX0qRVWJV/pt/j?=
 =?iso-8859-1?Q?ozzplyMOxEFpqACDXE6T/GmdUjIZG462t5OONZfo37WSgnYZK4RnnaX8A4?=
 =?iso-8859-1?Q?WZd+l1keiJztbOi/rT4WTtZOj9RTMkEg9mMGHaCz086YJyVuMr8PFSaPF6?=
 =?iso-8859-1?Q?XjPRsMpj/CUJxSG9l6n5HK3zX5gaApfiHEHXbyNGZXpfeKtnxvoYKBrJBb?=
 =?iso-8859-1?Q?k3XpsBRGQ0IuQqWRJgMTp2LKtIdourn3+QO79gvtn30QyGVKlWkefrSshT?=
 =?iso-8859-1?Q?qk?=
x-ms-exchange-antispam-messagedata-1: C8VRBii2v6GPGw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QWF++YDM45tG+n171kuRLv24clQ8/EjvdbSpZ3VOuz3opI/0fCW6mOwZsfHa0/2ULYnSPqSSXQuA8UZeNPorUE4cKfDjFXdqrFjJs16+9Ma/22NDojD2Vxq8o708pTzr564Ss/gt5HqHfeOhs97nSgRDW/mookcMmSPw3tPwbENYg2oyhP389AfwN/B19owUvzQHaCLsqUQ5oucNWigOi5+LzBGsle3rXd0gV09GJ1IxWUIcFnr+7hcJjzafBaJU9dJkcCABsseAWKf07hfjxSIt5AiZnEo83eH0cqfN2ZBwlQgyA/xT7SiGtegSKVqnsqZKAzxz71wrzx9/fmgsLg==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5c7bbd-b51f-4309-2fcc-08df457d17a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 14:06:07.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J70d/gHdEZA87P3Ua3eneuZWyO7sGNIIUkkHS2HpWCf1gV/kl8IbpucNF/kPYGCA8MrbythgcBJ2Wdky0gq8klAoo3k26BhnwoPk70mjwAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1630
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfX3w7MvwgDgCw6
 TqB8XWEPBolxlj4+ti4e+cE+p8cB01DCpLsUlRgP89CARp7sC/d83O8dalvuWAIYMJt5SjBo3ou
 cwHh1KWhX93Cg9bk/zqsqOFamGFMqbid14Nw7aSgYj1aUhNS8QemFis0TgmQSx4H7Q41uBEZoq7
 WXyowlOcHqk/01rcx74nZm0AcnObqNHBhe58aWvaiZCCaqX5u2RIysne7mIOfJJpPxsoyqM4dhn
 AE2UekAE9maIaxVAu1wicKVk5rUyafuQt0uGCQ4mu8XhQkl3zVhaR7pDXyZV+Fr+irF6frzLaGU
 c3pvBm0qIsmT10+Z/e7PcLdsfaQyvdgMd26baNX3AqzUByRzpBMflJgeoARtHRpfGdZSHMmt9vn
 sy2vNN2rD4zrquxxrvYbu7Lb5OJk8a0zKJsrY7El1Xyc5DMrCoAIunwLRcwc0Et8pCoQGH86ACT
 EJ5SuOYyGl77lxhncKg==
X-Proofpoint-ORIG-GUID: 6UAGfxfyNn_foraXIYDdHh8S2Qku2A7m
X-Authority-Analysis: v=2.4 cv=QdvzLcbv c=1 sm=1 tr=0 ts=6afdb0dd cx=c_pps
 a=xC/ZzPVxK5qpaLrndDdzSA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=maIFttP_AAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=DjQL7Z_0J3qOgSZSxRoA:9 a=wPNLvfGTeEIA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=qR24C9TJY6iBuJVj_x8Y:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 6UAGfxfyNn_foraXIYDdHh8S2Qku2A7m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfXwIZky0Wg8Owq
 xw20bXZ2OFL/Qn1DY4LkmTFOXLWfdoGpU/b2hC07jw7m/lwpCwTD2xfHgbxC/uJP82FF31vCCsZ
 DkuHEY60KyZlIpeuurkw6OQOwRVo5kyQZwrzYUj7PvzwwC73TVYG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180055

>On Sun, 1 Nov 2026 02:14:22 +0000=0A=
>Jonathan Cameron <jic23@kernel.org> wrote:=0A=
>=0A=
>> On Tue, 27 Oct 2026 17:19:16 +0100=0A=
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:=0A=
>> =0A=
>> > From: Josef Bacik <josef@toxicpanda.com>=0A=
>> > =0A=
>> > If the chip is a wake-up source, inv_mpu_suspend() calls disable_irq()=
 with=0A=
>> > st->lock held.  disable_irq() waits for the threaded handler, and=0A=
>> > inv_mpu6050_interrupt_handle() takes st->lock to read the interrupt=0A=
>> > status.  If the chip raises an interrupt while the system is being=0A=
>> > suspended, the handler waits for the lock, the suspend callback waits =
for=0A=
>> > the handler, and the suspend hangs.=0A=
>> > =0A=
>> > Disable the interrupt once the lock has been dropped.=0A=
>> > =0A=
>> > Fixes: 305914d01807 ("iio: imu: inv_mpu6050: add WoM suspend wakeup wi=
th low-power mode")=0A=
>> > Cc: stable <stable@kernel.org>=0A=
>> > Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>  =0A=
>> =0A=
>> This seems correct to me, but waiting on Jean-Baptiste for=0A=
>> view from someone more familiar with the driver (and maybe=0A=
>> able to give it a sanity check test!)=0A=
>=0A=
>Ah well.  I guess Jean-Baptiste missed this or is snowed under.=0A=
>Either way I'm confident enough that you are right (and the very=0A=
>low chance of regression given the change) so applied to the fixes-togreg=
=0A=
>branch of iio.git.=0A=
>=0A=
>Thanks,=0A=
>=0A=
>Jonathan=0A=
=0A=
Hello Jonathan,=0A=
=0A=
I definitely missed that.=0A=
=0A=
Good catch indeed. Interrupt handler can happen during suspend, and disable=
_irq()=0A=
is indeed synchronizing with interrupt handler.=0A=
=0A=
If you can still add my tag, here it is:=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
>=0A=
>> =0A=
>> > Cc: David Lechner <dlechner@baylibre.com>=0A=
>> > Cc: "Nuno S=E1" <nuno.sa@analog.com>=0A=
>> > Cc: Andy Shevchenko <andy@kernel.org>=0A=
>> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>=0A=
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=0A=
>> > ---=0A=
>> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 +++++++++++++++++--=
=0A=
>> >  1 file changed, 17 insertions(+), 2 deletions(-)=0A=
>> > =0A=
>> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_core.c=0A=
>> > index 38c3f3b398d4..0ae9d497ccfd 100644=0A=
>> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>> > @@ -2166,7 +2166,7 @@ static int inv_mpu_resume(struct device *dev)=0A=
>> >  	return result;=0A=
>> >  }=0A=
>> >  =0A=
>> > -static int inv_mpu_suspend(struct device *dev)=0A=
>> > +static int __inv_mpu_suspend(struct device *dev, bool *disable)=0A=
>> >  {=0A=
>> >  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A=
>> >  	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
>> > @@ -2212,7 +2212,7 @@ static int inv_mpu_suspend(struct device *dev)=
=0A=
>> >  		if (result)=0A=
>> >  			return result;=0A=
>> >  		enable_irq_wake(st->irq);=0A=
>> > -		disable_irq(st->irq);=0A=
>> > +		*disable =3D true;=0A=
>> >  	} else {=0A=
>> >  		result =3D inv_mpu6050_set_power_itg(st, false);=0A=
>> >  		if (result)=0A=
>> > @@ -2223,6 +2223,21 @@ static int inv_mpu_suspend(struct device *dev)=
=0A=
>> >  	return 0;=0A=
>> >  }=0A=
>> >  =0A=
>> > +static int inv_mpu_suspend(struct device *dev)=0A=
>> > +{=0A=
>> > +	struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(dev));=0A=
>> > +	bool disable =3D false;=0A=
>> > +	int result;=0A=
>> > +=0A=
>> > +	result =3D __inv_mpu_suspend(dev, &disable);=0A=
>> > +=0A=
>> > +	/* Not under st->lock: this waits for the handler, which takes it */=
=0A=
>> > +	if (disable)=0A=
>> > +		disable_irq(st->irq);=0A=
>> > +=0A=
>> > +	return result;=0A=
>> > +}=0A=
>> > +=0A=
>> >  static int inv_mpu_runtime_suspend(struct device *dev)=0A=
>> >  {=0A=
>> >  	struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(dev));=0A=
>> >   =0A=
>> =0A=
>> =
