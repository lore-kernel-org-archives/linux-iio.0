Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF21B78F3
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778989300; cv=none; b=c1WwSmQLzsuLL5jWc7ZIQfqeyz5IlerYtW380sACpxmDp1L8DnP8PUjc7T7C/X3cU1wFBuegnyt9tCPlPVkdbeylVCx/w+scQU2kQqcE6hxgGbqXE0AkOKOQIIOFe69cYKJ1MWFLp0ydnkgWZbzWw/grH8knmlc3nd70xF9hyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778989300; c=relaxed/simple;
	bh=TNHC9Hf6cEZxiHv3zfoIYVZ6ETXgaVN+xUbLK1W+djM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BVKjnMov9ExZJ71/qIweE4MiVcwDtq5NMcSscEs+Rf1X+L6SBYDtKvFkZMSuzNrG9DHuipq2vKJwq1aRstMY+QVTTvhQE+fyyaJQtx5qob9N0sXDAALkn5NiHrPLFz6THkuzLX4i/Av0HpehJGgJON6Ppg0H4IMRKWDV+/zRV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgB9nkTy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgB9nkTy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366375c4076so334910a91.3
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 20:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778989298; x=1779594098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CKnqFmMYqo0djxyK2+5XZs3mGgV7B68vlxm58Out+D0=;
        b=lgB9nkTycOqZiF5lgU+MtR9YmVqSaIhUtURSoOXJBPM2cMV02VfOKKYkYaf+dUWDfS
         Xayf6h6vru3PoCijzpRGKV5QiNINsyf9Miatc9pCYYZ4XddBlTJtQ/OdHAFEMTN1tfPL
         UMTDaxjh3CkUrvls96AcMlfCicaWU8Ogk6g58bBGRx5QkSSUv++lWXmrWNfaHda9fASt
         QsiQaMAjpcMi6DS7x7rANBzCg2RdKgWQUtxYhMxLOn1Vc1/9h4dZ91Va+M4TGUdTm/u4
         A1emxse1gLdiHvoxGlVpkhG4ghcNxqPBB4pfWS/waALlnOIoI74el5wh/qiLEZruePpE
         BBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778989298; x=1779594098;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKnqFmMYqo0djxyK2+5XZs3mGgV7B68vlxm58Out+D0=;
        b=HeFRnwLPNgbmjEmqbZzF4L004tOFVxDNrRW26/4RXpChF2fhPUzyG1TQPbw9u5W0yY
         rN3DHs7kw+10rsafqpbrMFLbVViMwQ7UDaHvegoe2behJog5pcxHJU4NraoHOUyAPzdi
         YLvNKKNiVqCrCsPQD6IZXmBOMra4UCFbgNQK0OVi62pOWOLDd530x+CE9OadOHCeMNq6
         qVVhfDBZLCWDOwhY0od5oR7RurApa3rSd3MnDT/OIhH25hg1ZVRin+dr5OoXkVSSOmlO
         fUl30wIyL5ti2WEYI+YCril5ePyW3Yk7XglXS2IsW3S+dFT1WEbcbkw/nZmE3ANG5haj
         3LZg==
X-Forwarded-Encrypted: i=1; AFNElJ+lbgies7Y8pwnX0ttbd82se2JT+PikRriPy5CrflmAIVoHHjICbjydZz/5wrKEKtFQhHTeaiz7qWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSUPX7Nm59m5UJsovAANJJuUqKjuP90c6xhn+FWHKj/Cl64x+
	fHCRmF1x7LML6NrAarnPebHcLV00V9nDgY3YSadKXiclcaUS5g73+9jK
X-Gm-Gg: Acq92OGg40IbXxuvV3Ze473XgBC4seUdEttsKsZoPf1BxH0GR2iQdOpOCeRJUbYJZIy
	2XW2xnySukO6JCJSAwRKxqZb8n3pZEHKSWqRBUB7OjhUwliWWaq+ChHqho3EuLXRu1qs9qJbiTY
	hzSRIMKSm1w3WiiguGakbH18VpsHMqyb7d353E2dwu08V4tGVrxmXRn5lfYD8bWc2Tu2/jSt0Hb
	i5Irc0wdvIRKSOxjuO/9f+OEHDycZAEr6L65PbPQQTvgAIkWhHegm9w5RZ1zvSiFKrp3/nE0ol6
	ELkrbJoPlhqvYmrIG7lTRVVJJwRKnf2/MjyKYxn4bfRoW3vfbmx8DKX4hVVnmqLPJXMfY2Z/DkF
	fngPN76eXhcPJYgmqTaWzTQkPpvW0ZNugBmpK4fx5vkeBsc+EW7nd2h8zP16BoMhYqj5I5BPkes
	+0EkgXSXsUKqH6u+qjCTQj/JgX59XC+oCD1QTw9D68RZJshOaMAGB2QZgmZw==
X-Received: by 2002:a17:90b:5290:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-369519ffc97mr10169030a91.9.1778989297957;
        Sat, 16 May 2026 20:41:37 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:2c19:c87e:d8bd:7518:c4f1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm9374511a12.11.2026.05.16.20.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 20:41:37 -0700 (PDT)
