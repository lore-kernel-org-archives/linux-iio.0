Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D63C4563
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891028; cv=none; b=iSMuO8rXYsthQoTA0zTvik1S3YJvRpYr5nXh7I4ACMRUC939OOBft64Rb1gFxs1Vu/SD0QN/2ByU8kjtRl1XPtl+HI2t2VQOJAFq/J4/68RpU0EzTmE9x0fCZfllqEX083d/tvGVP0dYDgAlW0n18Al4h9Ecv/zaYXxxEbLoRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891028; c=relaxed/simple;
	bh=sFgZLoPCzaXT0KOtVLO302gAymZGbtFi20FWtK/6Q7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf3k9Yzh2kBogIi2RvGZUSM0c5zlPShG8tHFleanLGuPx33T7TYpU6TS8oyk5E+qdM7Qa6LC6Okqy1t8IkoeQCOEsLA6sUG3fRZBQlj6JJIdqBoRbSizcwg3LFyjN+CEXPaTQXmv5LO4iZ8pEkiHVVkSamSFBvrqWBQaDiaE4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPL4wgZT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPL4wgZT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1661264f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791891025; x=1792495825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wwOO4EjDIP6FblnXsOYCnC8y3oppmtWD4jkkEFCbjSU=;
        b=mPL4wgZTRzxQb5Z+KACNNCu9Mel/iOI9zoct+a29CDc98+SX58ZHT9oaLiiwSiBiML
         tHI3A46wFihsuKe5J5HUk47riJpVo3EAlMoBEMPJDZQT9DS9Ehbd2naa5bjA0GWB9kWQ
         VFM1k2H8E9ixrrWrajd9kp8cF6S+0NvPS2OHkH9Dbs/VlyI8UjHtsQCKG8IOVoepyMcG
         VqgaD7BZg08fHx2LF4xaaQl4hOWwLlT4ZAsj0EUGoR8cNjrpiuQUiMLhM9lIrMKPqE0H
         VIkrxqP+47ABfqhzvkYBTo3NdgxarKMdUdKjeMNv9GiGo6KdtUCv7eCr3fEqsPbfX89Z
         895A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791891025; x=1792495825;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wwOO4EjDIP6FblnXsOYCnC8y3oppmtWD4jkkEFCbjSU=;
        b=eAKqwMWkgtDyDbfso8smEKI/LDpFGl8qir78OGp8JCD6GaqR/C/tBIt6ZcTrUKjhZA
         YFGQxfm9DG+pXK98vLXUlPTvXdWs11/lOkjLsWzqAFxifu0r3McwVLhVglaTfYwSOt48
         6gExsT7ivN4xyYqOdvXI/A/9tfG+Fffd3VPp/rGmoab81NOoPBvFJs9WwnZc7W0hckKJ
         xdz3ifyml82qnS3fkIDu3V56e1LmVzdcuJwN+DpgJj3yeO3q27gtabTv08vhDuJsggWo
         hEEe1oZNeYH3y0JApbAA9GF6pqF6n6pmFW9J3hk02RjouIuyfUwf6ZezMMkKjPACZ/6w
         d0Lg==
X-Forwarded-Encrypted: i=1; AKwUvBzV8+FtkOtArHXgq881d68JQJHmjalYayp/L/1tjpLBu5c97yo4p0WIi1nvzbrKJkhP2/gCtHtqYQw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeDJjkjioMf4JCJDAlYxDtOYVXLXSdC0dBJF4kqxnV0cFeqmjX
	O9OhO5jntEeLY+uq9nL6txV3y321TKdQboJMw6KrLqX7zno24zrxPthw
