Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953FE44AB88;
	Mon, 12 Oct 2026 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794146; cv=fail; b=kGmlXyDEouu4XI+M0oN9zV0amaVIDUXJAEM5zuGLj4Oi66NeQZgozrJu0wBOG10BeVji1KYiLKZppaOzg1Cggsy8Ddir8oHn7gVLvUj1oKpWHokHpqDTxRvelyMnsbE5fY5TfVcCk6TWh07ZN2EMmdwOuD6zRXjTNYepxYlqe4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794146; c=relaxed/simple;
	bh=K7iFmluRZlDciShpUBxCGnD4YCb6YqF/TVJ/1KAvj6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6RU9E0VOHaJAEQGgktPqzovlhXXglIS4KSlW87atRSZJ9qM0plLu8TCVX8CeA6ihx4ON2Fln0KXnOK+p7pSFfG2sgJcMfBGbwV4XRy5bLNn09Pcm7Nd8aBz7yweQlYz2y4BAfk+fBGT4MyHN2jkhVsnB63dc2UdLKHmP4oQNMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=cQbC7Xf2; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="cQbC7Xf2"
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C54Ojh2589475;
	Mon, 12 Oct 2026 07:54:38 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010038.outbound.protection.outlook.com [52.101.171.38])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4h7eqh19br-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:54:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtSD8c42t1vhI0PvEHPY7qgJLILZ4U3kofdkUHmKniee3AQziCq6VAeym4RRGvJyWhRkZjCJGjaAL4jp8k/S3RV8TaRvetVNb3Bt9y+Aw3BhfIINrW9tAKkAt7AQkX7JAFM3PYZ+YMnIgkUHbF2NXXb32V1zblLy1O4j6YiNJ1g9fk57qDjz+aovm1qhf6jix28RT6ZGsOBjSylOYdw5D2bIQUor3my8sUfqDvNBvrzUSIL5AHc2vXg6uC/hw+THJKlpbfgipg+pIfclIO9YZESRBioFL65ZLteJrkEBK6Eoef/UX05EG/cbvybR+Ru8iZmwEafWN5COO0p1OYwF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=craLG7YiVN6cTs/CsI+9xIiRf9Uqq09lMkAoKndACiM=;
 b=inxgUwiL5TR3AnguGEgWWxjapzdtCCpBHfHZydCx/ioNGUnB356gPt7qaBw1ut/VEI+EQA9a7r1VWGrvx8xvu+1WzeEYTMXv2y3H1xLB9n2Eu7Q4Rt/07cc+sBOc7sAI0/WMgHlxAotgWIRG7WzLmP9nVuhqvEUryqrj0RXUYgTT+bNoQRFOr1xnldpTqI8axK1X0OfmFwbizy+dRODA2sHyTATUkxYNqpIG7IMTwClLAqnum45kFtdQ0rwSTlURU3TwO8lTFZfaX6l1I1FfC1mnb8GjHYp3AlhbdoTj5wbc19h3BwRMTwdf7n7sFHSr/0DaNSpcGdYKeVKDrPjccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=craLG7YiVN6cTs/CsI+9xIiRf9Uqq09lMkAoKndACiM=;
 b=cQbC7Xf20Lz5EISPxzUHIeFKwJ9x33Y6AdnxEOzlO/3XHSorX4XeBE/yKFYqtqyI37bNtBzHcvRQqjcr+yv3I7hIgI7YbwK2Y/UHOYdSvG5ncImF2GBzuhODSMtuKeQLvuevwjnOFNlWMLzFVMI7kDTIZvBeRJefBek1HpIqaC0CXKHeeunkrj1/xv2TOyeOG24a54Y6IvrHi8769ds9VEEoo7Ikvrav/nKjSV299mum5gGUS+6tls5rbrkAdpanqsvqTdbpNyW+dGgvDvyx3f7rO5M5KvgirdSBBdq2Bw43x6UIeeNPAdvBRSPFb4ONmH9qwPxN9ToJhcdnaVcO1A==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BEYP281MB5621.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:54:18 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:54:18 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix swapped accel and gyro startup
 times
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: fix swapped accel and gyro
 startup times
