Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023133.outbound.protection.outlook.com [52.101.127.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4519CD0A;
	Tue,  3 Mar 2026 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502345; cv=fail; b=ps00oW2r00Ehj49hkplahEuIe3AVL5+KiGU9ZLL1enC2AP5OMPkP94E0qOwuvOaFjoej8h2uCelmI5/mNy70Dxgb8HueKzW+alxKPKKXruGOoLfRGGC3G6OwAu7silUsbnYUnRuIS1zY7mLAqCcjnpjhAXVh+w/YPt5617EKvok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502345; c=relaxed/simple;
	bh=jNk7fi0mgYBQDSx+c79D1U6EQeaowJRxRCgQiHC/gm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r3OKuSSRLt4t5X4Q9oxTYomdb1MlECHXDmSvcMW9mAGNHnKWRXn8J+pVBpkpHvjgYP6STzi4/yvcDw9oetejIYiBe8q3B/D+9/OKVqNQJB41K8FEEdB+qVN5NseCfCMf6yf7mGYsgJ5KI7S6qey+oiAuqoYkiAbtk3cwc60gIew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=eTVneOTS; arc=fail smtp.client-ip=52.101.127.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="eTVneOTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLtWF+zUO6LdDrAHbhq/nUh61OlVJSbSMANvnTSxdqgKXPXseat1Qys6l2tEsYZjIAoZhOkS3XFAhAwHSm173Iazbi1l7LtoU8GAALVhLBbnjaG10LaH4PRUIrNjycWKG6voKrhTZQ7/6xL6uPBnVn/EuI8gqo4/qymyzEAe/IraZk6kuzz+jdNyqRpHiGZnmVyBjElUgaX4eQkriM7T7gauBSa6qjIT3E/XJG3evF75xnLlMr1jLkMXGVpa7MDU9BoQUZFJf+ik4UePy+EJMMBUA3wwiLU+XG5Z7Iq8bzG1BVb+ZDVjz/YLjguuXSBGsYg/LWJYSUgcwuROhG5OyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNk7fi0mgYBQDSx+c79D1U6EQeaowJRxRCgQiHC/gm4=;
 b=TCFib9UFK1icCGE5e3cx/8BBGPDwQ0/LcwwfYqaRe6aRpPsKCBSemhOUQqa8vPCxg5es6ZFgq/PTkUUTslVWpKx50ojRq1gnUg8B+V0Ic/XPiSFhe/QEsad5qakETAZSe5LcNsQw1RKn5oh5qbwxMByMYHCBIEPuuCgBMM5Ot2ZJes+sjUUVojcBqANnnnzb1WSwDgzHeD2D8UfAHWEYC0a7DSx8Y4vQigt+QVkFoFQdSf2UCsdRFAUfbF4O/E0IeLLrHXq23WsiXXfJrbPRj/wHcveMDoJuPcyv2am1DVCzDTImd3+CBPdkcWAqCA4Vp2oZdknZCCGScn53ESXINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNk7fi0mgYBQDSx+c79D1U6EQeaowJRxRCgQiHC/gm4=;
 b=eTVneOTSDSpvs5qcCP6c2GJ8g0SiARUcUTiuEsbrh8N2yUdP9klCc4CfpHqyOqH0GA9ltIXtuLH3FmyPpPdn/ctluAsI4FrQPdK2futZSfK7t+NOlUYhosomfRuVbDF1gEuGx7YlKgQjSzhvEKMR4o++qrLI6bICDdJUc5TogyuG4aXGjEnT/384JzHD1JznvYb6ou3zpoEAwXTJbJ3GSB2qsi6O627xSOTh/7bSZDj+oZiM8FRuk4WSARYyMCwnVXoFQ+FEGFFivOdhWkIo0VOUnyIm45AiMYMSjggM4QipwfHcsE5C7OhIIUZUZvkVswDhlWTA7E1UXECx1oeyiw==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by SEYPR06MB8309.apcprd06.prod.outlook.com (2603:1096:101:301::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 01:45:39 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 01:45:39 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: aspeed: clear reference voltage bits before
 configuring vref
Thread-Topic: [PATCH v2] iio: adc: aspeed: clear reference voltage bits before
 configuring vref
Thread-Index: AQHcR812KX71xFLq1kSS7eVjWylLt7TXV8mAgMMayACAAlvdTA==
Date: Tue, 3 Mar 2026 01:45:39 +0000
Message-ID:
 <OSQPR06MB725214B7E1614AEBE7C9F2D78B7FA@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
	<aQCXm_rvwpB6-UUq@smile.fi.intel.com> <20260301134120.38ae5ae0@jic23-huawei>
In-Reply-To: <20260301134120.38ae5ae0@jic23-huawei>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|SEYPR06MB8309:EE_
x-ms-office365-filtering-correlation-id: ca058018-9540-46c3-0f97-08de78c692c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 CgegC0T9oyU6Q2lZQtcNZiv2JAhRrPpipE9WWRHUtwMsEmYUXBLWoGHWDRbgUO9OH5PiRmkVdgyc9NB3GGVcdfDKSjQYavZCPNRTGwWLFM0+nP0GagkI9KGApMVl1nW8bWWk6wlRZFxf/Zg8aYw3zXrLhc9ZWXAav+jR8wpmW+n0wUiLU98YhCViL3h65FTG3/ro7pwsGsvJAofokMCnm2ehF4sK1aeDwRr689sXXCXf/DCA7M1SE7VBJmGhGYiFVTJOxzEebim7RSRZrZhCIRmKlop3bJSmBHwfXuejV4Lny8aWSNUSouUkg30CUtN0Cg//LqRO1cExvAhIQC3Vs4ST4hDRkqPiDp0qHS5WxUfNYR9/UHfYWyx9+u2XaQaIolc9qsn/Ysi/KuxsCLW2jrXRUVPoNFTwJNiVTqvLTr6O2hVFwzPILBoup2S4depZzkYPZObm34+S9FoxOsXdMm9h2NP02Oidob5GDyYg4lFvmAylhlhSpl24O6cAH4YuFEUX7E4gVuNtuYKypgiBL5Qxpa2NwpdCK1lhCBFPf9cg5dXTca7QY13LYVXMwVLrJTv4vU2xfq63ClHtPJQIyoaH6unGtAPqIxOweDBkcXwTpRi6ZVfU4mxzo/BpjIrBSPDEu+ZfEvyJDnSyiyZWoZt46txmYC1Er9DpOd6/TF/Af+2ZLG4FRyd8MCN8htptddCAE/OSFF/o+QeFfZMeVyaSsmbTK377FJ5Exl+q9JB1MkjmnQNdrxEpFFwA8u6OV2achgQpBJ7+hKg5v8THmup+r8skWuonfXQCMsmpcoM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rfGQhwWEqh1+HpCf56IP9jB5B4WX8qXcoqpAsJ6HTHdHE55vvFybU5wX6+?=
 =?iso-8859-1?Q?YuhSdno18igO9k5HXI3t4Uw+ixkhxq1Ua0q2bFsGVLWsIv+9cAYcOzBUaG?=
 =?iso-8859-1?Q?xXsoMdRCkKrTFG9prhaPlIp28uZ3X/Zld6j4TTdO8xm9bbu0CHLL4dvgPW?=
 =?iso-8859-1?Q?iXrakMK6vkHS4VocgFJ7UMwK93UMjtkwU8zgjyCZrPFUtv4YJdJf7+DlEK?=
 =?iso-8859-1?Q?Au0jJXT175gHtYWzO2l4J55TlQsqNvmWgUp/HATPHFgus7yoMQBOTi26QL?=
 =?iso-8859-1?Q?d8H9S8IZMcJzJ4lCXJD1FP0zkSqld6n2Qn7ghejYLqqCi61g7Eh4toa8ca?=
 =?iso-8859-1?Q?MNIaOJ7bSTWWcMzB13JOA9SqsGk/dTiHDEo1PYpWByz1sBMhxs/+c2xUCZ?=
 =?iso-8859-1?Q?+YwtKCtR1NbwuV/4FehwkM5mBLCNdvtoor+4SKqNEhGgIxwM7D0pHQ0Afw?=
 =?iso-8859-1?Q?ousRhvsWnjl/7BoxpfHl9rDLchoh6XLwe2Z8H6iKL6AUHlU5O0XwG3yedj?=
 =?iso-8859-1?Q?/i/p+Xevo+UT5E9XTPLFUD73MX86D24BZgSOzwWqpQ3qIDH7VaZWHZ4Z+F?=
 =?iso-8859-1?Q?fC+46gB/SNrOZpsNsGebA37gHjRqa4CEEcafmwR1MxHc2CpFQ4+VzVt+Bc?=
 =?iso-8859-1?Q?OGfYkYKlCltHvRft7Y4rAM8xzAi9vsB0FtjkFUU6IRJq+i7K8xlHb8eDu3?=
 =?iso-8859-1?Q?wtEvYJ6YUr0EqVbSZNUeZqACJVCIHlHs9MdibaZbvKQuJWfwTNQ4M2HGHT?=
 =?iso-8859-1?Q?pT8/yAj3QwKNnGr+INXxkuWKylX/Za8birpHk84Vv8v8HFXxop7p7RFeIh?=
 =?iso-8859-1?Q?SnfXuhN7midZMdGs/uZcuBWNWA81087LiLNOKvUc5+VYp7ue0qR8MqOi2u?=
 =?iso-8859-1?Q?bQIxfCcmiYZN3UosHHlH47xL2rDhqcwDbswMwFxvok3RVj4XOtHuXptkWb?=
 =?iso-8859-1?Q?JpczroCLupjImjQTXsiXYzlHl6rqWYADey03QfQmB9qv0fk/sXsvZ2IdXQ?=
 =?iso-8859-1?Q?rfZOgss8ijsejkhj4yn1AxB5RKRCw90v1I1qf0zWo5DTPZIJ6BBuNEpaKG?=
 =?iso-8859-1?Q?+ueEpZETd7zWq0ME8RpPuzdwskSs++/YH0vHg2J4nmUAM/tFlovaNfKmF1?=
 =?iso-8859-1?Q?wjiohVJHzZls3rvoXUn9TBLSbJgWpES9Vjg+ctvWoNc46wJLCghp/jgUkf?=
 =?iso-8859-1?Q?PzsQ3gZA2dCp3atMw4NRqQksAG1qyOUequ/Hm4YZmVvPn/GttTfkmY6kV/?=
 =?iso-8859-1?Q?gSrQhjx8Q6nUxs4dU0WTlihZzi3GDSuOWDNOyQuAwyzJEc9IUHXqOtx9+y?=
 =?iso-8859-1?Q?MB4X91o4iQpggPsK0pGYh1DBpO17F8InkVozQef29J0r2nMu8M7Q6O8V/L?=
 =?iso-8859-1?Q?ly4lMLOmE7lYD5eajhw8pAwFiutYAbp3QPeLk3vl1c2GxIPpcoAzlRVUJ0?=
 =?iso-8859-1?Q?0Z0N5vx0+IFNcp4hcpG5M0S1L5S0Z7voiFommmqirGH8wnyc6xIhSW2tQZ?=
 =?iso-8859-1?Q?du8Qhah7/41PIP+z5dkeJRd8OJMlfUF0DvIOpGI8a9WItrGpHydEqFvky7?=
 =?iso-8859-1?Q?jXKXm3yuWFaAO8TRFapvQ0PJ0HTGLs57RjIPUECoD3sIwBGhHtBUPebjxA?=
 =?iso-8859-1?Q?1TN250P2+UhniKs0Roi7YoA8dd+qemm/kwSrUe1ToR6uoke2vsHotJWR0i?=
 =?iso-8859-1?Q?+gcXmM6pKkrVtao+O/x4l2Rxlx3vw9WaEYt136ojAnCpC35cQ2+1nNZjux?=
 =?iso-8859-1?Q?3PT2ZoNd7S/KHRYJ3eg6EtcBCb9raSwxcDeurg1EMvymqC6iNAKNX7HDzw?=
 =?iso-8859-1?Q?Y40MPdPGyA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca058018-9540-46c3-0f97-08de78c692c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 01:45:39.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5EuBv02fTwol+2l8SEujMAPR+Zjr+rlvU8cXKv9SDJe9Aaj6Z2mGCbuAkEZx6q+4K8+FvDtpCgJVRku6vK1yiVTEv0g5kYZJZ3gh/SHuEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8309

Hi Jonathan and Andy,=0A=
=0A=
Sorry, I missed this email thread. I will send v3 with the appropriate Fixe=
s tags.=0A=
=0A=
Thanks=0A=
=0A=
________________________________________=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, March 1, 2026 9:41 PM=0A=
To: Andy Shevchenko=0A=
Cc: Billy Tsai; dlechner@baylibre.com; nuno.sa@analog.com; andy@kernel.org;=
 joel@jms.id.au; andrew@codeconstruct.com.au; linux-iio@vger.kernel.org; li=
nux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org; linux-ke=
rnel@vger.kernel.org=0A=
Subject: Re: [PATCH v2] iio: adc: aspeed: clear reference voltage bits befo=
re configuring vref=0A=
=0A=
On Tue, 28 Oct 2025 12:14:51 +0200=0A=
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:=0A=
=0A=
> On Tue, Oct 28, 2025 at 01:41:02PM +0800, Billy Tsai wrote:=0A=
> > Ensures the reference voltage bits are cleared in the ADC engine=0A=
> > control register before configuring the voltage reference. This=0A=
> > avoids potential misconfigurations caused by residual bits.=0A=
> >=0A=
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > ---=0A=
>=0A=
> It's a v2 and here a changelog is missing.=0A=
> No need to resend, just reply with a missing piece.=0A=
>=0A=
=0A=
Billy. This one is still outstanding.=0A=
=0A=
I was rather expecting a fixes tag as well.=0A=
I'm going to mark it as changes requested in patchwork and stop=0A=
tracking it. Hence please send a v3 addressing Andy's comment=0A=
and either add a fixes tag or say why one isn't appropriate.=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
