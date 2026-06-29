Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8D43DA35
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746742; cv=none; b=CYZh3oUymIxWFuxv0OUoO+AXwie25dK4KveYcRLvKKH78ik+w/UV3JuywPnqKMd9T9pwFalInquTBHgguB6foHCVoWZIsC91HMuVA4bonFuWjfG3oXq8u1OgyICzqahm1I4MwKrF9T+MaGYCy/7Lagf6G6IlVJWGJnribbG4c98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746742; c=relaxed/simple;
	bh=bMEqNXZ9mHubK+aM6jy3pBJZxkKeyMW8AyvCDDB+Lrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7+tJgRl8bUaeYyOaZS4dtzeLeC/lb89h34raCpgt/zLdUTXBu52eQkoZxfTa/fMc/2FRjViW1qNWhfb8qKG/A9eeINRD2P5A5ctBkP5GO5fkMd6koAFY89O718O4rNHmYGTVhWc0OksMMNNbAXsww+3zOboHOJxtkiwbKnD8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mJaLXTBL; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mJaLXTBL"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-447bb8bb754so2550084fac.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782746740; x=1783351540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaJaAgaoRCLCjD+AlsRhR9FrqAL4y+0Revc/YO4kdQc=;
        b=mJaLXTBLa1qxGRMHQu77viTO4XIUoCRPMKffn6Frhl+5jxJuXvfhWmKOKLWFtpX3Pq
         6X5ukd4WrfEay3JhK5jUJ9HkVhQ2QrBsnXW3BgscFG95s5xJJgcswBGiJxFiZG8iphwy
         miNpmJs3NhOy8nYPpfH+YJ+MKLXGomTyMRfd1ihBvymSHnOTLbunt/Q6iUpgmw7ZTDoq
         vpjseUl3AKApgG1Gm77XvO+Q0vos+Vi/M1fir6bwwlNRBimriXLFJ9eGIkbJhayPIs7E
         rVo22cdcFtJLWF39Qo1T7JWSlgqA7XTQ7GNaNAavYX5pztGqX+zi4rrG6ek+MEzcrsjX
         k6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746740; x=1783351540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaJaAgaoRCLCjD+AlsRhR9FrqAL4y+0Revc/YO4kdQc=;
        b=WRZOlp+qpVSVTLJurUExGngRidZaxqKC64KO2sibIt9UcrIdlJrdlfeH2lxcs62wia
         QczVucdBtmktN09zaoSRYzARLN1A3ZaweHn9wK0V1mHdCOOjVAhmvP/5hymWKqiOc8Gw
         QZ8H+2ETh4MHesYZrKD0NRBSx0UE812usDD9bMP6WHem5gWTzaMK17zTJVw6uygzmryW
         TK0OAwHHGgMNgLjfoIreekB5zLqgrZvgXXndOTNVpgTG9n+PadmyyfXKEBSwsk05aKuT
         zyc/rubZ/KatUUHNNLHD0w8KvUZ2iJNDYHDxAIdQ9dHxm8LVpaXDfeBZt/Y6HnTfyAPf
         EIkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDPz0hc6FDXytxr9Lcqi2XmZ+Mq+elR7g1pLR6AxMNBKjU1I8SXnnE0Rm7/vFl5W0E1Il43UPrksk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjjwG9QaLdOh/uVHqynuX3Ftbf91GR32o3fzlzdlJjS5fEFwH
	p9eECD+ou7ZdebQYO/xqd32MtNdzAOWtAGRFh83zzzWnzxEK6G8oBc9RddPR6d9YnWk=
X-Gm-Gg: AfdE7clSSs3LESFWx+lB/7EuJs6Ir0Ila92CC4a7C0d/UX0ZxboFxwd+y/xLh8KjKb8
	99cnPZkVxcJgvRaKax07x3VBznJHbfiEmme2qsieE85N/kRwy0VBVg6Cbj9hVhrz3NzxiFYrGlB
	BciSNStBVvzE8gIz8mxLM2KamKXsGVusy6rm8pUVDjmD4qumn3wkv87z2i61gh9Q+FjOT9MhZfe
	wSHj2+S7+lsrf5HW3kr6jVkTTqnTeouFTwMRrL/z7mPc2GQXaYEobB5t30OKQ7YzJokvNERhF3p
	63k/fVLYrIgDi/fD+lSeUer8PfC8UfMYsm8p3m4qnAZTXDeia/39WZdm8MxBEDZBfSwlb3UkXoi
	umP+mHMqUCFR1+lOEhrVBtA4YCU7PWbXMLYzIPow600JPN9TnCZgL96AU5YVHMH8ydyQMtlFI7D
	BuHwp5o4tl5Y2xyFe8KZKJPYxu8Zkzg8LKtxS7Q+ZKiUdZCNx0orzflhe8fra6/8k=
X-Received: by 2002:a05:6870:9693:b0:448:6e54:4819 with SMTP id 586e51a60fabf-4486e544f3emr4992977fac.16.1782746739826;
        Mon, 29 Jun 2026 08:25:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3533:aa22:9a69:df1c? ([2600:8803:e7e4:500:3533:aa22:9a69:df1c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-448dbb2302csm70720fac.7.2026.06.29.08.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:25:39 -0700 (PDT)
Message-ID: <9b179166-3057-4867-be04-b071a809f70f@baylibre.com>
Date: Mon, 29 Jun 2026 10:25:38 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 0/5] iio: add Open Sensor Fusion IIO driver
To: Jinseob Kim <kimjinseob88@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260628191337.937-1-kimjinseob88@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260628191337.937-1-kimjinseob88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 2:13 PM, Jinseob Kim wrote:
> Open Sensor Fusion (OSF) devices expose a UART/serdev host interface
> for a sensor aggregation hub.  This RFC adds a Linux IIO driver that
> parses OSF frames and creates IIO devices at runtime from capability
> reports provided by the device firmware.
> 
> When the corresponding capabilities are reported, the driver exposes
> accelerometer, gyroscope, magnetometer, and temperature data as IIO
> devices named osf-accel, osf-gyro, osf-magn, and osf-temp.
> 
> This remains RFC while the binding, protocol subset, runtime discovery
> model, and driver-facing ABI are reviewed.

If you are just looking for review and don't have specific questions,
then it is time to drop the RFC.

