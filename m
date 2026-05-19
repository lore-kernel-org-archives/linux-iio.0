Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C2325485
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205994; cv=none; b=UZr9nZHiwXCDsxnkxSm7eqkCv+FBuEEQYjDcJ1OFmtc7DQgduLjx/Zw672Z6x/+K4+wMAafiFwgMsMzTj+HBKS43rqGdaZmnvi6C/LbazccYOSNmQohgMjLhvLV3rIMUuYteHNVhs7usWGU2Rifq8NNOaUCFreI5z6tIhkpZOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205994; c=relaxed/simple;
	bh=GmV62koviKtbLcXZIqOLEUoj4acRq5lIkTFPPKF8lDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QikdHKVPjhWi1CSTC3JWNSR/g+pD2Iy2VU4ECZ0sZpPeltLsq3+9vae6dp3HWZBM+yVPEEp2HcIB5aa4KFVvjQKfmXfb4vyTyyIluchoXFmhJZusfg+VE7nORwpd8XLFJVsr0DMH1kVUwE+/7uEoZPSrEXqpLfziNeK6WyFxTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e582b3bcaaso2975688a34.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205992; x=1779810792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igtwKeAxN0SUZf8sXSvXxNz0ljwI+sR/pp6U9EhJI6M=;
        b=bPpmZPcoulhPpPtAC3nvl25sCPydOC9MZU3Bx508A8eIVZa0k94WAElO27Kg9tMqDT
         4bsGS/J9mI5Kors7N2VpWyoiidRbnPKzjpFtudlWX+uHtF2Jyy4rr1DEUPzvR93B7HuM
         LOjArUZDJ9fDmBohyKoCYni3oQiB9rE28URbSKwmcXllgphE3v5xp39suMFvACWzXRx7
         T9MoeYcmGYEEjbec/4UAx57skx5m/gGIUP4gZE/e4Hf8Q4YEEU1IIrdTvqU1X6Rid8Hb
         Vbbxd94OrGcEADJwd1mLqqGbUJrFthp/NcnqS4RbcXeukpRW4uV/7LqWmsf7ncFaQMDN
         DB2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/KiDC7Q5tKGVGaqErm7OcsyH/hL/GeZX+Tb9EPF/CuyJrDbwweSBB+SUCGQMrMOtWzBsn0kWrno4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xl8mwl4rTd2WkTUkjBFuwh4e4iltWjxy0OS2toDyS+a36diO
	NfGxdWMnY4EXrVJbgUpyjWRaWPjV2RmCnF6d0XRGFuOqM+KV50QOSRT1jI7+4OoyvJM=
X-Gm-Gg: Acq92OFsyMAWBEeqQv9MhvoL86novARKAamYWMzI9M9bxVCmMVGvdLZbV5YjMrkTlpN
	yy+sacRY9sMpKcTwY/W9BWvJlOu+nXJe+NAPtFYmwPy8rmKX/KtH+xuK++pPkReUSld2RfKfHbd
	WMlsdDemkIxORdElYbZMKaAdjtzG0PHIuxG8qILj+OU/WRxp0wkyCL0Gi5kLld5k32X+WqSA33p
	4PcAe6mk0M8Z57LEybriesBeVmfzbDy3VhXqomeNTGNgQSjuxXqEXmFvlSc0DilgBYTlg9sSjcy
	+oZnf1H81bigRiFLyQ7Js1Wy928IInbVQP/aE3OLBlzhMzJe02QylIU779G2rdqFGwno4O4u7PR
	ev++BXSrfadrvTWQ1iUj7JKOKEDiDrfVp6AkRMs/5zH8ZVOODSuTVX6x/Wz6+LPFquJyEoKPhDM
	b6AsHtw1ZvG7iQQ+I1qdNTj1IkgEKQiMfAwhy5gTrxfSVeDA8xUXU5ADjZ7pEHS1xbHGQEcpoc+
	NGbvsHmLYjubONnZhSr20CREhk0u0Y2v/BhVjXsz6f9LMG3F6t29l93QmKdbs1R+gjHKeclQIxj
	jQ==
X-Received: by 2002:a05:6820:201c:b0:69b:569b:e64b with SMTP id 006d021491bc7-69c9457ea29mr11447559eaf.40.1779205992091;
        Tue, 19 May 2026 08:53:12 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d04655cbcsm6915219eaf.8.2026.05.19.08.53.11
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 08:53:11 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-439bdb1d75bso2427400fac.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:53:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/KH/Xa3ZFpwYnwluEEslTRrCcBsrc7+jInkVGq9su4cMND2hqAqx38ME4ZqGiy0F9L7deQIj6qEZQ=@vger.kernel.org
X-Received: by 2002:a05:690c:f09:b0:79a:b9cc:2100 with SMTP id
 00721157ae682-7c95c00dc67mr228864147b3.35.1779205598317; Tue, 19 May 2026
 08:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com> <4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
