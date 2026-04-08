Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010003.outbound.protection.outlook.com [52.103.12.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE143AD52A;
	Wed,  8 Apr 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658683; cv=fail; b=aJ4WT5ly2BG01zwYzNKireweFjSs4Oz0tki/0+B9vD6HgUcYPdEIQi+MYi31DYnMj5EYrVP2A9aS2UOddOJe9/R20N5sSxqOeHIhJVGvQn2/IGVYFNEFSFCAcVEEk21fYGZ3r0yEuhR6cZ5xWjl2QWFlBB2kGjeqlXf01eXYH60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658683; c=relaxed/simple;
	bh=rOUOPdiLY+fxmssM6DcDd4dY7/jUkU308o0olac32MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTn/ZVyUnlxAvst9Ygd2oYJGNVepDr68Hhehcs2SImZLQ4XFOg5h7a2290YWML2sRdDPwTPwkSdMXV5U5TZR0qYETNLpwfabT9pVSeXS2dB0qOpeq7KiMPMIpXpKLl8goscL9krlfsUxkWvLFdBXWGIvPmbI5ggZ2ZCGfGSXHH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ef4ODhj6; arc=fail smtp.client-ip=52.103.12.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ef4ODhj6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr/5trAEmRVwZfhSxN5wqCxUOAl6fUw56vhjviVbQmgvKIrfF+rryO92JXZpISZ/x3Z+pGyi9cDgc0UKGdA6TOoO0IRNOyidxILTl9pc9hS0lFftT/jbEcRGbdy3oqEboNSY8UEK5gMILMzifCKpQt/65iyZO/FBRjlklYCljojx3IeERcwsuOSBXCqPMy5q4Q/SkvK0B50tarJ/elci0Mt6RE4rRspehlQhxZbFaji/lx8cbhntKVyr7L1B/UmQjpTQU77QNkI0njg8P+E+CXn635sDn5EolLG32Lrfs8nDcXOSW5tNiFOWFCty/kAASD1HPzkTQwZCSMDny+1oNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5cL+Xh4nMDfsoY6PPQiP5r/FJFxIvroqVW1a8KeBxI=;
 b=JL4OdLp/qxdjIkel+Oz5uxv6hceGIDu2+Gu12iuuml6VREcLvyw2CyYzHJUPptv+FlSbb+nXsDNkjgWxz516N2E63feIDus8ETuOuT8kS4mIRDlshHPDtThRY06Zj264RWEmgB5plizz9io96pQ+dY0tc+CHZNzHrcenRgRhSZryZ/wdU/tBcTB4dpgSfM9mmmWImJLTv7oLHKsRDpzAo5NP62r1zVZRFKeXbUrzNc1HLpF8+yoPUGkwHekkq+Nf/XFDdyMSMra1jsv7fQ29yVFhgA9NOLW12MDkl3Z3zJtA0nzvH42O4gDYqyqkzMHQrBqm9I8WO+ChNaYqhAqTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5cL+Xh4nMDfsoY6PPQiP5r/FJFxIvroqVW1a8KeBxI=;
 b=ef4ODhj6fnkYvILhHIXUsTCeyCdV9PxK5sB17XPQkHCksiH8CoU6EK+HSPEa2rQxOMx2boLBxOkQZSfQMFlqwIBJI3N22urHyQkg0MLkcaImcuB2q50Zi5C1mpDG00V2UHyHtJQnFFxX8tkvw2sqUIS7RwN/3xz7csc6eXkI6IcKW7s0NylVJF76YocsRtS+0d4LqDa38OL3kTz5CSxWrof2JYpDYkC6D3zOhs4DkXPcz8sRfTELhetCXNrIpb0UrBex4DKqs59m+lkVUVgiAjId7kExf4z3WiLa9qhoWtX6tmJefZ+7Nc33WmEXi2BlEf9IyNA1tDJHm+JePB1msA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CH3PR19MB7658.namprd19.prod.outlook.com
 (2603:10b6:610:129::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 14:31:16 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%7]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 14:31:16 +0000
Date: Wed, 8 Apr 2026 09:31:13 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	andriy.shevchenko@intel.com
Subject: Re: [PATCH V3 1/9] dt-bindings: iio: imu: icm42607: Add devicetree
 binding
Message-ID:
 <PH0PR19MB9973386B000D79AD04904C96B2A55BA@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-2-macroalpha82@gmail.com>
 <20260408131944.GA1901621-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408131944.GA1901621-robh@kernel.org>
X-ClientProxiedBy: SN7PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:806:122::22) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <adZmsSr8BCaxeFeI@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CH3PR19MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c5cfe6-8830-4de0-882d-08de957b7e0e
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBv5zL3Pq3ogIg0sNnRYStpomEmKktuL1DsrivyiA1Mm/h5SGdbRUsUWIDo6rpa8B6d6v8Kpe3erUHAC6sl+JUS9ytd8w6Q6QCZEUNFQrk2NfMf57Z+q3meSM75kGy7ncv/hYssS/EotQq9HDKlBsJq7+SW6dQBxZX8oVYII8+g2DJ3aRRLfcr1CirlVXC/9gvf7Dcrl/J4iIwv6gbTu3dAxv9hdJLxhGJCP0cmXC+GU9eWCK2/FyMwdnIiQL+tEZU3l4rUSQ6D96/M7Bh2zu4sGnXOdQjHMRiyrHt/LJOkn142S1/DP++Sla9m7BbFSU4ppVsHytm3SXpigQDw2FaGE0LH5cklVlMdpZdYkGAunVDnXCiC110GHoY4VVevKhZqL8z6RegbWf5nUY9PKCmQhAlPy8BS2tYQ7Ezs5jO9kIXfzcAwSUCFwPRiUk+ZxiXRjL2GQgW1XTWnVP6XjfT6m0ZhVFB1Lbyklm9HVGc5Nss8kTO3EO1XvYbj9+6zyAabtcBTcnF8UioLQXUlyaMlrnmTVNG/5n07RCJjPrI3+pOY7kmQdkMHcGejdc7TXJhbJObOcaK1DHc4YkYgQGqF6MltuKtOMfCJna3lBeVIQ8EGfKsnVMius7CEpj5k1vFuvuVafsGW52HPOXoO21U8SCYrq73ayNvgis3hEtbs/mWzHqTq2/Endr9BB1Z78aHwmvHy0x2tQlL41mASlWLJSI70QTaETkkivZdxpzVNV5YSdD7R9tS02dSzReirXrwTrtiyVk6q4tSnV0ZpvrBCe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|23021999003|25031999004|41001999006|8060799015|15080799012|51005399006|5072599009|37011999003|461199028|6090799003|10035399007|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pmdS4xedSXHs7616f2bZY1wpOlXiLtkcNXr3jH257WL0tNJRLuVxhMr17U5u?=
 =?us-ascii?Q?SaK41jdrzJZHRRcgjPb/WsnQQKWss5KisGH0reAWxTAN837RsnIaYRB/jKO/?=
 =?us-ascii?Q?YRWR8UP2yBfqhNboFeI4DUMY3b64FnziADmYqZRfYRXbcxQl0dHImYDjrqKC?=
 =?us-ascii?Q?VGNy62EQm1BXSznKOBntd7UTnkttOS9zKF9hxpyUCN8UZmXof5XXzfcccdZg?=
 =?us-ascii?Q?zqxxRDmlW/hvNO6eGv1UJxPhZbVJFjFj46aNyEBxUrAa9cpIv5ka6hR1Zov+?=
 =?us-ascii?Q?HJTJsZz5FUrDh5o9UFd2qDC8OWXCf5VR/uny7CWzGB+orUBe80KtJMxohjYo?=
 =?us-ascii?Q?TpsHLJdxo2jXH0kfr58tPfUseevL+7jYk4iORfhal15P74E02T5mtmSKvm/T?=
 =?us-ascii?Q?npF2/rmmkClsuzuU7e8tfq5SCBRVYHCbH49uZ8wAhwiKfPqp9/zoCBN7dCKH?=
 =?us-ascii?Q?2i6jGnkO0hfGf1tU26HhwDAS1lLXTUKOapp/DCCvwQKxUZMaA1ja1THcR9Vi?=
 =?us-ascii?Q?zpOCCgIRxCrsxvmNGoNJMs3o1UwebrAkMD1jI4UCGnOwCoF3J34dVCgIfNps?=
 =?us-ascii?Q?beLV9DRSylASfHCaC1enT51PA57+7eVeszH+812e7Q/fdt1lR5G947Ty0G9S?=
 =?us-ascii?Q?5fzVazYZDipFXjrWfCt7/iIo+i86KnZVEH5rHMyP85Caqc9RqIxuow0PfIdd?=
 =?us-ascii?Q?LYEGaXjalfBAVf6rRo6X6pQxlv53+blqksZXkoXKT9ZDY50ekAIi8HSgBkXh?=
 =?us-ascii?Q?mQ3d3S0DqxfENwQBCyjbV+1DitNeHLMq0Jj41kxGOP7cOZFtdKpi8HA/pl78?=
 =?us-ascii?Q?7KsCMjhSQo1r/yjji8m++TEsJB7QXzWKq7issXavjnC31AO/cxSwf7tY6aR6?=
 =?us-ascii?Q?fTgvp7ZWPn2GOL1Vgvoutu3Z//hCJdnfCvB58WFWFgtrfiDuQiDHT3wmPiX3?=
 =?us-ascii?Q?ytcuS/CE7O5ggc6vodqxV6hMkPnG/XqBtUIP+iLjgVeZY/rWJgVWi3MS8ipC?=
 =?us-ascii?Q?q3KHzS4SEnHWozmtpLZP/wFnjo1QnKTte8SbYZG8RvqbEdci6UDKxFEflk78?=
 =?us-ascii?Q?A4Uk7mauElKsAqMFk3FxioCjUsUftg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gc4hec5QMMfe31j525U6GGQHzLCSjRhhwSDHr+B62Wei6rSmHyxaynVUrnaD?=
 =?us-ascii?Q?dOeoKPjmjyxJxbt0gR4BLUA42lX08OfGxJob9pBt8NsBPSyY3Ep8uebBS0h9?=
 =?us-ascii?Q?NswUDjT0MVVENevjUhDeKOc1UVlTEAXKANZRLJ+C9NIvA50WbFlG/GFZPPtl?=
 =?us-ascii?Q?QghQorRAJy+7yH5hS3G4wYoSe2yHkHJy9QYmOW697zggxM2X/kDbTuSAU34J?=
 =?us-ascii?Q?HCzV0bVsjK7ZbboX0ho111GYtHU3hTN64Yhyx6G+odD2Svwm4IaejrmJXkGr?=
 =?us-ascii?Q?aR2ppWU8XR9P5wOvP9oaVhExOIUThhE7HHq5xSTx+tCPq4wo/z1B8gx0qKo2?=
 =?us-ascii?Q?jGJni7iQAQFK4L1jDQAmZecy3vQjr+ZvQy5A2zriNsOu1LA3NNZtLyV2RDfC?=
 =?us-ascii?Q?SbDeMRNgm0rgouwrqM9x4EL4TBCNbawehK1ICP8TJ3fpcgL5PiKUdzMPmSbX?=
 =?us-ascii?Q?ssNpUw9K6P5sqaVcQ7T6zE3n5u2y/JBoQ+rprAlKIxLFb2s4mt2o6Q6qzp35?=
 =?us-ascii?Q?PAnCfypdbFZ5KNq0lkkquVJL6zG5P6SOeUGJIvzNwZV+RFYzoTe3L73ZaC02?=
 =?us-ascii?Q?kEgMeFl1CGMQPpuF3b8vEPAZarOBqAa/ztiUQH2u/c2d6nZr+P7kf50eKTv9?=
 =?us-ascii?Q?i1FM9ZQtroLvZfYkk3Scnx76JAu95Gw9sG1MAUi+qbrahU1hmLa+nImJqw/+?=
 =?us-ascii?Q?zpPFUSxMOpjThhCkQlTh2KQluedsmald5ptAh4Ug4mL5PdqsITXW9R2jngKZ?=
 =?us-ascii?Q?YQloLIjo7hQWywZpbxa8vkgnTXroqhGqUnttXSWyZo+J11yi9akC2R7oYzLz?=
 =?us-ascii?Q?nXlKMHcZlkcp/W/e42RSYNfP3HpvaQl1HGvFI+nYSMnMr86bT2x0tKaSSSaP?=
 =?us-ascii?Q?7aN9kycbPF1lRk73J4G8lEYmlOFnaAEIM80KA3OIgQGi9rgpENfdoW4bHDd6?=
 =?us-ascii?Q?pOnm7G6AuLYTtme3DWNI2kojxTV0US9ZLPX0HJ1z3OoWGrbEo2vzSiM/cMBC?=
 =?us-ascii?Q?znXa4UyHYNcNT0PHf6bT5gI5TiklXWLn8DV//nBXivSlO+5SSU1BYDXo6dlh?=
 =?us-ascii?Q?OY1P89J/pAPOE/169ynJgB/SNk+dVzUzx58Db5yoI0TTOEQ6TXvrmghDcS0b?=
 =?us-ascii?Q?IRIDI/B88M9lJdqU+zOvlP+WeFwp1sQ8D9lW41an1a3o0iLuR+5RUndI3h5J?=
 =?us-ascii?Q?124c1c8Nizt3HnUYgJcaNNUNg4s7LRpDQW5anzaofDpKBQjhveZxkvsbBxQe?=
 =?us-ascii?Q?t5dhL+LLgMavkcI2zidVhRgVBc9XEjfa1W/VAEq/36N6drOWpjVAQZd2NjQj?=
 =?us-ascii?Q?OGz7FZkf2bLwBsB/FM+XwfqDNgMaiVW70IQYTBTPH/OaNaTnH0zUPKhzgvET?=
 =?us-ascii?Q?V0ruqeePztqE3cuIQx3kMuWZNjvIYN+YzxdFDa+okwDyU4bcIA=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c5cfe6-8830-4de0-882d-08de957b7e0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:31:16.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7658

