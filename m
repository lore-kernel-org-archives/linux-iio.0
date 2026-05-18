Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8E449EC5
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108671; cv=pass; b=oy0Icb8s1J7zYWTG6l4/qZMvfuFQxuDRpLznBGewD60Qcbypkhayn2FtlsRHp1cwVT/1MYgor33M8wUlRXkDUHqSZMpXqIcaQXdiq+ioaTds7ecCJSwg5AM/EuFHgHYvaQMXmTxIB2/u8QKy+dwxlXMdV59NxP3LBCgtK0SO/GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108671; c=relaxed/simple;
	bh=3xZsA1EQdUTnM3K+9+rZZVCf4GsAj79x+j2RgB2i6Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B205jMADhJlgW803ej7Mz1A3GvLS3rZgLJsWtPTG8OnzDe/6xw6zBHSU6lcm3G7gzdsnHkyx+c7xAjSf4U30iFPFvH/8HexINFcp9MGLB2lJz2TW/dlUvUc2fS2DP5/L6BH+1JD2aZEBeqkuiNlzgzcvnQqx2v2OAMrtKSw3X0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/ATbkNg; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/ATbkNg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-453903ee4adso1922672f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 05:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779108668; cv=none;
        d=google.com; s=arc-20240605;
        b=inwG6aH2eahc3m0Oa1+8Bm94bI8e7EGwYoLhm3Vxlkk3DGk46fVfEeqfJ1kzZMf2cQ
         SoqhEO/EaTRW0XR7PwrPvKqiUHdBoA338tgoH3jYwOB5OJRMJDDATGItkvFVlAm+EjKu
         KurdipQt+z5W4Kk4MxlkXSU+9ny8NzmsosBjWZq+ZrRsHraJt00/d7zGoNPFSK0sMlw/
         i9B+Hga4l+MoEEuRHa1f/R7886TbsD6df0vhJ3xBebWRMbIUdo45prf0sRssjBjSgjky
         ulBViFNPjP+BCOF/NP3AjHBud4KBSlZXG4xdluv9LQDp8r7dIFF+Dn7bWU1/QJB2H1RO
         x+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KVSSwreBmj6BUKqCeoSJUvxJRda2KM6i6vtOQyCV7Rs=;
        fh=e4w5jBAJWHu9Cyb6FhYjJ+QCB79PALviH9H6s1r7nJY=;
        b=AgKcX1UX9soCAgbveGWq2yVheUtselAXnGWwbIaFEzgXXsPrC9Mxh+rX54y4ZxkK4z
         COcZRuicGRfd0nk+h6ooeKcwEPeSnmOgCwlruTT+qBcSUGVBOA7ykAdztkOE6FHvBH4f
         cDj7B1T2f83CQHqtEysj4OHSrWP+GVc8+jk9Yabz73Mm15la9jfofwz2OVOvU/Y7OE21
         TEzygaJ49SonlY5o27M0oi/Xj3Wugq0Cd8QubP9JsPYpQozVkDARAsDJ/0AVTNv4i4Bj
         dgemXicjpgrz0RriHfclPqZMuuUpJQoJnJlxg1JXn5aYhrxVcSQi7HvfXpzl3uYFT+Yi
         6PCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779108668; x=1779713468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KVSSwreBmj6BUKqCeoSJUvxJRda2KM6i6vtOQyCV7Rs=;
        b=F/ATbkNg6BcemWwjeN89yaGngvwPU9Oerc4VNtrjWlOITQm4gtPARhDaFxxsSsTB0S
         FAxVV9i4JjPGcixN/PgP8ND3gR8Lw6yns2i2CYxDIq0TyjJHtORiLl8r9NiqBtkiuteu
         LZtdCfyTs9+r0HtPF2vpkFxl+S4oVLYbRE3CwOME962O0PRTNwPmE5J3CR1SJQfYssms
         R/Bqc1Avf4dhhCm2RBXHJVudfRrp3oE2tq/vDvNrf0NVP2FTYZEyh0yd4zseAbtbN0VJ
         1Q5NswhDm0gKJpvDyCy9IkAXlZG15Ypd2AJTG5ILx+g9o6daXiZyDYJ/vWLs9zRc4XsC
         cvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108668; x=1779713468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVSSwreBmj6BUKqCeoSJUvxJRda2KM6i6vtOQyCV7Rs=;
        b=UigpO+AmqFz21cenw56BRnLnmSoZeGMEaIqWnUsRR7tKZFvrpccZYWEOBazj2IVg52
         TIV+blQ0IAVZxChNrcfY/J6ccp5yycxJHfvvjjkPqBXu3xnbC5TyDihRHODLtlLKUQVn
         CIsJUv2WxTCK9UgPtAqml2mfZgUoUn44/qAM6E64u1fmYI5yemCYE8GMy9+k8+jHZTxA
         M7FJpQzMMb+xG7Hx/fDmaKKL5kFtcwf/7Hdh+tWL5FFm2cF6M/BxrpezSU5HY8Mf/uO6
         iPW+FqL+dUFm9pFDl9oOEFlzM+FZ8hlJ8wjvkR+mmIEV56r5n7aZ87BcpOzx4QU5wp39
         WzoA==
