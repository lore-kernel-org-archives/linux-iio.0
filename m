Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA77414A03
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193874; cv=none; b=V8pW2NvAdjFCVJL8qBXI+XGxv4PgSYCwIcgysY33hwzQH0Xm4hKuK6cXOcgvOvNEX+ZmMh17ZIJAfpxQLLSgvjyz1BF525ncgcyy8xxxee/Vc3aYrfqkMkPjSyc16z9MGugQ0lSD3mCYYRnbMd6Xc+XMYd1AH4ZTWo8nS/GiQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193874; c=relaxed/simple;
	bh=OEZ/e0YjUiCKKW9fTpOkAY6Bx96tX9uEI1A8iPd7l28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTsB7eYRBzd6LClqJrU6o6rf+Xai6/xon03K66Mg6hx4c38/nFH/qlrP8a+c1Nd6bCI3cHFDrXC5oDL8DAhNsNmgx8O2ff/upLjePHx0kM3TixLmr6rAxnSZgbeN0ebCoXExqHxpI4EHL48SOaDQitRMuuPSAKkJWr/zyCAF3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dblbYNWM; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dblbYNWM"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6ae4475c68aso94023eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786193869; x=1786798669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqOVgeQ8pxr3czPYlvO2CjRZ0GEXGMq3LroVmNRAd4A=;
        b=dblbYNWMcNNl9BZ3gQGHcklohco+kJXgZ5w6I7hki5eqE0aP3RmOyqpzYFelR83lLe
         iGR3GKxSF1pnWrh1YMqvjWiwxol81ZCHp4O9jotL+GAmWewoC6nw73RpdwuphAeO579O
         kzyxx44/TQqFJewCqnT3B3oFIRiTOBfYW7qvf1r1SOp2LyZravo7YSQZUe8hLakdy3bs
         he9I8Pd2Q3RT1rRAPRhEO385tcQwpN/s8I+bp95Enx61ZZYOBxmKkdvtLccZVsNXDc6V
         +sNoQPD4h9g62k/y0EjT8s8Wpg/HQ5mZMCm1N1AWh/2NetHPrBilegALgvdJcaBQa7QH
         kpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786193869; x=1786798669;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vqOVgeQ8pxr3czPYlvO2CjRZ0GEXGMq3LroVmNRAd4A=;
        b=pw8ntSC/WrI4qnAxCEXS08YPnZ+Aj3xzZ1w4SBQEIFFz5GVpwIekIjdaKNNTEPy+dj
         tIvBZBGptp7GsYQEvsySWnNGYOVFRwkHTckgU78apYySkwcBi9k6yUKNkgTCC2Qu6rco
         DWamvOMyPR92g2MoRdvds+NlHCl4sIj2o85G+LIlNX0P7Jys/VLj/z088M19JY4V7hyD
         R47aBHzkyNncJgoZM5SgW/qV3ZIuBA2a495ozrzQafHNszT4j5IKyIoDPUXb2y2X83HV
         wYGVkuE0vGivbflyW8U9f+HbxDoIkyAXO5YN9Br1dPDlO8T4+7Bp6BjrZnPV3WQ0/1YE
         915g==
X-Forwarded-Encrypted: i=1; AHgh+RpZGlDhanuNnC0YLLJVwS/aqNN3vleZhACYXh1ThE4QgTUBtSeDyWB5qAEOEndbpkzWrXnuvadINgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5MxeCQwlm5D9fUIVKdu61RE5BoFCq/aktkLoIEW0cyxfLR22
	e8qFoIRG5F1hgz3grvI2plFfaqGBINzrCnrFz//ermKlvZvsX3xLr1+KqXY76gOon9A=
X-Gm-Gg: AR+sD10ynxMCxNVbc5KqJoUMObiOIssPRWErP7MRIgdIftGs5BQd2tt4I/B3KKbcVdW
	Ubo8BOGOLb/ybarWdEaDg6tZfRI+ORIeMwPD3DLQ3Gz7Ad6yhDJa9vgxQZGc0L+MiOx1O9d7cxb
	SjMPZT3jFGOK+j2EuD8vKijf7hcrHLXobJeRuDsNZwx72QSMSq5kGQM8+744YqZkqhUUSc11XaU
	aQZQm0AF6rqvZam6pO9ko+ed7nof5/IMv3g/preMGCVQei2BWp1aIN37uDVyNOjH9XFuxYvpfkW
	ZdYwEOnpABgL681QuvHRsQMkZW8bOCeuMAK1m349kTPtxvTFLSR22YzlbipLUWDDp8ZEq0N4I35
	/bZq0Xwp9LL1unJjks2VZ8h6q6BQeC0jo7DrmbWmciHWP+Lpg6FvHjRQL3fhq6aFBWUoIb60/8r
	HL/JuISuhDzRwin5UAd8HGzduNQMLcJ0PHxVa+96KdQQeF+snAFSS9PN+8FitiCsNNrQApDQ7rp
	C403IEyGV8+5zOxVKc6TwrfOVSrHYUakXQ4VAs=
X-Received: by 2002:a05:6820:c87:b0:6a1:3ee1:d679 with SMTP id 006d021491bc7-6ae96feda46mr16255133eaf.30.1786193869033;
        Sat, 08 Aug 2026 05:57:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bc7f3d1sm4915953eaf.8.2026.08.08.05.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 05:57:47 -0700 (PDT)
Message-ID: <4072672a-dd9e-449c-b208-4bab3058c034@baylibre.com>
Date: Sat, 8 Aug 2026 07:57:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iio: ABI: add sinc4+sinc1+pf1 filter_type
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
 <20260807-iio-adc-ti-ads112c14-filter-support-v1-3-4d3ba00caf18@baylibre.com>
 <ancEfS1iqZqfiks8@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ancEfS1iqZqfiks8@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/26 5:27 AM, Andy Shevchenko wrote:
> On Fri, Aug 07, 2026 at 07:19:48PM -0500, David Lechner (TI) wrote:
>> Document "sinc4+sinc1+pf1" as a valid value for the filter_type
>> attributes (used by the ti-ads112c14 driver).
> 
> This patch does much more than that. And I can't easily see what, so many lines
> shuffled. Seems like two patches were squashed indeliberately?
> 
> ...
Oops, yes, looks like botched last-minute squash into the wrong patch.
