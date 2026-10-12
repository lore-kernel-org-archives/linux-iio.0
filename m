Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1963E49DA
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813105; cv=none; b=QuTNM6OHO7LzbutxcHBDV1+D/kWykj1lJvpzbBq+sbp8HCQILWa+T/6G3BHpWS15fL68KOav1u3VAOd1z4IvMTFVwuBDoxcqQjwQPlzvwNKVy0Bz3akIYLic6ePQzUq0kfA5YtFjdHoduNJGlkAiwYiJFEMEx4MO47hXfjHtoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813105; c=relaxed/simple;
	bh=JNLvSKsWbpNpU+kVfR1ZUgo0qtFkPeJnN9n/3eiEcSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7rNl8YuFvG1KV04REHpguUJDwZHRkaK4z+xhriPNfFCpVsVuPSEUpWokyCjvE6QtKT/NEUZT7eXaktBwMJ51IkE0vXje7yRWmIU5r/1DEUOvCrtIjf8tWyjbRYovsl4F4XGlw8XsQvrnXxxsGINL0BVZifxeV8nN8PTJsXTqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWW/dfsY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWW/dfsY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so13893185e9.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813103; x=1792417903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLOrbPkiMwYxELk182ZPfeiCmk/lFJpYO2IK6N8cvrs=;
        b=kWW/dfsYmSuWUUAmOtu9ANV87tPPKXFs3Wu2Zf4c9BjI1gxqJUEUYZR6eDFV2eSFzZ
         9IkrgEcM0UNHqTeDzb/fi3vsTrHLpX8HoUz5MUT/ec4oVQM/Hn7YR1hQKx2S4bXHnt8x
         HZxqhhXXxfOQHbq0nRBwIiB/iVLkCNWky+C4Nztk3wkwVLqubb1dIZgHm8VrsCgo0+l1
         +QBbPfQpacUPyQXJpH8kkT9EOWM6v+WRMqagJdpxEPH4lyd2x0hXl+3tEGACJyTaAZYQ
         ejnhHfdKYevn5S4de9Sl/q+i/lSmbVR2Iqwqep7Rwp95GrwKUTAE8N9A8EAhFoiIpmOl
         LFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813103; x=1792417903;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLOrbPkiMwYxELk182ZPfeiCmk/lFJpYO2IK6N8cvrs=;
        b=xS/RQWl6/2PLuJi3IoblpJneKzyvJwkn9UoQjqGYKhM2sdtYd6pYTMAzWNeGhEi9BA
         iWaKuzP99ZzexCPcwaJ6haU8XGtBEj8nwVNvuwlxh9vepTpGyPgFgbFJ1q8h0jaobgiC
         plMNyPoXpT2atKzWu2olDw/PH3DtUpCfodulLTge4AZdDv/E0wmNdtmH0B32qJoiD/zr
         crj+Lah/xLe5r8KAiA98XlkEDu1gYh9wXjh/A4hULOwfUkDiC5GoYZbOv26vun4rNIj1
         SmbzW4vp1+I3JPIZJwQvKB1EBNpVEACoNt4J+yhrbhtN/NNFXUdy0mUpBBGssQUyyweG
         gzwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtpcLdCD5BA/efGadGzzICZl4tm77K7kOtyoqwG4UB0w1rBLGqwwhLTcTJCESdhxbvJGFn3ReUmUg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwY+IBWY8/WD1ssLcKWiEkR5AQI7BW3pVtYpUcZnG7RjPsf1RE
	X/N1sM4Kt4qCYEJE0Y7LiCnEnZoL19bhZnH/x74n7GH15WW6AivC717L
X-Gm-Gg: AYBFou3LKLX+IXdNPGa6YmuUprke0rcbzfExtgbovV6uahuoWNEigetM9UfuVVZGHgF
	Ssib8mICZhRVyidQay2dPjmt+Y/N8CzszsdScFIB7oip5lvFbmGHup4SfcDecDBkD2BzULknhCS
	agnw/r7HeTqJUELOcV2HQy65Yiog5CHi6J8lt4uOEeaZzRs9WVrHS3CTJk17zzBfGHugW831nQf
	+GyPbZ8JmgryBfJX0cdtlKqelFAvw3xXJ+Yyjfd+uK/eLfLq5HD17A9bG9Kmv4/z/qOxgiLFyc1
	pFfNpCFoo3FIO0SscLz9FPEd/0vdSisr4Xp78PMRwHgSgr3exDfqM4TdDaPcgbwT+4hBHcEx/uE
	OnUi6opmTXuVVz0tC75dG/b3YoOx3+IVDHBCxHQK6tx8AcI8lmN2qhKZKWB9h+Pw4tDIAwlmNSx
	4rlclTk2LTZsak5gXkQ8du2+iJn+8D/PviCChiMsTfJwa28ZWnmfFmBxiooALrC9ZiqTSLoNkzo
	T/pda0ymKB7KUr/AE7BRY9YqGVpGQJRnxRY3wZ73PhD1V8V8+ADn0y5bhVUAKn5bvYU/EdSRzIY
	0hVtKzXEXaSo6P5SVui2bSf8TY9vXVJwgkb7OHjP9/nudkemVxBOJmkPyBzyqzluIzf1y9YVaES
	Cjle4SIsBPlYH/j3XD+AvR4MbM+jWQI9wrga25Fh+ex4QZvdkIEevHo1DrhunVqYYTsF9nrTfdb
	eMQkRWYCSJxv3JsSs=
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id 5b1f17b1804b1-4a18e4cd667mr179122395e9.26.1791813102687;
        Mon, 12 Oct 2026 06:51:42 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c3a13sm19399336f8f.25.2026.10.12.06.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:51:42 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:51:38 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Radu Sabau <radu.sabau@analog.com>, Janani
 Sunil <janani.sunil@analog.com>, Salih Erim <salih.erim@amd.com>, Jishnu
 Prakash <jishnu.prakash@oss.qualcomm.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: adc: ade9000: parameterise the reactive power
 channel
Message-ID: <20261012155138.0000726c@gmail.com>
In-Reply-To: <20261012111342.48040-2-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
	<20261012111342.48040-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 14:13:37 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The channel array is declared once by ADE9000_DECLARE_CHANNELS() and
> specialised per part through the altvoltage_rms argument, which lets parts
> without dip/swell hardware drop those events. Some parts in the family do
> not compute total reactive power at all and have no AVAR register, so they
> need to drop the reactive power channel as well.
> 
> Add a second argument that selects the reactive power entry and introduce
> the ADE9000_POWER_REACTIVE_ENTRY()/ADE9000_NO_POWER_REACTIVE_ENTRY() pair
> for it. The entry macros include their own trailing comma so that the
> variant for parts lacking the register can expand to nothing.
> 
> No functional change: the preprocessed ade9000_channels and
> ade9078_channels tables are unchanged.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