X-Forwarded-Encrypted: i=1; AFNElJ+cDrMFEQocecr9EK4pmFXj8/bYH1bpITT0+4DC3oadvZZpHUg5AZowgYDBaePXrC14682EIfanhaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWUVp5Ifrd/J9J2lFtmoCrw6PqvOXdLdTEe8V5NLw7RteUueD
	3USjJ5hTJ7tgcHMKgkKAH+lfGw0Kk7bqeJVdDj/sfCLoqQyjOilm3eE7JcsWUoIU95DUMWeC1kq
	UHYACd3TCCy8602o/d+g1FHyJuu2UGG0=
X-Gm-Gg: Acq92OEyhjwioIu8+AVYIjOzIno7D33SmcrQvlVLORPAJcUmQ+iyQry2DVkCkU6m6fn
	Pf1SaQ83e+KUNBacdt4KAfk8NrNnG7iUz+E8xlmz+w2WjTMH0u8oedyN5gulN+tFDRv5DXQD4pw
	V0BgJzTdfjBYPuQr9eulwV4ru/CaPZWBD/GSBbximXyEHTwZowP7h8dUiSgw66QhIiUokGAAggE
	EivTHXVcX5TNjilMkC3/grM8qJpfGWoT7z8INAXRLF4bIQCMBlsy7oAmhmJrbvYC0PV8EH0LchL
	GWLut6b8JsfdPHzy6b826zXbaZZk+pevDzE5Cq6a5o6r2k8CsKcgeIyWBSAnBsC6apAuNwAosnq
	j3BOWYZtu48HOV8GuVpafSlMkDHBtySMpvpPcd4zOVjHnlEIC7YHry8uOMX9n9+MQEXBh5IcoIX
	ZYYKFPfgf8cFniLgvu
X-Received: by 2002:a5d:44d2:0:b0:45e:739b:3e3c with SMTP id
 ffacd0b85a97d-45e739b3f89mr7217630f8f.0.1779108668403; Mon, 18 May 2026
 05:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518114502.219375-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20260518114502.219375-1-lukas.bulwahn@redhat.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 18 May 2026 14:50:55 +0200
X-Gm-Features: AVHnY4JxxoQtajvr5dtFHjLH6n8K-ka8WVANAXjkpcTpZ4sRSGQchDL69-ctH1Y
Message-ID: <CALoEA-yikL+PRDys2tXY5GKZhZtWRYdfhsczrgUWrr+rrbZqBQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in ANALOG DEVICES INC
 AD4691 DRIVER
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Radu Sabau <radu.sabau@analog.com>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 May 2026 at 13:45, Lukas Bulwahn <lbulwahn@redhat.com> wrote:
>
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 963d07535e77 ("docs: iio: adc: ad4691: add driver documentation")
> adds a file entry in the MAINTAINERS section ANALOG DEVICES INC AD4691
> DRIVER referring to the non-existing file drivers/iio/adc/ad4691.rst. This
> commit however adds Documentation/iio/ad4691.rst; so likely, the file entry
> intends to refer to that newly added file.
>
> Correct the file entry to refer to the intended file.
>
> Fixes: 963d07535e77 ("docs: iio: adc: ad4691: add driver documentation")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
