Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C62DB7B8
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026540; cv=none; b=kRwbmdS4Yn6UJFjpXby5cTH+aG4va4jqLK/q/q9WPqa/YLfy1DLTMgltlT0iNQcRDwfVTif8B9zFpV6i7NpVOSvddSnMenTDBKS9NkZuRnoAl3V5bzfiOdUDhJ1DeNdhjR+W+erJRjxltPgI3o8CfKvIqMQALqQSbQKlGC/bp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026540; c=relaxed/simple;
	bh=THTDXskffpUZ9JZxziWLBF3Q9HrUMawUCCalagYpmp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRvWgs6UkXHUryVDUm8OsdpSlGz4IMNjrTZN61hXS2JbCjIaQCkA008ga6wj+W/1DD/X46OeaNFvviGLqO+HfLXtUIe/Ag49Cok+V9HEyJ+FqjOL51/MCVOFwc4Hal3kwL6/Xex3K8h/nYS+OIK1paj/CFLwv+VsP5hehXt7XyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgW7XdoG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgW7XdoG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso82514435e9.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 00:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789026535; x=1789631335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ncoEJh5U1cN5FlCpWJf8WOmw4w7aR5yyugqARzW4Hgo=;
        b=XgW7XdoGXg1sUGJgy5TeD4Cb1b8NbQM7u2VKXc0WE9TkpCr5c0e3BbLj0nsvL+0kX8
         SVuMRw+MUnabXZkm9JmvF4QUwy+IZMB3X4pcvH3F8GCIzMUWgBVZ/u8HAVyitWpz+Hr7
         Yjud+fB7XORQBEqnGtmwIC0eWsP1bQXPPvzAdXt+u/Wyl05YAR4zZ6mU9mdIyKjZUHAG
         T8i4LHvJaTcX/g0isl43ADp2/pGG70kCOis/cboXW/vR/htrKVJvG9YANt2EqUxKAviP
         7D8gSAjT70v+R6rJf+wLtu6CFYqUOpvnClOZF0EzM8C2QDeLozdT1h0zpSLG6GKP5c8E
         LGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789026535; x=1789631335;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncoEJh5U1cN5FlCpWJf8WOmw4w7aR5yyugqARzW4Hgo=;
        b=UozYpOPH3CG1VJp8KCdgcKtAZD4eabyGZtcqUefvUoj9QNyljmAUQizYYUlqXG0SZ7
         FQrj9lv48FllT1elseKuyuRy+aEqACrBRXgtAAyZ6UgluC8aNBksfiWIoNXMHuptOHNn
         LuOVQt43LOi1Df3cyxqHJ3ZrWzozSsoLpasupgjmZWfCV87MP+oNpNPBJU8VlgDthclW
         OzQhrZvPZuvmG36dhvByQGjQP2CGOhvBnQGEVGEFhZ2CZg46idk81TW6t+tmSjTb9RfV
         BiDJfs0yhIwfvdiypf1QVszwJVGVx1gEZnD3iXE63Mz9HLeKHx5Zwgc9B999zPAc7+LT
         l7Yg==
X-Forwarded-Encrypted: i=1; AKwUvBz5aryjTrg9O+CN/EryBSkJu3Z0Up+FIEmHZKJh0wnZQJhTX6xQeRHM9Kxk/HiWyV6frqHk/sy2MJc=@vger.kernel.org
X-Gm-Message-State: AFuF++k/K+azodRfJwm3W8MF9Y7MhnZKmma8DZlAFAqUud2/X0Xon07y
	buNhfYHyvtLABFULDY5bZxvW9TDgstMRBo61IQkUb3BRAgv41mIMIPMiRk+KSWAzrsI=
X-Gm-Gg: AYBFou1jvuCb7+IytBERZjpRkPZy1SZGjLzSCR7PPac5LkPXNcGIWE8dmpN6IIg9fPP
	amGwhZ8MI9nqV+ZhfdQe7+X3u/vGUbVWsXtIZhSdZR/C1CLqPSgBwrRMsb+dCr8nDwUPlMID4tM
	SVda7F/vFtv8uE/ajwved9Z4aFqqHhWtlZeiCplIQegX6j/Tu9kFnhPXvFF5drVWJ8ef/vfvaoq
	6mbsTmrhGqM11kvnhInT5Z8Z0E9EnGpsW7RSYh23LNDqktUiWp/+nnaeb6+cZGEOvcfxaQpiZCo
	AiGVWbESCeLo+tdN6THPGynNcIsU5P7d+0OAxN5DSPbESLxXRqh0CGePiwL2E6CzJqlx5UyEFkz
	cmXUoduk5YQ6gSr78s3zoMOb+6SWlz3i7wEUc8MXnWg/fastCPwbZoY7LnU7VCRf3CWDT+yVKGS
	zjZeTrroWUshhIIWpi+rmqVETIRj5pteTbXVeNWROLcr+KQGrQCW6/pziAzVpt6UKxrB8DAX0Vc
	aUjpbD0oV6h9xZStI1XfEQ9EgGpdoCq4brQwQiTokPYBP3wHa2dAEp279Pl0jG1yyVKhbJI2Hj9
	SKfS2xx3d8T0LsY9459dkQgsIuRi3I+MD278Eq5RBjnuGmky1/nYvwS5ZrJCy9nHO7Wq0lMS3Db
	bo3J/s3L2GZC2C/mAoWFcm6t3waS3d6lJwkUlG0zbf/d3U94M0BlRIV2OFBM9/JZJZmVTI4iIWU
	l8yfMy
X-Received: by 2002:a05:600c:620e:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-49cff2078b8mr379128155e9.31.1789026534498;
        Thu, 10 Sep 2026 00:48:54 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e2212193esm10381195e9.1.2026.09.10.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:48:54 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:48:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Fabio Cesari <fabio.cesari@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Brian Masney <bmasney@redhat.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: isl29028: fix runtime PM reference leak
 on error paths
Message-ID: <20260910094852.000052d2@gmail.com>
In-Reply-To: <20260910062449.331749-1-fabio.cesari@gmail.com>
References: <20260910062449.331749-1-fabio.cesari@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 08:24:35 +0200
Fabio Cesari <fabio.cesari@gmail.com> wrote:

> isl29028_read_raw() and isl29028_write_raw() take a runtime PM reference
> with pm_runtime_resume_and_get() but return directly on their error
> paths without dropping it. The usage count never balances again and the
> device stops entering autosuspend for good. In isl29028_read_raw() this
> needs a regmap access to fail; in isl29028_write_raw() one rejected
> sysfs write is enough, for example
> 
>   echo 200 > in_proximity_sampling_frequency
> 
> which is outside the [1:100] range and returns -EINVAL with the
> reference still held.
> 
> Take the reference with PM_RUNTIME_ACQUIRE_AUTOSUSPEND() instead, so it
> is released on every return path.
> 
> This also stops the return value of pm_runtime_put_autosuspend() from
> reaching userspace. That value only says whether the device could be
> suspended right away, so -EAGAIN or -EPERM turns a successful access
> into a failure, and with CONFIG_PM=n the stub returns -ENOSYS on every
> access.
> 
> PM_RUNTIME_ACQUIRE_AUTOSUSPEND() exists since v6.19. Older trees need
> the manual form instead: keep pm_runtime_resume_and_get() and drop the
> reference on all paths with an unchecked pm_runtime_put_autosuspend().
> 
> Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for < 6.19
> Assisted-by: LLM coccinelle
> Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
> ---

LGTM now.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
