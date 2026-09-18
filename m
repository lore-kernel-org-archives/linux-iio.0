Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6147ACCE
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732919; cv=pass; b=P5c6kTzwRdzbWMu2ci88GdE9cyWka3zp9zME+9gcBK6UBM6erFTFbasYoD+BnKqAUfzDyLeg9w/VBaDE6riaz0xtXg+fWuFL47H/KGxLy9PsyWKuCwU4oVMkrcVzQg7BAxBgLzBjjG0c1R5Cp+BuUXpDTlGMXQpF0kZhewQ0uWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732919; c=relaxed/simple;
	bh=M1dK5DFyS2Xdz4T/diTsjALrxvZ/bfOp5H11ne5BCCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM45+5McwnD/Mn4979b3rZ6jqm+j+lmyvTCLvqI0REis7U7ow/NuscETo4wf4xMON4c1FEcdzpi9mmGGZFaylcdZkOQ0zVhOcFVVbA9jylvuRTrIar9OB9WgGIOEznSV5KrrN7B0gyaTQyW3Hp+Rlw66jYVUKtPU5BYJiZplRkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/FVqspF; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/FVqspF"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5329fc7b325so4041651cf.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789732916; cv=none;
        d=google.com; s=arc-20260327;
        b=q8lIJccoMvXY6EKsmVq4nRhbUq8qoZ3yIch4ATz6PXfG8ZZW5wrbaeE+9aZxqLFDoD
         2B2nD5Mtu2D1vWTLHQ4vMFMMn2CsJGYnKRS7OWBBInJHXFCMOn0eJUTO6nOjG90KctlS
         rgGCsV2L9dXrgiJeEh3lE+S+lHtzdGYynH+qGLTW7CWnUNUB39dIFuoBcG9gUoIxMUoV
         hFEtanEhoeXRtoJi6RB8+GGBQUbYG0+6qvXMHxAabnVRAPlal+1/oU9m3PcPJS5qtRIu
         eF/qDWKoHR56CyU0RCdcQ6ptKV6MbfH0K86EK5ID5QQzPEE39NFr9cZafM5HitxK2Svw
         W6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M1dK5DFyS2Xdz4T/diTsjALrxvZ/bfOp5H11ne5BCCo=;
        fh=QqlKyCSYzyDekvrr0WF9kt0fpxz4k+kTMcXeuMHZ0Wo=;
        b=HzpIjugbNwbHoFNbS7X/SQsJZlAxuEih16j6MI1XmdZ8s9cLRDLSyXA+k6jAtQajnc
         7NQMN7KVzRqCQ54TcePkPvUZZXVKeB+a9szHsexQdc4pc6saRLyYHmsReV/KUjBkhOhQ
         vf3nX2YhMhm1j07+tR+nISM+8kFL6X4IEgjT+qOY5+Wcv/YGL81TFoTLqdh614iNvIuv
         S1fuhjw2GK1gvgeWqsP6cAAqfhS31UWvmJy0qXniSCc7AS8zs2ggSIsQODpVBlgW+Na7
         jQTZri/Hq0/E15+Yeo2RUUasS4WI5Ga8mrNHjQIl0IfXpN4UENtSSBXJuW/hvYszccZ5
         j2BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789732916; x=1790337716; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1dK5DFyS2Xdz4T/diTsjALrxvZ/bfOp5H11ne5BCCo=;
        b=a/FVqspFnoZVJqVCKknw+PsR8Tj3CV4XK3np/pgDkLQ9DZ1bCLG/pWTP+b9bfNUuJy
         Dq3Sgh+aq39ZlHJbztUaFKIGtmIMUpB9KvIJkos63asDzUucV+Lzm8QHoIat8AAxW3UO
         8PK8FOg4Ka5nmBdb9Fxs8EEtjKgjIfbFOmK3FWiD+83EZP3ZNFNVohOeZJPNL8n1Y4IE
         knYmV2LAED9vJeqwUkfcgTeUhiaygZLH0fk4jhwv9RVOWsjuVaqMWVr464w7epAB1y4a
         ZDj54WIpFPk1BUvl8xbBtM3HnoHW+mrpQjSHEzuFnWUWZNgTtznfHajTXaL5aygoxWDE
         9uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789732916; x=1790337716;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M1dK5DFyS2Xdz4T/diTsjALrxvZ/bfOp5H11ne5BCCo=;
        b=gPupvpP0HYJE0kZNHGvR/JTv5NZ63PyhAEVAUtByqGJupdgOtZAA+BgQR/B2Npf5ml
         sOnsE00mohUZRCmIulNwUdjTHTcXMRKgEwFV9z/kCofY5nSHCe+IecMZWohWBqcmOFcA
         czk2qDbiMcP8Z7WtrVMAGMofxHEc576i6xScqhE8cYACNDeqjymzqD6TdUPdA23lE474
         0SKpMYnHaRBXTwEWjl+UPwUpr5sYKkKmq1A1gom5BWGLMaWF5lssyYcYcYWnMAzU9ajm
         BTb/OZ0TOfLnxWYbtrSMPDCnawcHiB2hHdlVsWONxYKNI5u18x7XS6rV9LMKSocvTp++
         2mdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJI8XROc+KF0nJzni5xJlvUEHhB7j8alkEvfPxQlAIvvyYlJzCFisLduYZlNIa6o1PXJRyR4X4i68=@vger.kernel.org
