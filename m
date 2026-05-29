Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C433CCFA6
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053122; cv=pass; b=EYgSKzsstBv86V//8v2e34vbEW/XyGrKB8fMIZSLRoF79hD6b3UMpHAxgpf8zB138woWlKmfza6AyGk+IkrUPCArZu0ZvWOGCglPBpP7j7pZ/pRA3OKKKIZU7p5BcLqZZdigZfUrpUjgR09WGC8J3Z9Jw8HtCDBp67j/dV97+xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053122; c=relaxed/simple;
	bh=8wkglXjVU6JEBZlnTooRBiWGbdspQowCcNG7fybF35g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHd8KXSXSo5azJgA01Isc5/N+ElMVGv6WBGLPDwSOJDLZQr4UdaunEMLl4RW5YDZreFy/nkm/pSoB9P6OsdHdT79ArbztdK/q318l6PPO4mCdLerXldOKGZF9KA62vxQQqiUGKgQd1Lu/RWGZtg3Fpu21xgVkgQlD3300VEttD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBST1a/z; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBST1a/z"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eeba68948so1114952f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 04:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780053118; cv=none;
        d=google.com; s=arc-20240605;
        b=bvqDWaJr5x6wS2XOy6tNTcFCG3jbWf4tprxogQs2S744+A+v4FY2P5wuD4VAJ6LchD
         Inp/C1j9kTmjwJ3w5MuNNpM30HjegzjgOJkhftfl0PZUjT1sGlHFdA1O3dWDpsxPIoDF
         E9hU64gzv5aWIjq24XrRTpCdnha86M3nSm22VQlMm0FQdi/cMo2w0FR1N8Tb2vuSnek+
         ZcUC4irJwQUTEoG08c8eompV0MRx33yJmb4OVUahvYPKGYDDesO2LnPrXSd9Euu9SVYa
         KQTv71xw+WwiYvJ3RVEBwzoqsFyvjueMZ2aFlH8ws2Q9E1HYW8+CLHrtxZ523U/nThfO
         WEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6cP10sPviPffkTtbT4HFnT5v/q25UD6CviQVyqor3x0=;
        fh=R3ctAtPbmXAC7jgwpRzNECOLEO7AoMS57daiUKjw5jE=;
        b=U6MQg0n2gY2R933etsHcj1rjkJcauOhnfkns9fsBg5OuACkyIjZI02KUqoqHT17i9y
         ZVDMv8s4u4cqNzWMZXdX7kS9jvX7buEzHm8mSmaEYEn5K7k3vDKFACqK7zvUyhqDYuBA
         4qZNhzYXZfBtHbbwMli2JWCiE8Wg43i+k4F1o+3y14Sng+AHpLjHiTMFik7twqCbZpn4
         ipeSz38Ic87elb2VY4x9CkzRs9u6fzPIZOhbnD6KgleIhkqAcE9moxprQssF/Jz0EudC
         qxFi8Ry552G0FLS5FE9Xzj/If0Q9zi4xq/XvCj6ttE1B8XW9PFNh2sOJNEIv56ch6Y/k
         jqow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780053118; x=1780657918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6cP10sPviPffkTtbT4HFnT5v/q25UD6CviQVyqor3x0=;
        b=bBST1a/zuZ7R9sXHVwJ9sZ7xOrAjpa7ov8Tfx0LFK6Maq3WtPZN4nwzsvUlVNzOTic
         7TjBFe4+j6l05XsgvHi+7JXbogKDsm9YGSdIe6GXQrgRBWOhcGSERLzY3PNjS3cLlIsa
         UwxKYhLd+pn/Iv97UgnLko3adcLj9X+t9inckhlJo3Pbnnj7T1lepNwIYH2tbtI87RdA
         Og7heIUz1cvSscMbols0iGqlfiXwXEH/wiyyauYI09fASGuCDvc5HUz4ubasU4SUXOrg
         HUWuWnhokeIvHvHi78W/hyeX1P6ekZ6rmfXgDNOdoQ71Pm7qaNnOmRtE2dxUrxUG+AzA
         di3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053118; x=1780657918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cP10sPviPffkTtbT4HFnT5v/q25UD6CviQVyqor3x0=;
        b=gH24FFO/iy8ObrSvsJxTawjnahB8gFrXA0VOofhnLcji2JBxhFTbrQVygPl0wJ6Ggv
         XQNH/XutxFhNV5p4fFezYOo/EY6pCjnLKHB5w87r+uJiiTlhGhJyq91GN4v6eVJ/HmfG
         xBHp11LC4vVL9bpggxqqRk5adNzz7Nz5Rr7BzSyJSSwai1xDe0ujp/G2OXQTV+AI53Lp
         6QMFLD9A5SrQtw3MmZoZCPRaeRnrfNcGbKd8zcBHOreWardp+HZWYEx8g+jkz0QZixi3
         gTgOohTPAlzT+pReR2u2ICluUh8Q45AJJvkXZHRZDLEnjnZiTG6x42FLxf6uYsyz40YR
         RhlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PfvJRGiWYlebtc1qCi2e84qOMeWtEQDQvWnK5gAxSJkNslnjdbAloo+vhW4lbjXAsQSZ75yf0H1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0uONpKmeVmuj2jAuT10ygsK3WUGqNGnDVjd5Tc8YckAEDybyM
	kaUEA4ckrPKKCMw48aOky0Xz5JFBCFTO2qzoDP7uEtyOstHRV5hc6vFFEN2a/YbgSyfezugZqC7
	j6B8UCTiQYg/7XA0XpelxTa2mcRlVIs8=
