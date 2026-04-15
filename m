Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB930337BB5
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248237; cv=pass; b=en9aCA8BSymJCBjlg2Yqn1rfVO/VtpbCIWB6fWNpYDEcitzoDUR3zY6TfWsz6dYL/Tyt3byS/qF2gvkQ3YEvF0GgQPrgtD4Jr7u6B+HM6ESbV6YrbSGtNVuIJTg1UJZfldwjYMdo1VPLSXEpIIexLD2LQ+vG3a7m06q6ic9rQ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248237; c=relaxed/simple;
	bh=GEJRMbT1fnKhLCd2sVYksO5gfbs0YNvAaaLQ8+u9oxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq70G5/2AEwo4XRp3WCSTqnzOF38SzcIIDq4KZMorQKbMzEy9mjVU9hPxv+8hgVEj3nrEzQhR/470O2IB/5miMF27Cd2StCNDChNDVzF1JVkUneEjFAMlADShKIucO6PPsfasqg1vsWqw74b/Eb/zxAy6lwcMuhiqsSVLNTaZM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8NmyYCk; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8NmyYCk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso67889805e9.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 03:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776248234; cv=none;
        d=google.com; s=arc-20240605;
        b=kak6jDU1InJa2eR8jYHnfAYvIaCLb0f3k4767QDd4sPH3Ux8hAHwYrDKkhtyvLIXt1
         0qsbG94cYJdV+j3E2lSM0dRUlYhKgQLuxk/rSY3tA8qHcDQ15dFf/nGVqZ20otiQvOF3
         3xqEuOS/1QlODjfpz6jSwqsYI1ehYku2PMnk2l+ycMiGhfQKwLlADRZjC7udjUWtsXet
         Ke5oVturXjvRt5KO1kgw1oqzjlCXXE6YPYar7ZQMAEV9LfhiAVLJyB/8s2ENZwrSMoU8
         JX88TEhLAXZoOxPfXGBzv1byTo7JpuwanW+S7bOtTuFa87xzkZg3UO6cUSsacConQ3WK
         mF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Xdab+DX+2QKzxNGFb/RStcW513VAKLlMV/prpdYFeAQ=;
        fh=bUV8vWmSmvB0Hgu73jNbjg97zqmOORZ+ADkYPkpAFvo=;
        b=gTJc75Snk8wUAq2e69/7+/grLlS/UBeiuoglsFNQJf8o7qt5IF6otfcwEPksEKwuno
         WnTTJRWbDpnVIZWYBNd6AtLkSF5dd1nwv8Ovg4qdaePnvDCFUXYp0YPL6M0uRHsmzOAx
         FpLJwiy2Xqcyiy+J+gNrSbYs1B/9g8jKajv6ahHCqcuLvC0rZlReqqKW+Jiyfr6gncvK
         8JcUIojRhIL/MbElspl0gMb69VP59/0dhPHzhjh9GDo575+mG2Nltyxzh6B573yiYZWH
         zUqnxLxSNxTIaGuO5EdLqotmWN5mD5QY4jUj0ZzMILsYfcLNvLuGof9lNXi2zAzYJ8Mm
         1XTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776248234; x=1776853034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xdab+DX+2QKzxNGFb/RStcW513VAKLlMV/prpdYFeAQ=;
        b=L8NmyYCkVxMLv0GsWlSIkp7+iROhXtyguOM5ygfSMf+m297XqhokBGBKqc1aj7qtSw
         vfWpxQs0EdcThnN1UIjmYHNOd/TUrtbiOJtGHH/Qu7GfvaFa0/25NQ+K/RxhaU4aZh9V
         MU0PT/HGMNXggga6S+nZUGSLa6vKufjQJrRe6zBfxBMU/uq9pBq78pCZy9pFboDcrlNO
         lX7c/IJ3iLUilXq07EY8ve2OKpyv9TxBnS10DTO0L4sby7LIf2d7v97tCMIbRTMTw7L+
         Wz63E9dpvlc1LlAWynxaMN5kXAjnodHQoFu/17UgAAL/o5vv2tKvxvNaKmjhZET1YjZC
         c0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248234; x=1776853034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xdab+DX+2QKzxNGFb/RStcW513VAKLlMV/prpdYFeAQ=;
        b=rreI9B/hbrmyencQWT1TvutUtfLtaum8HaeuLOv8HIZTIzjTjdNlGKF4td4LMQXVj/
         D6MAn8mSsYY7L+EZYi8mgCqMt4z3Lg1TykhGB9g9gL/sE9XOadhFU5Si6OG3N/l/nLFk
         l7TfbDDYNAYfq6QTlybYS7uYQ+o9tNAgcubiLGftbh44x5ClxJLie1hmkoz8Kj6hgLdj
         lq++jJMfzR3Mh4zaVp8fylGxYt8MVfpRLzxl2wAqj/AJkeS0rNdsRnjTmYa4TCUfEzKK
         kHvNGH4BtT6PXkWy8henhp9Aqd9mZUgdSh3baKna9jfMg5t+9TSyWn/tkJVToz1SIWNq
         Bw6g==
