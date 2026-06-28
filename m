Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BEF2DF6EA
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667376; cv=none; b=MxN1iizf1a/RmdLvOAF/C2zVTuqD36X5ADciCZFQlpdLxYkLQw7NIIuc2ZV3Wx9jOCERLdRMHxZ3oXlTmZk3xkO5lNealrBtxqINb2UThDqxgW1HuMJpaArgOujjHuaXtSQ0VT23IEALoCDbf5Q9J7pphyftZfqU0ElGQ+gZuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667376; c=relaxed/simple;
	bh=sqOjKs10DlRaYigsltasIW4bPet1SFPyLkVBwrI5BJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtZ45UfivzgwXPezG0zWUDnC7+2c1BfRKkL0CVp0YdKBrXI2HHlWtmUZ65ib6GgF9vE46S+a5emAX0JYCo8iSisvhEtTqQ/sR/FugOhVOwry0J5dMA8jqcnD7iF36fGRBkWNNOroCsk7d5QOa58Jm1YSWog09YFpIyCljOQ0bdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Avgf+yv2; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Avgf+yv2"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9ccbb7aa3so498107a34.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782667373; x=1783272173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oh7fEjLsXphwa/7AH4IQmnn1Y/jtq29CVRwa7CFXToI=;
        b=Avgf+yv2DNMAP0xtY1mhQ8S9IVcApweLZ6TvPFIy/OqyIoyP6/SXyeGve8bo0neMuY
         czcMKe7sK4XkDoOhr6/baa+JV37szuSz3QyNjcAiQ6sVapzZGQweHhBqlUeFg5lhL9xg
         8JdMEV2W+k+xzLUg8/kaXayYtBQZVWbF+a46YjkFEtpNjlFn0dAnX95wmIxOIqqcSBgg
         a4lgc1RTbFrj2YAbHZmYbeK8AsYljyaF6tKW9kgcQta5WUEa/ZaehgF9y4vrwP8156MN
         a72qizQhBFWV2dAeXf3xBE3lCWN5xBKBXk9lN9s7/zE/0MYNVCPtaVUCVYlxKkqEYsou
         Za2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782667373; x=1783272173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oh7fEjLsXphwa/7AH4IQmnn1Y/jtq29CVRwa7CFXToI=;
        b=pQgz+3q+/ZJgvhUX2yjjg/Oaqo2c68c4uk83TiH1D7UaDqbnWHd8TfEVOgXVnc+MU7
         IwZIGTuXG7CPjKoruT+z06fgoCY8S0iQBwrNOA3Gu8Eh+WFrwPjSVGGbYGFUA6FrFErT
         VtK4FlDctyM30iWPamUPeFjXdeXxLr9D2ovAUTIgzN838COwqTKxGDNept+079HF3Cu9
         wAc/WDCP7xRh15MnvM1gC4wPKOtSMoQ4NucOC/3/rW2gNMchfa2+rkGFkLNNKmYdi6c2
         scuoF5TeVV4xc0d7qoRrWVMOcKzKJeavvigcSpzcujqJo55YsQfy4ZoqZlKpdB7pKbSP
         pYew==
X-Forwarded-Encrypted: i=1; AFNElJ/kKz+ocFQrP9HSDsrsZTDo3EXmYWa7fTKBsWacgPlFyKxXKTpzo+UIIqWWSMz9uNDH/fMaZ/dG698=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhScp4Rf4iThxzKtCkvKSiX12D+skWCBFVxeN551k3ulPsBe3/
	kA8DfGISBGKtTl1ZP+Z6vpCAFmMl5WCrULiuzbb4U4FEvCxU8uYuJ71TykaaaHJ26Kk=
X-Gm-Gg: AfdE7cl0F4F1SrC/UPMi/qaj8tJq9mZzE7ngTdQ9p8NTGN5v/vSTtu+Lf2i5D6RwHMl
	v/pDLnVFS9QWFVEXVNpkZJORy7h84QkWU0U6ORvdHS21u39v+FSQibOmTJty/1ozC5XTbWK3cJd
	J342Zt1LMKZUr7K0KSpi0BpOeQKV8YJcxK+PsJJE7K5ZGTTZgRE0z5hA4x+1AoPLyb1ruXS3yYa
	Xy5zVvZtLvrtp0P7yIxGsmAmlkcXdSmVvpXwTBZOZMYkqWpJb/N2i4S+R9HwiQCaZ6vcRBYimIA
	l2X8h9cNhHDeIOpCUlx7gbeLgU7/hfTynZOPN+1s4F/pdxVzvhjSnMWh3N9dRRjcN7uQSFaZ32z
	hoAIsm2mbJiAXWBF31dN/lJPEJYyn1aIcm5Gt4XdFseqAWy/2hEjyWSCwsAImfn3y/Jy4o5mZW9
	PyTUUMLojhIOkKqMbuBmkDOiGsHgEyE6PPZhby7GTOnONBbTHWa3z3qlb0qVug60g=
X-Received: by 2002:a05:6820:4dc9:b0:6a1:1292:ec38 with SMTP id 006d021491bc7-6a13523ca0fmr10746261eaf.41.1782667373678;
        Sun, 28 Jun 2026 10:22:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0e7219sm20483187fac.17.2026.06.28.10.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 10:22:53 -0700 (PDT)
Message-ID: <caf89e08-6ce1-4dbb-adc1-7fbb2a60fd7b@baylibre.com>
Date: Sun, 28 Jun 2026 12:22:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] iio: adc: Add ti-ads1263-adc2 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-7-4b1b231325ba@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260628-ads126x-v2-7-4b1b231325ba@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 12:36 AM, Kurt Borja wrote:
> The TI ADS1263 embeds a second 24-bit delta-sigma ADC (ADC2) with its
> own input mux, reference, gain and sample-rate selection.
> 
> Model ADC2 as a separate IIO device on the auxiliary bus: the ti-ads1262
> SPI driver instantiates the auxiliary device and exports a small set of
> TI_ADS1262-namespaced helpers for the conversion and register accesses
> that must go through the shared bus. ADC2 channels are derived from the
> parent's configured channels.
> 
Can these just be additional channels in the main iio device rather
than a separate iio device?

