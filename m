Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD11A9FAB;
	Sun, 12 Apr 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776009336; cv=none; b=LuYxLC95KBdvKOg4HhEA1zHA874klaVdJ1YPig7zvF6ambV5qgpo4WbOlmv3DJO3+Qm3MLR/GiNRmhjCB9nEEmjfnUDwCkLaHFujQgLg8XvUd2vMT6US0dMZBW4bH0wz2st8SdtmjrtoZ5eeLCE5fL8tr7GnqMLJi48EGKGyAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776009336; c=relaxed/simple;
	bh=d0ZuKhtFNdkkNyz7RHPgKJOLv2/ZqQDA7MYvJn13apI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXeAFiN4X1CkcrUAPIhifWbFYvuI2SLjJPktj/1mBVYcbFsQPMies7QpctRmEoNOL+D1nPG0HGqWN6ZVbGWBcPOR3k+tTQNTSePUR6X068cO/fLf5zbGfhGmpfeyHAMYuvEVPItzo1X1sQ5ipZDZZISCrRjdHOWqxUJNK5fWRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzoWCpBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzoWCpBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26A1C19424;
	Sun, 12 Apr 2026 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776009336;
	bh=d0ZuKhtFNdkkNyz7RHPgKJOLv2/ZqQDA7MYvJn13apI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OzoWCpBmmu9o3CNFO9d/U43iZDrCm3LKQXYkelMqWl2LmnkBLyPKS6PU+4lk21mae
	 S7/l85kYyAnWJmZmThEnKAEjKFAWDbyUK+FNVmGYrSUBhq+8/KotH4WNuV4tzYqfoz
	 K6StkP+niNOqasM0G+Ric++tjycJI+dcGOccsCt58iqnRAP8J3p5vp+pjIz3k+qUKm
	 nL3RkJPxg4LUSVZ20JB/QESPX9GymzhS00rdeJ+LkI7o8rgz2N0yr/HV7XFhQYed5X
	 peQi32zqtxN/2iHBXU8ypD/slnLFWajU8SMKUX0SV1FcIuZqysXs0Logpb1PaQOa0c
	 E345Q5D8GUA9A==
Date: Sun, 12 Apr 2026 16:55:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: gerben@altlinux.org, jagathjog1996@gmail.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] iio: imu: bmi323: Fix potential out-of-bounds access of
 bmi323_hw[]
Message-ID: <20260412165529.26c94145@jic23-huawei>
In-Reply-To: <ceb7a191-2e6d-4711-b108-e91a2fcaf2d7@baylibre.com>
References: <20260327103202.459143-1-gerben@altlinux.org>
	<ceb7a191-2e6d-4711-b108-e91a2fcaf2d7@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Apr 2026 14:28:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/27/26 5:32 AM, gerben@altlinux.org wrote:
> > From: Denis Rastyogin <gerben@altlinux.org>
> > 
> > The bmi323_channels[] array defines a channel with chan->type =
> > IIO_TEMP and enables the IIO_CHAN_INFO_SCALE mask. As a result,
> > bmi323_write_raw() may be called for this channel. However,
> > bmi323_iio_to_sensor() returns -EINVAL for IIO_TEMP, and if this
> > value is not validated, it can lead to an out-of-bounds access
> > when used as an array index.
> > 
> > A similar case is properly handled in bmi323_read_raw() and does
> > not result in an error.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
Good catch.

> > 
> > Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
> > Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> > ---
> >  drivers/iio/imu/bmi323/bmi323_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> > index 6bcb9a436581..64ead4f667e0 100644
> > --- a/drivers/iio/imu/bmi323/bmi323_core.c
> > +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> > @@ -1713,6 +1713,8 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
> >  		iio_device_release_direct(indio_dev);
> >  		return ret;
> >  	case IIO_CHAN_INFO_SCALE:
> > +		if (chan->type == IIO_TEMP)
> > +			return -EINVAL;

Please flip this around as we want support for this write to be opt in rather
than opt out.
		if (chan->type != IIO_ACCEL &&
		    chan->type != IIO_ANGL_VEL)

Alternative below is better though as that is opt in anyway.


> >  		if (!iio_device_claim_direct(indio_dev))
> >  			return -EBUSY;
> >  		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),  
> 
> This is OK, but why not check and propagate the error return?
> 
>  	case IIO_CHAN_INFO_SCALE:
> 		ret = bmi323_iio_to_sensor(chan->type);
> 		if (ret < 0)
> 			return ret;
> 
>   		if (!iio_device_claim_direct(indio_dev))
>   			return -EBUSY;
>   		ret = bmi323_set_scale(data, ret, val, val2);
> 		...
> 
> And even if we shouldn't hit the error in other case statements,
> it seems like it would be good practice to still check for error
> there too.
> 
> 

