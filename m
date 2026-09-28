Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4F28686
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609477; cv=pass; b=TV7Q2LC5eUxZv6QqsJZI+tWnfzm5D0zPsy1xQICXE/sM08mGqA40SK5glsOx1DySiEfPDZuCTrrhhqHuxzF5Z3xbtELkouZh6ejvck+yTBw7/VAByYvU9beQpvFkdz2nevOC3W3YzjSbl6t4eoWIlBjNYNzgmJwK/s4PZq0o4vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609477; c=relaxed/simple;
	bh=URdrVF8CUCfl5cEEKueYF3bFcAaehDEpLdUsL9ZEN7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shkc758WHhg+RIT65k8+BlrLlkuZ+UmhhEZegFM8Y11mlfAntenW9sFNP54S2ClvkJR+BWnjU33BLxmIsAHxhw6QOT/iEoVLSN3q5GmdS2xBj7Mw7wvmQEddIbzHOtN/0uA0GckOAL1yQ3ouYmc0mrJZdIKakq/4WdBiRZmsNdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFtM/h4q; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFtM/h4q"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2da4eea067so243112266b.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 08:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790609475; cv=none;
        d=google.com; s=arc-20260327;
        b=SumFPFHW08L+7+zlhMwy34tmEcHWnFJGOaFFgT3lgX6Aoq8qyoUhrjcSP5/bg7VGd9
         e5Wfaxd+OeZ5iHddxb7XuOYC0u9B2hxJ2Uv5D+X2N51t2Z98uuMXFgp4p3bpZBMyEvYJ
         +pKI9VWl9PQsploK16nJaU9uGbCjOsf6aGAnkWUZn6n/nFVHu/xGAWKxRtKI/f/BwjDj
         A7CIzi+/paQPwPw6MiTRaYVP7Vh0nnGoea2pt1xm72X7sbi5WWgmSauBUiy919LsBfg5
         NJiMYPi4Ya2JDyvOO4eLWe9hlilMeQtP8QrxtqSZosqlK+OIpPEgiVYNoC1mNqQ4wUt7
         7Kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RAXuWKTislQVLPyYyJ2DQuvsjvgmRgUDTyRccJU8uDE=;
        fh=8d8RxbytZMqW7vAM13WIlhC0ZyBt7w7GKQpamFbb/XE=;
        b=hgA0MUa8KRfaufvadlEzxn3sQb5ypewBs7Y8hVq/DgtKdig1aCqlqRf+9Cat6FFWsZ
         DIirfCpceU8hozJGUaxAF+laCEkd3lPfJ0cH/NGxQqoaQR1Y5iRYSBaGeTga4u4/lGAm
         OYjvw2yqllpAV0yg+6n/nxqKhbwhnL+kkPeujZFoUCAye17sylCaq+FPUTUVIRvJBTGE
         QUCpDRxkp/55t0V8w+1dg3f8ZTwe+ggyuQUfMMgImkLtsvD9gB8Ilm4ePO3RzRiJ+9Kv
         JJQc5XJK0KTvvwh5vC5vvIZBI9jfRNkFpSMqbM28DGdJ3YHyjpySQAmQQYkpCk5844f+
         dEJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609475; x=1791214275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RAXuWKTislQVLPyYyJ2DQuvsjvgmRgUDTyRccJU8uDE=;
        b=pFtM/h4qzUo22QBrJ3kI8EXOU93rF+MkrQiCAves69ufrXDm0sL5PAFaNveaQYc32g
         b/UoTAmBcWNLjUKqaFyE7gue8UKrYgbHliq+SdcWHKj7aHMbcrlwS40yzjIy1fwmF6pL
         6+JUjjnaySr80UqE9nvnTLlRAMdtVWOs9gmhbFWbFE2vzekDB0/JshAb5txzrZ5SFohp
         emtIFQ5YQ1osyCRUjLTaDzhDiJJqfCDuRw+fQn8JTDNuQY2nDJKTc04N/Uh6XxgpUgFr
         VuJ4RyAJJRaMGkDtzS7q98hoih/nJRfM5pvwEpHCK0KWfKL0ubzBjnaT3nUZzD4NgiWP
         OnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609475; x=1791214275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAXuWKTislQVLPyYyJ2DQuvsjvgmRgUDTyRccJU8uDE=;
        b=GFCedXyVHUUOsuQgP5mnUmp2DKgQwo+HpBfEMD6TXUYZWm/73NjwhPAM0wUeW9o+2x
         eMgr4+DOHQinaIaOxlo2e74nUH4GSRflKm3npaVgGEn5mdVLNAKLxzAUHKjHpZvc85nR
         7BnKTvLrvx+6HqfE54XBUbsz/zFqI0G1g0vF+QMZrTgNfbXob0ix5yzZiU3ghGDBQmdN
         s/eQu1i0pkB6BUOwNF95/YLvMnRHKqVpf1ZoGxawKB42s0/VGKOxJdjfZuEJmtg7nRAS
         o+ItF/Vy8vOp/AISvZSF+k4JB3pAFmbLKsUpp4mtjWNMRglHZ4serQ2HbG9fQifi0YqW
         iOJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOexXBEl8HSltUrAO3r3OKPBqQYh494qprALgJBxGEWmN6e87zE/jF9HZhvRI8IZPQeJY6PoFo/LU=@vger.kernel.org
