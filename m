Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB72045AD
	for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2026 05:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774674183; cv=none; b=CC5ho4N5bKLscMFtOhlUa1P2xwn8FtVosJSX7BtkIRRF8nwRZKJyz5fOJHla6mvDvEnXVSiuN6hQjLZ0aViRPbSvB1won+27LBm6LPK4VfJQXfyghuaFauYC4n0KoO4VL/wJt8PSEbo4AAkwbqASKfYgj+LU72vPOndfjxgaSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774674183; c=relaxed/simple;
	bh=RA9eUe+gnEl5B7sPzhN1dHV/pHppBGSxzQyy9oc1jC0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AO+NpJfIPMG/4u57jF+rHJ1qU18PZqDOUVilIDMqKYK7F6Jz7UMuHe68Xr04vK0ViEikuWi//Of3xwNXPilhw1jMSiJQy0Dx0V/YA+sHUrqKmT9b2Gb29+nm0TL6oTSR6grboY5Zzya+7vM/vknCLCX2XQawUY4F5QKBk88NDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTFe4i7S; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTFe4i7S"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-356337f058aso1628521a91.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 22:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774674181; x=1775278981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H3JSX2pzaaiQjbe5Ws37SyQ0tu8pdJEZiAoEP2B3/gw=;
        b=mTFe4i7SKlzQM6f0p43jbOw81Ca8bt0jznl69GlzHA14pWTBfIH6qP4l74tZIdBumx
         d6WWHPUbRGFPSETTJsGgING5yhguKPGEBdk1zOfD2aiU6HzEWHe0C2TOrabh6WqjZk9C
         Knm9NyI7ZAo5rmFMcrIvrsywKhkUyaWa3dOX/h6/cQCia5mLX0B3uPtfifN03xhDMUkY
         CWNS1SMR82bGy7CQUp9PGjtdBs8OHp7CoRWfozCoJYREIQvYUEOA9Q1yI+vwyxYJER4t
         eksgqEX+nYl/nBKtluTCHYS1fSYgRGVVkw3i9gHwoO904YnXqYaR0fcFmUxH5dZQXOTa
         ZexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774674181; x=1775278981;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3JSX2pzaaiQjbe5Ws37SyQ0tu8pdJEZiAoEP2B3/gw=;
        b=lEKTDsx5yaiXpwNkE5AmB7MGLBLL5lua2SvaxegRo3WTY6V1PU3zlB+potxO9r+S8s
         MJYiosqS7riznKxJKIZ+87y5GrIpfJeaXZ5yYdRpB1mjshv8xumECApUsya8CUCMHfth
         atyeCUV1W87FybThn6R8Hazb89ABxQlMjta6f7+3xGJuShfbQ/VU5EJ1w/BD3lKogm2L
         fzUUuhv/nnwdwFsoSDpaHgy5m4bBffXctdWd6lxE0bN6HYbe6NUQ8PC3D8HeoIotoc/0
         KOyRMdklr+GRvNbBNOEwnL7AQEQ/E+Jw4NNbRvjUXHWZpWGZH6fSpWAqqDWLRI70IbDD
         D/3w==
X-Forwarded-Encrypted: i=1; AJvYcCWQm0uzD6GM81k1JyWyxpcnSmgYzgMKNL6WeEcdd7VyRrJbw5telwhHBM4/JbKU/MRvgblU7GBvByY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhtJMnzR61de2OoADxaezt4mrGeeQI8JoFrqJxxJljqjRpDUe
	MLtT7FDIDQYem/fHN8TeeAojEPzms1BK5PwiYyAAMfGwnnmYo1xASXTP
X-Gm-Gg: ATEYQzzToNKT7cBrDC1NVIYeKIAbRmg7ZGv3UXMyfRCuv2YytK/RSmk/k/ExTbP5xtI
	bFi7ysqh/+AtUL3JCxmabstZ8+dEgTPKdhXxNIpOobN8R27tWD/QFiHxOi4Rs+bz+uqT0YilCVI
	tAM9lxfNTWuB+IHkTRXsbEhDDDnVsWqvNOofgJilnymlkdpcyT3f5wD7LiEA8R8Ug3xhuv20odS
	QqNZAMDEQySowodlbL6a0WKQ4d7HJ/n9ycCEg159e6Q/FUoSoJxRtOWlH0xR1vH5GXnuZ1ZxLUU
	/WNhLmkDhdd4uzZq0CqGuEk4zSRfRo44dEA4fdTVnITUsFvIoUmmADpg6PUTiVnHfAYP7wyc5nV
	cmucejguTZWDKgsO3QtswanQWMNaPzaAHqZeYVpFLSGRkFMLej4p9LfLKVfTOEJTA0BLqRXDb6y
	XNadMIyuA/dMq8ODC4jSFzamQEVNWhWW3EjTHi2SMLOIh8iQ==
