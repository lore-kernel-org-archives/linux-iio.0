Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C72EDD40
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697560; cv=pass; b=IdSoK51rorDsG4yPX3nwlNpQ7BcRB62hZGyostdxg0EzG8tNW5V6+3J8pcNyofkjh+2b6KeQnAryImG2QAvCDltjrPb11GE6dFr2HS7409QmACsfQlmtcWaS05lza7ShePVb/aXijFKp5bwsoX2WZpmKhG1AJZdQThHybIxQanc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697560; c=relaxed/simple;
	bh=LD/HoXawwSiJkE0tqPWy8TxRHVZpMFV44E98okcn0uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRSG/1K5drnfaHjfPvuKDv8XFDnt+GDJE3w1BIx90K4ah6nPQ6HpAcvKzJE75yyFYAJqJ/rQx1bN3AYz70QWNXZL8Nu8/cqnFjurfqrmddH9fYuohhNrYd+YVKbRgxhxg0a4i7ZTI159B4S6NTqo2cMV5/XijuzP99OJeTYlpn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBjhuiao; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBjhuiao"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3811e59df58so719613a91.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 08:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783697558; cv=none;
        d=google.com; s=arc-20260327;
        b=RpjCCv6GDSMgUmUUolXLE3vE3ds8cMSix8LOt7i1wXOFxgw/xcns64KOXKwV/fQYeU
         8KWK2n0PC/jsgcd9mQpzNetVqHukVW58FUn8MkJLBDw3WhVwlTjF88kPR6EE4a18r2n0
         sr7qYsPSvYuDdNeNBjEyhwEXsIMYrPTL7Y9L0cPt12eiSIVKujXf0+IucS/Xa0NTNWUB
         wh5eF6pEHBO/4u24MgLGy9A0bAhknbnRGmiOQqhiFJT2vABrn37GKG0/2C2UCYufJKMB
         IM0/+dff9/WpNwRqHC/kBFDJm5Ck9zTyQFYvqu62L6pysIR+iv0Brx8geuVmPKukKCi2
         lSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LD/HoXawwSiJkE0tqPWy8TxRHVZpMFV44E98okcn0uQ=;
        fh=kAyjTD9oD6nA9PGb67l+h5mVBrBRzMBXd3X9lJtCtjw=;
        b=A7hbiorUFqegGOIa6TinV85eceKjOebJXJvDYu6LOUVwqoSMJLu74TYPQDW7hSn+mw
         k5ARraSiVT0UG20JH3LBwP00bTwyZwxHs1tRt+PX2Bt2+GENH6GPfYfAhu5yGqKHQOTm
         x+/c+tbAshEC+1g4BRDW/QaZu8mEurs2Y4Vo9UFVB/RXb9K/WuEguaNZiBIhz9erEe9P
         4b5StXfYq3n7Wsq6uXEgKWotQM25OllMaxB0JGavgMQtZ2tpEgLh33xSVABhcCBXla76
         6YrKuRlk1Rhu82iO5x4w/cqP7mJ7STMoX0UEJPob52NYhoCRa5BT04zd0Yz1qkttjyAs
         iKAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783697558; x=1784302358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LD/HoXawwSiJkE0tqPWy8TxRHVZpMFV44E98okcn0uQ=;
        b=gBjhuiao85kliPAtWQRZSCYeQP/QIcQCfg74Ce5nA+jM8MI+iAw4QWWHj6PCwBoF01
         +lJu4uWa/pdnqC93qyB/5GEbYX16Mi2QsIQ90xt6WyWyCqT4Un5yK8lQZXXplXOnnsV0
         X1QmrJ1RWHY5UwzASYmfFBSU2XN6gZ0TXRT0aM7VWBW3/ivwRBpXU+i4OiRyLXCFVk9B
         qwk7Lmez1FEdADtTNGJSZWb7HPuPHYqes8tmRHXvUAtkm9mHzQeLXZMbNm6bJRJN6BoX
         OBdUFoonxtbs8VPMDjoKZav2Oajmhaw7i1xqBS0Np6+EfFE0kja/PMkjY13F0mePoFKV
         D/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783697558; x=1784302358;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LD/HoXawwSiJkE0tqPWy8TxRHVZpMFV44E98okcn0uQ=;
        b=GmBD1TjYLEYNVV8zkoIUY8reg5iGDROMCxDij0yb+zSEIiAFkrimhjwKieihxttKtm
         4qv23d0C5HjJWC8e41jM/K2uI1+RQUIFNUpEQz646cUhKNEgIRUWigEAG0AOkCYPO8at
         Ym5jLHHvH8pJHoEZM9IOvWqumMtuthsX87D/vJ4qaZ9GN7pOx3x8n0i0Bm2uF2RcFH5R
         aoiYn/IyrFO8FXs9c6C60AQEhjrLbd2qCzvg0zbVPbMwybGQGH+6vwI3gtctKUVtJcgl
         gsOixeAwnx2DsYxYKutYqdSugfBCalkJP1seihQiZmNBTUGEUuY7P0mJbNSoiupOW2ff
         wkhA==
