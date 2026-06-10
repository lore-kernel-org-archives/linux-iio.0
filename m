Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492381F936
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066764; cv=pass; b=vESxOwggA34VwFQjJrGbzTXNhGAolB6j2z6tPZj68yCRl190npFA7UbPkXMQ0A+4e6yjLbA5vliZSkgmMNClYx7fhDU5v5a4hND+v1LzjYU4MQ9dwc/TqCQR8wMP95JvOCwSV8/KfbB8+OQJUeoWemAuvYfdzslBwpBJtCqaa50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066764; c=relaxed/simple;
	bh=P8428hCSppZXTQhfWrm0FHo0noQQSZE3weEEZ9n7SHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSw69mcHoiuJatfyD3KlOuVIYouA67aPSZVwBuEY5CxyuVsQOqp9zU9BRoxmIgMwDv4oVMN+HzQZJrs7Eppz3lmJEDCJvFp9vtf4mzqJMf7Cb4C98rI2qXcnZsJ/3VmYzMcf87bf3mIQp43DCGeRu52PnwMVFsAh0v6IWYKtpOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQniw95D; arc=pass smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQniw95D"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-441080fd7b9so3998100fac.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 21:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781066762; cv=none;
        d=google.com; s=arc-20240605;
        b=V/fkm4RuamECKHGpBTQXIhL8oIaXzq+oL5tkOuWdu8HxyrA/kbuXZbCHtG5mDHAH3Z
         TTahm5MUph3hQTveY5tNfjKeCvaVmsoDJC6nS/9CcvaRju8/tSHwkgfSC/joXF82NmKZ
         YQec9eYu4GfXbKKKVTeafnsjWrrsRwaSESzkOIdKDBqH7PhVUTVK8zNDY8QXFFoA+/IW
         GxgpbMcC1YqpsZdhZ6Y0lxNDB5esPQIIgccr4zTaaNL9MezE0Z97behBl69LGDsERcJ6
         P0T+MSGeYbY25rp6lSqDhRPJrNh79vFX3F5KVSMlWlPw+UtI+vvA+aiUsXVFdAGwIiBC
         mtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gNxOq2GpALVlyS9EMBI35GCpe0RRxgi4stivcRbDUeE=;
        fh=5QQ+3/2KSMInvi9Yl5SYHZYfPK88fVjZkSnPXJv3SWk=;
        b=ZqjcE6drb+6PSens5lwJjDO71O6ia3U1zPa6ZsDKA5nel0H2Io6SyomfmN/ECMledJ
         gn0PDlbKCxB8VxjB9MRhcL6fDvpclUOekcCutxdVZo2UXk8TgoauRAzsoIolYItVs30A
         TBsFjPDeO+ZMcP2LyT2v/EE5yJURtUnHttgX4O5M40BebMs4IDpD7Aa9Rx1fhpH1stO/
         G5Z8Khlwlad/AEnU+TSMEHGhjYVJ0nV4uWmmv7Cdq2KUiq2R9sI8nVaWZuXBW+X4L+h1
         GxMUCtn2LKNKTrFrtMOUDIeFdjmZotHNko4lDCjvZQTI0GTUoVQ1OHclCa8jBCxKjhja
         p7KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781066762; x=1781671562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gNxOq2GpALVlyS9EMBI35GCpe0RRxgi4stivcRbDUeE=;
        b=NQniw95D3RaHuf7ZgBswagAvJAcxXxoSRXOzOpB70t/boJBh1tg/ylfq9hccnNRw4M
         3IoQby4zFPqPREWr4lWueHid8pYPVo3xy2JeYQlUF6+ZnSMmExGvdTJrSfQpKGwGGgbd
         1AcNzPaV+/EqsywLFmjonbkXzfvdxlwyOggBmtBCY2S2dW6sMZlsE85y+6/4GtFOZtni
         cKZuw8x9JF0cJ39taQUUioft4MZiuXxtZ/zc6XkkBxAPx/eVcLNW/0l2w3SMTNFovkrL
         60O0GEYgkGayiV0xBATT7Eb5qR8UWNzCFU3RSAmb1cDVL0j6pjNaxae6Gy/BNB5nXxXt
         FNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066762; x=1781671562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNxOq2GpALVlyS9EMBI35GCpe0RRxgi4stivcRbDUeE=;
        b=WCzlLsqrxgCQoXL/JHcF0X80AVIr55Ele7t1Dcn/ADlBBdicPAxVeqXkDVFlMtP0N0
         Xbu7Pj2qHkrUpdUTukD16kwwaJaKaWhBjDEIb9di6S8me76FgsT80FCrTrBDMdGYl9wQ
         VDO/pU5Qz6YuC/WIIFzzbJ+BZj+VZ+FZjo4+ThtvQDw04fa8XqSr8JIxA+YhHaToAWJ7
         2yDqsBd4bfYfINLh70zbeZGIKkQWOYvG+jG+Em3CMtCGyGJt+wel5Hxz+NEv81AV7WX9
         A37vOuG+o/N6rWvdxEDKgjtZ7dYRdOygzv8Q37o0vYb0avLUorMIPBlyltvvkfERFxbC
         wqjA==
X-Forwarded-Encrypted: i=1; AFNElJ+C2QPkmLmqqvrKOdEWWE/+joUV5NMbeJVnK3WIZprWCV9FcyOsSELCLB7QVO98zWQPkh5lV6Hc5qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyj31xYuFLALTk/Ol0Jwu/lVmxde+x8I5FJh7RkP0uXRdwtFnr
	rfjt4exW61JaSmB1p+27zXr4v0r+gNpZfWDLK32y3veqo09e50ZMd55ibeO/IvvrCRSJv+jHQrr
	dxWbNc1XvKdGfDubLTzIQi4BfI1xKUz4=
X-Gm-Gg: Acq92OG973sWdkcNJ1281vPAlK1PBF0Z9rllMbr50Kr+NDTB9ahgKXyhg7Iy+POc4ol
	BsChIVQKAgIySy8C9gKZh9g/6feF95Hk39b8XQi5Kk0fV/o12XOsTkW/WmCjYRH+Ss2ouau/v8l
	jlHsOG4tTBn34w0UbqDPT38x7OKtoCovzpvpkF7jJASoUj5y0jDs/okyCEa/I2ILCOAeFhNDLGJ
	0i3LsKq1HahLRbBkZIfCtRsJyrcfs8mGP5R5S2dvSfeka+oteuKuLaQCYbuXV/rqmdVJtfPBvjK
	RFYaoscA9DixiTa7Q2IUGkJIw4IM2EBs9UGkFuvPx9RCuD/B/M51
X-Received: by 2002:a4a:db85:0:b0:67e:36e9:79ac with SMTP id
 006d021491bc7-69e68b9665fmr11323350eaf.27.1781066762401; Tue, 09 Jun 2026
 21:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610042418.90308-1-dennylin0707@gmail.com> <20260610042418.90308-3-dennylin0707@gmail.com>
In-Reply-To: <20260610042418.90308-3-dennylin0707@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 9 Jun 2026 21:45:50 -0700
X-Gm-Features: AVVi8Cdy4RPa9qyNPKqZtsFtfQ9w2vGPJCOnx1wnzRVYyqG4TXGn18u_z5GsQG0
Message-ID: <CAGEkeHcqb7SAWVbx6-R0dXgOvy0mXBWvLso1aTo-wAG3002uJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> -       odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;
> +
> +       odr_val = FIELD_GET(BMC150_MAGN_MASK_ODR, reg_val);

Thanks Andy.

The blank line issue was inadvertently retained in v4 and
has been fixed in v5.

Thanks,
Hungyu