X-Gm-Gg: AYBFou208DRi6sYwp4sKttf0EsbmCMizeMFBEMdlzaSIPEXoy3apriBwAgVo03nhNsp
	ulIaBHW3UZBSun4oTTKRn5B8GBQ0aHtQe3iHdE+vNME8sDESCPfF+mECFZY+Q2i+KMUYy+29jHR
	aICUB9jjpWQNTZHyDJ/PLndIRDk0bDrX6F1aoRMfjHEioPbtUQoYmMhsAiTEFtFh/B7qUjI4AD4
	rEvFPjH0rq7cdXPa8YYGk9Flrqapd3Cu16Tq4QWygCAiLRoLrFb9Og7qurpGQw547Zi2O1JKJzD
	HYmY6LEWPZaMmhWN0CptO2iGxR4nGhcsPqIKEHyoVrGA+vgb9nafWRsDji5M+j+OI8hrM8ar+TJ
	mS4qPIoN3htDMQXwQOHkCJd6qIwwL8lrX0fv8O4A4Aq+cyEhpGruEdgyTJVakeuOhUnWx+nxJU8
	7MEkoLh6aJe4HLM9y5/q+3ApULKTMHIwu6H2PeIeeLeXYtIbcTxN0Mz1MulJiXoza9VqeRg3tpg
	1rwAp3nHJQ7aR+/oTA846EIfSjBMLPVPmv7aJLqxYkoJoopR8zJRT48jRrPhBR/eLCRIh6hJv6U
	qdl09LNPtEAG9FA3b8IjwqyFtwHNQtWcKiJKFyi3OqR0OZXyNn2+KvgKIZvpVkiPTTBiUDHkg29
	tPZMeD1Yjl6xX6etlTcyT2SrlTj2eozfjMc0BmDs5/ZvJqutr/7EuPohxRrwk3q28rpG8blRpSC
	Jvx9oF
X-Received: by 2002:a5d:5d83:0:b0:48b:11df:c496 with SMTP id ffacd0b85a97d-48dba9d2da5mr22876093f8f.28.1791891024661;
        Tue, 13 Oct 2026 04:30:24 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaa21sm5252171f8f.9.2026.10.13.04.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:30:24 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:30:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dingisoul <dingiso.kernel@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 linusw@kernel.org, linux-iio@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [BUG] iio: gyro: mpu3050: use-after-free via trigger left on
 iio_trigger_list after unbind
Message-ID: <20261013133019.000033e1@gmail.com>
In-Reply-To: <20261012200904.1853361-1-dingiso.kernel@gmail.com>
References: <20261011190522.79da3607@systembl0wer>
	<20261012200904.1853361-1-dingiso.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 16:09:04 -0400
Dingisoul <dingiso.kernel@gmail.com> wrote:

> Hi Joshua, Sashiko,
> 
> Sashiko's concern is really about not being able to tell whether the
> trigger was ever actually registered before calling
> iio_trigger_unregister(). There's a precedent for this exact bug class:
> commit 3c5eed894efd9 ("iio: temperature: tmp006: use
> devm_iio_trigger_register") hit the same
> devm_iio_trigger_alloc()-but-plain-register() mismatch in tmp006, and
> fixed it by switching to devm_iio_trigger_register() instead of adding a
> manual unregister call.
> 
>   https://github.com/torvalds/linux/commit/3c5eed894efd9
> 
> devm_iio_trigger_register() only installs its cleanup action if
> iio_trigger_register() actually succeeds:
> 
>     int devm_iio_trigger_register(struct device *dev,
>                                   struct iio_trigger *trig_info)
>     {
>         int ret;
> 
>         ret = iio_trigger_register(trig_info);
>         if (ret)
>             return ret;
> 
>         return devm_add_action_or_reset(dev, devm_iio_trigger_unreg, trig_info);
>     }
> 
> so it can never unregister a trigger that was never registered -- no
> flag/pointer tracking needed.
> 
> Suggested fix, in mpu3050_trigger_probe():
> 
>   -	ret = iio_trigger_register(mpu3050->trig);
>   +	ret = devm_iio_trigger_register(&indio_dev->dev, mpu3050->trig);

Ideally you shouldn't mix devm_* and non-devm_* function, this can cause headaches
down the road. Either we do the manual dance or we convert the entire driver to
devm_*. If you check the file in the commit you referenced above, you'll notice
that all the other functions are devm_*.

Bartosz Golaszewski had a talk on this at OSS Prague (recording still isn't
available, so I'm attaching the presentation instead).

https://hosted-files.sched.co/osselceu2026/0c/OSS%202026%20Prague.pdf

-- 
Kind regards,
Joshua Crofts
