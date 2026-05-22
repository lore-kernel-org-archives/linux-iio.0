Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66382BE7DD;
	Fri, 22 May 2026 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415004; cv=fail; b=EWIEJO5NQ0vwETVnyMi6gQxF5tj0nrFsjsgh6RXQnnkL1Rd6ZLVtEy9EVuOLijG7NdkMQ8hm18FM5VHOlBZvO9rYCWkLsAPKyf3lSTWtuoFLFP6liRUg86DojdvMMY7YrBkNzAk3CKLg6dLMlhg2pncfWV4yS05VyRX7e15Lh3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415004; c=relaxed/simple;
	bh=EVJuLj30j0Z15QXZvzKZsf63OtQOnAGbGbcIRr/aNRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E55tGq05ommmVhUpAzJFphOZKvMtPhIOVj6IA4WuwGuDxj10NBICNIVLUr3hzfbUszGbnvUmC+1DggwwcRc3GGlQ6OSu1+EqvzMr5XtrF6TkeGjZ76/+GSwnN24U18FhBMQu/liVxYVxiY6bEZCFUcG7ZD2dFBEfH4teUDbTQAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMWgOsHcxMArFhDSKHvNb5kyzDTDmVU1/TTBYkz5SNs1ad7p7+vcFiX1dEBG+/LbiCKsK8C0X5N7h/ociL3gVsksgq4b73Bz1J7AqJMHLUBPA7c4nMu//LpK1ovBG+2sFGwxOZcnMmAJmu6Thij0DkRXrykBiAPTRygF0vEHgMUD3ncD+62iA3OBp4Xw9HTWZYeTypKmlHICCwQtidT0Enfv/dJm+76SLQTsvFeOg9MlMNO48tAkP6d5A3lG6PonjKGCRfJJYjGCIoodvbYailN3XULBPFBvMCs6Zjey7NHS+o8samXktFCAXIkIQ/z7JI32n8fCzTBSCW2qxt85WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf655A9y/fXU5XmTNExZk0PjOLTfRRVTFSbRnuu2AYA=;
 b=VVjgsnh+jQPkF4N0qBrvY4T6DF6eJ2NyU3YvEFGIl05+D8lv0L44lrQthzXVFhpYKUbt0ZVJs/zxshRcAgwyzjt96oJd2jwE0jcnBRWWiF5XMg+fRn6bNPcintND1x+Gk8QTvLi4ny6Oif4MTSuqEdzWd/nkkiPH1ai/Al0DGn6tK+uyYc6CcHqWEXtBeSba/pGIxpiGNNMdZIZyvgyNm7/m143QHRywDJG0RjeA7WZnW0G7G1Zk19SZyjHYSSWVlq2HoJn3/zwox+h6HzOACwHk7pZkPpUlmdhPPgrOssBkSfAKMIbqJsllkal+4Hg99TsF2EWZIoqzTp3tN3rBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1083.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 01:56:30 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0048.016; Fri, 22 May 2026 01:56:30 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Thread-Topic: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Thread-Index:
 AQHc5p77jQOM2JwohkK7qO7svRU7q7YT+EcAgAEVtmCAABFGgIABhc1AgABkbYCAATcuwIAACRcAgAAWD4CAAFRWAIAAlyMQ
Date: Fri, 22 May 2026 01:56:30 +0000
Message-ID:
 <NTZPR01MB09569F0AF51EF555BEC08D369F0F2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260519-undoing-ambitious-012d608ebd7f@spud>
 <NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260520-relic-chloride-c5cdb96696ce@spud>
 <NTZPR01MB0956DC43B5D6E6EBB4F457129F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260521-growing-brunt-4e5a9f955a4f@spud>
 <20260521123949.20e3c0a8@jic23-huawei>
 <20260521-bunny-ranch-77fddc80ad83@spud>
