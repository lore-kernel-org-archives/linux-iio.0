Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268D425CFD
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835632; cv=pass; b=qqMRgxWiH5pVSxKurOvLEfYJfAwfLqmybT+xZuO7RfhBshUoSo2uEVoV3RZBZxihXWoMwozTwx8+YTs/arR1j0w89s3x+zfk8rqmAkPFZ9DjkkEELi57XjZB+978k1RqVVm4aVZhfgS7hpVI91/tId6NBPYOPZx6cymaPl4LqyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835632; c=relaxed/simple;
	bh=F/X+K7mq57LanIUzere2hvolhecmdp/IaOj+v5+0pyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBHSzH6eGV6jzzoZ8SLsy74lAXv+Q8Wisg8xA+4vAHuZBhartk+UlGyUhPYPUnBgVTeB+GRV4APz3DvgXA9rJuQ+EkYv/Zb8ej/efyDlCOKkjO5Tc3PclD73gMjzn3buP3cC+O7QBiSbn2ltZ4v6TdBIarmt4wp5EfX4nUSyMj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A52d2FKi; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A52d2FKi"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-441209fb77eso381459f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 02:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778835629; cv=none;
        d=google.com; s=arc-20240605;
        b=UPKPxl6i202VCe+DIekvXVUs2yDDMpQZ3bQuD7CJ/kB7fA4UALVi+/rDBNIb3IQuBt
         yYpWhuVf1V6Pj/Pa7QeSTmNsgHC+w6/s2JR9lsaKnPgdwxCJy306Vai7wzqhIGLyoSBJ
         FkRyfoXyX5huAUMldl//u/jNyYTsCi7r55zOVK1MI1CqeX1ybl/Trza/I4d/yR4+5u6N
         GeeNF6F3Ni56dq/jgtf2YuPq4Qqde2WuDh6UMNxVUg5jwhJmrMoKpL3rq85QaHjaHZMA
         n/Eny0G5xcLvts+nzoi7v85oSfT/0kFpV4QCuPZs8OYNh+G4TQX9Bqy6KC9YmZjEs3LG
         54DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fSEW1HYxOL8S924kl6mfYFM2UkEZu01y2bHFTxrJdTs=;
        fh=m2UQ8btjq/wbVdwHbM+bJ8RfXQNV9OF3rNFdPYPYW1k=;
        b=Rr04mHZo5YrH1QVGwAxa8c1Kc1HDnCI7Ie5LCHtXrf72LWnDwulmtkRh0AXBbRMyVs
         cg2gH+/JOpTw4KjaXI8laHPDUmljxlHNQ3BPzRGAynTYfAjfJvx7qjy8xoXCug4aqPRc
         QqlG2oKKipJ+7sU+ESa4BgAH23c/O1avKipawkjadZNCIW2SuYOm/KLj17XTpFvpvnwr
         kYFZLvpIrvEegcO3HWF7zrW3vZC1ffJk+p4/Bg6EtpyKFs+uLpdeBJX3i6WoT8HCfbYu
         LwI9W3JvGdX9KbGNhFbOEZS7kO6zkJtmCF/LEWFtY3ii0n/LWO9YP/A73pRiai751okp
         WcnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835629; x=1779440429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSEW1HYxOL8S924kl6mfYFM2UkEZu01y2bHFTxrJdTs=;
        b=A52d2FKidQ+wv+Wcf6Onyqbl1WlDBNfXRttqanqgV3M6Yo/WiwrQ9nG9vx/5am4LzZ
         2RZAGuHlkuyCcySPaK/pSGtyMi/KFhWCQQIGhVWJZeLl/qGgj/ERQinNLmiC4h1M2Ttd
         QCPwtc3aTD4rjHoSRy9/ZTJoK2/1YKdX1+54jvHj4gxXyPnw+yjV6FoEYbEjRJg5BVqf
         QZ6//6diwYJ3YAcBrX/1aFBLDOwY4hdiDhQXWvfALmWXrp2yRqMhO8vlD2dAdTAjK2ib
         Hn906ioEHLFLkV1DLmUJPs/jvGfROrO/Vc0MZJaymNcVBhqIdgcmU3IcdAeeUPNKICTq
         fGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835629; x=1779440429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSEW1HYxOL8S924kl6mfYFM2UkEZu01y2bHFTxrJdTs=;
        b=QwLz/4MZcEv6Zb61Nl5BtQqzgdSvNBcNd44HdF2cqZWSSnwoCvoBHiyYBM9A+fBOCl
         DPDcnt+AgJ/STOE3xX9E6lUZuO1FVlOuMFGK/fqzX+kXxlj4cVbkGwhpJhqpJkw8oVwt
         lItB4FRm7dpEHxgmfA1Ozgq8fP43j9cL3uOnWbdxLB9rF/DoZ4hFduJWlSHmBPTP9W5r
         6DnTijPvI9+MB8MIwaIYvQMhqIYdp3X7w0dfvBFO7+evQP+7LJzswrAH6+QOzBXiKIZm
         Bb1I3Gifl9b6/S6A31bRswcXDKhxgOwAecfn4RzW0eBkyrMG+cVYJNwHNdRSbnpEifZT
         VM+w==
