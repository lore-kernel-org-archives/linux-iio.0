Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017549AA21
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591232; cv=none; b=I+LsMFGk2/UVvz8WsqwMSpR6covSb42izQmJq6eSunjAapFZ6vECpHPhaM3wsEapCj7psF98Jbh20ASDTqjzZ9YeqDUzJj17auHCy0vnRLu7LQhaTb3X2/8iOVWbxit+bhua8ENHnkmYeSwoxN+xftpnM5iMgiF2LrLToQLUUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591232; c=relaxed/simple;
	bh=lfw5A0uXAuhjAZYX/T8OzUkOdY60W+ytkN54QbMhIRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfweN9GCg0K54Db+GUwDt4j0ACkSXAlFzeFZ6jFTteYPinkh2YkTwMvZzN0HvPRbCVowVZpcXBEFiqWdn2LHTKSGuuC1YnrEjf+sstCR4JmGL85UocPCpTMDQGMA7AU8NDSyowBKdq4WgwpaxPqqnP28Yeg3airZugZsxAQPGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URUNnOml; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URUNnOml"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48434392b02so2433988f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790591228; x=1791196028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pOMrGoe0MJA+5JRUzHhpj1OGWu27WePfFyfzZS0Xvg0=;
        b=URUNnOmlGSsz1Q0YUjhWskzhtgq6nKyuGOZkSsW5DDvmi2iAYJXvRguk5163n/jiuN
         89TZX9j3KQW9JEiaYyeXBUh0wK4NyR/lxPTRTiILgsEi23oWOjGlU5I8iYgeyLT4Nz/o
         P44sIbG64giveTAPBc+AHicIJKtmzTUlwFk4z1gaSKR3ra2MOBjUfM+hMgnws0FSbsb8
         NxMspionauswC1Rj4f1pi03imYg78eC53acTEVAI2ShguTx3jLWf8F2pNEetGaErAaNH
         rPVmn4Ku3+YoIeoy4CVOn5ix16TwYcoQkI5z2NHC0kzdURHO/UrUxvnPc7FWg391W4GC
         LpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790591228; x=1791196028;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOMrGoe0MJA+5JRUzHhpj1OGWu27WePfFyfzZS0Xvg0=;
        b=zo/dKnBNThw/L4/om9mThXyAyaS9+Owd6LEvYYb4yC2RHHkOxHuHs/omUOFOFGZjor
         NVLtYmNC34oCzIkNrijw6JTgRgSgAvXBvQb9HjBz2kZlMrjZcZB4JrTvxZgWOTegT/k0
         0nd9CTz6Cd+/1lHVTSOrfMl2hvQTkTr/ekMNA/90RhSyochBpYRl9vdIuTs9jwNdDM91
         9UPLtheBUb6buW2w/g+XYDCGjnNhmBCiBCunbyodcKmdven4lzej23lbq3Vnw/kmB7UR
         /8Be75u9X/83nIBEIqx0kpCC3p5JFHqghxxMNsJXc9RxnUz9kBQ2CxJFrLqWpGWX2bIY
         mAeA==
X-Forwarded-Encrypted: i=1; AKwUvBzRzf3frLKBrNCQlrTyucHnfFU/llXlY+3eRw8+0n5GJ/LMvmh3HmZX+IpZubYTpPrEERBmnZRulUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrrtdv2YWWLv41b/Dv6FrU+NMuAWjrKTZFr2u4DkdvRleexflC
	F6/yFrgSjVUUx+86Ti3izY4fotl/29Fq7oqqAHa0El/0vC/gga3O9U2U
X-Gm-Gg: AYBFou3r6zNSYOJ2WOJEiVoR0WB5qL3YbzO22f5YI0B2GnYO1uSFTaNPX5qUcKnkr5O
	sP3hVJRpEADbK22/a+w9uEG4zg1lOfxBDC3pLiPeteHNRN0ho7E69TJEU0GXLT5tvXYpQz8J/cH
	1acrMVKAU2ilEtdRkwKZjZvWpoDRyqlK+6Mhxx+oBEYS1tVB9EiZPKYSMjZsEQajuXM1s8BLaU4
	I55tP7EveMv4ZTrYkqDOXWEaSOueNlbRMBO105+6CkzP2E893Ge+fUFYebJ4HVekv48RtqO2TMc
	52Br4hGfDh5pBNuANb+1HJP43qWSLGRk+XISMqE/V9BglbvhWXisKceHLVjzXfAFMbKRnXmjCTP
	JcM3WLkYStwmzZpXdCr1nybOCoknGBbt0U0koCLAFPQ/2DfAZN8vzY6PImWL6KiFUZhF2rhQrDR
	tlvwDgh9YFOY7ZSlrY6ZlwbwIRMXdzocJ3puqMeZ7yG8fuZCLFGHazypTdgNHLHgOZk5bbwQcsk
	pMBWCi/Qgp0nqCsyLofJ/vxe9NGzjy0WtoGq80T4JKZj1w/ZdYdhWMnduUjonLyg6ASMMxJBn+3
	NdNYyaatoXSdCdzz0zDkrRf9h67OKXWrQWuNDWYhNPJkjSGtZMVQKksCHC277aF2FYCSiVAhm4e
	9bUcAVtNVPCcn/Ht1F9sYd+wmbhfnM6QnW8KfWOC5PA==
