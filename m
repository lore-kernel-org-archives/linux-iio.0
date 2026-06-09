Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012016.outbound.protection.outlook.com [52.103.11.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD336212D;
	Tue,  9 Jun 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034685; cv=fail; b=qK3r1NU08bHrJggIvPWD+TsSMRfqHz6Kspmmc7RUU42ck5EQK6na/TsXMVSfUuhSyGvUbdDLfzENFjie/9BuCz5+giqoal6jOpp6q+6/4XTlUPhoccn57yr5gDxXydGHWuBkQAjJZthsO2c8JsNXr5S+BYXz9CXYptf/fnjjX+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034685; c=relaxed/simple;
	bh=LtUW/poypDDX9Slw6v7bi1HmRAv75Q8xJLY53NOq3HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tZTvBISnbU1LirnJDK5Xlk4t67ofq7REuWcNoSGQ/vmI/DVSpGah/JUiub49KY/LXY+/nltruLePtbhPvebsXoT8fr2nBuzyhgAf5GbpSjbb5TvHHy3gGEMO0EKQlXg2bezI0ZaqplSl85tqwr2ZGmXA3T0qTv1LFnIbdyEoZNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=kr68Bwb+; arc=fail smtp.client-ip=52.103.11.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="kr68Bwb+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUvtkp9YuoCtx0wFz/XPXpVCnCC8IexCG7KfxvW/kiW+Rh3vckepeZ2XwpFYEmngoawee0YnOymH8Omvuaif/KY1wKjmQP11QPreZg2xzmTwM8OlpMotGS80yqRTmGMgu/3q6es2DmMVYtWGabXX9zWr9bju00SNu+2lMOPSDfSE/Pm+thmxxHECKceXxrBtafdJb6t8HVd0MB0WVH1b9FbM/LCvf5ZfFqJg0wdPlxzmOmSBLPs2puZ98LUNImI7T803+CbGJavD1qZfqJVc5XYI9ApO0kCXIiTsNcCRAdPU/M8mSAQo4SZz527FAYC1BVML1T6HNjCV36anG5EGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjPVfW7E0uLs103JPukwkRgdsD8ogCjHEXhIG9Gtpfk=;
 b=ecuaiVhSVWs9KuQI/xebHpeJnKLUfByzIMNvuF2GmhoTy4/XYcbfr8Z1aEEzQ4ZctpZFoBt1uhfAM5aq1DO6JpFmShSXSFQAw4+73KQr9eMgGro42HkLJj4IsW2Qetdz6vk8wGqbrU6zD9jMLnIQX5ZcQJ6V5Gjx+439PBiAr0gXWK7bWuhbYeZR14B7/O6OxsXb8e1qAb7XRn3LcBjV4CdrxzIfoWLb8A5g5cx3BKlsHNPTVVqs90Yj0v6TYkDnjYu90n2I17IoLr/mLOfFuvN7mNKWX4mi81AxTYbMaCjSs2hX86F3irm9y6IARmh9JQ0HvbtmZoZUT7qUFWqdkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjPVfW7E0uLs103JPukwkRgdsD8ogCjHEXhIG9Gtpfk=;
 b=kr68Bwb+CFpaViRzXJjOg5aA+lPv9wz9r7KkiVW4xnuPpKKMnM0BUm8TMGgHzCbCl7EuHdU2doEU75AoN92WP2zVHpc2qQdRCwWaBILquQb4nEjHa9Je+alEAXwBXpNqSA0wFzaKhdaaSvlCJG9wBWHUxj4spXgCyS42wHmJtyAVyGbyeHEW0vQf8PJMOYabDh431Uyh+tR+ZfixUWBE34Ro+gzfCiqyHYg6VxfmnQS7cEbP/K+o8GY5mbU9COfDAGlnyeqnag70q+yqXN7PdbLalKVUFvqUcXyWmPtKS+ADLeQsG2BB11mte9Jc8b7vHkOPuRhR6XI0/y7I3NoC5w==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DS4PPF57586ABE6.namprd19.prod.outlook.com
 (2603:10b6:f:fc00::a1d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 19:51:14 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 19:51:14 +0000
Date: Tue, 9 Jun 2026 14:51:09 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V10 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID:
 <PH0PR19MB99733822F73EF61B82CC16C616A51D2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260604201832.60656-1-macroalpha82@gmail.com>
 <20260604201832.60656-4-macroalpha82@gmail.com>
 <aiL0g8d0Y_JeAC5c@ashevche-desk.local>
 <PH0PR19MB99733851DADB0671AE5F76B788A51C2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <aihiM5Ao-vuAsUyh@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aihiM5Ao-vuAsUyh@ashevche-desk.local>
X-ClientProxiedBy: BN1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:408:e2::7) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aihurag8rYoaFxvy@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DS4PPF57586ABE6:EE_
X-MS-Office365-Filtering-Correlation-Id: 30654a6d-6085-4117-9982-08dec66076c2
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOwwMqWN8zwtxT59/18TtI5easvhHGN0AXaTa3e7B7e9g5/aGOySUppcOcTVnEhG7iyyLMi48jZaU1K8L+h+tGCbCUA1CYY1jpxiA15nhsceoi6ucyfNRcPpdDCiahMsWMj6CsAqpJPtSDl/dbnrvoFyExrSUMgYSIUjLmZYGRYPrNazgooAE1j8BduPBxfKayNmWxyCutcne5MvJBzCK/rAze4qLtd7Zpeu7pw9cduG7nuK/gVZJz7cZJXWWUL2ZRab6uf4Fzv5YzPWGKKFk6x09QeLYrr2HkVvsrZsFoMOwW6dk7lSvpyc66PiAPQFTEnfyyjMjxqqkecmWSBXKBxSYSmJMsdN5nVopWJhv60HypXptj9ANZJOBPZS8IFhatgQloqNuBTi9zI6s6mZ2tvD03cGynZlRfLcxaPYAd3jz5xAKvKvAUEjemmSQzPD2M52bj+6MS8k2BBpEwbynCj/o8sZTuydwUt4dIBR5BW4Qc6/A60lRQz7+7roL6uHlc0QwDm5OoNTDQRn9Rd75ODIjzkNQo2oB1BfUYm8gTeeB2xqbBIbF0bRjU4OCtyLPiMCyeor9T/agbB1sKPCrXOiN7Rat6J4+oFxW2NsGb5yJm5YCZqfWMksRsbVkivyr5dUAO3zRVJmqlYh09BxRLazlVJt7YeE0X1nwYRtL0Bc7sNGmKfp2jBUV1WUD5Aea9uNoS8sW6VZDSBfFQypNiL8/J5qMF/EEByqoIL9rnnpU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|51005399006|8060799015|5072599009|25031999004|37011999003|24021099003|19110799012|6090799003|3412199025|440099028|56899033|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MEjvzxQRHGNxVsnUhTBDZzuN3kRqe+TZTEyopQUTTr1psgG+M+vH/KqMq1z?=
 =?us-ascii?Q?+BxJUBsWFq9XGMGGuLuo4s0de7ZWnRmqHc3/pVBCr2u21N32Pm/kobgxITA+?=
 =?us-ascii?Q?qOJlklxRApsbtBlgifdHRDBBMp9y3TU2//Z7f+pectqP6tVx5TELevIQCWds?=
 =?us-ascii?Q?NYYDPpzx7k4/N8orC1hPxwgtebm3ZSE1ZAC5ubCrSgXbkgMs2R20PY7i6I4s?=
 =?us-ascii?Q?Kf0xSt77ZhyqaZpKW/BsVq+HaPDuKicAClrvGYdJSqz4mTGN9AeGqPRCI7S4?=
 =?us-ascii?Q?7llx/RT9onxUZVfpRWNburAp5ZvPEB7/uJZGw7BLKSutMqO5H0gGjxQYo8ag?=
 =?us-ascii?Q?2UqHAk38fU2pwr7OXFZkfA+ABhtq5NfEFALzXenjr/xqaUzJiEiUlMYCDMFe?=
 =?us-ascii?Q?dbQHQc3bNUFHEEc4tUUlOYz4w9OsgUsnq6y4IaLZbcSoKs30rtMvHnZHFEIr?=
 =?us-ascii?Q?Ef4mMQRoA/3AIzbTI7ICPwahA1sY3qoA1wvDjgR47zJ0BTO+nx/s7JFqTsZ0?=
 =?us-ascii?Q?0w41z7ngcfJVFYpGyykgI6WgF/40P+Gj98vyv/t1H2rWfLDJblsA1Hni4Hh3?=
 =?us-ascii?Q?ZjYsO6fxWBTUSj41BB+C++xpn45DyuT7jZrinJjo1Yro3MldyWrIfc8EPl8e?=
 =?us-ascii?Q?UmJ8U2OqikVTQVW4G0ygncsUn3ZcX8Bo/pGbKUzVT5KL/XiSNBQIjcvC9PR8?=
 =?us-ascii?Q?9fLTvQ0QnBd4uekS14AvOOM49OAQTLt5NfS+qMTefxjQGQkLoBVqMqzlht4t?=
 =?us-ascii?Q?AQGCU1yfgPtoZn4AjYFIRjhGA3rwo4qZ7DqS/yMYYvMuMGIKFJjpuwXhNuJU?=
 =?us-ascii?Q?m2cEwdTbgKZRn0PELgwaZSGEftfSM+1uhFAkI530O/KwbhO4mzsANY7ymcsk?=
 =?us-ascii?Q?74Y/VXDjOliPwSNjlC5txu9Ih4ZKOwiOVTYKah2rwrZHP7SsPIAXdHs/gHD0?=
 =?us-ascii?Q?o0yRF8yyDHd36OnIUn9vVA3gsCgweIhsBK+uVV+P+lU13h3MlvS/b3V9X6Yy?=
 =?us-ascii?Q?A0K1omDhLZn7QLQlIGoWo8u0LA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gl44N2EnOf6LifvZeyHNOM1kxyY67eKxFPCDnt8rirM4KvzGtf/k8Y36CBQJ?=
 =?us-ascii?Q?P1s0ZlI3hkVWJjj79PQ5un8ZhxKLm0dxL3+ljssrToI9xzoGKNi+yypclZsH?=
 =?us-ascii?Q?ZyFte4JXLt01V6NWHuA6Qw0P7ynwX93TxhKayOApa4LuRu3/SQFGHgbgG9cI?=
 =?us-ascii?Q?ge28JpYSN1TmkRAkWNLWnsACoGPub8iHjBp7q9R9ErfkN9RISNfvnUR2bXq0?=
 =?us-ascii?Q?dBfmt97piSdjff/yDJFDAJlNMXzoYglprK8u6Lppy4qmStGu3kieVLvtPTnf?=
 =?us-ascii?Q?D5j57S6DAPVD7i1qdWRNqj9ZPhhYv8O/HTW7y8qrrxdC2YP8SnF0c1PKVgwG?=
 =?us-ascii?Q?PdyYjkHcRqE4T5nc11Bo/DAmIUet/kI/UHIDxltK0c6jvZ1aXOegtKysZ7kt?=
 =?us-ascii?Q?eF0yqChWAUsUb5/zBFmMQ57DRaelkSp52dZuR8A+1/Qcw9zeXWYYdTRhLsg3?=
 =?us-ascii?Q?oH+7Iz1I6XlFXyjnN5ZVkeHXtFUHriJKpgNPjRviFoSBEIsp8oJA6BbadTPd?=
 =?us-ascii?Q?Ct75Uk+VzGZqTCkTE2gQAdZwVRhnWi4EUrO/SeQhjw+fDlHM3Ix7M6FvuQ/3?=
 =?us-ascii?Q?5HQwUb1icALaCBVD3AgECz49BDovBY0AXMztx7m2mVsD59G+rtIvOfMSDN6I?=
 =?us-ascii?Q?cMFpeyI3SgotvuWStf7tDbcpe3IbHIEMmUmhQ7DvcQ16oeKKndMUFI2G0yxZ?=
 =?us-ascii?Q?8Yy4KwSWXnND59w2+TTIaaCzFKDfH5jA+Tmtu75gnktDCsQ9M5XK9I3qcfUx?=
 =?us-ascii?Q?gcjVlCAW59cOccJ9ZLpOF3uLPtRkvhJvCH/I/yiOkJlRkqW89bV/3Xlk7+sE?=
 =?us-ascii?Q?jIclcUdRGXrb5PeetezMKTt6nbqhyaTbbq3qj6bwilvIj6wpCPF8WKOVHun3?=
 =?us-ascii?Q?xOYDn22HsKa9ZosUI2YsCfa7Hc8dt42bQSJuUFfJYyTclWNXfuxWix8VVFYo?=
 =?us-ascii?Q?/BZ5TqdJC/LLm5akQdTSdzTn/yk58XA5kUyuv+lK0r+b3LFB5kWpAF6y8lsJ?=
 =?us-ascii?Q?sZA20xYC9mFcVxUhCViVNj9nOf8Hr5sEyjj/2JKCjkVUxreZN+uV+d2Lf5OA?=
 =?us-ascii?Q?FO5HuoVwRuNj6Go8ibInBW7iUpu0/Nbh5nf9waCl6ykbAI9kKuJk4H+Cnxfa?=
 =?us-ascii?Q?PUb9AUJfOVsr7fy6DZ8w9I+KZR3kQB57SeVWo55wMcTFKG9ITz9jBdA/PjHL?=
 =?us-ascii?Q?43j82sXCKx94Pm0Wp1wpZ3V2CQ6K1upxY91LrYuRBerCaqMUE6d+fVHDx0sa?=
 =?us-ascii?Q?t0NBdRE8S5C49d2y5yapqVOHwflMQMniVeIIyfqYcF8GdobMDjuX1+4fjy3J?=
 =?us-ascii?Q?u8vJE1Qz2l7k74A/jqXkH2xT/pQ6Hmkukm3hTTy6U3R81UC2jZE7FdcaQDbD?=
 =?us-ascii?Q?RSM3ewQxdTSO42W1GoiZ4t3QCpqOpWktqslQ1mpMicIzGU+RNg=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 30654a6d-6085-4117-9982-08dec66076c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 19:51:14.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF57586ABE6

On Tue, Jun 09, 2026 at 09:57:55PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 08, 2026 at 03:52:38PM -0500, Chris Morgan wrote:
> > On Fri, Jun 05, 2026 at 07:08:35PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 04, 2026 at 03:18:25PM -0500, Chris Morgan wrote:
> 
> ...
> 
> > > > +struct inv_icm42607_sensor_conf {
> > > > +	int mode;
> > > > +	int fs;
> > > > +	int odr;
> > > > +	int filter;
> > > 
> > > All of them are supposed to be signed? Why?
> 
> > > > +};
> > 
> > A later commit will use -1 for invalid values.
> 
> Okay, perhaps add a comment on top that negative values will mean invalid case?

Will do.

> 
> ...
> 
> > > > +#include <linux/delay.h>
> > > > +#include <linux/dev_printk.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/property.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/regulator/consumer.h>
> > > 
> > > IWYU, please.
> > 
> > This may sound like a dumb question, but what's the best way to invoke
> > iwyu for a kernel? None of the readmes or man pages seem to be getting
> > me anywhere...
> 
> In this list we (I mean community related to IIO) discussed iwyu tool and
> its best configuration. Yep, it's barely good and far from ideal, but that's
> what we have currently. Otherwise `git grep ...` and cscope are your friends
> to answer this. Also doing review on regular basis makes this knowledge
> developed better.
> 

Since git grep (and elixir.bootlin.com) are the tools I know best, I'll
try to sensibly pare down the includes where I can. I do see that the
interrupt include isn't needed anymore so I can drop that one. If
anything else jumps out let me know and I'll exclude it too. There's a
few other things I'm going to pare out since sashiko.dev bot correctly
pointed out some of my code is now dead since I removed buffers support
(because I don't have an interrupt on this device).

> ...
> 
> > It will get extended, so I'll keep this for now if that's okay.
> 
> It's okay.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you,
Chris
