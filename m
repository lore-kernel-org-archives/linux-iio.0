Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609C3E5566;
	Fri, 24 Apr 2026 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051231; cv=none; b=RUBjvJcwfpwuA59LVblUrxVC7CMJoJqTH4KgdvL33FF5dON9Km1moAkx5tLiPbuq4fq1YDXJjHCTbt6XstNk0Pi/44FhzEg7QvXw9N1hNpNLesyfb8/wvD7H68eNagwMsiRYUlPQjBHmFT5SAwIozEI79Z8/CnsTANBj9amJ6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051231; c=relaxed/simple;
	bh=VpGQ5+eDSxARmjhPnjzLGAnB119nK8mB44M5U0+/Zd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q44Jo1hrEwzK73QnYtJRm6p6v2aty0Z/QY6tq0jX4AHRoUkUVUO42cgkPW+yhTtJsFH2i6hsS0/oh/B4tLHEXEGIH1Uj2VOjQlxa/PRI4csN00ktHgE5gT1Ph8COYOnx1gpGEdIC7PlxC2fyuRybJK5QCw87G48HZKftguzFy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECYIijyQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECYIijyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3197BC19425;
	Fri, 24 Apr 2026 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051231;
	bh=VpGQ5+eDSxARmjhPnjzLGAnB119nK8mB44M5U0+/Zd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ECYIijyQV8yrsOeT11w/i/CyYmZgM8zxjjx3uXjYqWyUNkEHOJM8g5PhEyu56dL0a
	 +HedC9E8E8Ma6cuP9EDVKJZ2EXRZ8BI+l5ZBQ3fHuYOHEN6vmZ6SrWA7Qer2yfhBZL
	 Nq7Hk4XK2Fqb6ANmQ15Q+uCgE8xsebreg6qF+/ggVF7aYXP3ecbxhN4qzfLZrVvzS9
	 ihsQZoTkUskrVPVlG87QaCjnUyq2H6ZgZpsWG3X4wU9yQprWvQ9IWZZRcSfRDSych6
	 Pi7LFFmB+s3FkCfhSeAPW3F+kdP6wp22gkCz/ovzRl4BDJ5cRCn6LLU8AEZnX0BBRX
	 04atijSiBzsWg==
Date: Fri, 24 Apr 2026 18:20:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: accel: mma8452: use local struct device
Message-ID: <20260424182023.71fe69af@jic23-huawei>
In-Reply-To: <aekjBaFT8xvM64zh@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
	<20260422165643.2148195-4-sanjayembedded@gmail.com>
	<aekjBaFT8xvM64zh@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 22:35:33 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 22, 2026 at 10:26:40PM +0530, Sanjay Chitroda wrote:
> 
> > Introduce a local struct device pointer derived from &client->dev.
> > This avoids repeated &client->dev usage and improves readability.  
> 
> ...
> 
> > static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
> >  {
> >  #ifdef CONFIG_PM  
> 
> So, this seems to be a missed in the PM patch.

Get rid of this function as part of that cleanup. Having the runtime pm calls
inline is going to be cleaner.

> 
> >  	int ret;
> > +	struct device *dev = &client->dev;  
> 
> Keep it in reversed xmas tree order.
> 
> >  	if (on)
> > -		ret = pm_runtime_resume_and_get(&client->dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> >  	else
> > -		ret = pm_runtime_put_autosuspend(&client->dev);
> > +		ret = pm_runtime_put_autosuspend(dev);
> >  	if (ret < 0) {
> > -		dev_err(&client->dev,
> > +		dev_err(dev,
> >  			"failed to change power state to %d\n", on);
> >  
> >  		return ret;  
> 
> >  }  
> 
> ...
> 
> >  static int mma8452_probe(struct i2c_client *client)
> >  {
> >  	struct mma8452_data *data;
> > +	struct device *dev = &client->dev;  
> 
> Same here, reversed xmas tree order.
> 
> >  	struct iio_dev *indio_dev;
> >  	int ret;  
> 
> ...
> 
> >  	data->chip_info = i2c_get_match_data(client);
> >  	if (!data->chip_info)
> > -		return dev_err_probe(&client->dev, -ENODEV,
> > +		return dev_err_probe(dev, -ENODEV,
> >  				     "unknown device model\n");  
> 
> Now it's a single line.
> 
> ...
> 
> >  	ret = regulator_enable(data->vdd_reg);
> >  	if (ret) {
> > -		dev_err(&client->dev, "failed to enable VDD regulator!\n");
> > +		dev_err(dev, "failed to enable VDD regulator!\n");
> >  		return ret;  
> 
> Convert this to dev_err_probe() before doing this patch. In that patch you
> introduce temporary dev variable already. Here will use in the other places.
> 
> >  	}
> >  
> >  	ret = regulator_enable(data->vddio_reg);
> >  	if (ret) {
> > -		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
> > +		dev_err(dev, "failed to enable VDDIO regulator!\n");
> >  		goto disable_regulator_vdd;  
> 
> Ditto.
> 
> >  	}  
> 
> ...
> 
> > +	pm_runtime_set_autosuspend_delay(dev,
> >  					 MMA8452_AUTO_SUSPEND_DELAY_MS);  
> 
> Now a single line.
> 

