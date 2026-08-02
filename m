Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843283A14;
	Sun,  2 Aug 2026 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635382; cv=none; b=SieVVi8Z5BOzWARacjXDgo5zVCZ/NHr5Fq35boEekeubKnLkPxlta5XngELWrul9vI3Fd4pSzSM14s6JBHYnAcJJpyT+DYmVSgkH6fwLM7fqoxhMLRSwH25N6G5TQVB/KaO53xpvUlC26LT5TKdSg53AQpR7b3X+vsmloNNm/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635382; c=relaxed/simple;
	bh=6gk1pN8lnums3U8Ebdp7LdYB79hFFCtJFxBfyx3779Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4DuiXXzBGmjz8ABi71CJ9guCVg35pvAECTDvqPVe20jnY1aY+qRG5Lt1Tf8wV26nyNchXaL6iywQwGQRwZqYKCO3GHzatMTLl6h8Nf9ZX6YO1fIhkpWmFyFmTMybQetRQ07Vu9zFZkUKgSQomkQwYCvZRbR8qMBQf1Lo1ZiQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJVKqVtg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJVKqVtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB821F00ACA;
	Sun,  2 Aug 2026 01:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635381;
	bh=URkOTl2aNej1/Vy8jixVrUCmPhiBPbFrf95LlKeYltY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CJVKqVtg8pEaeiTLaw2MdaarIPuVfjGhpB+F6cRqrbnKLEf6Lr9y7yd7oz9RQiby9
	 s8LKQMdKn7TgHuys+0rp9b8Ljj0YiYuIfyqCj8JquTQoGo5YP6YS5b0pbOqKrl3UmV
	 mP5NpADbNWt6rr5UmEMIyxfXDYVNE8fFqlnQ0kxLoDcbneDPNK+ISUcVyQ4HF6pJNF
	 mbsDFdXq2kNhFzSQkOx0UXGlpP3Jb0sY8zy2V3P/qbIIahs2P25pdTyCmnMHgtChmV
	 dhO2MQCnqwWT6G+oBLjqoXKIFI+iJKcHNPnTANmu1QY4WqjmFFggUYLCtJmMP9Zly4
	 bxi4oQrZ9/nhQ==
Date: Sun, 2 Aug 2026 02:49:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Update enable mask when using
 sensor fusion
Message-ID: <20260802024935.2bf032c5@jic23-huawei>
In-Reply-To: <am0JPMfepRUkMNfy@lore-qca>
References: <20260731174702.2665870-1-flavra@baylibre.com>
	<am0JPMfepRUkMNfy@lore-qca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 22:44:44 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > The enable_mask struct member keeps track of which sensors are enabled in
> > the IMU. When enabling and disabling the sensor fusion functionality, the
> > driver does not properly update this struct member. This prevents a correct
> > calculation of the number of samples that should be read from the hardware
> > FIFO; as a result, reads from the FIFO can be unnecessarily split into
> > multiple transactions, some of which can read past the FIFO length.  
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> > 
Applied to the testing branch of iio.git and marked for stable.

Going the slow way because Linus has requested only breakage from current cycle
or critical fixes take the fast path. So this will take a few weeks to make
it into stable trees.

Thanks

Jonathan

> > Fixes: cd4e1141bff8 ("iio: imu: st_lsm6dsx: Add support for rotation sensor")
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> > index 2e72c7ba94dd..5321033daebc 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> > @@ -112,6 +112,11 @@ int st_lsm6dsx_fusion_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
> >  		return err;
> >  	}
> >  
> > +	if (enable)
> > +		hw->enable_mask |= BIT(ST_LSM6DSX_ID_FUSION);
> > +	else
> > +		hw->enable_mask &= ~BIT(ST_LSM6DSX_ID_FUSION);
> > +
> >  	return st_lsm6dsx_fusion_page_disable(hw);
> >  }
> >  
> > -- 
> > 2.39.5
> >   

