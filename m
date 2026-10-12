Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730A43E9D2;
	Mon, 12 Oct 2026 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793098; cv=fail; b=bzNmRxXkXhPY8VIyyb6ED9Na4FBuLb+egi1eRwr80wwKZZPM6lEhUkHde9FKILkITmIIauM9Tq/pex+qOqyxu8d9zPi6IHmVZJ/1cbNanbTfFa0hJJxuSRSutteVVUUT62cbbfDJdB/2NY1QyNVd4G3DTBluQBBAE5+WJ1I2z9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793098; c=relaxed/simple;
	bh=Tw5LC3XJpj16mA5653MB+NeCq2mvWngeFXBjujvwTFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MNZ6Mnb59+sUCPQn2N8ij507rJ3byzsUzPta9WLS8YbIDpZOfuE29vDwswnh9iqWq5kZ0z1rZnD7YXcxp+6Ul4hHK86Zu7DS0E/yPxEB+DKohP2303LokPQKiI4Qa5EL9zEfGzv+kB9ZUgKJsS2Q16DtIfzRZClHCMkcF4WR5wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=IuB8Yorr; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="IuB8Yorr"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C54eMr2230879;
	Mon, 12 Oct 2026 07:51:00 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012037.outbound.protection.outlook.com [40.107.149.37])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4h7bqv1c84-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:50:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx9OpvNNtp6MvmwRVlWNKDXv5PsEQg14274m1QfaHZuSh8TJogrN+1C55wqt9MUCmITai1F3VYaBEufbnFcrMbbT76YTSIH6AiwqK4MFrjHiRm5w1NIraDlquRNCTQ0VZFnG3peKvNZobKgOQso+tOPQ3FROIsJVTM3RjkNHJJUz9o2flJb8nu3AhpGfzXRl+O/06plCu8euu+t4+FM80Yu8se7fM+rwgweSDnv+pSnIj6+WYcGTjCjBkFJONgcEKfhn/k1SXYeW6h3UZG5hyypfRatf7R0OdeCHDaQFcFUYkJrwEDfg6fHsqMLTtceuCru6yToLEN6qLGm9CO9vQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3/Hul4zuNodLsEAUXCzpNR2zEAXzH7+K5acG7bggww=;
 b=kC/ZNmGOh38/0BKvsvnMnOCvL3WDTBxO8qKQjmG0B13RIL9CT0ZgLo0NhhwzEzzzIXpMSfn3Y6Jce5luWO3QQdiI5lLMnkjPCwuBFG6tPD9XC6xYPahwZ/SosiwhbBV50aFM4NzFB0wAiH7zHq7tzY+jdVVhipzTjWYG5MLLjYe3V/KJfdJFhgIq1omzT83K+nIYb2MlEYi5wxvnjpdQCp8Se24CpS1fcvnYHTG5li1oLj7pWf+NSBCVqD4ENU9zm4R8q/rhltLP3iCbdd795nDwJ8NuoBLbXaBtpmT67naczjlUA+MteCggv7W4u8srUZig9cTUxda8mNpzsl77cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3/Hul4zuNodLsEAUXCzpNR2zEAXzH7+K5acG7bggww=;
 b=IuB8YorrvVU3v6w4/QxcepHchGeG65KM3BCBtEmZR66VhwNs6jJYP81QhV4huKicvGIPPvruwgHk757LEMXT4nRI5brWa3+Ksq60NHaCmqtIueTp4MEOmAAX3pZzwuQ9h/qcVFWuXFtZrXp9WbSNy5Kf9ufBl7YFF0X3rli0/14/6KSYTuRpfhEAdgf3K9zgAn/4Ur9NH1g3RiOj/8k7H5PIpj+D8E69gfTRDew6c3kU0qfYYyvllPNM+8dm3ktQbZTbCPkj7s5iOpp65QkByM1/2yxeTAHofq+Ua7hoF/5Ut6YrtQ8Shdh/7R9zHiQ2ljHPA3sYo3DPDu7LJZe/Zg==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FRYP281MB2190.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:50:52 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:50:52 +0000
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
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix magnetometer scale of Y and Z
 axes
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: fix magnetometer scale of Y and Z
 axes
Thread-Index: AQHdWTzm86X7uo5TgkyM7CJ/G8WKGrb5iiuE
Date: Mon, 12 Oct 2026 07:50:52 +0000
Message-ID:
 <BE1P281MB14264B9E6725E3B3C471C11ACE9F2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20261011045619.357261-1-kapoorarnav43@gmail.com>
