Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020112.outbound.protection.outlook.com [52.101.225.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C623624D9
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214788; cv=fail; b=mkLvy/cclc4LVtp55XLWHUYdd+notSUa1JaxfeWLpaWZkeQOdw8cSJBuekb/Nv8utuuMsH5YOJsmTroRaqvgoYvMlcOMUCvRPiw9P3LtvxZ/nG5K3mr0cgeUvDfV8uzuwuXfPT0GuUkxE2T1P7/54Ggx4e+iShSJ96zNkpOq+fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214788; c=relaxed/simple;
	bh=3i/mFMbzruPxOk9JVXcoleKz1h3dkpI19xtUvMWfPFE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qrTJcKi75mKLAyQ+qIkv47SwCLpR8dT1kWZEqcHsIjXJQTup0rxgXoaDyr/bh9M4HgxR2E9ylzHEUM54yiAHsWb0vWDBYKwpKspcV9albaSHlai+ipjFmjASANYWgKM5Li7UDa9NnDd0XO6Gp/IeptKhejcPps4+Dc9YH2y+TSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iisc.ac.in; spf=pass smtp.mailfrom=iisc.ac.in; dkim=pass (2048-bit key) header.d=iisc.ac.in header.i=@iisc.ac.in header.b=mpc8IplL; arc=fail smtp.client-ip=52.101.225.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iisc.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iisc.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iisc.ac.in header.i=@iisc.ac.in header.b="mpc8IplL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPVSvda54a0qVDPKWZSUMdliqEr7ew0t+EKHd+Le9MS5l3Nda9hUq6uexuJzU+j7b6YqtxKDmAhv0WTlkAac9Mz0Cvxg/XOBJFtIDFXmaVOxGQJOzCrnHZuhtzEXoADgKNuaEUAbgTDBVL9u+HpjKimSQYcvWsiPJyfTe87KMcqerP93eWpBdCOXJ9kHyAALnq3oTZCUHFZEUIXj3GhnAF+FW1GkVA5t/PkrkrpzBByDTbubfOoGr4HT0J5gnQv4pZ8UJBgThIbD9P88RxwT3SJLCNBtLkkBDkZt8sJ21KAqVtKUNGuIWPaqGCDElv2NSrflzQ+cJWYD99PRlUSFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i/mFMbzruPxOk9JVXcoleKz1h3dkpI19xtUvMWfPFE=;
 b=Su5R+P87rfd8N8Wf+GFZwP9er3L9m6/yucEUjfr3ex2QEGJlVBD7LYiCAQP0i74uLyqUHVHt1VVIa5rPLpFed2Eg9hMAzz9u81zcUHhHoEIV5M42gqEqJTOpEnXh/6DH8DdaWdTrgaxCucgy4WmbsTzKzE0Xe2AdzdxxDKCT5RJPE5HvmBCKOFG0Oh+w9JzIJ6xh563vpw0N7cHalN2VWtiffxP0qv9G5L6MxIfC8gfC+bNwsm1WSu5tFlHDtM+iXAj+QduWmp6vfesVGwIRmE6ta//E55BP9KJNhD80JXKWtIbemvd4XbuARTJkEhsG/9MCSjR6Y0uCzcDVCtr0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iisc.ac.in; dmarc=pass action=none header.from=iisc.ac.in;
 dkim=pass header.d=iisc.ac.in; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iisc.ac.in;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i/mFMbzruPxOk9JVXcoleKz1h3dkpI19xtUvMWfPFE=;
 b=mpc8IplLK9YsKJJ3eHTquaot2VWST/GC/lkWTz8JBGlbbtMluJ9T1C1Yx+97A2dZu6cfH3rLSBJH90S6m0tdU70LzV9SCvKGE69eJozJope0QKo74SpsaaqgLEMgEkLWJgh14lrFVKgnc2544LqarxYKTRvpDZYOwaTIOSoez7UATCtDmkztOCl4ts9vTv/q5J5sQSkYguv/fLgUjhNg/JAfHy0dT2CzmR8xcwm5DrCqzwQIL/FKR97SVAL1OcA52UWQjCPrPtcQaJ9D0Z9w4gJr5GQ510uWABRaXNnXVJ2O216A6N5ttTttGwduGxY3HOKyHhj3m0CDJuLmq86ntA==
Received: from PN1PPFB119D6BAE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04:1::31f) by PN6PR01MB12169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2fb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 17:53:02 +0000
Received: from PN1PPFB119D6BAE.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6397:e211:a079:3bbc]) by PN1PPFB119D6BAE.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6397:e211:a079:3bbc%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 17:53:02 +0000
From: Anirudh Gupta <anirudhgupta@iisc.ac.in>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "marcelo.schmitt@analog.com" <marcelo.schmitt@analog.com>,
	"dragos.bogdan@analog.com" <dragos.bogdan@analog.com>
