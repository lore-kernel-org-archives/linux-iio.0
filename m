Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ECD1F1932
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208948; cv=pass; b=YFPtDsPImB9WCbSBecwtZFNWgf1SXjEPtGGfe6ZJiWK9F9WZISr2bKHARTJYCSswRvWFejQBcV3S1PLx82RHXpF2cL1ONC/fHV8086H+iS3MnlGjxMJ7FipLLx2t3oHzsQkEETfMhkJ2MA0tibTAVohhig/UeYWg8q+A7IDZuAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208948; c=relaxed/simple;
	bh=U2dNogQjtnc5DGPPh+0op/1WKOY/GrJZI/Aci42SXOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6Qac0NuGUJWsBxP9uHrGjw1Y9GWgwqDlcjHzMoAHbzso3+0HAlcek0HAK57UHWFiwlTAcwIR9WMvw7cOQ8puQuSLMYo/2PYqek3kMu/zISmRaS1hUiSN3Xwpe1EJW7cKp+1UIm+Woi5PIesE6Ds/Ox0jAXQYWWOi3Y+2/352o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKrEUVbN; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKrEUVbN"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6470d549e10so1043935d50.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 23:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773208947; cv=none;
        d=google.com; s=arc-20240605;
        b=e1cJbFrbWKaOY+LTKTQq7cLHBhzo6birjoQl/w4Fvs0r/J9Kz6h4bbyaXZW55yY+kf
         tojNxYhVwDpceB0fRQaSvekKce6EOsU77Zp2xf4t3MzvYcQh6aj4bmHApF5NTXtpWSHf
         NQuqlMRT9tPiYMMV2dFFSRZW82MhaDct7lPqLhMMaFfxNYwEAv1EeHDDPVL+/Lro+zc0
         obulH5jYN3F0grnmeI2ZheqOmT/lsMR731cU2ZNaTrUmr47gGC+K+Na4hFHzsFub/YlV
         xQyRbz81SOkB0nZDoUxH7sO+7MUgeBqsimN9mRlRD2tk7YIxyDVsYN9TD40NXBSPXRV7
         P+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U2dNogQjtnc5DGPPh+0op/1WKOY/GrJZI/Aci42SXOE=;
        fh=tgqgqJtpBfBf1SwPIJYyUw7W52ANAGoHvJAR75jH5Uk=;
        b=SJW6aR8TbUY9d2L6ANfN8w2zgumYBI5LqK/QMxrpiQjkct0ngTzoSVJsEP4PZ/o7p/
         9ehgU9W5eX7XoLbHDGnS1Wnx7t5jj3U4FkNDFMaM6W3YeP7ovu6kN9OE2EwDjDOk8o8w
         tq6Cy+xdpqK4yIN2jEer+Gh7ziaAShFbuHsLhtE602SqkAEsyjSEXAxiuHUgRj5rWk35
         lLVzhI8dzDAV39IuaR0Tmo8W7RtCqT10UiTsw+VsQJ8kjSoNz6u1SFh2XG7vLmTSPsb0
         X0Oio+aYD69ry30s5xYYRvN88hcDa4v10C7lDDZRBMJvyU8H1DbgHoyp1a6a/gs7B56f
         mpqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773208947; x=1773813747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2dNogQjtnc5DGPPh+0op/1WKOY/GrJZI/Aci42SXOE=;
        b=gKrEUVbNDqjXnajVvmcVS9vyNiH/I+4Fhwxorj8hf4PWkFqSKjDalLUKUjRxOB9Hl+
         nnTFr6174IES5mEqQwBuK88cpRXuAhxy6lO6pmeqCPqcpE/fIaYsut4F5DqWSUDUAyx/
         5N00Nn8uj4nol0PCRb5rN/g2FxfwtesesmsJ1YoZS868egjaoCTQxSYruCY+TLUm32M5
         Qo32qU3Y4YfEHV2RGWBKfN8Vnft4nX4qWvVh1v8STafcPAEzZvMsae7G/dFU5plD+NHy
         JbLVK5KRuONclZUWmDpgudLgd9wl6eXz+V3kXf3Ooy+M6C7/gAfUjf1/3VRGzNrHE1ig
         S1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773208947; x=1773813747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U2dNogQjtnc5DGPPh+0op/1WKOY/GrJZI/Aci42SXOE=;
        b=v4YrSLm8VTWk9Vt680rQ4yxKQ/im6L4EIJm5eDX9uSeCDsjJ5AgxsaukeXaSktaIMJ
         OclEXWS2UksgrOHu5l/ODTHrVdlfLCm4luJLhqQX1+IjaugnGlEyK4VPCZ2QKwP4+sTk
         PxOHXEweKE99piszaZ+pdcVRRRgzQOhGBl6+1ly0UEtIXm4r2ke4dzRd8QFr8rud9AJi
         e87CR3oDw7CkY1G7Mbt3Izly9Q7ur6y9/V1r/ontrEBK/KwVpvlmbUODBokSVE0SXn49
         boAGY3yLC6ByWYOqS/PrNKNYqlh7h+rjkjKWnu1pQjU+VevcVxKL+7gmi3odjqGymTaB
         11sw==
