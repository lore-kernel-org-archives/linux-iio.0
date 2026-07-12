Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484D1DFDE;
	Sun, 12 Jul 2026 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783817346; cv=none; b=Z2QywbfeT8FOfyNjsK5jFbfSEAVO7Sh5ogcbx25Y5eQ4+8ec/+sNBUJUCh+/iqFRMgzym3kU2waBcxFfddTxO4RufHe2S8FF1kSPMhfzg/MzKd1IbuDQDRouWlTBTQ0dI1CDFNObo01JR863wuBRHeQHfRvONJVF6eca2noZYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783817346; c=relaxed/simple;
	bh=TiOyYuX03fqpPySQKFUrrski21o6Q/RV2EwtHx5iRmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE+4tFVBORClgyjEb1tdGYiCzD1JKWyAzNL+8oVG3DKfy1zot6C4BWyjwB7BmO30gjEFrXbawQkfSJm6dnEf6N5j/mJyMLGm35D74iPM/9hmvOxTqziHrZrOJ1Kt5igym1gB3tl5ZiyCa4iH0iTwtp68V7MEnF0+VGg/oKEVvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg/7RKf5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg/7RKf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C361F000E9;
	Sun, 12 Jul 2026 00:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783817344;
	bh=qvPucw9EqbB0Lc7KuclkR0/HWm6CyInfES1SdaO1r2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eg/7RKf5VysjynOh3iGN4EOe6m9sNeQnzSbKHZQFQE8nE4tVePP3ulzQHpzDEoRn5
	 GYLiOjbsd+5+qS/jL5EyYlSbHvvhoNwIZipUXEIlBEhx6kz3InvkBZQ+FALZIsD9rG
	 d4g9PPKmO7HXJV6+hQVuHA9qsz3Zl0MyoAZgUm0Ln25QAJnyjCxE/4gQrNZnse2D/h
	 +j9fRJSRclAr3Qay7Ee0mqkAYWcdc/S7GWxg7JnPcdpJdb7FlxBF5lHoTg+dXsikJg
	 DdusM2Y4+BJeXcHNcZF+UnAili8LKlwixpyPyqyQQ3e+pAVrJ3LRguiWBISAiD48nb
	 Pd4m+c9MSDRig==
Date: Sun, 12 Jul 2026 01:48:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad4080: configure backend data size
Message-ID: <20260712014859.1e92ee70@jic23-huawei>
In-Reply-To: <3caf5748-0da2-4f11-a0ff-d3dd5fdf339f@baylibre.com>
References: <20260623090717.3296-1-antoniu.miclaus@analog.com>
	<20260623090717.3296-3-antoniu.miclaus@analog.com>
	<3caf5748-0da2-4f11-a0ff-d3dd5fdf339f@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 18:07:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/23/26 4:07 AM, Antoniu Miclaus wrote:
> > The AXI backend needs to know the ADC word width in order to pack the
> > sample data correctly on the bus. During channel setup, program the
> > backend packet format via iio_backend_data_size_set() using the channel
> > resolution, so the data is transferred according to the device's
> > realbits.
> >   
> 
> Do we need a Fixes: tag?
Antoniu?

I'm holding this one for a tag or a reason why not.

Thanks,

Jonathan

> 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  drivers/iio/adc/ad4080.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > index 8d2953341b15..8feb0c7f7fcb 100644
> > --- a/drivers/iio/adc/ad4080.c
> > +++ b/drivers/iio/adc/ad4080.c
> > @@ -698,6 +698,11 @@ static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = iio_backend_data_size_set(st->back[ch],
> > +					st->info->channels[0].scan_type.realbits);
> > +	if (ret)
> > +		return ret;
> > +
> >  	if (!st->lvds_cnv_en)
> >  		return 0;
> >    
> 

