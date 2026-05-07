Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0D2D8399
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178292; cv=none; b=JeA4SXI0hSr/P3z/G7Nkeskwd9C0KD5PFFeSouoPhDIjJORoguO8MPBSypEYuLlXut/a12muiMcCnxJraKxExgFSIM5/UjvLuriLbhiW4dzLtn33q7lbdu4z1M0WcVkfVEbT0mM72T1KFODjTba1vKtKuFJwaFYSFfQLyg7Tlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178292; c=relaxed/simple;
	bh=q41XWtmnRT5g3mpwlBKklnVMfCoiDo9xFmj+qJ0fkJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVvuAtr51WJssQ9N3sntIfxiHo7NU6aBCB5ACIn1CRlVJX5CRIDaisE0DysefvCfzfQ5IiGgIxt/egEg7bXQF0woX5j2Q4HWDLbe7Fsv3HKWChSowTmJO+Z++c3SgGQXtNZk7s7DTVboeBc3cuiy3U+7dItYc9yJxHcRgNL5a10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SErIseE3; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SErIseE3"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f30a4601bbso1328606eec.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778178290; x=1778783090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2rGV0MC0xkmaHljKfxDGXfn32sdZGKXbeWbQM1LbbtM=;
        b=SErIseE3vKugr5Fng89g0BwsvyCQnC+uO65KqCOnGvbSDgf59FSNzkftcQAz59ZXYv
         EWN7elFZbtVFmwu1zWkW6EfoxII7c5FXz8Sk8OEQbbGa6sLYLinMYhur9odwOqPG4sTm
         TZVUb/YxFYthqKVsi0ifUtzzVRdeDEKiu88NpnCLyddyzAwkgB7OWWFADHVStkx9+5UA
         4+prurGbFfFv9yzLUpXzm7k2Y1l9Z0r0a56MWRnhUJShFIbBa768tFQLGP6RLZzqvRrk
         uy3MpktO/bIXE1rDd9NrNWRU8Z7zvW2sBHcqzUfEgcIx0DzxXnL00M9eCJDjAknoI85P
         z8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178290; x=1778783090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rGV0MC0xkmaHljKfxDGXfn32sdZGKXbeWbQM1LbbtM=;
        b=Z8jcybLW8NEm5Vd5HiKyyc9lIPRYq+ZerM0SbILFQ/doQGlkcoipzSpN8Chhcg3uGQ
         xG/2/qmV9Ya28cTzHRKp+HBx8MviZgVsYpeLP/IfeSYjbJRwAS3zKiCsxHRYeLtTeOZ4
         4OXAiES2xwbSTkPqUap/oz1LU/tlKSvuE9HVqm8kTQTuX2vKzewAuct8kpzMJZtZJdSn
         XOukvHMA0D8T38xiVWNOMVpAmlAHkaNL/laGP+qXO0EeoTnDXBUVNt66rZcBOse6jj4j
         BA8j4TFsrrszvr2gCUqXN50T807m510N1tqBAI6sbcGv5K1ntnHzpVLiDHy7zEAIqFwo
         dpzg==
X-Forwarded-Encrypted: i=1; AFNElJ/iuwoZCc+x7UIrSaKw1JbzxtAoaZ958cJJQ5D216DndKsG/87QAwjspIM4B4vYdtOPI4hTs7X+jIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8r1Lj1cRz632DPq2EwmivKVhHSIWmtibYvOiIIEUMuqZuT/7
	rxZ+FXyuzgsFLbtpmhA3DJH8i5GfDH1bKPPtPqRsWANc0gT8cS5s4wWh
