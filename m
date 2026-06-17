Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6A39936D
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732602; cv=none; b=guPbJNnWi6zYKwmE9oaY6hl+dphwKYq/UUk1ewRSM2odwO7mMNVfIztooWBLZogBK1OgEWtU6I9PDJ2N8V/9pPjcDo9P1EKBqvmy0ozwX1GHbcRZHtxR1mNN6cblW0N4Gy/IJG8k0PEhkrDP7SwU/C60K+6LuCqH69GHTYwXZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732602; c=relaxed/simple;
	bh=STd49iieVtEz/Mng/F8+k4bjVOlJZ0xuDkER0yL5GTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9g5Bc5u/g8kEcwg8skMZLzaa7q1YDonS+dw1TZmwozM/xynlg2V9+77qAULslS4eGuaFCpQN3XDwO5JeGmPXQlzvZKRSaP8Il1vo5gZ2naoPlIbVbOa6xBJd5GVa1XZ9aRXJRlT2DH98m2msUR2TpMlnQw+koqUJXg0pS2hs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=d9GHL7KT; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="d9GHL7KT"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69e4483cfe9so768116eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781732599; x=1782337399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moLf1HfI30fPHYhYl3mY3kuDIYItGKUlS6CPPB51Qa8=;
        b=d9GHL7KTyxsmYAH/hZulR6JqiSCDRJYTA7O1/h5l83Kj5Z4oP9+aSXHOhTzCSA4grA
         yjYL4lTjWKJOnW66s7lYNPZSh87bkt5wBJbzAx8pvbs3YryrDCUuvKnToySXjQaJu86q
         O0b7iHAtFnYPGs0qEM/sfIMo4pj/lWEd/85I5QzL5unUomqMzjYV4fUzPFqUWGiLvDHX
         9HlaTi8Ak+mx8fSdYGA92uQOvXpnRWHeL+R8kLs8pC7j8t0KXmC1B7uT3G24uTIMR439
         8ghl9FkxXs5fj3LveZTRhqIcBNrTDiO0gRp6DHMqOYqGDYwT2cF8H2Q/kqq8Jcv4Cpuh
         9o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781732599; x=1782337399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moLf1HfI30fPHYhYl3mY3kuDIYItGKUlS6CPPB51Qa8=;
        b=sutsg6tGHi6FLbRqrwfr1jU0NhWzzD1m+rc5+xbc+xKuTSJC41ex80Rlhflv08euWS
         P0/6XLnyARb4ocXD+Ydoh8xsFmiK3hRlPV3HkwEghgjqxWJEALfokt5JnmDPrb30vGgr
         YjhCdNjrbSPZpCR9luysDPFLuujRDb0G+ObbDkpUmvS8LwZtI9FOoaM4SusQ12sDyzui
         JN8M+XxTCfYZozOTKauHA9MEOsR3xB0ddwTpAIgUoQLwq8ZBcbAQW0Bl9GUY5uHGfnwK
         nCsl0TS/PusnG9UgTsx40SxTjBA6US/slZg+qqRWwcts7Z36OcUNq75QTPJv/VYm3SJX
         Fnsg==
X-Forwarded-Encrypted: i=1; AFNElJ86X9xN72Tz0kv7cPISVrJlxBuhx2WzDapZOqSep/MBdqSWi3ymy7wgO5uFuJB5u4JmKdB6SJaKmWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqf+uJAFS3WQCRROwuc3DxX6myiWIpn48leBIwg0aTRnKr8tun
	nlo2OkeIAk9dMUzL/8x5gMPrh8a9qBU1/Q3P9PmjEm8p1vtlE4bZD206zygG6GrzDLc=
X-Gm-Gg: Acq92OF5coaGGCnYD2RyR2RvUy3ieANx1KhNJ0SZoVlwUG6Q+6Hw4HXF8PORRF65mh0
	1Ic8uE7sq0BajYRPg8cLWcwsIsjnNcqbA4JSqvTD83BCw9ZloghYsc2AEKEzQ+wsVBFq/XD8+fv
	CbBkJNMuJQFY2vUeNgHBCQk951Y5+d8StO5HPBmKTteq7R36CM9Gt+bIYWZ0FJdnzweBK08cMFM
	E4JtFZzIJdlyT4zAD9oMigCHof4CPeCq56lIQWqsxBluC3dGiVEnD5ZDGitb6tvXgsUuNnbupiK
	IwNcubkuub3wHB2/SM1npegHX722HYPSkM+10RMgZGz9MfNxotgCeIy6uOteul32qGkJQhAJGcE
	Mu4sDi3gzzPhlutwISWQgvDMn6SwnX5n2unxMKUTjV4oShuJJQQUBkf2kmJ801GOsbvjujLminE
	XnORUPT30gztbrt3p+wMk0UeAGmNCYx7v92+c43ZX2CdSckNABZRGQLLPlrAqek2RFfnXnCpmyf
	w==
X-Received: by 2002:a05:6820:16a2:b0:69e:b86b:1a9b with SMTP id 006d021491bc7-6a0c73eccf8mr742417eaf.25.1781732599378;
        Wed, 17 Jun 2026 14:43:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9458:d356:778c:22ac? ([2600:8803:e7e4:500:9458:d356:778c:22ac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308b0057csm5540529fac.8.2026.06.17.14.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 14:43:19 -0700 (PDT)
Message-ID: <3b96ec10-b022-4135-9ade-6fd9eb6e78a6@baylibre.com>
Date: Wed, 17 Jun 2026 16:43:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/5] iio: buffer: Extend DMAengine buffer
 interfaces to take extra sysfs attributes
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pop.ioan-daniel@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <a09f2cac2d26fe385f1f7790b0db64b7d9953ac6.1781661028.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a09f2cac2d26fe385f1f7790b0db64b7d9953ac6.1781661028.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 9:03 PM, Marcelo Schmitt wrote:
> Some devices using DMAengine buffers are connected to extra hardware that
> allows setting how fast data is transferred to/from the buffer. However,
> those extra pieces of harwdware are external to the sensor chip such that
> supporting the transfer speed as a sensor property is a bit of an
> inaccuracy. Expand IIO DMAengine buffer interfaces to take arguments for
> extra sysfs attributes, enabling the transfer speed to be configured
> through the buffer interface.

This message is a bit confusing. It sounds like it is attempting to
control something about the DMA controller itself. But based on the
later patches, it looks like this is just so we can add arbitrary
sysfs attributes to the bufferX directory. And in this specific case,
a sampling_frequency attribute.

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> New patch.
> 
> Now that I've come to this buffer "solution", I have pretty much convinced
> myself it would be better to instead have some sort of IIO trigger to control
> the signal source connected to SPI offloading trigger module.
> 
In the other chips with SPI offload we've done already, we just used
IIO_CHAN_INFO_SAMP_FREQ to control the SPI offload trigger rate.
Any reason why we can't do that here? In the original SPI offload
discussions, IIRC the general consensus was that adding a trigger
just to control that was overkill when I suggested the same.

