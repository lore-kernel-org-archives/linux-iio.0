Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C0366546
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932145; cv=none; b=F7NJGGl7NQSCugCHRWTUvXnF9CDnvnAchAIUkAFNuKJBXtSz1HSbbRDVYd6deXidA75Y2DulbLKSPeG0ImUoqOhy+GDjoxuDyEBOn6R3bNqGcKCaqaCGrS+fAo31HUbstSqlux2OmKZN61dSKTeyIp4C3MbjxBAgbygzRY6vesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932145; c=relaxed/simple;
	bh=YYkUvCnkd2TVZbVC3/scBh3gWInc2MEenoUizI+NAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtPRaDl/M5uoBp3B8ohBovSKrC8LtrHjl6fgSstW9riuSt+NXy4ZiiEFpFbxhx4l+XLHLD7RW7wzZlf7BmW8emgIr1ZrBTM0J0VKqahCVAY9rKrSYyFvMFzEynKnllF67oxfKF7ln15oFwW6WhMR+v26WcV5uh2Xohci+ufVPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWqsJE3s; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWqsJE3s"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d572f7437so4203731f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776932142; x=1777536942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZAkCG0aANfsFDZm/TfCRMjSmaZiLzbNxZIa0APK6uQA=;
        b=YWqsJE3sZF4xQP54qICgCbt0UH1IgT+Cct75xJxjQ/ksOpkCmEsWWkxKKLSQndV6Qx
         1ewISIqDQ1Plrylro660AI9+M9sU9ZDoFZh9vDRcm25azBHKex/6TZFeS8LiGTKGA1W0
         5/sk5PmYqV9ra9HqEDTSZIQYflvSukMWboojZaofraHISyN5NMT9+p5pKMrSqQFDq8A0
         7WQTjd/IIJIYdbCbeF+oXsFzfHnb7HMpv6/ua7aMGUtiR/4uzd8hdQJY4yW9aKHka/Di
         OLrZZ2PubINzboCQOmvY+N5jOJKJIL8oXtgYd8iIDYsB8YbqYBEOzWMxrZBgjN4/KZPU
         G5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932142; x=1777536942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAkCG0aANfsFDZm/TfCRMjSmaZiLzbNxZIa0APK6uQA=;
        b=iftHzt50nVs+jS/HCqhtgBQUNWCTCEznF2hd3L5LJwU2JgWn4KlhtZQ7+6mZxFvp+8
         OLHllF0JWDH+UPUfpHKwjuEIslKGFMTTVjtv7dtvLwWaceH1BK2YjBDGd5hXccldKzih
         c6FNS8HXEA0Mo4ZXRQT9KukE1dbIogTFgDxkBqg+mbO/QC4++Q/RfRpF4lV1Z9AmYMk8
         BZ5y8zEB8xmQboC89DiY+K8SaMNXd4fBQ4fc9alPzHz6joo0DeFDK/cXct0swPPj2Nuc
         q5US2hHmw79u4/vr2W10nfcwNP9OE9bNVKdLNZ5ao8I8FbQ/N7fSLYCgE9mMf59oH4Pg
         zegw==
X-Forwarded-Encrypted: i=1; AFNElJ8RDxE9nDXzhvfcQ52ysdWZUyAskY4Y+V0tjylAu7TGg2RC89HYU+yRbAa6B1MxYhhxzbToHEW8x2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jIwFiqpYhHMLnJiEDDDgigkuXLCofLc7jWFhIN5Wdj0hLpbL
	8/ZvYCpk+KZAaaiytZw73xDlASMHExzl8XTU5eMZdijZdZk+6//fkCdc
X-Gm-Gg: AeBDievojiLYB8ac4BI9/eMXy1ng9qvpSnjgyFV8g6Y76YAMo3lQkEIT2FWHJl35hTR
	juHpU+WszcnW4NahIojLjg0WVJ0QQD+RdkGxXpb3NVHJIgp8uUo4yr9Bwsr2/r3veh5VzVxAkSR
	Tr+ckkfR6Qvc8fM0PFtXIvBPboeqgXa6DDCbCAYbdaX5Hg6bsqX6gRYiaSAY+JNBzUyrPYLMIZG
	5e/eJIVZOKH6fuMs8Mbv51nqnURFaETumWMmtUZfDTVqHmKVcPwsTTow/OcbvsVGss8slYTGLiV
	fc48k2hKgRgngmdtqitA0X+YvUGfK0Twjj5xFRJl0T/6idTCigEKjfzgbuXDobfzLzKevVjG0WT
	4pIsGzyRjLH9QcqdpomDKwnNZ8dxaChzAlm351bQFfmZdHs6nEn2H84ExtWX52e1hLy46jQ+YD4
	HWhHlJPGQRznC8ti6chhy+Ke5t
X-Received: by 2002:a05:6000:2508:b0:43d:71f4:7ecf with SMTP id ffacd0b85a97d-43fe3e1131cmr39851301f8f.38.1776932141888;
        Thu, 23 Apr 2026 01:15:41 -0700 (PDT)
Received: from nsa ([45.94.208.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a174sm56755930f8f.18.2026.04.23.01.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:15:41 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:16:32 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	demonsingur@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
Message-ID: <aenU2WZnVJ-esibn@nsa>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421165856.2245598-1-sanjayembedded@gmail.com>

On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> The listed maintainer analog domain email for Cosmin Tanislav is no
> longer valid, and he would no longer maintain this driver(s).
> 
> Replacing email maintainer with list, to keep it valid all the time.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
> Changes in v3:
> - Following input from Nuno and confirmation from Jonathan,
>   replacing domain specific maintainer with mailing list.
> - Link to v1: https://lore.kernel.org/all/20260418211336.1800221-1-sanjayembedded@gmail.com/
> ---

While you're doing this, could you take the opportunity and also update
this entry?

https://elixir.bootlin.com/linux/v7.0/source/MAINTAINERS#L1837

Thanks!
- Nuno Sá

>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c981cbdff500..6498f0aed1ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
>  F:	drivers/iio/accel/adxl355_spi.c
>  
>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> +L:	linux@analog.com
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> @@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
>  F:	drivers/iio/adc/ad4080.c
>  
>  ANALOG DEVICES INC AD4130 DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> +L:	linux@analog.com
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> @@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
>  F:	drivers/iio/dac/ad7293.c
>  
>  ANALOG DEVICES INC AD74115 DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> +L:	linux@analog.com
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> @@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
>  F:	drivers/iio/addac/ad74115.c
>  
>  ANALOG DEVICES INC AD74413R DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> +L:	linux@analog.com
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> -- 
> 2.34.1
> 
