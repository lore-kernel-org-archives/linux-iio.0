Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54883988E0
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639966; cv=none; b=owdOqPi2PHJZe65VTmJog7b3Lm2DlPYuTXsrAqdeL0glWD9Fu36QtS8B9jAp4j4sVrljg7St3zhJzZ63EIRVT5WqWlwjgoFRhIOrNsHwWHxBVy4Mosz2upN9l4RTK3FY8o7zBnw+u+kIdxjTwRrqp9SlhZNg0ShQg5nxwnqCCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639966; c=relaxed/simple;
	bh=7iU6z91ycljbm0po7ZNnr4gsCKmCcBFKZQnQbJmK7to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT7jgqoh64TBmHN2XmuSYG4YhOoEf8Q7DNp8CaPSX3IExuVPKvCvWBtGiNgFjgMb9DuIQNUQwWc9oibNXW+RTH3oF34UAbzEZZgBCsXvcCxLBoLR6iyIHcEbmW3ryWgXMdQ+4ZXwIKCDIKls5oocBkBidhzzOkNvtJsT059m2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY8DTxaj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY8DTxaj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490c1915793so3928795e9.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780639963; x=1781244763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgxx/Rs2dNmB7kmYA8c5lq8xrDwo/RsROcUUe32SZ/o=;
        b=dY8DTxajQfSDiVsGelG7WvsXa7jfXDTZkOxWCpe24eNdmQj9wDOxa0NvYNVyLhIdux
         Z2oIO1BwQ279LO5RK/VNgileTlXlonnSKu6e9fuLvwmba0rAGTNGcIsmhWysT0ySo8ON
         cdnDP5OFnvBxzhJKTCQ6PWBhao0BKB5yTZttukD+oCXYcvXtR0HQyY5yTCMYpBtlrdiM
         gG+PwHlukRFfVYiNxJ2SXVRGgGxVoC/SuaYkP97NS3ACQo9OAOlbxSwpyqmBG7niXQnU
         qDwa2Qxte2IOQjp5zlKJ/mBGMmF2OV4WnZAII100N12xoR7ky6XLgJq4lRLJCmVFABnt
         bX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780639963; x=1781244763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgxx/Rs2dNmB7kmYA8c5lq8xrDwo/RsROcUUe32SZ/o=;
        b=L/OuidXC4bN7DNCsIdQxg7YVoNS5K+Q94HAyor3ZMdaq1crZDnoAJgf8ww18Q6gNz3
         +RlIQXyoKLTj0k4k59CWMB4fGVrS6arUvIClXKShDLZISjC371/xW+KobiM2aSghXDhv
         koAulpCKZAlDLLR0UkNMfi9cN4GAhvc59lkr/cdKHFHDb2v8ww0mR+VIbwzU0uDINO9I
         loK33YiARee3LwgoFZguV7uxyKqe9a6tBnO8JRMmrDu3SnEw8TGxvrvHIKkEKVXr2nBg
         U5DtZ4qniqb5KNLGzCHPJvE+mlHGCyrd2nugljA8qweHWmU8CGJJrtD31XMSvYyFZNHk
         1Cgg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZNAG2s2W1jk5BF1MmzvlVITsInulfxcsya6oAE3FjoJGmMMg1QJAmNkXWnYqpdxxO3o8sC8QT7M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcxdNnGf5ZxmAAwsS2P8oJKzuhUj8MsePL2nEJtV9868BdWAn
	G8ee67FjDIDxcvk1vCacVU9i0NC8WgVV0MIERSxKvEehQZclKHjQ/LuY
X-Gm-Gg: Acq92OGlBZH6syIVz5JbojxqgSgu/Rntzh3hM0Eo0f687sLdt0HFow8cpfpzT+ugNnT
	lPxoNa4SJxMMixGKnwRBKdJ60Y3CKb5hJ94o6lcHW53DkKpii9PoxOe0h73tBHggxaFvXRQbxn6
	CxEamWTMXKin86yH6Dp04NMsE/mnJ8/s/ATupWItWXIp7oJz3Py77iNZliZbYf/hH8xYa8FbOfz
	q0uWGCv7CZvd/Pe0qx9/eWk70hfVzqLYyWf3y3TYOPRUVO5cX3EFYTZSGcAX82zh20tgvuWPasS
	Kv1SIQ3CWzQX2uPhr689zNAibRPm1CZO4Q9ireYJy88GGQAUvwJ7yO3uKMqh2gPx2EfxrKOf3KH
	Un95ncmuFTUyTYdu6Jvgov6dyfLobXl6u09TW/dQ1sS15ygczVJZou1iMuRuV10GLLHFb1kQsh8
	tTxsNUpjTl7oqtGE6yS+MLX92n7T9elw==
X-Received: by 2002:a05:600c:3515:b0:490:b5d0:598e with SMTP id 5b1f17b1804b1-490c2604783mr26573285e9.21.1780639962756;
        Thu, 04 Jun 2026 23:12:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e59f5sm129250445e9.14.2026.06.04.23.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:12:42 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:12:38 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiJo1kjN3_XDUdBc@stanley.mountain>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain>
 <aiGRzFrSU6QUL4R2@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiGRzFrSU6QUL4R2@ashevche-desk.local>

On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> > >    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > >                              ^^^
> > > Uninitialized variable.
> > 
> > s/variable/data/.
> 
> With what I asked in the previous reply and what you explained there
> (thanks, btw!) I still think your patches are not fully correct. They
> will require to atomically write all or nothing. If we want support
> partial writes we need to go with that differently (reset ppos when
> we got enough or more than enough data).

Requiring writes to syfs and debugfs be atomic is pretty normal and
works well in practice.  These are very small writes.

regards,
dan carpenter

