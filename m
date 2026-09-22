Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03254EEB7
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089321; cv=none; b=CjGaEmntfhpGjzMtKJz9AjJvjEZjRqfugVUgbjKeQnywoA0hWjSTAVHAQFs0aKlYfdDdOpgF+V+p97ocQ2lNHyrQ6Qv5lIO0znGYfAt2hyL4rGbzgNF+2O+n0ytNy9RQphS0MQmkDbj/zEZARvDPz4AsXAf/hT+ZPIj+s1ysBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089321; c=relaxed/simple;
	bh=nJaInej20W9dzeQHSkKI/1OjjvnAws+MmFssGn7W3Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9mhg6JRYh391D2rx4YJOn+wgb2F2je/nUGqINFXr1CrixIALo41yn4SowTK5NS5KO8Gg6WnuYv7iLujL9SimvAFjvxxThvUpCi62Z9R588TrzSq3An/7q/IKspPUCO1iTWyUdd3bliQoJoDVLfOhFfF4w/UCslzw0h2xricqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTwAL2XI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTwAL2XI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so31954005e9.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089318; x=1790694118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LPDTkB0QGhdPj3hyMEadxYVUHPg+JvQ6bPrYQoaa3EA=;
        b=hTwAL2XI+1Q2PWSsIRnU+1NhMqw6409K+azDUXGp5ONJwU2xqXBFSzE4CeG1EczfUS
         bJXSwgVQJmRgjWk4b4LTr0U251LoZbzIfkObUP/G3PTNz8jDRqSLCbvTpwPHP5fmWqee
         i9LJlFQ36i9rIGgbhaV9cqbZWuvMFXtKgfimamfE+/yKye9zhv5g+g/owN+R9h7QR3QF
         EfEkxvazVUMI79a7GZyaNnXZkTzSpydAHYYvu22Idu7D66JmlvEwmc1LMExYBDwVaorN
         th9fzRKDAByp1q7B99aXWRDUWWWpKsPFlUa4RfyIJp0EKV6mj9HlA2oiWiPrWHqzRH2E
         hOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089318; x=1790694118;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LPDTkB0QGhdPj3hyMEadxYVUHPg+JvQ6bPrYQoaa3EA=;
        b=tVfdFcqXt0FUVd1zD/5SGvERkSqcT6MXz5tduRxItoAIm46dHkd/3nXPet9b3NPtYk
         RWb7DfGRlgb68SznRG/CX+6PwNS0QRV0ywPzcEdOpXjL0Vwu9m9/vBADSayCWmKY4diA
         pJ3WeiuF6Z2prVV0K5UL789fagnhy0Ugb2pCc1cSfq9XsdrxUn5C5s4nj1VR1VejeXGP
         /tuZV8kL9A5kMsQLjUqgZIb/ER7AawReYZXatHLhUvFydUg0Gg9ALj87bXmb26QgthtF
         EcmfIoiWuJwNgNiQNvyI6YNxd+R+gQStUs+ShtzPzSj4fuRXlmuBTsohKMzVeGZWR/j8
         X6gA==
X-Forwarded-Encrypted: i=1; AKwUvBxIuzE95p5omMXSzBm/v2JMJelHK6xsE8hxe1CllScODqOwqwGbLYBNaq2ZGxsDs887J+SeW7VBvXU=@vger.kernel.org
X-Gm-Message-State: AFuF++kzT5JOFk/D8JMFrU+aG0opOVhH1RDsO5LMWmrT91EtP4Q1Fy48
	WvlIXueiWhGXDs/TgmxRq2NQ/WI8yyUHFqQ8+J55O3WpIUJbEYV+R4UX
X-Gm-Gg: AYBFou0wkMPDf91JIHGBYCuvZOCMNvcUmeifMWaW99VjioImH95gFt296D7siXYU8uN
	XaT67lrmzWYAusLM/CiOwdVKf6OWGzI9Z7cU356j6vPvkeJWsFnBB8oYYcVSzCTASExqp7sFcse
	qv398ZqXh1j3HW917oSPyFSmt4qxCkhtRjXgZ7fvueZekW77PjUJ/KbkjvK6Ej1fXBOodkKQSyI
	+FDnpqBqCSZQC2HWeqjhNoQiy82T62raAH4nhQ/os+j5WloXxsPFJDf7G3xUXMaXX97GQ+s6h1V
	dJ2L2JgRPE10qFG1P8oPs63LfF6/Qoxj+a8fq/z1MCXIQo1T835ap2xcet3UnL43k6jsM0AeQVN
	ThxYzex3rcHp2XYzBzyrm3SRB+QK8I+06IsmIZXUkuXr8U69IsApqBRYiTCyNL1VZWyhYntn+tl
	JnyK2n6/0GnXwrMgi3WXKjK5tstZD14qNacZhr8ZiHtn1iGj/E/lvatP3K6KNKi9cKjDTC4avpx
	OQ71vU+nIEr4xZP9PEwd7DYaqnAA8flgqLjLyL0C55kaiQjCO7QuiJWAm4kod00CiDqhZjt/MNG
	oLXZikNiiphUXCLioLpf+rEbzG4wq4wXLfMKOaa6Qs3VqHTAczUT300Li/5Q31mIAhK7fAPb/u1
	vj60tpS7b1tdhi752XZCSHbSyGTwWBn3DqSxviA5cZC0wjyP6WZDDqFYI6bsrqRUHzvRQQ2izhO
	LBT96S
X-Received: by 2002:a05:600c:4712:b0:49f:dd10:3c71 with SMTP id 5b1f17b1804b1-49fdd103ccfmr19072185e9.11.1790089318256;
        Tue, 22 Sep 2026 08:01:58 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaa9dbd6sm62767365e9.2.2026.09.22.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:01:57 -0700 (PDT)
Date: Tue, 22 Sep 2026 17:01:56 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Add dedicated CM32181 schema
Message-ID: <20260922170156.00001c8b@gmail.com>
In-Reply-To: <20260921232752.3136129-1-robh@kernel.org>
References: <20260921232752.3136129-1-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 18:27:51 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

Why not additionalProperties?

-- 
Kind regards,
Joshua Crofts
