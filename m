Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75E3A3826;
	Wed, 20 May 2026 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279801; cv=none; b=YE5t38RralLTjyUm5066PB2xPAq+IQBTJfqCzfDV/13VbqI5AEw9MZU9azPXenAKlnMFlIQ5PBffEfDtMqD0YycvIirKVndYIN76WW1oMdunInOuzbEvO9NQ0yaaimxyrVVzGfDJVbDgL5srPldudp5h/26k4dczbShrvFinIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279801; c=relaxed/simple;
	bh=65GCmGHg32Tqq0NVP4hXIwSAH6YSIHyfOVK7i7Ty3zA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfCJ1Ws0cmMYl+uSRaxmmmx4ZmGOSxXy/Gq4QM782fryJWhVYsW2wVqzitq35c9N6QDJLYlsnzzPrPA56rmOwujVQy24IMN3tv4hezmZ3AfOAqo30HGcnn0BPN0alq2vYsXcgys6TC5i9EWkxp4W4gE7Fz+0R+E4NxvBRlwoA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OivKzZX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OivKzZX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACDC1F000E9;
	Wed, 20 May 2026 12:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779279799;
	bh=RJjCC9pEOnHE/hKjtUIx61IqbtK8HGknnmzYVlwzcik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OivKzZX8sYCpxcI9vsoDB0XA7aOyoPQ+22b93GO6WZJ0XG4a7N7mIyglEdYWGEIQ4
	 SSS7lB9lMMZMfV2xsohDk17q+ejj3KjmzNwXEMWSlvlbhY7dQmtxxeykaW6r/zEpEw
	 jojwTdXKUMpHwje8iLjlLljKzMtdFIMn7eEuJd7QYxMIAd1uOreZjOVUld6lztpEO3
	 1MY78b/sJRGLbezObX0/uB+uqKST4eMFD6JSd/SitiiumwguN93IFPDHzyxAhjLWAT
	 4ttsDdfBsh/g3Rxir+IUy3l+asW7y5SUlb1gTz8zPQZQK4awbl+75vK0+Gk5yvD90B
	 DkitFDo+v1GUQ==
Date: Wed, 20 May 2026 13:23:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Uwe Kleine
 =?UTF-8?B?S8O2bmln?= <u.kleine-koenig@baylibre.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: ad_sigma_delta: fix
 clear_pending_event for registerless devices
Message-ID: <20260520132311.0f551943@jic23-huawei>
In-Reply-To: <LV9PR03MB84140C8048A51E50F241EA28F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260518-ad_sigma_delta-fix-v3-0-a2a92b0c36f3@analog.com>
	<20260518-ad_sigma_delta-fix-v3-2-a2a92b0c36f3@analog.com>
	<LV9PR03MB84140C8048A51E50F241EA28F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 12:55:33 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> Hi everyone, I am responding to Sashiko's review here:
> 
> > -----Original Message-----
> > From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> > Sent: Monday, May 18, 2026 12:59 PM  
> 
> ...
> 
> > +	} else if (sigma_delta->info->has_registers) {
> >  		unsigned int status_reg;
> > 
> >  		ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1,
> > &status_reg);
> > @@ -274,6 +279,8 @@ static int ad_sigma_delta_clear_pending_event(struct
> > ad_sigma_delta *sigma_delta
> >  			return ret;
> > 
> >  		pending_event = !(status_reg & AD_SD_REG_STATUS_RDY);
> > +	} else {
> > +		return 0;
> >  	}  
> 
> He is right about this one, the heap corruption may not be fully solved as a
> registerless device with num_resetclks = 0 confiugred with rdy-gpios could
> still have data_read_len = 0 further if GPIO indicates a pending event.
> 
> Perhaps I data_read_len == 0 should indeed be checked before attempting the
> dummy SPI transfer as suggested, right?
Indeed seems valid.   Make sure to leave some comments around on the
'why' of the extra check

> 
> > 
> >  	if (!pending_event)
> > @@ -578,6 +585,7 @@ static int ad_sd_buffer_postenable(struct iio_dev
> > *indio_dev)
> > 
> >  err_unlock:
> >  	sigma_delta->keep_cs_asserted = false;
> > +	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);  
> 
> Also right about this one, it belongs in previous patch...
> 
> >  	sigma_delta->bus_locked = false;
> >  	spi_bus_unlock(sigma_delta->spi->controller);
> >  	spi_unoptimize_message(&sigma_delta->sample_msg);
> > 
> > --
> > 2.43.0
> >   
> 

