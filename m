Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5694908B7;
	Mon,  7 Sep 2026 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783594; cv=fail; b=CDZo80HAhAmHea05KvONY1ACiTRbmhGndJ2D6AIv0iMAiSRk10x+daZMe9Q2J4O0KUMoEFgODV6uCpX2ZTuhGifrQeujGLoc/w+5wErRSzUy+ACqdiz/Qq2BWFntNN36XKwdQrvlP+9I0zWAvYpoDIGuW/Xqbhnx/gQ1PHMKAs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783594; c=relaxed/simple;
	bh=vNyHgQ5BUMBIU40lm5+sBHUmDKIln7WYPBoBakwnOXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XNtOoEQdvqHZzeOedknbkHVzfwms2YBI8l0fR1rUAIO7viouWmHPvc+aRnowuuHuqnIQ/KOMYB1BfUrOEGg+mMLvylvos14aHVc+yguvyESsKAXFRU5nDrp9fY2rrAprfTsw+T6Ayl922I3eMdSbtJK5kXvN297Pxm9yhR7apkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=q6rGcU3V; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="q6rGcU3V"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687ArslQ1057347;
	Mon, 7 Sep 2026 11:52:29 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012051.outbound.protection.outlook.com [40.107.149.51])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4gg9ew1n62-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 11:52:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Trw1EgMRfzoSpDxGqZ1bnQsbnqqfvUXCk4hcDVXDzLQuaA91s9eBzxQvIvrmTlPoxJwj/D/6UMHdyLqEL45rOry8FSB7PeviNDAOwCQ+SDfrtKZ9cf3eJi8mOSwtpktvRsUfjY2xsaYT7tup21a71ym535K8cBudkJaFknKFMEZlLaXV9JCTmAHYkUa/I6oku+LYRFRXoCnfGD5XUdLFgyR8vGDMcbrChAhso98kMpQMLAik1aHHLkgGcHrnCbwtz16T/5z7OYoeOYgr+yboCzO+daXNTdxJhuihjD64DBzPef5kZyY2dhZ5qxT5BTJYGcXUu7ZydNEA3z3Keh45bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m8GGnb4S7rr7sdJagQgCuIhs8HPABlfnGtT2/D6i6w=;
 b=GKSgtyy6cwnVNR0P9OAqEkEJ+FZw1MpFzKFVxlzIZ0PlVieHr/UL8i/y6cs8TVuC/mfZ5uhcj7j5E+W1T8MYCCaGT2+r/oiplULtGbq57uaSPHMBEkpJi3WennMFWYtWGJNCJodzUxVLfy9w7fe3xhOJZrfqlJI/xeQln+6iytS0w8H09URvw56rGQ66U0cG7SuLcLhrvfC/+qHLDY00Qx/JcFp+Hbpw6r3fVcS/gsYtQ2wJR9boeXebJlqTtrNRp6V2vvnuFL1m6YjVJEuFW+8vco5O2dBC/ntWooz8b9B6oKBMHVRVr7XvLE0BlVXZhfPxyV7I6tfofR/rqB4XGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m8GGnb4S7rr7sdJagQgCuIhs8HPABlfnGtT2/D6i6w=;
 b=q6rGcU3VKchd9HpR+g5zR9ie7Bq/wTxWl+7kOhsUbA383Uy+Yn0TmBmMRLfjlumlZgWB2AXoVr9YdjmhRq4mNqSsu1q70TObCPIOAcOmJUdH+XvZbQZ0Xfbu0cBmDNDukNgo/BEWtATMjEYiO18195I6OqIwC5OaoreoVcu8IpyjBMetG9MZdjwFEV7Rk8cfScKhA7UABcEdutnEppPlY9G9WxyZWCJQGO0nWLNfdT4CkPUdXTfSYfm0U57YzPAOflXnxeErUnxJkJ6e2KRl6CRff5vNJwDSFk1QnCa9ESpF2M7zqTIXVArdn0YxkaopghprnRg/0NURB24j7L/9lQ==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR0P281MB1706.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 11:52:18 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 11:52:18 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>,
        Henrik Grimler
	<henrik.grimler@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joshua
 Crofts <joshua.crofts1@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
