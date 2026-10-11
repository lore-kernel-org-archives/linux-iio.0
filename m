Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A033C192
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738331; cv=none; b=JI+199ObBW7PQIEgXE5t1Hek77cS3xUIWsiosiH8vl1DLnmDmu24eV3rIk5ElAWXuamxpP7T+LKBfD+xfnQdXFVKNHjM21BWc7R2Ed3VSXNblJDeAQkKJK4sFrz9JYyHZ4BnksX5a1DeM68l89EJZ4R5X2VrCmL557lXBnNF/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738331; c=relaxed/simple;
	bh=FrzOi1d6DScGP5qwwlKD8zn+teFRJ0D7eWWkEUVxg9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZvBcSrru7ORVyjx6Xrw9uX1TvbK97QjeMhfLkl69dgmrnHPXVGH8pxO2CyUoAh14QcethzlKrmTYKApGPIpEsZZQ6Ej/LFZhTSU6SIhAHXmDQyEnQQlBHyH2Q50xDwsoAMgmY+zr4C9PIa2mvNmjdErQ09PU6NuN0orBZgEpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYQ/KQkr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYQ/KQkr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so10638045e9.1
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791738326; x=1792343126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZInZlKW0LbD5WgdvKF6kbek14uDOeglXNqIPQDEpMRc=;
        b=GYQ/KQkr3oGxEpCfFxTsXp1ZJH6fkAmpm4zm7RD9kZ/84BG7blicrHgVUdoaM3yt1e
         hjEys+TThOZhGqqMDOz9MfHsw+vXabqHQ1FUR7TJfMoPPldFc+C03/Q0xSs3pnzlYy4P
         OxX09Z7uUQZ6mvQiAlX9bxcerPbDhTyauIg8DJRJSBCVImRQ6trD1+4ZtDGB9rUOUHBu
         6wN4HaQwe8ErpcYfldJXMipF4RC9Rv2AnzLZ9H6Mb0pc08gdRe9YNMeO2wcKTxifvBLk
         JLP2nmKxdjRHpK8aedgX/NKNucNZFIQsXlSrsAoo8Rfu+lb99+/ogno5OIIkGEnEgAWZ
         9rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791738326; x=1792343126;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZInZlKW0LbD5WgdvKF6kbek14uDOeglXNqIPQDEpMRc=;
        b=ejk8llFM6oEjHoaKTw6ZnsAI/ekPpXZq8M8x498DBqYmZA49jYuJWbVvze6360r5ep
         PI0ujdIU+ih9yzzQrTOsguXqQE9G5vT3ik4nzE+J36IMYUf5OkAZxuWviLdzJYXEBmdL
         cFYjHzU+TCIchzzx/z9SHFrqK7AlMQ0gpqVaxfkfqoTya1ZyXlEnoxH41xLnxCQxtmmN
         8HsZepgk36I2pFVf393LVtv8xR6PeRAcuNc9WsL6XdjBxgs3O8KU9M8YeEzeqYqrJESJ
         Srqk2PXP3wtTXNxvMfmCjJpNMOA+qX+Sm87Hoh0buLBM6yaa8JIOg2z1SpB9+ViDOWF5
         xI9g==
X-Forwarded-Encrypted: i=1; AKwUvBxqJxt0Iwe3RGMKzSHrQ2+mQeooc8FnMbdONu3lgLaO+LS3JiScvPS9WdWyw9hJ6OIQ2EmEugn+JlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJY+8PWZ1z4tOkLPqFOQUNp0JbGNT5iYFLBqPIfGuETjVlfulBO
	+eoSB1CIk0RMTyS8B9XD1cjX0FHNx5O35hetdyxkcA68tjyrgZWOEleB