In-Reply-To: <20260521-bunny-ranch-77fddc80ad83@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1083:EE_
x-ms-office365-filtering-correlation-id: a141478c-6d58-45c7-a002-08deb7a557e2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|6133799003|4143699003|10063799003|56012099003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 XOp7xJMYrQcvLjgB7Zu2kWZWSNbHJe2EdBfrOdMRSh2SxFKrP+vWffqg6wFEbQN1TSrj/RLi34UqQU7CDIMl+95YdrEJfaqO8JjAsAS3pkzScymhI1kuimUnqxT1U+qlcvcyJQrdmSkTAwYHGRA+thQj05i3Issx9bbcpU2ofzU8A0YDW9yQUin1ozpdUN38qTFGBjk/jYDi7RyVGTHdJkSPgT11gn+9EwYlo9z7++hLDhI4iLB23y4SsT3edF01KD2Komus/rzuazyTLWkjfngmcrL8AEw5Kyhmuf16NY0BI0TveyCfQyfLacGJb8PpdG+LN00weOEE6frQVedmxVRcAGsDkuI3L6lE791XiVlpeDcE3E2UHW/a53KOYw1ZBiOWpT7/0AQG3wT8LEBl5GKFml3DdRjVo4jBo8PYMeYld0elfoBMYo2AzaefrrplLnpj66HFAW9hg06OrIGCSSH945gsZHOpJ86He7/kN2pNFcAbPxyWD7lOHMWVvQ9YMWn7VAmnUq5800YAMeVHz8daheCj9DCg3povVQ2hedSr8cGmiWoyqx0xcoTgFVXJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(6133799003)(4143699003)(10063799003)(56012099003)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?z86VK62G1NhyLC7NCeSX+grjv9u2wIIyPNbAzpPL34eg5GVrrLoXqk/wX6?=
 =?iso-8859-1?Q?UfaXFpmPx7Dtnp11LAIFouUxvfQ0nvZGxD9fhw1qwVSMPg5lhnn63x+Rkh?=
 =?iso-8859-1?Q?Yd0UgIBd9OZCWoQdzzD2RoWbFhwnxHVxgXyFiDT8YMV2f4dYe3CJzkMn5k?=
 =?iso-8859-1?Q?nFFqC0mqgYfxXb8snd/5hOUNJ5QAlF7wDlnYg96ybHem70BGmzTSrIZlQk?=
 =?iso-8859-1?Q?6NCTeY8IKqg7DRCsBnB1sIXjGuPQyCCEW2jbE+CcACZum+LYmZfYV8gRE8?=
 =?iso-8859-1?Q?Mkz5bG+2QJdFBu4Pccx0XWWVt/NT1qTSJ6JNteGROFnCTYHhzSVdUeBvN9?=
 =?iso-8859-1?Q?fKre15AOTB5PLjcxRGQMYRHPXK/MPVRhb9GsS1OvgLpzUOeODLh6pO557K?=
 =?iso-8859-1?Q?aGfjJ0/i3VfVa9RoDBr9KluaPapqrW0PjYYlsEnPrwhppXkQpndh7BHgff?=
 =?iso-8859-1?Q?I4lA4NjoA1KxzCwR84zSwcTW/1D31hnOWHO0FAd86JW2bOxO5ch4yxaoPf?=
 =?iso-8859-1?Q?h7i5dhMvSHVdMA4Co6Vq5ln0xZvY5+dVnfCHTQmX0ruwV/DXL5rCtuNfAY?=
 =?iso-8859-1?Q?Lnp8rKTD2p8UphbynAdgF0SlbJx2xfVrTqPHM4y2cM8DEhMVuU/IXU+fKM?=
 =?iso-8859-1?Q?kPexRl+nuGVPVp3xk1YszvqDc5DnXp8b5AvQYb67ajeENZmPsml5CH90/g?=
 =?iso-8859-1?Q?eFiH/o/u20NKANFkS1sBO2t/0V/CK5w76N+RwZeuDOLEs+wUp+4VfQpeL0?=
 =?iso-8859-1?Q?zPgm4l/YzRmt16PwEBDHbpzU3XDbHP7fHzN0a34BOrz+s8Topw/c6Fl1cQ?=
 =?iso-8859-1?Q?vq0viB8fNr1/GkmtwXnKREOjvZS4CfNcIvcAMXCxq9pKq0ttt62tw7sCah?=
 =?iso-8859-1?Q?hEhFzWZJ/IapKhtL0CmU+36UoWxdUXby8d9Y6exa/T1IAe7smhQWkd8E+i?=
 =?iso-8859-1?Q?85MvGEovW416SZNCUWTwHoRHUk807oNOpNhccXRtNQhO1CZFyh4RPJiAmU?=
 =?iso-8859-1?Q?nQVydw4gR0Z4P36eVPi+4HHr9BzlnErfay2CmsRxKUuSPb9Bfc3Y+U6QPd?=
 =?iso-8859-1?Q?NNs652Sw7ZAkp0cR4+YzsM0fTmhxkd6kSpCvV61pwORDmOiAZBDW9ZYoCj?=
 =?iso-8859-1?Q?YhJ1IVQGTRhnOnxbByqiMyKRtLLEH0/gRFL3739vUCDDv4U2Y6V3V7Dm9j?=
 =?iso-8859-1?Q?d9TmhXI+xIatPQZdGasqdRKSMnqgidWPZQrdf5Qjod3i6liV7KoYUKH+4N?=
 =?iso-8859-1?Q?dHc6umpyKo9qMQUA0qugWp09iJ1FPFc3DQslA352L08r/pudYg9c53ok1u?=
 =?iso-8859-1?Q?GtKJUmo9somTQx8AzpMqkRJCgPigYtl0GklCurZTQM+1SaXRCQIAyGakBe?=
 =?iso-8859-1?Q?eT02/+s+TnEby3TWHHOXzBXvdaLqcE9eBD1E5pKUSNjwLj8a5RiR5ugyCo?=
 =?iso-8859-1?Q?gUx6QkgBnXnhG+7J8vqoPzRmHGy83CmvriCBcKnHhYtoC0QjKL0lPYo1Pw?=
 =?iso-8859-1?Q?gmhkOG/2w8Sca6Ug0S7c7EA75K/S5OdHaV9eeDCJ9DO5oXWVqoKEbo92am?=
 =?iso-8859-1?Q?Z7oM1UZ5AMPqkRi5j3AmPGq82iILAo0lQpW7T/vkfSoqoIu41NLd1kwY4B?=
 =?iso-8859-1?Q?Zfufv2mt+a7pY6ONWYxWcfvxVGtbdPhZ/IeM4cdwpCX6J4f+Ql93Q8Nw9q?=
 =?iso-8859-1?Q?+NKvWvd/lE1hSjjDXNqCsNIei/1qzxOMKNg2XuyxZLfiq4uplbC62OLeC1?=
 =?iso-8859-1?Q?WYYiELvHMOaykncLSwMpRIjmV8/xzi+49xhza11A5fdftGqHxMsRM1+q+b?=
 =?iso-8859-1?Q?XTuxt9Lf+w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a141478c-6d58-45c7-a002-08deb7a557e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 01:56:30.4657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDU0joe1bqOaUCxVoawpPjp0qEIfBmAJmKXj6f+qJ0XxYW7ZeqhMgqLwYj/02xN0ElwZBKBMlEMD0qcZvWyY9wwggRCIWXVwCoxdMHGSGu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1083

