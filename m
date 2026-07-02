Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D133E355;
	Thu,  2 Jul 2026 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022746; cv=none; b=rcm1gijphKL08jOg8FiHYmZLigy+Qc01T7FOeJiQW20y5tOyYAKn05z/P+GAFr69xvvCYx/BXYt9MMy4LB+4u3/zt/9uxu0vHik3NQ7ZYvXDb1Nh75cqeD1gzAo3YD5+wIpkhQNQO65xUpQv7pitCgV2oo84BY14BAv/Pn/Tqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022746; c=relaxed/simple;
	bh=EBoPbc48Kjr4V7+xxHen32/8XfHKt+iyrOZlSmPILls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS1eUhUd/5OjfTx7oW/JqdASD6wRIeHVd+MhW8YvDiFmdP2h9q8qJDEFuKQDBvinwXBcSrIZfNW477jTlkiKv+b+tbgQdAreQiUteljmSXcvNEaX0Ilx9R7TDdNJ+/oe4/nFlrujP8mFRPoJSATS1fsTMdlyH+pqGnNveYcrW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2zBY9mp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2zBY9mp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44311F000E9;
	Thu,  2 Jul 2026 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783022744;
	bh=YAeVXImpxmohDg2162C83eGfFj44yEiv8FbFQFUUZcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S2zBY9mpti5NV3w2+tzbeL4EFeNn7+yB+sqToKh8q7wuIyHlxaeI7so0hoSVdoeih
	 8JXuE91wI2pWjYKFaY93BwvAQ3z0C9WTgtiu1SoHVQG2IPEuQZK1D66oJX7bau2GML
	 OaLxmXZ9uvEF0RO58HThCvgRXZxAca6OTuuLVERzC2LPZu6WxG/UmdD7wyPh9KlHRK
	 bG7y7c1l9g1L7Hi7FzLQo+HoxN+eQkpKOV3551FBXr1naxu46F+Lvlkrx3557S66Zf
	 Lq6ReZ0V7r4O9+mfC2qT9Dkvm7ofYAtz0dGUAcmvXrMfJt8C55s/0yemHJvEqcRUp8
	 JIZDLm2Qa8E0A==
Date: Thu, 2 Jul 2026 21:05:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Biren Pandya <birenpandya@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Linus Walleij <linusw@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: accel: kxsd9: fix runtime PM leaks and
 unchecked returns
Message-ID: <20260702210540.226358a8@jic23-huawei>
In-Reply-To: <ajkxRQniQRqmAe46@ashevche-desk.local>
References: <20260615200330.1234-1-birenpandya@gmail.com>
	<20260621193036.78549-2-birenpandya@gmail.com>
	<ajkxRQniQRqmAe46@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 15:57:41 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jun 22, 2026 at 01:00:31AM +0530, Biren Pandya wrote:
> > The kxsd9 driver uses pm_runtime_get_sync() without checking its return
> > value, which can lead to silent failures. It also relies on manual
> > pm_runtime_put_autosuspend() calls, which is prone to leaks.
> > 
> > Specifically, kxsd9_write_raw() contains a bug where returning -EINVAL
> > bypasses the pm_runtime_put_autosuspend() call, leaving the device
> > powered on.  
> 
> ...
> 
> > void kxsd9_common_remove(struct device *dev)
> >  {
> >  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >  	struct kxsd9_state *st = iio_priv(indio_dev);
> > +	int ret;
> >  
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >  	iio_device_unregister(indio_dev);
See below. Sashiko correctly calls out this is badly broken.
Those two lines above need to be swapped - but it's a separate fix.
Given you are working on this driver, would you mind doing that as well
(credit sashiko for the report).

> > -	pm_runtime_get_sync(dev);
> > -	pm_runtime_put_noidle(dev);
> > +	ret = pm_runtime_resume_and_get(dev);
> >  	pm_runtime_disable(dev);
> > +	if (ret < 0)
> > +		return;
> > +
> >  	kxsd9_power_down(st);
> > +	pm_runtime_put_noidle(dev);
> >  }  
> 
> I am not sure this is correct change. Now, if the PM runtime fails, it leaves
> the device to be on. Is this desired behaviour?

Agreed. I'd just ignore that return value and carry on anyway.
If we hit errors in here we are in best attempt territory anyway as
there is no right way to recover.

> 

Please take a look at sashiko's feedback. Some of of it is to my mind
more important than what we have here.
https://sashiko.dev/#/patchset/20260621193036.78549-2-birenpandya%40gmail.com