X-Received: by 2002:a05:6000:461e:b0:488:8a5d:ffcf with SMTP id ffacd0b85a97d-4888a5e01b1mr8368802f8f.19.1790591227919;
        Mon, 28 Sep 2026 03:27:07 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcc4sm27549105f8f.1.2026.09.28.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:27:07 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:27:04 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Esben Haabendal <esben@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, Christoph
 Muellner <christoph.muellner@theobroma-systems.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/10] iio: accel: mma8452: Support interrupt
 sharing
Message-ID: <20260928122704.03df4e7e@systembl0wer>
In-Reply-To: <aroytGH8u-gGFYvq@ashevche-desk.local>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
	<20260928-mma8452-open-drain-v10-10-b906fb408386@geanix.com>
	<aroytGH8u-gGFYvq@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 12:26:12 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Sep 28, 2026 at 10:26:26AM +0200, Esben Haabendal wrote:
> > Adding support for sharing interrupt line with other device requires the
> > interrupt handler to handle runtime PM suspension properly, ignoring the
> > irq if the device is suspended (maybe even off). And while at it, we use
> > the PM reference to ensure we do not get suspended while processing an irq.
> > 
> > In order to prevent the chip from raising irq while suspended (that is when
> > using fixed regulator, where suspend just means setting the device in
> > STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
> > then restores the value again when resuming.
> > 
> > The scoped_guard in mma8452_runtime_suspend() is changed to a plain
> > mutex_lock() instead, both to prevent mixing guards and goto, but also to
> > ensure that we stay in STANDBY mode while writing to CTRL_REG4 and all the
> > way up to disabling the device as much as possible.
> > 
> > With that in place, it is safe to add the IRQF_SHARED flag.
> > 
> > Keep in mind that the device by default is using push-pull for the irq pin,
> > which might require additional hardware design to allow interrupt sharing.  
> 
> ...
> 
> > +	pm_status = pm_runtime_get_if_active(dev);
> > +	if (pm_status == 0)
> > +		/* device is powered down */
> > +		return IRQ_NONE;  
> 
> > +	if (IS_ENABLED(CONFIG_PM) && pm_status < 0)
> > +		/* runtime PM was disabled, possibly suspending */
> > +		return IRQ_HANDLED;  
> 
> This is very interesting part. I bet this will be the first driver using this.
> A big question "why?"
> 
> > +	/*
> > +	 * pm_status is now 1 or -EINVAL (with CONFIG_PM not enabled). If
> > +	 * pm_status==1, runtime PM is enabled and device is RPM_ACTIVE. If
> > +	 * pm_status==-EINVAL, runtime PM is build-time disabled (i.e. CONFIG_PM
> > +	 * not enabled), and we can/must assume device is active.
> > +	 */
> > +
> >  	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
> >  	if (src < 0)
> > -		return IRQ_NONE;
> > +		goto out_runtime_put;
> >  
> >  	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
> > -		return IRQ_NONE;
> > +		goto out_runtime_put;
> >  
> >  	if (src & MMA8452_INT_DRDY) {
> >  		iio_trigger_poll_nested(indio_dev->trig);
> > @@ -1120,6 +1139,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
> >  		ret = IRQ_HANDLED;
> >  	}
> >  
> > +out_runtime_put:
> > +	if (pm_status > 0)
> > +		pm_runtime_put_autosuspend(dev);
> > +
> >  	return ret;
> >  }  
> 
> ...
> 
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, MMA8452_AUTO_SUSPEND_DELAY_MS);
> > +	pm_runtime_use_autosuspend(dev);  
> 
> I don't see the respective _dont_use_autosuspend() call anywhere.

FWIW, starting Linux 7.4 you won't need to add _dont_use_autosuspend()
calls, driver core will just handle it on unbind [1].

If anyone would like to join me in purging the kernel of redundant
dont_use_autosuspend() calls once the patch hits mainline, feel free
to do so :)

[1] https://lore.kernel.org/all/20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com/

-- 
Kind regards,
Joshua Crofts
