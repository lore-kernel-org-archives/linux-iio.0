Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF73C7E07
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869459; cv=pass; b=gjkQLAwMqQ+QUotYQRIrvAG4ua1ak/sSFB3dXB4CksW6sYylMK7qukj4Q4cJtFGQtmSBzRwee9DTjD5vXp5094b6LliLnB2M6IA0F2xZHGSXZxaSCdU2YYmXrd1fTkfquKxB4K/zsdV1fYSR0mjMYu+xCsYJqGjYcS8bU1yh27s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869459; c=relaxed/simple;
	bh=eh7kEkBeHvbWMvzaF5q1o5H+ArkFOARG09QsvxkOvpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYGRa7WhH6W5ZrXk4IfHdcyKwzbJjOhGsYDN0velaCRRybcQJkvxL7Ru508rkgg6fbpVKANgGfXY16cTkiDpqebqgYRKozLLMkuflsKwYjlq0lyBKxeJQsdQmC/zwKhAXzc2KvXvYRgjVAXM9uYCAwLrDHUMLk/Lwrb33+kTwms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHmu9kkz; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHmu9kkz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bcda7765d64so2212929566b.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 01:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779869457; cv=none;
        d=google.com; s=arc-20240605;
        b=Nrt6cAAuP3H9iUv7Lbbk6fgnfs6mm7qK2IoCJTBTQaxYO3jSxXHDD/CFPya25lI8oa
         Zg9Z9sk/brGCmfEUK1krJXOzvjydUNVsA06DjKNUR8MvKdik/s+Uv0asZ+iIsb59J93L
         zEj08kaFMSALPMCpOsf1fY3ErVjHU8NFK9PF8R+QKB7B+abJmTtNrXjwDsd5N2AItUWf
         zXITUtXr1pQ1UNBMaC80kbfFs1Q64WJxdhKq2Ra5JmwioxZcHNGHTKTu8OrxTyNVUOTe
         uySXPIv6IzZTvLy2uKB2UNnosbDv7cmRkw7SqSdVxweo9itACdQI0wUJikfbimSAnd7k
         uqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNZFzbb07apK1nUG3nSXjFrXAMtMQTHwbifCgxx+J10=;
        fh=pwmAPVtoG8Y1a9QBQFtSUmxMGqPnoojTyd7BhbnHsn4=;
        b=M/h6JleezsMhGHOAkJp4aeDnCijA+MC3uGI20Ss6ylmrR3yNfUYj84s4fUbDRA3CfZ
         K+W0va3xAKGOltQTrsjY/VyjK1OAl2UY6cjHt/OSlVPpHbXtuxdvUuRs9a8sXcBfj3no
         z01+eGlyyhJSfNVCbQc05+SLIDFTWu28ty9OLwMjzUznNH+tbVZgI93QLpOBhsLIhbu4
         iKs0txgDLf/cJ+sXuB/8i3NN5WTod3Ws4Fr7FLKA4QwNkTlqrLpZ8tEIyn4BK03cKZ0m
         S1GlfmmdvOzkRIz5ngjzWItigePnW1rPGObEagTfq7mWqcVJ7CimEvcylRK/0OlOqkRX
         OGwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779869457; x=1780474257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNZFzbb07apK1nUG3nSXjFrXAMtMQTHwbifCgxx+J10=;
        b=HHmu9kkzxKn/7myqE39ukFiVKPPv3mfJSIlvjqHrm7IDnpLodZLHwNwQpMOnE6INrW
         3V09x1DLpNcKwMOG/8otvTiRP6GD+eHDq1IubGZKbhCYrHaTnktGF8V4ZL3tjWxgIaPy
         LXYRk+U1+rU4AnzYdLScAVC/dHPDj6vyQcM8bl7edwx2w12R9GKM0A5u3GPok5Busxjr
         rvOUJzHxhaxkNTb3/nmxLW5Qm31xSXY2inpu7HvUwmD3rNXnMPT8myLZSk5/p1xp1dHT
         EMsQl0R+sOkgCSlJLoW30YKnezIHQAZ2I24IN88anK8mln/p65ofWcVkq1+AusvqAg6p
         g2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869457; x=1780474257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNZFzbb07apK1nUG3nSXjFrXAMtMQTHwbifCgxx+J10=;
        b=iPmSI18vcgdvsaW9WOz+cvXLClSidWcP9LZviI9AT8ziH6HoywAvXISGSFtSWcyQwS
         rIGG9832s5BLlESaU1xSEDmwSJQdvO5U4rmlrZc4Cy3QWCBFoAs7oPQFsCDdejkQ3+uF
         3CctS8TEAYZdm9In2W6433Y6dZ71zaG+xxmbcUKbC4GMFSpfakQd+WvA7mlq1xyVuEIp
         mma/LnWh9nmLlqaGEK9ZtgNaaEzr9KEm++ujvrVIaJDGLcDeFdz60B0VjfqN8t1ikERA
         6Nf4SmW5WTaljchrX5WEisErvfzLeO1E8hDowUgC1GcgjKSGSGM7UafSCxE86TavMOIJ
         q+nQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Q+H8UMsoB0Vh6xmDj+p/jmBlBhKQP1pNd/pvQmXHBUOY2GM9ame//oyrBxY81abrNMpCGtXkZAf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdND0AT0YLXtHWGj5zy9lbEaIH7GbZlxOYJKFyhkTGTV0TcYa
	4EQS0qodwfKsalMxagX/dTZxv2ucrtmSriJXGxQzVYCGHXSO1sk8VWATI/AbH/PY8xyQThVnrQw
	JGurkZemoPTotSb5wkd2zEOo9ub0VFlo=