X-Received: by 2002:a17:90b:28c7:b0:35b:a3be:f1b6 with SMTP id 98e67ed59e1d1-35c30076d01mr5256174a91.16.1774674181275;
        Fri, 27 Mar 2026 22:03:01 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c009:ac88:99b7:137b:c894:2d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d9507dd72sm803914a91.12.2026.03.27.22.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 22:03:00 -0700 (PDT)
Date: Sat, 28 Mar 2026 10:32:56 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_4/4=5D_iio=3A_ssp=5Fsensors=3A_reus?=
 =?US-ASCII?Q?e_preallocated_RX_buffer_for_SPI_transfers?=
User-Agent: Thunderbird for Android
In-Reply-To: <acT7ndQKmAUajb_b@ashevche-desk.local>
References: <20260326081815.925373-1-sanjayembedded@gmail.com> <20260326081815.925373-5-sanjayembedded@gmail.com> <acT7ndQKmAUajb_b@ashevche-desk.local>
Message-ID: <31B44DC6-FE3E-441D-94E2-DFADDAE7FA69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 March 2026 2:55:49=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Thu, Mar 26, 2026 at 01:48:15PM +0530, Sanjay Chitroda wrote:
>
>> Avoid allocating a temporary DMA buffer in the interrupt context when
>> handling hub-to-AP and AP-to-hub SPI write messages=2E
>>=20
>> Preallocate RX buffer during probe and reuse it for SPI receive
>> operations=2E This removes repeated kzalloc() calls from the IRQ
>> path, reduces allocation overhead, and avoids potential allocation
>> failures under memory pressure=2E
>>=20
>> The RX buffer size is tracked and allocated using devm_kzalloc(), ensur=
ing
>> proper lifetime management tied to the device=2E
>>=20
>> No functional change intended; this is an internal optimization and
>> robustness improvement=2E
>
>NAK=2E
>
>=2E=2E=2E
>
>> @@ -512,6 +512,17 @@ static int ssp_probe(struct spi_device *spi)
>> =20
>>  	mutex_init(&data->comm_lock);
>
>Pzzz! The wrong use of managed vs=2E unmanaged resources=2E
>
>> +	data->rx_buf_size =3D SSP_DATA_PACKET_SIZE;
>> +	data->rx_buf =3D devm_kzalloc(&spi->dev,
>> +				    data->rx_buf_size,
>> +				    GFP_KERNEL | GFP_DMA);
>
>There are plenty of room on the previous lines=2E I think I already comme=
nted on
>something like this=2E
>
>> +
>
>This blank line is redundant=2E
>
>> +	if (!data->rx_buf) {
>
>> +		dev_err(&spi->dev,
>> +			"Failed to allocate memory for rx_buf\n");
>
>Pzzz!
>Have you read about error messages for -ENOMEM? Please, take your time an=
d
>study this case=2E
>
>> +		return -ENOMEM;
>> +	}
>> +
>>  	for (i =3D 0; i < SSP_SENSOR_MAX; ++i) {
>>  		data->delay_buf[i] =3D SSP_DEFAULT_POLLING_DELAY;
>>  		data->batch_latency_buf[i] =3D 0;
>
>

Thanks Andy for the review=2E

I have addressed the comments related to this change and updated the alloc=
ation as follows:

data->rx_buf_size =3D SSP_DATA_PACKET_SIZE;
data->rx_buf =3D devm_kzalloc(&spi->dev, data->rx_buf_size, GFP_KERNEL);
if (!data->rx_buf)
    return -ENOMEM;

Regarding the managed vs unmanaged resource comment =E2=80=94 since "struc=
t ssp_data" is allocated using "devm_kzalloc()", I aligned "rx_buf" with th=
e same lifetime=2E

For the IRQ handling and other resource management aspects, I will address=
 those separately to keep this change focused=2E

Please let me know if you would prefer those fixes to be included as part =
of this patch=2E

I will include these updates in the next revision=2E

