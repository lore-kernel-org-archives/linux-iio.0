Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217236829B
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769891447; cv=none; b=V0k5UjORpTFUp8EEiJoK17EqdYUo98SUabY3AmB7Y3vB5fbaK8+3MJoUE8c/qa8Eps91u3npFFWlL9PRPFulbW6xSp6pobyDMNtQPomNYEWryrrKloY83KBDU6LedQ25WebrmF30xGN7VKnEhR6/aGHXdmMCcQfIdGe+EP1Wf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769891447; c=relaxed/simple;
	bh=L9XJve0ulj8tKYF10Wkb04uXGOq5u4DHLER2Q3q5jNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snhSt8iLQRftKzGiyqn6gf1g1C987OHYrRKm8Uco0VDBeMMRBd+X3cABWG5d95vnMecvuqPapjMnp/PaYZR3S9x2if4dNsouZ5Pq31c7Ds6TS7j+H8ccJny1unB7ykw0x25J8Ad3sA45Tq8RjeWvz0RzWgmxLmsYIwFYzeAnfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HnwlS2uK; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HnwlS2uK"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40427db1300so2029501fac.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 12:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769891444; x=1770496244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGj1VrnHQQ76sXlhAlBiObgm7QPOVd0/aqgVTeAbbdk=;
        b=HnwlS2uK0S7+uhtd/kpw4oNnPDtA1oMk+taVOm8GEbZv0kCWa5tCT4HdAHD9ipzqHf
         K/Cgc/qFI243mcCCcaipfiwn0c0Uhj5vChUCwuMlCCRPBf3ErnYYJD3H/I18/STkikGO
         sRjLR+sGafyKt7SZYziO8bBNmaIV0Etm64m3/kLCruAucifHVWQeNkbdl7UpP1OBrDQj
         ceOxo8PRUmKkSlTFWa7wEUikfLzc7nNin73m2BQrZopLB8iQr/AG6GFBhCcUiwDs2Pn5
         aYdot3volbcBo0Uw8YOCFsp3at/Mn5+h2z2McCDYQmaNu3WHslu7HqURu0HhlhZppWku
         7lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769891444; x=1770496244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGj1VrnHQQ76sXlhAlBiObgm7QPOVd0/aqgVTeAbbdk=;
        b=Dg5I6XbpPZMSJNsTuzUR1w1sMveIqajWsBnZSXRj5O9xFtXEpvYCl0ClnMEQp6dMGg
         1c68EsxHiL6VDwbtccJr1dBJvC0mPe9IHw+PSkcJ/KYinBxTB2VgkiG62PJXTPz6GaZY
         T+wF7YNm/fwKv+qLc5u+7aFFjzWZ+8+4bWYbuN468gHQzHAXfES2l65VWNpvup9zRrFf
         NiLBtWALzilartbIZUjaydGndy05Zed1x9DlXiJraelXBRWlWtGm5wmcQvfTQgkLB5DX
         aR5I1snglVbtdDgmWTrYmP8W0UdXJYYwDVgmRJC9FIXEeKPVnQMJbH9XLqkZQr5mkUFM
         QHHg==
X-Gm-Message-State: AOJu0YyDbA7J4pExZ6lfvzakNYGtf30ueVrpduXa0n8GbGB0xGDgJLTt
	Ba0WnGQnkfWscz+vZ7EC5fHAjoa/nUuFLoicofNb6c3uTkbTGWTnQ8qITGFYDClFuQc=
X-Gm-Gg: AZuq6aJwxvCN0hm7zQ/9DFoPISjn54IdFHU4pPBjE+6KU7SlCnFmCajZPn1RZ1gWizq
	U+9BLbU0Q+LDgd5KCCzwPuKtskbaZeiWe1bFQKPpGElwJwPyrDHw7zus4i5LxoimsJWpey+wQjw
	/+XZO9f4MWaxVN+JwdH/bHHH0mFmZWDvpzL4HwrHXni+a532oitsIENj0v1x9/ejcloxpHUO+yx
	Jrv4AOGlJ3gKmki2jjQf8L7zHcqtoEArC8cn4Z0DEU5fLJGhPq2/fETkW81kSYyqY7dlt1ZkW7C
	Z0qnQKTrWYsG/LMCfgaoaIOqQdUn7ePweLkXCGSuh4S7mD99wkDIlzkrixE1DTdjjAFpPX47yR9
	eysCUU503F0tlIOctX8YLfka3pj9fm1ITseTekmKg169lPM2hPLDyqhXYbsQ/b0Q2E5+KetrOeb
	jytG4dEwOlqTnPhZvjlKJC/1sWFw5jtwblp0N4Au/dBVrQb8/OQ+k2GFtQ+QhqzlBZu/B2JAM=
X-Received: by 2002:a05:6820:3109:b0:662:fd69:e0d4 with SMTP id 006d021491bc7-6630f3b4d03mr3283555eaf.70.1769891443760;
        Sat, 31 Jan 2026 12:30:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9963799sm6975601eaf.7.2026.01.31.12.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 12:30:42 -0800 (PST)
Message-ID: <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
Date: Sat, 31 Jan 2026 14:30:41 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: Tomas Melin <tomas.melin@vaisala.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/26 3:16 AM, Tomas Melin wrote:
> Not all backends support the full set of capabilities provided by the
> industrialio-backend framework. Capability bits can be used in frontends
> and backends for checking for a certain feature set, or if using
> related functions can be expected to fail.
> 
> Capability bits should be set by a compatible backend and provided when
> registering the backend.
> 

...

> +/**
> + * enum iio_backend_capabilities - Backend capabilities
> + * Backend capabilities can be used by frontends to check if a given
> + * functionality is supported by the backend. This is useful for frontend
> + * devices which are expected to work with alternative backend
> + * implementations. Capabilities are loosely coupled with operations,
> + * meaning that a capability requires certain operations to be implemented
> + * by the backend. A capability might be mapped to a single operation or
> + * multiple operations.

It would be helpful to list these operations explicitly for each
enum member.

> + *
> + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports digital interface
> + * calibration. Calibration procedure is device specific.
> + * @IIO_BACKEND_CAP_BUFFERING: Backend supports buffering.

I assume this means it supports devm_iio_backend_request_buffer()?

In IIO, we usually say "buffer" and rarely "buffering" so this name and
description is a bit confusing to me.

> + * @IIO_BACKEND_CAP_ALWAYS_ON: Backend does not need to be explicitly
> + * enabled/disabled. It is always on.

Do we actually need this one? Alternative could be, for example:

int iio_backend_enable(struct iio_backend *back)
{
	int ret;

	ret = iio_backend_op_call(back, enable);
	
	return ret == -EOPNOTSUPP ? 0 : ret;
}

Or make a iio_backend_optional_op_call() macro.

Or if there is some other nuance where this capability makes a
difference, it should be explained in more detail.


> + */
> +enum iio_backend_capabilities {

Documenting members like this works too (saves a bit of cross-referencing).

	/** @IIO_BACKEND_CAP_CALIBRATION: ... */
> +	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
> +	IIO_BACKEND_CAP_BUFFERING = BIT(1),
> +	IIO_BACKEND_CAP_ALWAYS_ON = BIT(2),
> +};
