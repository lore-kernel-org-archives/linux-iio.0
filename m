Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF71946DA;
	Sat, 16 May 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949243; cv=none; b=MQbM4SNbM73OSCy5ggA6jRbfc+fSnBy+bONtArSo2QaA+isvBlKDxcZgzj9zmmwD1prisdoGl3MiVtokSjlMq9O8fxLds/AF3ATIieC2NDJWpGK5K4QkX/OOsyJBhXQ4Q1RRsOJ1F1Fm8tizxuRM/n8AeYsMXOpo0ChGNYYKTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949243; c=relaxed/simple;
	bh=Kpr7V2i7nKXOLOtgE98qxBwEuxcGJfeeRqEWxOTgUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYb8jkOJQINMYCIc4KCWDDTNEHo5gZc+ay0PBr4QLWBNRw0zG+HGD6PwtU5V0lzV8S6ekPF1vp7pm5Vhs0V1DeuHfDqBqdcCCMkiqd4mSnKemhjlKeAJjMQUlYpFi0YwPUWgZ7c2CSxJJhi7gK7jp8kdWhhwLD46Ks+5XbNjv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhak2pWp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhak2pWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527A2C19425;
	Sat, 16 May 2026 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778949243;
	bh=Kpr7V2i7nKXOLOtgE98qxBwEuxcGJfeeRqEWxOTgUYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jhak2pWp0IFD4COsY9nhit3DoyPCMGv2dDah1XcGNz7VCss4X7AYg6t2HiNgBOcsH
	 L39smlF9sO3WI1/tBj1CwJa98xoxk0Tkg8rqAtTkmrhAEtUYM/NpTgI/i1jHFlG/Gk
	 pDB6Gk/QMycvRMGdGMuHGA3QNVjBJ5CopoczCb18UmOU1JI4nLtFj1qk0gUj9nMDZe
	 iUIBnfsdom8khs3r31nJ/OvSxYgKwuzvNcals/eV9R/hnSUdx5+PTLb2g+2QPX/Xzl
	 Jez9Zp5jt1K8ZT0btQiyAjQu0jjt1E9P5XZ9xm6rdQGzDuhjJkAza55omdLk7S/FON
	 Y49AlGjPddo8A==
Date: Sat, 16 May 2026 17:33:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, songqiang1304521@gmail.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: vl53l0x: notify trigger and clear
 IRQ on error paths
Message-ID: <20260516173354.12218543@jic23-huawei>
In-Reply-To: <827b665d-7341-4ec8-b00e-11d5a7f9cf07@baylibre.com>
References: <20260514143711.23648-1-sozdayvek@gmail.com>
	<827b665d-7341-4ec8-b00e-11d5a7f9cf07@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 10:38:02 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/14/26 9:37 AM, Stepan Ionichev wrote:
> > vl53l0x_trigger_handler() returns directly on the I2C read failure
> > paths without calling iio_trigger_notify_done() or vl53l0x_clear_irq().
> > 
> > A single transient i2c_smbus_read_i2c_block_data() failure (negative
> > errno or a short read) therefore leaves two pieces of state behind:
> > 
> >   - iio_trigger_notify_done() never decrements the trigger's use_count,
> >     so iio_trigger_poll_nested() silently drops further dispatches
> >     (see industrialio-trigger.c, the !atomic_read(&trig->use_count)
> >     guard);
> >   - vl53l0x_clear_irq() never writes SYSTEM_INTERRUPT_CLEAR, so the
> >     chip keeps the DRDY interrupt asserted.
> > 
> > The sensor's buffer mode stays wedged from then on, recoverable only
> > by re-binding the driver. The sibling driver vl53l1x-i2c.c handles
> > exactly the same case correctly by jumping to a "notify_and_clear_irq"
> > label that always calls both helpers; mirror that here.
> > 
> > The bogus negative-int return value cast to irqreturn_t also goes
> > away as a side effect.
> > 
> > Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
> > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> > ---
> > v2:
> > - Drop the cited error-path code from the commit body; the diff
> >   already shows it (per Andy)
> > 
> >  drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> > index ad3e46d47..7acb94acc 100644
> > --- a/drivers/iio/proximity/vl53l0x-i2c.c
> > +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> > @@ -87,15 +87,14 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
> >  	ret = i2c_smbus_read_i2c_block_data(data->client,
> >  					VL_REG_RESULT_RANGE_STATUS,
> >  					sizeof(buffer), buffer);
> > -	if (ret < 0)
> > -		return ret;
> > -	else if (ret != 12)
> > -		return -EREMOTEIO;
> > +	if (ret < 0 || ret != 12)
> 
> This can just be ret != 12.
Doh. I missed that completely.  Tweaked.

> 
> > +		goto done;
> >  
> >  	scan.chan = get_unaligned_be16(&buffer[10]);
> >  	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> >  				    iio_get_time_ns(indio_dev));
> >  
> > +done:
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  	vl53l0x_clear_irq(data);
> >  
> 

