Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A823183C
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778988484; cv=none; b=kF+cKu+SxalYZ2cQ/aOBKqUOilgm8Neb0LDzjcC1NqPnyrYoOoB10tMXPH2oRS8uekrvW0ltXSAFldtPv0JluN9cVGUUha6NwydEto4zXzL8JJxqgmrBJQYlX/TbbFqhdqs1hTB2VepsVNvKEz4RzfBtIbICHz0UdGOlBy8R8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778988484; c=relaxed/simple;
	bh=PJWcPjDMjWs0c/FR2wuQBALN8mECfQMfdss+180oHVc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hR7UJWVir9sFuycR//5ZQGen+piEwZ0kl66PfyTj5OV/egobxNJ6E2vO/VqKBPoRDR0rBr58pRxAtDfa4IpWPMylGg8S0GfbGgLjhPt5UyY1dkwMrot4pOFgk3US7ENbC2GawcyAX2n8E2e1YAVJZP9EihK5nINSeAkTDk1gxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR8FTC6o; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR8FTC6o"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-366139223e4so489199a91.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778988481; x=1779593281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/vMjqO6vdKeoZZj/1K6kqKKNvx2ViUMwGdHgA3bADEI=;
        b=NR8FTC6oOyjtABlVVpj1crvzwitp/KwIY6LMGMRiqdp0WhnmGHO1S+paKqcj8ccJZe
         NBrFMR9zR7Yl0IFeRnuJYhjtoXmSUoDqYzeoUozvV6PmSeHJuvDLmrV/uh4cV82TVze3
         iaKGPlJ6tujX9EkZnm4JvSt5dgdUq0jBYLOVM9lTtvWr9OR8nCuduZ9Hh2R0cBgZTE7Q
         6U1513egkS/tkkd8EbgkBb9i5zC6pOe8CiA7ZTp5u3IuCm6fwDg993BJcouH+IgODljY
         VtJ4XjAb1/ka/NvHWdloOJ1FtSuvWUBg+tKNtXPIO/FOplwbV5+vMNKuXk+IcS5uLBDH
         iNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778988481; x=1779593281;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vMjqO6vdKeoZZj/1K6kqKKNvx2ViUMwGdHgA3bADEI=;
        b=UIbyeK1kP2UC4sf3nE+LvpoFLXCxPVz38xVV432+6sPJH/Sa3Y+wTmmCO6XJ1CJ1M0
         KPXpcSq4jD3YGNY9oTzkFKsDnkCCwDg3Rd9KsdrZo1U6VwqrNBR6WOdpFcBvmQSQURAk
         weY8KLovzjOLXQ2syCkwO+eX/deO8YIlbwvtrPogaoABKtZ768I7Fcf465L3paOTcPrW
         tYUpohHnF6fhqc4dI98QJJtpRM3L76nV12qcyi/r6TnX0YAmkCJbpReWzXukgiso6n2F
         2WtnRLI704+V7LFBskXAfDwHWpPt1sVoh7/3xDakCW0bobjoXm9I+wK1L1WZgEnpeJRx
         v6ig==
X-Forwarded-Encrypted: i=1; AFNElJ+c61/KYvEDbmsinPpjhRszsNUYb2O4400q8wKPjP7RwWH42ckpK6HldUKIDQ2ut/uekwueEcEIG/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqP05ST02bdOponmyy1cymJkcWr6+M5DpfB/Z/3v7DyMCgQ0OB
	lBas21MPBQM5a8bJxkFoOrkM1xE4nw77R+OtFT2rFm0v2BQviVzvVcWv
X-Gm-Gg: Acq92OEgCDh1WfA73u9Y2xJFETf+HiRXTwCF4aHRcwAYIROgHlguCuQMwYuFiL2LKx6
	j6GKDwLowGaBYoK6Qoq3mu351h2pb9cN/V1XQYkHPefl+KC31iB7qHCJ+sXY/64g6k6yr2ngJln
	nN42dV04bz1IW5rL0bpEddEw2nHkEUk2LQMiu/Tw1w2V4gaI2Svwb/HVzVo4+5ldZ5k3awMk+nC
	0nTGGj7cVXD11kgWqaZ4g+99L8wjCBK6IoUoM/qNwy7q/gP3SQEkdIy1hUcqR8G/Y+fHoegoRE6
	HpygtPJ311zB/vxvEGfsdLf9bCkN4kmaRkr4Q1xKz0m4meTJEGCKyolpsD7NH0JpRZv9m+Fgodt
	dlcIink8SDmyi/7ITzG987cYV2Ny7qdSLb+niFj5QYUQ4AaYhP8VxUWSEm497wVZJXLLUiw/HKj
	BCIA0qFxkgYBnuItkwegZp37QpxBnLMVQut1nsKgdML5NmoPfjWfJMSJR7EwkjWhpoKEFf