X-Forwarded-Encrypted: i=1; AFNElJ8ShI+zSrXOhlWqG+E/LRiAdZR66kFJncgSRsOikMro6oSY/2LfV3FryeuOuOW7VRe/4E/O/ZhaQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyknlVaOOY5YhWVzHJPqhKlQFqeCbTYIT2W6dFJcehrC54jJddh
	4JMMO2sVsZY34HbLunqUQhpa5uUTBaSObudpPYL7JoViXGeXSCLzH6yx4qUKektsna/eTgwWCMh
	UsmkdGLdnUBOpyIU8FIga8NDVXxYAzEY=
X-Gm-Gg: AeBDiet/s+gV9fPns08pZNhBJm30w+XRimLCxvwo7chhceoKKwfG55DnWsw8GcES1Ex
	nup/g45uukV9b2MlvipbcQmYpyNoQKJQJAtD3m6WuhvwC2/q+CoB4FFcRrBYIWk81xy1nEa6eKt
	Cm/tAY89B+NofBxV1ta7/Y5G7bms9PEQLFrF++bc9PL2U/8JZlpuPlrqxviPdeyFmZyoqwkK14a
	VfO4mUBUU7h3eYw8tM6gf3p9fKdwNOz2l7GUji4WNCXb6OoFnJpuSml/4VFOy21kkgnr9ovZxOE
	leHmuYAI/c+z06LzF1Txae7YEmiuqU8BwGzdT2UXACZPPBtV4h9kGs2CLffcqA4F0ac8y4hctW+
	QbLot2jeZUz6gN+W6MHm2d3VWTNCczr96Ngbc2PMYgDCDNzXSqd7RmcDofTOjwT0HrxTvF5gk6b
	WSRbMvnSgiclp1nY/u
X-Received: by 2002:a05:600d:1:b0:488:8bdd:cfcc with SMTP id
 5b1f17b1804b1-488d6772785mr260505095e9.0.1776248234123; Wed, 15 Apr 2026
 03:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-2-joshua.crofts1@gmail.com> <ad9SzwJDwRNldv_z@ashevche-desk.local>
 <CALoEA-xy6WApV+ZUavnEipTKiAezYkXMwiE++TjtHuxkVdR1mw@mail.gmail.com>
 <ad9jThxf6PINFFmo@ashevche-desk.local> <ad9jtH1YgA6N6FYg@ashevche-desk.local>
In-Reply-To: <ad9jtH1YgA6N6FYg@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 15 Apr 2026 12:17:13 +0200
X-Gm-Features: AQROBzD-afV1ydOejveQ92FWSZHqehBRAG1Eprp9p5RAnyrkqn2RCy5sBp2paEI
Message-ID: <CALoEA-xopdHNGtBJQk1_cZZ823qu1_8EM5GR2tB+RdYyuWpWEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 12:08, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Ah, all of them have the first one an AI... Perhaps you are right.

Therefore, should I send a v5 amending the period and <linux/*> header fix?

-- 
Kind regards

CJD