X-Forwarded-Encrypted: i=1; AHgh+RrXlT5mKsdPWXMgCal+YM+Is4BSQdaFbLXwAE+fPyc1XhiTSs1EfV6pB2SvNAynesxKpv0Oa24xOwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYph98Q5pwQXH2vqEpmOpWlxxcP3Yp1avm4lY7YY6csMjYYr/I
	MsW32+jl//6c7gUaAjqBJpUqrRRo7mGVZ2tbli+Z+YsNMDgTkH/qSuP9MHZ44rtJ1sJtyQBV4Vj
	pvRwDC3knOudKjE3bD4yilBpWcGrghos=
X-Gm-Gg: AfdE7clgSa/HAeca7P+yu4L3jge2Eo+93gRs+mP1UgWzMnINy6B1+ZZ6Lk4ZNm/Amq8
	xZ3jvjye7dTiZ1rczOtOTiIimaiYWISf2bgRxAYAcuK2wcGqkIxi9zX8teSz8cewOBnDyx9El/K
	3Sxs4CgeirRPa3dUBOj6r9CzMctuwGtroivbK0S0w0sbUIC7pb4av0+KupZY7ZpeXJZWZfx2Zou
	eiIL3z+RjgZGv5nsoNikcOJ7pH/H/yMcKAu2OJhRzFO997vcmrVCF5NiQo17VnbUEcr5wLG2vWs
	sDDLrjj+48yHko84s13iGtx9qtdl5CWjckuApp+Zf6JvLwc93CyT6IhYvg68
X-Received: by 2002:a17:90b:2ccd:b0:37f:9ce0:af31 with SMTP id
 98e67ed59e1d1-38941ad2a55mr12198944a91.28.1783697558119; Fri, 10 Jul 2026
 08:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707014525.1015-1-kimjinseob88@gmail.com> <20260707014525.1015-6-kimjinseob88@gmail.com>
 <20260708022006.4276fc99@jic23-huawei>
In-Reply-To: <20260708022006.4276fc99@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sat, 11 Jul 2026 00:32:25 +0900
X-Gm-Features: AUfX_myFYIBykcPPdf8s5JAjoOTFSzN_9Jogzi0T4pIoiCbRwRR3MlGuA2VyJNw
Message-ID: <CALMSewLT_FM33VqeDtcReZt03nmRrs1R_a_6dTVPXMiFfbWJ4A@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] iio: osf: add UART IIO driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is only defined in this patch but is used in patch 4. Make sure your
> code builds after each patch so as to avoid breaking code bisection.

I changed patch 4 in my local next revision so that the stream parser no
longer depends on osf_core.h or osf_core_receive_frame().

The stream parser now accepts a typed frame handler and an opaque context.
Patch 5 provides the wrapper that calls osf_core_receive_frame().

I compiled the sources introduced by patches 3 and 4 separately using
temporary uncommitted Kbuild harnesses, and built and linked the
complete module after patch 5.

> This feels like going too far to deduplicate just this. Put a copy inline
> in each of the other macros where it is used and drop this one.

I removed OSF_SCAN_TYPE_S32 and placed the scan_type initializer
directly in both channel macros.

> Looking at this again, why do we care about holding the device
> in buffered mode for this? Races should be safe without that
> big hammer. A simple check on iio_buffer_enabled() should ensure
> data is only pushed when it is enabled, or just after it is disabled
> (which should always be safe).

I replaced the buffer-mode claim and release with an iio_buffer_enabled() check.

The one-axis and three-axis cases now return directly from
iio_push_to_buffers_with_ts(), and the default case directly returns
-EPROTO. The zero-initialized scan structures and aligned timestamps
are unchanged.

Thanks,

Jinseob