X-Forwarded-Encrypted: i=1; AJvYcCUNhS1KcCGq5uCN921Hy6XGKywITAn9IdOvImevG6h4+fkg+m8SokofkebC9lvtyol2MmRV1JQ34Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VJeb7u026CSnv3j+clfQvUrrA1YbgPw0M8KmNyGBighE/wDw
	+227Dq3D+f8mDeESHUKkg7angcQeGgu2ChfV3xcYwHDbiffLTiGqv+6Jh48QEcrmr0VAl4gkiO7
	AW1YAEzTOBMHs3UxLVCl6yXjhjQ28CUk=
X-Gm-Gg: ATEYQzwLJAGzY46GfjFfPUaLv4/8NXErsSZR/tOaNxFuYHDGnMHdtk4sRkBLw7aSQ84
	WQyOIBBO48EU7SRrk0LE5dZkNjPsty9+oLPX+xUTFXM4/xp7EzCNjfnHG7hLoqEY7d/q5/FfuzC
	8Bu8R6ZWKePil9Dr3dpQx1Sm5KeyIzMrTfd18Lyr3JEa+7J0axaX/SLRYSqwblkVWh4vneBQJI2
	obNZbsbfG4dbrCYOvZFjHfXsXbapF49BgfJyHhNUXJkfKvEBB6GcBZuKRJjXnGqRwrHOLW/r1ox
	GGd8uUifr04/q4ZHkbHoqD25qEDQaJSkRiAk78jEwCc50yj2sNbSCLBFZLuKjuDo7x6iQ+f6eXG
	iLtzvdUWDKu9yy6KgP3zj5A==
X-Received: by 2002:a05:690e:2456:b0:64c:e7a0:7eb9 with SMTP id
 956f58d0204a3-64d657fdf76mr613534d50.6.1773208946542; Tue, 10 Mar 2026
 23:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310143809.83126-2-giorgitchankvetadze1997@gmail.com> <abBNesBmxjJfCx2J@ashevche-desk.local>
In-Reply-To: <abBNesBmxjJfCx2J@ashevche-desk.local>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Wed, 11 Mar 2026 10:02:15 +0400
X-Gm-Features: AaiRm50PKuS9HekFdL59_J1FM_goAvGdW1sPEkCPoyOsnDZ7p20nC0RN82GGwwU
Message-ID: <CAE7dp2oYDs-=L4Kz8rof8z3jnXGDTjyQfbeVY-MxvLygoYzAyA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: mt6359-auxadc: Fix comma spacing
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 8:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Is this the only issue (of a kind) in the whole drivers/iio/adc/ ?

Yes Andy, this is the only issue of this kind, in the entire directory
