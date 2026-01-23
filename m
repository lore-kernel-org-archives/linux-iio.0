Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737D2951B3;
	Fri, 23 Jan 2026 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186839; cv=none; b=ohcYtKDBBxdxJLM4Wrxsf7EkMf5WJZjNoRpyHuY5i8aROjc5TRMDf2SdgVD+q0fsZM3pKHhnY7CcJMRIrVajuRAvEq/gIDviZhZ2LgHIi5wnBICSo+zLUIx/MfVl2h8AE4eGaqD5SU3YIBzNvkZGRoEECgWU6UiOwMf1yplSlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186839; c=relaxed/simple;
	bh=vEOQ+AWR+7escZL2OQZG4gWGiuRQAc+cXi54ovZbxF0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H02ZHy+NBc6BY+Ytcu3TM/PdLnamBQLQpINGRiVLXqrPnUg7meMcxJ/bZppb+Xf6JFNisqb/Xb7DHwJk82Y7De0k6bHLlkdU+1njVUprJ237G9aeVM2h2eL86c/UMHGokOocELFjMcx48qkD1Y/Wu3RepD37mjRb2nAm+GuMrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyP2z48m0zHnGhl;
	Sat, 24 Jan 2026 00:46:35 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E40240570;
	Sat, 24 Jan 2026 00:47:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 16:47:12 +0000
Date: Fri, 23 Jan 2026 16:47:11 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>, "Thomas
 Gleixner" <tglx@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Puranjay Mohan
	<puranjay@kernel.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt
	<marcelo.schmitt@analog.com>, Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, "Gustavo Silva" <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <20260123164711.0000379c@huawei.com>
In-Reply-To: <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
	<20260123113708.416727-19-bigeasy@linutronix.de>
	<aXOKVqxyhQ10l9V4@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)


> > +++ b/drivers/iio/accel/adxl372.c  
> 
> > +		ret = devm_request_irq(dev, st->irq,
> > +				       iio_trigger_generic_data_rdy_poll,
> > +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> > +				       indio_dev->name, st->dready_trig);
> >  		if (ret < 0)
> >  			return ret;  
> 
> Interestingly that this driver ignores the flags from firmware... Seems to me
> like a bug (not in your patch, obviously). Ditto for other drivers doing similar
> things.
> 

It's indeed a bug but one of those historic ones we can't fix without
high risk of regressions :(


> ...
> 
> > --- a/drivers/iio/pressure/dlhl60d.c
> > +++ b/drivers/iio/pressure/dlhl60d.c
> > @@ -306,9 +306,9 @@ static int dlh_probe(struct i2c_client *client)
> >  	indio_dev->num_channels = ARRAY_SIZE(dlh_channels);
> >  
> >  	if (client->irq > 0) {
> > -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > -			dlh_interrupt, NULL,
> > -			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > +		ret = devm_request_irq(&client->dev, client->irq,
> > +				       dlh_interrupt,  
> 
> Joined to the previous line it gives exactly 80 characters, which is allowed.
> 
> > +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> >  			st->info->name, indio_dev);  
> 
> Forgot to indent.
> 
> ...
> 
> > +		ret = devm_request_irq(&client->dev, client->irq,
> > +				       iio_trigger_generic_data_rdy_poll,
> > +				       IRQF_NO_THREAD, "tmp006_irq",
> > +				       data->drdy_trig);
> >  		if (ret < 0)
> >  			return ret;  
> 
> Jonathan et al., this seems to me like a duplication from one to another
> driver. Can't we do like a helper for it, so we don't change it each time
> the IRQ core or other things got changed?

I'm not sure what the helper would include that would shorten things much:
could hide two params, but need a longer name and that's going to be
hard to find.  So maybe...

J
> 

