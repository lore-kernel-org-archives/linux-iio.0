Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06653314B7
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141670; cv=pass; b=lDTwQ9zSqqg5QWiA53pJt1N+3ZUO4Y024k++pPTWbmFOWiC4ItWXggoR6dkb7Kt0bnMnkDbnb8LgrSAHzyCGZZMz2POrKRZBrxgquTVJywd9tjfXEk6n1qkdprfBQwJT+/UlXByK0A22W2ws8SX9oyVUFM/T/wKkhkvlsWoZDfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141670; c=relaxed/simple;
	bh=8zvipcslBvGLMROe27G8a4yy9yYjiXdUNW/PADn7MPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZQljne8nJnPh7c9GpWCkNHt2MbZr32mBFlgJcQHHinwKiLzSqUxDSWB4QmUBzJ+eDGBxQeG6jGJNILUrxHAa2DoiyChb3wtDF2df/HWDZ0bggKiGWIYI+g21NQjg9kulUBct/n7N/PZoRlj3myVt0/u9rQIh63u+4CIzF01jP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp/xCq0j; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp/xCq0j"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7fffb090ddfso46041227b3.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 08:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782141668; cv=none;
        d=google.com; s=arc-20240605;
        b=MPZPRUxPSkv0yEQMgMYy/66qwTC+dqWc+HlAMfqfv/8hOfREyehZQhdggN/GcxKO64
         zGGNho1OL9JA8lZGWSM6wVP31AqIUAJPD9Zo+bo5ONTmITTsEtyjiVkT4V423jfDp4/z
         zING6YV14VF/AXIIqvuwfeEN78FQL6eG/es7WKhnEPOrZl3O7Jf9k9ECgfmz376dWLEh
         4qDhleFtLaxW6bl0wiYPCTHIy/cezRZrZ7sq8rqzepXljsYaSzLHrllHLe0grqfTzseJ
         nBV9yQl8SlmyTj9p3zQzwpNzP4huhhGeFUTQL/dXMQkOvCRQ2wj64SD8cwCd2t4Yupny
         tykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8HFbjIkyjH5nmGj3I8BWSKEfArELaB0NC6yKhSNZlpI=;
        fh=5KHue66Ap7xncvJ0S9LZ5fUYER/MadW42gWsY3F0Pb0=;
        b=VutEnw6w/QBlthMphVLELcg+XRZXWxTfKXlnxm8bvqglKEzwMBG5/AeISfkJYSHfj8
         ivROPtknMK7HWv4+mNBNVj483WX6+Lj8V45qymYEGjA2ggL7wNYXYKna/EdxNW3+ZQFu
         ZGEtaDQvEMGgaa1eR1L0X7OBVNgkb0+DiuMv+jWG1D/dKjLrEjdnbZnVOEGCzrh/uIg0
         yi7+sC1bNSQPNZuXWiqZ/E3TndtCwYLLKd7McFnFvMaAhT9EUGaq+sbwqo4Gjt8tifgg
         io0XH6IIJPuM1fKg39YweT2HJTKumRItc7Fp4DX1x3MRRhz0sOG5ryvm9anfYGDa9Ryy
         VSqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782141668; x=1782746468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HFbjIkyjH5nmGj3I8BWSKEfArELaB0NC6yKhSNZlpI=;
        b=Hp/xCq0jSmF/cz6Yersg9ROypQzUYsFPMudkA9AnxhQY9DVZmA2MNW1svteEvdjuJf
         ZJN5bsAPITiqorkm11y0YhAZ4jw4tSTyp8PZtbODaXeMwZ3ue0M3a3Ts38ROalbmEZxt
         JI5jE5mwEP2XebzDjD8dj6XhGJ01fATQHBfdwVj+nrHjqthwL0EUMKORPGyRYzAa9NjR
         eGq2Y4MT8F6snMFB25EVbQQfIOB5l+HzDU5hfBkOwBE0xn9bMOh9+uStqPohgKFdy57r
         claKS6y3XT2DmZ22+A9h+wfF6KyMwHxX60AGPdWGvfidTAuCz3x+VBOH+ibHV6i2+FVk
         PbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141668; x=1782746468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8HFbjIkyjH5nmGj3I8BWSKEfArELaB0NC6yKhSNZlpI=;
        b=orGxyIc89t6+9Swi+VpIdsT+sAtTJV27YubzyY6ofAq9AKJWVa2GTpo2r9GuR2xAK3
         ZaUEvV+e4I87ChMh39nM7htu9yDEAzTqU7rmIK2tYmlb4QHVQwVk9x7XNlJhXuP9PYS5
         8yUTDFbdWXDoiY874KySsBqfNBviCzzNIRVzji1p6jJX7HpQXDC2Hnt+soQJ5O/c4xZU
         g1pSIXVAyWRKASy385yLgGvejc1HoICJj8Jn0ZB95wmSRy28nO/3AKR+HQvc19wwP84K
         iQvb38i2OcrSoKb+ZVm0TnmO3YZ+/sU/oWAHkL8Es3SjG0mqVTsOHF0n1CujneMLFW7q
         PMJA==
