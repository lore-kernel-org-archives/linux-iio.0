Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E909390C98
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052056; cv=none; b=REdXdv1P/XyGKrR/uHQgUdsS+ua9B+EJWDzE81mm/jjlHn+UoDNr+jb5it2jMk4zVfAuk1o6pcUAI+Xa8IMhFKCGRXs17q0eW+p5pjYLh8W/rthp25LIE2b7syb+vlmKJmVp0R68IDnDtbSQO4jYjej01uW/113RRig3eV1lz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052056; c=relaxed/simple;
	bh=P6s3MH/jJoO7SYO8UAvPe2t0PMXf8YEo0PrAHpGQA6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc6BwmNbnbtWaiSkAuaMSouyc/faKAzVKNSWzIPHrRqFcSa5MkBma0BupOnGZM00qUqXXxK9gAG7/bT3daZTUuGPQJNujlvytIaw6NuD7Db5NzQNoS/MJdhXpEFSx543zyUwciNH81a+djeN9od/9/PTJqHIA0/LPAuNe+8KZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so10168791d50.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052054; x=1773656854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6s3MH/jJoO7SYO8UAvPe2t0PMXf8YEo0PrAHpGQA6A=;
        b=ZZKiblAyJc0iSt04m/2SPsCVwWxlrbJWEJxNH03Db6bxQd2Zq7zca8f3Ye7gj49avv
         ocdrxkFeUv1WlptgiCbyIsj2WlzHGMWvxSK3S0dX5xNQ2OJQBJkM2r2RBZUj/P/lP70R
         7Cshx+47lXT4ye4NdfUq3qE4lPZIHpKWWgrfgQo7QIca+cBPqXrv0ASW+zo5kzFg9Q4J
         H2NVZk7G8PYPLRpO/tGQall7kATx7jApG/BPac4Z92RBVXUZR+fxomK6h0MOHwIYTsFa
         cVz2RiD19mU2+tWHK/9PPoX/ZllHw4LZnqwU2mmQrRKnbR/BVBqv1nka97Kr/TZ1BeFU
         3Qew==
X-Gm-Message-State: AOJu0YzFRgS5Ro38xUEbN2EXWBldehXl1tcQb2Le+16duA55zLDDc1EJ
	krMebZLYb7vWpTJ5Gs2QpOyTvA81momwRR8hKR9+WikPTMsAitnbGYNyokWpN2+clNo=
X-Gm-Gg: ATEYQzz8MOrQ5LW2A/f3PkMD4zQ//3p5nDVzH/lHhiE4MReVYZuJhUEga66jeckjjQ7
	dWSWKpWxy0C/vk+EhpPIvduxoPBgn2pz36dNTt3s8flDVT64T2uZWG8EniWzX6U0/JEQ4zdEXC7
	ItZbKE5EjiwUtmhZo7LAzZp6hRyaLfD+fksOtJZx42eMwXdYgoA8hJsQXhJANzbsR9881p0FZAZ
	TgjO7rLnvP+zsVSlWv0GQpJS6FETzYrk4/PKhYhikn16K49lBL21VeD1jlNQBDYVlEdIPlL4O6f
	UYQ2LajWHSyZuviJ7AoXs5H7Hw1FMeLnRa/4sDEUTGsqVlPzccF3Po/Z98gl7qJo6e9EFarkl8+
	fQpmK8ngVyL4wJV+NKAKGof+zEliAevWObXrsoOtWAOJiZS2t55bZdU4NO9QZq3YJ1nO1J55gey
	pFQ0sjWSzppHlJQ33J5QPVcu6UiYt+FRUdLngZyreSrlvWaQIcsXo0QsZi
X-Received: by 2002:a53:ee57:0:b0:64c:f4fa:4030 with SMTP id 956f58d0204a3-64d14147f3emr8380132d50.25.1773052053872;
        Mon, 09 Mar 2026 03:27:33 -0700 (PDT)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com. [74.125.224.41])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4490612d50.20.2026.03.09.03.27.33
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 03:27:33 -0700 (PDT)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so10168776d50.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:27:33 -0700 (PDT)
X-Received: by 2002:a05:690e:d4b:b0:64a:fe95:2ba7 with SMTP id
 956f58d0204a3-64d14164dcfmr8540934d50.31.1773052053325; Mon, 09 Mar 2026
 03:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308113728.40860-1-email@sirat.me> <20260308113728.40860-3-email@sirat.me>
 <aa3lRthNn_VnFChk@ashevche-desk.local>
In-Reply-To: <aa3lRthNn_VnFChk@ashevche-desk.local>
From: Sirat <email@sirat.me>
Date: Mon, 9 Mar 2026 16:27:22 +0600
X-Gmail-Original-Message-ID: <CANn+LWKVJgXTTyd4usZcaAzvws1DvzFuQ2Lm9f8xa82SU36DDA@mail.gmail.com>
X-Gm-Features: AaiRm53h6ZH54dnrZHqTiLaAAypfc59YYsLzwVe9xpXU3VKw9p9GkpNrHeAaZHw
Message-ID: <CANn+LWKVJgXTTyd4usZcaAzvws1DvzFuQ2Lm9f8xa82SU36DDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 3:08=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Mar 08, 2026 at 05:37:28PM +0600, Siratul Islam wrote:
> > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > ranging sensor with I2C interface.
>
> I'm sorry, I missed cover letter, but can you remind if it has the explan=
ation
> that brand new driver is needed because of ...?
>
>

Hi Andy!

Thanks for the review. The existing VL53L0X is very different from the
VL53L1X despite
similar naming. Trying to extend the existing driver would mean
rewriting most of it.

The VL53L1X has a different register map (16-bit addresses vs 8-bit),
requires a 91-byte firmware blob at boot, has a VHV calibration cycle,
and distance
mode/timing budget configuration that doesn't exist on the L0X at all.
Also, newer
abstractions like regmap instead of raw i2c_smbus.

I'll make sure to add the info on the v3 cover letter. The rest of the
review I will address on v3.

Thanks
Sirat
