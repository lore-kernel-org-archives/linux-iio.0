Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14083E715E
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993953; cv=none; b=TcWy4nq3qMGJLEygVoE8r1QMXm6PVoqUCHaKHY5x1Br4JSsnuSEoZdX/2CETv5n74bc16GQqppNJiz4KX4TRSnmo0m0KIvjtIIHaLK9fP4lngSxbcyG5M3R8anmwldcM2xwCE9RGDGxFb4ArD0k3Z3dMdkixHNwQmddcgQTpV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993953; c=relaxed/simple;
	bh=dwkFkckx8A4lLBC7MNotRBFCE13hS9ANi2U4ayVEduI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBFFujSy+NrO0cf47gvc1xSQprZvVP38KPNL5mAEfDx36MKJZhJav7jplBKUK7MFd6roNPS2JNNhCd82Zc0suspK2iQ4+GBbXhxuwSIJGMafIXJ3RKsz6bxAVzkMuK5H1U8l/AyYkKwsM52f3KNNubZuM5qvSSBADUuqdSazXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yot3jYum; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yot3jYum"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so7506347a12.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780993951; x=1781598751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRVsCUYNC1QWFnnUTXYvdwCGlZn2yVPna1uH1jTZ0bw=;
        b=Yot3jYumJmO/y0b6nP/Qr/mWyuzoYZXV3MSuhzesudnqoMUzFE5zBOvf/KbCws8bfT
         Ps3JZ+sVVSPWPq71RZyx7LIGHjWD2jrOq0cZsIty/yq9CkJwX6dRuYJfJ8g7r610odVW
         QrCk/hZG3apyqTD+zwkzuT0hlDRjl7w1EU2Xa6f7ffyWuNP0P8h7U8WamUnlk7edNvhy
         ipuyz2+ykNrK2TLo9LrJkjAqArFLcjgBWbZpW5SF3Yhop855O6pvR9+qm3d03fwdPpws
         s/3niytXMv8fIaj9r4azaxcWVyzDqdkEt3xsygvIKdiMeKFwg/tSIm2bP3SJuAcN+LT3
         JPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993951; x=1781598751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRVsCUYNC1QWFnnUTXYvdwCGlZn2yVPna1uH1jTZ0bw=;
        b=bLHSSCJrUt53ckq/hqe/5kaP5KSKRHCguZb9yP2Itu5ygrHXPhxFT/Jqw2eF5JmYdt
         FyyG0cAFokmgHFo+vOymb+xo8FQAPR/nlsGx43KmLrfixPEv4Biw26Ud6eFsUoTuqlN/
         b4p/qWsRIaZ7ygDqtYHLi426uEo+6wHvWT54AXLK1vEKrJ/GbdBlvgdvHyF1UCjQED6T
         GLhCO2c9QVYD0T7SRa5HpgtWBWeXBSxCovwIph8uHzAeUbVCwvSYR5a7O86ye3HBh4hR
         W1FwyfobD80bSqfYv9e37XudJGK3/EgTZmxvrssmJG4XAV/7w3FZ3I4IGoVuig34oVQO
         XnfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Yie9JEQlDoSoEXaoMPdhHhxpw06swj0TVNc2hjYaQZm0PBsqeVUMzr6zIVWAJYiURI2pPHrbV0i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHN9FcWTPRFGeBJz2fCzwiT8LXxhL8f1SL3BCLnCHQ1iZzOLSt
	i5vjEuIg3VQt7X7GjT4+NTyPetJAIFt+jHSp2szCc3jhcpGthC17/Ru+
X-Gm-Gg: Acq92OFxfV8YGFgFWOQ3ALCMD7/0d/JihcdnKoSX4+Uz+bS2lP/40ExwYdH7cvvMJhg
	JHBCHs0f7uQE3f9zRdAVYsp3FNVekLxgt4g8HsKJoGYL9SCKgD4k6FM6uI/FOHHPzNUJbaFN1iV
	Mab48dnAtlIVhiQaz0uKRnLPmIZBVdx4ffj/yZBsA3bJGh9kmWj9n4+PefZMNk72WrTBBv1ru7i
	peHnPEZVAVw37Y2S6r+Jv1fXHzRO9Zbej0JEzCkrCUeREdDGFSnPVeF86D/ORxrE0NTmNT5JpEZ
	nkSaEZgzQ0YmqUJ+kdUaB9cJ+E76dBmtngk9XbU+vP3klQWmyWmTKQoqKXlliP8bOxPc5Y6WMZj
	qGsEc4x2fAjB12GWpTu5EuRY/ikHSiRMexvH5Uwz6PZlL+L8hoFxb78oHi4wbPIilOdPzkRtVkC
	zPu/cbJMHwWEbq+aJKQyQ6RlG8ia5rnU5L3VAr7zyuZ+GCeE9okU3MGjAgzSIuJYNs+WWXK6VD8
	IAsBM4ukwS2q/v53PIzhGLbb2JuIFqoIS8TknWXbo4fYHR01w==
X-Received: by 2002:a05:6402:3988:b0:691:6fc9:da93 with SMTP id 4fb4d7f45d1cf-6916fc9ded9mr4253991a12.19.1780993950904;
        Tue, 09 Jun 2026 01:32:30 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6915a637180sm4254235a12.26.2026.06.09.01.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:32:29 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 9 Jun 2026 09:32:20 +0100
To: Wadim Mueller <wafgo01@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <b5llqv5gikxjffro4rc4avcotwlaiizl5fk4mc2zt5fbpbotjh@bbycp7etmj23>
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-2-wafgo01@gmail.com>
 <ahx5cuM1xlOVP6DT@debian-BULLSEYE-live-builder-AMD64>
 <20260601104233.310ac930@jic23-huawei>
 <20260602-slf3s-v3-reply-03-wafgo01@gmail.com>
 <20260604094436.3c50f123@jic23-huawei>
 <20260607-slf3s-v3-reply-femto-wafgo01@gmail.com>
 <6at5vkw3byvbdw3przfchwrqscghdfhuwkv5xf6v6dkvfpplt5@3k3gjxn2ua26>
 <20260608-slf3s-v3-reply-unit-decision-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-slf3s-v3-reply-unit-decision-wafgo01@gmail.com>

On 08/06/26 14:24, Wadim Mueller wrote:
> On Mon, 8 Jun 2026 09:53:28 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > v16 is essentially ready to be accepted! I suppose adding the FEMTO format
> > could be done here if needed.
> 
> Thanks Rodrigo,
> 
> then let's go with m^3/s as Jonathan prefers. That does need FEMTO (the
> SLF3S-0600F scale is ~1.667e-12 m^3/s), so could you fold
> IIO_VAL_DECIMAL64_FEMTO into v16? I'll base v4 on top of it.

v16 was sent Thursday last week:
https://lore.kernel.org/linux-iio/20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com/

It does not have FEMTO. I meant you could add it here (in your series).

-- 
Kind regards,

Rodrigo Alencar