X-Gm-Gg: Acq92OG8h1RjtXjXYYYx58377A1zSkDI/MpG55N+5qm7ce9hyD4v3u3/qCjmjkzoCDE
	o6IgtUjbBcaSVQ9/ux8twL3vo+eqNmqFPCCkxxxP8aj1XsRZCyyXiHGLQGq2liurF521ljKOy3R
	R9/2HM3AubyNT9B78s9tthps49yCl0jC0TsCe768V5ub4cvHO3J0OKyo3LX8fGrwSuPhbEL3VKj
	4qQk6/1xiR9vgOnZIRHzTaCZLfBPwkzh8znpo5N2pOKKjaAuvX3SCP9Gg/TYeXc9BVNDdXGMOMr
	tf+JUXzWIC398/bvZHVoRw9dy4W3N8SjcMi0aHjfJCsivK5Jn5qOaeFjJAcrSMzLJgYbIU+gZf9
	OViqB5u2AlK5Xel8pTswmtajwCHJq/r9DvoBpEzjTQsnBxdTW4krEL0+aC46cZASaczCzkLUBjl
	LmVHy5tNAzE2v3DYdy
X-Received: by 2002:adf:e5cc:0:b0:45e:d3d4:c230 with SMTP id
 ffacd0b85a97d-45ef1460d52mr3439160f8f.38.1780053118206; Fri, 29 May 2026
 04:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780050609.git.sozdayvek@gmail.com>
In-Reply-To: <cover.1780050609.git.sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 29 May 2026 13:11:46 +0200
X-Gm-Features: AVHnY4I2Ri-8CtBqR6HlFrrFv2C0tdAHR15azmryU_IGhYjAjW2UQ0fDsBs1MhQ
Message-ID: <CALoEA-zdDO3zZdhLZZt+f89E5cwVH-dFVJoA+Ecs-W+ve3AyXA@mail.gmail.com>
Subject: Re: [PATCH 0/4] iio: fix PM-enable leak on probe error path across 4 drivers
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 May 2026 at 12:51, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> This series fixes a class of runtime PM enable_count leaks on probe error
> paths across drivers/iio/.
>
> Each affected driver calls pm_runtime_enable() in probe and then a non-devm
> registration function (typically iio_device_register()).  When the
> registration fails the probe returns directly without calling
> pm_runtime_disable(); on subsequent probe/rebind the runtime PM tracking
> complains about an unbalanced enable.
>
> The fix is the same in each driver: replace pm_runtime_enable() with
> devm_pm_runtime_enable() and drop the now-redundant pm_runtime_disable()
> and pm_runtime_set_suspended() calls in the .remove() callback.  The devm
> action runs after .remove() and handles the teardown.
>
> drivers/iio/adc/ti-ads1015.c was posted as a standalone patch earlier:
> https://lore.kernel.org/all/20260529101011.3030-1-sozdayvek@gmail.com/
>
> A separate follow-up will cover four more drivers (apds9960, mma8452,
> pa12203001, us5182d) where the same leak exists but the probe error
> path needs a goto to the existing manual cleanup label rather than a
> plain return.
>
> Stepan Ionichev (4):
>   iio: light: isl29028: use devm_pm_runtime_enable() to fix probe error
>     path
>   iio: light: tsl2583: use devm_pm_runtime_enable() to fix probe error
>     path
>   iio: temperature: mlx90614: use devm_pm_runtime_enable() to fix probe
>     error path
>   iio: accel: bmi088-accel: use devm_pm_runtime_enable() to fix probe
>     error path
>
>  drivers/iio/accel/bmi088-accel-core.c | 6 +++---
>  drivers/iio/light/isl29028.c          | 7 +++----
>  drivers/iio/light/tsl2583.c           | 6 +++---
>  drivers/iio/temperature/mlx90614.c    | 6 +++---

I guess something happened to your formatting, because all of the commit
messages exceed the 72 character column length.

-- 
Kind regards

CJD
