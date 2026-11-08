Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169722;
	b=wUpDhyu5D8SAnCqcwBD1aOu+fk94/sTL/Zb4h6y6R0icaLRsq3fEdZTweZqQra0tpNtH
	 gyo74zLCb0O5uEHFqrK9nHO1nm/pIPR59bUdmbK/LubqTB99W8qfYfWGfbtXeMqPIyviZ
	 m0BQZPiGyqvaO0TM3lQ5O7j6++GuAb6p9CTbdPhdj32jqiAJ6q7tEaoyQZw6cbhNXdbp9
	 Xgig80gyenQ6xcXvfQ7GMEUT7bUijNXlFFc7tYIj+Ce7lgGBNWRcf9LEfFfwDPGFiQBcT
	 +R+48zyAqyfpXyntsm5RS2eVPECe0Qzjn3NP8kXs9mwVgF+3Xq6IWDn5hdJTqj0tV7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169722;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HhCdlfOuWpOhqkNbDjFsY17ARD4Y/RL/GgeoNyLX1Ik=;
	b=xp9Y+gctQt7bpyPl+EM1OqO94IqAMtKzR5IWn2ZbdHTLaIJXsBYmgFiWtfqkCdVWif4/
	 50EJ7j2nIUxc8z6wxsuxjCn0DJ+v+DER6Ar/+tm2PXNKkE9CcoLc6AG3lEawIWtn6uLsI
	 stN1RoLOcrJR34J8kayg8/SxIGMqg+g5LEUYTTnNvgFyy+/+TBCxpWINz/6piNHyuQAaQ
	 q26TjLaaiU2URXTnS91Tk03G1lGMSbIBnj9ldcOFWZOKWJ7LMkEjHX3PdQEwLLpuCQtW+
	 pLORTtkoo84NuJOI1tihX5X1+E6rv2th0U1Nmj1m6+YigO/gEtRFueqFZz9Chog362w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loqMa9G1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E80606A322
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loqMa9G1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7613A1F0089F;
	Sun,  8 Nov 2026 20:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169722;
	bh=HhCdlfOuWpOhqkNbDjFsY17ARD4Y/RL/GgeoNyLX1Ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=loqMa9G1u4R1KbgW2TOk7hkMkFYSusaR4puELK9brem07mNZfGp3ifrQeAHSXWgY8
	 1mMErGvp2cizj6t6kZu8SQNQPdG5HabjSnJZceQG+in9yvln4klzlqA7caJF6OWDu3
	 dheJNfqF10T4vJ8ZkRxeUyCoZ1putzd9SnQSLgw5FT74BxZnFL4fNQn/wxyIk3FsX5
	 gU0E9mBSUq931t37WRtLDxadW0t1qbrZ9swbXBIzcM7muhqUckYs9UO2rA0uBvc8Vf
	 /eHo89yAXTxVQQYcUY7jPHeqEMhStDRLwtUAAk8bRY5f0naLcgtClWwcG6KJGx5+Q2
	 OWZgtmLH4O0rA==
Date: Sun, 8 Nov 2026 20:28:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>, Guenter Roeck
 <groeck@chromium.org>
Subject: Re: [PATCH 36/39] iio: common: cros_ec_sensors: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108202834.679f5240@jic23-hlaptop>
In-Reply-To: <auAYJyyHq0_Hdv8r@google.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-36-8b136778eedf@oss.qualcomm.com>
	<auAYJyyHq0_Hdv8r@google.com>
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

On Tue, 27 Oct 2026 03:19:03 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Mon, Oct 26, 2026 at 04:05:54PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> > at both call sites.
> > 
> > Replace the raw samples byte array with a scan struct containing the
> > channel data and an aligned timestamp, matching the layout it was
> > already manually maintaining and removing the need for the
> > CROS_EC_SAMPLE_SIZE size calculation and the casts used to access it
> > as an array of s16.
> > 
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>  
> 
> The patch looks good to me.  Just a minor note below.
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c  
> ...
> > @@ -192,19 +191,17 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
> >  	if (!iio_device_try_claim_buffer_mode(indio_dev))
> >  		return 0;
> >  
> > -	out = (s16 *)st->samples;
> > -	iio_for_each_active_channel(indio_dev, i) {
> > -		*out = data[i];
> > -		out++;
> > -	}
> > +	j = 0;
> > +	iio_for_each_active_channel(indio_dev, i)
> > +		st->scan.channels[j++] = data[i];  
> 
> This is a pre-existing issue, but there is no bounds check on `j`.  I'm
> not sure if the number of active channels can ever exceed 4.
> 
It might be a good idea to add a sanity check for that, but
job for another day.

Applied this one with the tweak that Andy requested.

Thanks,

Jonathan


