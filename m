Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8040DFC9;
	Wed, 15 Apr 2026 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215431; cv=fail; b=atmtXdUmpGgNqlP0SnE68KUnQk4P9Sl8+tYCSU8S509Kwbhat882kE9bIdrgO0q01GEXKfAN+zQ3pAYJi/ZLRT8VuVCzAczzm7qbgsSChIV47+hUWfxmvImdVJn3Ef6mCIi+cjj00HBbYnym/cw7Z6g86G1FRhCpkkRmJ4W+lRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215431; c=relaxed/simple;
	bh=s8ey0OkkaDTZs6zFNZ6SGkniUMTAScyejtAmp62Gxes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQckxx75q0gg5SgA7YSANe9o+JJUtUL5iZhhAUAcNWbmpvu/NsczDlFxgyBgMdwPfDomTZI/c3iylGvAE3Gee243Z3NNUMtakcRgAKzJT76NynAL2fCLtNiNiS09X0ggyXg4F8El/abppaPM/ae0srAX7E9a+MaeucYIz4LkcNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZEEeb8uT; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZEEeb8uT"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F0CcdS3602676;
	Tue, 14 Apr 2026 21:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YodIY
	Xfu9ACGAH5PRTi6rVfT6S8KzjCD3x/qVXU3qUY=; b=ZEEeb8uT3hOGnG3Uhx5tZ
	5ySBFjozrqb3W1stkC10iaXm+mK6HuzQrjWNhu+S7c43a1wuoMPECTby+o4Ofe7p
	OTMxRWh1QbFowFon1QRW0sYZJzQUHuipB6vO5rLnwYfmSvZ2uObl1Yb9IM945liB
	CdIpKVOYIXaheiEj4yNcTdNipVGWU9FvwICp3Miy1+mepHvDAO7Yvo+4ZdjfMzLD
	/Rxz15/8APLfAhJstJkEitU5X/GRLDdRmWyzD38z7Uf88bL+2bemczKKeYFF3n1D
	GoUFRniN9A2CF7ublSj6ZTq3L19P4/qFN2LkH0zU9RkWpSuC9nGfWxGebbmAqulY
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dh84r48br-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 21:10:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sjgoz4ESI4dkflZQR+EvLhTSpr/mtkjYuoJAMHQmtTWQy1g+7VI6L+1QcfzTMqWq9cnXzdJtAup/HalhLkXLkOCXt3ZEvRBlR4VLoQCFXXzVpRudzT+aBa1lS7m6Uuv0RHPwl3aRLW67FY/f4lmbmEmPZTo7VehJ6QF8Xe4XmTfIVoxJ9dbXb7jHOSbA8Nus62m9fNNH2ckS4fOjXOnlem+C2ZnVNh5u1UlXPr3ZokZ0ATnR2jej/40ZLkSJmO2jpstcynWImbK0A518GYx9QX79roXzj6cDj+cinI40/+eGM7cDNKvLb9pO2/6V88ZFYO1qSO8X5i3DMWZTZI0Akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YodIYXfu9ACGAH5PRTi6rVfT6S8KzjCD3x/qVXU3qUY=;
 b=hPZitJrP8qAMNrJlSO2bscHTa9GxCxUDUgMpFR9+w1W6Xqmv7089vp8uDJO43oCVJEACguFa+AXKRG+oReijro4zGFnwGno92NYc86iFCU6WZPWc/AEpeg31YmcqXjwDLQ+c7jXeiQHDwnlm6Ht49izGrg0k1U7SSH3MbnnoFRNSbv4KqCwnm52HvXGpQE5YVUhDljVnAIrcTIiiAUEe63cTbzXeEuUK6dTsxLdUTkxCHyBwCBxq97v4GpvKzkeA9Q6tpqOK4imW0AHTCCkEsBVZrHsqvx/LI9K4W+oelzfVmD9/+LNmPZ2puQpJjNCJWyTa8Nm4dWX1vVDEjMRaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by CH0PR03MB6177.namprd03.prod.outlook.com (2603:10b6:610:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 01:10:09 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 01:10:09 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: RE: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHcyLYbntrYV2qu+ES6PcRhOUDLm7Xe7q8AgABbqlA=
Date: Wed, 15 Apr 2026 01:10:09 +0000
Message-ID:
 <PH0PR03MB6351E875581B45ED279785D0F1222@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
	<20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com>
 <20260414195400.60d39158@jic23-huawei>
In-Reply-To: <20260414195400.60d39158@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|CH0PR03MB6177:EE_
x-ms-office365-filtering-correlation-id: 21d545bc-149b-4e70-ebe2-08de9a8bbcfc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 NnhRJH5dtdLKdcjNFFuZkXLJ05+0JLD00RE4le089BciAaHOYEHYOvW/PAQqtL5FGLFDcX+YdEZbKRlJnN6BV4rtR73hJnPtWVA4gBpZ2UmJkqCdaeMyvB9nNGUmYClk+RimYHpJTfKz31ECfI3ISqWpgeYB5up7OLFem4ah+HkJFEqey58rIMVRB0jSOs5TZIdNM7JxnJjaey6q9pDeKUfgPAh3JHnZcg4UouqNUP0Xkc/EeHB/EziQzLSiBn55tHdiOWUyumBh1mTrlwzeNI/lH7k9aTq7+XZ+ea9Hbo4v48ksVx6AOcfw/HrIk1KC80w87dTkW+BCDrBWcIOHOxVLwz32UXlKWjgkpipVdc7tBYe6c9NjhugT03oB4+tid3ia9oyxgRrciaFX9oRe4TOwkUJuA+L+ev5icTm/ickLTYIfQ5H8NPTDM4m9zQJKonkVbVzy9DOLkojy7M8teITIYnkIm3OgWh+vZz6qMjCGLQAJGZew3H37NQy+qThgXvdLEFTkubR7jyTMVmEvKzp4b1Pn8DafAxM7VRhXAq3jX86COIa8gxYXlEMVo8H0T8ZvOc6PdPDjPmSkTGszg+BOG61XPrM5I9TTQ9ACwuOxBoCxt3UqHltbqTymfurNlxEq6lRCfZqLFtMH3EkhDPRlGRiSGiO0fN0m0VB0Mt95eWD+2M69qrcr9E7uRqaSln2UzYRFcCBYfCMgCQ30yS8zkyRdjuCVit8WQ8Q7tfUVuZANXSMo40b7VyrKeeS47jlXOYbH6vuPcv2wFnX5JF4yaGOICAGxB3oiXhjCPUk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xuD4R4pGpKQQxrF0pXXtxjRBUNoN6PaW6woSxsrl9gaiiEhGEsnA1MMRxgcv?=
 =?us-ascii?Q?fhowxpz6iWaKpeIPT32QL83B+hPk6ZL/I58oPyMMRg6QwHu6Y90CejwdIHaJ?=
 =?us-ascii?Q?yAJIHpnWYyz6vrUVMWJuAg5mgsvx8yL7dYn5lWG+OFHqMr4tNz8aRNQRMd9Z?=
 =?us-ascii?Q?dJqXLCjyldDrfcPQW40Nshg/zePcmvDx2ezRgs6oQpYyJFfpMAYfYE/EmIHr?=
 =?us-ascii?Q?COSLiwZt2j/c0TJbj9o9U2pU0Qpov9keJ91t3GfSJQ3zvxxdL+EPVIvyP1fg?=
 =?us-ascii?Q?z/dhJpyW6zXCFzMu9WxcXCBfqnpvzZxsQCi1qzhVjMqpognruspBgEtzgs3M?=
 =?us-ascii?Q?aVTSOb9iApfLSRgdCX/xZr6JV5THgUshZ+UJFuYImPrg9syAHAA8BwmzL82j?=
 =?us-ascii?Q?0y7SJLf4m95hSQLplfvH3xarwCeG649B4QQiW9Wsl2uMM1zTpvlh0w5XHTNW?=
 =?us-ascii?Q?EwJLIEIMkhYgZGa+FvasszvfmkPVeHp+O6zugW6vCKhqEKLtVpKJnGPAIMzf?=
 =?us-ascii?Q?6PFzwDCIEW3zQNU3cyDh4ZjlhdYalCSc87/+PqgVD8TB9Guy19tRE5gAdSHy?=
 =?us-ascii?Q?7cJek7/fDmihugtLyzwVIs+V90DN8XcYTUHJzEzYeqaKSIwW3ADhek9jUJG+?=
 =?us-ascii?Q?7r9UEZ62YOjA/f/dcPt7VSHcrmxc6Fpuo8kgx0CgIK+IMxBj6+Bg2li0zJvR?=
 =?us-ascii?Q?8MkNywJyA0YxPcxJk/xoSi57ID69D6wjtKxNGYZ0fOfk0O93DFZ1C2U0w94T?=
 =?us-ascii?Q?DFmfMfVqs6pfGWD3JPu22ppyV08WGRGyy4twp/4yTS82QURFp7kZwkZkkqR1?=
 =?us-ascii?Q?OHydNO+sRFxx2MzgtHAPP8HM1OXeRksHIfPVtHE75M3eYBVJqQ0+QW4y/+y0?=
 =?us-ascii?Q?0VMsfJzCbWA12MS6OXp13beBPi6FfQyH90EKxwMs/oqbCNRedl/FNIF/mYel?=
 =?us-ascii?Q?8iGB/Ujodb5ZOhJ6kyVMFfpO3ad3qBKaxzpc8fIbqjvg6ctE9JexNjpYzcHI?=
 =?us-ascii?Q?hbL1epLMPwccz1aG+E61UzUYQw4djB07Ntet+kCOP8LRT9uONlEhR6nBPxn/?=
 =?us-ascii?Q?80yr/QziU5BCKwt6WxtNnsmuTxh7WL2XATxTTlNUjo1Xom9XwDQEECwuYKgc?=
 =?us-ascii?Q?2GS6VHAs7pRFy492ufznlYmXbZKDkcdVBeBb0KSDRge6+Uoc2B5a+3XcY7Y3?=
 =?us-ascii?Q?+pCpJsjWsJiUr4dP7taYunt9O4KFx/qvx14fR6di43YXHDdh1ZW7uXq5xv7a?=
 =?us-ascii?Q?NSEL7mGEAH/ABSACyPQ0y1pc9wSnq5e7PhlyCBFueju4zW7oS68Y0mcpgygs?=
 =?us-ascii?Q?7X5rhIixp8VSzzmIWQb1kmtdPLlY3X/uCkj4Wj5w2SlmuuLGTIs06uXkDtoY?=
 =?us-ascii?Q?Cqxn1JirF4WeZNMsri/pjeJZRgxMwlAr0rzuqZb/o+Or0n83xXasuFbT3H8K?=
 =?us-ascii?Q?3/leC/wOLtuGrvN1yLtL8SZ1/8W3yUGNjEKoimxE+fL3UFTrPkTLI10kJ2I+?=
 =?us-ascii?Q?kXVCtKpQEuya0wxfkK7HkcG+w/6LXI03lRTSAL6+ACxeSFXajSDxfZMZFrg2?=
 =?us-ascii?Q?LxnzhFN9B07s7vrgc9JuD2FoBBEasBX/LzZDZwk0+uu9ABWixpTRQyjEPU1+?=
 =?us-ascii?Q?I9WeTYeSEPbZ2CX3WDhtNBpyeHqT4ZViD01qDP6vhH0psQ+NsD6H6pANUhh0?=
 =?us-ascii?Q?UQxDs0AgHpq3bSHbdtTSasqbAtWr0nDiJNGSh6IgsO4kPkAkKcBAnv2J2BTs?=
 =?us-ascii?Q?2nyWN3fx+ml9LOwox+1AKSYk1cvOLSU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WhiGBTO7B78CuUIA3YlH568GgaNv7CxghhE73HuHY91UMQ1QMark68EI7B37umpHBl/MyQ/AqSJ88H9eBP5Wq0kVcrycxU4UF0KkuFCljGthUQvjLsfHv7gjQjvu3d4S+Fc6z69Ka0OL/yVrnSrVOT5+G1Uk7xf5jRkMAY6nGliauUfH66cEqacZ5V9OuUf1yB4qjaUnxEDmf6X+/9VjMK4UhTTm4y0jWI/adD0l9sMoDb13XYSAnjNB2SmghGcACFcn7ogu0R2dk4qy9daOiVNUNpFPFesStCrW3ygnkUcLLeD1OS30aQIy2ipnk5hRTvTrSoo5AtivVTC/BXVbkA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d545bc-149b-4e70-ebe2-08de9a8bbcfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 01:10:09.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOyO5gfPbDRPqbtx4ohT2iuOqKi2CMbPmXDlSzJdAF0tWp7RV5SjMrsDQNIHxlK0oGiP28CPyA0nauKFHtiICRkYXhXMCz0Ij+yHz0XIcFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6177
X-Authority-Analysis: v=2.4 cv=E979Y6dl c=1 sm=1 tr=0 ts=69dee575 cx=c_pps
 a=feJg8xcwi6yo0k/5NfVkgw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=wimFQrT0xA_z0L6LzgUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: G6RfE6V7u6yrc9Qnki_dl81CepQwlQrN
X-Proofpoint-ORIG-GUID: G6RfE6V7u6yrc9Qnki_dl81CepQwlQrN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAwOCBTYWx0ZWRfX4zpt5/0pT8Pa
 WwzjRqPccYvz1IJgD3Ml61XvtAk3Uz7E9Y4fvdP3CPHhBEFbWe7eD0PfHuPAoO8Wx9S1vrh/g8r
 mYslx5ROc6ga4b5MtKPlceRXPx3x5VMLQ3sWqhvjEwE8KGb+mbcmLiPvg+393HVxO3WLIA5eECN
 SmOBYI1VBjf4YwXrIde1L36pF+60jg4rLytnSXIgHt57/YYNzSred5liVIcu1X/uuGq6hpVTcvs
 hjfZmLpYYrJJJ0/yzEcl5WtmSUtS68HgOWCZ6TcZwKcYtDTQqqZmPErOowH/qBXizsmx3AiOtbu
 M5t5qjDpthFdM5sPRdiOu+9aVLU5I7hex167kdIvMIk1GUZkNajhamBZzVYeOpLarJFUllkePm6
 Jvunh64jQMyUuHD9ft4miLnJ/QEIVuWqkNzz6xX8FlRQuKu3Y59KTH+d6wbg8a9CcXfk26EN/c+
 HOtqudQi5gN3PF7jSpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150008

> > +#define AD5706R_DAC_RESOLUTION		16
> > +#define AD5706R_DAC_MAX_CODE		BIT(16)
>=20
> Trivial but I'd expect something called MAX_CODE to be GENMASK(15, 0) not
> BIT(16). E.g. inclusive limit.

Since it's dac code I guess this makes better sense, will edit.

>=20
> > +#define AD5706R_MULTIBYTE_REG_START	0x14
> > +#define AD5706R_MULTIBYTE_REG_END	0x71
> > +#define AD5706R_MAX_REG			0x77
> > +#define AD5706R_SINGLE_BYTE_LEN		1
> > +#define AD5706R_DOUBLE_BYTE_LEN		2
>=20
> See below. I'm not sure these two defines bring us anything.
>=20
> > +
> > +struct ad5706r_state {
> > +	struct spi_device *spi;
> > +	struct regmap *regmap;
> > +
> > +	u8 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
> > +	u8 rx_buf[4];
> > +};
> > +
> > +static int ad5706r_reg_len(unsigned int reg) {
> > +	if (reg >=3D AD5706R_MULTIBYTE_REG_START && reg <=3D
> AD5706R_MULTIBYTE_REG_END)
> > +		return AD5706R_DOUBLE_BYTE_LEN;
>=20
> What do the defines for 2 =3D=3D 2-bytes and 1 =3D=3D 1-byte bring us ove=
r using
> numbers directly?  E.g.
>=20
> 	if (reg >=3D AD5706R_MULTIBYTE_REG_START && reg <=3D
> AD5706R_MULTIBYTE_REG_END)
> 		return 2;
> 	return 1;
>=20

I suppose not much, it won't change in the future so a hard "1" or "2" can =
work.
Will remove the defines and just put the actual number

> > +
> > +	return AD5706R_SINGLE_BYTE_LEN;
> > +}
> > +
> > +static int ad5706r_regmap_write(void *context, const void *data,
> > +size_t count) {
> > +	struct ad5706r_state *st =3D context;
> > +	unsigned int num_bytes, val;
> > +	u16 reg;
> > +
> > +	if (count !=3D 4)
> > +		return -EINVAL;
> > +
> > +	reg =3D get_unaligned_be16(data);
> > +	num_bytes =3D ad5706r_reg_len(reg);
> > +
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D st->tx_buf,
> > +		.len =3D num_bytes + 2,
> > +	};
> > +
> > +	val =3D get_unaligned_be32(data);
> > +	put_unaligned_be32(val, &st->tx_buf[0]);
> > +
> > +	/* For single byte, copy the data to the correct position */
> > +	if (num_bytes =3D=3D AD5706R_SINGLE_BYTE_LEN)
> > +		st->tx_buf[2] =3D st->tx_buf[3];
>=20
> This does feel a bit odd vs using if / else if as you do in the read case=
.  Also,
> same as above wrt to single bytes having a length of
> 1 meaning that just using a 1 might be easier to read.

Unlike in the read, I thought it would be simpler to copy the whole data of=
 4bytes,
then just correct the buffer during single_byte.
Should I make it similarly coded with the read()?

>=20
> > +
> > +	return spi_sync_transfer(st->spi, &xfer, 1); }
>=20
> > +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask) {
> > +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> > +	unsigned int reg;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (!in_range(val, 0, AD5706R_DAC_MAX_CODE))
>=20
> I'm not seeing a strong reason to use in_range() here (hopefully I didn't
> suggest it in an earlier review ;)  It make sense when we have a  val >=
=3D base &&
> val < base + length. With base as 0 and MAX_CODE not 'obviously' from it'=
s
> name being the length (it only is becauset he base is 0) this seems odd.
>=20
> 		if (val < 0 || val >=3D AD5706R_DAC_MAX_CODE) Though see
> above on MAX_CODE not being the maximum code...
>=20

I think around v3 Andy suggested the use of in_range, as the function itsel=
f helps
document what the line does. Is this a style preference?

Regards,
Alexis

