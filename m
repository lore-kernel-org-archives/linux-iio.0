Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795520068;
	b=yvyaIDeTS7rPc1SHXPsExe2XUYvwZD2db9ozmB2tIUJ2FD7UEZaIPzQq1xlCahcrdzqY
	 SzbJsIX+i0kJW2w+XTu+JZZHeziGyoiVphKgVSAghlXlKIcKjZ+87v1vQM+CS9PXZ1SQb
	 3A5ZM2dAKXLRY8AQ/Yd/vY5W8pCdPCZnD1TDjNiHHzZT02nc8Zy9l62TwYZ6dfNu4fILo
	 zt9+keRGeBd7O5lHGYtRYxRKljipmN7IR1T7UFKl6+8I8/rOUJO0gsMxT/a1EbPZYAGDx
	 nr2V2lbqWkE5klTbaqVgOF4rhDUkhLsWjinrO+ifLw9hg1v+xbrDyxV5KxiZLXbrR4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520068;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ddEa9uk/C7yTslxG7GcjHr+HoLV+m1xzoTijuZB1ahM=;
	b=jSdSBnZYkoAZ7ThNsVkohIZK4KAJ6ubEFgVexOjts0wVKotfpXjsoSH1LIbAALN5Crau
	 NF5YA5Xo18dXQ5b+yOLcbvb37bSbPMzbOMITwhkyjyUnkQi2ybUpiRG1TnSiDZSUWKqDV
	 xXXFO/tFkeQsjZLOMUhkpRUGZjAX8J4tHba9cjwExqBFRolM1cdnrWTEyT/CRFV549j4r
	 0BQfqqyKWpi0I1tKnDYsQghTU81gaAPwBeHcLVQZ+GkkUTjdS2lCQ3Yjv8gUHKtqdhlVT
	 l9edMz6uU0Gzq2UVNvUee/nDuzTits018MFfdgdYzuiV4TZV8rCFvyFP/U7QL1JytnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dFQWxOS4;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=u8+U0L7P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE7606A31E;
	Tue, 24 Nov 2026 11:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0CE7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dFQWxOS4;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=u8+U0L7P
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvVhx3110202;
	Tue, 24 Nov 2026 06:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ddEa9uk/C7yTslxG7GcjHr+HoLV+m1xzoTijuZB1ahM=; b=dFQWxOS
	4w1P1sptMdsY7pm1y+MhV+LyYd1sIvicKaZdN0rUuO9DY4BZlkvC2BFgLA1kjJJx
	oyeCqB81+ZtwbFALCYFqKfxXTh1dp7NYOssuWL7M3dblO6cQezuwG72cIO5EZeaS
	T3koDtrrgxzcaIjCeZ/Kg03YYLeRh8bRLGxf3YISEuPOwUW1+wYUwlpeyRqwPK49
	fwJ4WBNORr/twAiRv31T0xteUKNnuqv/pqW6Zytpo9hETmsJZ1l4ePagqqNRLdQT
	frGy0pjfYQyTfrOmFB5hmk9rQD7OWPrI1Nu3j+f5w5LnMAxERClyAeQbQL2gGDFf
	rGhjaH02gItojIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ddEa9
	uk/C7yTslxG7GcjHr+HoLV+m1xzoTijuZB1ahM=; b=u8+U0L7P7pTBPCI44P6oi
	pM2aGtq7cPABu8VGUw3wv3kO2MkB6oKZXy/COmP08ljJ8wLM8NQCYpBBc/ZalAqD
	DQkR8U8iP5hManTpKMX+FGNEEusH6jg/uufwkEj0hJrLIgGO3Hpt9iCvg5tX7LXl
	14B+IhwheUxinKfncH+U7AexCG23DWpNfrM9YIAFFVCmCqwo02QRsHXS5uEXODmZ
	IYt8hpcifeRxx+Cja1iJ1vBmCpX66H5BGivBLwdPvmtFg/vBtRhnFygvOnWjGOpK
	vraBJG1v4uOAbipGIwuY+Q1Mekjig2MGeUfLRHJI4dYAECARLG8/NiU/YaNElToJ
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j4bfa93rs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:34:08 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbFb/6FfJPpErYaULaRwrUyQl3vtRQ7Ao4FRX0ToKftGDSdXbizGlohtEWOrf1eGQyrEfjcHHiDaVIjpWPz/HLdFQk+hYwhJuVX5Acy5pWg351LiYKZS/k9rKQyOP+/nNPIfUk4lrZjG5i+6CfcOxLGRCSGmb5G2y+MgZXmqQsGNUN6SEJGQS1qCG5VOlklKr/lHk6iWDRDwb/5NNbVtOFfoR8mWDxhTsjJ2fdNzOcubMpAWVCGMPzfZwip0w7kksQcdhuClvpcAJsFxXtjorYPX/awmLvKWbQzNWGG/vwLfKai8nkh8Dr+IJSb6RH65VBL6/dHiOBsujLcL/IXsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddEa9uk/C7yTslxG7GcjHr+HoLV+m1xzoTijuZB1ahM=;
 b=fIWQLdnxIOY9gBEdDxcYQ/R9+k8ISEvhtgUpqD9SHAwDJveo4Xy/hJUyN3308X8iNAYRQ2I2ggjfGrVzKFVzAKruN5MmDmYIqyH8QC8XpGoN4SuN3rwLOe8cDmb5lfPS1qItAejHD+e27RWe2LD+O3SGDMpKPZdSLF7aYBw6cNGC27B34A6U1adhb60dBT8M5dOxxFOhKr8kNGyNuErOVWt//McdlBI+KY2XVBvjP5i1j+y5r7l8K0DGcsW1qaf5aiQRrSVM21o+kHEKH33/Ej6sHT3zXp3xmjPm/Rtdv5vlffO+lescAJPfzAnHG5g9JwONEALBPuVvXBldT3Xktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by PH8PR03MB7246.namprd03.prod.outlook.com (2603:10b6:510:239::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:33:14 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:33:14 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan Cameron <jic23@kernel.org>
