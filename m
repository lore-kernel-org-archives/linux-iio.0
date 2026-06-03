Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA03905F8
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495729; cv=none; b=I7B+duaWzXtPIuN7aSajrqHyfJZfvvyis5q6EnenI5xqztOh7WRgJWcSiPTvUtSI0dTxLIXWbTb21V6HKvWHJ+s0iUZgArHQNPe4yukIK9iKXN96dROQaCA9cSvYq+2R4hgt38VuvFfKtnRYTBarUHRl95BUWtShJ29Roj5Md0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495729; c=relaxed/simple;
	bh=TeUe8xBkT6d9cm4wG3uRwDCdbb+rN4QrP1F6fWpCbQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiH+M41DbSI3z3Db+y+GDFmLUQ5D9BFWmef3tB/lzD49PuYi4wRg6pjlKiBdBbddz0mstj5vimM4QOfaaPv9FvgPAWNWVqUKVa8a1ws0iAZBUg86yKcQU+J3IPjoCZ7sg0FS63YJj/F1UMWkxrCWYDX/uUG2lNl19uU3LPZiHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md+udgk3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md+udgk3"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bef47b1ac01so347232466b.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495727; x=1781100527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeUe8xBkT6d9cm4wG3uRwDCdbb+rN4QrP1F6fWpCbQM=;
        b=Md+udgk3PfLMQJ6pMRDZoZoS6FXdXLSxV2v8LsFW8qeD1LvW+YjV7TU+2MEGpRyQ6s
         HXVn31ki4RcVNXosGs3L52rR0/I56vcKcC/xcZp+9KsdcQajzgAq+eILI+7HLcIZlreP
         ee+o5WERL29+gjJrOwQkuieoj3xgmVz3lUof1zkSQg/HWmWpciioKd66LteTIyiSr3Ti
         7QpKKck7bbcEvu9EuhjdUzephLP0eG2/hTjWsH75kbKE4YnyWyF19igTYg4i3In349g3
         FuMfpo1rkvePl3PRYfOc99ZODy5qf9LNd52a0Cm9LyHOeVYOR2OPCv+F/2kunTAq+1c2
         ueBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495727; x=1781100527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TeUe8xBkT6d9cm4wG3uRwDCdbb+rN4QrP1F6fWpCbQM=;
        b=tKARycrAb+XCT+vCvMVnj7er2Cmq56LS3Th8ga5KoKhKs0BKk1KbhTpqJ4GQeT7uJ0
         lZm8jWQgVqz2SIXStoIg7tiPlU2cW2eqbDyyNPa7rIJsS5RrKkORPB2ZSJYFo5X6IUeX
         0X4cppWVc+TDfw+RArQ4b9nbhsZ6CcKiYY2JvPdfjyns+1WmJGIh7WMLXBUk6m6YeIlQ
         6mc664+1xd95Z+pYfWi3zjv7lgrLIubPaeQkdoCG2sezPMwnVhIky2kLsU9+d0K5PLuK
         IHp7IRmYF4UJw11Y2cojVb8aymWhZjrgr3rm+A2m2sJxuKbfwOSpxsfbIC4LSuGEvygm
         6Djw==
X-Forwarded-Encrypted: i=1; AFNElJ+/WjqeOeMXmO24EZ0iXSn9NVrqsoYtZ/JjHhS9uVUqbXbA4xQo7mwnNFQrS9QjnOQ5kbBv2ylm4mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKV2CuBrqg1SVTX7IgudPp/LVqCWfn8dCRWl6vEyL/3H0cr1gI
	/meY2ApEvRLxYy5076kc1C06pagsEM3Hn2RDe4uD+tvgFxycDnwsTV6526eUUaFZ
X-Gm-Gg: Acq92OF722JqAnxyLxsbOXjd5MuQ80stzAMd65wgAIJxONBaivCKgX9wW6PDdOwkmJh
	DF+mIFTZAHMg1TrmRTmXXZPVHwP31JE0ion4rp1u6rxj6XgJfFuRt7pQsa8MLVqO6LsDbUn9A6n
	GWktPtEaISejzLBGcMNBvn7Z6XnI7La7Y/wCm4ZU3HgNhl2bHa0VRZsUu4YDQmPoikR7yF1R2UA
	7kC7P2AP05cvLuKp0/1Z9XN3i+4IjECFDF+Zq2hm6x6QwM7DruAK0wRV0gYfZMhM1sHuJl3t2nI
	Eh9nY9d9GgWLUXI0t8G/9yH8SGMsfzOvNjoXR1gIvSKEODtdlVEcuBpsNnTT3LuygSSqOyZPbpO
	CXEOfoh+wJX8NfZEEcBvUZ5CUtcFl2grplEiK/9B9N0UwXVS4k7yqfLLJbBWOj35cY80oHldO16
	uNbFGqstwyHNBS8XerFZ1jkQDyfj0+iC9mOAFm/aUGtA8Ry3Z5eQBkJb9e+MVlHhmcF+nH4RKao
	w7Sjck=
X-Received: by 2002:a17:907:9627:b0:bec:e6ae:2f6a with SMTP id a640c23a62f3a-bf0af0fe85amr195437366b.36.1780495726173;
        Wed, 03 Jun 2026 07:08:46 -0700 (PDT)
Received: from fedora.embedded.cmblu.dev (p5df027fc.dip0.t-ipconnect.de. [93.240.39.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1ac0sm162062866b.62.2026.06.03.07.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:08:45 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
Date: Wed,  3 Jun 2026 16:08:32 +0200
Message-ID: <20260602-slf3s-v3-reply-01-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260601150959.49bbf125@jic23-huawei>
References: <20260530205435.37326-1-wafgo01@gmail.com> <20260530205435.37326-3-wafgo01@gmail.com> <20260601-banana-narwhal-of-music-0b4d3a@quoll> <20260601150959.49bbf125@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 1 Jun 2026 15:09:59 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > And here something else. Confusing. Didn't you say device variants are
> > auto-detectable? So you have only one compatible sensirion,slf3s.
>
> And then future fallback compatibles can never work. [...] this is why
> generic compatibles are almost always the wrong way to go. If we get a
> future part with an unknown ID and don't have these existing specific
> compatibles, then we have no way to specify which one it is compatible
> with. [...] Note for this type of device I absolutely expect there to be
> future parts with different IDs and same ranges as here [...]

The scale comes from the detected sub-type and
there is no real feature discovery, only the opaque product-id. So for a
future part a generic-only compatible would give the right driver but the
wrong scale. For me the per-variant compatibles are the safer way.

Krzysztof, is this ok for you, or you still want the single generic one?

Wadim
