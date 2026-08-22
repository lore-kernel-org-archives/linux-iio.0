Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4F482D4;
	Sat, 22 Aug 2026 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365220; cv=none; b=c3HcFlrd0gBNwFGGsie1Zi1+avICWq6mGtjOOAuetQd/9wEGvfKxyVjmcUmKRUo4BfSE83F0WowwxHRqqXz8gMtR1I12Fr6a2t/O8mKdqUbQJpRRbUgz6yaG1bj98ZT4ekoxWbH2C6AFSa/35HMHAniNuWcrWxHq+zb4I1HrI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365220; c=relaxed/simple;
	bh=pDpzKPhy5CyB5AjMrUbmxWXMKOjC0SfvwPv59aYoB6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHJ1RjIhOKC0ZesagCYS+xWbx88PmVkJvVpOBCKIHEwE7fgWaUpf/vJIEsKjS/9m74WH0sMh/1fmHZAzSMe6dQJi+mxgcX/S+cP3OxQ4ywmCKsuHvsR58tkEPz67PEkDLQVXOdZ6tuNoqYV7V6gN2u9pTAcEoHFuNU+IFryfjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDQQS3CS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDQQS3CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148F51F000E9;
	Sat, 22 Aug 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787365218;
	bh=tjB82S784fbDMFRoh33no+EsSh9WbPRsDDhxA31zn28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YDQQS3CSCVdh8gZ+8ojU7s99nBfzGGRoKGvx/CI1w6LGRzrDWOLa4zrwHdMQ4XBT/
	 nleZb33kTIsLif99POzuCWE1jsRUgiU6CMhMuaxG9vktb3zU98FeDUS08jEDDHAQ8G
	 ycCfVPqjMAzFzQbV+gII1nOt5zpW4CXGyNjDOp86GVdQcIcqvj/OhIoJqdgGxCJggD
	 cLHZJ0vpUwlA1e56oiCXJ/belqD0zA2zTvh7Gmg4G5wx52iwDQv1mnvYEe4A1ijnKy
	 85i0Vqy8xnm4yQ4J5kiqD0BfYeTOUvnWkRWL7oOVX6PLAeQRlR4kv1LrzageMK8o+w
	 7YqXyR9228sHw==
Date: Sat, 22 Aug 2026 03:20:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v10 1/2] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <20260822032014.3d4607dd@jic23-huawei>
In-Reply-To: <aoK4FXvkPT45RsIV@ashevche-desk.local>
References: <cover.1786661484.git.marcelo.schmitt@analog.com>
	<8b0d2e34163b85634266be3b9dd8f76697c89bd2.1786661484.git.marcelo.schmitt@analog.com>
	<aoK4FXvkPT45RsIV@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 10:28:21 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Aug 13, 2026 at 08:05:07PM -0300, Marcelo Schmitt wrote:
> > LTC2338-18 is similar to LTC2378-18, differentiating from the already
> > supported part mainly on the embedment of an internal voltage reference and
> > addition of a resistor divider network connected to the input signal path.
> > Extend the device driver, handling the internal reference and input signal
> > attenuation, enabling it to also support LTC2338-18.  
> 
> LGTM now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Ah. I applied the earlier version fixing up at least comments it seems.
(Not that I've completely forgotten doing so!)

Can you please check if there is anything different we can handle
as a follow on patch?

Thanks,

Jonathan

> 
> ...
> 
> > -	case IIO_CHAN_INFO_SCALE:
> > +	case IIO_CHAN_INFO_SCALE: {
> > +		struct u32_fract fract = st->info->internal_div;  
> 
> + blank line
> 
> >  		*val = st->ref_uV / MILLI;
> > +		if (fract.numerator && fract.denominator)
> > +			*val = mult_frac(*val, fract.numerator, fract.denominator);  
> 
> He-he, I have a local patch to add mult_fract() macro for this kind of cases :-)
> Perhaps need to submit it at some point...
> 

