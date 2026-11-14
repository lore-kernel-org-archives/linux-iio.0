Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794696231;
	b=BxRmNnPRwTjjOSkskelD7hxTzr2ey7GLhDVJqwRu8AumFjq9EZoOY8gS95V97X8zBJlU
	 Dq06psJQEiM9HQ8XVOcuWdaQUQDuc/Q4fn8KNq94SPDGoq7JOi2o2bO6XTgZGv3N+memI
	 KwXB2KmSilP6tdVRLhnrZS76rYbWjQ5T3DbhiPux0vdE+eIPVwE/J+886CRbno/RBDgDd
	 GnOt0T6rK7zRHhQijMqNDVMWT8wgb2/yUEyPn4G2hY4H8U9MFmuagRyBEYVkYCMQQDehs
	 CRFhNhBxFdx80xw/CTu157gukKLMV6EAMcPg/G35931zkRfXNwxG6I2vtrPMiKtwwCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794696231;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fmLdiCj4pTbjMuz54CgFehD3JmaDzwV1oYyPSiV+so8=;
	b=ZfbWkyFYq52CcXlLFLAfVck96l2B1nn/vaWqV2Vn+69+Uug66j3ecvHK3UmvsWAxtjca
	 tixC8IBW7zCVsLDW+9vZEJM6CeIAuUIU34HwICrAs5vyRavwuIei19UuDZ+36cNYRKb+9
	 U3MniQUQCaS7oje0eXMKh6EiJDsP38PUyTn/AdXsvjK05eNeqeggbgMDh56VyUQoa3fH9
	 87HSdbHay8oYG63BVuWoHDG2FtsTgZZCnNOWjWEMVFFm6qhTbPFG/rrJbqPY3bMkQ63nq
	 Zmv6w+QmWSHvesQvV7vVJ9ZQp4REqCyr3WCZw88YBHOkHIRLtneRqqX5xPGPhN5PmNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQKQFmmV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A9606A327
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQKQFmmV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB311F000C4;
	Sat, 14 Nov 2026 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794696231;
	bh=fmLdiCj4pTbjMuz54CgFehD3JmaDzwV1oYyPSiV+so8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SQKQFmmVeNlz/M+lQ5x+NJXcd0NSb8cGpPkkfcaPNW+wSZq83T86ukaAJTbPkt79b
	 E2FGfKEqRemjT7CqfiKr9yBKYpGnCagqKJm868AYaZtQFe194VapcCGUbF7Tt+pVKK
	 NZeYSMiZwV6nqxjGCaoyhbce8oaHeuUNBm0eVawI+fz67PxQHRJ80c12+RUTEJHLuF
	 3eVRsty4ZFqm79qXm4UyLcxaXQmjpLuoINC3q7XghkJxYvsNR5d0wOKoPuC2qfwSzG
	 rcjDMGVECP8S27vwwVoTk7jcYGeH6c7gcphDddRXDPBGUTs6qSbM51vxNtXKEum/5m
	 0KL6XIqjdeJ9Q==
Date: Sat, 14 Nov 2026 22:43:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe LeVeque <joe.l@reflexrobotics.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature
 sensor disabled (ICM-42688-P)
Message-ID: <20261114224344.105e0e04@jic23-hlaptop>
In-Reply-To: <CAJLMkXYNpRWWqNbUn72J8p7Fqi1jCy4FC2fdAtjkzJ4eW_9r2Q@mail.gmail.com>
References: <CAJLMkXY6wS7ErVT5YUyp=c0TJDPmGePJiDua4MPw47V83JQ0Fw@mail.gmail.com>
	<FR2P281MB310391F1880DC67B2FC446DBCE722@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
	<CAJLMkXYB9NjwN1ZxfkGPE=y2NESRc=ir7B80cVpVk=d-tyPoVw@mail.gmail.com>
	<CAJLMkXYNpRWWqNbUn72J8p7Fqi1jCy4FC2fdAtjkzJ4eW_9r2Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 14:27:22 -0800
Joe LeVeque <joe.l@reflexrobotics.com> wrote:

> Hi Jean-Baptiste,
> 
> I've implemented the change as you suggested (temperature sensor always
> on, temp_en, set_temp_conf() and the TEMP_DIS handling removed, FIFO
> temperature reporting unchanged) and tested it on my ICM-42688-P (SPI,
> i.MX8M Plus, 6.6 kernel with the driver backported).
> 
> The gyro reads correctly from the first read after boot (about 3, -6, 0
> LSB at rest at +-2000 dps), including after runtime suspend, and the
> accel is unchanged.
> 
> Regarding my question about temperature reads with both gyro and accel
> off, testing shows the data is not marked invalid. The temperature
> register retains the last measurement:
> 
>   gyro and accel off (runtime suspended), 10 reads 1 s apart:
>     3598 3598 3598 3598 3598 3598 3598 3598 3598 3598  (about 52.2 C)
> 
>   gyro running (sysfs gyro read before each temp read), 10 reads:
>     4934 4956 4950 4958 4956 4958 4956 4958 4962 4958  (about 62.4 C)
> 
>   gyro started fresh each time (reads 3 s apart, autosuspend 2 s):
>     4952 4960 4964 4960 4956
> 
> So with both sensors off, a temperature read returns a stale value, here
> about 10 C out of date, instead of INV_ICM42600_DATA_INVALID. The invalid
> value only seems to appear before the very first measurement after
> power-up. The fresh-start results show the first sample after a sensor
> starts is current, so it appears the separate temperature startup delay is not
> needed.
> 
> With the patch as it stands, inv_icm42600_temp_read() would therefore
> silently return stale data when both sensors are off. I see two options:
> 
> 1. Return -EBUSY based on the driver state: if both st->conf.gyro.mode
>    and st->conf.accel.mode are INV_ICM42600_SENSOR_MODE_OFF, return
>    -EBUSY without reading the register. Small, and maintains the documented
>    behavior.
> 
> 2. Have the temperature read turn on the accel (for example in low
>    power mode), wait for its startup time, read the temperature, and let
>    runtime PM turn it off again. A current value is then always
>    returned, at the cost of a delay on that read.

This one would my preference.  Having sysfs reads for a channel return
an error under normal circumstances is a bit unintuitive. I think
we let that in for a few devices where the temperature was really of
very little direct use as it was dominated by the neighbouring sensor
element rather than broader environment. So not a hard and fast rule
but my preference none the less is to report data when we can!

> 
> Which one would you prefer? I'm happy to implement either in the patch.
> 
> Thanks,
> Joe
