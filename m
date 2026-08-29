Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EE4398FD;
	Sat, 29 Aug 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788047318; cv=none; b=nXOEg1e4FIQodbnBD0pcg8Gv6TF0gkqLy9bihuhx0dt73hiDTJUxU/LdaiGh8KwwULZU9/s2gY5CtcoFsKWZmfnpS+hQiiTELabb6rvw/TbIhELm2tEtyge8yI7nRr/YmjoNRnjd3fy6BMDSN1mEZc9V7bKoRxvQnUTe28nTKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788047318; c=relaxed/simple;
	bh=BZNMXodnRPnijnQCG7TktPuaaXski6AuhLZmiWfeK7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYZS20kf7FaTdzUXuMwtbBYf+/BxBYPOtqSMle9qK6JYSy0xkyrK5LAKUxYWFbpcF/HtC1Z6oKFVWMiTdfGYvweULfVYIt/+VbNCmxb625J1fcijkiN+UqjPnCivp30AG9V2AG2d8Umu5I2RVr7ys/380EBqeyvcI2Z2BAYkjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR9vDmfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR9vDmfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F87D1F000E9;
	Sat, 29 Aug 2026 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788047317;
	bh=CzfSHF7h5RjL0+eRPLgpm3xRv4votq18WCdd9uzCzuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nR9vDmfh1qsxbC7OoUQEAaFJGMV6fpFNmZD02tP9yqG781Z+ZvMuS4zqKqtzDpKRb
	 L3ARsMaQnhwlmH6YChhg7sGRfBSjbz3u6KQ7BBGKVJeOeI/RwMbV1TeyEDhGRv6N1X
	 stGUHxXUq46QFVRMkdy63rllEu4iDbkgtIt0R3DreeEUtN7JzYM3eXYiqZzCA6ytxO
	 w58Bsrn1tCsAcqdXYtKzDJoK034kBSVQCSNDQ0yJFfHcMiqEvXciTKAxddLOsed/8Z
	 W0JWRnTKow3dkzsrVd7tdWp8Z4i/gGlbRj/C5+qxIQFghie1WWwttkMYEZ0B5eks6i
	 LltGVsXlhkULg==
Date: Sun, 30 Aug 2026 00:48:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Cong Nguyen <congnt264@gmail.com>, Matt Ranostay <mranostay@gmail.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: pulsedlight: fix iio_device left
 registered on PM setup failure
Message-ID: <20260830004832.357df308@jic23-huawei>
In-Reply-To: <20260829183443.3b5ac19f@systembl0wer>
References: <20260828105909.2425439-1-congnt264@gmail.com>
	<20260829183443.3b5ac19f@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Aug 2026 18:34:43 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 28 Aug 2026 17:59:09 +0700
> Cong Nguyen <congnt264@gmail.com> wrote:
> 
> > pm_runtime_set_active() failing in probe() jumps to error_unreg_buffer,
> > which only calls iio_triggered_buffer_cleanup() -- it does not undo the
> > iio_device_register() that already succeeded a few lines above. probe()
> > then returns the error, the devm-managed indio_dev is freed, but the
> > iio core still has it registered: the sysfs/chardev nodes stay live and
> > point at freed memory.
> > 
> > Add an error_unreg_dev label that unregisters the iio device before
> > falling through to the existing buffer cleanup, mirroring the teardown
> > order already used in lidar_remove().
> > 
> > Fixes: 4ac4e086fd8c ("iio: pulsedlight-lidar-lite: add runtime PM")
> > Assisted-by: Claude:claude-opus-4
> > Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> > ---
> >  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > index 400477b4c740..8a9ee21f2bf6 100644
> > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > @@ -294,12 +294,14 @@ static int lidar_probe(struct i2c_client *client)
> >  
> >  	ret = pm_runtime_set_active(&client->dev);
> >  	if (ret)
> > -		goto error_unreg_buffer;
> > +		goto error_unreg_dev;
> >  	pm_runtime_enable(&client->dev);
> >  	pm_runtime_idle(&client->dev);
> >  
> >  	return 0;  
> 
> Hmm, you should just return iio_device_register() here instead of 0,
> as that should always be the last function called in any *_probe()
> function.
> 
> No need to add a new label then.
Lets keep this fix minimal.  Agreed that it gets interesting
if runtime pm is enabled only after the userspace interfaces
are exposed, but we'd need to find if there is actual bug to
'fix' it as opposed to moving to a easier to understand flow.

So applied this one to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> > +error_unreg_dev:
> > +	iio_device_unregister(indio_dev);
> >  error_unreg_buffer:
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >    
> 

