Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906799;
	b=lqsQeq3mCfFG7rFBJmYR4YWkB5o0Wn+ksPPyy7TOUesOjTi3eMNR4bAMwE7c2CwzYL8r
	 gnzfULpDrkVIV7UdyGe5X2TvQChyqlSs+nFEDHHa+4GA8uwe8F2pUg1A+qQcYFwOmKibM
	 xuCenzGdyyFMjgJEjlkN8ySCUBgARDWW/paeLaqIjY8L5NOvCphFH0gWozIFwzUopMcsT
	 vjcANaIW33I7mZtRLo5vkre95L/hAeUjWjjnAmAhAvdwnjq00ZEJd16A56GgxLHZ/NzLm
	 YqjyOI6EYoEqXUj9iy1s12zJoBNfEgtyFMySdH+ROYAkzVDNw81wxsDIWS0FebkvI9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906799;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TZphQxclz2gFW9ezkdnyrlJdzJISPtOa2u0+oLIYQtA=;
	b=ocpp5xESatwVaeQscbUdhfJrbYr/JWfm8ELEIs0U+/r2yklrO3oiFFZj9SrJN0rLLf+j
	 maJcAQOkZuSEJ5vskKxebR5Y/tO3XUfgCHkN/sjJSsHh8GjcoKuI3hsCpxmwZ3sH4o+9p
	 +x2uA17Rnp6mTNuQvWbg3FEJTTw776cHJkwhz0YsqwH6Z4wq5zRdcDZXBrzYIsYSWcjre
	 8xNsZMv241ETl9JZDvDNHgR7d0uu983O8V8wPxRnIOM8yzUOhWMoXk4chyGA/cUwzv/0l
	 lG+jIrq/KoFHE+xRUHJbvqJZ5FVXf8DEKzWKmEAvXtqrlq/l5U2XtTiHHfNSuUyNv+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=maryasin.name;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67C606A329
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 19:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E67C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maryasin.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c49b431f022so108971666b.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 11:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906798; x=1794511598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZphQxclz2gFW9ezkdnyrlJdzJISPtOa2u0+oLIYQtA=;
        b=f8kVjHwzSOMbtWX5a6owhXMO6nVxDVXw6pHcQpZvvRN3m8HWtXVoKSQ9avL8cyCVPf
         03/IN9y3G8EALaLyhpLS4dZtIiYm67PS+01yIJxlHTVTpx+1/6ib1LBxNB/tsUwolofC
         xRNXPisx8P4Zvx2FhGXfJWtZPbX6SmY/N0rhA3pSgcGFkZY8uzRyDzAO4LnbqSAM3iPO
         2V74c/UYUK6oIEC3azxwzXnZkab59zQjmjy6+6QXNW5JVKr5muqft7Zya2ow0Kvx3UtX
         Qi93Oz4nI/uAhn0QWtDat9sTahqaz2wv0VSvzR3KpEDO2T4YdHbjoBqkxwe+YyggcLmR
         TXrg==
X-Forwarded-Encrypted: i=1; AKwUvByR9yzJvshB+P1+dLVr4xYParV7hWW0hSZwpVXHpB2hO1Fkk9rXM0spC1AhZMzfSK6Ov/9o3HCsKYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VNHCCZzO4vhhnCgPuUu/Ff1B39WGeJOWagWbEJsJGYkva/TdF
	GsqnOs+7ddmzz4hr/HPDHJteFsrUCjVg6tN1MV3mVZUcjnW1s3vYY3dQRCe0Ck/i/toPZg==
X-Gm-Gg: AYBFou17hFCE0jMrw+FGDOxpEfEpHhqJs/GjscY4vvtbKqzSPhclO5TkJy/12pKgAHd
	KzA50yocvtFvrp9PrEbcYqbesuwruFXolJCAJZPkA0Zf4jh44hSNE91vjkdQ7X/VIAe/rrFo8IB
	9IVJzhm9Sz663dfYf6yWUEuYGLSRS+0cJ/cEPtTHgILfiv7cXXVcrhT/9h//YJxxJXKqZ5+RE9p
	MZbf1H+b9bpM7AjjKWdj0GMxdz0r8f8rWjf9rwayTOQ8XrdJPhUWGLE0Swj0rT61faqLeMigPoy
	9dd3Uvt9DXsJpjz/DnEyREKyD+geC5rej8MRvgDLO5JJn12V077KZgn73G5iur7uCpWDhyWEeIo
	S7DC6KTDVNmG1vQSuZgE5M4iC7U6UZJ/PiAoG660iBUquVpos883BruEnfn/5x8Y22nEeg9XYoh
	HdlUHC9yuBnqNwKkSkdIfrMpq8Izqj/EL564krm5YG1Ht2V8KnBZybHUUP/CiBl4AerlJqjuqyg
	rUERTnj8USGN85B3/Vhv+RR33x8w4uL1AN9s8O+ZuuEipAVV17rs35vpeLLUfBN+MYouuIpBC/3
	zQmgS5DCPNB0fBC8xMu4qLAFRyPW0jiQYy5wnpHADq1sntpUlSxONzyLC6BNjI8cT00SrQ0SrDo
	Utn1i1ydWwxoHUmmMD7PJR0W7x/254sABFXNl56v0MdkY+n1aSAP+5nfQ3bCZLI+JNQ/qBGz8x3
	pfeyvtk3hJ5C7A
