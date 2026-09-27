Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0381724
	for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531726; cv=none; b=mdJUee8LkGUaP9K3PlZGeyw8XWh33ItWgrgbNf17dJ6R3YrScJOuYcvdWLujQyowPikvCr/q37u23nZPjuUxmrqheDl4XGhsTwn0T38k2Il49Zs07yC2xW2nK2sYTqNH0L+3KCP6EtCV3Uxh7pigoC+Yo94kaVketABF6m2tnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531726; c=relaxed/simple;
	bh=s6FZYmulgvomkdY9Fcfdj3azSZv7XguaNTjdt7XQ080=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pqe18cxkBQnGCiaDFRl2I+VgA3dDEIvGGwXe7D3DbF0VGvlc61u3CgEoT5sI3MpABr5T4+Ay4Nc/LE8umW/5JnUhkIh3KMxLhpXIJSWriL3ihRccDTgZQb/ToFXT2pc6B4YwYZ+pNeO65L6Brq7kSlP9+yKEEHfsgHFZX1WzW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIyidMYx; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIyidMYx"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so775771f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531723; x=1791136523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nKitTAlwTBExXI+cI2+8578Ap+v+wKyXIoUr5i+JPl8=;
        b=qIyidMYxGa5GI2DCovSSGiYtkNlwmLmPZVoPMRV8/8HA9hSHYE6Myqe1TlRkKa5C2P
         P48CbrZ3euJKTmo8k3c4ljO4/tIJXoSKK2DI9DSMcGOouEccutJ2GeH46xNDu9vAAAbF
         Cmw8PJ5haznHdC2abLVYgfBlhY/qDt9cSNBWlmvdH+6y2Z1paE6RpgiUCwvX0HjBZvZJ
         9AFiSdYnMbGDPiB4A8e/tVSHpHKz/tMKBUdFwtZZH1nx41qLwihQncd25CaenUHBAtv0
         Ad77awKe8O21KBLMiLR+CfzCNoUyf20d5LDV1vA2c42P/tGBbMZJ14ueJZ8e2bNca21n
         sMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531723; x=1791136523;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKitTAlwTBExXI+cI2+8578Ap+v+wKyXIoUr5i+JPl8=;
        b=rqJaIHvymEptMrIHoVzV19d6p4CRS9xIOgank2nrUNk7EnratfkcevVsN+/Zi35/tq
         cUxs1CLwHK+5jCxLFgE5L9xVjTQwFjs2KGF5aeZ7VWoKo2vKuTsoVr/IzScc5wnIKBgs
         bVYOJzXjCicHuRneKO8ZaurmLhX3OkIK6yx05OR9UN6zvQJQL3G0Mevj5Z18KfiQQO1A
         gg030hERsCqSbnq+9Q0LhxbwQM8h2Erqy0IWQi43z8J0qrkDP6mmgYOB6hnHjZC2IrUV
         shST3PDwahCYaZHLirIk1sQROK2MPEPth8OWmRAsoL29XyMNokqTMOb+a9nMZxkUa3iu
         aywA==
X-Forwarded-Encrypted: i=1; AKwUvBxEeomdJjQ1c5IYjw0e/igfg+16VrDZZJS7NPP4O/xQnh23wHzKsCRv04BclKCNywuSmS+mnsYz02o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyp2yGiWgj0u9qABwVce3seIzYjWpGGvbtJ7OYDWEuDaO6lWEP
	zj752bbHZxRo5FuLhiqgLHPQiA0wci+v3B2NTCqQE8jBwClQi/JucfOr
