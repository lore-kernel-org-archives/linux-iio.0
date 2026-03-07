Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C181339A4;
	Sat,  7 Mar 2026 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880221; cv=none; b=QEtFVxhuQU4xfq7pxexcgVlP/ZwYiGqKkq5ogcKvpCeqaOvtC1eQVM61B1B5jtrIWUKscbtLcld2s/pKPbB71IlhOynQFAnWAcyXCYlTvDGpj7DzD6/x1uj4ZLQ8gVUrBNaMiThCWlHJvcBsB/XQYOEiNyy7H7AWD4FYZ0Udmzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880221; c=relaxed/simple;
	bh=EmXqekTwyeJo0T/iHo6pjr8xk/7J41VJ7Cy2yQlMueQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFWu9VXdWqNZXL1xZNCHVdx8U+UrAKyChGZ77cGgURdOPooRbQ7pPa3q56zRgDVqs4XDCpoiSnwWTrqoA2DT0G4sioklWUzRV+SsYm7CFZxzSnADaw2Hj11UZsKy3AtYYswHOQafPBw1ahl2bGsx5oEeQb73iFuEuu+dOtADpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH2j/pSD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH2j/pSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03067C19422;
	Sat,  7 Mar 2026 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772880220;
	bh=EmXqekTwyeJo0T/iHo6pjr8xk/7J41VJ7Cy2yQlMueQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nH2j/pSD/WlvwuCUW740IQdNFbGyqd1xkoyK35wchcWFn61M7w426EoijSF6CoJIG
	 cyb7Dgtqxo+IR4TRsg+ohWXfoqZ4+qAAQeAu7JF+5NgfPHqdrvrUggRHZdkleSekm0
	 r0PV7DtQiNMsUzaE12mIXwcpMMH3xgz7uzZbVzCbkyPKq7X+Uf38ODX1p4i8HIyrrC
	 RHmN3hSgAPMEZsaMqBxwjqnP3PSTG5bnw0FB5rfUOPuHNzTS3jxM338DvpV1hCkjZQ
	 oe0J2M+ATwEVGOtcqajiZtJMTYPJceT4tTaiKKCs8SPJNsXjcyJp/6c3EeyFclEVKP
	 7B1inG+IuOwMA==
Date: Sat, 7 Mar 2026 10:43:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 puranjay@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: accel: adxl355: convert to guard(mutex)
Message-ID: <20260307104331.2d1402cd@jic23-huawei>
In-Reply-To: <20260307103949.4cb3ce6e@jic23-huawei>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
	<20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
	<20260307101758.50091-3-rajveer.chaudhari.linux@gmail.com>
	<20260307103949.4cb3ce6e@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Mar 2026 10:39:49 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat,  7 Mar 2026 15:47:57 +0530
> Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:
> 
> > Replace manual mutex_lock/mutex_unlock pairs with guard(mutex) in
> > adxl355_data_rdy_trigger_set_state(), adxl355_set_odr(),
> > adxl355_set_hpf_3db() and adxl355_set_calibbias(). Remove all
> > goto labels and return directly on error paths.
> > 
> > v3: Remove all remaining gotos and return directly where possible.
> > v2: Split into separate patch per driver.  
> 
> Same issue for the change log needing to be below the ---

One more thing. Sometimes guard() brings enough extra complexity it isn't
the right tool for the job. Whilst you can explore the suggestions for
helper functions I make below, I'm not sure they will lead to easier to
read and less error prone code.  So it might not be a good idea to use
them in this driver at all!

Jonathan

