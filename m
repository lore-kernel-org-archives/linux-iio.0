Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010004.outbound.protection.outlook.com [52.103.20.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8B356767;
	Fri, 22 May 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467046; cv=fail; b=Vj9CtM2H0wbZ2h/rok9sU32WR67G6f1aBU7Jcv8R4ut6wX+i+PXW5WrzWA8Sbqtwr8EJthLFB7u7/zRbV88ShyRzK9nJcrueRLK0pFNBdlDxLlNEcNhiRzTFExnuSOmi2EaUYGi7M0Dm1mRBHDKTxF8TCoWJFuhwC7uJKq8yXmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467046; c=relaxed/simple;
	bh=vZB7ux9x1yrYIh6/P2M+uP7B8qGfKi8NVe9UT4J1XHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B0dPttBToLWlRgOC6uaD3xBFmumbidRFxeqYfloQWqSab9L7VHsAJ5NMF5XxIMosJSwx2Q/3Kes+U/4Rh1mjXAcvxLDl/yiLCF4ZWLY7hq5r/pyYrUSFrvzRmP/gnSCXU+t1qr4Y4nQvD9yvS6TUZX26Xc+LF2Gchuit1zfdhE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=G167tvwe; arc=fail smtp.client-ip=52.103.20.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="G167tvwe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMlSWB4Yr2uVGPxmcvTH4cuCvgtN/knIvE1xcoOrKvBI0bkBKLtdNQCikwK28I9g7B53y/w6Nj8btdM6h2JpuyD7tjo1gzVpD0qgADOQCZNk5lTGXL1A3LMu0jlGsmYtSzAzYEA0SMn+0xV1f6S0p+c+Uiqm++0b8NYZ1rP4KCVHQ4oPOM5ONAyWWHeuwkg7SLR2ed6mMMH4xjsc9002ecM/BOeUpT17uSkE2GO14WxGZ0QOw3s5FU8iTKy3PX8wRopWKRMNZDE7C//HGdwz6o73ztsHBGpFqKb532fOsrv0AoPcPkw9LgezTIq9NNEqBCFQWZfFRv2vS8KhfeYytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5fLxz1VSSGLMZYndel7pzh6AOVHOju0vi7lHJYWfuo=;
 b=Ofh8xP7BDOEMTE330CkOBftgcoyxZujaFw7RgU+i6LEai7sqvITtbHQv2G7lWSkg83eilRXro0bQfYr90RKUGl5wmUoXRM8vmioetqJ3hNWhnX7WUinPTWqd/kYGAi5+owQd1xS+j1/Ppx3FLBk3qw8yw+l+Le1vOSHrdbo4lEX4aYE7agv4fiToxIl5jYWfAd4aOKJn0AQYIATvyEP1vZUe0kxsN1xvGaajsNqDwM+1PV6uhj/m7lVEtJ9Vx1Ek+Dk6v2jS1h64LtCGr32JHS5Wke/IH8R67NEds0m+Al8ihWWZDA3wGivo2V5+oMdFZtyyqGebx+NuCvSBSV17vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5fLxz1VSSGLMZYndel7pzh6AOVHOju0vi7lHJYWfuo=;
 b=G167tvwe8sKCj8Ln7bHs5TNKmUKfZIxW+vC13g8yGxQzf+BsQOdyVfg+7b6oYEjoQqtNtHqHuJJOg8mJbSfvNJHl/xHRjW23ZqNSMPMiaDM0Tvuo9ly62LGFYSEICik+eoxLkEGp0GqTQNbeOLClNJD82dPk0n6GjlM/aL6zCBZlWAQ6oTLaSZfax0BLo66LdC+/YRL+/rCjAi8Oh2Ka4zum9pnt48WTuGqgAFbNmP77trkTU2oL0fuNLuA/T0debbb6M3/Ys+sFML5LqC/NfdwtNs4VPxw3uqgbGmwo3/GaRiVT4F1lLyXeQbxejB4TA8RhJ6cfSDTrivpcGVmVSg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DS7PR19MB7628.namprd19.prod.outlook.com
 (2603:10b6:8:ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 16:24:02 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 16:24:02 +0000
Date: Fri, 22 May 2026 11:23:59 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V8 05/10] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID:
 <PH0PR19MB99733838CE49A3752AAEA250ABA50F2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
 <20260518200526.458421-6-macroalpha82@gmail.com>
 <20260520181353.0a0371cb@jic23-huawei>
 <PH0PR19MB9973386EF146AD6590DE5508F5A50E2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260522120515.652661ed@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522120515.652661ed@jic23-huawei>
X-ClientProxiedBy: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ahCDHxLhE22Qah6c@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DS7PR19MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2a4b9a-611c-49dc-3168-08deb81e8925
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQk9yDZfcyB2aQXfgqZWb+OOmJP02r5goILS2Npf15Dv9706SF/yW0BOulCo688KN+40p7frfmIPz7/KeYIXQNNwFlODkA7ffQzDEA8SaGuJX1TXaK9z+uhnnXMMkNKIO600E4gkAwUcdvFbkoprwTt4pEJ7+ZeqgEGH5IQkVlUsEShzHiE8butgYwFizH3Af2I92TNcFKByW/GfrIq+dlqQVchwbJG2dYH4oAIoHkAu4lUfR++JfHo+ax6//PbNr8HAYEY9c2yE8OXz9A5E7BDFVQn7ySDAauYwd1G2J+1Os2yNhNkjMvT1+L3AoPK0vM/hJrvxwbEtCWc46IpocbAY5lHEXtTa9pKuDXL9rm2NiVuDQiJaUpk4mU6wQd4qtilIPo6uMFPBkSpjk7VEQxoR1L9FqGi12/7Wr2aFF3F+LNKxyGQUYPLNkuUV/D5BKhMk/xhgZCDDOY8zhQNeximON0fNJ6vrjrkzIuIuedn7I1OlF78qpCiEgDIG1gtrjsxKgJ24JdHrbKt1Xk5InYdBhzMhxIRVKGy4M90B+ukmPZj0PdA347X07kmfX39duxfnuiQhVUVSMGNfqZAZYAW424FGLOXwwx+sp2CirsH4LcfcjPYPtnIbMyNcSjG9g0MO8nBrm0WvSptB8yZLqP/tI7yZjIL1mDrY5lh6XWikC+t9EVzlpe0EC2a3eiP/FTTs9cZO8ZVWPQT9hXH+G9LRd2oyf9wxzJo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|51005399006|37011999003|24021099003|41001999006|6090799003|5072599009|19110799012|8060799015|15080799012|23021999003|12121999013|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mrIFqJWMESSuP8rp9Uj1R3xvVZvzOygpGdw34II6960SaotPr+ukQqPxgcWI?=
 =?us-ascii?Q?S/YhXYAPyjJLlTk+3+4xwY6de07Nqt5Qfz1WFVfPTiMID14kZnwSyAkrzGFx?=
 =?us-ascii?Q?37PKKoz1NMu7UoDvFglurDb/D9gTRWftlVBCTcxg9FspKls0VwBcYZgqs4vP?=
 =?us-ascii?Q?5g9uggXvRA8JQn76UTkWl2x84s26OGPCJCupYN8qHRFR153bDOvTSmT5iKa2?=
 =?us-ascii?Q?vnJ0994GfNafNz/lqzn6VCGmz2lq4QKFk/pzKh9SdNiFeLOao9lbStVZGqfm?=
 =?us-ascii?Q?0jjAcfugkt129ZK+OYfJaRWifQ33MnE5NRFui0uRuWWlQY+sfsoYFiQo1CuX?=
 =?us-ascii?Q?KtHGDMXmIQ6rX0M7DJ4Qnz5uusXVONJ9bxtI4eCP7h2upz4MO8qfhOnln98Y?=
 =?us-ascii?Q?RqTxz3zfuP2uoH3bjg9CDyRbPQHiysTMBvL6OS6xE0cK+YrTDjMEI2k0IrJi?=
 =?us-ascii?Q?NUCeZEkliaoo9dCDHkrWAoVdEiN5ic2lSIc5oRq93e13EzJi8QNCDAlYKgqu?=
 =?us-ascii?Q?oWpKFrjyzsmDZh1w+rRHqjj68fKmlGsyrGbWBxiZPsv3pQ50XFnCxOfCwqOt?=
 =?us-ascii?Q?MgJvaPTXzWFDkK6bAcADLybOE9Gv9RFOjA93U8T7N1E/uNMz/JaDxMAwg49f?=
 =?us-ascii?Q?v2nZUunzGLazj6dicvOZK+5hk7wx/9smhAxR8Yv2EoBvm1bzHb/6jUHAww5j?=
 =?us-ascii?Q?/6fz5wuL35GwJ/pl5OinL6rclZk6goGLsmyjEVo4WnHem4GY7zxZD8NAtu2y?=
 =?us-ascii?Q?yYGH+/7W5Exumf0vS20zWAPcaZHd8iNg0fJkovSLapNECrI9QtQ5z02yNqG6?=
 =?us-ascii?Q?v0jRZC0GAWFiRj6k0mDdITuqoxHLXae9sTUErtJ+YqIZE7Q8eaDbh8YKLJgU?=
 =?us-ascii?Q?bvQWS/IiY62ALDbK6Q9Q9ttcFfimfF48v2IW0cMu7zHe8DSnwcXP+fcCH3Os?=
 =?us-ascii?Q?J0ZlmqqgAMUC5HZiUpsSZTpU90Ma4MM9xnG/ROD3wVO6zWws2xSPwFmuVeXr?=
 =?us-ascii?Q?qSaiUDc2ehEKr/7qsurqQnlR9AkpMtvOEqCT/x3eagcw+dJOIqIcgdZd8tc2?=
 =?us-ascii?Q?ilI097tXSpj3lw8WB4nlLKq/VuKf0g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgHK3oeHZmBsFlzbBJp+Iuav4UkCRnpiw7yBgc5XGbdCSU2iU2L2Mn/Sw5k7?=
 =?us-ascii?Q?xyUR/3pj4b/hfaHQklTFy2MhSUGE1AJasXCiyiswxMwaPI+XaJUYuqCKgeh0?=
 =?us-ascii?Q?ltR0raKFA6qL+O3dcrtHyP5IQ6EMyRVMR0BABZLCVqopr9xIk32kkA4LsSFk?=
 =?us-ascii?Q?vbBLnL/Z3BOPQ7mhwHgNNmwMjDQNXk9otvwjFkkIUPT0xNPA90zXLQS6JQTK?=
 =?us-ascii?Q?jW52i1cvOR9tBYYbl3gyEw3jLh1j/LdX0yJTnY646tcrvg4s4KDifdcA5adt?=
 =?us-ascii?Q?qpnc5yP8RC9Ib/tT728Ygtap1BKaDrWPDV7pWAgF7qDTJOi1Ea7XgbrqCFcC?=
 =?us-ascii?Q?YAtHPmq8Q1GIJYlw94P/9hmFMu5lCtC3sR8ScrXyBHjnNltN522Q5cmWzClD?=
 =?us-ascii?Q?M+WK7Qky2twFVwFQrY25BxmKdel/ogZNWqKchQ/hwfb1RljJDygrNIsHVbLb?=
 =?us-ascii?Q?YywtwjiAXaYaS+kvnKU5J7pabPXTrEnWcnvKGxNPbZ9WVZtcVcQYya8jzdjA?=
 =?us-ascii?Q?9gH5Mg9XaMsMkNlvj7pRbfpaeFln++EnBxLxJZMUUrUOSJX/JOpfUXLC/lMo?=
 =?us-ascii?Q?2bMQPH5Uap4+X/1/meyGXTxr8/SCnNeWS35E+820u9aYFBd5Yzl2e84xkaJk?=
 =?us-ascii?Q?OIaTetoTeH7K7HuwQEWBr6vqYFpW6K54Wym3zkntqEg8BNE5WcJhfM2e0KH2?=
 =?us-ascii?Q?2Ou/ATzGT6ZVx+m1Fwo4vjwS4Gh34tdsrIIrwocpT6AreQOKSDpvZjVVFYif?=
 =?us-ascii?Q?GwIZ6f3EoCjzsy3aIQZuuxTOHKMa/Nt34kn9VxRiyhz7y4525Vsut+VvRcg3?=
 =?us-ascii?Q?37eV6CAZVZ7+kYuVHLDzQP1tRKn0OPyZE5qLAmS3Ol7WAfAnl7JhBBiLPNIS?=
 =?us-ascii?Q?zElDtzC/bKhNUEUnn1l+UxEyZW28VP2eGVtsArjfp+xkNwPN28ha2KiPPTsD?=
 =?us-ascii?Q?HH7bsnPzGwkJTRjM90WZoNa8VrekoM+aZNcQs+VhrfIg4f11gdAos9NTi1fs?=
 =?us-ascii?Q?y5YdnBvVqVKSWco1p84I19LEVZYHkU5fUgvZ/HT/uIYaP2ZSBE+T+o+l1+ch?=
 =?us-ascii?Q?mUFSIE1JXVajqeGp7npNCcCu1x/jweH9DRuHlH49IzANNZOvKs+8rVmbo3yj?=
 =?us-ascii?Q?Um/ec/xscK0fd7o7YEeSx39nvxIWUSochLhuJ170lUxtLgt4UMJN7K+X/8rL?=
 =?us-ascii?Q?ecFMW/zzD8JySO/lSo7tBbR/h/dew4t1LQ4L9hIg7awew0X6xF+cUpK16EW9?=
 =?us-ascii?Q?fjkTxE88WY26VfTU70hDUoquCqxRiiflsy0NkcqC6IRKQqUX1dI9c7pDqK/2?=
 =?us-ascii?Q?HFghbeu8GtrZSB/87d9FImYBjSxomVDciaYjN6m8XltBSXxOGLUxz0U3hNFs?=
 =?us-ascii?Q?5C4y2qtgA+SjRcEv5FBPknQI3EDRGWuyLl++hY3kvnsXwndGFVSSP+WXBePD?=
 =?us-ascii?Q?KtToj09bWQQJK3DVSEhPaVM1UoWHqrnE?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2a4b9a-611c-49dc-3168-08deb81e8925
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:24:02.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB7628

On Fri, May 22, 2026 at 12:05:15PM +0100, Jonathan Cameron wrote:
> 
> > >   
> > > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > index e9c81b52f9ef..bc0cefa2fb77 100644
> > > > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > @@ -9,6 +9,7 @@
> > > >  #include <linux/irq.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/mutex.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/property.h>
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/regulator/consumer.h>
> > > > @@ -72,6 +73,62 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
> > > >  };
> > > >  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
> > > >  
> > > > +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> > > > +				      enum inv_icm42607_sensor_mode gyro,
> > > > +				      enum inv_icm42607_sensor_mode accel,
> > > > +				      bool temp, unsigned int *sleep_ms)
> > > > +{
> > > > +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> > > > +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> > > > +	bool oldtemp = st->conf.temp_en;
> > > > +	unsigned int sleepval;
> > > > +	unsigned int val;
> > > > +	int ret;
> > > > +
> > > > +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> > > > +		return 0;
> > > > +
> > > > +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> > > > +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> > > > +	if (!temp)
> > > > +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> > > > +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	st->conf.gyro.mode = gyro;
> > > > +	st->conf.accel.mode = accel;
> > > > +	st->conf.temp_en = temp;
> > > > +
> > > > +	sleepval = 0;
> > > > +	if (temp && !oldtemp) {
> > > > +		if (sleepval < INV_ICM42607_TEMP_STARTUP_TIME_MS)
> > > > +			sleepval = INV_ICM42607_TEMP_STARTUP_TIME_MS;  
> > > 		sleepval = max(sleepval,)
> > > or just assign it here if not later patches add stuff in between
> > > the assignment to 0 and here.  
> Wow I write some garbage English sometimes (no excuse, it is my
> native language!) 
> > 
> > I'm going to assign it to 0 here (unless you think I should define it
> > at the beginning as 0) and then tweak as needed. I think this code
> > here can be further optimized, especially if we make the assumption
> > that START and STOP time for each sensor is comparable (the datasheet
> > doesn't say, so I'm going to go with yes since that greatly simplifies
> > things).
> 
> I'm a bit lost. Suggestion was just to do
> 		sleepval = INV_ICM42607_TEMP_STARTUP_TIME_MS;
> as we know it is 0.   Probably not worth it though as ends up with fragile
> code.  Fine to keep it to what you have but use max() rather than
> if()
> 
> ...
> 
> > > > +static int inv_icm42607_resume(struct device *dev)
> > > > +{
> > > > +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	guard(mutex)(&st->lock);
> > > > +  
> > > Given the bunch of stuff we've run into recently around these
> > > I'm getting more paranoid.
> > > Similar to above, could you use pm_runtime_force_resume()
> > > You would need to gate stuff added later to not occur
> > > though if it wasn't runtime suspended.  
> > 
> > This I'm having trouble understanding. If I use
> > pm_force_runtime_resume() I'm assuming that either I got an error (in
> > which case I'd return the error) or the device is runtime resumed
> > after the call completes. If that's the case, wouldn't my suspend and
> > resume steps just be pm_force_runtime_suspend/resume, and enabling the
> > regulator (first for resume) or disabling the regulator (last for
> > suspend) as needed?
> 
> If you call pm_runtime_force_resume() it will do the right thing
> wrt to runtime PM state prior to suspend.  If it wasn't runtime suspended
> it will runtime resume - if it was it'll no do anything. It won't
> directly tell you which one it did though.
> 
> The extra stuff that you know can't be the case if runtime pm is on
> will need some sort of gating.  However, looking again it may already
> be protected by more specific checks.
> 
> 
> 	pm_runtime_force_resume();
> 
> 	if (st->fifo.on) { //I'd failed to look at what was added.
> 		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
> 				   INV_ICM42607_FIFO_CONFIG1_MODE);
> 		if (ret)
> 			return ret;
> 	}
> 
> That if (st->fifo.on) previously didn't get checked if we were runtime
> suspended because in fifo mode we never are.  So I was thinking you'd
> need that check to be
> 	if (!pm_runtime_suspended(dev) && st->fifo.on)
> but the fifo.on check is sufficient by the same argument that if fifo.on
> is true we aren't in runtime suspend.
> 
> Basically I overthought it and didn't check what got added where the
> comment is in this patch.

I'm still lost here... are you saying the existing logic is sufficient or
that we need to do something more (like force the runtime resume/suspend
in different places).

Thank you again for all of your help, you've been amazing.

Chris

> 
>  
> > 
> > > 
> > >   
> > > > +	if (pm_runtime_suspended(dev))
> > > > +		return 0;
> > > > +
> > > > +	ret = inv_icm42607_enable_vddio_reg(st);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Nothing else to restore at this time. */
> > > > +
> > > > +	return 0;
> > > > +}
> 