X-Gm-Gg: Acq92OFCXQsL6tjn0qzO/Vce6JRlpZzp/YZx6POSj2Yg7UaRyhUs1y0Ow/A1jq56RV4
	XMoNO1mn3YNdyVNllnoMhZB0a+iPhIgpX2Bk8f8WsxSMXqg1c4a7XEmG4Tcnjbe2sB7N1ZsZznr
	ODkVEf4dogUH121MpG2qDbuX03aatY4yJI93mu1/7heXHSamqpesJ0gw6derPb7jjQLuyHD7soO
	FF6ifmCpnvodEkd0EDAmsEluIHg7UVJGqiqCmM7SR8pdpJM885Hv1spWnLcKehZq3IsZTyCI8MU
	GvbUp3IOnbpEz4uLWFZDGdNeYKvxvL//o95Db5HQrEHQRyo0zS1/fbfq1znErbzsbSz1YV3lWKk
	dIC/QyxgUvUMIhmYW1fr1o/14Cfo09wq2pdMy7cteuWMcncti/WHxyVTpDh+hG6WCyzr8zkGeZ4
	U8R4VktghUkk5HkII=
X-Received: by 2002:a17:906:d014:b0:bdf:b9fa:6683 with SMTP id
 a640c23a62f3a-bdfb9fa7325mr546535366b.14.1779869456736; Wed, 27 May 2026
 01:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525152137.7428-1-sozdayvek@gmail.com>
In-Reply-To: <20260525152137.7428-1-sozdayvek@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 May 2026 10:10:20 +0200
X-Gm-Features: AVHnY4LdsTesxKhmNFsFl5OzZKMwGtLvpUqUeN7_PNvXsYAIAJ3wg-Y-eqJyNOw
Message-ID: <CAHp75VecaMW5S+jtP5ZMr2ZtPTHXsTeVzos7+WSpgnj7YcMjLg@mail.gmail.com>
Subject: Re: [PATCH v2] counter: ti-eqep: balance pm_runtime on
 devm_clk_get_enabled() failure
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: wbg@kernel.org, m32285159@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 5:21=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.co=
m> wrote:
>
> ti_eqep_probe() calls pm_runtime_enable() and pm_runtime_get_sync()
> before devm_clk_get_enabled(). If the clk call fails, the function
> returns directly via dev_err_probe(), leaving runtime PM enabled
> and the usage counter incremented.
>
> Route the clk error through the same err_pm cleanup as counter_add()
> so the runtime PM state is unwound on every failure path.

...

>         pm_runtime_get_sync(dev);
>
>         clk =3D devm_clk_get_enabled(dev, NULL);
> -       if (IS_ERR(clk))
> -               return dev_err_probe(dev, PTR_ERR(clk), "failed to enable=
 clock\n");
> +       if (IS_ERR(clk)) {
> +               err =3D dev_err_probe(dev, PTR_ERR(clk), "failed to enabl=
e clock\n");
> +               goto err_pm;

This is not right. The devm_*() should not be followed by goto.

> +       }

...

> +err_pm:
> +       pm_runtime_put_sync(dev);
> +       pm_runtime_disable(dev);
> +       return err;

You have to use the respective devm_pm_*() at the same time.

...

William, this patch should not be applied (or should be reverted) as
in current form it replaces one issue by another.

--=20
With Best Regards,
Andy Shevchenko