On 2026/5/22 00:42, Conor Dooley wrote:
>=20
> On Thu, May 21, 2026 at 12:39:49PM +0100, Jonathan Cameron wrote:
> > On Thu, 21 May 2026 11:20:52 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >
> > > On Thu, May 21, 2026 at 09:54:27AM +0000, Xingyu Wu wrote:
> > > > On 2026/5/20 23:15, Conor Dooley wrote:
> > > > >
> > > > > On Wed, May 20, 2026 at 09:43:02AM +0000, Xingyu Wu wrote:
> > > > > > On 2026/5/19 18:00, Conor Dooley wrote:
> > > > > > >
> > > > > > > On Tue, May 19, 2026 at 09:26:03AM +0000, Xingyu Wu wrote:
> > > > > > > > On 2026/5/19 00:24, Conor Dooley wrote:
> > > > > > > > >
> > > > > > > > > On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote=
:
> > > > > > > > > > Add the new documentation of SAR-ADC for the StarFive J=
HB100
> SoC.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > > > > > ---
> > > > > > > > > >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62
> +++++++++++++++++++
> > > > > > > > > >  1 file changed, 62 insertions(+)  create mode 100644
> > > > > > > > > > Documentation/devicetree/bindings/iio/adc/starfive,jhb
> > > > > > > > > > 100-sara
> > > > > > > > > > dc.y
> > > > > > > > > > aml
> > > > > > > > > >
> > > > > > > > > > diff --git
> > > > > > > > > > a/Documentation/devicetree/bindings/iio/adc/starfive,j
> > > > > > > > > > hb100-sa
> > > > > > > > > > radc
> > > > > > > > > > .yam
> > > > > > > > > > l
> > > > > > > > > > b/Documentation/devicetree/bindings/iio/adc/starfive,j
> > > > > > > > > > hb100-sa
> > > > > > > > > > radc
> > > > > > > > > > .yam
> > > > > > > > > > l
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 000000000000..ba8e19b72ad7
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/starfi
> > > > > > > > > > +++ ve,jhb10
> > > > > > > > > > +++ 0-sa
> > > > > > > > > > +++ radc
> > > > > > > > > > +++ .yaml
> > > > > > > > > > @@ -0,0 +1,62 @@
> > > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > > > > +%YAML
> > > > > > > > > > +1.2
> > > > > > > > > > +---
> > > > > > > > > > +$id:
> > > > > > > > > > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-=
saradc.
> > > > > > > > > > +yaml
> > > > > > > > > > +#
> > > > > > > > > > +$schema:
> > > > > > > > > > +http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > > +
> > > > > > > > > > +title: Successive Approximation Register (SAR) A/D
> > > > > > > > > > +converter for the StarFive JHB100 SoC
> > > > > > > > > > +
> > > > > > > > > > +maintainers:
> > > > > > > > > > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > > > > > +
> > > > > > > > > > +properties:
> > > > > > > > > > +  compatible:
> > > > > > > > > > +    const: starfive,jhb100-saradc
> > > > > > > > > > +
> > > > > > > > > > +  reg:
> > > > > > > > > > +    maxItem: 1
> > > > > > > > > > +
> > > > > > > > > > +  interrupts:
> > > > > > > > > > +    maxItems: 1
> > > > > > > > > > +
> > > > > > > > > > +  clocks:
> > > > > > > > > > +    maxItems: 1
> > > > > > > > > > +
> > > > > > > > > > +  resets:
> > > > > > > > > > +    maxItems: 2
> > > > > > > > > > +
> > > > > > > > > > +  "#io-channel-cells":
> > > > > > > > > > +    const: 1
> > > > > > > > > > +
> > > > > > > > > > +  upper-bound-mv:
> > > > > > > > > > +    description: The upper bound voltage value of the =
monitor.
> > > > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > > > > +
> > > > > > > > > > +  lower-bound-mv:
> > > > > > > > > > +    description: The lower bound voltage value of the =
monitor.
> > > > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > > > > +
> > > > > > > > > > +  scan-freq:
> > > > > > > > > > +    description: Number of the scan cycle interval.
> > > > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > > >
> > > > > > > > > Can you explain why any of these three properties are
> > > > > > > > > something that should be in the devicetree rather than so=
ftware
> controlled?
> > > > > > > >
> > > > > > > > My intention is to be able to obtain the initial values
> > > > > > > > from the devicetree during
> > > > > > > probe and preset them.
> > > > > > > > Do I need to drop them and just set them through sysfs?
> > > > > > >
> > > > > > > Unless the hardware configuration determines the values
> > > > > > > (which I can't really see being the case for scan-freq at
> > > > > > > least) then yes, you need to drop and set them via sysfs.
> > > > > >
> > > > > > The ADC hardware can be set the scan-freq register to
> > > > > > determine how frequent it
> > > > > should scan its inputs.
> > > > > > The calculation is:
> > > > > > 	frequency =3D 100/((register value) + 5) MHz, The register val=
ue
> should >=3D 15.
> > > > > > The maximum allowable scan frequency is 5MHz.
> > > > > >
> > > > > > >
> > > > > > > > > How are the bounds calculated?
> > > > > > > >
> > > > > > > > The measurement range of this ADC hardware is from 0 to 180=
0 mV.
> > > > > > > > This set
> > > > > > > value cannot exceed it. This explanation will be added later.
> > > > > > >
> > > > > > > I'm asking how this is calculated so that I can tell if you
> > > > > > > the property is permitted or not.
> > > > > >
> > > > > > The calculation of bound is:
> > > > > > bound-mv =3D 1800mv * (register value) / 0xFFF
> > > > >
> > > > > These are the formulas, but how does someone know what the value
> > > > > for bound- mv needs to be? Why would someone not just want to alw=
ays
> use 1800mv?
> > > > >
> > > >
> > > > Can I add the 'maximum' and ' minimum' to provide clarification? An=
d the
> driver will also check.
> > >
> > > All that does is repeat the 1800 mV though, what I am interested in
> > > is how someone determines if they should use 1600 mV or 200 mV etc.
> > > What aspect of the hardware do the bounds depend on?
> >
> > There are two options here
> > 1. This is critical stuff to avoid hardware damage. (If you are relying=
 on
> >    Linux for that you built your system wrong but if we ignore that...)
> >    Then userspace control should not be possible - or at least should
> >    only be able to move boundaries in directions that make them tighter=
.
> > 2. It is advisory only and not related to hardware damage - in that cas=
e
> >    generally doesn't belong in DT.
>=20
> Per Xingyu's latest response
> | These bounds are just for the monitor mode. If the input voltage is out=
side this
> range, interrupt will be triggered to report the user space.
> | The bounds value (1600mv or 200mv) are determined by the users' applica=
tions.
> Users can freely set them according to the range they want to monitor.
> it controls the level at which interrupts occur, and is therefore not sui=
table for DT.
>=20

OK, I will drop them in DT and use IIO event to set them in driver by user.

Best regards,
Xingyu Wu
