Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013086.outbound.protection.outlook.com [52.103.7.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C393749FD;
	Wed, 24 Jun 2026 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320690; cv=fail; b=VMPRZ3MYuYSlz1Q4f0HGd4e00GKvXrgBJNkgjbNA9kZtGxURCVq36TJP07lIYSYpti4vPyG9IpMrZOvcGDPzFzZCkMmjTjCB5SPbiSAkuuEGl4421bQ0JMbJ+OpeFTUo97utM0fpygUxr4i6iEQuJcv5VXnwAS9D0c+F6S5SoeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320690; c=relaxed/simple;
	bh=706rbTe2boTHuUyrjud0lRvEHpT2eX6lvSoAowSF+iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fkrhtqPUBKoTSwEAa3LbxE9xmUjDucIX83BhpkyMP6rO/ABO4jBaxBcv63TgaVmoigKs5haiNvdKS8VSOR2jgsKSt6iXRdvxgjOBwoD8FVu+rQQXQgabgeVBGL/nTMgPASHhhq1cgbrSnBeJ1gbg64VjZLxPOrsdevKVMAJKnc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YPmuEPc+; arc=fail smtp.client-ip=52.103.7.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YPmuEPc+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK2DtlOrG5Gt+5MbM0e7BM6DoGhNsx3FqvbTpIo8/Bv2UaPKvZbUU5t8JgQgHZFeN0tXLF1aAPUcLTzCx6iKvt1P4qs3fx0X/C5c3miahTDzleVOPXELzDsW3sqT6J0PWPtH1IuQobTZnzSMsM6vFD14yOrt+DRG4tlGgi7En9/k+8gaPB3eoUyKq+puOZQ3e6P7CRltCAxXOegNuyVLWn9XjnoouNuMoR24SL+3Yf948mz0402YawK9CDSsbavFFD5lri+DBr0tjW14KNzV5ufkr0PsGuvfPUGQUaAxAmEZLb1oBJAtjVQNt5CPMRoQfna2sX34STmh/g/cXkxQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o54LWEU1JNGSXI3zkXKw21dKee714CTxp+RmwEAb0tU=;
 b=r1ao9smio48+25z32ZsAKKL2iCTRRp4HrXRaMaj2VReEfMHNUrjgL9xCbt5a4rmnJGBy4/e5c17//cQMmqijDAoSizK3YbOyxf7paLchw+YXsuJR958AalsR//5yBkUEJdiy2lmfrfBH/AFURNGAulCC2dgZUu64z8tk/OJvzaJly/9MAwLitEde32z77LpP35qivlEDR3BUgiGY6CjFafwLcYCV/mWrLf79ipEr0xz18Up1MC9snmcs4AWT5D76cu8xlaOqXt/32Hvs3IECrOMrfiPa5+kdxT7CT6GxyTxENp60wY8M915M/AdEC25KqYJS+5fUkpiwYjz/niCgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o54LWEU1JNGSXI3zkXKw21dKee714CTxp+RmwEAb0tU=;
 b=YPmuEPc+aNSK5FjRBAw2fLXtzm/f6V7QtOpHxukeeSfSWU5dqThpiPQZcQ8a0XOjspjDNV+kZkZT8bZgAUWW8d6HGnXIq0tcSZixHIlsSOWNAdQ7Lvp4rhimRc+oUSW8hghFSPjwNka75ZumMtglR2ku2o9OnOIlevqVHsI3akLXidnAvhxX+ClZvcuyLysTwucyr4F/8f1hUwsLRJi8/6pMspIESRSJh+M3c0NiI1PCNfdb/xgOwiK344rdpWLeA4UdYBXCBvekTkSXRZZBrqF7J/8F3tePtrHb9cVUMAiXBsA7/Hqzpmu8YqPcSWcE2jZf862jDE7SfF4fC4xFSw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DM4PR19MB6124.namprd19.prod.outlook.com
 (2603:10b6:8:6f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 17:04:45 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 17:04:45 +0000
Date: Wed, 24 Jun 2026 12:04:42 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V13 5/9] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID:
 <PH0PR19MB997338DDE007246CDD6B1BA801A5ED2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-6-macroalpha82@gmail.com>
 <20260621181948.21d40a09@jic23-huawei>
 <ajnwk_zWevY14mEO@wintermute.localhost.fail>
 <PH0PR19MB99733833C502FDB1FA4927B8DEA5EE2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260624160651.03645da7@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624160651.03645da7@jic23-huawei>
X-ClientProxiedBy: SA0PR11CA0125.namprd11.prod.outlook.com
 (2603:10b6:806:131::10) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajwOKkZyKCsks2qu@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DM4PR19MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: c19ba15e-303d-4acd-af6c-08ded212b0e2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|4140399003|15080799012|5072599009|24021099003|12121999013|6090799003|8060799015|51005399006|23021999003|41001999006|19110799012|25031999004|37011999003|4302099013|440099028|3412199025|10035399007|40105399003|1141799003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5TSon497Ov8L+vqMrmTmLwYa+MY1pt7Ue8HyxT089CsdsMlkfTtAnCTkKj/X?=
 =?us-ascii?Q?MoCB9ParYvC6AkBYyqnhjJhFAA9ngi+xM9tkLCuI6lYAj5xLjhjpwESjD/eV?=
 =?us-ascii?Q?6m8DbuBPfe3M6k6S7wd4cpInpZ0LiCrJ7+UUaapfpKUH23CdyvA5LF2uvjJW?=
 =?us-ascii?Q?vaT8HSCZULkDObj2VZGY4C35ue08ED+sJsxLmDx5lGKTzUvKO64RBKXv/nYb?=
 =?us-ascii?Q?62w/og4Ei/FBVxEvHxzCy39mbDLqusEEeXwb11NoN5f5zr15BEQBTAW8HqXC?=
 =?us-ascii?Q?jIk1HgOWfTKbblLeWQz4ZWAAHY6RVQLFisblbNFqfha2zubJpu30kJbOf7G+?=
 =?us-ascii?Q?8pmDMZeAhT4Yjg9QNcfhsbgvL3l47E8zNizWfVk+yiMtcVd/Q+zMbOZ+m5rs?=
 =?us-ascii?Q?Hxla4331Aa9YJIZD4PTi7W8SGgj9KO183ueFrCicUfDnwzHk4uqehuLCpjYb?=
 =?us-ascii?Q?PKk5UWEwEdre6FMTrdDAkEM9FcqfQVolhl7+cexjBOHIkw+CWKT+3qEZSkcR?=
 =?us-ascii?Q?WgNF98glukvCGJLNenQgSZBvTJQnJj/XyG4trfoRlT2zU5xZmeTdokjh1/vX?=
 =?us-ascii?Q?eubzowqSkM9JHJBOrgBX230JjsdFQDtZ+nCJ+lWS2Yju1tMRHehcecAvcp3S?=
 =?us-ascii?Q?W0dQH0GIaYmaie6c2yJysrhJAlDJogHqaP4eKeXjNGOpu87sPiLs3Xxf0fT7?=
 =?us-ascii?Q?GwiO7LUelFcFp2lMwLUpSCxh1tzexg4AHDpqeAQ+ptP2q/1XgVYqI63DajJS?=
 =?us-ascii?Q?tqqPDbul0mY3bbPITzZWa+rMG4IvbZgLzw2ea1xeQ7WmOTPylOXY/KzRWDrd?=
 =?us-ascii?Q?RqYISTYOXppnip8Tu/x6xnhr5Ak66XBolJNwQ/peQfDSikb5pOVWC+nOCD/l?=
 =?us-ascii?Q?ueZvDZDCErSiUVqOV9ugdj9Z/5eJXHfZmMAtYRTbZbbz2D9vHluenWGavmYS?=
 =?us-ascii?Q?hwD+o+/1YjolGX9r1rvGDYG3gSUS9Vgg24H1fg3vh+sIy5nR+2s63DAWas8V?=
 =?us-ascii?Q?BJr5jXXLWvGrGMOPGg5tYNiyHYRd+nEB6Y9A2sotXmkcgpZ6qUBUvr19s7VZ?=
 =?us-ascii?Q?wr0gubdL7xHiuGd7Mz+XCH6VlxlDmyFOjZ5S19UCf9VZyxEM2tj0KT1l1ov0?=
 =?us-ascii?Q?x96fCQO9JneDkKxayOFBWqVinv3ZDr1MSg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MosMvW3JlJJK6hEavu+I1TT6fs/RFkqkFfdfLfEfA3RG/E/7jlq+Ji5ysELf?=
 =?us-ascii?Q?0upgSTt6efH7zqzVgJF/bVhZSSgIdOcqKRtwVZjeXDC7hfmtmzZpnWzpoIoH?=
 =?us-ascii?Q?OuKmpUsQt77i0raYhCTviSniIFVuL4yyvrdrm9S9Ln5bjHCvhbgrQjvhuAmy?=
 =?us-ascii?Q?sOXIFooeh7x2WgkBlhqv2YnWQkqdwDtnfrPwOO2mYt+dLd7rrWLuxzqFByJt?=
 =?us-ascii?Q?ipLEmAG6wiITjw6CrYNGCPU/wEexzbpZbFh39hC+4fyMMZqSbQwAtmUPsJAU?=
 =?us-ascii?Q?xYkECV37j6hYi8/Bq8M567CY9CFnoaqndfqp+2GZ8IJUVXI+7xbPf76AbUdM?=
 =?us-ascii?Q?4bn2Q7XtRDI+ALleTi8i4YacXZ3mvnkt8KgNNZBcHPr8bYimMAE6SqX9wpI2?=
 =?us-ascii?Q?JtAQYkJ0Gpx3MwIjhsBqdUqRKo6N9pSVASjaw0MkSDBcuUf+boan/AC35rYx?=
 =?us-ascii?Q?oM5gUfL00TN7Pa1+MAx1RtGs0ba5Fs86m1z+BJlEIqRQkAogYOKx6HZEeeSI?=
 =?us-ascii?Q?Wa98VmlhNs/x22B5UKRip+xgkV4rBjM10mOT1HwsscRMWIEaVByzM5G5VLi4?=
 =?us-ascii?Q?paa+N9E50+gDyH3DdF33cQXdkdT9SSz4JjVGy4tAuP6aiNUIID/6g+FRwabJ?=
 =?us-ascii?Q?XNJpNFfZ8Y769G0DbQkyVJCrcSIBfKmFS07PAwPuWCiL1tqLQkqGJLdn5855?=
 =?us-ascii?Q?QY5nJl+hdvy1w1Ga2et1vOnd7i2HxUcxrqCqC97KAeC1m2w9x4sM07cNimny?=
 =?us-ascii?Q?CxSgHENZoyd5mRyRlsnjfvoF6aJNEt3NxfAa2ek7pjbXPIoS+/LG1bUsygDn?=
 =?us-ascii?Q?Nup37IKCG5h0zD+5/CPfppbUFg8w84tzvFEjgyYTGbvU6XovIsCvtuqTojcZ?=
 =?us-ascii?Q?enI/I7LIFc30hfvQhwE+3C6Z/6TSK+WaRpP/PQ2MsiW64M9w6uXtPNc+7iOV?=
 =?us-ascii?Q?gvCodEnGNIDZR/vXKL0YqBA6dXBYS+YBtRl1z/W8J8qqMEpwZ++l2bzytZ4V?=
 =?us-ascii?Q?6kwX4V9XyMYRaf+nbAMimazwrDTU1AlfIQD4by2ssWA+xGY0xtibPNuQCjoG?=
 =?us-ascii?Q?Ig5NWzyqj7PQlJLOeaMXo91efbJE4naii8J9lJwCL/oXolkKqly+g1zfU8Rp?=
 =?us-ascii?Q?pwgyhufDVfOhQTvBaim8mijLMYYt1rePerp5lKt8/3TvylA2cG7Uxty1i433?=
 =?us-ascii?Q?rJPu4Vu6Q2B6xoZtGngGh03zGL7P2sA/xBH9IXWCB42NMd3Tv1+lSjWP0hzy?=
 =?us-ascii?Q?qGWYBag34EAfU7cUtPH/pku9WuXsW1C5pui5uD7EKqTuUMtrxsxqqj8w5CIr?=
 =?us-ascii?Q?lc/Yja5TaMw/6pdmj8MbpAnsbhF007U/BCq35ze2BCeIEHBSqA1aKj178E0A?=
 =?us-ascii?Q?s/1bVFZT7jjDVi56sAU7kQp5K4KE/+ykmkoW+dPuw3qbSBX28g=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c19ba15e-303d-4acd-af6c-08ded212b0e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:04:45.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6124

On Wed, Jun 24, 2026 at 04:06:51PM +0100, Jonathan Cameron wrote:
> On Tue, 23 Jun 2026 13:08:02 -0500
> Chris Morgan <macromorgan@hotmail.com> wrote:
> 
> > On Mon, Jun 22, 2026 at 09:34:10PM -0500, Chris Morgan wrote:
> > > On Sun, Jun 21, 2026 at 06:19:48PM +0100, Jonathan Cameron wrote:  
> > > > On Mon, 15 Jun 2026 12:25:48 -0500
> > > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > > >   
> > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > > 
> > > > > Add power management support for the ICM42607 device driver.
> > > > > 
> > > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> > > > A few things from taking a look at the sashiko report:
> > > > https://sashiko.dev/#/patchset/20260615172554.160910-1-macroalpha82%40gmail.com
> > > >   
> > > > > ---
> > > > >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  18 +++
> > > > >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 139 ++++++++++++++++++
> > > > >  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
> > > > >  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
> > > > >  4 files changed, 159 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > > > index a6a58571935f..4f4f541027dc 100644
> > > > > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h  
> > > >   
> > > > > @@ -334,11 +345,18 @@ struct inv_icm42607_state {
> > > > >  #define INV_ICM42607_GYRO_STOP_TIME_MS			45
> > > > >  #define INV_ICM42607_TEMP_STARTUP_TIME_MS		77
> > > > >  
> > > > > +/*
> > > > > + * Suspend delay assumed from other icm42600 series device, not
> > > > > + * documented in datasheet.
> > > > > + */
> > > > > +#define INV_ICM42607_SUSPEND_DELAY_MS			(2 * USEC_PER_MSEC)  
> > > > 
> > > > Sashiko had a valid comment on this.  MSEC_PER_SEC seems more
> > > > appropriate given this is 2 seconds in milli seconds.
> > > >   
> > > > > +
> > > > >  typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
> > > > >  
> > > > >  extern const struct regmap_config inv_icm42607_regmap_config;
> > > > >  extern const struct inv_icm42607_hw inv_icm42607_hw_data;
> > > > >  extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
> > > > > +extern const struct dev_pm_ops inv_icm42607_pm_ops;
> > > > >  
> > > > >  int inv_icm42607_core_probe(struct regmap *regmap,
> > > > >  			    const struct inv_icm42607_hw *hw,
> > > > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > > index 4b8e19091786..64f5d263de4f 100644
> > > > > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > > @@ -4,6 +4,7 @@
> > > > >   */
> > > > >  
> > > > >  #include <linux/bitfield.h>
> > > > > +#include <linux/cleanup.h>
> > > > >  #include <linux/delay.h>
> > > > >  #include <linux/dev_printk.h>
> > > > >  #include <linux/device/devres.h>
> > > > > @@ -11,6 +12,7 @@
> > > > >  #include <linux/iio/iio.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/mutex.h>
> > > > > +#include <linux/pm_runtime.h>
> > > > >  #include <linux/regmap.h>
> > > > >  #include <linux/regulator/consumer.h>
> > > > >  #include <linux/time.h>
> > > > > @@ -103,6 +105,63 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
> > > > >  };
> > > > >  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
> > > > >  
> > > > > +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> > > > > +				      enum inv_icm42607_sensor_mode gyro,
> > > > > +				      enum inv_icm42607_sensor_mode accel,
> > > > > +				      bool temp, unsigned int *sleep_ms)
> > > > > +{
> > > > > +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> > > > > +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> > > > > +	bool oldtemp = st->conf.temp_en;
> > > > > +	unsigned int sleepval_ms;
> > > > > +	unsigned int val;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> > > > > +		return 0;
> > > > > +
> > > > > +	/*
> > > > > +	 * Datasheet on page 14.26 says we need to ensure the gyro sensor is on
> > > > > +	 * for a minimum of 45ms. So if we transition from an on state to an
> > > > > +	 * off state wait 45ms to ensure a sufficient pause before power off.  
> > > > 
> > > > Sashiko commented on this..  I think what we could do with adding to the
> > > > comment is what the path is that didn't pass through this function which would
> > > > ensure we have been on for 30 of this msecs already.  
> > > 
> > > I'm going to track whatever time the gyro started, and then if less
> > > than 45ms has elapsed just pause the remaining amount of time.
> > >   
> > > >   
> > > > > +	 */
> > > > > +	if (!gyro && oldgyro)
> > > > > +		fsleep(INV_ICM42607_GYRO_STOP_TIME_MS * USEC_PER_MSEC);
> > > > > +
> > > > > +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> > > > > +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> > > > > +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	st->conf.gyro.mode = gyro;
> > > > > +	st->conf.accel.mode = accel;
> > > > > +	st->conf.temp_en = temp;
> > > > > +
> > > > > +	/*
> > > > > +	 * If a state change occurs from off to on, sleep for the startup
> > > > > +	 * time of the sensor, unless a sleep_ms is specified. Since more
> > > > > +	 * than one sensor can be transitioned from off to on, select the
> > > > > +	 * maximum time from each of the sensors changing from off to on.
> > > > > +	 */
> > > > > +	sleepval_ms = 0;
> > > > > +	if (temp && !oldtemp)
> > > > > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_TEMP_STARTUP_TIME_MS);
> > > > > +
> > > > > +	if (accel && !oldaccel)
> > > > > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
> > > > > +
> > > > > +	if (gyro && !oldgyro)
> > > > > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_GYRO_STARTUP_TIME_MS);
> > > > > +
> > > > > +	if (sleep_ms)
> > > > > +		*sleep_ms = sleepval_ms;
> > > > > +	else if (sleepval_ms)
> > > > > +		fsleep(sleepval_ms * USEC_PER_MSEC);
> > > > > +
> > > > > +	return 0;
> > > > > +}  
> > > >   
> > > > >  
> > > > >  int inv_icm42607_core_probe(struct regmap *regmap,
> > > > > @@ -236,6 +305,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
> > > > >  	if (!st)
> > > > >  		return -ENOMEM;
> > > > >  
> > > > > +	dev_set_drvdata(dev, st);
> > > > > +
> > > > >  	ret = devm_mutex_init(dev, &st->lock);
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > > @@ -271,10 +342,78 @@ int inv_icm42607_core_probe(struct regmap *regmap,
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > >  
> > > > > +	ret = devm_pm_runtime_set_active_enabled(dev);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
> > > > > +	pm_runtime_use_autosuspend(dev);  
> > > > Sashiko does put out some stuff here.  Please take a look and work out or
> > > > test if it is right (I think not but haven't checked that carefully!)
> > > > From a quick look I think that the auto disabling of autosuspend does a
> > > > rpm_idle() that should result in it suspending...
> > > >   
> > > 
> > > I see a few other drivers adding one more call to
> > > devm_pm_runtime_enable() so I'm going to see how that works out.  
> > 
> > Obviously that didn't work, but digging in much deeper into the PM code
> > I see that devm_pm_runtime_set_active_enabled() returns
> > devm_pm_runtime_enable(), which sets devm_add_action_or_reset() on
> > pm_runtime_disable_action(), which calls
> > pm_runtime_dont_use_autosuspend() and pm_runtime_disable(). Shouldn't
> > this work, or am I missing something? Basically when the driver
> > detaches shouldn't this chain end up calling
> > pm_runtime_dont_use_autosuspend()?
> Agreed. That was how I read things.  The only thing I didn't entirely
> confirm (states involved were fiddly enough I'd want to check it
> with the actual driver!) was that pm_runtime_dont_use_autosuspend()
> ends up calling rpm_idle() in this case.
> 
> Jonathan

I dropped in a dev_warn on the rpm_idle() and can confirm when I
unbound the driver it called rpm_idle(). So... yes?

Chris

> 
> > 
> > Thank you,
> > Chris
> > 
> > >   
> > > >   
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > >  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");  
> > > 
> > > Thank you,
> > > Chris  
> 
