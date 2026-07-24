Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538D4749CE;
	Fri, 24 Jul 2026 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935281; cv=none; b=VRWdZ9DKVu76JbHcrpYnwFXJb1Ywe083n0JwLeYgecWU8Jq5OSnZ7OhlCKVqzysDy91RztLNqJ9ecv2/AMl48wcliDww7uDVuhFfrdwBBvHwRlsSzvrdoF40AcVnoeRGhKormuvfJrMfNqhT4cXxQsPBU2GFtuokcic2NFbhfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935281; c=relaxed/simple;
	bh=/DxCckFtkbg3acPD18ZfcjquascEd9sb5cw+P9m3JWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHd2ljrsG2BizAyBuYrdCXsu4aM07UtVp4Wb+aghZ/AeS74eIYE4Mi5DwxwX5R9LLXf/aBhAzvhkxdk3Rzrr+tGlHy2J3vhyUfkZmYqi+S+3wT9FuVs3stAnpeJMMiq5LD2btnmu2G2tnI3mPoGgl9jIDSmTjAJ3r/cTVsT0p58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVBDsJ84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVBDsJ84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896511F000E9;
	Fri, 24 Jul 2026 23:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935280;
	bh=kLBp8kNS0MYTTovPxekE/mk16+79w5L2SmR8pYljKfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oVBDsJ84S7XjWh+dYt/oRXJ7v7bqVKQWlJNhW6r0EX7YbZCpNfOe+6wjMKfc7yvmP
	 PADJrfZlYRfdL7dHhCPQs06beCeG37N5Nnqc+CXLltkBkuHSOfeEGXpCRtDy9hSgjq
	 mRqn3gagiPDHlJ2NcvYQarAN7rm2hc5oIqs0sx+oHeCkNfmOglCBFaWE8vIJ5b9rZs
	 44Br3pgyP1PjaghtZG1bBmuJ7Wt0WTTqmKJ9+kz64s1etwGTuIzqqCUEn2lGFHXVaT
	 /tdWI/zMcOZG/vee/KczpldXJc27bUFMC4suT+vBWrDs+tFtz7ekOUC2EIhXQ+CNjO
	 E7Ka7HkSZ/7AQ==
Date: Sat, 25 Jul 2026 00:21:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Andreas Brauchli <a.brauchli@elementarea.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sgp30: Handle IAQ thread creation
 failure
Message-ID: <20260725002115.4e263db2@jic23-huawei>
In-Reply-To: <20260722145218.000030cc@gmail.com>
References: <20260722074837.2258269-1-lilinmao@kylinos.cn>
	<20260722145218.000030cc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 14:52:18 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 22 Jul 2026 15:48:37 +0800
> Linmao Li <lilinmao@kylinos.cn> wrote:
> 
> > kthread_run() can fail and return an error pointer, but sgp_probe() stores
> > it and returns success, so the device is registered without its IAQ thread
> > and sgp_remove() later passes the error pointer to kthread_stop(). Return
> > the error from probe instead.
> > 
> > Fixes: ce514124161a ("iio: chemical: sgp30: Support Sensirion SGP30/SGPC3 sensors")
> > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> > ---
> >  drivers/iio/chemical/sgp30.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> > index f10bbebc29e4..379c1c4af8d8 100644
> > --- a/drivers/iio/chemical/sgp30.c
> > +++ b/drivers/iio/chemical/sgp30.c
> > @@ -548,6 +548,9 @@ static int sgp_probe(struct i2c_client *client)
> >  
> >  	data->iaq_thread = kthread_run(sgp_iaq_threadfn, data,
> >  				       "%s-iaq", data->client->name);
> > +	if (IS_ERR(data->iaq_thread))
> > +		return dev_err_probe(dev, PTR_ERR(data->iaq_thread),
> > +				     "failed to start IAQ thread\n");
> >  
> >  	return 0;
> >  }  
> 
> Good catch! This should also be marked for stable, perhaps Jonathan
> can do that while applying.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
I'm not going to rush this one in, so applied to the testing branch
of iio.git and marked for stable so it will make it to stable
releases eventually.

Thanks,

Jonathan