> 
> 
> > 
> > Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
> > ---
> >  drivers/iio/accel/adxl355_core.c | 81 ++++++++++++++------------------
> >  1 file changed, 34 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> > index 1c1d64d5cbcb..af606e2ab8d4 100644
> > --- a/drivers/iio/accel/adxl355_core.c
> > +++ b/drivers/iio/accel/adxl355_core.c
> >  
> 
> ...
> 
> >  
> >  static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
> > @@ -409,38 +407,34 @@ static int adxl355_set_odr(struct adxl355_data *data,
> >  {
> >  	int ret;
> >  
> > -	mutex_lock(&data->lock);
> > +	guard(mutex)(&data->lock);
> >  
> >  	if (data->odr == odr) {
> > -		mutex_unlock(&data->lock);
> >  		return 0;
> >  	}
> >  
> >  	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> >  	if (ret)
> > -		goto err_unlock;
> > +		return ret;
> >  
> >  	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
> >  				 ADXL355_FILTER_ODR_MSK,
> >  				 FIELD_PREP(ADXL355_FILTER_ODR_MSK, odr));
> > -	if (ret)
> > -		goto err_set_opmode;
> > +	if (ret){
> > +		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);  
> See below.
> 
> > +		return ret;
> > +	}
> >  
> >  	data->odr = odr;
> >  	adxl355_fill_3db_frequency_table(data);
> >  
> >  	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > -	if (ret)
> > -		goto err_set_opmode;
> > +	if (ret){
> > +		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > +		return ret;
> > +	}
> >  
> > -	mutex_unlock(&data->lock);
> >  	return 0;
> > -
> > -err_set_opmode:
> > -	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > -err_unlock:
> > -	mutex_unlock(&data->lock);
> > -	return ret;
> >  }
> >  
> >  static int adxl355_set_hpf_3db(struct adxl355_data *data,
> > @@ -448,37 +442,33 @@ static int adxl355_set_hpf_3db(struct adxl355_data *data,
> >  {
> >  	int ret;
> >  
> > -	mutex_lock(&data->lock);
> > +	guard(mutex)(&data->lock);
> >  
> >  	if (data->hpf_3db == hpf) {
> > -		mutex_unlock(&data->lock);
> >  		return 0;
> >  	}
> >  
> >  	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> >  	if (ret)
> > -		goto err_unlock;
> > +		return ret;
> >  
> >  	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
> >  				 ADXL355_FILTER_HPF_MSK,
> >  				 FIELD_PREP(ADXL355_FILTER_HPF_MSK, hpf));
> > -	if (ret)
> > -		goto err_set_opmode;
> > +	if (ret){
> > +		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);  
> 
> Similar to below.
> 
> > +		return ret;
> > +	}
> >  
> >  	data->hpf_3db = hpf;
> >  
> >  	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > -	if (ret)
> > -		goto err_set_opmode;
> > +	if (ret){
> > +		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > +		return ret;
> > +	}
> >  
> > -	mutex_unlock(&data->lock);
> >  	return 0;
> > -
> > -err_set_opmode:
> > -	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > -err_unlock:
> > -	mutex_unlock(&data->lock);
> > -	return ret;
> >  }
> >  
> >  static int adxl355_set_calibbias(struct adxl355_data *data,
> > @@ -486,33 +476,30 @@ static int adxl355_set_calibbias(struct adxl355_data *data,
> >  {
> >  	int ret;
> >  
> > -	mutex_lock(&data->lock);
> > +	guard(mutex)(&data->lock);
> >  
> >  	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> >  	if (ret)
> > -		goto err_unlock;
> > +		return ret;
> >  
> >  	put_unaligned_be16(calibbias, data->transf_buf);
> >  	ret = regmap_bulk_write(data->regmap,
> >  				adxl355_chans[chan].offset_reg,
> >  				data->transf_buf, 2);
> > -	if (ret)
> > -		goto err_set_opmode;
> > +	if (ret){  
> Whilst this does answer the feedback you got on v2 wrt to not mixing
> gotos (see comments on this in cleanup.h) it leads to inelegant code
> due to the duplication.
> 
> There are a couple of techniques to avoid this. The most appropriate
> one here is to use a helper function called something like
> do_adxl355_set_calibbias() which has all the code
> done between set_op_mode and unsetting it.
> 
> Then you can unconditionally unset the op_mode before checking
> if there as an error.  You will need to be a little clever with
> ret code handling though.
> 
> 
> > +		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > +		return ret;
> > +	}
> >  
> >  	data->calibbias[chan] = calibbias;
> >  
> >  	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > -	if (ret)
> > -		goto err_set_opmode;
> > +	if (ret){  
> 
> Run checkpatch.pl over your patch. Should be a space before that {
> 
> > +		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > +		return ret;
> > +	}
> >  
> > -	mutex_unlock(&data->lock);
> >  	return 0;
> > -
> > -err_set_opmode:
> > -	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > -err_unlock:
> > -	mutex_unlock(&data->lock);
> > -	return ret;
> >  }
> >  
> >  static int adxl355_read_raw(struct iio_dev *indio_dev,  
> 

