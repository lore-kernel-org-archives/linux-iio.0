Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8B49C4CF
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299451; cv=none; b=koDC3AwGZ3fW1U4Owh/3Rx2woEymt9IwA2sSXqDYCWE3fIAqBrMXSGKF5eEex4EB8V7lpxysQ3YxDoU4ox4kCvrFPSaTg7vgPJJs2YwCvDoEt7mWKoYvlGRO+IMzQk3WC95/mh8THBw/JqHuJ1uMe1+4vpoo/psnIpjcqxGQ10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299451; c=relaxed/simple;
	bh=CZzQYMQ0CaouLEUN3WcNvt6IGP+hlIKiFum7Ja+K3MM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqweM4nWXcZHljPkKVmHn6KVuFDq1zQGEoLMQ2u0VtffPIYDj8zp8EHrl9nlhtAPaU4oB3OmSSbz2pRCsajdwJixUDAJTjN/89XZRix8uiW026pK1uum3HLIfxY++C5NJNRpgDSFLjiuyWkvFnpr3QDwOXg+AZugh+CQfDsfRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTPH8fna; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTPH8fna"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso6525965e9.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791299448; x=1791904248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nmOy8UDU42FfjcKIpdai+HCHqrBu8cVwJxEwsCYIUb8=;
        b=JTPH8fna4wWTnv2sItNXpeCvcFsxqVxBz3avd9L1dxAvkGYeWgy4u99gz8eYEPUmrQ
         yvR91QlZAA2vKUJ5AmqTXpIBgq1iZTbanDMa3OXDTZ8I78UmIH19FGftOEvzgCZzdm+Y
         NTum6ZzAOljhvywlYdz5CQ3yiVcRDEX3PZhH8aH4TX3yT4Nr45nUKMGsBRzEXPJeB5be
         4XJVDXvgwUmcQGqfbP0oC4N91iDR9cBkzdF7FO+noe9hfmvl7g2i3TZWDeRU56zcFFT+
         CYX1LurPvtmEQG+14IJIX9/UKkQ6HL7S65hdkj18dPOpm7pxHCbELeUiAKbU7MudphGe
         K3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791299448; x=1791904248;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmOy8UDU42FfjcKIpdai+HCHqrBu8cVwJxEwsCYIUb8=;
        b=mA2k18h/xS1jhqpuAr9n0Fx5BQdkZjL0xnGVeN+uiQkLaK/XYEvERqSecjkanmYDMk
         9p3e3DBDgZEipBGy5pptZSkNbbxGKkFfGs2V1Eq49+2p9ks+tPmaEb7rGVClmdb2FXEN
         e5VNlMsvYzzTcKPoDkZiMnWFn7feph7EDAeeWJcBk540MOayMoQCkSCOwqqwv7TqNdpU
         229M8NvLJ42jqU2sf3VCIvQ59PeipqBLd7e22v+CJ5TE2YsQwC0rlZwuM5XCHpI2KQrP
         cr3+PEtGhMkRbF/VRaSMJyY6WFi3ZcyQraCESaHdbuNwKu5dmH2/YtoGIUydj3mP9jDw
         lboA==
X-Forwarded-Encrypted: i=1; AKwUvByojOHiH9a5vCiYix47RoZm22P2Se7jG71SU375W71EaI9OQhUpZmBpoj8l4E6ndROj2SYw26n0kgU=@vger.kernel.org
X-Gm-Message-State: AFuF++l6VsIOQXBMN52hNDkO2gKjGBruK/PTs2IeRnd+vA2m8CkPSmiz
	FTTJSMKHiKx1x4vfvHgBVTCWjCtT0CPhSqzn2Sgys+DgOKFMRo/McwpX
X-Gm-Gg: AYBFou0wWoFmhWTjVNJI1vApnbcEKyOn8DS9dvx8jzABGbLF9D7vkXuQM+3qOgmyh41
	d9CUuXQ0azptTyxG1I7WYA/xMFZ7dWXEYIUqq12403q10OCcVaNNBq3PoPaT0dP/h0/xF9MsLT6
	kWLoznOF4NBuHvYL3TxkL7DbEvMbC8GS5tHt/FB+SlEOb7IW7LXGf5Y0bfexL4YxkZ1B2a9myhg
	evVYg/LIWVer0F6SMVDoykdAzbb1fE9FHUgKa4Ib47e4uTGwIWgDmAwLrheoSYArYZ0ztOVGhFA
	rCOhrAD5OlNctTpS4zcIX9LgjhHi56vbXxIGKu+3+AVsqRKs2ZNHNAQgJkAI6KWKIBy0TCMLqIH
	uVYimIer+DHZZ+vGMp4G9Nfk4vMBKe1ZdygEsbQLa+KbaTRhnyXOpbfIaFWvB+Xg0+FilbdYDOz
	itoRmS07yuwiXvtRuuue9zLVQFO587f1atx3rZJuAlHh2EWtEioC3PMdyH1fIYE94qS+3rEYOgP
	vUnuS9el36fZR4409CSK5wFlNgljTZJw0D0HWb/Jx+Hj3ytxqQZ9Q3Vc8bRHv2QHSxuJYARt1NP
	sP+yh7XCuybSTDE93yp2MX5PrRaEIkJaUdCIHYvl48d/u8IkQzN/gqCna+POhK4cO4RzUUb5UF2
	N+hV3CA4Pt7edNv2IN0IM7UECkuZuurT2Eyt1qdrjHOcqsIg5dQIxZ9W5b0A1yC/ayS8Kd0kSmc
	HuVSVr8lyX0nxW1rs=
X-Received: by 2002:a05:600c:4e11:b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a17b554d8dmr27260815e9.31.1791299445565;
        Tue, 06 Oct 2026 08:10:45 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm73243025e9.3.2026.10.06.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:10:40 -0700 (PDT)
Date: Tue, 6 Oct 2026 17:10:35 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
Message-ID: <20261006171035.00001ce2@gmail.com>
In-Reply-To: <20261006103350.32853-1-abdelnasserhussein11@gmail.com>
References: <20261006103350.32853-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 13:33:50 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Replace manual and unsafe character checks (e.g., buf[0] == '1') with the
> standard kstrtobool() API in sysfs store functions. This ensures proper
> handling of standard boolean inputs, fixes potential safety issues, and
> adheres to the Linux kernel coding style.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 94 +++++++++++++++++++++++------
>  1 file changed, 77 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 20f6052cc7fb..21a1b811a142 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -246,12 +246,12 @@ static ssize_t adt7316_store_enabled(struct device *dev,
>  {

Please also include linux/kstrtox.h.

>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	int enable;
> +	bool enable;
> +	int ret;
>  
> -	if (buf[0] == '1')
> -		enable = 1;
> -	else
> -		enable = 0;
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
>  
>  	if (_adt7316_store_enabled(chip, enable) < 0)
>  		return -EIO;
> @@ -285,13 +285,18 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config1;
> +	bool req;

Hmmm, req is a pretty vague name in my opinion. Ideally you shouldn't
use super short variable names unless they are self explanatory/common
(like ret or inx). What does req mean? Could be request or required...

(Perhaps I'm just nitpicking).

Otherwise LGTM.

-- 
Kind regards,
Joshua Crofts
