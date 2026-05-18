Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8336DA14;
	Mon, 18 May 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117568; cv=none; b=n+jZeI5ls++90NYB2WeS59Evd6eSyKRulUhXVCUnJ7/OHUgLyrxEFIKNUdmW4EluicDUIxtAE4+ipanb2b0oJCoZvR6bX9+IASxlOyOImTkNvhTwe4fKxkdUMH/le+QqSuh2wfmfZMKNOlMK7LJLVItJRWGNV+Geg22Ct4RYkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117568; c=relaxed/simple;
	bh=ohYqeSjJ6o4iNeLfzsstcqkIZRcJMkgqoDKSN70mfK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmW7ybe4UXCLdrchHPBZbxdS9z1cHfi5T7Wgv0HFHJc0FZk2FqTjP5/7n9u4GL/kqIa5bqbSlgtwn4rfzOwENI21P/UwMpwnpxW6TzUeJRrx9WAPq9P9lnu/21OTTuEHroZSdhYqnf+gF/xBC+UUqI1TBJa6ZlLdW2vWGqcJt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4OMoSd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4OMoSd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92AFC2BCB7;
	Mon, 18 May 2026 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779117568;
	bh=ohYqeSjJ6o4iNeLfzsstcqkIZRcJMkgqoDKSN70mfK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P4OMoSd0UR75fpog/Odnhc1MNlBT8mF5qZew6olhFqkIRWECKmYTcsAAT1cqT6ty5
	 4on0ME7PWxNCEGbo5UuuErckvUkP9e+/yguisZY2vSdIToDYk9L8TK1NDT3+Ub3cBW
	 DXfONs7A6QCEdAy44KrbO+D9k1M+XP6BPoxehEsSTiUIpgaRwnHbinMCRI2fvNud3t
	 smQzCSebh+iaoDFYarLIZV/htHRfJKVAhKzz0EOvarIvxkffY+d0HsO1TxFNiLw6/i
	 86tmpnboGKchngWbl9IXBB3Ktuz4KEX7elx4kVHe+dIOSupjpy5IK9PfKln7q7VJJt
	 6deDnwNJV1gbw==
Date: Mon, 18 May 2026 16:19:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, daniel.lezcano@linaro.org,
 nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org,
 hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: notify trigger on channel read
 error in buffer ISR
Message-ID: <20260518161919.4fc7507e@jic23-huawei>
In-Reply-To: <57d1d577-39fc-47bc-b01e-a2cc1d2ebdbd@baylibre.com>
References: <20260517162346.189-1-sozdayvek@gmail.com>
	<57d1d577-39fc-47bc-b01e-a2cc1d2ebdbd@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 12:07:33 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/17/26 11:23 AM, Stepan Ionichev wrote:
> > nxp_sar_adc_isr_buffer() bails on the first channel-read failure
> > without calling iio_trigger_notify_done(), so a single I/O error
> > leaves the trigger's use_count stuck and the buffer flow wedged
> > until rebind.
> > 
> > Route the error exit through a 'done:' label that always calls
> > iio_trigger_notify_done().
> > 
> > Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> > ---
> >  drivers/iio/adc/nxp-sar-adc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> > index 9d9f2c76b..ed004812c 100644
> > --- a/drivers/iio/adc/nxp-sar-adc.c
> > +++ b/drivers/iio/adc/nxp-sar-adc.c
> > @@ -341,7 +341,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
> >  		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
> >  		if (ret < 0) {
> >  			nxp_sar_adc_read_notify(info);
> > -			return;
> > +			goto done;
> >  		}
> >  
> >  		info->buffer[i] = ret;
> > @@ -352,6 +352,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
> >  	iio_push_to_buffers_with_ts(indio_dev, info->buffer, sizeof(info->buffer),
> >  				    iio_get_time_ns(indio_dev));
> >  
> > +done:
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  }
> >    
> 
> This is fine. Although we are already duplicating the call to
> nxp_sar_adc_read_notify(). So could be OK to just call
> iio_trigger_notify_done() and return too. Let's see if anyone
> else has an opinion.

Similar questions arise for this one to the rohm one I just reviewed
- does this actually help us?  What is the trigger, and is it going to
be in a state where it will ever refire if an error occurs in here?
Here we aren't dealing in bus issues, it's a state machine issue
(either software bug or hardware in wrong state) if we hit these
error paths.

That info needs to be in the commit description and again to me this
is a hardening change rather than a fix (with need to backport etc).

Jonathan

> 

