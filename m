Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B09388E6E
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786248; cv=none; b=dYa7NjpHsZWnpBiRD4xYl4XqEunWGn3fv3SFBpzmb6OsYk97WkfSpH2cllNWVxi9CLQ9fQ1CacftlQGTLVUMMmfKUovOpfwifC0gcGPMGgI3jlmI4AAmuY9EvNPXKQdf50FQyUCDB1g0EjSry75r0FyoSbhTpX65vPWIeL6hRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786248; c=relaxed/simple;
	bh=KptO8WNNHJTHjTaOyH+m+lT2lUjxq05h/0tjq+IcM7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=lBeA93J6ig/hU9PFP3EqvGZRP4ngLK9J1cgSf79gIgxmD1Fyt/BL4or94rtMZUs5VXTrC8ExACjGnmTCy9hK178AaucnZ/DNoizlgMqNia+ZKai3BtlGiHmsvWKl36oKW5RvpSNmUgRDDmUabuOdcghZhxwxb8BAD8TM8r+BlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3+n4VYy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3+n4VYy"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3664df32e91so7272130a91.3
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778786246; x=1779391046; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv4A3QNVmDiH/s9yrvUyvjlee7+H3i/Jwbce6RGUR5g=;
        b=a3+n4VYyP2CcqNfSTJHlaWEaC2H/kw/jxw6n81VtKWVSfDM+8F4tgv0HqBy1KD0k7b
         3gL9RN86gEqUcX07TkKSnetJhZGH8v3QxrW/X/zqGO8kxoQfLCZuRlOunclT0NZsGrqD
         +4hao4DbTRrnza7jaAE9qV/FzQ6lnkK9ZA7g8kEyTJ2IKf8BtUI77CRFZhsEzJQZh6Pb
         mBLEvGbEJffw83YYLg3AiO6sBE/BqAZqSVbE5uhUiSm/LUIjI2YfRj/uNkV33It8PcX3
         infOOSqWaHv5GXwv7qGlJntzm4Q+EMIotOnO2E+9g9gBKoIVhRc7Gz8oGz9Q61a1TN57
         4QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778786246; x=1779391046;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yv4A3QNVmDiH/s9yrvUyvjlee7+H3i/Jwbce6RGUR5g=;
        b=ATeL2dDc95dwW44lR/XETHgn7lb9dai0viuE0IG/tyKwc2VHQWeGcs0SY+z2F3P6mh
         w9QJqsUkGvghR+ARpEb0c50ni5Os4hRwmK4zJQaolWpkc4I8n0DSaXYUGbnTGSgkoWAo
         vYjS7GMyUFUiXQ85Q34BXtjqwKTDIiPu6nnVo4S8kVSlIsMbK3WS4Py+7J3wmcHxUgEP
         NHf7LNp1lmezwI+0XZXiy/f8599Mhan7AGziJlJeopigm0mOADQmxocVI0qaDnvZv065
         w0ZGES69Snb9ITKMb14kQywEs0oyFtYu64tWc0wsu9fa7XZGJGS3RqIuWei+aPXRozC8
         vPWg==
X-Forwarded-Encrypted: i=1; AFNElJ+D5FLt2zALidquv7UMR8aKmBbUhoF/IspC2m8q5jO80uVUgSjVnjd1YXusX75XbH3V0zWCjkgaH3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwynGjo0wt5AUkJ2w51gNK3dXmgtiJHbkB6q2hkONH3gJZ8McVG
	OgTzNtjbHgPUJOTQTPaGDE603jmBmc4fIjoIkCGgu6JMN+Ra+oTgnN1I
X-Gm-Gg: Acq92OE5NC6KhmYM4FGYst1TvYzwIB2TfR1KUh2cg3bKcbBmmbcoUGp0TbN6+MQJ6Cb
	H7RLc6JQ+t+IpztHOEkCK6pWa6DozBWJn5bsd4ZJolWy3IV0k6tB7bLuH+xGTgYaWL4+ejwSh9f
	J1jCoVLKX5GFgbpt69kt08dvGq3FLkfyHGj3lTWwMYEuse+zSkPU6Dyr4jy4ZjYR0uZRXL3OM1A
	JOQO2fiD5KaBCMhTBqvWxV5gwUYvG2+94T/I+GmvXIod8d/4ekUsAZRmMMlk7flCdqR0mNRRkwt
	Qr3poUgo6KNAjaZ5l6iKbA9woaa+YO/ODMpv9s2C7KOltENEtVSo+1RVO1RAjDBD2YgRSy3WJk8
	mK4h4dtrQUORb+ok1GhC/K0SJUZcLpBeAF2w5vutskfSRBA6QjyEpVk5f1wUzv8mdYLyL7Lf32D
	6shc6dE2ISXOWMh8Ja22IvEnBKmxPFQqXH
X-Received: by 2002:a17:90b:2d4c:b0:366:52fe:e74f with SMTP id 98e67ed59e1d1-369518badb0mr730478a91.1.1778786246158;
        Thu, 14 May 2026 12:17:26 -0700 (PDT)
Received: from localhost ([103.77.225.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951278e7fsm418602a91.8.2026.05.14.12.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 12:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 May 2026 08:17:18 +1300
Message-Id: <DIIN3H0YMILE.3PFQWDK2BULIT@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 2/3] iio: light: veml6075: add bounds check to
 veml6075_it_ms index
Cc: <linux-kernel@vger.kernel.org>, "Sam Daly" <sam@samdaly.ie>, "stable"
 <stable@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-iio@vger.kernel.org>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <2026051420-strudel-graves-f6cd@gregkh>
 <2026051422-hungry-dolly-0250@gregkh>
In-Reply-To: <2026051422-hungry-dolly-0250@gregkh>

On Fri May 15, 2026 at 5:23 AM +13, Greg Kroah-Hartman wrote:
> From: Sam Daly <sam@samdaly.ie>
>
> veml6075_it_ms has 5 elements but VEML6075_CONF_IT can yield
> values 0-7. If it returns a value >=3D 5, this causes an
> out-of-bounds array access. Add a bounds check and return
> -EINVAL if the index is out of range.
>
> Assisted-by: gkh_clanker_2000
> Cc: stable <stable@kernel.org>
> Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Sam Daly <sam@samdaly.ie>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iio/light/veml6075.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> index edbb43407054..f7eb159e5cb4 100644
> --- a/drivers/iio/light/veml6075.c
> +++ b/drivers/iio/light/veml6075.c
> @@ -100,7 +100,7 @@ static const struct iio_chan_spec veml6075_channels[]=
 =3D {
>
>  static int veml6075_request_measurement(struct veml6075_data *data)
>  {
> -	int ret, conf, int_time;
> +	int ret, conf, int_time, int_index;
>
>  	ret =3D regmap_read(data->regmap, VEML6075_CMD_CONF, &conf);
>  	if (ret < 0)
> @@ -117,7 +117,11 @@ static int veml6075_request_measurement(struct veml6=
075_data *data)
>  	 * time for all possible configurations. Using a 1.50 factor simplifies
>  	 * operations and ensures reliability under all circumstances.
>  	 */
> -	int_time =3D veml6075_it_ms[FIELD_GET(VEML6075_CONF_IT, conf)];
> +	int_index =3D FIELD_GET(VEML6075_CONF_IT, conf);
> +	if (int_index >=3D ARRAY_SIZE(veml6075_it_ms))
> +		return -EINVAL;
> +
> +	int_time =3D veml6075_it_ms[int_index];
>  	msleep(int_time + (int_time / 2));
>
>  	/* shutdown again, data registers are still accessible */

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
