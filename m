Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012072.outbound.protection.outlook.com [52.103.11.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5B3F54C3;
	Tue, 28 Apr 2026 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384882; cv=fail; b=Mnq9Ja6uRwnCp4rVRRJC/Rl0D+i6zByeVjFi6kEOwDf/PxbSjzdvNBfJ7uR91gkXPamIIrqNu93TN+MdEPhtpzYJWLqftHBW2CrU2VOJZ/4GKCW9Fmrt8vYHAPAMPMUPiyBKoV/yCOELDyrtizbc+K2U05q9be/0QXeBZNfvarY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384882; c=relaxed/simple;
	bh=8SkOps9pkf/xKMa8sNK8doHPouLoZUPWKIZ9Ukvug8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KrciZofjsLMlOTGNRGmc//ReA3WmqgvQ/viCYU6d0YcCN3FrWYmEP3VlP7Rb3aJQjI9IX2pnQ2rCqbn68J9ncXPVRdPlLUlYIkWqUtLeHIoIFeWKp0yDUhsta0nwnUAO/D7+SMjgola5pRONyCDggzDTa24/gUUoFNcTvpxhT4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rJkHMedU; arc=fail smtp.client-ip=52.103.11.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rJkHMedU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/VXz7AvB+WaS50OOdStScZqeHLBaKOLnsD/IciHQ82vGX3KZdHdwoY0BD1tR4cNlCjH9NE2QpBJElC7d9ps1kn3ce97adBCUfsJ2QGxUWdpQw+wid1vtn/+4QNIqC2xWyb0jhNtg4XkPOY3Kx7saBEmDLJAKCfzr1offpQxWJcqJIuKiunmunGtJH7cUju8OZrD0jklukE5zMo8hqe3WU9TY2VQUug7Oz/8n+w+QBY6jinZDKeP9vb8tAEJlSmaPn/DS407PWuYuzRNzT2SSbajZD4fNd5wpTkgc39qmQ+ZkpdldvnP3h01CwMs1liiR1WZQxDggfDIbw+3UVsO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK6NBNBD3roXbA/kjeXOANm8VDAyYnNh/C9qU1YF/00=;
 b=L2790M8jmRY/G0ZIZ3ONXHIEdzYOXVrBgQ0TGGgjZiBJ0tuwWmXFN1UlJq9P+ahO2/CthrCPMV4d6Eg79ckNx0d4QW0ktanRcIsOh6B+rhRFfgPk9zllJHVzbcfY50sOQdrpXz/udjrvw4rU3pj3McBgsIdEu86cJjugL4Vrp3zlLKdzHC3n36CBmFwvJ37DAB+r+0QWTlYmthzp6gdArtf9WYNScTZg73NkCQHUcSW/wLlGknzk45BQ6/2XqxHaelxVcHMCbEmT8jSnm+LJB0/mL3YFELAkS3EDC9ITPo4+vGoyM4mK3H0cE8Qymyntq3tTke98lw/OF5HcK7eewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK6NBNBD3roXbA/kjeXOANm8VDAyYnNh/C9qU1YF/00=;
 b=rJkHMedU7JgCgPcTjoLJ91PYOvLbeBC4c9gbKarpmbkm8Arq7AHhwgxZVVcb1/4CpWDOedOmLXFJuRY62qc0Nb9Wa9L4Yv5p1rgKyEAqj2wRf1VuqFVU8U0X4R0A5uZUXEMmg5vuMu53TY8A464U/FlFVScB6rCwJjZ52ZFsT6hQYzoD/oVmahEISGfqXR9nIlcYTlj0wZkkCyz1doAhMparHbD5I3nxG17jolz7QxJeKyZgNoCcZsV/8RKzh78b1dXSnjomK/aUNppu8e5l1RyL2YF29+MrBSXvPq81KfsQah/5hzOZqFdkB64r6VZokdTI1z85X+hnM/ggP8GJmw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CH3PR19MB7982.namprd19.prod.outlook.com
 (2603:10b6:610:161::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 14:01:18 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 14:01:18 +0000
Date: Tue, 28 Apr 2026 09:01:12 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V3 6/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID:
 <PH0PR19MB997338EE6A13BD08879C4B9B2BA5372@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-7-macroalpha82@gmail.com>
 <f1ae57fe-1ad5-46ee-9f0c-245f4deec7ce@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ae57fe-1ad5-46ee-9f0c-245f4deec7ce@baylibre.com>
X-ClientProxiedBy: SA1PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::15) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <afC9qOzisMfb_Ulc@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CH3PR19MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae7dbd2-00da-44ea-3d9f-08dea52e9eb5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|41001999006|6090799003|19110799012|5072599009|461199028|23021999003|15080799012|25031999004|24021099003|37011999003|440099028|3412199025|56899033|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+tjGF4PR3/YKtdK/48wli+WiOGSQDIZ6uiLgrJ2XkoT85j0jziVQDD7Z/ant?=
 =?us-ascii?Q?kqZVXgyIOMHIXVZMvC6GP1MKkpnqA+hoLFaAwaX6J3e5eeBWb6iop1FVO/xL?=
 =?us-ascii?Q?PDt5i9drIs8fmlUHknLs4w4DI795ml0BiwOlPTRf8GEhX0h/T0Bf4ANqLpYR?=
 =?us-ascii?Q?KdPe4wxZf62YI56+kiZ9H65bJ5mf+kWKtatbxcMnBrq8U5qgKiuLYls1HsxE?=
 =?us-ascii?Q?ZTQWP0YIPMv2dbughx29i7RbybhUfq6uvjqqN7Tr2nFD0z+Kl5YlQr3bb1DZ?=
 =?us-ascii?Q?VK5sHfq6lIR8a7gBfieImQFP7DxCrllLvlTC47dfRDJJUh4QQGXdXnHtgzIf?=
 =?us-ascii?Q?SJmXzIQ9ER7IaJJh4snymb82EeGnh9KAYFBeNvAYfRsTnO2Q8T/QoWhgE9ch?=
 =?us-ascii?Q?uuXsRAyU1yD5aLpe2ierKX3CB1x/HU3QFwp+3eUhtYX594ptdltd6LhnQRrE?=
 =?us-ascii?Q?ISLSLnAv1j5fCZtFmDV2A5tdAi2F5hs12uMJGzi8NJ9aGTe/h/T7+jdINqLw?=
 =?us-ascii?Q?MjmRueuTRtYZND4x9AU3qpdGk2wD4G9kt/729rrLTuZtBFaCk+pHf4MpVpm9?=
 =?us-ascii?Q?XwScOc45sZDBrhkLzTrJTbJRonxN6r/ufdEWgOt9k728jQAPps8Qw+Fs8Dbu?=
 =?us-ascii?Q?f+GP0yI57XHalXpKdurQMR9XiSqDruyN/PnhEmYlNJO63HOXmEkgzS0ZJX3i?=
 =?us-ascii?Q?Qi/yTOpzSUGG1oGinID/BrQEmJz+XYfoIWhZl8mK57851K+szReD1QXDFL4a?=
 =?us-ascii?Q?J2KLBm5yV9dBvIiH2HZujF4SH6URTQMELA6pXpS5T7mOtynCiMUV+NcrxORA?=
 =?us-ascii?Q?jQVsFJyapjYtJriAw9Xa6NaozPL5vq3ICY3iPq2CeqHQNZzatRnxeKb92fx4?=
 =?us-ascii?Q?8TqaWR9cROuYosm+M71sbt7TdfZOzDb3wvMrDTmuqDujOXD8RiUSa206qNfH?=
 =?us-ascii?Q?gdEa51PEwpy5iQ7SPdmsfB9exT9p22M+S5EWXtgKyp1L9lZ70O8WW3jBJq9m?=
 =?us-ascii?Q?VgdYUjisYC85zwp/LUg7zjpUngmmeBy9JCpDuKt7HXZXMbJIeGd538S/9Sbp?=
 =?us-ascii?Q?mpGfsQIj?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y3I0KI821oux9H+7CVAU6qtebCblyhcWoO229lSYTt09a/y/YQmcS8B5WfE6?=
 =?us-ascii?Q?QvaNpX2MK5ciU9ru4SrtNV0J7LruMmlFNCO/3bTJO+9jTKz2KlGR6vXW/dXQ?=
 =?us-ascii?Q?AYSwd28M7u1Pzfu19wjIs2dHgtpnY8gonwalcBK4F4QgZ/imQKI4IJPgsXQY?=
 =?us-ascii?Q?HMb3ariK3RzHhHkjgc0w0GrgIcsjL2ZhLMKTOl3Cqr3MR7rjGbmzASUL28XK?=
 =?us-ascii?Q?rpj7xQwPAKOV4O5bVyVmDOSf91kjs5L1PzFwpM3XR4mYHEImtyY8LeUH6zUn?=
 =?us-ascii?Q?tMK2UKQvcNpRx+u8tSLxeUeGm40zbwnPXCKZYPgxXjrQZF6lWBahJReevbt/?=
 =?us-ascii?Q?0hDI2rBS5cmIAr6FBIXDpz5OykPuw194SGO554+ZJnhwJdysuCl2sVkRS2B4?=
 =?us-ascii?Q?AAaqVXy2Ys6s2K/GOQw2EIrW71QnNA1N7B3l1Qa4CoRg+sKgFFA6QEoT8fvA?=
 =?us-ascii?Q?jDnpUtycs9wU11xWf/Y6kSeCw0Lg1gYgTaQD9eeb2n8DZq03Wbkpbkc2XuIX?=
 =?us-ascii?Q?/KElfxSCoSzw7/zLRiOhaXfaQNnpdGW/6zhsXHBXtL0vSnezIpeFXRzRKqPq?=
 =?us-ascii?Q?AWz49AF4gMvoRuJ7C4kdvf8GxEfekEHMaFkW94IkVww26CzOsWETXLG/rurK?=
 =?us-ascii?Q?8MuhdzqJD/kjzw2w7Y6UTM9k6On1/umsZ1oAlbGhU57Aq/0I4Fnwu4jMBis2?=
 =?us-ascii?Q?Ecya8qAXv/1l4r/mYoH7ybt0YHq7hPyPVwrouyJBc6qklwcjozisCGUl5J8B?=
 =?us-ascii?Q?uujPhBmv6Uekh/qNs+EnfUPZRi8wQ09YYEiikNA1v/k8jT3q4MPwblFOj+Xu?=
 =?us-ascii?Q?cW8PjQRzhLwTMDdwzrssB13F23bE8HUnGKKZoSg+o295D3/L65HMTkQTmOT4?=
 =?us-ascii?Q?URiGlzaHFAwntFs0qbtGOyaU6umcpC9cMGPKFJWW5p5dCa9KL3042lA9x2Lr?=
 =?us-ascii?Q?gNhTGFu2DPAjvFwpQmDdlyT1plyVH80kiTO6H1dndBvzpXeunQwuDZHfpKP9?=
 =?us-ascii?Q?T2GFr6FOHNOWfSsUoY3TeXQMe1a2me2ur/k+tLJZLaDavEWfUe3KGJfPzHpE?=
 =?us-ascii?Q?XWee98zO93Kq+MZVlQOe2BS4CNw0HSP/yGm8ebANmuRVv28nkEXib2FJ9IQO?=
 =?us-ascii?Q?lf9SgnJhf5X0PmkPCo7Xfki+E1B9jTXiiBkQkk5KT+SydJFLo9Y9bU0yLQFj?=
 =?us-ascii?Q?FBmo1F367PCsPcRASfDVylt8jC1OEspmeQHrgYUxdeFxoG1LyI+9mtpwoYjs?=
 =?us-ascii?Q?UPC8U2/F+5NzgC2sXHDpC/My1dYaGQZoaZqBFeS7asGIu1Q1rVlIIec46Yfz?=
 =?us-ascii?Q?KcZtPoVmG/Ylkm7FtA5dMKLTH0X/w88B/AsyIFZ4ncuw/mNVFvnihpP+PP08?=
 =?us-ascii?Q?PQVVfflA0+daQ1s5cgr2JZXQ8Hf/vHstMBCRbJoKvwU9Yaal/Q=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae7dbd2-00da-44ea-3d9f-08dea52e9eb5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:01:18.6422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7982

On Fri, Apr 10, 2026 at 05:59:05PM -0500, David Lechner wrote:
> On 3/30/26 2:58 PM, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add icm42607 accelerometer sensor for icm42607.
> > 
> 
> ...
> 
> > +static const unsigned long inv_icm42607_accel_scan_masks[] = {
> > +	/* 3-axis accel + temperature */
> > +	INV_ICM42607_SCAN_MASK_ACCEL_3AXIS | INV_ICM42607_SCAN_MASK_TEMP,
> 
> This is going to make it so that the temperature channel is always read
> even if it isn't enabled and additional work is needed when pushing to
> buffers to remove it again.
> 
> It looks like it is possible to read accel and temp separatly, so
> there shuold be two more lines here,
> 
> 	INV_ICM42607_SCAN_MASK_ACCEL_3AXIS,
> 	INV_ICM42607_SCAN_MASK_TEMP,
> 
> I forget what the correct order is though.
> 
> > +	0,
> > +};
> > +
> > +/* enable accelerometer sensor and FIFO write */
> > +static int inv_icm42607_accel_update_scan_mode(struct iio_dev *indio_dev,
> > +					       const unsigned long *scan_mask)
> > +{
> > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > +	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
> > +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> > +	unsigned int fifo_en = 0;
> > +	unsigned int sleep_temp = 0;
> > +	unsigned int sleep_accel = 0;
> > +	unsigned int sleep;
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	if (*scan_mask & INV_ICM42607_SCAN_MASK_TEMP) {
> > +		/* enable temp sensor */
> > +		ret = inv_icm42607_set_temp_conf(st, true, &sleep_temp);
> > +		if (ret)
> > +			goto out_unlock;
> > +		fifo_en |= INV_ICM42607_SENSOR_TEMP;
> > +	}
> > +
> > +	if (*scan_mask & INV_ICM42607_SCAN_MASK_ACCEL_3AXIS) {
> > +		/* enable accel sensor */
> > +		conf.mode = accel_st->power_mode;
> > +		conf.filter = accel_st->filter;
> > +		ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_accel);
> > +		if (ret)
> > +			goto out_unlock;
> > +		fifo_en |= INV_ICM42607_SENSOR_ACCEL;
> > +	}
> > +
> > +	/* update data FIFO write */
> > +	ret = inv_icm42607_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
> > +
> > +out_unlock:
> > +	mutex_unlock(&st->lock);
> > +	/* sleep maximum required time */
> 
> Would be better if the comment explain _why_ we need to sleep.
> 
> The code is pretty obvious that it does what the comment says, so
> it doesn't add much.
> 
> > +	sleep = max(sleep_accel, sleep_temp);
> > +	if (sleep)
> 
> Probably don't need the if here as msleep() should handle 0 without actually
> sleeping.
> 
> > +		msleep(sleep);
> > +	return ret;
> > +}
> > +
> > +static int inv_icm42607_accel_read_sensor(struct iio_dev *indio_dev,
> > +					  struct iio_chan_spec const *chan,
> > +					  s16 *val)
> > +{
> > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > +	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(st->map);
> > +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> > +	unsigned int reg;
> > +	__be16 *data;
> > +	int ret;
> > +
> > +	if (chan->type != IIO_ACCEL)
> > +		return -EINVAL;
> > +
> > +	switch (chan->channel2) {
> > +	case IIO_MOD_X:
> > +		reg = INV_ICM42607_REG_ACCEL_DATA_X1;
> > +		break;
> > +	case IIO_MOD_Y:
> > +		reg = INV_ICM42607_REG_ACCEL_DATA_Y1;
> > +		break;
> > +	case IIO_MOD_Z:
> > +		reg = INV_ICM42607_REG_ACCEL_DATA_Z1;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> > +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> > +		return -ENXIO;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	/* enable accel sensor */
> > +	conf.mode = accel_st->power_mode;
> > +	conf.filter = accel_st->filter;
> > +	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* read accel register data */
> > +	data = (__be16 *)&st->buffer[0];
> > +	ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val = (int16_t)be16_to_cpup(data);
> 
> We don't use int16_t in the kernel (ideally). Stick with s16.
> 
> Although cast isn't needed here since val is already s16.
> 
> > +	if (*val == INV_ICM42607_DATA_INVALID)
> > +		ret = -EINVAL;
> > +
> > +	return ret;
> > +}
> > +
> > +/* IIO format int + nano */
> 
> Usually we make these 2-D arrays for readability and then cast to int * if needed.
> 
> > +static const int inv_icm42607_accel_scale[] = {
> > +	/* +/- 16G => 0.004788403 m/s-2 */
> > +	[2 * INV_ICM42607_ACCEL_FS_16G] = 0,
> > +	[2 * INV_ICM42607_ACCEL_FS_16G + 1] = 4788403,
> > +	/* +/- 8G => 0.002394202 m/s-2 */
> > +	[2 * INV_ICM42607_ACCEL_FS_8G] = 0,
> > +	[2 * INV_ICM42607_ACCEL_FS_8G + 1] = 2394202,
> > +	/* +/- 4G => 0.001197101 m/s-2 */
> > +	[2 * INV_ICM42607_ACCEL_FS_4G] = 0,
> > +	[2 * INV_ICM42607_ACCEL_FS_4G + 1] = 1197101,
> > +	/* +/- 2G => 0.000598550 m/s-2 */
> > +	[2 * INV_ICM42607_ACCEL_FS_2G] = 0,
> > +	[2 * INV_ICM42607_ACCEL_FS_2G + 1] = 598550,
> > +};
> > +

I've gone through and implemented all of the changes everyone suggested, though
this is one of the few on which I had a question. Obviously this driver was
cobbled together from 2 different sources and checked to the best of my ability
and tested/validated against the data sheet, but there are a few bits I'm not
fully clear on such as this.

What's the correct way to represent this data? Since it looks like one of the
values is always 0, should I just assume it's always 0 and only represent the
values that change in this scale?

> 
> ...
> 
> > +static int inv_icm42607_accel_read_calibbias(struct inv_icm42607_state *st,
> > +					     struct iio_chan_spec const *chan,
> > +					     int *val, int *val2)
> > +{
> > +	/* Not actually supported in the ICM-42607P registers */
> > +	return -EOPNOTSUPP;
> > +}
> 
> Can we just not create the attribute instead of returning an error?
> 
> 
> > +static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +						struct iio_chan_spec const *chan,
> > +						long mask)
> > +{
> > +	if (chan->type != IIO_ACCEL)
> > +		return -EINVAL;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> 
> Can write this as:
> 
> 	case IIO_CHAN_INFO_SAMP_FREQ:
> 	case IIO_CHAN_INFO_CALIBBIAS:
> 		return IIO_VAL_INT_PLUS_MICRO;
> 
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> 
> ...
> 
> > +int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
> > +				struct inv_icm42607_sensor_conf *conf,
> > +				unsigned int *sleep_ms)
> > +{
> > +	struct inv_icm42607_sensor_conf *oldconf = &st->conf.accel;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	if (conf->mode < 0)
> > +		conf->mode = oldconf->mode;
> > +	if (conf->fs < 0)
> > +		conf->fs = oldconf->fs;
> > +	if (conf->odr < 0)
> > +		conf->odr = oldconf->odr;
> > +	if (conf->filter < 0)
> > +		conf->filter = oldconf->filter;
> > +
> > +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
> 
> We could use the regmap cache feature to avoid having to manual keep
> track of old values. Or just always write the same values anyway. I
> find that is nice when debugging hardware with a logic analyzer. Unless
> there is some measureable performance improvlment here?

This is another one I had a question on. I'm not entirely clear from the
datasheet which reg values are volatile and which ones are safe to cache.
Performance wise the 42607 series appears to be the *least* performant
in their lineup, so I don't imagine we care much either way. Should I just
not worry about the old values and always write? Do you think that would
work?

> 
> > +		val = INV_ICM42607_ACCEL_CONFIG0_FS_SEL(conf->fs) |
> > +		INV_ICM42607_ACCEL_CONFIG0_ODR(conf->odr);
> > +		ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
> > +		if (ret)
> > +			return ret;
> > +		oldconf->fs = conf->fs;
> > +		oldconf->odr = conf->odr;
> > +	}
> > +
> > +	if (conf->filter != oldconf->filter) {
> > +		if (conf->mode == INV_ICM42607_SENSOR_MODE_LOW_POWER) {
> > +			val = INV_ICM42607_ACCEL_CONFIG1_AVG(conf->filter);
> > +			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
> > +						 INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, val);
> > +		} else {
> > +			val = INV_ICM42607_ACCEL_CONFIG1_FILTER(conf->filter);
> > +			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
> > +						 INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, val);
> > +		}
> > +		if (ret)
> > +			return ret;
> > +		oldconf->filter = conf->filter;
> > +	}
> > +
> > +	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
> > +					  st->conf.temp_en, sleep_ms);
> > +}
> > +

Thank you otherwise for all your valuable feedback. I've implemented
it to the best of my ability and plan on resubmitting this series
soon. Thank you.

Chris