X-Gm-Message-State: AFuF++kTrBftGRmrBC96+KQyMF/Nf/fitfLitXLcDMiclLZueksFfPDV
	tDRzeNw5WHQ9RAOAwODjZS/n0Vr99jlhVRdTLWz4I1dIRRBKbiHXdNrB1lydPO2+AA5tCJfFytt
	+ImM8QERNMFtiHvRPlAU8CikxdnXc51M=
X-Gm-Gg: AYBFou3/xCDh6aZoF9cVzl6gjSVlEkFwb6ZGhC7Xj/vhkUySDmOwno0WqpcRPY+m1f5
	WV2v+PRRzsRnjq/v3+AKzbOQJKLSsdh03JuSHOe7CJ4cRWrOV9Qm/xWARtvJ0xfsEg80Tiokwr8
	Gh0u8hz6MMvb0PNnLYAJx69sDjVq+zjFbMNXqs/UzPrRzvCko0AvZJUlIbB01JiXIGi5Vn5SLht
	1Nexepkzpa4M481iv1fttb9sQcgUEVkaSp7HnN4u3LYiTmCeL8VWiWvnxlP6Jyqff79AQODeaN1
	FvnclFYIDA8k/uJEn+NYqMvgoicI+LXXWp/AiGXCNb5jSTYejvEGnzO+WoJpLgOIXQkoen2l3DL
	xSGGDGnxeYGZnNtpf0xBcasCfymaB2x8ITwNrC6sXWT5Eo48DMs1Lq1Il1b8AoaW60ZoG5W04Nt
	PCp8N4DrdO88LKiNaQ5LQqxr7qubg6EC6n2FhnQQkb
X-Received: by 2002:a17:906:6296:b0:c25:541:fd3a with SMTP id
 a640c23a62f3a-c2ac525f2e5mr1076429266b.7.1790609474421; Mon, 28 Sep 2026
 08:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928142450.103799-1-vidhu.linux@gmail.com>
In-Reply-To: <20260928142450.103799-1-vidhu.linux@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Sep 2026 18:30:37 +0300
X-Gm-Features: AclHuK-5IKTJHGjSEb6fW93reQsGc4rhOzFPJDI5ScaUzd9TfeEPZ2P1lvjRVCw
Message-ID: <CAHp75VcW3ADQdf68Whmo7yhqu9rdi54YVYgyh5PRLPccH6aUBg@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: am2315: fix negative temperature decoding
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Siratul Islam <email@sirat.me>, Tiberiu Breana <tiberiu.a.breana@intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:25=E2=80=AFPM Vidhu Sarwal <vidhu.linux@gmail.com=
> wrote:
>
> The AM2315/AM2320 report temperature as a sign-magnitude value,
> with bit 15 as the sign and bits 14-0 as the magnitude.
> am2315_read_data() stores the raw value directly in an s16, causing
> negative temperatures to be interpreted as two's complement. Both the
> read_raw and the triggered buffer paths are affected.
>
> Decode the sign bit before storing the temperature value. Positive
> readings are unaffected.

...

> -       sensor_data->temp_data =3D (rx_buf[AM2315_TEMP_OFFSET] << 8) |
> -                                 rx_buf[AM2315_TEMP_OFFSET + 1];
> +
> +       /*
> +        * Temperature is sign-magnitude, not two's complement:
> +        * bit 15 is the sign, bits 14-0 are the magnitude (x0.1 degC).
> +        */
> +       temp_raw =3D (rx_buf[AM2315_TEMP_OFFSET] << 8) |
> +                  rx_buf[AM2315_TEMP_OFFSET + 1];
> +       sensor_data->temp_data =3D (temp_raw & 0x8000) ?
> +                                 -(temp_raw & 0x7fff) : temp_raw;

Can you use sign_extend32()?

--=20
With Best Regards,
Andy Shevchenko