On Wed, Apr 08, 2026 at 08:19:44AM -0500, Rob Herring wrote:
> On Mon, Mar 30, 2026 at 02:58:45PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> Subject space is limited, so don't say devicetree binding twice:
> 
> dt-bindings: iio: imu: Add Invensense ICM42607
> 
> > Add devicetree binding for the Invensense ICM42607 and Invensense
> > ICM42607P inertial measurement unit. This unit is a combined
> > accelerometer, gyroscope, and thermometer available via I2C or SPI.
> > 
> > This device is functionally very similar to the icm42600 series with a
> > very different register layout.
> 
> Similar enough to use the same binding schema?

Yes. I was under the (possibly mistaken) impression that different drivers
required different binding schemas, but these should be similar enough to
use the same schema if it's allowed.

Thank you,
Chris

> 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  .../bindings/iio/imu/invensense,icm42607.yaml | 95 +++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
> > new file mode 100644
> > index 000000000000..bbacdee5b906
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
> > @@ -0,0 +1,95 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/invensense,icm42607.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: InvenSense ICM-42607 Inertial Measurement Unit
> > +
> > +maintainers:
> > +  - Chris Morgan <macromorgan@hotmail.com>
> > +
> > +description: |
> 
> Don't need '|'.
> 
> > +  6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
> > +  accelerometer.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - invensense,icm42607
> > +      - invensense,icm42607p
> 
> blank line
> 
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      enum:
> > +        - INT1
> > +        - INT2
> > +
> > +  drive-open-drain:
> > +    type: boolean
> > +
> > +  mount-matrix: true
> > +
> > +  spi-cpha: true
> > +  spi-cpol: true
> > +
> > +  vdd-supply:
> > +    description: Regulator that provides power to the sensor
> > +
> > +  vddio-supply:
> > +    description: Regulator that provides power to the bus
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        icm42607p@68 {
> > +            compatible = "invensense,icm42607p";
> > +            reg = <0x68>;
> > +            interrupt-parent = <&gpio2>;
> > +            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-names = "INT1";
> > +            vdd-supply = <&vdd>;
> > +            vddio-supply = <&vddio>;
> > +        };
> > +    };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        icm42607p@0 {
> > +            compatible = "invensense,icm42607p";
> > +            reg = <0>;
> > +            spi-max-frequency = <24000000>;
> > +            spi-cpha;
> > +            spi-cpol;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-names = "INT1";
> > +            vdd-supply = <&vdd>;
> > +            vddio-supply = <&vddio>;
> > +        };
> > +    };
> > -- 
> > 2.43.0
> > 