In-Reply-To: <20261011045619.357261-1-kapoorarnav43@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tdk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FRYP281MB2190:EE_
x-ms-office365-filtering-correlation-id: f2dbfabc-1bdd-42e8-0d93-08df28358a18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|10067099003|18002099003|22082099003|3613699012|38070700021|11063799006|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 xNH35cIajBw7qZC0ZByG+DUAk7Ymkt87Tsi/QaeNTO4NYiyeSxc+BU1OMSQvFOJfEE6Ox3EMxwXrwYsuCGg8gx3uFbksBpi2x4y0iq8Uik27GzeWwCWSIzOyms+yL2QLhE9MjetYD/a/ghuCJQxCAYR88sWnH8kDHdf4C47zyZtmwcrWjSngGWaYH/WdEoVu2ZvDHzTkQahNL6xKmI5N5fI8zl8hVSnX93/ydAfxFZdtyyDN8Vfop5e4ZnvLtdW2lYFgjcIbup9yB1XgnqsDs2JZbXLIiGjd1dPqQPNtzMF2lVPLiWTrdkcL9lTG64gNjfbj+YfYW0t84voeZkPpfrkjLobrEkK5DxpkB44XHwXAjmsSIv7szYJBxjgPVZ1IqgX1hGJ92J/NXjiwMU0Td/eCA4+rSjpHOIRViTOwvi3ZOPIJS5DP5P4aelzq926R2HBBvaNU+22j2UO8fyDMZoNULheJj9EJCcMYrDNIj++tbXda5Dtmw26T5BBEdE8rsrIQWelNdJjNjXzWgzGggyK2r1Kyg2AOr9p36B20QMYWcPhnGjsexbpYQ6L6Hf8ehEtELfwI2OSDZ2ogsQ6nrqVWQjCYKoWYqRo/ufVzPLIhotiUpxtWbepXidbBtbZT3hQmx3EXKkW8LtQd/wpGdUf3d6lRvksamrxwgejvdsSn94ht4Opf3XFyLCkPS7vUKQrAmTfoTlnQykmTCc8YCHD46kwrmC0CtYiRy/JDR0H6NOHdidMTrUFWCyrox5DE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(3613699012)(38070700021)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cZkPfb6B+yALW8OFr4dZ4pCPotxc1gGH6rh7GgyPz5p7dmoL78y4Mvvq5+?=
 =?iso-8859-1?Q?Ycg9v9BuCMrlL0N9Kz97Hy20o4zxnniiEH0N8DmHnN45rJUHttdyWZ8rS+?=
 =?iso-8859-1?Q?s/oURnZZdIajaMtGehWxHUFAbtAAO9CSN+xGZDxv39YicWxCZsvqDVu6MP?=
 =?iso-8859-1?Q?WDytJ9uRIZT3gl+rHpolBwdAEqjxWMDbU0Bq6r5z7mZvFKN68sLohdSPwZ?=
 =?iso-8859-1?Q?2i02MoG7bLj91YkOjMbXyYb8u4aXGq4FaySSw/5SqGjTNYdLe3q40GGEOI?=
 =?iso-8859-1?Q?8IThJIulOqEg283JkjvRwZ/As4jQaLY86/o2gd6bqK0PDLtgw4iJBVWTDl?=
 =?iso-8859-1?Q?jcDKYjKQ7lDvqu+CL9mNV4sY8zf0vHQsQ7AdvNQWaAykfeA3tG0nwFYTDC?=
 =?iso-8859-1?Q?0J5VzHLpgGfkelytbqVtq5zWZenxk1FbhyBScRx6RmguflXohg1RwRhmWl?=
 =?iso-8859-1?Q?IIdebVM8QJHkmYXa3VjyiGSubwP1LWOz6v/p3Bh9F1izRWfWQYZc3OMa2u?=
 =?iso-8859-1?Q?wP8yJ2Q/KnOPJywbAGK6EAeh/5J/9f2352EkW1u8M1iqK64OjYkJL6qki2?=
 =?iso-8859-1?Q?Qdnv7XY/DzzWYwHjyxv10zTwJ2x7LYdVJxN7T+D3mj7R+Rp8uKzuLnRRmo?=
 =?iso-8859-1?Q?yFIju4x6FRFoCwGQ7Vspe4Sx8300mUimgZFtQwquCNcTPiBmczffFznsk5?=
 =?iso-8859-1?Q?lXT0QbwkdPU2emCoZbnI5qqocljLAidEQ11UPhDnA0qOQ+Sc7KBL+E+uZi?=
 =?iso-8859-1?Q?M8HVICBZ4qjZWL7t8pXccM4kUnm6TQEQ/vWLy/EsE6grdRlVXxU+myC3FF?=
 =?iso-8859-1?Q?mjRwbmN/WwBz9nhOFG2PKDzHNJwMLoncskRPBhd4Lmzm9ux+zasZ1eaRUv?=
 =?iso-8859-1?Q?NKNcy+AcafGqr5YfjoAnDYkISemeXtNK98Q/B330181fPN8txfT5KbZIta?=
 =?iso-8859-1?Q?inebB+IBe5b1NEZAoRRGxlo4jPL2UpUCZY31vOcoveG/fb/5Z3VxziukQp?=
 =?iso-8859-1?Q?BdtrFQqNW/8IJlOjUEWy5j5Q+pe1B9KLWFjNj/ESplQ7vp4VW+l0T0GVkZ?=
 =?iso-8859-1?Q?eadonuAaAE6GOn0U+2O1bAV0so8YRrElEO5hZB49ZojbFwhIS+PoImzeVH?=
 =?iso-8859-1?Q?ksjlF2L038p4bD8xZokH72OJNspYU3kV7EhdmgAjxdACxMSx0x5fKnyHmG?=
 =?iso-8859-1?Q?mUm6fJThh4Y4wEPi3Eb4t371MQdtAq4kj7n96dZG7cqjFLp1MJ9F56+KOJ?=
 =?iso-8859-1?Q?v3S1M2s8iReBVLGP5EtsVnhjOrza8TtN0u/o1TV1J0sx786DWfqYIjTczY?=
 =?iso-8859-1?Q?WvRkei5mWOW/2hYUNGuv/8H3PLQ1pp4cG2LrlkF5QfhhYcT7lOHHHrccix?=
 =?iso-8859-1?Q?UdB8AVtQ11y3PGwrmnGCgI8WlU6IM0KD73/62iA8b7zIwFHF8u2xOrF6IA?=
 =?iso-8859-1?Q?9AULCheCKHjrjhcXGKMVAh+y/tfnnD/iGAKx9x6NFnYRl6RRwQjQbiGc2E?=
 =?iso-8859-1?Q?/1bu6aD6YPrUMoNCyZ/zY5ADfyUIvZ1hK4f14vfvyAo1657Xl2rtDv9fhO?=
 =?iso-8859-1?Q?G8dDYr5whZN13FU4mqK2VzPxavunwqkbtgSjiqUWNi+HZqLdlV6+lQSWFI?=
 =?iso-8859-1?Q?Su9Rmoj//aDmnwijMoeV2xysq/ymjuZG46NF6CxC5cTQ6Yf77w9U0/rBty?=
 =?iso-8859-1?Q?6J7x8jlBj4dAS5vaye3usQ8n+HekhGhqgPlZqc80ZCl3737tMtLZnBk17t?=
 =?iso-8859-1?Q?uFGnNfzLUBIPTGS4ejeO5yDVugiRPzZYB1HmImhr7Nswffis0gU/xZRiaC?=
 =?iso-8859-1?Q?Wl5sqmRaqEE3IGxHEtdHKuwb6HSEVMo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	zp/Z03zSn5dD7X88xygtZE0IB3DCWbxOXkRKsOLT66+5o/tkoh5thCSUxEDxuJRS2WRWk5aueibNRBdVv/o0EgVwRXt76bK7QWLjWx59+G1oxwpw2HdMfBQsRDQ/HBxVMbmKLSPqT9Dy91iVDq+GpCT8aLoNjEsK14CL6kJbMrZ9olZTlxErkIYNkOyqN0nLO+oIT3yckgAWBL0jZIbqJ63WHreorhwPrEIL71D5XRqSt/TANLPwH4Mbo62fhnEvkB++ba0siuuoh5A2mxUviV4GamyNgp6pcr6fhxWAsE/g2cChvgfqVKPAUMRwZdfIHwd00I+8EmssQSfW9oEefw==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dbfabc-1bdd-42e8-0d93-08df28358a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 07:50:52.4685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClYxc0PbHGAuAOuOhbFhvKKYWqE9M8ZRqp2kKGuyG7P7OCiJkPsZawFv+8ctTE/XaPs0bLGrmI+MyBNR9Bfm4NJmcazZkJi075yLTqVMSSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2190
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iWStKKwTUYIxKFnbMQrtILzpUawoEhkA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMCBTYWx0ZWRfX2Fou9WLBBFhE
 ZpvNHOXoXWMrnq8l0zz02IJ+bxi9QRrbXe+bx6wjX1djnUnp+0XxSYrlR1Nsze+LCcgw1sAVJUl
 coszDnoCJ5Ch4nh/F/UB9Cd1EzrBdet7mMFmdSeEbNMbyoZBCjdH