X-Received: by 2002:a17:907:72cc:b0:c42:3a77:80e5 with SMTP id a640c23a62f3a-c4d34cf1aebmr45037066b.29.1793906797526;
        Thu, 05 Nov 2026 11:26:37 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c6025sm10735666b.73.2026.11.05.11.26.36
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 11:26:36 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso3636451a12.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 11:26:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy6RP32mh72RDUUA0zZ1qMimkUUheRVLaDB2sARwWQ1IW6WMS3rIGFHSy5aAZxPfqe8tI53OIYYxXo=@vger.kernel.org
X-Received: by 2002:a05:6402:280f:b0:6b5:8674:c01d with SMTP id
 4fb4d7f45d1cf-6b5975277f0mr197220a12.5.1793906796627; Thu, 05 Nov 2026
 11:26:36 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
From: =?UTF-8?B?0KHQtdC80ZHQvSDQnNCw0YDRjNGP0YHQuNC9?= <simeon@maryasin.name>
Date: Thu, 5 Nov 2026 22:26:25 +0300
X-Gmail-Original-Message-ID: <CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
X-Gm-Features: AclHuK9weJ0gP1AI6YK6eNmMlqgPCqXQEUZ4hk_XFsi6eDTrhg4oCQvVn1yYuq4
Message-ID: <CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: hid-sensors: fix fractional part for unit
 exponents -7 and -8
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Semyon Maryasin <simeon@maryasin.name>

Here is what I observe with this patch:
1. Enable sensor and run xxd /dev/HID-SENSOR-2000e1.3.auto
2. In the second terminal, do rmmod intel_ishtp_hid
3. Observed result: xxd stops with "xxd: No such device"
4. At the same time, in kernel logs I see the following:

=D0=BD=D0=BE=D1=8F 05 22:19:16 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
005:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:19 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
005:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:22 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
006:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:25 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
006:
timeout waiting for response from ISHTP device

No system crash, so I suppose this is okay?

After subsequent modprobe the sensor initializes and works properly.
No kernel crash with this patch.

=D1=81=D1=80, 4 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 19:53=
, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com>:
>
> split_micro_fraction() scales the remainder to micro units by
> multiplying it by 10^(6 - exp). The unit exponent of a HID field goes
> down to -8, so exp can be 7 or 8 here. Then the argument of int_pow()
> is negative, which the unsigned parameter turns into a huge power of
> ten: 0 modulo 2^64. As a result, the fractional part of a value read
> from the hysteresis attributes is always reported as 0.
>
> Divide by 10^(exp - 6) in these two cases. This matches the reverse
> conversion in convert_to_vtf_format().
>
> Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> - Fix __udivdi3 link error on 32-bit by using a 32-bit divisor
> - Address Andy's comment:
> Keep no % divisor in a temporary variable next to no / divisor
>
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/dri=
vers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 9e7c26e37880..d44091faf122 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -96,9 +96,14 @@ static void simple_div(int dividend, int divisor, int =
*whole, int *micro_frac)
>  static void split_micro_fraction(unsigned int no, int exp, int *val1, in=
t *val2)
>  {
>         int divisor =3D int_pow(10, exp);
> +       unsigned int rem;
>
>         *val1 =3D no / divisor;
> -       *val2 =3D no % divisor * int_pow(10, 6 - exp);
> +       rem =3D no % divisor;
> +       if (exp > 6)
> +               *val2 =3D rem / (unsigned int)int_pow(10, exp - 6);
> +       else
> +               *val2 =3D rem * int_pow(10, 6 - exp);
>  }
>
>  /*
> --
> 2.56.0
>
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=
=D0=BD