Date: Sun, 17 May 2026 09:11:20 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org
CC: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, sozdayvek@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_iio=3A_resolver=3A_ad2s1210=3A_s?=
 =?US-ASCII?Q?plit_trigger_handler_body_into_a_helper?=
User-Agent: Thunderbird for Android
In-Reply-To: <6805AC3F-CF03-4CCC-ACA9-E7BA463C048D@gmail.com>
References: <20260516151721.1982-1-sozdayvek@gmail.com> <6805AC3F-CF03-4CCC-ACA9-E7BA463C048D@gmail.com>
Message-ID: <F66046FB-1E18-4E69-B053-7EF33CA872E3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17 May 2026 8:57:38=E2=80=AFam IST, Sanjay Chitroda <sanjayembeddedse@g=
mail=2Ecom> wrote:
>
>
>On 16 May 2026 8:47:20=E2=80=AFpm IST, Stepan Ionichev <sozdayvek@gmail=
=2Ecom> wrote:
>>ad2s1210_trigger_handler() takes st->lock via guard(mutex), then runs
>
>>--- a/drivers/iio/resolver/ad2s1210=2Ec
>>+++ b/drivers/iio/resolver/ad2s1210=2Ec
>>@@ -1276,10 +1276,8 @@ static int ad2s1210_debugfs_reg_access(struct iio=
_dev *indio_dev,
>> 	return regmap_write(st->regmap, reg, writeval);
>> }
>>=20
>>-static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
>>+static int ad2s1210_collect_and_push(struct iio_dev *indio_dev, s64 tim=
estamp)
>Hi Stepan,
>
>Is the return value of this function checked by any caller?
>
>If not, should this helper return void instead?
>
>> {
>>-	struct iio_poll_func *pf =3D p;
>>-	struct iio_dev *indio_dev =3D pf->indio_dev;
>> 	struct ad2s1210_state *st =3D iio_priv(indio_dev);
>> 	size_t chan =3D 0;
>> 	int ret;
>>@@ -1295,15 +1293,15 @@ static irqreturn_t ad2s1210_trigger_handler(int =
irq, void *p)
>> 					       AD2S1210_REG_POSITION_MSB,
>> 					       &st->sample=2Eraw, 2);
>> 			if (ret < 0)
>>-				goto error_ret;
>>+				return ret;
>> 		} else {
>> 			ret =3D ad2s1210_set_mode(st, MOD_POS);
>> 			if (ret < 0)
>>-				goto error_ret;
>>+				return ret;
>>=20
>> 			ret =3D spi_read(st->sdev, &st->sample, 3);
>> 			if (ret < 0)
>>-				goto error_ret;
>>+				return ret;
>> 		}
>>=20
>> 		memcpy(&st->scan=2Echan[chan++], &st->sample=2Eraw, 2);
>>@@ -1315,15 +1313,15 @@ static irqreturn_t ad2s1210_trigger_handler(int =
irq, void *p)
>> 					       AD2S1210_REG_VELOCITY_MSB,
>> 					       &st->sample=2Eraw, 2);
>> 			if (ret < 0)
>>-				goto error_ret;
>>+				return ret;
>> 		} else {
>> 			ret =3D ad2s1210_set_mode(st, MOD_VEL);
>> 			if (ret < 0)
>>-				goto error_ret;
>>+				return ret;
>>=20
>> 			ret =3D spi_read(st->sdev, &st->sample, 3);
>> 			if (ret < 0)
>>-				goto error_ret;
>>+				return ret;
>> 		}
>>=20
>> 		memcpy(&st->scan=2Echan[chan++], &st->sample=2Eraw, 2);
>>@@ -1334,16 +1332,25 @@ static irqreturn_t ad2s1210_trigger_handler(int =
irq, void *p)
>>=20
>> 		ret =3D regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
>> 		if (ret < 0)
>>-			goto error_ret;
>>+			return ret;
>>=20
>
>I cannot find this goto instance in mainline=2E
>
>Is this patch based on top of iio/testing or another branch?
>
>For patch dependencies like this, is it preferred to mention the base com=
mit in the changelog for single patches as well or in the commit prefix?
>
Looks like David has submitted change answers my concern=2E

Thanks, Sanjay
>
>> 		st->sample=2Efault =3D reg_val;
>> 	}
>>=20
>>-	ad2s1210_push_events(indio_dev, st->sample=2Efault, pf->timestamp);
>>+	ad2s1210_push_events(indio_dev, st->sample=2Efault, timestamp);
>> 	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
>>-				    pf->timestamp);
>>+				    timestamp);
>>+
>>+	return 0;
>>+}
>>+
>>+static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
>>+{
>>+	struct iio_poll_func *pf =3D p;
>>+	struct iio_dev *indio_dev =3D pf->indio_dev;
>>+
>>+	ad2s1210_collect_and_push(indio_dev, pf->timestamp);
>>=20
>The return value does not appear to be used by the caller=2E
>
>Should this helper return void instead, or should the caller handle the r=
eturned error code?
>
>The helper function changes look good otherwise=2E
>
>Thanks, Sanjay
>
>>-error_ret:
>> 	iio_trigger_notify_done(indio_dev->trig);
>>=20
>> 	return IRQ_HANDLED;