Thread-Index: AQHdWT0ECxc0Qa65x0ikpTN3gat6HLb5ivyH
Date: Mon, 12 Oct 2026 07:54:18 +0000
Message-ID:
 <BE1P281MB14268B8ABA5134519916E673CE9F2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20261011045710.357809-1-kapoorarnav43@gmail.com>
In-Reply-To: <20261011045710.357809-1-kapoorarnav43@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tdk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BEYP281MB5621:EE_
x-ms-office365-filtering-correlation-id: e3f8dc1c-3539-43ae-b024-08df283604f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|366016|10067099003|261009223027099003|38070700021|11063799006|3613699012|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 atmpAGMaOOaHexVx8zApOsRKzuB+IGpVeub0ffFjUXlY1aQlYOHBA4QB9cVNs3t6WWzBxfvMg9i/xDMsJq0jl3WG5j/HR9OWoiSmv8BerkqcgdGAL0GpJB83O4bXuRisBQnrw2rxMBLIOZRvR58Yp1VDsjedXoeCBmrJpn7gWuHxd6C+BNQRlwN34rOoUsrFnwKnyGVjumwD3Hnjtn0pJ3ZDlun8hLXiXjvbRocgY31e2PUdBR7jaH9P18YrETElWnhZQDlUReuljIoORjKbQrrqrswioqyJ8zvaV3H+DFrKJoB0kQaCm6280rDqgQOu8qfjMuiD9kI8KTvStUckAnX8sJJNBg6Occ1Waz8hhKZ9+WMZc2BSlv6Ej4xm78854VvHmOfHaC0clHVl3RMv6QExG9Lmpq8QgUEjb5u/E4VUxwNbn/z/b/2/RRaunjYq1jCcDwgfW4kSlxH8I+0BG0oEX7j7x652EtoqLreMmGinwf1FafhbVO8VPVCpAXcZPFO5pb/H0CwUtLY0jRjfxAygy8+so9oZJkJWmxxjI0KwtCoBsHcsJRF1CytlTOuQGnmgtmT07vUPcHje1qMNc4m/tpI9oedkPvkUqFIXjSwVeNcP27HsUg5meKy582nze0qSuTt1jioRsHmWBiPYqzSxZw+T4y3At9HKzdwTzNxSzNWhqgHvQDfkqMxUBRdnaPoJaBHzrNDlbL9icrEVjyUELRE4NLmkDor+cxcxEc/TnsDUN7TrPIxamq4SYE6G
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(10067099003)(261009223027099003)(38070700021)(11063799006)(3613699012)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cmCsw+mHZMT5AehnEeHzgfgI7wW7xSXhQyuw0ki/fGBFu+6g9HvsXmGe8g?=
 =?iso-8859-1?Q?1WVXlVDRVwxjXPQa21rbUtXukBFYH2kmbAwLkBG52TejDjdYYGedxXFPc4?=
 =?iso-8859-1?Q?C3OcQZjkzzaEPqqslDbX1pwvbM3f8eOyvMcDK1ms9C/xXnk6fWIdIYvt6Z?=
 =?iso-8859-1?Q?iGpkkyxS8dHTFWXegqbKkXUtKbggAmsOo/WdJ9U8mcqNH/2Hie4FLB6YpM?=
 =?iso-8859-1?Q?GDckTqhWLf207tbRDV1FTQFkc23TK1/buwvfkvBua4vubs1lzM4p7uX07K?=
 =?iso-8859-1?Q?dMnd8Vl1R/tcjKHYY35pStFEs2ISLxEhtdQVOGxa+ZdYomks6Edfa6SxYz?=
 =?iso-8859-1?Q?21WGYa0J7+U23YVipweN5eu0tyvaAnVrFRKjAfC5YTEeZLKtQ4/JwOWeQp?=
 =?iso-8859-1?Q?HmGvaEEE66rTxjEsK0+I47pXYfpiileXPOpWiEP3bMQhEYus28z9XsSfJK?=
 =?iso-8859-1?Q?KA8TSEfwptl2YlDuA5ELFl3ywT+hAV04Bny6cjFccBgRB1aYHs12WodWLf?=
 =?iso-8859-1?Q?PCBCqf9Bb7FUVIZuAeNay5L3uWPuBUYX25xTaEep7F972gciexo4Pp8sJJ?=
 =?iso-8859-1?Q?uQQAsYZmHx+7tN2rVUrfqzAJ7R8wNFjQzrl0N7F7TBfhKGDJuYvNmlRnCx?=
 =?iso-8859-1?Q?Y/HATr8gGGvjX4ITCZuKKFeEFjOZ6FgKxGdPYXkdBCcY6UJwJqHeeQfOi3?=
 =?iso-8859-1?Q?5yusYR92sigFGo+b1Y78rOKrLuu5+S8gV+Hop+rbBmOgVNCe/0qxo7ASCX?=
 =?iso-8859-1?Q?SnzomyCgoPcgnEKbcRPyEo/ubHpp3xqIM9jlCsLXgT5vqTb/l+vFQm/GFu?=
 =?iso-8859-1?Q?BVknukZy9os5fHVpLZL7ImKXTl9EZbMCm1M7HNTCibRL/chrbCkW0wBJ/C?=
 =?iso-8859-1?Q?JPTmAXQX0ON3eKC8p4Env3ONd7f03s56Y0yc7yM6eMPB7NrQ/v7k+EVaUf?=
 =?iso-8859-1?Q?kx5Z1Kh6BovA2eG9RE9AKynf8CyCoY7Q3D8irLM+JKsR7dZdTq9BVx5Ael?=
 =?iso-8859-1?Q?7XOsPq79y1ZtLs9FRSMRWqOGCpF2FmR621m1lrYfK3U2LP/GQ2ont2FOui?=
 =?iso-8859-1?Q?30SVeoW0LxQvvGJeel4A/rrqU7F4fwXwYO1KdiGsKsY9z96vdE8gbx78Ib?=
 =?iso-8859-1?Q?YwEjPefjcdbY/Z8sVEAkNalEqgdmnUxsxAeWzD9gsFoQdgpFCjVYabHyWI?=
 =?iso-8859-1?Q?vDhCdliN2lB4aW9JuftKVzEiA+F+NtXiw1ukX0S3KxKSHDT+cp0HH7/XAG?=
 =?iso-8859-1?Q?0D+7qkrNr22qrfWJmEZV1mtTEv0OCmA9stJ6Em5MLesQT5aD+iWqlvR/HX?=
 =?iso-8859-1?Q?LhymSsgG9PPDBe7XuDS0epNx2KFL4JJiprzPoVKSdp5o1CtBy93qS1WH8L?=
 =?iso-8859-1?Q?JJX7jFv3A550eBSjaCc7M7kmt8Oj14zGubuRprOH31xYHsgjz0i8PVGdfE?=
 =?iso-8859-1?Q?53RxmWwnd/Ax5A6L4jmZSq2rkNuH21GU8+UCTOH6GVUblsqW6nU06TRJxL?=
 =?iso-8859-1?Q?S041Y4vrj0ylj3MUbmtp3UW2i2lKKNo0Isx5azb2zyEKUJVxeB4ekFval1?=
 =?iso-8859-1?Q?CzTKC1nViicGvzknmkZfO/b4unEqKEAei3e9qUjlk34V1dBR7k0rkk4uXR?=
 =?iso-8859-1?Q?SoRoDuH/IV5tYQXOX4Yw+drS+kT85wBdf0upK0ARpBf7Eeiym/OoplxZWS?=
 =?iso-8859-1?Q?toQS1V4JUZt5TTdzhVL/WF6UIUmhDXuCfEhUdTZtMeceJoiyQ5wM9XGrQs?=
 =?iso-8859-1?Q?GDM0TcSENRc/JgUB30yy0tfpcKyYE5yHcanpTLLuyiWBzW0lhKR8RvfKm9?=
 =?iso-8859-1?Q?51TGAJ9+Lg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fANM1y346/6f/8S8Bo0C6+R+C3hIBRmpM57N1g1DWs2gGg+iWa4Uyhna8UcOksUJI/n/DbZ8rYkxwvG8unWprF8Ivv4/fpk6glqH5xC++JuNMWFuIwiSM3O/+xbv8cfwBv7JEfuPkCmwUTLO2rLOoevWWrQ27aHwnqGgtkGWU5uY965FxaKxQ2yBeaGxg5z43YWRWs1RYZft0g4CKFEXfoUBPpHvCsi/hoYPTd8RPqryuTB0suGoKx6+NXv+SCqUj/P6jb++WUXhFNS1N1+kni5lacWIOzAwl5bfgTvHN5RF59rJy3de/EuR8SKqeuhOi5w3NB6GH3u/wzEHaKTHdA==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f8dc1c-3539-43ae-b024-08df283604f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 07:54:18.6273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLGFxTnvQaLVDig7ZxrmYtSfT0sGVCvlJ8wHNANuKUJkfCYxNyj40qRN35XdGb6s6MArtMDRFOWbf69PiwEb95LqPeBjWrtisglEvS1RCpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB5621
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4AL0N7h90Dt4_Nm7QyrtM7Pln_plfHAV
X-Authority-Analysis: v=2.4 cv=FbSiV5+6 c=1 sm=1 tr=0 ts=6acc923e cx=c_pps
 a=uVqGL36Fv85oT7/kmtfAgA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=pGLkceISAAAA:8
 a=In8RU02eAAAA:8 a=I_f4t5oNeGUq6TjRBDUA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMSBTYWx0ZWRfX7v+YSzP95oV8
 XEwzTThL8DzY3ylRS5wk6r7U7AqARYWX+5Ab3YrrTn+GReTgX9URyfbdtQTCsnj5s56JL+oxF1A
 AG2wE6ki37xUhmwVs38jA0pUcf2GB0nuCaw3lm5++nE+r08nv/MfAq97aNMG5umluFSMUYMBO2J
 fLTz9QY/WQ/V9nB/WNkH7zKr4xAKFhci38dQ3m0S5DoPgKF7aSsyTCPfPl0eknrMZ7A4PdVCTr6
 S91a96K4oEG+XHClzKc44f3QcFmOLx07pxuQEHm7qNuGYZOUf+gzVze8qhliDbbh+f64A+5Nf2V
 cVyos8YRjt7KaIQwnuXreLnlkgXoIeBkcbHzN9TB5fIT+R0tRxYWBLSYneHgICC9K8mMSnjIsON
 /coyr7bftGDBNtnAqvR6Q+ipzq4mAngo9aBxHMKmHLpVTcc/Kawk9zWweChs0gDZFr536aiD5Si
 8lc+mQi/uL+ET6z0XIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMSBTYWx0ZWRfXyNv4jgMzB4C4
 k/I8Gcaqto81FA63ZMhHIW0q/mX4x/FtVfvwlsx4PIT9Bh6niUajzx9wTm6dZsLTFKhguGF8GY0
 MfT/WjF8Ftm66qvels4T39yA/cxlHxv4gt6R69qk1LWaa3/bZ5aD
