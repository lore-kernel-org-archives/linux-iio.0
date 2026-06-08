Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E404028F7
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932551; cv=none; b=WW+WgrAWbxpSKb9agZGitLTOVrqVtpjZL/63tJeiY6BkVYp+XNHfBVLJzL7Zv/Y/GiIn1u82xw/ybAbNg8fMOIWBG3JgLGiAWiwuzvRuQfktu6opqYu3RirzaAabSvwfKhTnWAZTsyMTHwo1vP5J4E4Jb10FWl4HTXDTgrVjw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932551; c=relaxed/simple;
	bh=rGuh4Piu0oh4HSSCpQUUfEz+iUljEVbHlDZbpvMhNvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1zbvLKqVDVUxJDtEksj9xnrsL1sZlWMp7V/eLN8CKVGzMx0hr6qDhO7n3x9QPg3tNCTtC3zLsc2AE6rxL2AXi9Ea1MSMJ7YSVDQSJWBD+8+7PTgI0YSg50uXRQ8CC8kzfcQnD02wXhogo4c1hG9v5QTxG1xl6ThEEO2jaCwKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrE+w1iW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrE+w1iW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490af320e2aso49976975e9.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780932547; x=1781537347; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6IHf+vahgYOQmPt7hIAi3jNHguz38EVn0G5aWHkhn6g=;
        b=nrE+w1iW8dZ9YLGQav5AWPGiGzw0tuO5H6DHh47NNzs7Gm3cRcqBmHpyp3gbC17ed2
         LuzL195GKDJPD1n7osuT67/xe5VR9hFqrDkKV8QbZ+yjbNC/oN5uvZ3V+Y5D1hnrAgbg
         FOFE4M731svF7aLSfquppEN6nGchVCUkDcyePP9HqRwo6ONfZYM+2t/haS4pxCdCcGLV
         yFlDBu89iFaOi73rjqyo2IeQJg3oqj8wS1B1Zf7xsFyqMGX53VHy+v4dvsNqv6J9vVEb
         NW46vJg342hGapPI3PKZiuPoMbI17z6ollZdjdQmzh9HN3JDQ7J5hhcPZbABqO+bgXZs
         HNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932547; x=1781537347;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IHf+vahgYOQmPt7hIAi3jNHguz38EVn0G5aWHkhn6g=;
        b=gJAU2yd0onXEiIWLvrAUaDrTL9EM8r2p5rk1CmWLsd3LlNj15jk5/JOxmAEWm230W3
         M1qe9dMBUzRd7mSNmrBSzsAyvdI4/191KyZaaKQOUYYGtwL69FYTK18N8+KVuxSLtu/4
         igqEf/MfgWlbufaHYEvOG5QcQoyOHL/LXQQyODAXbiSDngi/3jJ3TXDPVgF0/yUhJAi0
         FXJrfJOvDXFVDIIkzkShZQTA19u8LEg7/nurQsmAKoDaxlIGxgbUV43xDcCMM8uzxhMq
         rAAqadRSlXIT37PgAtwlOkL00LZ0Z+N4V4Or7hreoqZY/ST5+rqCAOrQpnFG1hQyn2Ou
         c4Ig==
X-Forwarded-Encrypted: i=1; AFNElJ80iFzo52qUP+pMUlgO7JtBacFsGqnffGmC1jRGJb6p51FZGOlbPkyKSzQ0uGmvvZnP/I2j8lPMNJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlW7iVRv+enn1NtfOqVN1uvRqpPZz+wJP/XFS83VFLXPX4buWw
	t0ZvaGGWN1fZsUq6O9ZHiXDhqbFl5kc8Ee6qnztkn+KhAVf19QJupdeN
X-Gm-Gg: Acq92OHyPuxj2l33QFv11Z2yqb6mwAwFUgfYmmRtKPGz76LkhbiylT0+YmXEYO5HPpt
	6Ur7869CtpL5LQ0owxtxKb2VZ28UPoojAflx7PnG6XGXn++boNWlWM7caV0iyLxFQtvfRlKYR5e
	LmmjPIn+QqaLKSfkoe4TaYhwSdANHjaJ70iMHYCQ8HeJgQyWZdgjPwM3RTP/kupFpj5FgCfInSh
	VN+Q/9SUX7U78XhKUF5d9fBGosSA6GwKudBXWx9usR3AWQTC5b0Shbsn1/lH3aYlsLhaXWgn4uO
	KSDpceLklFpdyhYXH1X9Clc5OwvCE7ZlqYappmt2Updy4FsLwbg0e+aatujpWk/Nh9eWS4oc80y
	iShzHUjhUmQBRP4OzqVgiWmW2DzCLb2uTK4GpIle8nzoEemi57IUedcJU23ulAa5dmgn6BBc+sV
	QLwlNG77MIKgz/l2jrM3Ctw6O5MqdZkybO3nNT7CjK9w==
X-Received: by 2002:a05:600c:82c3:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-490c25f4963mr259688585e9.25.1780932547001;
        Mon, 08 Jun 2026 08:29:07 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bda4fd52sm387929205e9.0.2026.06.08.08.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:29:06 -0700 (PDT)