X-Gm-Message-State: AFuF++nj84uw3RuiIShn5wXMpTkR43uQe9MODupYwjDFq2B5Gf/Pr/xF
	xJObaleJ2aHBZZBWO1uOTCxSsR8gsPYApCOXpINkeEN4o2ANHdBJEzqFJH6fQMaergIQ4GlyIIP
	XWZrVTogYQOfvLvUW04CTNb8hnHCR48k=
X-Gm-Gg: AYBFou2ptpwIDfB+2Ykb+L9Ya1eFau4PRExiVF1HjxSoo+ANhx6WhdLvt0RZWl1F9RS
	Pl7slZ4S3LhK3NU/gfWTZh0zhg7QiSTQCrfQ3RPvc9vZZyClgUM3dzUYlWJB7jQ+SJ/QmI3Bg+c
	REiHG3srsecsgmghmE6gYUK2i/SjPIoTLVn2b5DYRNWjCnUQNDHpxJZ80pmWcPuH8mEcZtM/U+S
	UMTu2V2bV3EOoWCfzoWwd/BMhz1bAi+IMqMIQs4vCXQ2aKSMZAb3ljw6tfs0wWKn5wz6owUeV+g
	MXZBLT+74fj2/pyL/WNYkhwG/JJ7PsKDqX0e3exXNuddaW2RAB6pl4rNluiADVAkgyaEgo9ATRU
	i5TdpjVAnoeU=
X-Received: by 2002:a05:622a:118b:b0:531:1e10:b660 with SMTP id
 d75a77b69052e-5329e3ae068mr34191691cf.28.1789732916427; Fri, 18 Sep 2026
 05:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917212751.16729-1-palaomer100@gmail.com> <f98165f2-270d-4117-8492-e1bc94b19330@kernel.org>
In-Reply-To: <f98165f2-270d-4117-8492-e1bc94b19330@kernel.org>
From: =?UTF-8?Q?=C3=96mer_PALA?= <palaomer100@gmail.com>
Date: Fri, 18 Sep 2026 15:01:26 +0300
X-Gm-Features: AcwNN1W44O_4sp_NosZJ8Bq5gVP124lqZbtMfXYK9VzIpzw4FBq01MkB6Is0T3Q
Message-ID: <CAKhZXnoyoqdz+BxfDsVH-Mzq7hdpY+_hwrY=K97UnBJigt1Acw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: Add AD7816 binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Then why are you posting this? Did you read discussions I linked before?
> If so, why repeating the same?
>
> Best regards,
> Krzysztof

Hi Krzysztof,

You are completely right, and I apologize for missing this. I will
drop this patch since the driver is still under staging.

Thank you for your guidance and patience.

Sorry for wasting your time.

Best regards,
Omer PALA