From: Sirat <email@sirat.me>
Date: Tue, 19 May 2026 21:46:25 +0600
X-Gmail-Original-Message-ID: <CANn+LW+=8c5SWsTTi21eLQDX4GCvFLWic-JSi5JnVc5975e9AA@mail.gmail.com>
X-Gm-Features: AVHnY4Jz8BvVqdFVRuuuc9rbISAcv00nYjMnz_vLM9GaqsKlf5ZiNuuDJ8qMl6I
Message-ID: <CANn+LW+=8c5SWsTTi21eLQDX4GCvFLWic-JSi5JnVc5975e9AA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: Initialize i2c_device_id arrays using member names
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Petre Rodan <petre.rodan@subdimension.ro>, 
	Dan Robertson <dan@dlrobertson.com>, Herve Codina <herve.codina@bootlin.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Anshul Dalal <anshulusr@gmail.com>, 
	Gustavo Silva <gustavograzs@gmail.com>, Andreas Klinger <ak@it-klinger.de>, 
	Tomasz Duszynski <tduszyns@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>, 
	Rui Miguel Silva <rmfrfs@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>, 
	Jagath Jog J <jagathjog1996@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Remi Buisson <remi.buisson@tdk.com>, 
	Christian Eggers <ceggers@arri.de>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Kevin Tsai <ktsai@capellamicro.com>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Gerald Loacker <gerald.loacker@wolfvision.net>, 
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>, Eddie James <eajames@linux.ibm.com>, 
	Petar Stoykov <petar.stoykov@prodrive-technologies.com>, 
	Song Qiang <songqiang1304521@gmail.com>, Crt Mori <cmo@melexis.com>, 
	Waqar Hameed <waqar.hameed@axis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Gustavo Vaz <gustavo.vaz@usp.br>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Guenter Roeck <linux@roeck-us.net>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chuang Zhu <git@chuang.cz>, 
	Kyle Hsieh <kylehsieh1995@gmail.com>, 
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Romain Gantois <romain.gantois@bootlin.com>, 
	Sander Vanheule <sander@svanheule.net>, David Jander <david@protonic.nl>, Andrew Davis <afd@ti.com>, 
	chuguangqing <chuguangqing@inspur.com>, Shrikant Raskar <raskar.shree97@gmail.com>, 
	Kurt Borja <kuurtb@gmail.com>, Denis Benato <benato.denis96@gmail.com>, 
	Ethan Tidmore <ethantidmore06@gmail.com>, Tomas Borquez <tomasborquez13@gmail.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Shi Hao <i.shihao.999@gmail.com>, 
	Xichao Zhao <zhao.xichao@vivo.com>, Erikas Bitovtas <xerikasxx@gmail.com>, 
	Aldo Conte <aldocontelk@gmail.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Gabriel Almeida <gabrielsousa230@gmail.com>, Gabriela Victor <gabevictor333@gmail.com>, 
	Beatriz Viana Costa <beatrizvianacosta16@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Adrian Fluturel <fluturel.adrian@gmail.com>, Antoni Pokusinski <apokusinski01@gmail.com>, 
	Yasin Lee <yasin.lee.x@gmail.com>, Felix Gu <ustc.gu@gmail.com>, 
	Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index ad3e46d47fa8..21579331c6c3 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -393,7 +393,7 @@ static int vl53l0x_probe(struct i2c_client *client)
>  }
>
>  static const struct i2c_device_id vl53l0x_id[] = {
> -       { "vl53l0x" },
> +       { .name = "vl53l0x" },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
> diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
> index 4d9cb3983dba..ff56bfcf8bd2 100644
> --- a/drivers/iio/proximity/vl53l1x-i2c.c
> +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> @@ -730,7 +730,7 @@ static int vl53l1x_probe(struct i2c_client *client)
>  }
>
>  static const struct i2c_device_id vl53l1x_id[] = {
> -       { "vl53l1x" },
> +       { .name = "vl53l1x" },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, vl53l1x_id);
...
> --
> 2.47.3
>
Only reviewed VL53L0X/VL53L1X changes. Looks good to me.

Reviewed-by: Siratul Islam <email@sirat.me>
