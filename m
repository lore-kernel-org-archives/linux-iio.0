Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADD3783B1;
	Mon, 11 May 2026 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501214; cv=none; b=cYUWyshIWIxQute4AmS/p4Ee/gyxDvvEHRUflRwHi6MpeDqnkYMQBPxGMZ44DnoLBRUqH3QkG0PGilWRBi910Rb1rDlhfWshLQzzt6NILxnXM9D9eEs4ihRkMm0FAGnCcd0my1Uk+oHjyQozvEI0j51DvxT0dw0ERYF6po4E70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501214; c=relaxed/simple;
	bh=KUz4Hp8zyRj8wJ2tvvUB76l56YW2G7r1DK6t38FFHRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WphaxyVxq6bsIy2tuKS70vCHhYSEODRtpxTFBosCgXuZKrPX8VMyFPr80UnSvnKPKj2BKS8Ob+HRRPUbYxWu6H9AX4Jwna0uDUqZFXAoxc+vWqFNubPHF2AKiHMoC56Sn75fPZfTnosKA1JcoW3cFHU/bsCV+5gXstPyHtQxMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfPPyY6p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfPPyY6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A554C2BCB0;
	Mon, 11 May 2026 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778501213;
	bh=KUz4Hp8zyRj8wJ2tvvUB76l56YW2G7r1DK6t38FFHRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RfPPyY6phyBmhBNCO2c266i6uUOCKzEUToxx+ksCWpgHWnrJ9Gi/zUfr4CRwHhSD+
	 r1OUrkLr4h/J+FLgZEkuttNqI5vnrgK2aISnA7GKNGQe9ee9+uSbOp92Kg3n+Cs+NB
	 xCmVE+RiZ2wneBHKicZM33kYRyEytG+GdjFvMH/NBITLjidJnzsRaM4CXkH2C91yWR
	 IhbmexJIt2tFjHt3T0RMaG/h7drIDg2jk/KuMdtdLko3lxSB0zIGTpUb5YCHEOrGwi
	 UUHMaF/srVlQkCBQ0pm7EXTwN741fhbCD/MsRFr5XRM5GD5LOcSn4mUQ7s9ImJUqcf
	 feD6TbU1gyqiA==
Date: Mon, 11 May 2026 13:06:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: scd30: Prevent potential
 divide-by-zero errors
Message-ID: <20260511130648.0c0f4deb@jic23-huawei>
In-Reply-To: <20260511130555.2eec64a3@jic23-huawei>
References: <20260510202154.319585-3-m32285159@gmail.com>
	<20260511130555.2eec64a3@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 13:05:55 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 10 May 2026 15:21:56 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> 
> > In scd30_read_raw, the current value of tmp in the
> > IIO_CHAN_INFO_SAMP_FREQ case is unchecked. Add checking to see if the
> > value we got was 0 to prevent a divide-by-zero error.
> > 
> > A similar case has also been found in scd30_write_raw(), also in the
> > IIO_CHAN_INFO_SAMP_FREQ case, where the value of val2 was unchecked.
> > Add checking for that variable as well and return -EINVAL if it's 0.
> > 
> > Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")  
> To me this one is a hardening change not a bug fix (unless we have
> reports of this hardware failure on a real product - not a devboard
> with dodgy wiring ;)
> 
> So no fixes tag needed.
> 
> Also there is already a fix for the write_raw one in my fixes-togreg
> branch. Antoniu got there a few weeks back.

By which I meant no fixes tag needed when it's just the read_raw case
where it isn't a userspace controlled value

J
> 
> Jonathan
> 
> 
> 
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
> >  v2:
> >  - Switch to dev_err_ratelimited() per sashiko.
> >  - Fix another potential divide-by-zero error per sashiko (see commit
> >    message).
> > 
> >  drivers/iio/chemical/scd30_core.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> > index be8c055be184..3851c9334c8b 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -237,6 +237,16 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
> >  		if (ret)
> >  			return ret;
> >  
> > +		/*
> > +		 * Value of 0 is unexpected but possible if hardware is failing
> > +		 * or noise on data bus
> > +		 */
> > +		if (!tmp) {
> > +			dev_err_ratelimited(&indio_dev->dev,
> > +					    "Invalid measurement interval 0 received\n");
> > +			return -EIO;
> > +		}
> > +
> >  		*val = 0;
> >  		*val2 = 1000000000 / tmp;
> >  		return IIO_VAL_INT_PLUS_NANO;
> > @@ -261,7 +271,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
> >  	guard(mutex)(&state->lock);
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		if (val)
> > +		if (val || !val2)
> >  			return -EINVAL;
> >  
> >  		val = 1000000000 / val2;  
> 

