Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF512BD59C;
	Sun, 30 Aug 2026 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788130691; cv=none; b=mvRcMXwwC2Vdm1NnadDnulEL16odSbU40I0nyNXgRw1OXs1EEndPhX4GEz4mFKysQTicZ2tCBiohaQjonZm74O28Aw8tQMp9+qGypCSYBFeFpzlal8S1HVWWp93sSEqoURBbVa4IDNotBgkKuY7vb6alrVrDB+zTUj87cwhwllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788130691; c=relaxed/simple;
	bh=Z9wSdY1Ut1U4xA+RxXXrWYFkdj8jsDd96ubg9xgitpc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CHiqw7JVoZb/AxCWjpsRorrUVMEs4kSNx1IrvSXX8g5LInbWh5EomEJKSkRHBS/3va7CPdJhXGzzIdg6x+3L4u+VTK5oChS2m0m2ii+5hK8oGUWwtL/wvW1p3ONfbyu2pqSIpmKPIJMu0BKBignx7CkRGyLLsURY8cWudaOWmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajJjn4gM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajJjn4gM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655F41F000E9;
	Sun, 30 Aug 2026 22:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788130690;
	bh=2khFgKx/iad1hxKhJWUmjRa045gAjR+aj8dqQvOJNO8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ajJjn4gMy4JaCwxM5AYDJnW1rJqRw1AtHrXqPJcCTytJYEaLO9IGXKJfYJqwXikqM
	 qSSG40TYJN6xQ3Yxc4AQZL4fGIguPbyaub5xdjlbIQKQdO9wamEy8+JMulotYDwOni
	 oHqHyhtExOTJsbW9GpR3AckKE/Wnm7mnMXkhZ8atfvvcjjYafg3pDCNUDwmbWpp7sf
	 ltdXMOTnjPh7I8kaDKQIOisi1lqcxO58ocWHd/tsACZWofrVZ5TbJIbRGuCoTgjdS0
	 dPYYMslDl1gF/j/CK4QWSFceT7VchsZ0PHD/DycKNDCH+QwAi7Z5VOzu9+3dUdcgPt
	 B3O4nn2TofBcQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 6/8] iio: adc: ti-ads1015: Convert to managed
 resources
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Archit Anant <architanant5@gmail.com>, jic23@kernel.org, 
 dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com, 
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <apCP7TkGVZ3I4jFO@ashevche-desk.local>
References: <20260827172100.39176-1-architanant5@gmail.com>
 <20260827172100.39176-7-architanant5@gmail.com>
 <apCP7TkGVZ3I4jFO@ashevche-desk.local>
Date: Sun, 30 Aug 2026 23:57:56 +0100
Message-Id: <178813067693.2788519.14185731509268102204.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z9wSdY1Ut1U4xA+RxXXrWYFkdj8jsDd96ubg9xgitpc=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlLV1kuFn5RKeM1SgrxarXFckNpRSZFjk3+Jpq
 RJQ3Izip+CJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapS1dREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiEPgD/4rgr9H1WzItYeFdctPuiD5MVcqmdCaunGCkrFDulwL9Jx
 Vr9Rb35zkL4s2jgYXOv/RYRvFlLFdJ7faD7roGLuwYQYod5XmY1X6nwAZz1X1x6/6r6ttJ1Jzpr
 plzSPxCEt7nppRAmsYuHrn8Arb/2QieYun83G4R2tfNeW5o1O4nu6b9LJteqk/DyEcOTof5hSAm
 srvuJYzQrjDErYkmtugPCp8t4exJW5AkPKEy2Eqft9dpbU4mxkR4tS9sM0SSYafCO9W3LNh6MUW
 BnlYbX5wnj0GOdsb9oGzCaZnBbtU9BHyl3VgKng7+HNFzql2wF1VuaZ2XQcayXwWrcWTG37V5Ml
 NoKFSVHuwiWqLTFO1Rr3UDpCbW9VmNzmBqfd+Rkf4TtNxxCUwT7gweZOHgjM8m/TMkz/0+pu9AL
 Ta81vGi5Rsyj3qlR0TEY87W6B+e/q6koeYvnVYwM6X9QcCRv92lvC4mUMVk93kzMUged7Jg2pih
 icy4DLSlnxRpBBp/qwQoE9DTng0yrda9VzNMZLelV5ZKxl2FxYFa9wWpC6+0E57KGf7+VnrHjyq
 bgH3J6ioL9UU+PUeuFuOM9w7QLzW2HpD/pPB/lDmE/PU30bItQv14APiHWSQok4ZxtNQQnzC/0W
 AJ96JTXUH3ulKj6O80531QTE9RuhH0ewvfap4ow==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

On 2026-08-27 22:28:45+03:00, Andy Shevchenko wrote:
> On Thu, Aug 27, 2026 at 10:50:58PM +0530, Archit Anant wrote:
> 
> > Use managed resource helpers for the mutex and runtime PM setup.
> > 
> > Replace mutex_init() with devm_mutex_init() and replace the separate
> > pm_runtime_set_active() and devm_pm_runtime_enable() calls with
> > devm_pm_runtime_set_active_enabled().
> > 
> > This simplifies resource management and ensures resources are
> > automatically cleaned up on probe failure and device removal.
> 
> ...
> 
> >  	data = iio_priv(indio_dev);
> >  	i2c_set_clientdata(client, indio_dev);
> >  
> > -	mutex_init(&data->lock);
> > +	ret = devm_mutex_init(dev, &data->lock);
> > +	if (ret)
> > +		return ret;
> 
> This part is good and maybe introduced in a separate commit (depends on the
> resolution for the below).
> 
> ...
> 
> > -	ret = pm_runtime_set_active(dev);
> > -	if (ret)
> > -		return ret;
> >  	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
> >  	pm_runtime_use_autosuspend(dev);
> > -	ret = devm_pm_runtime_enable(dev);
> > +	ret = devm_pm_runtime_set_active_enabled(dev);
> >  	if (ret)
> >  		return ret;
> 
> This should be done with care. There were some changes lately that actually
> moved from devm_*() back to regular calls due to some races in runtime PM.

In particular here, the patch description needs to say what this
changes.  It is not a noop change.

I'm not saying it is wrong, but I would do it in a seperate patch
where you can clearly talk about what changes as a result of this
and what affect that can be expected to have.

Jonathan