X-Proofpoint-ORIG-GUID: Z3G4oy3TSe2OrqhKF7RWvTCoMFOp86gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120031

>struct inv_mpu6050_hw declares startup_time as { accel, gyro }, but=0A=
>every entry of hw_info[] initializes it positionally as=0A=
>{ *_GYRO_STARTUP_TIME, *_ACCEL_STARTUP_TIME }, so the two values are=0A=
>swapped for all chips.=0A=
>=0A=
>inv_mpu6050_switch_engine() waits for startup_time.gyro after enabling=0A=
>the gyroscope, so it waits for the accelerometer startup time instead,=0A=
>e.g. 20 ms instead of 60 ms on MPU6050 and 20 ms instead of 100 ms on=0A=
>ICM20602, and the first gyroscope samples can be read before the sensor=0A=
>has settled. Enabling only the accelerometer waits longer than needed.=0A=
>=0A=
>Use designated initializers, so each value is assigned to the member it=0A=
>is named after.=0A=
>=0A=
>Fixes: e46a36d92da0 ("Add startup time for each chip using inv_mpu6050 dri=
ver")=0A=
>Assisted-by: LLM=0A=
>Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>=0A=
>---=0A=
>Compile-tested only (W=3D1); I don't have the hardware. I checked the=0A=
>built object: before this patch hw_info[] has e.g. accel=3D60, gyro=3D20 f=
or=0A=
>MPU6050 and accel=3D100, gyro=3D20 for ICM20602; after it accel=3D20, gyro=
=3D60=0A=
>and accel=3D20, gyro=3D100, matching the *_STARTUP_TIME defines.=0A=
>=0A=
> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 95 +++++++++++++++++-----=0A=
> 1 file changed, 76 insertions(+), 19 deletions(-)=0A=
>=0A=
>diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_core.c=0A=
>index 38c3f3b398d4..b26d1d401aaf 100644=0A=
>--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>@@ -150,7 +150,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6050,=0A=
> 		.fifo_size =3D 1024,=0A=
> 		.temp =3D {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6050_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6050_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_MPU6500_WHOAMI_VALUE,=0A=
>@@ -159,7 +162,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 512,=0A=
> 		.temp =3D {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_MPU6515_WHOAMI_VALUE,=0A=
>@@ -168,7 +174,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 512,=0A=
> 		.temp =3D {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_MPU6880_WHOAMI_VALUE,=0A=
>@@ -177,7 +186,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 4096,=0A=
> 		.temp =3D {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_MPU6000_WHOAMI_VALUE,=0A=
>@@ -186,7 +198,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6050,=0A=
> 		.fifo_size =3D 1024,=0A=
> 		.temp =3D {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6050_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6050_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_MPU9150_WHOAMI_VALUE,=0A=
>@@ -195,7 +210,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6050,=0A=
> 		.fifo_size =3D 1024,=0A=
> 		.temp =3D {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6050_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6050_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_MPU9250_WHOAMI_VALUE,=0A=
>@@ -204,7 +222,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 512,=0A=
> 		.temp =3D {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_MPU9255_WHOAMI_VALUE,=0A=
>@@ -213,7 +234,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 512,=0A=
> 		.temp =3D {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_ICM20608_WHOAMI_VALUE,=0A=
>@@ -222,7 +246,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 512,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_ICM20608D_WHOAMI_VALUE,=0A=
>@@ -231,7 +258,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 512,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_ICM20609_WHOAMI_VALUE,=0A=
>@@ -240,7 +270,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 4 * 1024,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_ICM20689_WHOAMI_VALUE,=0A=
>@@ -249,7 +282,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 4 * 1024,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_ICM20600_WHOAMI_VALUE,=0A=
>@@ -258,7 +294,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 1008,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_ICM20602_GYRO_STARTUP_TIME, INV_ICM20602_ACCEL_S=
TARTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_ICM20602_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_ICM20602_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_ICM20602_WHOAMI_VALUE,=0A=
>@@ -267,7 +306,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 1008,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_ICM20602_GYRO_STARTUP_TIME, INV_ICM20602_ACCEL_S=
TARTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_ICM20602_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_ICM20602_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_ICM20690_WHOAMI_VALUE,=0A=
>@@ -276,7 +318,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 1024,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_S=
TARTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_ICM20690_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_ICM20690_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{	.whoami =3D INV_IAM20380_WHOAMI_VALUE,=0A=
> 		.name =3D "IAM20380",=0A=
>@@ -284,7 +329,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 512,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_IAM20680_WHOAMI_VALUE,=0A=
>@@ -293,7 +341,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 512,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_IAM20680HP_WHOAMI_VALUE,=0A=
>@@ -302,7 +353,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 4 * 1024,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> 	{=0A=
> 		.whoami =3D INV_IAM20680HT_WHOAMI_VALUE,=0A=
>@@ -311,7 +365,10 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
> 		.config =3D &chip_config_6500,=0A=
> 		.fifo_size =3D 4 * 1024,=0A=
> 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>-		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STA=
RTUP_TIME},=0A=
>+		.startup_time =3D {=0A=
>+			.accel =3D INV_MPU6500_ACCEL_STARTUP_TIME,=0A=
>+			.gyro =3D INV_MPU6500_GYRO_STARTUP_TIME,=0A=
>+		},=0A=
> 	},=0A=
> };=0A=
> =0A=
>-- =0A=
>2.53.0=0A=
>=0A=
=0A=
Hello Arnav,=0A=
=0A=
another good catch, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=