X-Authority-Analysis: v=2.4 cv=GaKCDgXL c=1 sm=1 tr=0 ts=6acc9164 cx=c_pps
 a=wFjEMLvkP4Hcu5caAVgDyA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=pGLkceISAAAA:8
 a=In8RU02eAAAA:8 a=8OW6A-FS_EZx6n-9T3IA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: mBpm8bXVd5BbUU6RN9fz0AgozxIU3fQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMCBTYWx0ZWRfX9IpwHXShvWd0
 cNDnwXTfRm8ioS+2bAXHGTznefWUEdaqS4ZwLLLi92XYeyM/NGhQsdohu3fKDJzgA8PzgvycH57
 5doM52rJe6vAU0PAadekqDt+WhOO7w4mlailkzbEED18+RZ9AksHUQLZdyw11uNrs0TEOLBqWKk
 Tpm/tyWWPLeylo7fv1gjPGJDiDjKbqOHekUDpEctd7GpxxMvMt0Io7292phZaO2TE+4I+biHepk
 vo0sLKMTUPpCL8FxdE/86j8HF9V/sClAO1nQe/+TezX04/lf7carJkWZ02kKeFWabwSQ+IKv1QG
 91ac1qSRJseIgW2OgH5cfOfygHGP+6EwHlpY17mdWPicwDRFxgq6ZGJ3la/BdevPeLg87V9PN0J
 6CJhiI3kn77GmBYzu0k6PsdKBepkuMnmRQqPoH0eRoD/W4hfKQ87gqulAqqPKpZ1+t7EzJsrgTV
 YokqjULdzT3X7NWl/8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120030

