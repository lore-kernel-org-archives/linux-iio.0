Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119959;
	b=wqq71pUEiHNlqTVdBZ0XYcKvsuD+nRFL37xyvHCBPaUQgFandZp1RxH6ih6Xg1wxEWPX
	 vf/TKdNVl44njlaptEtETzX3XzkmTw2HQADp3hgMM84rFZNWzkO380/VLA6i/BPRtbsEb
	 84Ej87UNdHBWPPT4HockMYDCtPw+PREaNNpez6RG8XtBAYO2sqEBYsnHWlbJ0pLalJ2IS
	 QnipvmW9/u8pktvrYjJWQZqE13qr5Tp3MdzUk/tJfVCJnY5WXPvzDIhJ/+h4K4sgn+kpv
	 2F6SaGogZ5Tjdn7yojuTjFChQP/f6YXf5dTjKmDUG9LmD+k9ka/K1Z6YrQ6ZdPOps5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:Cc:To:From:X-Mailer:References:In-Reply-To;
	bh=kbsd3smpsKE1xqx27K/D3zo9SvefwIOkhzZEOizfuio=;
	b=JBx/8HvSNXWe8h9puz7tOkZsZEJk5AgZJjPYV4iRN/rjwc4+3dzJZ3a5r+xsZuqiKnYh
	 rUzJSFB8HA4o7IY4sO+z1iv4BefhbbGJtrbT/pFJv1DGVksqdnvPpji2W1LOMsNRmfrbs
	 AM1zqjeqxHGSYvK5iuLLRWIMApmxm0tHltFG7qpQ6vwtknFqXMfy/FqdUmKaB98ecg/0Q
	 9zGnewKvtYMjKxZp7sxuSeg5ycFeS0yzlt/WyTRH0ojGB8MYB4S9fNFlkKMcXFPyGeDrE
	 DSPmdMhPLhilmiJ3VmslBqkYnVp5A32CJxUShMzQYYy3jrsBTPBPaK8uKD27W7B42TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DcjtgjTX;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72791606A31B
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 16:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72791606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DcjtgjTX
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67a6cc9acbeso46055d50.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119958; x=1793724758; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kbsd3smpsKE1xqx27K/D3zo9SvefwIOkhzZEOizfuio=;
        b=DcjtgjTXtEdgC1bhvRAnyTPZma5OI3VE4GrINbe/kwo65uZfS8pthPj5h9S6qxE13S
         1W3r4+mNCNnWztUjUx8kR85VHvB9QEJcnxYNBBvXygSXWpm5BxopqumeMaCqfZf4sTOw
         GU4/QAcRk5Rne9D/p0QpbBEmO7Ezk7ck0iR/4t83S6IqgJgxynokhs6JXZBoZRaSvL9L
         MM6LpL9+OcsV44QoNIjOndAbdR77JAQm68NRn4865j/Ky/wQ8lNHx5WJkgcWe1a51Glh
         lXpZbphucm6YwvQ3MQbGOvAhhMOrCk5v/WdwpwrrIShf+VWFpjZvHiEIW6LtszDxxtRq
         kjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119958; x=1793724758;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbsd3smpsKE1xqx27K/D3zo9SvefwIOkhzZEOizfuio=;
        b=tKp1oBqw6l9MNs8I0wsu17ZQzGqX2bwudWvz9M9goAn7fWv1YkjpNPPGuHKOTS/PM5
         bAi2u26Kce4yIG8MuSF5Fl+10p92ZlIjdBnqST3OS9VlCrD3mr5FJc/dyw7b9JooUgCZ
         3M7LQ1nW/Zf05z5GU0Pjw2Q/WZotxglt5zl/7Y03Ij86dqQ0RRxWTEajBXLPnkczjwue
         tvQbPu8EJUuxe1WZZEveMNb4dUBOK/eqDaZD9ZvXmmznPD5LUulESAetW8Bihc/5Qcgb
         pjl1yjxxbbZcoIejNfpdNBeb7DgWNIRAHNfYJvHYK8hA9/EYpYC+dTxWSmAioIc5wIq4
         BfLQ==
X-Forwarded-Encrypted: i=1; AKwUvByT9o8rMTf1zvaXjFX+0rrNaVusY3mF/o0IN4sEiK79jwr0YLVAfvWNUJQT85GlRPP1X7rlqvRcClg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCDqxUMoxl3agJ6mXzJDbuCbcwrJelRW9Jr8f6Tq60GBKKkI5p
	VVufU5b6hcKDuKQxapygF0t5ADZTaBVideQEgnTdVO9Ye82Qs9lWYC0v
