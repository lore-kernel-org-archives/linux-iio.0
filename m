Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510397;
	b=QDVrwRg/ALSUOKj2eCLzs71E0ntHKVhOaan1wqdDPysV/Xa/tIMP7/aKfCl9jKD/1QdV
	 lddsV2PmL0BF4XhmpzcJVBtyBLRQ9ewdrwSoqlKHgvl6jOu49naUSZjSd13jQ5rlcDmSo
	 NtnxNzDEqbWvHbUvy6yYV621NdsDRZCAxkzws/5QU2nuYGkRHRRWmLv60A1PltU2whwlf
	 Wu9yYKTnMIS4q+15mEW3KSdq2U7wUozz18AmCsp35jNI4mIDUhZoPTdGucDMD/tTSGhOG
	 FUIPTRhk6GF2XCPkEaUkyukkIgsVsncY4AxHzJ4lrBhJeGaE5SFTvNZJNdXx7J9nIwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510397;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lBGHpPm4VF1pwdvuBZroMYa5oFr49mkUtZONNo8wTBo=;
	b=S/nKMKGDDMzL1QvfxA3zEb3yF8MsfexreOsaD6pwIaL4D116daJNKC2AduS8qPYBVEWF
	 pWz0wW3yTCx8jERhS0VCPyHFC2IoceOhwG6qk7wlyhXrbHw8hiYTCTEjeEhioqCSPHLVs
	 NdcYNmDNq3fHNVI//Zf+zRGE/Cl0wG2P5BCCjxiz4ZWFuT9VCEQgeprqko8Db0ZJ47vNy
	 Bz+Gjw1OvW3GlNjRQHPhvOjdwEP82KErwU9lTjjgQ60mKCTdr/JweFTvFVZAuw8XKoUjI
	 ztFyeGox8sxW+xL639pHuMtStPllNC8bJeLGDP+WxDA1rKVM5pv+W2YSk151Wm1cRKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=skf.com;
	spf=pass smtp.mailfrom=skf.com;
	dkim=pass header.d=SKF.com header.i=@SKF.com header.a=rsa-sha256 header.s=selector1 header.b=wzAGZsQQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.63
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DD3606A327;
	Tue, 24 Nov 2026 08:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15DD3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skf.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=SKF.com header.i=@SKF.com header.a=rsa-sha256 header.s=selector1 header.b=wzAGZsQQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkbVqKNd/RnBfJ0lla7rRVMr4SwZaXQA8LPU18byXqWQLsEH8g4RdZ9HgUXyV754a4KY4+r6sc48O5/yj0oXVIEpqirknKk4Vdq12Br4MFi4zkjIyEOXxgJ2Hj6BiyXWRSljxLsxj5iLjHPFQ0ulJm1/UfwstuarctvY8k4lfTDNwf4+1z4b8JMCdD7ghnr1HdIDMe5ij1HMFer7w74tpff2Z61vEDvcd6kqtimuW4ZoYobbalVyZF+ZWzwUf7R/qQGpsVBTEg99KfGSaXFX8+9/y8x0XMItbQFMQq6+pqWsPGC3plmduBJM+FUPzo0WKS+rFtWT+r/WI9EuRMAcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBGHpPm4VF1pwdvuBZroMYa5oFr49mkUtZONNo8wTBo=;
 b=GOgLktquqDVrenzZTXV3b1PoiOKEtb8b5jLDusj1Tzm4GiIVHebr+jCHsEGQA4y3ybKtmrZplre1wTr1tOfFbtGGlozOqn3quv3JLahoMUn0UjRLJgvIaY1drz/oulEi6bytrnub5vXYobBhMzQi9UJPq6CaZiCwHPADmHEUFMRObkqb3YdAWwGPdnN3yoD+z5FUTOpoQLjRi4zq/q2hQXG0SsLiwn7aJWAtQcx2YJGKLqv8Brg8HD0/9F/kipCr1Yd/L4tTF7YkgBMgzpkiJNF5+WYFwjj8aNd35PH6uQTIzhSbN+C7uYQFB6LxoyCtKQZ81Tir68JB+tKpYsbdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skf.com; dmarc=pass action=none header.from=skf.com; dkim=pass
 header.d=skf.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SKF.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBGHpPm4VF1pwdvuBZroMYa5oFr49mkUtZONNo8wTBo=;
 b=wzAGZsQQ/CaYq/hl4mhVjfKPH/bJMJYGSbVaZl7uTuIFj3uBlXFZl4SAhAG2X1t+50Y6nvEPS3pSUlZFtyunKuVL7Sn96MQeEkJoi1mpp4cKt2Wpm94S83IQGCo0NNlgtIZHncLRtcScc8DQ9+sDSkPyIskUcBpxQRfi41/EbYk=
