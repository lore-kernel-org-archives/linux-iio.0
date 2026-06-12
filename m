Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BCA38E8C3;
	Fri, 12 Jun 2026 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286292; cv=none; b=QeSzUcwBlaZh3Brmgkeu2qUYmlC5D0hHP6Uw6vHfNEbkf2/rboEQVCrJE4QVpYwphIFgFYtZGz84Cl6bNx6TSUAmewnUdSVVCRFLl9Lnb7mlo8G3q0EQISGjm8vywJg5fw2J9ywnFb8qhIWg8+cCI+FDFlge5Ue151L1WCwBXDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286292; c=relaxed/simple;
	bh=vMkt3r8xxEC4zTyLP/nj1AjH8MMnvnZetJTlaCvH2ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0cd7LD+OW0V9ogDfQiGfFQyQMGyiV4Eq3e/fs7Tg8QnprVI0cxC1t/uWZP4RHqJPArSTHwR9bsM51Ggdu3d5mQaRNd3P713B91QztPe2nibZ8Jo8EdfHhIYOG9olxkwSRBv1raSr9eyfC1XxtbWMufB/vK+nX2XVQ0Z4h9bqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6mp8dgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6mp8dgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1368F1F000E9;
	Fri, 12 Jun 2026 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286291;
	bh=/9huSYuQ0my0GKsr+0l57cbc554pe/WnQvStQwuz3Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N6mp8dgGDyjQZw2/W4nMs6Qmw+JTAswr9iYX9tto1LXtC74PuzMOCq+8ZPX6V1s2H
	 79ltTg0zpU4iCs3HrsVEmuXD+U3Ee//yJYipYEEGO6qWxu4PrWyRUWPg7GHgn0EYa0
	 LM4SoMVLd+4nDVAb2Scab824i0J4smye63rbfJgUNg944y7k+nR2kdS2SqJYrzUU+2
	 a4G9ndbrUiYJGSgqA4q+jQ31v2oQjXSi5PXtQ+0/Yb4yPUP4MUEK81Vs3XocjaCzQZ
	 p4TlxuYQaVA7uB4EmzyACAj5PqlwgjyQxGGgu24iB+h/RRfunyKbeoSg6+gMw356rx
	 xhsFMAVDki7Xw==
Date: Fri, 12 Jun 2026 18:44:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Siratul Islam <email@sirat.me>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: cleanup fixes for vl53l1x-i2c
Message-ID: <20260612184445.124d0119@jic23-huawei>
In-Reply-To: <aisLMs0Y5na9G-Qc@ashevche-desk.local>
References: <20260611134245.30042-1-email@sirat.me>
	<20260611134245.30042-3-email@sirat.me>
	<aisLMs0Y5na9G-Qc@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 22:23:30 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 11, 2026 at 07:42:30PM +0600, Siratul Islam wrote:
> > Extract data-ready polling into a helper, fix regmap_read_poll_timeout()
> > argument alignment, and add field definitions for BIT(0).
> > No functional changes.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> > +static int vl53l1x_wait_data_ready(struct vl53l1x_data *data)
> > +{
> > +	unsigned int val;
> > +
> > +	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
> > +	return regmap_read_poll_timeout(data->regmap,
> > +					VL53L1X_REG_GPIO__TIO_HV_STATUS,
> > +					val, (val & VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY) !=
> > +					data->gpio_polarity,  
> 
> I would put it this way
> 					val,
> 					(val & VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY) != data->gpio_polarity,
> 
> but it goes over even 100! So up to Jonathan.
It's ugly whatever we do but 100 is too fa.  This may be a case for just not aligning with the bracket.

	return regmap_read_poll_timeout(data->regmap,
		VL53L1X_REG_GPIO__TIO_HV_STATUS, val,
		(val & VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY) != data->gpio_polarity,  
		1 * USEC_PER_MSEC, 1 * USEC_PER_SEC);


or at least avoiding the mix of a full parameter and half of next one lin line.
	return regmap_read_poll_timeout(data->regmap,
					VL53L1X_REG_GPIO__TIO_HV_STATUS,
					val,
					(val & VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY) !=
					data->gpio_polarity,
					1 * USEC_PER_MSEC, 1 * USEC_PER_SEC);

I think I'd go with the first option of just not aligning after the bracket.
}  
> 