X-Gm-Gg: Acq92OGY9AK9ZgCy6Q6hD9Ipjg3ZJYEr2rwFVhs+PlHIi0NfFBjlLvZN8ymdamcCZtg
	t6fnywKBSObO0j2Pq3AXS/rnj+zNLRAR7/1r2j0Bfsu429ebPbIl84pzeWDhQle0c1HH9gRYodx
	dwI2H4+RBvzc4BAQudgcezVWMX1x2RUNEwGtUJprYd3C2AXZdo4iFgjeNG4eqXfhrKlRl78RqgC
	+PrpTmC3+OC8yWYV3j6ijxamKYB/mUYv7ZVUrX1jfg/AGXLQ+OYTYbdGB+Mcpk6gsm1sk/ZOF0H
	sGcbv46djicLazz4KEw7Sxs/qFjKjhQ7LjzHiWz96MorEWuLIYJNXyP4/63OtTz8dwwsBq30sX3
	IWQiO276TvP5v3ww0uORfmWOWYKRrc8gaUJk7M6oYBYNb6Gz4hGmRt8tc0RMuWmHCGZpSdAOWil
	nAI9xn4HW0296Dy7m6dlm+nvnDdH0u+A==
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id 5a478bee46e88-2f54c587faemr4875414eec.15.1778178290087;
        Thu, 07 May 2026 11:24:50 -0700 (PDT)
Received: from localhost ([2804:30c:b6e:3000:875:bcea:c04e:7fef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f82b563a12sm145430eec.5.2026.05.07.11.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:24:48 -0700 (PDT)
Date: Thu, 7 May 2026 15:24:53 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] MAINTAINERS: remove unmaintained ADI IIO entries
Message-ID: <afzY9ZgmSFIrrd5w@debian-BULLSEYE-live-builder-AMD64>
References: <20260507175132.3063161-1-sanjayembedded@gmail.com>
 <20260507175132.3063161-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507175132.3063161-3-sanjayembedded@gmail.com>

Hello,

On 05/07, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> The listed maintainer analog domain email for Cosmin Tanislav is no
> longer valid, and he would no longer maintain this driver(s).

I'm fine taking maintainership of the drivers listed below.
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>

Unless it's preferable to drop the entries to shrink the MAINTAINERS file a
little bit. By the way, if I get the point of the ADI IIO DRIVERS entry, we
will no longer need to add MAINTAINERS entries for new stuff that match
ADI IIO DRIVERS regex. Is that correct?

Thanks,
Marcelo

> 
> Drop affected driver entries that no longer have an active maintainer
> or reviewer. The existing "ANALOG DEVICES INC IIO DRIVERS" entry
> already covers the corresponding files, so no coverage is lost.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  MAINTAINERS | 35 +----------------------------------
>  1 file changed, 1 insertion(+), 34 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86b2520d18fc..6f8b61d66f6a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -632,14 +632,6 @@ F:	drivers/iio/accel/adxl355_core.c
>  F:	drivers/iio/accel/adxl355_i2c.c
>  F:	drivers/iio/accel/adxl355_spi.c
>  
> -ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> -F:	drivers/iio/accel/adxl367*
> -
>  ADXL371/ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> @@ -1451,15 +1443,6 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
>  F:	drivers/iio/adc/ad4080.c
>  
> -ANALOG DEVICES INC AD4130 DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> -F:	drivers/iio/adc/ad4130.c
> -
>  ANALOG DEVICES INC AD4134 DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
>  L:	linux-iio@vger.kernel.org
> @@ -1556,23 +1539,6 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
>  F:	drivers/iio/dac/ad7293.c
>  
> -ANALOG DEVICES INC AD74115 DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> -F:	drivers/iio/addac/ad74115.c
> -
> -ANALOG DEVICES INC AD74413R DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> -F:	drivers/iio/addac/ad74413r.c
> -F:	include/dt-bindings/iio/addac/adi,ad74413r.h
> -
>  ANALOG DEVICES INC AD7625 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  M:	Nuno Sá <nuno.sa@analog.com>
> @@ -1877,6 +1843,7 @@ F:	drivers/iio/*/ad*
>  F:	drivers/iio/adc/ltc249*
>  F:	drivers/iio/amplifiers/hmc425a.c
>  F:	drivers/staging/iio/*/ad*
> +F:	include/dt-bindings/iio/*/adi,*
>  X:	drivers/iio/*/adjd*
>  
>  ANALOGBITS PLL LIBRARIES
> -- 
> 2.34.1
> 
> 
