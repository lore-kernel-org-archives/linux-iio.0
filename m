Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEB2475CE
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770489841; cv=none; b=U4NUBOKbqZ3fTnyTNOr/d+60F8vUmCaHSw3Ol2XRUmDwoGOaGTX9O2iB1ovDsZc0G2BdewulvkTa8kkL11YGDpHexClqjZgKTFl41qMz5RfJMp/ZuRWTtfzZBpJhngOkw6xrpXsnWi2I39rSVRdpT+Pt/VVOP7fZT1PeSg9Uafk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770489841; c=relaxed/simple;
	bh=22neKB79fF7PF+NCRuGrpHzEtqUdhauQr7Y89Ve2PvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBus6CQd3QWBBLh3m73s9oMoonVDfO9Xr2kQjDFGTqcrFpvgfzhDlx8W9vK9+g3DPlh5Zyd1lBINiVERPRhiK96lrqnJiEG0fV5zHkug+0o2kfCcmX6h88iU2DuJan2Ul8xOgb0gIG64o6aOtEGCBjdl2D4TNgbRyyUZ7wcnwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1SApbZNz; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1SApbZNz"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45c9f47e1e8so1124598b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770489839; x=1771094639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhGHKBHX0mp4WhkPQ5KScP2KrjUHgqP7Fc/kWzxNrXo=;
        b=1SApbZNzyzcqsYvT+yJCIevJ1cZ8P61FiP4bmqkzb0Xh2Xg/VSxLxf8IESdx3gPLPE
         nRCkLle7OMlkBPD5odJYSyOlZ56j0v3oPGCNLcmPjOt7t82onC5QaggsxMm4T19iv66Q
         atZZLYAbDIPgSPgDVsanCePsVOGIPo+bqUu2C/+IQFDY2eaGpSMMhUqpYuiehzNjQ6yr
         CtLqvtQl8sxM1znNl+8l33IkVo5V9pRce6K64KXjBwHV0mkDO4Z0E3A+Xs4mjI5lzqW2
         +kFnVIK4DWRkSB8VIMane1Jh2OlB6JwII1QBwl8BYJXd0XxXY09eMmYVcIquOJF69aUu
         uM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770489839; x=1771094639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhGHKBHX0mp4WhkPQ5KScP2KrjUHgqP7Fc/kWzxNrXo=;
        b=k/gWvMuchSOMi54Dpd2yOHfpKi8qyHM6kos5/L3HzReP5rt4vtpLUWJ/g3uNxd1Uhd
         hoBVHQ30vPh7Rx3CHogzjvGgE2D86voNalhLkyWaxWGMtoexZWfEOF5XC23HURa4CeZI
         ChjMIU+xO0TM1sdnHku2tAwYOWFOweno68fa5iwsHiBxAgUbQj4xTkJWFJb6MaLB8RGC
         2qGcmktNsuZsQ6Tj2HEXtHawgKEnS9rGzf5+x7NPMsTV9Rn+dolyNsoFw53AhqGMlhey
         fgIY2eci5dTB76JKpe1eUI6WH8jnCluKeWjH4KVUOsHTMbKUnJB8F4DbiMgmlkDid+fP
         dvXg==
X-Gm-Message-State: AOJu0YwS/D9c4jI0GuLOG4k+0HOEoJupoiSjwuxN7/PxolOA9wEmkLDJ
	jgB7U4PGW3VEDNnovZ915bPKFMS8EjMrb58YQhLNoHk7BuKGK2qlrgTria9/uQ3D/uU=
X-Gm-Gg: AZuq6aJzbzuTxky4CuON24iggaskEO82OtC9xvGKteQu4L54NWaCuw3usjXVN0aVMXj
	DP1R+WAz1metzfJYM9hhQ3CgLoywPwXl9Z5IeHlgQSEfJpKisDxP6yWG6rEbqWiQMoil1MFzM+V
	wbATFkxVcNmgJ3XvG/6JypklaCmPgLDUyFDqaUy8LrushkJinkEUBxkkrGT9O2hRY7mwyXllrNs
	703YubvBXoCkKF1JVgWFtm7OXmMo0tB+5/sOCc6AIC+GLrsRRkIZTTJgT4ywGsqhO9t/BIHBx9R
	aXcLeMSwa9jwlpmC6vw9emB9HUIszU5LZOgucMKUY37s2xj0zJ3p/QwTuGE8cewXzV2sH8YnT64
	udLAwVMfaCfvd+NAXrdNDaGwtyh9SRTxk0LJjxpV2EuzVSaVfRhlzEbc1nOVzUib1/J+KKDqE7c
	Yr6f0EoN8pEncfSPDa6Ar834nUevi+6AcgIwWg0xGI6lElvOPlhGyTA757tQ==
X-Received: by 2002:a05:6820:22a4:b0:662:f4cb:208f with SMTP id 006d021491bc7-66d0bea66d8mr3312820eaf.51.1770489839460;
        Sat, 07 Feb 2026 10:43:59 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:74a6:843b:f33:21ae? ([2600:8803:e7e4:500:74a6:843b:f33:21ae])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66f0bceee89sm1025873eaf.8.2026.02.07.10.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 10:43:58 -0800 (PST)
Message-ID: <e55ee581-efe7-4ee6-b0ad-df0ad32626af@baylibre.com>
Date: Sat, 7 Feb 2026 12:43:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] iio: adc: ad9467: Support alternative backends
To: Tomas Melin <tomas.melin@vaisala.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 6:24 AM, Tomas Melin wrote:
> To facilitate backends with different set of features, add support
> for defining capabilities provided by the backend. These capabilities
> typically extend beyond a single operation and are therefore not
> directly linked to if a single function call is implemented or not.
> Furthermore, the capabilities determine if a certain set of operations
> should be attempted, or skipped by the frontend. This way
> the frontend driver can work with a minimalistic set of features and
> still have the device in fully functional state.
> 
Looks good to me now.

Reviewed-by: David Lechner <dlechner@baylibre.com>