X-Forwarded-Encrypted: i=1; AFNElJ89vE4CgtQHeGr4eYk2gElohynhvfRrM8rjVOZYkcuJN7K8WV+zm8LAQp4707MAv5mvvyRs3Q2jwz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMkYTDEt6d90Y0DQjM9zuzRbOetnDRwn4W5x5Kq2268643i6Y
	Z52ROk0eS7OjuzblL37YF5UfkEUH4MIjH4Xo3uG5MJl821yaWYKV/v2YIgG80T2PNump50avz7c
	ZjZTNITud9QiA7bGaT9Z/AppTznrpons=
X-Gm-Gg: Acq92OGr9Gx+ENCKY84cRLs1uEz7NJKjiKzQLhqAI0I9LuxFkRwW00pTe/MQyMHf8yW
	OJfvHhGHKXKRngD3TTBPF8v7UJYgG5X+J6dLAgd7DSM33zkY0XZAqUrbssbkgQzM8UQhazU3pz6
	DLMrv6lOHzqCIDVsxERN+3hTqCkdIa6WyNqeFSf4r4bIUn65pqyBtOW9jbO8aV2Z4gvqtMkENDA
	wIeAdD+wrE1eGCTIMKDiopzC9/eX+Br9nYoRSqbNOYUHRKzLiCrTaWi58blXhlp8bjkoPr0R1fo
	+uVQ/wgSLh5Sr68AowDcGX8IqQEJbfwLl3VL/jyIqEEdt34ZHfPcpiHMgd9qhjr40WdcaGHLvWo
	79wVJyLFeCBM2USEJFhE2YBTwnqrP/mBKREcT8TiNTKDjM78sLwAzVrE+oUk47ePi5jCNZ6I4S8
	YtlOU/AA==
X-Received: by 2002:a05:6000:186c:b0:45d:2efc:dc6e with SMTP id
 ffacd0b85a97d-45e5b895b4bmr4803889f8f.20.1778835628703; Fri, 15 May 2026
 02:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
In-Reply-To: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 15 May 2026 11:00:17 +0200
X-Gm-Features: AVHnY4Kp5BeexoywxD3HdfQW-xQ6iB-Lgl5_DxsLl3wuKsZ5H5iqQcVjeUTYCwY
Message-ID: <CALoEA-x31YdsdCtubOw7o1GBakCBcc4ha_KvuP=W5URBHyZDtA@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 13:38, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Currently in the AK8975 driver there are two instances where potential
> uninitialized kernel stack memory leaks can occur. If
> i2c_smbus_read_i2c_block_data_or_emulated() returns a value less than
> the size of the buffer, uninitialized bytes are retained in the buffer
> and later the buffer is passed on to IIO buffers, potentially leaking
> memory to userspace.
>
> Fix this by adding checks whether the return value of the function is
> equal to the size of the buffer and subsequently if the value is
> lesser than zero to distinguish from a returned error code.
>
> Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260513-ak8975-fix-v1-1-104ea605dd54%40gmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index b648b0afa5733fd7a54bdf2b8f92f00e924c074b..9d23c8136291a52ca9ab928d81332aa32933fec6 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -756,8 +756,11 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>         ret = i2c_smbus_read_i2c_block_data_or_emulated(
>                         client, def->data_regs[index],
>                         sizeof(rval), (u8*)&rval);
> -       if (ret < 0)
> +       if (ret != sizeof(rval)) {
> +               if (ret >= 0)
> +                       ret = -EIO;
>                 goto exit;
> +       }
>
>         /* Read out ST2 for release lock on measurement data. */
>         ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
> @@ -871,8 +874,11 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>                                                         def->data_regs[0],
>                                                         3 * sizeof(fval[0]),
>                                                         (u8 *)fval);
> -       if (ret < 0)
> +       if (ret != sizeof(fval)) {

Hmm, Sashiko pointed out that I am comparing a signed integer with
an unsigned integer, which would result in type promotion and subsequent
mangling of any potential negative values... will fix in v2.

https://sashiko.dev/#/patchset/20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf%40gmail.com

-- 
Kind regards

CJD