X-Received: by 2002:a17:90b:560e:b0:369:7811:5abd with SMTP id 98e67ed59e1d1-36978116a74mr3931874a91.15.1778988480975;
        Sat, 16 May 2026 20:28:00 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:2c19:c87e:d8bd:7518:c4f1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a10aa1fsm2527197a91.12.2026.05.16.20.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 20:28:00 -0700 (PDT)
Date: Sun, 17 May 2026 08:57:38 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org
CC: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, sozdayvek@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_iio=3A_resolver=3A_ad2s1210=3A_s?=
 =?US-ASCII?Q?plit_trigger_handler_body_into_a_helper?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260516151721.1982-1-sozdayvek@gmail.com>
References: <20260516151721.1982-1-sozdayvek@gmail.com>
Message-ID: <6805AC3F-CF03-4CCC-ACA9-E7BA463C048D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16 May 2026 8:47:20=E2=80=AFpm IST, Stepan Ionichev <sozdayvek@gmail=2E=
com> wrote:
>ad2s1210_trigger_handler() takes st->lock via guard(mutex), then runs

>--- a/drivers/iio/resolver/ad2s1210=2Ec
>+++ b/drivers/iio/resolver/ad2s1210=2Ec
>@@ -1276,10 +1276,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_=
dev *indio_dev,
> 	return regmap_write(st->regmap, reg, writeval);
> }
>=20
>-static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
>+static int ad2s1210_collect_and_push(struct iio_dev *indio_dev, s64 time=
stamp)
Hi Stepan,

Is the return value of this function checked by any caller?

If not, should this helper return void instead?

> {
>-	struct iio_poll_func *pf =3D p;
>-	struct iio_dev *indio_dev =3D pf->indio_dev;
> 	struct ad2s1210_state *st =3D iio_priv(indio_dev);
> 	size_t chan =3D 0;
> 	int ret;
>@@ -1295,15 +1293,15 @@ static irqreturn_t ad2s1210_trigger_handler(int i=
rq, void *p)
> 					       AD2S1210_REG_POSITION_MSB,
> 					       &st->sample=2Eraw, 2);
> 			if (ret < 0)
>-				goto error_ret;
>+				return ret;
> 		} else {
> 			ret =3D ad2s1210_set_mode(st, MOD_POS);
> 			if (ret < 0)
>-				goto error_ret;
>+				return ret;
>=20
> 			ret =3D spi_read(st->sdev, &st->sample, 3);
> 			if (ret < 0)
>-				goto error_ret;
>+				return ret;
> 		}
>=20
> 		memcpy(&st->scan=2Echan[chan++], &st->sample=2Eraw, 2);
>@@ -1315,15 +1313,15 @@ static irqreturn_t ad2s1210_trigger_handler(int i=
rq, void *p)
> 					       AD2S1210_REG_VELOCITY_MSB,
> 					       &st->sample=2Eraw, 2);
> 			if (ret < 0)
>-				goto error_ret;
>+				return ret;
> 		} else {
> 			ret =3D ad2s1210_set_mode(st, MOD_VEL);
> 			if (ret < 0)
>-				goto error_ret;
>+				return ret;
>=20
> 			ret =3D spi_read(st->sdev, &st->sample, 3);
> 			if (ret < 0)
>-				goto error_ret;
>+				return ret;
> 		}
>=20
> 		memcpy(&st->scan=2Echan[chan++], &st->sample=2Eraw, 2);
>@@ -1334,16 +1332,25 @@ static irqreturn_t ad2s1210_trigger_handler(int i=
rq, void *p)
>=20
> 		ret =3D regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
> 		if (ret < 0)
>-			goto error_ret;
>+			return ret;
>=20

I cannot find this goto instance in mainline=2E

Is this patch based on top of iio/testing or another branch?

For patch dependencies like this, is it preferred to mention the base comm=
it in the changelog for single patches as well or in the commit prefix?


> 		st->sample=2Efault =3D reg_val;
> 	}
>=20
>-	ad2s1210_push_events(indio_dev, st->sample=2Efault, pf->timestamp);
>+	ad2s1210_push_events(indio_dev, st->sample=2Efault, timestamp);
> 	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
>-				    pf->timestamp);
>+				    timestamp);
>+
>+	return 0;
>+}
>+
>+static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
>+{
>+	struct iio_poll_func *pf =3D p;
>+	struct iio_dev *indio_dev =3D pf->indio_dev;
>+
>+	ad2s1210_collect_and_push(indio_dev, pf->timestamp);
>=20
The return value does not appear to be used by the caller=2E

Should this helper return void instead, or should the caller handle the re=
turned error code?

The helper function changes look good otherwise=2E

Thanks, Sanjay

>-error_ret:
> 	iio_trigger_notify_done(indio_dev->trig);
>=20
> 	return IRQ_HANDLED;
