Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC33C3F6E
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136531; cv=none; b=Vn5wx8rtRqdpLAqRYND/8f8rFUtJFq+neQlPvRoaYL797p40Sc26PAMGOMZnKRRAaMeCuldizoD93zszlX5o2xqC9t+3A6YZh650O4C8wa6xGdSJZDI4RXy97THNYFaA5Z1btERDMBa0f5XDpZGg//iNjNwau508I4LxTTIE1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136531; c=relaxed/simple;
	bh=ca2rvTqJaJ0l44/M3BLtPDmJgbBNlx+t7Oc64RAbPQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilEYI0Y+tw5Ba8m84CsG2myOuvsn1v+8XSwCwYBLGQ4qh4lfS+EMx+9OjGdi4W8CmSuc7BYM9chOtNIIgsSr6mGaW0gAY+yePIPGDe0PlyUyaRYxX+oaKXvEQQdbvLgmdk0s542V6eFMpVDZiEFsUeTyy56JxjDHRJyDr3EV8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bITsE6oP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bITsE6oP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so22888185e9.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786136526; x=1786741326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ca2rvTqJaJ0l44/M3BLtPDmJgbBNlx+t7Oc64RAbPQU=;
        b=bITsE6oP4T75+ZUQ2uAcq9tjfocw4Ee6HaPGHfHotl5edmrjg8xo+7nfzEQuTjE5hr
         vPhsOzYeTetFEEN/6XDDOZaxDwEZ/zuokBik6c0gRpuLp1cHEbC2APizT1Ka0iQAmbIw
         7hAR55NushhEObyZ8UbwNfRbe4Y+n3Df5p4pko4zgC5Nqp2ujH0IGA2vhYpjgoJFiVID
         r310iE2EA+5UwGWd9y8TSL+V3/WJycDwNGN70hD6UYoduszBhVQTYM6WKlpKBix9V5oD
         yHynHilmGTq+uuZ0CGqZ6J9hwVUHN/pLMHMqh/aEuDX5KdKhmGnEUAAFwcrKuFmN5H2u
         ybfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136526; x=1786741326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ca2rvTqJaJ0l44/M3BLtPDmJgbBNlx+t7Oc64RAbPQU=;
        b=pJ/hOtXbpPVTXF41RZs9ICNKVOnB4RQWZgLaJ6Mom4m1J4BfT8i6Y5xVYCU/TTX+S5
         yGZ03w2cLRe94bWE/XeohDCgUcPcU6r4HYbuPtqsicqE+RqtQ1vvgZmt/SVGjko6VqXb
         gpwV1e6OIOi+MNAP0r8QY5OhnLEPXYClN7f6xUMBQ1U8/OcyZJ/Vs3/TBXYVrZ/MbqC+
         b4erCyDaszwFlq2AqU0jriX6NkEn8KY2iFFzPl741AN5hTpOGM4Tm7GUGnmoHtGC0DrP
         NkqtGiFSy8CSCSqhh91RjeEYrhYQhkKfHPTW/rkFGas73bK5Pul26Xd42QJknAQzW5Ee
         hzJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpxq1dVOrq3i+02T6sAbBYSHFPn+vnXHUzULhozCCtxtwK4QZTrN46PUov62b3olDag1dVepyMCCig=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj95yqLgXU6Uqph2YsHUBCjIdls37rCW9o6JB02vfJFJ0vG/+k
	7IP/3MJOt0EZqcFK/5drXlFY8XsLZFkLc20WqBSEyfobjvwIj86xGefjUCwhLuopOr0=
X-Gm-Gg: AR+sD12Wnu7hV1wCp7XeCSAzyUuAIKo5uQuDNBhNns5KjFjVAcoDqd1Q2HMZYciPz39
	/TO7dDR2qtqfPebWV2YnDKVNG1wOjr3Cf5hJpYW7j+jJAUBmpN7uNOUl9JcffoEF2Rd+1YjdMK4
	j00riUcKBYKCJFyfKoCJP+mSxt3CPnJ1OMrAIY1n3SMTnDd2vSGHp4GyPQT/FqiLVmeG05FH0lE
	qxaoDBi3InNoCB+sb1y0DRz/nEmpQfGH18RwVnFMMIq4/hCau/rCctO05XNL/gaI8tf5kM6TA1z
	6LPACDfAtCqJpayLFLlQNvzPEKCUNeRpR60O9ixcggt3t7QIod2tJ1rsJX4GXv5cPaJWo8usAE4
	leRYag4HE9iQFwhhwlIKR+TayhG9Bqo10IThh+JQP1jTJZlPtZRWhaavr5CQObYZy/8zqg8WyyX
	PAb4FATMWngMdOkCL7MgCubAHS5TTuvtpqaVMs+hNQHED8ThrfhKVCDClPyaMZ8RuUFg==
X-Received: by 2002:a05:600d:8483:b0:498:1371:6612 with SMTP id 5b1f17b1804b1-4994e7a70aemr270467195e9.6.1786136525974;
        Fri, 07 Aug 2026 14:02:05 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4995ea3361esm69056715e9.15.2026.08.07.14.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:02:04 -0700 (PDT)
Date: Fri, 7 Aug 2026 23:02:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <anZHcBfAeGB5gY3V@monoceros>
References: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
 <20260807-veml6031x00-v5-2-e60876fb3640@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="touihyfzdk2tirvq"
Content-Disposition: inline
In-Reply-To: <20260807-veml6031x00-v5-2-e60876fb3640@gmail.com>


--touihyfzdk2tirvq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 2/4] iio: light: add support for veml6031x00 ALS series
MIME-Version: 1.0

On Fri, Aug 07, 2026 at 03:51:53PM +0200, Javier Carrasco wrote:
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

Please rely on <linux/i2c.h> to provice i2c_device_id and of_device_id
and drop <linux/mod_devicetable.h>. The latter header will go away soon.

Best regards
Uwe

--touihyfzdk2tirvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp2R8cACgkQj4D7WH0S
/k4Q/wf6A3pGoHTJI1Jo0utoGpCFl3A2mA9rAlVwEacyVXio2L91HCSucDU82DEK
A1O5IP5u6aJbIqz+ZkG3fEGZlnBiRqN72KzINJNDhf8cpQ/RElwo+vIdPbLRlXC8
j98QII1HTZMvxJwQSK9pH8G3TRVs+Wx3/eNUv/pUeLmnNmPJvsBPkv/nkJQjaPpE
NtAowdUP1bEBNscNe38WHz0wQIiTj+q2Zf7HsORhvt7VXWgdg/fEFvMSTYfUrF9o
aM/Tg3JCfX7AzsdWb7bHrrIYCtVv0DFfsdGcpj1gVpCfgm2tghnFJVjl1f+yDRLQ
YBYhiGSEDKTnOpCL3w3VI7yExYlOvQ==
=Gsu0
-----END PGP SIGNATURE-----

--touihyfzdk2tirvq--
