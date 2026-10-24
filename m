Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792823893;
	b=bkAct04R78WnDw2hoU4mFrczE5DK8v1sJ60mTo2HXSkm2gRyvgxZkGbcDuswwRsZAQ8F
	 yJ9kuVWUBpVKRRtVCqJByJFbcTxO04e9iDvGWtHA26+X8ZHEsrDNFzKt6nsTG5Zsp8uil
	 d8Ip4eUfo3BGaSTfUafCrhUp4KsLJFwE6+q5JR7EY83dN914BjgY0FySdRbuMtH0HnHhY
	 2gTnObNbczD7wvUS6Gfo0PeNNQDqjEBB95fGpJ2TD9dyb7LRgnWauCVimduyg3Jd/Z0zg
	 4tR8AvoD9wg2zffVCLwnyzkF7lejX1nj1gpF02wtPBiGbwcQvBO77phKT8Y0dznNt3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792823893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Eo/uDup4KcaVJ1mR+rT1i9h2PRHKpBooRZboT0Neq5k=;
	b=idT1d+ovfbPN6dDeSTDuoJuhag+GxJqdaWIOpbIEO2KZa9IQXjGxsW9KVQg2Uw3sMHy1
	 rpSooP0Uf6JEkqW2LALNMk+tcv/nX4BcQD+RWv96amOX/5RxQI0rPjl22WKjXPJQK3KYR
	 2J6AYBDTMVRxGsvZxtiCAYsuezRBeSkrzwye304OemUMQ42Gha71R0VNBrV+xrls/Yw6g
	 paqnZa4hVK87jrEdWAfr4liu6t//20ehTcfRqjPq/f4TyjXu24gmw1VFDm3cVkwlGe70b
	 433FRUBi+KfgbXsgKWinP6V8Q1GGbFmFodjXgTQ8j2rnyGIcBxua+CVnNGMgOEw869Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JSq5usht;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863C606A31D
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 06:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9863C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JSq5usht
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso15771925e9.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 23:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792823891; x=1793428691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eo/uDup4KcaVJ1mR+rT1i9h2PRHKpBooRZboT0Neq5k=;
        b=JSq5ushtKCOp88C6tHvh//K5tNcwrAAwAHXEk/x9OnSeJ/X9kmdoR7O5qQ51NAbMXf
         PDaoU5tQ3bQOy7RkA2Xe7tSu0TgTxjIWtZtnmhxMaxVIaDhauDuYTTPB2D18kW6LOa3a
         copeaz0+6y2herGTsVGoBl7nU6YdW+c7qmbS+/scTzCXantPYa/AvOTu/rTxxN54c4qE
         snedA8EKU068xKbI0cT9dOgtk8ora/IKMl1pQ4flfYz4RbMahCMzNBarV6gMV4Ykz0ML
         4HPLYq1EZhhqGGrzUvGIvCDclZGXCB3FeqgdzY8PTbLg491oCK9Z7fai5d1OPScoiC1j
         2m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792823891; x=1793428691;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eo/uDup4KcaVJ1mR+rT1i9h2PRHKpBooRZboT0Neq5k=;
        b=rcgoVKBhclAX3q9ER40Qk08OyxlaC8NU1I80kgPCYYFoq3lKnxmk4+Zqp5EWEMvjKP
         UeGGiXQcQkHeggu6PFJm/qn160SmzL3bub6rKLbYqn5P4sAkhaUFh93s8sNFzyy1Huhd
         QHHIb7PrMCi6nhKB+hT7NcBOckGNzWFBqHXi1zR9BocDC0vW6R8LMyzZxE8WMO/0Kpft
         x5ZFayfcPQG8GvXFN8d8dlonsioKuarrWFX/ZpXwuwO/wqFKs/Gu135t/kuuGWa1wNrI
         B8JeB1oAbVQ9qJb1rdbaGK/ezGtovoPeb2qoF7iD0ST6pjfqnA5MJKeX7WITgtGusFbo
         WSnQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9SfllH9iwS+h7wBdrj0u8AjdqZ5zKrDE39aC58jVN8xy2J8JHStfJD0AhPhV/+RlDletee9lesIg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzjyXms55N/SNCuixOXguw39Ibq9Pvk/iDghNJ176CtRBornSx
	AlLZ2x6KvryeOkmgsk7imMe0HhsGm5ihXUfMojFTP0cyUWaf7/nrzGEr
X-Gm-Gg: AYBFou07jdoDjllYjoqoQw/oMgYTYBckXsIJRkpCnb/NjpBKVBGiGLJ8FYDjKC3OOjt
	uvbH79aK6gNfpZ6hcVUmWUwk0FXIzSjk+7+ZFyoNV7npPPQrh8yJogjvSdhAH30QHTjrz3dOnhX
	U4XKOzYxjhJQhtjDFk+5+qn7nxfgw6EIqRSUqpTzGj/5HOprZ8sWzIuhM+/M1jnHd30+Qn/S3zr
	Z/Ir/j4CpGaZvJt6TR8UTFmZtpDLs859J4RiSW8QGuvghtmJPL9eaoIcQjKIQ2OQ2IKFKTUlidf
	5DQwR/R4CLdBS973yLHtCE/9Im5zl5fOQWoIEFNlhEuWOk5aMiHo/LvGReULe1aNCDNlMhaKEHM
	6zqPQ2FVjGytY37t0GdMfldDkE/SBxBYsbVZT0yVMUq023SAcMeyBnOgPrB5QJZavjv1NsMvfAf
	4++eCzdvImqAD1gCv8Rgj75nYY7i5ppmo0DU82gsd8icDD3DQeNTOv2TmwVyEUwV3nIK0H/RJMH
	iLAcE4sevvN1ihbbNeP8K0kSfgv8rDm3Zn1w3UBJKADXgjdEpnicZs38QZR0r2z0pcxrrrutROQ
	DakNUHvZWIzgW/tMP2VuUfnY56D8CmNqY8oymWLu64C8Um8FkkTR6r2CtyZkebjrbHC521Z8epp
	PPw1S6h6tPhxkFe2kSVyJzAKEu9A6UkhPMDQZop9JqcYonZvTIjq3Tn3k/xS1xkdaO/SDZqQ1SI
	fon7tGjq9KFLZ3JGhjE1YwdgmY7wuF
X-Received: by 2002:a05:600c:5308:b0:4a2:86b8:7e9 with SMTP id 5b1f17b1804b1-4a35ac9d077mr14744425e9.16.1792823890868;
        Fri, 23 Oct 2026 23:38:10 -0700 (PDT)
Received: from localhost ([2001:718:1202:45:44bf:6db8:6c32:23e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bdd59sm22278075e9.4.2026.10.23.23.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:38:10 -0700 (PDT)
Date: Sat, 24 Oct 2026 08:38:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261024083809.000026e5@gmail.com>
In-Reply-To: <20261024041357.34346-1-olivier@mgcrea.io>
References: <20261024041357.34346-1-olivier@mgcrea.io>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 06:13:56 +0200
Olivier Louvignes <olivier@mgcrea.io> wrote:

> The X1600's SAR ADC has four auxiliary channels and none of the
> touchscreen or battery engines of the JZ47xx ADCs in
> ingenic,adc.yaml, so it gets a binding of its own.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---

Please use a cover letter when submitting a patch series.

-- 
Kind regards,
Joshua Crofts
