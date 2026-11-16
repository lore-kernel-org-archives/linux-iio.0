Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819015;
	b=rU8SM9GtPEupLvWxCBSwKNjxmOE6S1AHiXwvnQh1hLS7+esgHU5qkHvJ2nZBo9LqDqJQ
	 Cdc76oHwYi9y+HDY3/ENtK1odtfQ2VwjkV1eQfr0aMGxgVTCMKXkQVAr276KjRE1aS3VE
	 J91ZOsSHdoUsBSHZJkUBFfA+HiefRzA2OebwKUBvjVWI07qfuQlDZhNN+XQBjbni6vl25
	 QAxSUHxzQgz117z/88o7AXeAtNHOPwkq6txR7/T6PPMgd612rIjiSydqYzAfNqYK6fXbt
	 Qyg7tAUTFMinPa2DBcmDTVN0ktbdjbj5eGr9RZ9cBy0v6Sr46AKeKqj9gHODLFM9QnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819015;
	h=DMARC-Filter:Received:Received:Received:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-ID:From:To:CC:
	 Subject:X-Mailer:References:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=Ge4JppD5tZ3m94duBlkRytI2wXpdAfMlxVq1gwuajRI=;
	b=D/CHgEyEQLUFFBWNq6CR14dtLTSZYWctJa1ENSxEaFYBmtrZZSIiXZelT6k3FZUyFVaM
	 AcR/fRWwGCk+TGClT1MoUWy7adURob+wozucWFapfL6tJYN9WkF9HfOrA0lH2vSuheglh
	 XZ8vZNtslFbvyf+GKrNqp/p6PfFfOsGVDuoJxIFDP+l2FD5FcGLHwPrOFfVjJkw/TvhK0
	 aBSBkoajgzx1TNzKm7VG0L/T+AD79oEdp9fcg6WglwgCIzOTMeAWexlrpcDJPsjxmKZhQ
	 ObSNtGhdlWYJ/yrnLF5R98XGhwSmuK2pwF2kd6FpIbCOn9pLO9vKd5ZHusTIC3twuCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Ta8wlLoh;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371CD606A31C;
	Mon, 16 Nov 2026 08:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 371CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Ta8wlLoh
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6AG8nq3E001961-6AG8nq3G001961
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 16 Nov 2026 10:49:52 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xSsPQ-000YcX-2Y;
	Mon, 16 Nov 2026 10:49:52 +0200
Received: from localhost (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:49:51 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Nov 2026 10:49:51 +0200
Message-ID: <DMWI8DZPNBKM.2GHPISPEOA7G5@utu.fi>
From: Jaakko Koivisto <jmatko@utu.fi>
To: Joshua Crofts <joshua.crofts1@gmail.com>, Jaakko Koivisto <jmatko@utu.fi>
CC: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] iio: chemical: sgp40: Replace manual locking
 with guard()
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261102091258.247402-1-jmatko@utu.fi>
 <20261102091258.247402-3-jmatko@utu.fi> <20261102111020.00000194@gmail.com>
In-Reply-To: <20261102111020.00000194@gmail.com>
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhaXEgCBxsA
 HQlGCxoHDhwbWSgPBQkBBEYLBwVIWEhaSFlcSFlbWEZaW1pGWlhfRltYSFBIWEhYSF5IWEhYSFhIWV5ICQMoARxFAwQBBg8NGkYMDUhYSFldSAkGDBEoAw0aBg0ERgca
 D0hYSFpZSAwEDQsABg0aKAoJEQQBChoNRgsHBUhYSFpcSAIHGwAdCUYLGgcOHBtZKA8FCQEERgsHBUhYSFpdSAQBBh0QRQEBBygeDw0aRgMNGgYNBEYHGg9IWEhZUEgG
 HQYHRhsJKAkGCQQHD0YLBwVIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=mime-version:content-type:date:message-id:from:to:cc:subject:references;
 bh=Ge4JppD5tZ3m94duBlkRytI2wXpdAfMlxVq1gwuajRI=;
 b=Ta8wlLohWshmIOOIJydXCbqQu5petrhrWm36h5kCE7Vv42HdJzT2UzK6crTbabxWSJxafp8P6sSQ
	vub8lod+ssoSo1GQdpAJct3UYhr14sl/+RSh6+1N2BBhHfy0jcPIJAOX1hIJoQL5C6wqrMOSTM4N
	/BGyjEz0UvMulhyy23RzeVc0h8ZCnJ6m9N50accZ6EqcNfuCpVdlnrpo+rBbs5H8GasFn4boPB6M
	QI5+LYfgNH3QU23d4fFEC0WTk6xwR3JdViuqKydYTU9xyWQXcf86pIf4fmVq0otJ6Z7tPn/SmX/q
	2Kp0j8JltN/V+JZXfp8Hmkpo6364KqHAfgXW7Q==

On Mon Nov 2, 2026 at 12:10 PM EET, Joshua Crofts wrote:
> On Mon, 2 Nov 2026 11:12:55 +0200
> Jaakko Koivisto <jmatko@utu.fi> wrote:
>
>> Replace manual mutex_lock() and mutex_unlock() with RAII-style
>> guard(mutex)().
>>=20
>> Extend the lock in sgp40_measure_resistance_raw() to cover the
>> I2C send and receive cycle, preventing I/O-errors if the device
>> is currently running a command, or clobbering the output of a previous
>> command if a new command is issued during the sleep-period between
>> i2c_master_send() and i2c_master_recv().
>>=20
>> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
>> ---
>>  drivers/iio/chemical/sgp40.c | 33 +++++++++++++--------------------
>>  1 file changed, 13 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
>> index 3a239fb6847f..080d51f9f53c 100644
>> --- a/drivers/iio/chemical/sgp40.c
>> +++ b/drivers/iio/chemical/sgp40.c
>> @@ -148,9 +148,8 @@ static int sgp40_calc_voc(struct sgp40_data *data, u=
16 resistance_raw, int *voc)
>>  	u32 exp =3D 0;
>
> + #include <linux/cleanup.h>
>
>>  	/* we calculate as a multiple of 16384 (2^14) */
>> -	mutex_lock(&data->lock);
>> +	guard(mutex)(&data->lock);
>
> Blank lines around any guard() statement. You want to emphasize the fact
> that guard is being utilized.
>

Should this be applied also for guard() inside switch-case -blocks?
The extra blank lines makes them look strange.

>>  	x =3D ((int)resistance_raw - data->res_calibbias) * 106;
>> -	mutex_unlock(&data->lock);
>
> If only a segment of the code has to hold a lock it's better to use
> scoped_guard() instead of regular guard().
>

Will fix for v3.

>> =20
>>  	/* voc =3D 500 / (1 + e^x) */
>>  	exp =3D sgp40_exp(x, SGP40_CALC_POWER, 18);
>> @@ -172,7 +171,7 @@ static int sgp40_measure_resistance_raw(struct sgp40=
_data *data, u16 *resistance
>>  	struct sgp40_tg_measure tg =3D {.command =3D {0x26, 0x0F}};
>>  	struct sgp40_tg_result tgres;
>> =20