CC: "kernel@axis.com" <kernel@axis.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Topic: [PATCH v3 6/8] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Index: AQHdOh9ETX3PPFeZhEK23eh09jzwxLbDCgTr
Date: Mon, 7 Sep 2026 11:52:17 +0000
Message-ID:
 <BE1P281MB1426CC3CADAD2D34138C5886CEB22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-6-77cc31642115@axis.com>
In-Reply-To: <20260901-b4-inv_icm42370p-v3-6-77cc31642115@axis.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR0P281MB1706:EE_
x-ms-office365-filtering-correlation-id: de6bcdbe-647e-4f9c-3fe0-08df0cd677ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|7416014|10067099003|3613699012|4133799003|18002099003|22082099003|56012099006|11063799006|4143699003|38070700021|921020;
x-microsoft-antispam-message-info:
 Fiu5HEne/IG4HFqjtKJD/EhXFdsMfRqCqJaceXshq4Z+XG4R/z6nVL60X1fnaJhyjp8nD6OT3q9yBIIExyWk2rq5sIxMrz7BSI4QXGSk5ci1bIk0h1NLPX7dsFW917w+igyBPnAZg0HqNi4ShuNm1BHOGueStp+wXAVwubqolyX04ZAKQR+Av2nFYyJtX7zCZBiRuIFHVF+AC2pEjjNpbjYxO/rYytwe7g83cgFpoWYFrMEv3WIQD9y8DzSh0QrAAEimDa8l5wzeM4mDeLGJuFAMb7gAIWoKVmW1jyH8rD4GVdYmCiwA1EgY62OgIxUBZ0b6ZIQB/Sszrg9PJ6RAZiZfDOZG/oz99TkKa9WF82UtcOpr1SvLbNIhi67Qi9RqVpRZnwy3ExtFgSywwxdBHSAw14C3RLBuf7Je4RgZHhOYG8Zme46JY/iNAGUHusHW6lkoE8oDrnDoEXJNdQlagjZe4Dhb6RBj/vmGLnam6qKKncd8S4R6FQIjv6X2Lm1c154mWmBvXSNnc1bzKFh7dkzpbAvKR1d65hLrQquXaj8qJB+A78MYrs6xfaVkbmTk3B1PxC0m0LrziMNX/sjeRCWQLRaJqQrhPvSllJXQpQItzgbjg6TTcFMWrt9/Vlkc3CBSNcvdpVtzxww/2fjlb0clzk6sQPjala0JEkSLK5IDzFWSrlwHOVYmJbUZP2gzN/q1abeiBi1GJMCSJ6tQ7SEnfV9qE+zCwp/qktAFtEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(7416014)(10067099003)(3613699012)(4133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pxWyCdz4OtRRmmfLJ37fiJvENkQjWgata6sYPHLjuwjCNA/RTOf7CsVFfk?=
 =?iso-8859-1?Q?M4+6eU/M1JDGycCXXv0N+ekB6NaiLrXZhn/TQEEtrzP9fbYtuW7Xs8kTT8?=
 =?iso-8859-1?Q?LNyCGGVdYBdC2z1uT/G1l3PYBYrvjEVH9TNMZBXTTE9/6YVo8qsk2TZ/sg?=
 =?iso-8859-1?Q?cLdVI2Yl7DCLYfuW3zMt639HfBfx0gnySTSRGqQosl4eKkPDxaSo7BY4+P?=
 =?iso-8859-1?Q?O25h/znwW7KmwdNfY+QEzSf/8pYqyYVmj6BDx7DqMgmoE3QK7RfPJuLTKb?=
 =?iso-8859-1?Q?v+El92ctU6wM9s78P6kZ/0FFpTdT6phgGWdplxmnmslyaxPcJk9SsyqrAa?=
 =?iso-8859-1?Q?pO2IU1VXLsRbqu6B0WZ4yBX7bFBC1BtPkgzV9E3ADQyF9Trdays1UKQIm/?=
 =?iso-8859-1?Q?aaZu0gaHLBR1lM8psUxmIstX66jEH1GJ1ZUmRDFLqTXk0jpziibUUUMAEe?=
 =?iso-8859-1?Q?W9NuqH5SlYi/bmR2bm4RlnzM+rB/TWB5++D7bnEOmhrnpFjUHOkwPyJQqg?=
 =?iso-8859-1?Q?0D9gi1EpRuExwDujHnjVcgq4QygLKQkjT2LznLEv5VyqTO+gaioBFYApM5?=
 =?iso-8859-1?Q?yU7mTgdNz6ihzFLKJTbPbgDlrwdtkT8T86zw/iBcXPck7oUv4g/a14arcM?=
 =?iso-8859-1?Q?bFkJW/DJRNeTONU3U0Embn4+GHfX3z9ZLCBs6gtfyIM8G5fRBJ/Oyal1NG?=
 =?iso-8859-1?Q?TlnpGkmeC1Y7xwV6eWWCaX9eYQ1JrNXpNb8T67XlKzgtbTs9canLZxFA1c?=
 =?iso-8859-1?Q?gonz5iYKeblYk3UU6znf6tndqhTVd1z+HZfMnVQ5q4a3xxKYNtRlxCaSRy?=
 =?iso-8859-1?Q?RvlLPFiGP9X3FfQZymqI1XkuIL964SHLWdld9ZhvP1F7ZJoOpcXWg10f6E?=
 =?iso-8859-1?Q?ZChvkdaa4FVybgdvfVbFoP8XmSBX9/drLe7u/zNJXy+xgsV7xf3NbJjsl8?=
 =?iso-8859-1?Q?jIk0VOuNZTo7bTGWZSsMyADZrRJakLJ56CW5iuEL+CHMgmMv+BgyGrHrAQ?=
 =?iso-8859-1?Q?FYaSGk/otLgiR/84a6QuTkvRcKHUNJTUMm35QRm/jc0kWenc1r1ZWrkELG?=
 =?iso-8859-1?Q?rLhWx2sR/GHxuhEDUsjjFyrPNPfIhFBqrlA32ZRs46gRGkvdws4/m8IXQ1?=
 =?iso-8859-1?Q?u6QKNRDs+0VFOnMJp3gcs86mtR/x7w9M9bSKiG7zgT9vAoK9UY/h/qxQS+?=
 =?iso-8859-1?Q?G1jNKPR+dk3KG577AWT5BRa73kv8FYhZXtZQ+DVSS9VuAJGXqAZksI1rWL?=
 =?iso-8859-1?Q?YG96ioUJ1F4aWNXNv29OcNgDCpH+jt2x6WHaZtYg49nB47Xz/iIjipCnk+?=
 =?iso-8859-1?Q?n/fE2YYGoq2FOfoninCJtVZW2nuNJCP6Y0mrOf/b15jCWrjZHLy+gQyUq7?=
 =?iso-8859-1?Q?Tv0cEGwsHpgs2eRAO4qasqxhpc+z85SYlg5qxRleVehPb7vOol9gKnNf+n?=
 =?iso-8859-1?Q?fMLHRr3KsnMLDeWJTFlAM3uQ6kM3BFVJ4VXvvoUTK28tfETYJcwwuaVpmB?=
 =?iso-8859-1?Q?ABFzrymACE4QCq2Zu2x/whkxQhGlSVO7cBVyucNZjF/yH89n0PzLjFuqbF?=
 =?iso-8859-1?Q?EC2qEoVHdv0x1JXB/56mR46GAgexbd79w3DVzDrXs5cfU4zDn3SJQ7AUgS?=
 =?iso-8859-1?Q?eAuvXdzBsv1XkIIWUqX1NNNgBqHSJ46f5BgZYfS+KscQrWZ1nd0xfKzxwX?=
 =?iso-8859-1?Q?X3FgWzLIz0lfLoOXhzfmAxt663v0+VapiWMuej26NE44FLkpQpp9gXi+qN?=
 =?iso-8859-1?Q?NoVZ3R9uT/X5OZiZQ5qu3VbvYF2/DkO5jlQfiZdG+F1N+eUMLUEPttXZZs?=
 =?iso-8859-1?Q?V16123DbP60iDAfQAkHTmP2jhBkVAME=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	O2dn/n8Ezp2pACVom1frx5in+GO7QHRArXnu4X6gRpll7oSjQ8K96PL0zOQ8H63wNtIq95SrilBN/ee1/TnAZL7aMlRt0ES6iZowzQa5g7+HYIrdxlAQdTvkK6giJ3lkbiv0xdm0Mfj8tQgMzgGpl0y1vZ+//baGVaXCcuBdP7mlLGB7XZrTfspJeA4mkpYnFTTM8WJD10wWFYgAJEuWfd370+gSHGTNco1i8zwnYZSHcGAuPavz4roMIF3EOEFI87bGiml6z8KHW64MO7VLRv0tfyS4feJ8A99CPKLryeFjCQ3EHD28er9mhi6QnmSDMcV3BA7QaD71tjiZDsV6qQ==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: de6bcdbe-647e-4f9c-3fe0-08df0cd677ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 11:52:17.9757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghdRpDjh17GNKDQO46zvxrgoHnPSfndQLFZhzxwm37iuHRHwy8IgM4KypUvCzJFwreZhZ6Y4S1zVv2NWza0ZAqcEh3HWmUU/N6PdI9JZnN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1706
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX2Gz23jF0JsrD
 OZWlCMPHF25VHLLU+li0AswuZwpKoWJ+SAViVggReoWn4hR9SXSkqSqMtIQsdszngMP1TwQZgN5
 0hiQ/MrVgfKkmoZD0phM9C3paGmIhmQwSaGkn6zhUbf3Ddp4OUI2NgSh4sFCArNwJH7Vy0YHoac
 FqBkfuO2H8KePPeS9vcDG295gdD6jKW71N9EFcENdTXD/qKs7f8q4t2jEdLt3ynXEwZ/VxeYnd9
 B9BaQgxBVQHpR/vaAb3bt95LscV3hSm7kqF1UujvuIDC2lEi7n731YOUID+u9sj0vQR0ZdGZvyd
 EnksfvVnPXc9q59Ufd88YRU/wdTeDLyWwLSZEQxu2To5KHZr7KkVNNln6XupvF1XKdMuvnrLy6N
 Sp7tkc5YTEC33Klw+toBMLEQaRyJh/hFbt6T4W6yN0LtTaAvOUiQJkb7SY1ewFa1/5Rc8bUEWdF
 ZcGH9z/Ug8EuzX/ORtA==
X-Proofpoint-GUID: cv67muZl5dCmeaMoDxjCZjt9qc5PVobD
X-Proofpoint-ORIG-GUID: 0yOyA6ENVchULCPd4AOxOldTUnGqM-7f
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX9flThPhX61Zr
 zz0h/FGD8PfGQVwiePHHZEVhForS0t+kGplPe0ydvi7+Vj/SG0z3fiuLvNOOc75RyyO25PiU+6G
 MgowoZfcWPPomlKcQR0L4i1hx7KP/oUVMwNkadCQFnRgrEZX5VSD
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a9ea57d cx=c_pps
 a=5jDepLWPNCMdJ+QeI1Qykw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=In8RU02eAAAA:8
 a=jsYFnIEWAAAA:8 a=3-RhneuVAAAA:8 a=X_gog75BRoHvirylqrgA:9 a=wPNLvfGTeEIA:10
 a=SLORCI2Ex52a7CAF1bCE:22 a=VLVLkjT_5ZicWzSuYqSo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070130

>The device supports indirect register access to different banks. A=0A=
>specific routine needs to be followed when accessing the registers in=0A=
>another bank as documented in the datasheet (section 13). This is=0A=
>required for accessing registers configured via the user and=0A=
>implementing buffer support.=0A=
>=0A=
>Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-=
p =0A=
>Datasheet: https://urldefense.com/v3/__https://www.lcsc.com/product-detail=
/C5129967.html__;!!FtrhtPsWDhZ6tw!CMTPpmwpQnn9q5feyPtbKfDlZZxlAh6FLT3KngBIA=
t4pGu5iF9cjUawWbxpNVF6__BzwZo0XM8x2ABrLJ4I1epLGPQXws4rTlA$[lcsc[.]com]=0A=
>Assisted-by: LLM=0A=
>Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>=0A=
>---=0A=
>LLM was used to improve the mreg_check function to include the case=0A=
>where the sensor is in a POWER OFF or LOW POWER mode to utilize the RC=0A=
>oscillator for initiating the bank access.=0A=
>---=0A=
> drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  29 ++++++=0A=
> drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 108 ++++++++++++++++++=
++++-=0A=
> 2 files changed, 135 insertions(+), 2 deletions(-)=0A=
>=0A=
>diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu=
/inv_icm42607/inv_icm42607.h=0A=
>index a183a8566617..a522850e0268 100644=0A=
>--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h=0A=
>+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h=0A=
>@@ -111,6 +111,13 @@ enum inv_icm42607_temp_filter_bw {=0A=
> 	/* value 7 also corresponds to 4Hz */=0A=
> };=0A=
> =0A=
>+enum inv_icm42607_mregs {=0A=
>+	INV_ICM42607_MREG1,=0A=
>+	INV_ICM42607_MREG2 =3D 0x28,=0A=
>+	INV_ICM42607_MREG3 =3D 0x50,=0A=
>+	INV_ICM42370_NB=0A=
>+};=0A=
>+=0A=
> /* Signed so that negative values can signify an invalid condition. */=0A=
> struct inv_icm42607_sensor_conf {=0A=
> 	int mode;=0A=
>@@ -170,6 +177,7 @@ struct inv_icm42607_sensor_state {=0A=
> =0A=
> /* Register Map for User Bank 0 */=0A=
> #define INV_ICM42607_REG_MCLK_RDY			0x00=0A=
>+#define INV_ICM42607_MCLK_RDY_BIT			BIT(3)=0A=
> =0A=
> #define INV_ICM42607_REG_DEVICE_CONFIG			0x01=0A=
> #define INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE		BIT(2)=0A=
>@@ -370,6 +378,24 @@ struct inv_icm42607_sensor_state {=0A=
> #define INV_ICM42607_WHOAMI				0x67=0A=
> #define INV_ICM42370P_WHOAMI				0x0D=0A=
> =0A=
>+#define INV_ICM42607_REG_BLK_SEL_W			0x79=0A=
>+#define INV_ICM42607_REG_MADDR_W			0x7A=0A=
>+#define INV_ICM42607_REG_M_W				0x7B=0A=
>+#define INV_ICM42607_REG_BLK_SEL_R			0x7C=0A=
>+#define INV_ICM42607_REG_MADDR_R			0x7D=0A=
>+#define INV_ICM42607_REG_M_R				0x7E=0A=
>+=0A=
>+/* User Bank MREG 1 registers */=0A=
>+#define INV_ICM42607_REG_OFFSET_USER0			0x4E=0A=
>+#define INV_ICM42607_REG_OFFSET_USER1			0x4F=0A=
>+#define INV_ICM42607_REG_OFFSET_USER2			0x50=0A=
>+#define INV_ICM42607_REG_OFFSET_USER3			0x51=0A=
>+#define INV_ICM42607_REG_OFFSET_USER4			0x52=0A=
>+#define INV_ICM42607_REG_OFFSET_USER5			0x53=0A=
>+#define INV_ICM42607_REG_OFFSET_USER6			0x54=0A=
>+#define INV_ICM42607_REG_OFFSET_USER7			0x55=0A=
>+#define INV_ICM42607_REG_OFFSET_USER8			0x56=0A=
>+=0A=
> /*=0A=
>  * Timings as listed in section 3 of datasheet, all values listed in data=
sheet=0A=
>  * in ms except temp startup time... setting all values in us and using=
=0A=
>@@ -400,6 +426,9 @@ const struct iio_mount_matrix *=0A=
> inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,=0A=
> 			      const struct iio_chan_spec *chan);=0A=
> =0A=
>+int inv_icm42607_mreg_read(struct inv_icm42607_state *st, u8 bank, u8 add=
r, u8 *val);=0A=
>+int inv_icm42607_mreg_write(struct inv_icm42607_state *st, u8 bank, u8 ad=
dr, u8 val);=0A=
>+=0A=
> int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,=0A=
> 			       enum inv_icm42607_sensor_mode *gyro,=0A=
> 			       enum inv_icm42607_sensor_mode *accel);=0A=
>diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/ii=
o/imu/inv_icm42607/inv_icm42607_core.c=0A=
>index e77d72e0f7bc..6e514b8682a0 100644=0A=
>--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c=0A=
>+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c=0A=
>@@ -31,6 +31,7 @@ static bool inv_icm42607_is_readable_reg(struct device *=
dev, unsigned int reg)=0A=
> 	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:=0A=
> 	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:=0A=
> 	case INV_ICM42607_REG_WHOAMI:=0A=
>+	case INV_ICM42607_REG_BLK_SEL_W ... INV_ICM42607_REG_M_R:=0A=
> 		return true;=0A=
> 	}=0A=
> =0A=
>@@ -43,6 +44,7 @@ static bool inv_icm42607_is_writeable_reg(struct device =
*dev, unsigned int reg)=0A=
> 	case INV_ICM42607_REG_DEVICE_CONFIG ... INV_ICM42607_REG_INT_CONFIG:=0A=
> 	case INV_ICM42607_REG_PWR_MGMT0 ... INV_ICM42607_REG_INT_SOURCE4:=0A=
> 	case INV_ICM42607_REG_INTF_CONFIG0 ... INV_ICM42607_REG_INTF_CONFIG1:=0A=
>+	case INV_ICM42607_REG_BLK_SEL_W ... INV_ICM42607_REG_M_R:=0A=
> 		return true;=0A=
> 	}=0A=
> =0A=
>@@ -59,6 +61,7 @@ static bool inv_icm42607_is_volatile_reg(struct device *=
dev, unsigned int reg)=0A=
> 	case INV_ICM42607_REG_FIFO_LOST_PKT0 ... INV_ICM42607_REG_APEX_DATA3:=0A=
> 	case INV_ICM42607_REG_INT_STATUS_DRDY:=0A=
> 	case INV_ICM42607_REG_INT_STATUS ... INV_ICM42607_REG_FIFO_DATA:=0A=
>+	case INV_ICM42607_REG_BLK_SEL_W ... INV_ICM42607_REG_M_R:=0A=
> 		return true;=0A=
> 	}=0A=
> =0A=
>@@ -71,7 +74,7 @@ const struct regmap_config inv_icm42607_regmap_config =
=3D {=0A=
> 	.writeable_reg =3D inv_icm42607_is_writeable_reg,=0A=
> 	.readable_reg =3D inv_icm42607_is_readable_reg,=0A=
> 	.volatile_reg =3D inv_icm42607_is_volatile_reg,=0A=
>-	.max_register =3D INV_ICM42607_REG_WHOAMI,=0A=
>+	.max_register =3D INV_ICM42607_REG_M_R,=0A=
> 	.cache_type =3D REGCACHE_MAPLE,=0A=
> };=0A=
> EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");=0A=
>@@ -96,7 +99,7 @@ static const struct inv_icm42607_conf inv_icm42607_defau=
lt_conf =3D {=0A=
> static const struct inv_icm42607_conf inv_icm42370_default_conf =3D {=0A=
> 	.gyro =3D { },=0A=
> 	.accel =3D {=0A=
>-		.mode =3D INV_ICM42607_SENSOR_MODE_OFF,=0A=
>+		.mode =3D INV_ICM42607_SENSOR_MODE_LOW_POWER,=0A=
> 		.fs =3D INV_ICM42607_ACCEL_FS_4G,=0A=
> 		.odr =3D INV_ICM42607_ODR_100HZ,=0A=
> 		.filter =3D INV_ICM42607_FILTER_BW_25HZ,=0A=
>@@ -352,6 +355,107 @@ int inv_icm42607_set_sensor_conf(struct inv_icm42607=
_state *st,=0A=
> 	}=0A=
> }=0A=
> =0A=
>+static int inv_icm42607_mreg_check(struct inv_icm42607_state *st)=0A=
>+{=0A=
>+	struct regmap *map =3D st->map;=0A=
>+	unsigned int val;=0A=
>+	int ret;=0A=
>+=0A=
>+	ret =3D regmap_read(map, INV_ICM42607_REG_MCLK_RDY, &val);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	if (val & INV_ICM42607_MCLK_RDY_BIT)=0A=
>+		return 0;=0A=
>+=0A=
>+	/*=0A=
>+	 * Clock isn't running: we're either in Sleep mode or Accel LP=0A=
>+	 * mode with WUOSC. Force the RC oscillator on via IDLE, then=0A=
>+	 * wait for MCLK_RDY.=0A=
>+	 */=0A=
>+	ret =3D regmap_set_bits(map, INV_ICM42607_REG_PWR_MGMT0,=0A=
>+			       INV_ICM42607_PWR_MGMT0_IDLE);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	/*=0A=
>+	 * After setting the IDLE bit to 1 in PWR_MGMT0 register, wait for anywh=
ere between=0A=
>+	 * 10us to 200us which are the ACCEL_STARTUP time and accelerometer tran=
sition time=0A=
>+	 * from OFF respectively.=0A=
>+	 */=0A=
>+	return regmap_read_poll_timeout(map, INV_ICM42607_REG_MCLK_RDY, val,=0A=
>+			val & INV_ICM42607_MCLK_RDY_BIT, 10, 200);=0A=
>+}=0A=
>+=0A=
>+int inv_icm42607_mreg_write(struct inv_icm42607_state *st, const u8 bank,=
=0A=
>+			    const u8 addr, const u8 val)=0A=
>+{=0A=
>+	int ret;=0A=
>+=0A=
>+	ret =3D inv_icm42607_mreg_check(st);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	ret =3D regmap_write(st->map, INV_ICM42607_REG_BLK_SEL_W, bank);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	ret =3D regmap_write(st->map, INV_ICM42607_REG_MADDR_W, addr);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	ret =3D regmap_write(st->map, INV_ICM42607_REG_M_W, val);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	/*=0A=
>+	 * As per the Datasheet Section 13 Accessing MREGx Registers,=0A=
>+	 * there should be no read/writes to the device for 10us=0A=
>+	 * after performing bank access.=0A=
>+	 */=0A=
>+	fsleep(10);=0A=
>+	return regmap_write(st->map, INV_ICM42607_REG_BLK_SEL_W, 0x00);=0A=
>+}=0A=
>+=0A=
>+int inv_icm42607_mreg_read(struct inv_icm42607_state *st, const u8 bank, =
const u8 addr, u8 *val)=0A=
>+{=0A=
>+	unsigned int read_val;=0A=
>+	int ret;=0A=
>+=0A=
>+	ret =3D inv_icm42607_mreg_check(st);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	ret =3D regmap_write(st->map, INV_ICM42607_REG_BLK_SEL_R, bank);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	ret =3D regmap_write(st->map, INV_ICM42607_REG_MADDR_R, addr);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	/*=0A=
>+	 * As per the Datasheet Section 13 Accessing MREGx Registers,=0A=
>+	 * there should be no read/writes to the device for 10us=0A=
>+	 * after performing bank access.=0A=
>+	 */=0A=
>+	fsleep(10);=0A=
>+	ret =3D regmap_read(st->map, INV_ICM42607_REG_M_R, &read_val);=0A=
>+	if (ret)=0A=
>+		return ret;=0A=
>+=0A=
>+	*val =3D (u8)read_val;=0A=
>+=0A=
>+	/*=0A=
>+	 * As per the Datasheet Section 13 Accessing MREGx Registers,=0A=
>+	 * there should be no read/writes to the device for 10us=0A=
>+	 * after performing bank access.=0A=
>+	 */=0A=
>+	fsleep(10);=0A=
>+=0A=
>+	return regmap_write(st->map, INV_ICM42607_REG_BLK_SEL_R, 0x00);=0A=
>+}=0A=
>+=0A=
> int inv_icm42607_read_sensor(struct iio_dev *indio_dev,=0A=
> 			     struct iio_chan_spec const *chan,=0A=
> 			     s16 *val)=0A=
>=0A=
>-- =0A=
>2.43.0=0A=
>=0A=
=0A=
Hello Kanak,=0A=
=0A=
for accessing MREG registers I strongly recommend to create a new regmap=0A=
structure for handling this access. This way, you can use the created regma=
p=0A=
to handle all registers access without having to check each time you access=
=0A=
a register if it is a normal or an MREG register. Having dedicated function=
=0A=
is very error prone.=0A=
=0A=
You can have a look inside inv_icm45600 driver that have the same kind of M=
REG=0A=
registers and is using a regmap for abstracting the access.=0A=
=0A=
Thanks,=0A=
JB=
