Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C2359A7E;
	Wed, 25 Mar 2026 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469343; cv=none; b=i8JpQ8ix6nrkotYXpbWGfVib9vALOHHlOsC31sSRSA/QondebXjpTD8jtDgAmz2f9IZmOLHJdO1BK3BWueRMAlicJd9cFINhvM6tAS8pfhsLqZoKrmqRM1nUwmGM0kX8z+bujUpb/dtv6VCpXuBhjGasiJJiFfqIWbZ3VEA879w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469343; c=relaxed/simple;
	bh=0bBvVVaKgOM7c1Ca68Gl1jgezhLJDyl64PVrVnQSxWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTgxql5lYsSFL5lRdj820Z+qLAAjHCVcZ0cMKkKNpYJ248hBX9K2qWQ5Qi2+1f0RexS9PoDDIlAcv8Lz6BLDfon4jmam477q2txOUkw8gr/mvq+ZIn0wwedRXch9BwvvJDiOlyTB1bt1oo1agAayxLOZSSnNxYq3FNbYFIyjIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVGGiGD7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVGGiGD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C30C2BCB2;
	Wed, 25 Mar 2026 20:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774469343;
	bh=0bBvVVaKgOM7c1Ca68Gl1jgezhLJDyl64PVrVnQSxWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sVGGiGD7aLYWIojRrBr9Pj6Yc6WYtZjnnMC0z5qULcDQ1MkXZ7DZG4b86APhA+1bM
	 AUMeJ+09kBEXEh4ZsSjNw7HISrnBwzosnOM8UZi6EVmWxJN0AajY+GdAQs92RN7Ukz
	 yL4MXPvQlmobNgCSBOHcLzaa2PrTI+QT6zY8J+yXR0honZu+KoeUmGSSF7kliPfmYh
	 fWRWzxUPS4gnO3M6C5SNm/dEjwEkvdBgt9lnssd7mqph6QwUMG2HOHxqMg/DtcKUIN
	 HvMT/+vnGQRN4dAQRulDRxwCnX83uaESShcTxcXTQuTNOuL3sfUfhNqT8Ys477vGaw
	 wmluYx3/OWHJg==
Date: Wed, 25 Mar 2026 20:08:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <20260325200854.4385b329@jic23-huawei>
In-Reply-To: <20260325145526.000071ad@huawei.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
	<20260324084808.654118-1-flavra@baylibre.com>
	<20260325145526.000071ad@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 14:55:26 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Tue, 24 Mar 2026 09:48:07 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
> 
> > Some IMU chips in the LSM6DSX family have sensor fusion features that
> > combine data from the accelerometer and gyroscope. One of these features
> > generates rotation vector data and makes it available in the hardware
> > FIFO as a quaternion (more specifically, the X, Y and Z components of the
> > quaternion vector, expressed as 16-bit half-precision floating-point
> > numbers).
> > 
> > Add support for a new sensor instance that allows receiving sensor fusion
> > data, by defining a new struct st_lsm6dsx_fusion_settings (which contains
> > chip-specific details for the sensor fusion functionality), and adding this
> > struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> > populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> > logic to initialize an additional IIO device if this struct is populated
> > for the hardware type being probed.
> > Note: a new IIO device is being defined (as opposed to adding channels to
> > an existing device) because the rate at which sensor fusion data is
> > generated may not match the data rate from any of the existing devices.
> > 
> > Tested on LSM6DSV16X.
> > 
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> One trivial thing. But don't resend for that. Assuming nothing else comes
> up I'll tweak it whilst applying.  Same for Andy's line wrap comment.
> 

Ah. I tried to pick up the series but we have a dependency on a fix
that hasn't quite made it upstream yet and I don't want the complexity
of merging my own fixes branch in until I know that made it upstream.

Sorry, I don't think I can get this merged this cycle unless we go
to rc8. Will get it queued from start of next cycle.

Jonathan

> thanks,
> 
> Jonathan
> 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> > new file mode 100644
> > index 000000000000..9fb3e19e4a55
> > --- /dev/null
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> > @@ -0,0 +1,243 @@  
> 
> > +
> > +int st_lsm6dsx_fusion_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
> > +{
> > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > +	int err;
> > +
> > +	guard(mutex)(&hw->page_lock);
> > +
> > +	err = st_lsm6dsx_fusion_page_enable(hw);
> > +	if (err)
> > +		return err;
> > +
> > +	err = st_lsm6dsx_fusion_set_odr_locked(sensor, enable);
> > +	if (err) {
> > +		st_lsm6dsx_fusion_page_disable(hw);
> > +		return err;
> > +	}
> > +
> > +	return st_lsm6dsx_fusion_page_disable(hw);
> > +
> > +out:  
> Stray.  If nothing else comes up I'll drop this whilst applying.
> 
> > +}  