X-Gm-Gg: AYBFou3BCtzIZmIpQ/uQHEEqZv7hpuXxjH2Gch0Mzqcu2v7rpbdrRDnnq3/vNuFfyHO
	Grg13zIMcHjo11VZYvG3uurpsgpf8f8cwaMWZ6aLVZaVnoYm+YgXEhQmimDDRRA2adyYeXIHH0h
	Vv3ue1CAaGl3QMHxmY0/ZQ3hMiPCF4LW7M117OcEIgjOmjfZ+bysxlcQaqYSBTIf1l/b3iPjkZP
	Pufyv3nH767rmL1iqqs5nHWNkGSm+lOFxd4WB5QKDkNgjSUh7b+XKu43NpYnE/rw99X3direVVb
	85yDU6L0StqzNbzEAJztXzruEu8Kjr+eULdvv4+7nEOKNL3Opr77TzhIoj4vYDTDoN9jfihNKT2
	ibLnwKE4jUipxhHh9F63GDYsEdtJ07C+jxMub9bwJncAorf6u9/YSD8e48mQG47YoMy6qmv0hl2
	FmjMvwSRoscR/KQVfUs6J4J6EglXWQ/DFMrnf2owy7SK/5D7QpnZhShZ2RM/6ainKcTPVnAxDU8
	I2pwHPijpKgEQIqiVBTp7lubi5FV7rxLMx/04Pq156mARii2f8/jYozzgZ3yWL6Wnx3HH3djbsD
	z79vljVREGM/Ua1MbZ/+TBrNAQLKWDeoXBHWmS2awN9XJ1VJqm54QQAhCNnEaUlDQbu51aM055u
	X3eJu7kH6hd1ZgsvXHZsvbNWvnvjMaYQ=
X-Received: by 2002:a05:6000:468c:b0:488:76f5:c7d with SMTP id ffacd0b85a97d-48876f50d2bmr11484821f8f.6.1790531722779;
        Sun, 27 Sep 2026 10:55:22 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm22726735f8f.4.2026.09.27.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:55:22 -0700 (PDT)
Date: Sun, 27 Sep 2026 19:55:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2: disable autosuspend on remove
Message-ID: <20260927195519.76c2885b@systembl0wer>
In-Reply-To: <20260917041128.6d10a2f6@jic23-hlaptop>
References: <20260914113422.1689331-1-lgs201920130244@gmail.com>
	<20260914145339.00002f0b@gmail.com>
	<20260917041128.6d10a2f6@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 04:11:28 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 14 Sep 2026 14:53:39 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > On Mon, 14 Sep 2026 19:34:22 +0800
> > Guangshuo Li <lgs201920130244@gmail.com> wrote:
> >   
> > > at91_adc_probe() enables runtime PM autosuspend with
> > > pm_runtime_use_autosuspend(). The probe error path correctly undoes
> > > this setting with pm_runtime_dont_use_autosuspend(), but the normal
> > > remove path only disables runtime PM.
> > > 
> > > The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> > > with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> > > was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> > > set therefore leaves the runtime PM state incompletely cleaned up after
> > > the driver is unbound.
> > > 
> > > Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> > > path.
> > > 
> > > This issue was found by manual code inspection.
> > > 
> > > Fixes: 75d7556ac0e4 ("iio: adc: at91-sama5d2_adc: add runtime pm support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > > index e8a5285bb6d4..e68632e628c7 100644
> > > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > > @@ -2487,6 +2487,7 @@ static void at91_adc_remove(struct platform_device *pdev)
> > >  
> > >  	pm_runtime_disable(st->dev);
> > >  	pm_runtime_set_suspended(st->dev);
> > > +	pm_runtime_dont_use_autosuspend(st->dev);
> > >  	clk_disable_unprepare(st->per_clk);
> > >  
> > >  	regulator_disable(st->vref);    
> > 
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> Applied.
> 
> Please make sure to take into account both Joshua and Krzystof's
> feedback that multiple near identical changes to drivers in the
> same subsystem should be in a series.
> 

FYI, patches like these will become redundant as I have a patch adding
this to pm_runtime_reinit() so driver core calls this automatically on
unbind queued for 7.4 [1].

[1] https://lore.kernel.org/all/20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com/

-- 
Kind regards,
Joshua Crofts