Subject: GSOC 2026 - Interest in LinuxFoundation IIO driver project
Thread-Topic: GSOC 2026 - Interest in LinuxFoundation IIO driver project
Thread-Index: AQHcqBHqfj+eOEzpGUaMMW0WXM66ng==
Date: Fri, 27 Feb 2026 17:53:02 +0000
Message-ID: <830DF73F-3F7D-4E83-8C30-CDBA7408E635@iisc.ac.in>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iisc.ac.in;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN1PPFB119D6BAE:EE_|PN6PR01MB12169:EE_
x-ms-office365-filtering-correlation-id: c72e6a74-a6cf-4d9f-882b-08de76290d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|786006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 M3YCZeAkG0/2Eihsbf0JZw9Y3xrCSAMGwqkmDrTPH44Z+ZvIsbchPsu9p8l1bLJPiLG/1pz8l1TkfpwbnJqrNcHoneptxvuYn2jU2+1T/w++hy7fsE5Kx93w7bxpPf4mSQaPQ6hh49SegwAl4juY3LX/KZAgfu8U7RywK1y6NQWZlUBf/pv2dlcRWWIPhDX9SeZk4IdQrIsyht3sOToI/4wjnsQe7nj4uw/YVbG4y57anhEpEM2uLraMWyM+MQBgtcaiREuuUwxmrwAbrfA3LspkIn4CJlOG0KLcsotDYvba9SXAkKY3EWwts5GX3NYoF931eRwC/NnzbIzC5KJ07cZ8fK6/CRtSYpLiMt3UWcwXjrRsRkTwKLYaMxptG6y0Im6qBBUmWzw+hYJrgwhb2dlEs4//qytJCNP0rL4LJrl5lV4L4zUqoiHpGbGMvxiYwuLsYuIEO4Kfd0SlOg2Xnx4pTZ61tENl1CwxrM595lIeoYlmlmbhxqKLoRnFo/4lHd4rjEtUGloL9jCdH1POAj7vtg2PB7qxzsu8x1RgjMKPejugHqQcklKg11NjHpJiWXs4iMwliR0OFZlkWRj69lU1S+n4veUAUhvhfxKkUX/NBd/gxmANhTZSgVerB0Y5F2Y3oJRScNo3YtFb+yT2IRuwx5kemn7y347iNh2BtksT+QQWSbop5UR30375vM7InAr3F6zAAdPvh1UtajHrCK0wJjgU6mmNQoV/wQXg+I3DEdop/r442xOdPuEbvKrKOq/Kd56ezGZHB3jmhwyGAcBxSKrP8/JdANY59YUOS90=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN1PPFB119D6BAE.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(786006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P5+Kmnkm7fHlwWL0/VvILCPx/uB0Ih1I4JV2ywoLOyI7umQbgaiBHKTB3Wns?=
 =?us-ascii?Q?veP4+LYuf1xWtF95YyWZD1hf/0s80MqNFa2WE0XmjQ1aeES3JaWAcdlzImps?=
 =?us-ascii?Q?dWZc6X0s7yoBTk/B32YaaaoCKqRYBvP5IF72ELqCbqbdysrs395prx0OH/y6?=
 =?us-ascii?Q?qKCLBTUp4bCB7t2Eh+n7YDicviG6Y1Tz65KYahR+S8K52vyAGyANBnUZTmGr?=
 =?us-ascii?Q?CX+OacxdRJ+b8izk7hxPigz7T5+8TU9eIoWZooSn2yxBWbsRnOH1OcYiR15q?=
 =?us-ascii?Q?NLprBtaw+v76SoQ+AA/JgeiN26KMjCQxjHp+QHFuODzMv18qhMGldGH8mfHT?=
 =?us-ascii?Q?UB1Nsd2Revfn6I6mlHEGcv9Whj7cmYuGxzXcLjurtN1VAH8UfbQxQtwmH4QA?=
 =?us-ascii?Q?71YPETbqLDwPqqtbukEGiRjceyDjpNhouBC844kbXphRq91HZRs9tFgW6Usu?=
 =?us-ascii?Q?Wn2r3xrD45ntn6k6Hcl8BoIJ/zbYGRtdvC0mmVjSgA2HHj1joYg/ajhxWwGJ?=
 =?us-ascii?Q?gJSYEutYE9TD/kFRmz2tPPU4b10yFgcVrZpUKIKP+8HuJ9Xtpov+Wobc3jnN?=
 =?us-ascii?Q?FlpkGcbL3t3pcOrEXOz9sy/0q2PkT7ymm4gY8KP9XtWHpjN03Tc4/Amb2tzy?=
 =?us-ascii?Q?UKLLgkqz36qjY3Qm9VoVwkhFS3dkHw0lQ2/lHN4TsmWPGqWD9qDuk6BqJS1I?=
 =?us-ascii?Q?N4dohMXH4GgvjWGpXysPUfwCFbOz9UltYJqkpbqrE12jfvv3wAL3pdptjYCF?=
 =?us-ascii?Q?zpTweik0Bhn2y21Kp5OFe4zFhUEOCFdHQbMJEnA3iwKnLUOh3olkpEvBhu1K?=
 =?us-ascii?Q?ZPj7F1TcVyjkSTa4VZSlnhPkT7E2UkxJ72m6R3RVQDri+0zYBfrQsoNg8t0z?=
 =?us-ascii?Q?5dii+08h6Kq94o2B8JWUbc4hSCtwUjY8uNNGybTUnIHPUAA9RvKItatJQuAB?=
 =?us-ascii?Q?Q0Znnh7FZc0fJhCDFOzPeciaJOhM9blMKVCHaN4uE+vYyrmIHkzikaok5NI+?=
 =?us-ascii?Q?LZ6qrvMGbMZw1lZgcFIF+8tu7TwuuEGPIJ73OvieTPPLCeFA/cC5GaB9EbUG?=
 =?us-ascii?Q?ADSB0FQ+ADndUnI5V1cvjMda3KGEKfglwKWDJklBfsYQamZ/iz1wcD2yskqL?=
 =?us-ascii?Q?EfPPmurUIBsHTOoMRnC46Nks8Z4kiA5i9hjPFybiNNNqEvv+CGuteSdJXrof?=
 =?us-ascii?Q?dBcgkMpXASlQK6zf6Hyhb4iFfvzE5pWaXuucPH3U/MF9Qn0iXR+geCcHcq6o?=
 =?us-ascii?Q?fEabQpPN6UT4nDhEiJVhrTgSvlOUp2rj5JciWuoVu2HONmb1FKiHDT9wKG+6?=
 =?us-ascii?Q?n7i1QA0t/teuh/Nv0IPfvLriUaTSxq0098TbIZm3wnaAILvMTKbjXw4uJZZH?=
 =?us-ascii?Q?HGyVWbWc6LXEMVql6c48TDrwXGsaVq/Drof3zoQdree6vA/3BOvMbRqyw8Qg?=
 =?us-ascii?Q?+veLvNShhq8jcLr9srgwrXhOHGP1Hi4U7/5YB5s2kVonpkE7fpL1EftrtLiO?=
 =?us-ascii?Q?W+of8OcAlsFCrx66B05uAMvWGY6OJ4qn63WqgBKWLupprXsPW2IhE2MtpFIy?=
 =?us-ascii?Q?tU64OAe5Dp1n2Kjr7WTWFzJs6y1V/AoWd2r4nFJgj77B6mx00L0Mi9vp1mUx?=
 =?us-ascii?Q?zx8Jxa8O/wHI+/2mwtA+cpgNiqYlvyhjIOrgBYjg4riqQ2F+RVuWHf7vMQKT?=
 =?us-ascii?Q?u7gwlc6HJpBqQmRze8Tc5YNZOVg5R0khJ38ihJP+JJa11HXKWjClAy0gdyoL?=
 =?us-ascii?Q?TJPaUaBxfMmdlwA3W4h1Krj6hu63OGw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9C134447FFFBB4A9F0577B8738CBE0E@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iisc.ac.in
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN1PPFB119D6BAE.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c72e6a74-a6cf-4d9f-882b-08de76290d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 17:53:02.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f15cd97-f6a7-41e3-b2c5-ad4193976476
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRYqnDHtNgCp+Tu384vbcwkyzsznfJhqcvAh3XEcl3o4RZVRIjZAiRzWAaCvNSFYEVN7rdBUjV6WB69/dV3r5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN6PR01MB12169

Respected Mentors,

My name is Anirudh Gupta, a 3rd-year undergraduate at the Indian Institute =
of Science (IISc), Bengaluru, India. I am interested in the IIO Drivers pro=
ject for GSOC 2026.
While I am new to kernel development, I have a foundational understanding o=
f OS principles, computer architecture, and basic kernel coding through my =
coursework. I am eager to contribute to the IIO subsystem and learn from th=
e GSOC and the mentors.
Could you please point me toward any initial application tasks or documenta=
tion I should review to get started? I am also happy to join any specific I=
RC channels or additional mailing lists if recommended.

Regards,

Anirudh Gupta
Indian Institute of Science, Bengaluru=
