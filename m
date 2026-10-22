Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792712493;
	b=BZtD9ss6wz3c05hFDe1A1a4bvb564aKxSsLcol5xGWeTypYxwM4Bq6agQh2L/eHchh/o
	 6m80h2va9bT90xJYJSq7w+40Y3Lok5LjFOTfPs1iY4YhxM0QlER6p52hEvssuiqePTydP
	 gYNiXiDgh+XFR8JzYySIaL/mJ/u07bKTa86ZdvnVLZMVygQ/XQzrKV6hef1vF1YsZs6pb
	 6neVp2jKeBQczeOjV9Xzp+ypFlhZXONsEkIopiyKA7pAwHi5Y2oNKVZSlo/ApN+CarMPV
	 iuJRw0f/jTIufU2vf8AfwHXshKEdx+LX1R2rVqEJndJ5+eNZSWGrhTJSVpOvRjEBu6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712493;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LHOY51nVttjTjd+OK44VvgjXpOJoOZ5ynweY3P7swN8=;
	b=Y0MZ4nCdMzhPd7NdMHEqHwfobX5Ii1tCh0SAmN21FF8eYXEThMl1dxg+8zwym6DeP9ZK
	 IVIsxHavvhzMA8EnzCpSWekVzXJYkiR4zBmeF/l6XHOy/oUe00Kwj0n7CMu8DTDw11KIm
	 wz8BNiHO4mItBMVOtV3Th5A3kABYK21TPvR4/wfYa1IWsuO+EAtimnBZ4dcWEPK0dJ7FA
	 OMcFjd6jjQ7GD2vzJV2puwELyAFkzrJJFd4eLZx2gzZtt0TFx3FuoDvfKx7Gz4I36zt/3
	 cZ7fSHavlmuCFnlxPENfmma1cwcTTRlfsRHU8u1dSQOQnndli8aLe8q2CdG8UdFx9SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="cY13u/D3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.8
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012008.outbound.protection.outlook.com [52.103.23.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760C606A31D;
	Thu, 22 Oct 2026 23:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1760C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cY13u/D3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+o6Sq+5iokGaPZVLL4FnzipcLyzD6FxoID0WZf0/GI9r5isqdKGgr/PTvnM5pppjXLGsF9BwUQdjGuC6I+r31Hmar+ciy9ppzao+ratOSi4ILuIsx6PUyeq3YtVEANi+JroDDvFraILBr+SSdzaYNxHBaFNSUAuLhgfQKeanwTKqfLaUB3i304JMF52cwE3uuWyCYlyFr2q8U6FZSyiyxxlX1s2A/OaduxuxdvtvxXJmD5wcZymJxq97MrZeMkmTVL7REciWR0eJOZmfZlib86nHD1DAivznQRdHAKsoNVdPKqXRxhNDSlX7n60ZztT7L/HdYDfzyge+PUFIJXsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHOY51nVttjTjd+OK44VvgjXpOJoOZ5ynweY3P7swN8=;
 b=qgcGz93fZV2DDj+xSUew6G1Y3P+8vfvYn6e4ONcnavWGTvEmoWmNDIzVRoCT8b37IBcZVKjMt1op1MkoD3a48JPlQWQrV7gnZMgEIBwVAANP1amGyK4sPbyhGVOAkqrLw094oNFJTYefTw3XVk70pZLco7vnZ/y8wywKq9Y0oAaK3ns3jNRIwBfmGbY9rNQC4m6epkYujZmEZuyl5zW4NSRYstLqlYVe4SgXlsKl+8lkOzhxp7m6fjrIc02ZRUOpUuoj295XNyp9sBr7iWO/KECV4+va28m5UmVq3rnuRR2JBTxqzC1nPBELT3TC7xUpKoFDD8AVLmj9sJLnwVFBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHOY51nVttjTjd+OK44VvgjXpOJoOZ5ynweY3P7swN8=;
 b=cY13u/D3QRH73pa/xxFIOHF/avGAFtL5BstGxil0ToiretNWXSVKfPoR4DkixM6r6AKT9lI567PcfMnYsVL+sqR29u2HeeKRGm8jNaWdTROL9co2nO8sc1fWdRLxQG4C+R+LdZ7haoOPKrJM0c690CaPaZ2rv6SFAGXGtEfp1Dp6qWh1RDBNiUSAak0Kj3T/yTVLQy1bRWpqszt5LBHwaltZETpo+3vnX4D0hpfH0DEHS9xmRw/IKp0Am6USM7TQUj8b9efu7OePNUbOV+ggJL2fwueiEcTbrIssJKq7UNVFRaGoW3UIry/B6SEL9TYMsQLDR4R/ggZgL8LksLzHNA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 23:41:31 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 23:41:31 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Thu, 22 Oct 2026 18:40:31 -0500
Message-ID:
 <SN1PR12MB25283751BF4A06FF790BC114A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261022234041.61995-3-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: 857c30af-977b-4c8d-cd96-08df3095ffa8
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qUreO9dOhET7cya/2blvFTRFEsGhHswlM6oWxcGscs4+eqn/zFKM1PYmJZEJA8KwhwfW1xzOmXiIlnQsXYoi/Pm5dm69/q15xCUhEVFG9apE13fx/yM3EKktu7wknx3ycp9KOC5ZRS6JbQdt5sCCPZRXjrj1GTe4UmsVbfMeF1Ynyhe6beoJyCh8KoQ6twpHunB7Ev9U/KdfhfPWUDLbuKBsoMJcArr9wVZ/o8jL4YZ4QjcyaUkYy6iA6adllEkpMD5y4cXCMBRZ/NFRphGf9XXWCFgGreLwkgN8kCDpGgBs3KT/frITp5WG24W6CApkWwdYtPQiGi9V1j3PnTZxtHKDL/HjqN9vfcIujUZeknJiCw8nOEHMfqE9NjbDcrM9ibTIzyw5bkkTjggcvT2AjpfnhA4Myws5EUZgnuceKOmFnA4gJKn2YZJegderdqQwEgyMRXKg6mvu7627E/NYL7c3XsSf32Tp1Wv7iPAeChNpv3eqhAksxEmSBq5rPfO0WdwvMjGMyi2tZ/zKb3UG7WPjG53VlASnZt3Ui0hJJ+Jq2hcZYpBR9n6M5yBVy16QyKsn20Xb/7BtgtKCMvYAtcpblmv1IaR8S0daKlB9556D0aLHftkxbuhNbXjLRrCfGp0IiGNURbVs3I4ezo9uPIy0LOwoFMVuyXKNL/rrg8Vh15X4vK6h3iDtdpc0ZC33/elP9chF7IpGF7YmuhN8jacJPZ7yoiqS0DN/NkZJHpkasshXvDGuRYv9gUdNJIEchKpSduRaORYuh2DsHXuGtMBKrilAjCNK6wbouFURqFBZB+WUMUTBTHBoKmbYLIY9fTQIN5Xn533BpDP/rBhWnft
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|24021099003|22091999003|5072599009|23021999003|51005399006|24121999003|19110799012|8060799015|260925184616899003|41001999006|4140399003|25010399006|440099028|3412199025|10035399007|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iJ0wIScXh3h09evgLvDoR7zGWWMnRxxEKoVGB96THFWSZ1Oy0TPcGkzHj0aQ?=
 =?us-ascii?Q?2IuRWPAK3aapDw6PV4Tv0TkRITrnfbQ1A//rnVFqAfzZvF1lT3kzXKto3qhj?=
 =?us-ascii?Q?WkdoG5NFm1TfDWv2LLJ69Bh/cdKl1Nd35APRxuhupUzcviPX6dsieeZRYtSn?=
 =?us-ascii?Q?jxMdWPaFvVKfyB2zGBJywJN/HtMSpUsEmwtwt15qoXCysInJkGbx8TIX7y0j?=
 =?us-ascii?Q?nfsINC1eJwRJcjvZZYgdmMdwGy5BajhqxYjhlObe6VA4BE7drSxOCtY1KgWi?=
 =?us-ascii?Q?e+437995+KTZLxeDkgwLrq6Qo8o/8ImHKXWKdEBDcMtr3bhLg4KUj84xKs4w?=
 =?us-ascii?Q?kp+7kJZ9ADuwXifSrgFw+I4CtY41ekpiiUP4/mSWoSrKGa6seFeCGLqvBjqN?=
 =?us-ascii?Q?5tuf23zYIQmYrMxqOyc1yvjxOyXHXIPCznOR+DvxrhtUJUIJtHFxV6mAH1Hc?=
 =?us-ascii?Q?0na3eFcb+Id9QcXhb05ypjrf3H8RrUGxnCR670cQL1M4BVwLSmfiPgRzf3J9?=
 =?us-ascii?Q?Me6gHuGE6ZO4mEgfXJ/BJ4Z9DtE1ZlbQ9rt1djqnng80PBtKQ8mRMX5hMyxG?=
 =?us-ascii?Q?Jfz6LajbjOGseubiDbwb/uymNzU/TUwF4fiUkUDoJLouijye5PFHqqXIiFlP?=
 =?us-ascii?Q?TO+gEItMZDvUs22KhUjDiiTZCVWrdfzYZUR+q/O7nyecP7KlHr5Lywd+Q6pg?=
 =?us-ascii?Q?LW7nLw8KlPFRQLXTmJDDaOwS183IPN8CG4Xb/6VoiaNO2CGc0jxSsmS50Ny9?=
 =?us-ascii?Q?5E2QmoLrSm31cTQY90cM9kI5Vy8OzqAEY4q0UoeG4YP0fEsmJdj4RWBPCtWH?=
 =?us-ascii?Q?fyHx7kB3tqUst+QH4f0L5NOo9Q1owt5GC/HnRLm9XCN1QB+f5PiCZs4pfVFN?=
 =?us-ascii?Q?k9t6gvJHeu6QifoSZdAzJzzfIMY4Y5hHoPh4NLEu8Zt793lClOgLA4hG/Gzr?=
 =?us-ascii?Q?IocyUMng4b46frSp6cBsyZ1l9jQVhdwNfll+8Pukluhe31TUbeTy5Hbd/rtm?=
 =?us-ascii?Q?pPYvGqaVPoRBQ2yBLoMdsc/oisljumf7XyrNUQEUhH6hqMQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?htFV0LKWghfeIkuGjmr1OUrpD3TGhiOvBIftY/5DlocFHziZGBcWCyffXTNv?=
 =?us-ascii?Q?3QLRTumhsvvxquDqhA+5xgPdXCjeRttZb1tZY2ILZypo9peo4alPgV38183z?=
 =?us-ascii?Q?kzQXz+MaPv/Ogni9zqSbEYNDjeBuRf9WgzR3MBoHUKtnvomNyfKVabo/Taq3?=
 =?us-ascii?Q?GIcCDxBb1+ipIZyR/jlyGKhOUc1ZuCkMKTxbVy5poLbjBM7DKQ7hlQIqz+wx?=
 =?us-ascii?Q?QxZ263P1SuIUsp2StgsFMTkqo4CN+VRltpI1MYCrsJy7i+yejFlRq9oSg7Bw?=
 =?us-ascii?Q?4+CHy0IwdDfvrGL7tyRspOOsUkBErOmDEQTT1BkMfTmBY5AUvRVA7yky3hxF?=
 =?us-ascii?Q?qzE9DJboFBfu4VOceXbhOxyFvWcXl6qJpICkImINudAsxnZRLcW6Xh8j7iP1?=
 =?us-ascii?Q?FN/ACD2pl+T8CvVPPyb5Vq69igbjuW19O16Nunk2+NQcSWeogEcnauCMyUAi?=
 =?us-ascii?Q?m8I2g9s1lFzDV9yHyIUtyO5/eXCmQ62giSpGXyS/yEtRhvaFFRMy1hvK5vdG?=
 =?us-ascii?Q?41xCx2aqAaxLPiBJzx/SkwDX4bU7AZs0bIpulGhd1kgey4U/jfPggI5vtF3L?=
 =?us-ascii?Q?8fH+3ZXd8TLE2h7arRXqeSXlg4apPUaQ2JT/0mf7Dvspw0pqDQp6FJ/LBsx8?=
 =?us-ascii?Q?OHjK1tc/Yy9xYhEdIjEoOPD9AnpqGjsb8KvZTCbrZeqHaQWoS6y3mKvOFOXG?=
 =?us-ascii?Q?j2nOVduzD8J9qGOEDf+sqwcTsY5V5pIYd9MOYUmrui5HV2BI6fWPHtlPqOT4?=
 =?us-ascii?Q?sDoT8020WUTN+Ctvey9fyYbI2wtR0GXYMXBQXlqPV+wIpZcjZJsbjV+XUg+8?=
 =?us-ascii?Q?+kYjzFJCzGfhSrWtSTg3NQ7+f6N7S56mZDWIusIDqHOOODJCW/KTKjBBV91X?=
 =?us-ascii?Q?5mv0CS1gfuyg2Wvc49RY/QDOhttb9JOwYdfb0u0RUsGwKdbQxQxdmpMar7BU?=
 =?us-ascii?Q?jlaDa9WuNA1D+PajYoC1wTf0+0hehloEMbc/PvVljy8R2HtHZwLMrI6bYf1M?=
 =?us-ascii?Q?1IRMe4iD1pVGaMX2CP1igBvbDWmjx6Gz5l4E0pmqEXxbGA9z0iLOnbSBXCGa?=
 =?us-ascii?Q?GpsITxvZrray8HGFiUU0idiU565zaDvlfCsnh0jwb6n2fJ6/GFerT7qieku3?=
 =?us-ascii?Q?+qYwyw9eS9Belp8EvenvxiZNZgPUlSTYt4S25PgolEc/HKe45VPcg4Bs+edl?=
 =?us-ascii?Q?VPspVCtMt6WaZIhh3dwPZ/p77Cnu+oBclq0WqDuc/AnlKJcV7ELrb93+XF22?=
 =?us-ascii?Q?aQpkQi2zyItZycrdyulwiUykS1Pgd6gT2lD480w22CxHcIGzWEbkxZL9UkCu?=
 =?us-ascii?Q?/Smxx6ouiRgchyZIvWcI3tqD2bWJHgh38QIJxkxyMQIzV676x1Yk+TGUN/ZY?=
 =?us-ascii?Q?VZ0kCDlcH+BNs073ASBtyDDPEA6mOpFiVGyyDwIEskFaKA2LsA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857c30af-977b-4c8d-cd96-08df3095ffa8
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 23:41:30.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135

Add device tree bindings for the Texas Instruments FDC1004
capacitive sensor.

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 .../bindings/iio/cdc/ti,fdc1004.yaml          | 44 +++++++++++++++++++
 MAINTAINERS                                   |  5 +++
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml

diff --git a/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml b/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
new file mode 100644
index 000000000000..d22b7bc92a3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/cdc/ti,fdc1004.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments FDC1004 capacitive sensor
+
+maintainers:
+  - Victor Chernyakin <chernyakin.victor.j@outlook.com>
+
+description: |
+  The FDC1004 is a high-resolution 4-channel capacitance to digital converter
+  that works over I2C.
+
+  https://www.ti.com/product/FDC1004
+
+properties:
+  compatible:
+    const: ti,fdc1004
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cdc@50 {
+            compatible = "ti,fdc1004";
+            reg = <0x50>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 360977678f70..69c23ae21016 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27388,6 +27388,11 @@ S:	Maintained
 F:	drivers/net/ethernet/ti/cpsw*
 F:	drivers/net/ethernet/ti/davinci*
 
+TI FDC1004 DRIVER
+M:	Victor Chernyakin <chernyakin.victor.j@outlook.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
+
 TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
 S:	Maintained
-- 
2.53.0

