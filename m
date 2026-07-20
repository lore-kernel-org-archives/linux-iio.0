Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013087.outbound.protection.outlook.com [52.103.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415B445ADF;
	Mon, 20 Jul 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567817; cv=fail; b=jNm/HNs3nZOsZGvMjlQGDHic1DvO6vqVWiZWUvlxzTnwWIMExBXKZltWXfS50DXw3zEW96JnZ4ayeQMzA+zK9Dx1EeKr76sxV/T2hTAVo7PNJVkoTx3c3q+zUVjlhdMhhm52wpbPEKCADvakokwaQFoOL/VNXm1g1VXGH9eW2aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567817; c=relaxed/simple;
	bh=eABo7x2gvx2G4Yh0yhTpco6TGvtwMo3BPmb6M+Xa5yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dv5KFpuLZgO/7bgs5D+o7nV+YaAw1d6YYelPGEmms+T3+gHZtCsTTTtmmRb337qJMOHS9c+rqlD5O4/xdos/ApUmU3xkr1Cl7iE4XBHVXj6MNGF9vHVVVH+2hlNli2NssDKNIbTHMmlewAABhyRmer75mZFPOf1XZlwEkIep7Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=mSAgiVS2; arc=fail smtp.client-ip=52.103.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="mSAgiVS2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptQhZOhpVZuE+JLhUWYO6tw80KDdWL2bjAtN2Pbo1yPyFR+EmnzYabo3kl2kgHECobA33F0/IvAKJd0w26N/JssQoGr1WHAXokkJwiOHwzw5QewlQ/Y32dSislKWzKWVxoHEAibJK7TosPGbuV/I+X4mPlJKlUm+YB8Wm1wxte+PUethFGpvPbb8bUbPzP0KBIPg2tEV/pUSewJSXsGwBq8s+snFRuvNB++jl5saI7zjeB5i7jQeLY8toS402tcyy3O147b1rW4C30I5TL4RDA5JMBMpi7lu6v4D7U+CkCflFaapYQ68+LvyhpHR3AwOzf1xCaZaO6fD7/0G9gVOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpzhKxDKiUIXA+5d78L0T8rYmCEoOQ0wgVGlIpwxgWU=;
 b=wNPn9ODAgQs0YZIlivnCgvr9txRpAtrgyE2+MYsWzQQBwwLUkLkNUUKlm9VPuNMSUGY53HdVDFFrty6jpM/C0IHsvaV8eWDI83quT9tdSWWx/WBNKdVbpKqkAARgQGfdDqUqnbkc8Ddhx3704KjIRMj2xRvbDgzCEUIu4P6Emgzb3bx7v5litd2QY3AGcOF5pgp4Gmumg5JxntqBQiVr22F6k/xL4GNIbzIS7+4v+UIlrHSlNGG64IM9ScZAWsxPtxoJDsNwVeduuWsRYLGL80HGUFLQqgxCivbLLQuWrEV/Y2nn/l7f6lE3J4HGIvOoJ5wOu/Rvp+dMHEbibNhdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpzhKxDKiUIXA+5d78L0T8rYmCEoOQ0wgVGlIpwxgWU=;
 b=mSAgiVS2HtxMrZIzAQqEUm9kerXKRGshAr+7t7tHEvt1l2xhZojaBqZ2QjJFuIhwD3N9mfQZW05FWa9g3vnhB5IeeuKep8iBkLzNnoUgElTd3culJj8VIizwHL5mYkW22BnOhqDThPG0ivrzcVikPg/sjjKNfGEC8WphsOlAd6tco2pglm6rz0iK3HoEN8jLucPe9SzkhtpNSysBuWRmsbnP0YptrLhwk7vMWt2UP06LfKRQIvRIRU0MNvAVaWPYhc3YqWnMph4WsMQpt/omNvXl6UjdH4cL2d5gz6DHbXLIflBdFd++Dyxg6TARpgrcrqXDfqvXi6/glUzS6WzBtw==
Received: from DS4PR19MB997335.namprd19.prod.outlook.com (2603:10b6:8:34a::23)
 by PH0PR19MB7478.namprd19.prod.outlook.com (2603:10b6:510:28d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 17:16:49 +0000
Received: from DS4PR19MB997335.namprd19.prod.outlook.com
 ([fe80::bce3:a5d7:93ac:7dc8]) by DS4PR19MB997335.namprd19.prod.outlook.com
 ([fe80::bce3:a5d7:93ac:7dc8%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 17:16:49 +0000
Date: Mon, 20 Jul 2026 12:16:46 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH v16 02/10] dt-bindings: iio: imu: icm42600: Remove
 interrupts from required
Message-ID:
 <DS4PR19MB997335033645A4555221CC6006A5C32@DS4PR19MB997335.namprd19.prod.outlook.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
 <20260713215842.69097-3-macroalpha82@gmail.com>
 <20260715-mottled-uncovered-mastodon-6c08be@quoll>
 <PH0PR19MB997338D80EB8ABB7C623850A23A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
 <82e3c736-f06f-484a-887c-9e156cb7cb44@kernel.org>
 <PH0PR19MB99733836951FBC9755A5361641A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260719001848.435886e0@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719001848.435886e0@jic23-huawei>
X-ClientProxiedBy: SN7PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:806:f3::24) To DS4PR19MB997335.namprd19.prod.outlook.com
 (2603:10b6:8:34a::23)
X-Microsoft-Original-Message-ID: <al5X_o3nSfwogonJ@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR19MB997335:EE_|PH0PR19MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bab5bba-8cab-460c-4a2b-08dee682aec7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|12121999013|23021999003|37011999003|25031999004|25010399006|24021099003|15080799012|55001999006|5072599009|13031999006|51005399006|6090799003|8060799015|19110799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtD8Kapl6hSzwQMzlWxWbMf8SBfivYbmW5AEMfh+GMPNhiBg50552CWyebxf?=
 =?us-ascii?Q?GwdTjSdrIXlgJ99GKnYNVThqf2uWCHfh0iHGyzRrZlRGjGy5KAvwb5sWpmVR?=
 =?us-ascii?Q?X2uQvd8ZyXAobdcX1kykpMYDJ428v0EkdHcGK/aOdQWTw9K7fRtGBw7CYX1n?=
 =?us-ascii?Q?7T+D6YqvAbNTqsx2c8gwKEsYCkUXAljGKdJHmiad10RxTF85iBO6QtyGxsdZ?=
 =?us-ascii?Q?sVc2Me97J5Vs0shX8DASe+R9n/SUWmntebdApmAfllGoYKDE9MFpzQ5Y94lV?=
 =?us-ascii?Q?wVqj36jApmlYzWdkeGEGNifynGjMYDy8dr6/ckgWAg5kIUaBQLE17l29TkAW?=
 =?us-ascii?Q?W9LIDDjhXtwl5Qwzz46e3s00UVJXE94KLel7qFE+YcRviWocPaBjjh6rCeQO?=
 =?us-ascii?Q?0bjy2EdpR6Bx31vvQfse5+3QGd0spCKZVM5+YuQzBTGIUvgHectdXi6CSZAO?=
 =?us-ascii?Q?qSh0HWM6G/wBCGgT4RIDLMPLAaGGHY5nJlZGfW3Rsb+Yxw0wB0fmpIY/TRC3?=
 =?us-ascii?Q?s9s+2A6T8J6VHKroUnTZaocmWNVD0E3fF2oiSlHVt8y7mSPL901K1ZSsbZ7n?=
 =?us-ascii?Q?KVcWHStMOc5U7FUfOzHA09kPeoypr5Ju4sO+UYzO0KuNo5/6wLd4lHXwQmp+?=
 =?us-ascii?Q?XsfKPoxFQe+vz66rw59J6p2Hw1GapNlPxyfM+K6TQnCiudcvmesSUA8OvsXs?=
 =?us-ascii?Q?t3Ib0FvJSOZrIwTxVHlfIM5vcRZsQIhO9PC7jzLbahz0ZbM9DGIc0a0oX6UC?=
 =?us-ascii?Q?6E9iguVtw2a3wjmk+UYFWUjc2NntE2F7jGiBFn88hpnnIWU1VgHBsAIbBM/6?=
 =?us-ascii?Q?PKOZmx0AQNt6oqvyg0EmuxlxPOy1gXxW89F3lWn91QSJZE9US9OGjetz25BW?=
 =?us-ascii?Q?LaYC77ApQxq6rQqDU/2gpnCnLbPysfgER9DDyTIjSc8mL+P9erTlFm/FV2jK?=
 =?us-ascii?Q?1k9BIYUsNUQACgi7+auounn8fkd7fiGm4AunmkhYUCCPQe1uQicwGjPtILjn?=
 =?us-ascii?Q?Or082j0V/5U5kprSg8k+QSWhNsbDoMMJl8nRV6K0d+4anxb9W7+4bfdoWRBg?=
 =?us-ascii?Q?cdwDmPPTwi3ytjzLenxQuTdf1LSBJllFfOWvg/eflEJwIA0G2itHOr7wZ3e7?=
 =?us-ascii?Q?RkKUxRBwmYOV?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WRDP58QtgC/zyIHmXDda3SRAu0jAj2cvDdn8eziyi7tu8XNeqUqPGf8hLZb4?=
 =?us-ascii?Q?fuE2/XsztU/AvpZHzaayPXmO949NbuyPIA7MHmtGV9zReJUJlncfhBhcoeD2?=
 =?us-ascii?Q?X2HjpMqYVAGpN2eb66JR7Kfs0JLgAkMH+g8eUZsocSREjxWYfvlqPg5+wObe?=
 =?us-ascii?Q?UWf4iUZsXbgUUi6eOqQ+8i7LNmwqIWQIBvXq5BZU2lqS6psaiAem4YncX9fn?=
 =?us-ascii?Q?Ra8qQK8WKcCztGttIueGlZfvoYo0JfiPO+mvY2d9tBgdN//fJrCxAwpS44GV?=
 =?us-ascii?Q?+6ZTBoaJXDaGCtsgPSE7TbbZuAolF5EHzJZm8NUqYhfVXQpe1DniIV49Qiha?=
 =?us-ascii?Q?E9DckcZAGOdg73KpeJ2S4PpY7P2qvjgMhqdaN7F3xYh6NbGmXV+/lBnDr4eo?=
 =?us-ascii?Q?Pl6NcqmNhL9bZdwZTXTVdwKHD0BX5sWl4vAsda50Of2MKzMz/FqxJZ7Eyo+w?=
 =?us-ascii?Q?Wd7NuFHn/sLvfc0rfKliq+puXtb8brfBJiyXz3XY3vDjYWjopzsECuAHyRYB?=
 =?us-ascii?Q?r6TI9AAXJKFchX7HomXXLFhxbbBypRZydO8S11lVNR8NJBlnMuqNd671nMCb?=
 =?us-ascii?Q?18rhHnBBseNbDHIWECKGb5CwjbktKY7x9SMPEOBHDbrg+cdBsqpBYVwBPzIC?=
 =?us-ascii?Q?604lOcWAm4F+ejUToSCHddXn3tY4a26KevEhMejYdDze8/Xjf/c6XJeAkJQO?=
 =?us-ascii?Q?7GqEurPMNNNOYZHiCeQ/7MCxgDl/qr4T7nPtFqL3pFmBrIMZAZO/5HCsntw5?=
 =?us-ascii?Q?zfOS+uyZEgfgb+3xJAJhhCOWtevNG4oAPZTfRJdocdhbNCHf8YGub8mTUGCI?=
 =?us-ascii?Q?2j1RBVVMstJv2wtGXTJZ+1gG1CNTmYQfOs9Ooj7rOcQ49c658ZeTexnNPMFt?=
 =?us-ascii?Q?53erCyatU77Spii4gKFo3/lZWHxNEdU6wbu1EWAyux/HejZe01k8QiNhlYgm?=
 =?us-ascii?Q?GBU85xBTN3vGMeVvr6SNj6IaWDQA+AVzybHMDZQp1UAXYQNA1w4381I/MbTE?=
 =?us-ascii?Q?Hho0U+/biHQWq6y8N54fAWWuoPS/VD2RD+MuyzxMRx5GXgxaBc56a+yy8BNB?=
 =?us-ascii?Q?FIAFuWNrfPLpS4rKcY+vAssm9zXIgVLVROy/CiNuvnqnPNb2R7XuRwziS7bd?=
 =?us-ascii?Q?+rGXKvS6lzCb15JMOUsc+czornz2HqA2aHbaJk/T3dzn3/mWFHtxl6StgneF?=
 =?us-ascii?Q?8g5T9Z5SHT6uRzlAzj+o2bEngsFdNZZakstyTvEfDDh4dLSDR+NfNZyDNvFk?=
 =?us-ascii?Q?CvyeV6vq1cPOkj7HDd+JZX9lpjQVelprVjv6XCaJ8MSPlHFDlXrgNFKkwJCf?=
 =?us-ascii?Q?XOwRogaJYW8cyM6mGhS3/+vc3MVU0vBJHhgnqGVCAR8rWxaXnoa14W2yRI8s?=
 =?us-ascii?Q?49h5SZMQ+iG+U2CpIb3ltHGyNDbnOuanPHjBRc8UIIFu0HzBn99SveHEfy+v?=
 =?us-ascii?Q?VsCBdt+6Yow3Jj9Lyk+/IezzEQ5Vx5Un?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bab5bba-8cab-460c-4a2b-08dee682aec7
X-MS-Exchange-CrossTenant-AuthSource: DS4PR19MB997335.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 17:16:48.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7478

On Sun, Jul 19, 2026 at 12:19:00AM +0100, Jonathan Cameron wrote:
> On Wed, 15 Jul 2026 15:34:53 -0500
> Chris Morgan <macromorgan@hotmail.com> wrote:
> 
> > On Wed, Jul 15, 2026 at 08:29:44PM +0200, Krzysztof Kozlowski wrote:
> > > On 15/07/2026 16:52, Chris Morgan wrote:  
> > > > On Wed, Jul 15, 2026 at 07:52:52AM +0200, Krzysztof Kozlowski wrote:  
> > > >> On Mon, Jul 13, 2026 at 04:58:32PM -0500, Chris Morgan wrote:  
> > > >>> From: Chris Morgan <macromorgan@hotmail.com>
> > > >>>
> > > >>> Interrupts are almost never required for IIO devices per upstream
> > > >>> maintainers. Remove interrupt as a required parameter for the
> > > >>> devicetree binding.  
> > > >>
> > > >> That's an odd statement. We do require interrupts when the hardware
> > > >> requires them. We do not require interrupts, not because we have such
> > > >> policy, but because hardware does not require them.
> > > >>
> > > >> Plus, we do require interrupts when software implementing ABI requires
> > > >> them.
> > > >>
> > > >> Above commit msg is simply inaccurate and misleading. Instead, please
> > > >> use actual hardware arguments or how ABI is actually used. You must not
> > > >> introduce changes to ABI just "because" while for example making that
> > > >> ABI conflicting with existing implementation.  
> > > > 
> > > > I will defer then to Jonathan on the specifics of this, but from what I
> > > > can tell:
> > > > 
> > > > 1) The icm42600 devices don't need an interrupt for operation other
> > > > than for buffered mode or wake on movement. One-shot should work
> > > > without it.
> > > > 
> > > > 2) The existing icm42600 driver does require an interrupt however, and
> > > > refuses to bind without it. The driver could in theory be modified to
> > > > not require an interrupt though and skip using buffered mode and WoM
> > > > when no interrupt is present; however I don't plan on making these
> > > > changes at this time.
> > > > 
> > > > 3) The new icm42607 driver I'm trying to upstream does not use an
> > > > interrupt, because on my current test device it's not even wired up.
> > > > On future devices that I have with this chip I may pursue using an
> > > > interrupt, but it will never be required.
> > > > 
> > > > So should I go back to requiring the interrupt for all devices except
> > > > for the new driver then?  
> > > 
> > > You mentioned two drivers, I don't know how does this relate to them. In
> > > any case your commit msg is inaccurate and not a correct reason to make
> > > a change.
> > > 
> > > Best regards,
> > > Krzysztof  
> > 
> > I'm confused, so again should I just go back to the way things were?
> > 
> > This binding is to describe the hardware for devices using two distinct
> > drivers, the inv_icm42600 and the new (that I am trying to finish)
> > inv_icm42607 driver. The hardware requires an interrupt if you want to
> > use features such as wake-on-motion or hardware buffers. The existing
> > driver inv_icm42600 always assumes an interrupt is present and thus
> > fails to probe if one is not (making it a "requirement"). The new
> > driver I'm writing does not use the interrupt, because I don't have
> > one.
> 
> For dt-bindings, look at it from the question of 'is the hardware useful
> without this interrupt?'  Answer is yes for vast majority of sensors as we
> can either reduce features but still have some useful ones, or use another
> approach such as polling a ready flag to replace doing it with an interrupt.
> It is very common for boards to come out where none of the interrupts are
> wired.
> 
> The only time I've seen that they are actually required for IIO stuff is
> for very simple devices where the interrupt is the data - e.g. stand alone
> threshold detectors with no ADC like functionality.
> 
> All this is independent of the driver working without the interrupt.
> It is fully allowed to refuse to probe because it relies on something
> optional in the DT-binding.
> 
> Jonathan
> 

At this point (if it's okay with you) I'll just make sure the interrupt
is not required for the new chips supported, as the distinction between
whether the hardware needs it versus the driver is a bit lost on me;
however for now the driver will fail on all the older chips if the
interrupt isn't present.

Thank you,
Chris

> 
> > 
> > I'm thinking I'll just go back to the way it was previously, unless
> > Jonathan disagrees. The interrupt will be listed as required for all
> > devices using the inv_icm42600 driver, and not required for devices
> > using the inv_icm42607 driver.
> > 
> > Thank you.
> > 
> 