X-Gm-Gg: AYBFou11o4FLz3tKu9sNAG62lap+BPbuHo426EJ0li41urkRzIQ1Ux1sCfXv144KuIN
	J3SC6OiA0G8rjcRU2A2hYE0dPNJtsEpxK7YzJ7qELb7NFpNlGV3GVIItk2GdGPr6DBokoVEgO9k
	/ari30LMh+bMf+GfXp9QjUplhRUKDI6JedlCwmqTQYjPnSKvoMrdSCtGIm1+uDNz2NvPOmawE8P
	WZi5Wgn8+pLHJDi+zb+gRBtwqsp2o+z4IDW1aO93KuuyWo/94y1m3imJ6D+V3wFnb6NjNqJJGXt
	UmqXWujvbFuHoj/EGgrlNJ9FQcpqHzCT0oW9JDNSWgtBUWs/HG1kt/fVtyAhEVLtwvVx0jMPXFn
	IRwBKqHwnqSfTdxByiBdfa20LeyKJC6bNRrsf6HO7ImfLo3+JiYJjm/KQmG/DCOdmOHef/soJ1+
	lzMpRFBiNuQyvoFw//HMjkNAznVEXp5/UfQihAXqRHOSVpufS0+E/VpZzjsu38RvOr42+8m6WN5
	Ku05HQFSjvJBOU5sO4I8nX7QuluMJ94kVI7bFWNhaBSNVZjr2BhqpJFvmBJrVIGWxN1GpdNrBHF
	JpgK0lb/NWkpP5/JqDuhwwBQNODocr2b1D89clABGCuHiLG85qcts09moMDf9uW1TFUqlGOtiqX
	ITJ8LZVJUkTChWh+D+yO8mhmcm2sGZIY=
X-Received: by 2002:a05:600c:3f0c:b0:4a1:85d9:13be with SMTP id 5b1f17b1804b1-4a18e498471mr155353675e9.20.1791738325786;
        Sun, 11 Oct 2026 10:05:25 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beabbd0sm259720725e9.12.2026.10.11.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 10:05:25 -0700 (PDT)
Date: Sun, 11 Oct 2026 19:05:22 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dingisoul <dingiso.kernel@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [BUG] iio: gyro: mpu3050: use-after-free via trigger left on
 iio_trigger_list after unbind
Message-ID: <20261011190522.79da3607@systembl0wer>
In-Reply-To: <20261010203601.1686148-1-dingiso.kernel@gmail.com>
References: <20261010203601.1686148-1-dingiso.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 16:36:01 -0400
Dingisoul <dingiso.kernel@gmail.com> wrote:

> Hi Kernel Maintainers,
> 
> I hit the following report while testing current upstream kernel:
> 
> KASAN: slab-use-after-free in mpu3050_drdy_trigger_set_state
> 
> on commit: a90ee4305c4a (2026-10-07)
> 
> Root cause: mpu3050_trigger_probe() registers the data-ready trigger with
> the non-devm iio_trigger_register(), with drvdata pointing at indio_dev:
> 
>     static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>     {
>         ...
>         mpu3050->trig->dev.parent = dev;
>         mpu3050->trig->ops = &mpu3050_trigger_ops;
>         iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
> 
>         ret = iio_trigger_register(mpu3050->trig);  /* device_add() pins trig; no unregister on remove */
>         if (ret)
>             goto err_iio_trigger;
> 
>         indio_dev->trig = iio_trigger_get(mpu3050->trig);
> 
>         return 0;
>     }
> 
> mpu3050_common_remove() tears down everything else, but never calls
> iio_trigger_unregister() on mpu3050->trig:
> 
>     void mpu3050_common_remove(struct device *dev)
>     {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
>         struct mpu3050 *mpu3050 = iio_priv(indio_dev);
> 
>         iio_device_unregister(indio_dev);  /* devm frees indio_dev's storage once this returns */
>         pm_runtime_get_sync(dev);
>         pm_runtime_put_noidle(dev);
>         pm_runtime_disable(dev);
>         if (mpu3050->irq)
>             free_irq(mpu3050->irq, mpu3050->trig);
>         iio_triggered_buffer_cleanup(indio_dev);
>         mpu3050_power_down(mpu3050);
>         /* trig is never unregistered: still on the global iio_trigger_list */
>     }
> 
> So after unbind, the trigger is still alive and discoverable by name on
> the global trigger list, with drvdata still pointing at the now-freed
> indio_dev. Any other IIO device with a triggered buffer can select it by
> name via trigger/current_trigger and enable its buffer, which reaches
> the leaked trigger's ->set_trigger_state() op:
> 
>     static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>                                               bool enable)
>     {
>         struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>         struct mpu3050 *mpu3050 = iio_priv(indio_dev);  /* indio_dev is freed -- UAF read */
>         ...
> 
> The reproducer and .config files are here.
> https://gist.github.com/dingiso/985aa3eb2786b62f80e2e6780e9af090
> 
> I'm happy to test debug patches or provide additional information.
> 

Hi, thanks for the bug report!

I've sent a patch addressing the issue, it would be great if you
could test it.

https://lore.kernel.org/linux-iio/20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com/

Thanks.

-- 
Kind regards,
Joshua Crofts