X-Forwarded-Encrypted: i=1; AHgh+RpFEVVkZk2TIpDnq7ctzO2nE8HY8D6Xcmhk3+Ow0gVQoq3kUyO24wk+auCKb5w3wS3vNGA0vxJGs+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweFdAnooxK9HQZmWvJiqTCOad5hre9+BunojQRkOm9+HR+cLUR
	UhJSfnzypD4azcTYYQFY/hGqHAlSrBefJxHOPW/CYuGf6AZ43gMaaORg1mlDcBbicyf44i+d3TW
	g2td0MFhf+t5I5qwh3h6Ln2X+KLPbs68=
X-Gm-Gg: AfdE7ckIfPyWlPS75yQ6D33JyzERVEM0KzmgT62D4oMdGagym/xBS4aJlk24CuhtVfx
	swgVHwExmfIcBfCP9QA5MWwCAD/VGylGCxELcco+L4Lmw0zTOW81WOqcUj429bMVc+1Fn2f624e
	ibE20qWF76YMpOndKbMi6Zt9Qyvf5SX84gud577YG43w9vhTKjUol5gro4JK6XnMpp9WIEuR0sq
	cYMbb1bAqTIu2yfQjvO9RBU0CGiTD8Y9SsryLvhd9v/RW7whDl/W+BcefgGv1KYEr424nzJDg==
X-Received: by 2002:a05:690c:39c:b0:7bd:73f3:7a58 with SMTP id
 00721157ae682-801216280e6mr120841637b3.11.1782141667701; Mon, 22 Jun 2026
 08:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622052135.1804135-1-sanjayembedded@gmail.com>
In-Reply-To: <20260622052135.1804135-1-sanjayembedded@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 22 Jun 2026 10:18:45 -0500
X-Gm-Features: AVVi8CeJhQ1YA9yY3iSTy2JTki3SbfzKbLRF3Z3-5aNIG5o5PJNrGqwFOvwLbOQ
Message-ID: <CAKqfh0HeGExuwMpdcW3=OH8Qm=Y261dc2AJs=e8Cyj79_FE48Q@mail.gmail.com>
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	hongyan.song@intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 12:21=E2=80=AFAM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Avoid using devm_iio_device_register(), as this driver requires explicit
> error handling and teardown ordering.
>
> Mixing devm_* APIs with goto-based error unwinding breaks the expected
> LIFO resource release model and can introduce race windows during device
> removal. In particular, the IIO device may remain visible to userspace
> while dependent resources are already being freed, potentially leading
> to use-after-free issues.
>
> Add explicit iio_device_unregister() call in the teardown path to ensure
> deterministic cleanup and follow kernel resource management conventions.
>
> Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

My rb will be a tad redundant but

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

and should Cc stable as Andy said but hopefully Jonathan can amend :)

--=20
best regards,
max