CC: Shehryar Ahmad <shehryar.amd@gmail.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "andy@kernel.org" <andy@kernel.org>, linux <linux@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Budai,
 Robert" <Robert.Budai@analog.com>,
        "Miclaus, Antoniu"
	<Antoniu.Miclaus@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [RFC PATCH] iio: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
Thread-Topic: [RFC PATCH] iio: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
Thread-Index: AQHdXI4zfW8pmwGcuECudWohT/jAJ7c9U6Hw
Date: Tue, 24 Nov 2026 11:33:14 +0000
Message-ID:
 <LV9PR03MB8414939C448E9B624C75B9FFF7442@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260925110239.59320-1-shehryar.amd@gmail.com>
 <20260927185929.70635769@jic23-hlaptop> <atCl_aZSFGLu5pf6@nsa>
In-Reply-To: <atCl_aZSFGLu5pf6@nsa>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|PH8PR03MB7246:EE_
x-ms-office365-filtering-correlation-id: 87a9a55f-6e0c-4dfe-7377-08df4a1eba39
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|11063799006|56012099006|261026140227099003|4143699003|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 f9ROMOmoUUt20KqOrSDL2KFEueh8BS1H8VxdVwrdu7FbItsoiq9tISRMkF9Q+T9hMkjEDOUHa6y9l4y6wQDBi/JoaGVKVmJO6OdCi/gKHscKIDgH0DfdbHU5f3raboE1gVW40cD5Sm+P3YwMQ1kochxY1NxPou+1vrzqeBjmEoeFbtzwXSTY8kB66q+fZEi/fCGZydwsBFHF2iixLMGSKZlzFUMPP/tlYX+Z911maPWPWGFu6zC0MaV7TRlEj7mCBqOtdV76RG5Z1ijHHLrwlmf3UgCCKQM/8/aOsju4JdxhqS4DpF1aeepmn/5fWSzHNk1A8R6piWoAgQwgjV1+L0vT9hUL/9L3R9BNZZFbkJlX1/IbGx7shQpFfpPAFctQe1iU9ffPi049oZNEsBqggP59abuXwXqnLeqZFg6czdcfGujT9kEiAB+8Nl43vRYx8yL6oG0W/qDIDdL/CqE0brlMwpGV6I+v7f9es34ZAnGSLs5LxGZPUjxPNDzo1mek1O0BQNje9wNWtihsmSA0pmnoSOPzMvwW4XcTfiG2STEevO6aILjHmTunMFSl8lykYnZu5SiNNs90+JX6s6hm6vfQb8b7QyJ4vHoBCPd9Q5rAbTkCaXtLXDdbt4LpatQ4syhSwY9FjZIH3N2l3jK16LAAxuNPkeC2QGtICjEvaaXNz2yYVX2qbdPsT2rNMF6DlqxDdT3VDEd8IavRMrV4Ak2ANzdDPYpulJEtAAyDZiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(11063799006)(56012099006)(261026140227099003)(4143699003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXlpRHEzMWRDVVpnQTdvSEYybHBZZkJhNk9CSDYzU2VjMlU2MmF4M2Z0ak5P?=
 =?utf-8?B?eDFlN1hTTENra2hwNGVrYktWV05tUWNMWHd6QjRiY1ZNYmYxSGM5VEFPeXN3?=
 =?utf-8?B?QUVEK3JSbE5ORDVzOG9kZnNIdTBiQngxY2U2bWIwQTgzZTFGMXdNUi9JQTU0?=
 =?utf-8?B?Q1RqdEdTZmoyZHlrMndPWEZaeC9LUDUvektZU3UvWkF1VWxkZlRlcjFJbkNu?=
 =?utf-8?B?YXZsdUNrRTRvZDVBN2tGbEpvek5sY0JEY0daZWlRdHM0UkNBZEF4K0UwUDVP?=
 =?utf-8?B?c0Zvdm41QXIyMjFCN3A0MnQyZnEyUnN0UkNnWStrbzNRblZlc0F4RkRZR2Rt?=
 =?utf-8?B?dkZMRFB2Z0JrSlMvVjNraGttOVpHR3BiL0pqRDJyTG45UG1yd2VLRGphVDJF?=
 =?utf-8?B?ejJsTFUreFhDREM4VnlkQkp1SXMwQVloNk5lZVpmSzZOZFRjZGo0bDdodFhk?=
 =?utf-8?B?UjVNcHByU3cyU3VGbWZjc1BQWXdqMXdnaW1qcmkweFRSRTRnV0NIbDJhTkty?=
 =?utf-8?B?eE9QeVo1Z3ZINzc5bldjSFhrYjRBaElBeXRwT2pDeVliWERRdVFJWXBreDM3?=
 =?utf-8?B?VU5ld1JZT3ZreUNCOEtoVWhrS1ArY0VucTlKZnN0bUJtMFpHbmVXYytqaVJ4?=
 =?utf-8?B?ZEVZanFKVXNJSXhnYUk0Zm5XRy9sZndzZVpTdmpKS2FFODVFeDZFUUR2M245?=
 =?utf-8?B?NzZEMEJMMjNiSWpRV3QwM3lBS0I0TzRvY3BYekJUQnpITWYrWitGaVJ2bnAz?=
 =?utf-8?B?UDg5WmVUb3RybHVBbmJMSVhsdWRIc1RTcDJ6ZjlCQ2djKzF4ZVBQNXhteUww?=
 =?utf-8?B?b1RiVEZHRnV5NmlDQlpEMWk1RVZsQk5UMUNXYzBpMnBxMnYwSWc2VWZYQnhY?=
 =?utf-8?B?YldvRDdOU3R0NXVDY3I0cVMwZUtBWEJYVXVjNS9sUDQyN0ZTbUIzVVhpMEkx?=
 =?utf-8?B?OFNMSnNYQ0Y3aXNVYUdZaDY1bVNvSHlYQ3JneGtGbUhUNisvdXhsM3BKQW5U?=
 =?utf-8?B?WkV2c2w2bUhwYVMyNDArRWR6cjFnQTFuL29uZ2tUbDllZEdlTzZQTlI5YklV?=
 =?utf-8?B?YXA0WllmcTdNbkRVK0t4aGdWdHhGZ2thbTNYMnVGVFhGUkVDanpxQXdNSjQ1?=
 =?utf-8?B?ZTlTWU0wcmJhbmU3VDlvYmJva0RLOEg5dWhiQlh3ZGVoL1R6SUZNUXRvYTBL?=
 =?utf-8?B?RTRpOERmdVZjUjhBU0ZnaDhMb0dUYXRaWmw1Sm9lSUJ2WmxJbnRnSnRKV2dq?=
 =?utf-8?B?ak41eVJkSTFxeGNhcis4WFFhUjlyeTgrWXZTVi9yMHg5bGF0SnRTZVpDQ0F6?=
 =?utf-8?B?Z2o3RFNLS2Y4UGk1ODdkTUpwd2JtaDZrZG5pL2VBQ3I0dWxBRlhiWjV4emZz?=
 =?utf-8?B?dnRLa1BrR2VPaDhHMEpIcDd6UjhGbzhIMzlTd3FPRFJiWWZFZFRCRXVGbGQy?=
 =?utf-8?B?MmNoeW5panFMaTl3dStqK1JMSmpFRmNhR0lsdGk0a2RReldnTVRZWDh3ajhX?=
 =?utf-8?B?SnpranBvMFdUVSt3MWFaUURjYVJpbzU5RUd6d1BIVjcvYm96VEVMS0NXUGZM?=
 =?utf-8?B?dFM3NHQ3cWVwN0pYZk04S3Y0VjRERThqeENlekY3SlZ5Uy9BWVpYRUR1ZVhM?=
 =?utf-8?B?K05OSExjUHdHVU1mQVZKTjJDbWJ3SXpqVm9sUnlCcFo5RmtkdS9WYVBMY3FZ?=
 =?utf-8?B?enZtbzFJNE1YSENIbm45WjRPenFyTmtBQXIwc09ZNGIxcnIyelBnd0phUUEr?=
 =?utf-8?B?L0sxNU1NczdZbUJPL0FCQmFqMDJEbUNmdVN4Nm1oQVF5bXQ3Zi9pTkJJTm9x?=
 =?utf-8?B?QmliOUwrZ3poZDBnWEpZT3lxbm02SlRkZE9naG1YVjQwM1dxRVdqczQ0dElH?=
 =?utf-8?B?N3hPMEx3TWhEcDhqdEFlYkI5NWQyYkZzNVRaUDZvd3pPZVh1T05aREtHdThM?=
 =?utf-8?B?aXdRektXYVNoNEZIbGdWRC9SbFQ1UkFsZ2ZXUUhMRHdyT1h6LzFhc25qZXhZ?=
 =?utf-8?B?YjZaT0xYak82M3hFYUoxanJPSHF4dUVjaGtPYlR4NWVhbk12bFA1SDlEOFhJ?=
 =?utf-8?B?VERwTHlvT0lXQzFVOFJPQ2tWQllvemNMNHZ5MkkrMFpxTkRmMUhSdG9GeUp2?=
 =?utf-8?B?S3VQTUY4T3dRaDNRU0tNL1QwNHc5QkJNM3Z0NGNJK0FNTWtBUVBTV2VJeVJl?=
 =?utf-8?B?R2VKbjZTWFVOK0ZteDhaQ0pXZEhNbGZlWUJLRVBHZzZjd2luVGdOemRCMk9Y?=
 =?utf-8?B?TDh0c3V4SUZ3TlNHYVg5SStaTXBzRUdVNVZYdTF6K1R1YVFJaGdqWXppdUxv?=
 =?utf-8?Q?I12pbaCJ2/LU75YNkh?=
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
X-Exchange-RoutingPolicyChecked:
	UlvNmP7D+gEx+hcXBXV8gULBG51s5P02PmqPp0TtyCa9wqEZsdyBANIewL7ELrIO7039xNNcikXKaYxeNyRK2ahTmisZg+pWQX0NdwodnyVSDXwbzCBHplQWfgYoWL+4pM4EPX737rzlQmE8Q6J8zAh1f303HxiZcjNDVVA1wVoKMRSHTqilbsfHR1zu42XU0hpnq2/GzAfcQdJDBDR9S5uo/GDhTa40wuMy3eSaRfU8WiTnjpOLYEKjyfc3NtbeVTq7Rwdzql8g41wJBxK0Scsp6aAGZ22b9n/CETARqyyQNtSPsxWq4gN6YhdRnzMZrI2RRCgP8vqV/90d5564JA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a9a55f-6e0c-4dfe-7377-08df4a1eba39
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 11:33:14.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VETgwKQdD+9GLxJweNH/psG2pX3FkK1ECnU38qetsKKZk7rag8bp0C0Rde4rL2zOLqj1jf5dtYtz583A7k7z9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7246
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NSBTYWx0ZWRfX03QWQ8pkAvrg
 /Tm2oYbo02bD84wdpqJEtAo7/6m/1eCKSVnktDORosdVginGjHfd2tAqSTOktDq3hgiA7/u/3Ra
 8HSCJgvGOQk7d7i5T+yxqpCZUOXXR0LmvzSodpZMm18jSMAU9d0TznsA1TtXkuKvNuvHmSzDFpW
 3R3izEoTEIVRFrUoWQ7NEj1x3RGGsh76wS2fbjfE+FF2ym9k8VCcc2PiGMHc+Yll+oLcAdlzvZ0
 v+2B5DD4G3N0zxEPs/Yl2M5rYscjSG1fw+wIIX4vNw6B/ZTeZSToF2GxWTq/MKfAVsHszDEVKou
 5ZCSrkvCSDPelRfHDDApUaGxrnEGXIoVDfRwFdpjAEEddDWXTCJ/LMdjlzF/R5bax1v74CpFGAj
 Vg1cS518sz6RXW/Fkdn9lBIHAVgf2godU7n3hKtBE1RO0ylnORzlqbPLJXcOhSqDUbAPyFZxGH5
 3KXxhaddAFMBjW8oPOQ==
X-Authority-Analysis: v=2.4 cv=OK+yTiaB c=1 sm=1 tr=0 ts=6b057631 cx=c_pps
 a=SEJ8dOKVafy+qjyLYqUPAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=NpVCT-QAd54ZNhG2DuYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 09VlJpIuyYvcmGLRzPThM2PoBa8lZBzG
X-Proofpoint-GUID: 09VlJpIuyYvcmGLRzPThM2PoBa8lZBzG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NSBTYWx0ZWRfXwtOxJAEiSKbf
 naE9wIfcEqCYlXLz0qfejePQfU0uFb1hY2gRdeOepBWPXt3NkPKRR5fbzK3U8lG0NzylT2zj6sx
 xtVlsEXBnv0QZu4GJtXUInBOG1ptpyLG33sYj9xUc7uO6V+Aq7kH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240045

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYSwgTnVubyA8bnVuby5zYUBh
bmFsb2cuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxNSwgMjAyNiAxOjE3IFBNDQoN
Ci4uLg0KDQo+ID4gPg0KPiA+ID4gV291bGQgdGhpcyBiZSB0aGUgcmlnaHQgYXBwcm9hY2gsIG9y
IGlzIHRoZXJlIHNvbWV0aGluZyBJJ20gbWlzc2luZz8NCj4gPg0KPiA+IEl0IGlzIGRlZmluaXRl
bHkgcGxhdXNpYmxlLiAgRm9yIHRoaXMgSSdkIG5lZWQgc29tZSBpbnB1dCBmcm9tIHNvbWVvbmUN
Cj4gPiB3aG8gY2FuIGFjdHVhbGx5IHRlc3Qgc29tZSBvZiB0aGVzZSBwYXJ0cy4NCj4gPg0KPiA+
IE51bm8sIHlvdSBhcmUgbGlzdGVkIGFzIGxpYnJhcnkgbWFpbnRhaW5lciAtIHNvIGNhbiB5b3Ug
Z2V0IHNvbWVvbmUgdG8NCj4gPiBsb29rIGF0IHRoaXMgcGxlYXNlLiArQ0MgdmFyaW91cyBvdGhl
ciBmb2xrIGZyb20gbWFpbnRhaW5lcnMgb3Igd2hvIGhhdmUNCj4gd29ya2VkDQo+ID4gaW4gdGhp
cyBhcmVhIGluIGxhc3QgZmV3IHllYXJzLg0KPiA+DQo+ID4gT3RoZXJ3aXNlLCBqdXN0IGEgY29t
bWVudCB0byB1c2UgYSBMaW5rIHRhZyBmb3IgY3Jvc3MgcmVmZXJlbmNlcy4NCj4gPg0KPiANCj4g
SG1tIG1pc3NlZCB0aGlzIG9uZSEgU28gdGhlIGlzc3VlIGxvb2tzIHZlcnkgbXVjaCByZWFsIChq
dXN0IGJ5IGNvZGUNCj4gaW5zcGVjdGlvbikuIEp1c3QgbmV2ZXIgc2F3IGl0IHNpbmNlIHRoZSBt
b3JlIHJlY2VudCBkZXZpY2VzIEkgd29ya2VkIHdpdGgNCj4ganVzdCBkbyBidXJzdCBtb2RlIHdo
aWNoIGlzIG5vdCBhZmZlY3RlZCBieSB0aGF0IHBhdGguIE1vcmVvdmVyIEknbSBub3QNCj4gc3Vy
ZSBhbnkgb2YgdGhlIGFmZmVjdGVkIGRyaXZlcnMgaXMgcmVhbGx5IHVzaW5nIHRoZSBJSU8gZGVt
dXggKHRob3VnaCBJDQo+IGRvbid0IHRoaW5rIHRoYXQgbWF0dGVycyAtIHNlZW1zIHRvIG1lIHRo
ZSBidWZmZXIgd2lsbCBuZXZlciByZXNwZWN0DQo+IHNjYW5faW5kZXggb3JkZXIgc28gbm90IHN1
cmUgaG93IGl0IHdhcyBldmVyIHJpZ2h0KS4NCj4gDQo+ICtDYyBSYWR1IGFzIGhlIGhhcyBiZWVu
IHdvcmtpbmcgd2l0aCB0aGVzZSBkZXZpY2VzIGFuZCBvbiB0aGUgbGlicmFyeS4NCj4gDQo+IFJh
ZHUsIGNhbiB5b3UgZ2l2ZSBhIHF1aWNrIHRlc3QgaGVyZT8gV29yc3QgY2FzZSBzY2VuYXJpbyBh
bmQgeW91IG9ubHkNCj4gaGF2ZSBkZXZpY2VzIHdpdGggYnVyc3QgbW9kZSwgeW91IGNhbiBqdXN0
IHR3ZWFrIHRoZSBkcml2ZXIgdG8gZGlzYWJsZQ0KPiB0aGUgYnVyc3QgcGF0aCA6KQ0KPiANCg0K
SGkgZXZlcnlvbmUsDQoNCkkgdGVzdGVkIHRoaXMgb24gYW4gQURJUzE2NDcwIChhZGlzMTY0NzUg
ZHJpdmVyKSBvbiBhIFJQaTQuDQpUaGUgQURJUzE2NDcwIG9ubHkgdXNlcyB0aGUgYnVyc3QgcGF0
aCBpbiBtYWlubGluZSwgYW5kIGl0cyBjaGFubmVsIGlzIGFscmVhZHkNCmluIHNjYW5faW5kZXgg
b3JkZXIsIHNvIGl0IGRvZXMgbm90IGhpdCB0aGlzIGNvZGUgYnkgZGVmYXVsdC4gVG8gZXhlcmNp
c2UgaXQgSSB1c2VkDQphIGxvY2FsIHR3ZWFrIG9uIHRoZSBkcml2ZXI6DQoNCgktIHNldCAuYnVy
c3RfbGVuID0gMCBzbyBhZGlzX3VkcGF0ZV9zY2FuX21vZGUoKSB0YWtlcyB0aGUgbm9uLWJ1cnN0
DQoJICBwYXRoLCBhbmQgdXNlIHRoZSBnZW5lcmljIGFkaXNfdHJpZ2dlcl9oYW5kbGVyOw0KCS0g
cmVvcmRlciBhZGlzMTY0NzVfY2hhbm5lbHNbXSB0byB0ZW1wLCBhY2NlbCwgZ3lybyBzbyB0aGUg
YXJyYXkgb3JkZXINCgkgIGRpZmZlcnMgZnJvbSB0aGUgc2Nhbl9pbmRleCBvcmRlci4NCg0KQ2Fw
dHVyaW5nIGFjY2VsX3ogKyB0ZW1wIHdpdGggaWlvX3JlYWRkZXYgKGhleCBkdW1wIG9mIHRoZSBy
YXcgYnVmZmVyKSwNCmNvbXBhcmVkIGFnYWluc3QgcmVhZF9yYXc6DQoNCiAgICAgICBXaXRob3V0
IHRoZSBwYXRjaDoNCglyZWFkX3JhdzogYWNjZWxfeiA9IDB4MDMxNzRhYzAsIHRlbXAgPSAweGU3
DQoJYnVmZmVyOiAwMCBlYiAwMyAwOSBmZSAyMg0KCVRoZSB0ZW1wIHdvcmQgZW5kcyB1cCBpbiB0
aGUgdXBwZXIgaGFsZiBvZiB0aGUgYWNjZWxfeiBzbG90LCBhY2NlbF96J3MNCgloaWdoIHdvcmQg
aXMgc2hpZnRlZCwgYW5kIGFjY2VsX3oncyBsb3cgd29yZCBsYW5kcyBpbiB0aGUgdGVtcCBzbG90
Lg0KDQogICAgICAgV2l0aCB0aGUgcGF0Y2g6DQoJYWNjZWxfeiBhbmQgdGVtcCBhcHBlYXIgaW4g
dGhlIHJpZ2h0IHNsb3RzIGFuZCBtYXRjaCByZWFkX3Jhdw0KCShlLmcuIGFjY2VsX3ogMHgwMmU5
N2ZiYSB2cy4gYSByZWFkX3JhdyBvZiB+NDguNjdNLCB0ZW1wIDB4ZjYNCgl2cy4gMHhlNiBhcyB0
aGUgYm9hcmQgd2FybWVkIHVwKS4NCg0KU28gSSBjYW4gY29uZmlybSB0aGUgZmFpbHVyZSBvbiBo
YXJkd2FyZSBhbmQgdGhhdCB0aGlzIHBhdGNoIGZpeGVzIGl0Lg0KDQpUZXN0ZWQtYnk6IFJhZHUg
U2FiYXUgPHJhZHUuc2FiYXVAYW5hbG9nLmNvbT4NCg==