Message-ID: <9d1f3538c3e42ad5dd19c4942123eb5423f1a884.camel@gmail.com>
Subject: Re: [PATCH v2] iio: proximity: cleanup fixes for vl53l1x-i2c
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Siratul Islam <email@sirat.me>, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Date: Mon, 08 Jun 2026 16:30:07 +0100
In-Reply-To: <20260608124027.35879-1-email@sirat.me>
References: <20260608124027.35879-1-email@sirat.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 18:40 +0600, Siratul Islam wrote:
> Extract data-ready polling into a helper, fix regmap_read_poll_timeout()
> argument alignment. No functional changes.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Siratul Islam <email@sirat.me>
> ---

Normally don't really like these one liner helper APIs but for this cases w=
here it's easy to mess
up, it makes sense as if __we mess up__, we only need to fix one place.

Just one comment from me. With that addressed, looks good:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/proximity/vl53l1x-i2c.c | 36 ++++++++++++++------------=
---
> =C2=A01 file changed, 17 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/=
vl53l1x-i2c.c
> index 4d9cb3983dba..ed83999cf735 100644
> --- a/drivers/iio/proximity/vl53l1x-i2c.c
> +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> @@ -43,6 +43,7 @@
> =C2=A0#define VL53L1X_REG_SOFT_RESET						0x0000
> =C2=A0#define VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND		0x0008
> =C2=A0#define VL53L1X_REG_VHV_CONFIG__INIT					0x000B
> +#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
> =C2=A0#define VL53L1X_REG_GPIO_HV_MUX__CTRL					0x0030
> =C2=A0#define VL53L1X_REG_GPIO__TIO_HV_STATUS					0x0031
> =C2=A0#define VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO			0x0046
> @@ -64,7 +65,6 @@
> =C2=A0#define VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL				0x00DE
> =C2=A0#define VL53L1X_REG_FIRMWARE__SYSTEM_STATUS				0x00E5
> =C2=A0#define VL53L1X_REG_IDENTIFICATION__MODEL_ID				0x010F
> -#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
> =C2=A0
> =C2=A0#define VL53L1X_MODEL_ID_VAL		0xEACC
> =C2=A0
> @@ -191,6 +191,17 @@ static int vl53l1x_stop_ranging(struct vl53l1x_data =
*data)
> =C2=A0			=C2=A0=C2=A0=C2=A0 VL53L1X_MODE_START_STOP);
> =C2=A0}
> =C2=A0
> +static int vl53l1x_wait_data_ready(struct vl53l1x_data *data)
> +{
> +	unsigned int val;
> +
> +	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Dr=
iver) */
> +	return regmap_read_poll_timeout(data->regmap,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_GPIO__TIO_HV_STATUS=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, (val & 1) !=3D data->gpio_=
polarity,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC, 1 * USEC_PER=
_SEC);
> +}
> +
> =C2=A0/*
> =C2=A0 * Default configuration blob from ST's VL53L1X Ultra Lite Driver
> =C2=A0 * (STSW-IMG009).
> @@ -230,10 +241,9 @@ static int vl53l1x_chip_init(struct vl53l1x_data *da=
ta)
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D regmap_read_poll_timeout(data->regmap,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_FIRMWARE__SYSTEM_ST=
ATUS, val,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val & BIT(0),
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100 * USEC_PER_MSEC);
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_FIRMWARE__SYSTEM_ST=
ATUS,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, val & BIT(0),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC, 100 * USEC_P=
ER_MSEC);

This looks unrelated to what you have on the commit message. Either drop it=
 or mention it in the
message (but I'm really not sure on the added value of the above change - I=
 guess more meaningful
line break wrt the API arguments).

- Nuno S=C3=A1

> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(dev, ret, "firmware boot timeout\n");
> =C2=A0
> @@ -261,12 +271,7 @@ static int vl53l1x_chip_init(struct vl53l1x_data *da=
ta)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Dr=
iver) */
> -	ret =3D regmap_read_poll_timeout(data->regmap,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_GPIO__TIO_HV_STATUS=
, val,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (val & 1) !=3D data->gpio_polar=
ity,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1000 * USEC_PER_MSEC);
> +	ret =3D vl53l1x_wait_data_ready(data);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -461,14 +466,7 @@ static int vl53l1x_read_proximity(struct vl53l1x_dat=
a *data, int *val)
> =C2=A0		if (!wait_for_completion_timeout(&data->completion, HZ))
> =C2=A0			return -ETIMEDOUT;
> =C2=A0	} else {
> -		unsigned int rdy;
> -
> -		/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite D=
river) */
> -		ret =3D regmap_read_poll_timeout(data->regmap,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_GPIO__TIO_HV_STATU=
S, rdy,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (rdy & 1) !=3D data->gpio_pola=
rity,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1000 * USEC_PER_MSEC);
> +		ret =3D vl53l1x_wait_data_ready(data);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	}