Received: from BR0PR09MB441440.eurprd09.prod.outlook.com
 (2603:10a6:2c8:56::18) by AS1PR09MB501696.eurprd09.prod.outlook.com
 (2603:10a6:20b:6e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:53:14 +0000
Received: from BR0PR09MB441440.eurprd09.prod.outlook.com
 ([fe80::4d6d:2f45:42e8:3a37]) by BR0PR09MB441440.eurprd09.prod.outlook.com
 ([fe80::4d6d:2f45:42e8:3a37%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:53:14 +0000
From: Ilyas NHASSE <ilyas.nhasse@skf.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	"linux@analog.com" <linux@analog.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: adc: ad_sigma_delta: support devices without RDY
 interrupt
Thread-Topic: [PATCH 2/2] iio: adc: ad_sigma_delta: support devices without
 RDY interrupt
Thread-Index: AQHdeOJzO0Fyn6I4S0ir2HE8yRQtk7c24lOAgAYOEDQ=
Date: Tue, 24 Nov 2026 08:53:14 +0000
Message-ID:
 <BR0PR09MB4414408680F908802B0A1A358C89442@BR0PR09MB441440.eurprd09.prod.outlook.com>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
 <20261120-ad7124-no-irq-v1-2-7826c5c3fd25@skf.com>
 <awA769JyWRvSG8PY@ashevche-desk.local>
In-Reply-To: <awA769JyWRvSG8PY@ashevche-desk.local>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_Enabled=True;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_SiteId=41875f2b-33e8-4670-92a8-f643afbb243a;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_SetDate=2026-11-24T08:50:19.288Z;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_Name=Internal;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_ContentBits=1;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skf.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BR0PR09MB441440:EE_|AS1PR09MB501696:EE_
x-ms-office365-filtering-correlation-id: 2cd4ba6e-bb0e-4aea-8fd8-08df4a086041
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|6133799003|56012099006|4143699003|11063799006|261102123227099003|261028144727099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261026140227099003|261022115727099003|38070700021|10067099003|261021135927099003;
x-microsoft-antispam-message-info:
 SpckQznz1t24mGxmBZ67n6N2cKHppocOGj5abPpVItsy8tNnjCHWxkLqjeBFp8KCXwWgA/I3muC0skzY1XHrko1igqG+23w5DCt7ugsUsgzMnapeWES2SJ+tZWVsF+gSWGEjbqYhkjy4WvHOP/lDwlGrSgPr2vg8vBN5c9Cx2fyFRcDz3DFzS6Uk4hMgecKQ88xfPOSc5Jrzkd9rJCcGaj3qX+r0cigp/JgBII8U0QqasuP3E/7wqX9dpRtAZyBLL2QzhKIzZkMjSai+S5LkUrfv311++IBrVhcJOua3C2giD/LXfpB2kMpinyvuiOMCZTJwVxxCLj0qg3SDd0PNBYjFvpFuoXTHhrROL+aw4BwuOxHTP5psMa/DKgu4UhdTDdYgurCh9kjYPY3nvWycIvPkgFVbQoWpf7pvMqjeRKcCpU/HtcnIVhn86pqemPGSSNmjtK4bU4mNJT6o8rYy6HB+GHD7X9J/BSalAriXYkmZtKTcf+K9DzC+nuvLkp6axzprenrw0DXfROowCToaLdPdys2w3YCv3D/cgSCnBebny3+DL5HxVkUbhaUziqqEcGtfGcT4fZh5srZDxVeZQBbowpN6h4f9L99Qhi4PQbQ4gciHdRO+y2FKQoTfMn13s2EMbJdcbVPurw8nV9Lvtv/S6ah3yFDnFhaVqAIuEo4df6vDr80yQ20DoFQoyEIpOfwiXsMtcY4Adp5x8onk8Fgn1/EV1hD4+CWViCdEuxY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR0PR09MB441440.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261022115727099003)(38070700021)(10067099003)(261021135927099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3Z5aWNEdG5pek1YU0NrMVl6SWhtSUpxL3RRR3kvdkZyZTFITjZUc0loTEFn?=
 =?utf-8?B?TUptM2NyS0JWS1MrUlR3YVdFdDR1aTFVMUtHYWV2eHVJVy8yWDZUQnpJRUl0?=
 =?utf-8?B?RTZiaGRSWExhRTF0dG9TVzQ3M3hQc255UWx6Y1pOKzJjK1h5UkhkZnJkUWpY?=
 =?utf-8?B?NVhoclZUMlBXTTdvdmhYWEZsSWxqb0svSVZJUXFMMkxYcWoyRURoVzAzVHVr?=
 =?utf-8?B?UGkvbSs0MDVQV2Rwa2FNUW1IUkJuT2V0NmdMZmplYmtQaStoTXE2TTZqUStP?=
 =?utf-8?B?STUwOHJMbWtFWDQycXpDbG05bmdXcktOaElZTWdMZlc2bC9tMmVlQ1lZbkpy?=
 =?utf-8?B?dTV3cmZZYVIyQWdBSGxZdVhXZ0RoRllpaTFIcDE5bEFHc0NpV0RtMkNZSk02?=
 =?utf-8?B?VkgyVHA0c25XalJQSDVjQTVlL01VWnpOWG9RL0ZrQlFVVEp4UWZCTEVDMHJu?=
 =?utf-8?B?NTRyWjAwYjNDV3pKd084NHp2WWVrRUU4V0JMclJTeGlra2N2KzBZcDh3UWN1?=
 =?utf-8?B?bDAxZmhueWZFRUl3amNpR1FCWlB0d1laVllxNXY0RmREb0VVYjJZcnY2MmVL?=
 =?utf-8?B?WWxyaEVVMDJkOE5iMWFTTUQxMjNOWmhiTkd6RmU5VVc5b1Iwd0x6VVd5OHZC?=
 =?utf-8?B?U014NzViOHpnTjBhb3JNcEF2eHBmUTdSSXd6eUtwWEZjZC9XeVhPWkoxdWdl?=
 =?utf-8?B?ZG51YlRrT1phamx2MzRGNjMwODFadTY5SDZwYS9vM0FpMTVqVExXYmFpQ0Ex?=
 =?utf-8?B?STNhV3hSa0VabVlINUZMTEJjUnFyZThPRFlOa3JlSFNyS0hwcEt0YkhrMFcv?=
 =?utf-8?B?YnRuU3M5MXYwSFBzUTJJS2FwVUlqNWcvdFB2MHVKeSs5WFRiM3hLSFVISUYr?=
 =?utf-8?B?MitSZVpTL3RNcjhuRkhGTnpvNmRoM0QvMTlaRUJkUGE5U2ZabE1xUjFLandn?=
 =?utf-8?B?QjQvbnIyMndnTDZxVFBDVWZWWnJlaCtja0VjdE5ydll6Rk5TSFRCR21LeGk2?=
 =?utf-8?B?RGtFOHQzSDVJT2pxbjBlSmtCelFZSjgvTml5Z1VFZ1BuaHdIdCthTVhHdEps?=
 =?utf-8?B?b3RWanMvRVVxVFUxMVZtVkltZmlHYW9MMUozU3VGYW1uQkJsRmtOSERFdlkv?=
 =?utf-8?B?OVk3RFVhV0hRUXJHR3pXUUZrakxNK3BWNjR5VmsvaGd1U2FqeXh6bTQ2ZFoy?=
 =?utf-8?B?QWpZcmhpbXJ6VTVjdXVtV1VVTXNUUDBPcTBHcFZYbm1tQkhIZjYxcFNqNWNT?=
 =?utf-8?B?QmJZNkUzWUtnUDFjMDBod2NHMStxbmtWY3R6eG14QkxkSEIrZW5VUEZJSEFP?=
 =?utf-8?B?OGNhd3dYOE14SzJrYXV0WDZUaDMwcUJVUitkdkhoYTVWcW9zYm9mc25xZURU?=
 =?utf-8?B?Ui9wdVd6RU9KWGUwN1JPaVBIeExUVko1Q0sxTzRzR0R0dVhmRjRtWnlZM2hi?=
 =?utf-8?B?Vk5kbmYvZlB6NWsyQWhzWVRDV1dxR1VSckdIUXdpNnNIc1dGN3ZEWHRiMThj?=
 =?utf-8?B?emVuOTl3WTRoZi95blV1eHh5U1EzOS9TQ3dlS0pHOWJCUXVYQ1lRWnB3VW1j?=
 =?utf-8?B?S1NGbnZ4TTRSUHpIUTYzR1dTdGNlT0FvNlFxTVMyRGgrTVNiaTBiZ1hyYVM5?=
 =?utf-8?B?NUd5R1NHMGc4R3FYSlVENmFsY0p1N0EwajY5OVFSc0lLdkxCQkJRVWVoSVhI?=
 =?utf-8?B?eWpjYXRTVW9zanp6RndCZFE3dU9UNTBYdWVsVE5QWElsSUE1UCtQWTF5c1ox?=
 =?utf-8?B?eG1yVHF2L0FFR3Rkby9aYkxXc2poa0VxSTdnOWZNZW9YK0s2OHgzNzVSSmty?=
 =?utf-8?B?NENiNUZuOU4xcE8vYTBpRmc2QW1lMFl4QUVMOEl6TldGbU1JQWx1MUNFWmFy?=
 =?utf-8?B?WENsWGc5QUxVVkVraUV5T29Mc1BJVmtIUzV5KzJvQWxQSXlkWE5TRFFqY3d6?=
 =?utf-8?B?MExlTlRaaGdWZW5GblQzQjRmMXlheHlEd2tSWkhiVnhYaDUwMWF6MXBEYTB3?=
 =?utf-8?B?U2pNUHpUZ1lrbXNFekVFUnBjbDF2OVN4TkRkeTlqcTcvdkVhTlhtbVhnUHdJ?=
 =?utf-8?B?clJ4R1p2cHMvODBJQjhKbjNHaWw0czdLSUd2SU1tem5sVmhHbzVYN1NLbStv?=
 =?utf-8?B?SnFRM1JKSUFKcDZCN091ckkzT3QyeHN3WjY3Zk5qRFh1eTg1bnlvSTNOTmRj?=
 =?utf-8?B?VWRqYVdvMFVzRlREZldianEzWmREcnVNQ3JCU1YxaGV0TFBSVVNtTUZETFZw?=
 =?utf-8?B?eEtmTnczU1JpN0tYa2VRNkMwZGt0M00rb0ZmaU1VT1QzSFRRMjJXOEh5RWtL?=
 =?utf-8?B?NnU1UFFkRXl2WkdhelVNTkVBWmFGZFRzZkVOS0dHM3VXd1JKcWdSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: SKF.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BR0PR09MB441440.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd4ba6e-bb0e-4aea-8fd8-08df4a086041
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:53:14.4602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41875f2b-33e8-4670-92a8-f643afbb243a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRiKnu2sn8O+7bM1MfLZ85GjlQDx5cyLojRRXJCPVdAnXMU+6lDENXJ5Of5SUrhoPcPgheoBEGcsgi4kBJ0PVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB501696

T24gRnJpLCBOb3YgMjAsIDIwMjYsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gRnJpLCBO
b3YgMjAsIDIwMjYgYXQgMTI6MjY6NDhQTSArMDEwMCwgSUxZQVMgTkhBU1NFIHZpYSBCNCBSZWxh
eSB3cm90ZToNCg0KLi4uDQoNCj4+ICsjZGVmaW5lIEFEX1NEX1BPTExfUEVSSU9EX1VTICAgICAg
ICAoMjAgKiBVU0VDX1BFUl9NU0VDKQ0KPg0KPiBUaGUgbXVsdGlwbGllciBpcyBkZWZpbmVkIGJl
bmVhdGggdGltZS5oLiBJcyBpdCBpbmNsdWRlZD8NCg0KTm90IGRpcmVjdGx5LCBpdCBvbmx5IGNh
bWUgaW4gdGhyb3VnaCBpb3BvbGwuaC4gSSdsbCBpbmNsdWRlDQo8bGludXgvdGltZS5oPiBpbiB2
Mi4NCg0KPj4gKyAgICBpbnQgcmV0LCByZXRfcmVhZDsNCj4NCj4gcmV0X3JlYWQgLS0+IGVycg0K
PiBJdCdzIHZpc2libGUgaW4gdGhlIGNvZGUgd2hhdCBpdCdzIGZvci4NCg0KT0suDQoNCj4+ICsg
ICAgcmV0ID0gcmVhZF9wb2xsX3RpbWVvdXQoYWRfc2RfcmVhZF9yZWcsIHJldF9yZWFkLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXRfcmVhZCB8fCAhKHN0YXR1cyAmIEFEX1NE
X1JFR19TVEFUVVNfUkRZKSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgQURfU0Rf
UE9MTF9QRVJJT0RfVVMsIHRpbWVvdXRfdXMsIGZhbHNlLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaWdtYV9kZWx0YSwgQURfU0RfUkVHX1NUQVRVUywgMSwgJnN0YXR1cyk7DQo+
DQo+IFdpdGggdGhhdCwgd3JhcCBvbiBhIGxvZ2ljYWwgYm91bmRhcnkuDQoNCldpbGwgZG8gYXMg
eW91IHN1Z2dlc3RlZC4gSSdsbCB3YWl0IGZvciB0aGUgb3RoZXIgcmV2aWV3cyBiZWZvcmUNCnNl
bmRpbmcgdjIuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldywNCklseWFzDQpUaGUgaW5mb3JtYXRp
b24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgaXMgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNl
IG9mIHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZCBhbmQg
bWF5IGNvbnRhaW4gaW5mb3JtYXRpb24gdGhhdCBpcyBjb25maWRlbnRpYWwuIFBsZWFzZSBkZWxl
dGUgYW5kIG5vdGlmeSB0aGUgc2VuZGVyIGlmIHJlY2VpdmVkIGluIGVycm9yLiBTS0YgZG9lcyBu
b3QgYWNjZXB0IGxpYWJpbGl0eSBmb3IgYW55IGRhbWFnZSBhcmlzaW5nIGZyb20gdGhpcyBlbWFp
bC4NCg0KRm9yIGluZm9ybWF0aW9uIG9uIFNLRuKAmXMgcHJvY2Vzc2luZyBvZiB5b3VyIHBlcnNv
bmFsIGRhdGEsIHBsZWFzZSB2aXNpdCBTS0bigJlzIFByaXZhY3kgUG9saWN5IGF2YWlsYWJsZSB2
aWEgd3d3LnNrZi5jb208aHR0cHM6Ly93d3cuc2tmLmNvbS9wcml2YWN5Pi4NCg==
