Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027604A015B;
	Sat, 17 Oct 2026 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278647; cv=none; b=r/MGSRuenjvlRDOygCM5DPrNbCjQuBWrCUTm9mkfvl1td4c3qm5DnOO2wNG7DrVqhYMxdsRY2fMYjTQ++6Gmx8aHM93+iEeLSAo+Q3ZidOpvrQe3joeDQyQ4GvQiQIXh67eYwXrli/pQyUtFhT8QZ2V9bQb5UBLeW0OFgJgd+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278647; c=relaxed/simple;
	bh=kCIVRfXQi3yASmlaFkl5s5jaggkSWMzEPEml5kch36M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RE5fSjKP+dZyw+OFAakzisataNmse5MdOTvjQM9ckiEv9eGcfQQVDgeDMzFT7h3uI5QIAMv3U3Jvid4WW65Fg3dmvk/wR6y57YWATisS4wO143TH8l6Av4mijVMXJE5YYCLocW7ORDwV75qPl1PgsE150WqYjs6HC7cuHxMKYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPY1gYah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPY1gYah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120111F000C4;
	Sat, 17 Oct 2026 23:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792278646;
	bh=/L3YeLHKB09vOTTGPcyENwwCNDUxu3dkeI5NBzlemyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QPY1gYahZoCzCvBkAZvyreOnAbOmhI9ocyNiF+NG+IMD1G9SIZbP09Ny75N0PQWL2
	 Vq/d9jtfbaqd5AkOYdu5GGg/FmB9qE3RxpM7bL9JQwhGKBK80WAoyU5VXUQ1tXWR9Z
	 fJtsrMCaWFrkTtNOhQ9pmu2PWeadKiNoFSf86jaa6yVnDiu/28kf3vb7mxVzwA/Lov
	 F4g4r62YYu8bBIXaY1ueZHXUXx+j5/oloanMJV1oihK60FW7p6G/r9A3sP1DYkndjw
	 O/TGptKuQcJtBLskVOmW7PM6mrm62GsSIQiykpu46/F/LCzR8ojhksanHJBJmHvzSL
	 sYdqPou/DkBNA==
Date: Sun, 18 Oct 2026 00:10:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix swapped accel and gyro
 startup times
Message-ID: <20261018001042.31f109bf@jic23-hlaptop>
In-Reply-To: <BE1P281MB14268B8ABA5134519916E673CE9F2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20261011045710.357809-1-kapoorarnav43@gmail.com>
	<BE1P281MB14268B8ABA5134519916E673CE9F2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > 	{
> > 		.whoami = INV_IAM20680HT_WHOAMI_VALUE,
> >@@ -311,7 +365,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
> > 		.config = &chip_config_6500,
> > 		.fifo_size = 4 * 1024,
> > 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> >-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >+		.startup_time = {
> >+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
> >+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
> >+		},
> > 	},
> > };
> > 
> >-- 
> >2.53.0
> >  
> 
> Hello Arnav,
> 
> another good catch, thanks for the patch.
Absolutely.  

If you fancy doing a follow up cleanup, lets reduce chance of similar
by using named initializers for .temp just above each of the changes
made in this patch.

No problem if you have moved onto other things!

Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan

> 
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Thanks,
> JB
