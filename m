Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C682737F9;
	Mon, 27 Jul 2026 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186529; cv=none; b=GKlkPfBs/SjHtwxpVwWfFr5/m66kzaebae7qG7ix7VMOCfJyiza7//yMsGUbFykuGpHQjtyoDgzyjrFgfH85YsU9xR8Xt0l3VXMVz8JRIVDen11aCQhYrq1Mr7pTEr2StMz2Ej2kM437KcHaumc26gkY1E+oM27Q0mnDk+npS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186529; c=relaxed/simple;
	bh=y8ngCDxpUW426lxABDBXEjhsOA1WeaEIgb8ocvq9zeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yf+yxuM+eHA1Yg4oXr/FK3Y73mJ6YnCaWQKxSiO6iT7LeRyvas38Ou+ACbOsGBY+QNWzHfU+9QGdOLvVUzGUduRQX3GYP7XdTGfqDtvsR6448Rc5mD7IBhtbZmbotBPeSoC+tDuwS72tyhDVb+S0c2O1Khqt2fGN6c9GQR0dUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYIaYgw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYIaYgw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BE81F000E9;
	Mon, 27 Jul 2026 21:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186527;
	bh=Y/F9qqKZ1nAVNJvbvc+eektfiB2CzIaHrqML8wuKdZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZYIaYgw3KDyzw+RGH1Iu1hVGuR/W1dP0gr97NYIoEnEX43tyscfFLmhvIfcZgOUeH
	 RwAo+8B29mgbKQqO52lryTKKA6Uj33c13MPsqie2muPHGrfjg//v8uVj3jfYlpsu/q
	 KpAXgiX7kNpURghi4uwkoZLpuiOjJlo8BG+NOStAhCrTXIJXiS4JQIEHSXYjsoCL2u
	 qAvMKjRp9z+C177aq1sSO+8zGu0Jt8dH5uafJCYLXpJh+DGfJKdGzyb7kFQ8dZ2c6v
	 QUIckLXe3z78/cgR4g2h3sprBwiXPSwdfGwhL2zAMRhEKTD5FNbapaHFGgBX7/DCKH
	 AOYjO8KhWbSjw==
Date: Mon, 27 Jul 2026 22:08:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 08/17] iio: core: add hierarchical channel
 relationships
Message-ID: <20260727220842.6f3d4b32@jic23-huawei>
In-Reply-To: <6tdoluaxt24zpkb4rrfe56lcb7ohphkbvi2klqplw7zibxy6xs@yi6m7bydrqaq>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
	<20260722-ad9910-iio-driver-v9-8-459d1df5ac56@analog.com>
	<20260725232432.7a0d4292@jic23-huawei>
	<6tdoluaxt24zpkb4rrfe56lcb7ohphkbvi2klqplw7zibxy6xs@yi6m7bydrqaq>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 10:40:55 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 25/07/26 23:24, Jonathan Cameron wrote:
> > On Wed, 22 Jul 2026 16:50:17 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add parent-child relationship between iio channels by creating a parent
> > > pointer field in iio_chan_spec struct and exposing a sysfs attribute that
> > > returns the parent channel prefix.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> > Hi Rodrigo.
> > 
> > One small thing below
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/industrialio-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/iio/iio.h         |  5 +++++
> > >  2 files changed, 45 insertions(+)
> > > 
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index aa9d6474edd9..f7e3048354b9 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -856,6 +856,22 @@ static ssize_t iio_read_channel_label(struct device *dev,
> > >  					 to_iio_dev_attr(attr)->c, buf);
> > >  }
> > >  
> > > +static ssize_t iio_read_channel_parent(struct device *dev,
> > > +				       struct device_attribute *attr,
> > > +				       char *buf)
> > > +{
> > > +	const struct iio_chan_spec *chan = to_iio_dev_attr(attr)->c->parent;
> > > +	ssize_t len;
> > > +
> > > +	len = __iio_chan_prefix_emit(dev, chan, IIO_SEPARATE, buf, PAGE_SIZE);
> > > +	if (len < 0)
> > > +		return len;
> > > +
> > > +	buf[len++] = '\n';  
> > 
> > Use sysfs_emit_at() for this rather than a direct write. I'd rather not have
> > to think about what happens if __iio_chan_prefix_emit() returns exactly
> > PAGE_SIZE().  
> 
> We can have __iio_chan_prefix_emit() called with PAGE_SIZE - 1?

That seems sensible anyway.

> 
> Filenames should be capped at 255.. so that NAME_MAX << PAGE_SIZE 

Agreed it isn't a real issue but nice to tidy up anyway.

> 
> As you suggest, we need a local buffer. Not sure we need to do an extra copy...

I'm lost. I'm only suggesting sysfs_emit_at() for the buf[len++] = '\n';
not eh more complex __iio_chan_prefix_emit() as that takes the size so
anyone reading just this snippet will assume it doesn't overflow.

Jonathan


>  
> > > +
> > > +	return len;
> > > +}
> > > +  
> 