>inv_mpu_magn_get_scale() returns st->magn_raw_to_gauss[chan->address],=0A=
>where magn_raw_to_gauss[] holds one coefficient per axis, computed in=0A=
>inv_magn_init() from the per-axis factory sensitivity adjustment values=0A=
>(ASAX, ASAY, ASAZ) of the AK8975/AK8963 magnetometer.=0A=
>=0A=
>However INV_MPU9X50_MAGN_CHAN() never sets .address, so it is 0 for all=0A=
>three magnetometer channels. As a result the Y and Z channels report the=
=0A=
>scale computed from the X axis adjustment value, and userspace scales=0A=
>the Y and Z readings with the wrong per-axis calibration.=0A=
>=0A=
>Set .address to the axis index (0 for X, 1 for Y, 2 for Z) in the=0A=
>channel macro, matching the order used to fill magn_raw_to_gauss[].=0A=
>=0A=
>Fixes: b1392de06184 ("iio: imu: inv_mpu6050: add MPU925x magnetometer supp=
ort")=0A=
>Assisted-by: LLM=0A=
>Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>=0A=
>---=0A=
>Compile-tested only (W=3D1); I don't have MPU9150/MPU925x hardware. I=0A=
>checked the built object: before this patch the X, Y and Z magnetometer=0A=
>channels all have .address =3D=3D 0, after it they have 0, 1 and 2.=0A=
>=0A=
> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++=0A=
> 1 file changed, 2 insertions(+)=0A=
>=0A=
>diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_core.c=0A=
>index 38c3f3b398d4..1614f49be66c 100644=0A=
>--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>@@ -1576,6 +1576,8 @@ static const unsigned long inv_mpu_scan_masks[] =3D =
{=0A=
> 		.type =3D IIO_MAGN,					\=0A=
> 		.modified =3D 1,						\=0A=
> 		.channel2 =3D _chan2,					\=0A=
>+		/* index of the axis in magn_raw_to_gauss[] */		\=0A=
>+		.address =3D (_chan2) - IIO_MOD_X,			\=0A=
> 		.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE) |	\=0A=
> 				      BIT(IIO_CHAN_INFO_RAW),		\=0A=
> 		.scan_index =3D _index,					\=0A=
>-- =0A=
>2.53.0=0A=
>=0A=
=0A=
Hello Arnav,=0A=
=0A=
good catch indeed, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=