X-Gm-Gg: AYBFou3ySCmGchy2F+rbGMr6jIahF/cSiQ9azO8+DTjuCR9Ah4l6B4/hzAprkuPQsSA
	OxCBQ9HkDzbMggjqRESatI49WUU+PaNw0NTHlPwwIDsUOIzlnmt/1BKoLe8iZ1VcYUzba6froDY
	2Qn8UYJQ64tmlm5xpMlfmbTi6CjGOaASmEpk2Am3BT4l2KduS2nXv9RQDItPS1DJ6iZVjmfuleA
	H7HOLtp/cLo5jPYMZWc1D3RaYznmwcLpI014585tUGqHFvMGj3VKwrlXuijVqLEoibzi/nWK8AZ
	4gT6oeojsj1QV/xN3S/3i0LbkcGhe9T/6vLY2LIrKy2XV22vXhGlfuOBbzVSec7WcuxnXLL5hXj
	he3yL0h66ZO6ZUw0as4TlVFJ2FvdtY/AMpsj0fI36bi9cKI6tjKdbomnuup2q0UUg/nhjzRTwgi
	GSewjFuqr6h7bDyu4NUbiI7RUwX4acmP7MshQSIA9q2BXi6JktKs/vU41s5ajGl6yxb/5KwPVHE
	5wsE7qO6BapdLfy6p0U40Ao7+CE4j2M14wwVigrYgg4nLIXDR6ML/1EVvQ6qoOOVQdTfwtrs1U2
	VXk4XPgwT2MC0HsDc2GF6lShOQcSk8mscFyTI4Fd+QShx1Ws80LjNZM2e8nNST0OEE/WNBQeEMF
	da43npceqIdzP
X-Received: by 2002:a53:e7d0:0:b0:677:c8af:d149 with SMTP id 956f58d0204a3-67a7bd1804fmr61705d50.74.1793119958354;
        Tue, 27 Oct 2026 09:52:38 -0700 (PDT)
Received: from localhost (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a080d4csm425545d50.4.2026.10.27.09.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:52:37 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 11:52:34 -0500
Message-Id: <DMFRZ3B3A6CH.P7SKUZSQR23T@gmail.com>
Subject: Re: [PATCH v4 8/9] iio: light: veml6031x00: annotate the event
 enable helpers
Cc: <chrome-platform@lists.linux.dev>, <linux-amlogic@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Marco Elver"
 <elver@google.com>, "Bart Van Assche" <bvanassche@acm.org>
To: "Rupesh Majhi" <zoone.rupert@gmail.com>, "Alex Lanzano"
 <lanzano.alex@gmail.com>, "Andy Shevchenko" <andy@kernel.org>, "Benson
 Leung" <bleung@chromium.org>, "David Lechner" <dlechner@baylibre.com>,
 "Guenter Roeck" <groeck@chromium.org>, "Jagath Jog J"
 <jagathjog1996@gmail.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>, "Jerome Brunet" <jbrunet@baylibre.com>,
 "Jinseob Kim" <kimjinseob88@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>, "Matti Vaittinen"
 <mazziesaccount@gmail.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Remi Buisson"
 <remi.buisson@tdk.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
 <20261027124954.110697-9-zoone.rupert@gmail.com>
In-Reply-To: <20261027124954.110697-9-zoone.rupert@gmail.com>

On Tue Oct 27, 2026 at 7:49 AM EST, Rupesh Majhi wrote:
> veml6031x00_event_enable() and veml6031x00_event_disable() call
> veml6031x00_set_interrupt(), which needs irq_lock held. Their only
> caller holds it, so mark both __must_hold(&data->irq_lock).
>
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
>
>  drivers/iio/light/veml6031x00.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031=
x00.c
> index f6308498e422..476ac3717f8e 100644
> --- a/drivers/iio/light/veml6031x00.c
> +++ b/drivers/iio/light/veml6031x00.c
> @@ -784,6 +784,7 @@ static int veml6031x00_read_event_config(struct iio_d=
ev *iio,
>  }
>
>  static int veml6031x00_event_enable(struct veml6031x00_data *data)
> +	__must_hold(&data->irq_lock)
>  {
>  	struct device *dev =3D regmap_get_device(data->regmap);
>  	int ret;
> @@ -804,6 +805,7 @@ static int veml6031x00_event_enable(struct veml6031x0=
0_data *data)
>  }
>
>  static int veml6031x00_event_disable(struct veml6031x00_data *data)
> +	__must_hold(&data->irq_lock)
>  {
>  	struct device *dev =3D regmap_get_device(data->regmap);
>  	int ret;

Thanks!

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
