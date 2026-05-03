Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED702DB79E
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777817837; cv=none; b=uxHSlokY3iJkaSnUGxepXEGvDzLCambw3uUC0lKrISqIZX3I2twtrtnuz52fC+lSAPUhENTyq/9iyB4yk0dZ6vXizGiYbMbN5cDjOKdoqHVRuIl7kwUNUUxTc9jTDFK1gkgne0h0I0vnKUr12CfC2wa4gV96yt9dX9K40rG3wIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777817837; c=relaxed/simple;
	bh=yRozUyojZfZK0RqFIQxSQtMQHsJ16Kwd9wCnDsCZXRs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TxrIZyakxc7GFVG1WujtbFSj/RczkSs8f31ET6aUUgbnpBqXB4+g3umoZzQQOr96QV18y3wV9sww91f2Jbn4SzkT9lqA9K3J6yabRI9jL6ppWRiVWJYmQHzyN+U2pZ0BqpRiWVdrpWnmDJo3mpA55I0pRgwbRoMFYtIpbiHBwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA24N1Da; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA24N1Da"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-364eef1891dso1287936a91.1
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777817836; x=1778422636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2IgW7hnthbt48/vAXh96SJ1gPwAAHh0EsYwYa2W+GNA=;
        b=ZA24N1DaWkb60XFX6f59HHVenfqWlK5tr/NrRR0wyaP9bdV3Y5st6sw1/hu42sncGw
         RrYBYx74CzKaqkGqGBnigwsicixo/66LV34GapXSby0Doe3lFyqixh6+CuEFk01qvIsM
         hedI25dNLMbfyXE9v4sGEMdYxe6Wt8mxBZE2ulWYCcxwHvX0SIu0d3xRhDM9juphzd9a
         IzWbZvnsdSgVvjHaNnngK6nzbE2AF4Q2jNmEOTJEdQTniWly7B7iqWti4P36ZzyDv7t/
         DRgzYopTNyROhXywplh8VQK3Ta2uRFOhBgmPbxGgZouBdhuzrVlH7VRFp7LSIUiQPBWJ
         iSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777817836; x=1778422636;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IgW7hnthbt48/vAXh96SJ1gPwAAHh0EsYwYa2W+GNA=;
        b=pFkzMxkFOlLjakYueiF+zKsVTr8iwFtT8vkN6EoDOVQzK6j1itJWZGzCbAQCGSfW/p
         x96OpfLNhy2m7+DbY7UdHdwRWo1nYPkE4Al5nqvGu0g0nF+PIsfpPkv1z5EbBbj2tSK2
         UdGVQbdTfQlNHzbwqvW0zVXOpqymFWtHPzXkzk/xMb+OiVkh3WerWSxfwo16Qo/HVk0h
         U1FWiogpqY2b2w41dJZFHABfXtg8HJRMOO16UXflPtFkKI7RLBQ6WATA1L8tEntGf2qg
         KHyOrsX8mRaWtNjmb+Q605KnkL7B+wlgzvRqW4spBCH38712rv/f2v/dwuHFwDeXPDcC
         oxWg==
X-Forwarded-Encrypted: i=1; AFNElJ+PJWeZQjwrQ0nreWSnrCs+tiq3bOu8M5P5ps2871cSkteeDUSEsXDFDUWjBO2fDWBf6cH19hsrhJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaAPxI3lTiKgMnGiYEeXfs5wGZsQZ8nURTsd7cs/FrdpXailt
	iLvYs9DdplwsHoyRu+iWpGuikDm+A3KAoTuKttKlcB2h0SpSluo1mA79
X-Gm-Gg: AeBDieuUukezRKVyyvTePq0OuaHXYq75iSL8AvfXyDylTiulqiBj8aKDWhxYZzacOyF
	4IMjxn/XW3KZ3jOhm3E3cGX5+uvJHLjgrG30nH/hyzc/OlF2afNJVTVSyfZbia40mbghlVuPSX1
	n/xQ1DhV5nHL/OtEZcnCA0CCQw7oz+Rap7Kb7iI3UZH+je4X3vML24kcqM4YU7fRvdbqdXHuy2k
	puLwmkYlKs3lI6DCJb/HpKwQwtZIPKZf81Re6duktAzKZHJJaX2mQ6dXxQI6+yq7Pqr46t2s8zk
	gdW4eZRBP4cg4vBodqVhkyIGeLkOKIiN0ZLT+1/eFHrk/Kd5FWD+sLbegTaTgQmLP//UFpdelmC
	YihgFCxxnQgSrcVokTYTtoGCuoh7GYeo/6UWgBJWJIAD7UT9cA8JMRx/TrPCbZFvNqfpC4zq79q
	3zxx27nWLctfoR+2xUOhifcffcOrKoTPFNMROiEdS3OTduzOwvKAwZh1M=
X-Received: by 2002:a17:90b:48cb:b0:364:b4e7:729b with SMTP id 98e67ed59e1d1-3650ce47351mr7394878a91.21.1777817835587;
        Sun, 03 May 2026 07:17:15 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c032:ba9d:4953:28:24e7:1e48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec736dsm8335235a91.3.2026.05.03.07.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 07:17:15 -0700 (PDT)
Date: Sun, 03 May 2026 19:47:03 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
 christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
 kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_9/9=5D_iio=3A_ssp=5Fsensors=3A_re?=
 =?US-ASCII?Q?use_embedded_RX_buffer_for_SPI_transfers?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260426153540.3d43a085@jic23-huawei>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com> <20260426091710.3722035-10-sanjayembedded@gmail.com> <20260426153540.3d43a085@jic23-huawei>
Message-ID: <B6831FB9-2E1A-4A55-B29A-A44371201849@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 April 2026 8:05:40=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Sun, 26 Apr 2026 14:47:10 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Avoid allocating a temporary DMA buffer in the interrupt context when
>> handling hub-to-AP and AP-to-hub SPI write messages=2E
>>=20
>> Replace the dynamically allocated RX buffer with a fixed-size,
>> preallocated buffer embedded in the driver structure and reused for all
>> SPI receive operations=2E This removes memory allocation from the
>> IRQ path, simplifies lifetime management=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_spi=2Ec
>> index 870214551f0b=2E=2Ee41da88bf96d 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> @@ -339,7 +339,7 @@ static int ssp_parse_dataframe(struct ssp_data *dat=
a, char *dataframe, int len)
>>  /* threaded irq */
>>  int ssp_irq_msg(struct ssp_data *data)
>>  {
>> -	char *buffer;
>> +	char *buffer =3D data->rx_buf;
>>  	u8 msg_type;
>>  	int ret;
>>  	u16 length, msg_options;
>> @@ -383,19 +383,12 @@ int ssp_irq_msg(struct ssp_data *data)
>>  			 * but the slave should not send such ones - it is to
>>  			 * check but let's handle this
>>  			 */
>> -			buffer =3D kmalloc(length, GFP_KERNEL | GFP_DMA);
>As bellow=2E
>
>> -			if (!buffer) {
>> -				ret =3D -ENOMEM;
>> -				goto _unlock;
>> -			}
>> =20
>>  			/* got dead packet so it is always an error */
>>  			ret =3D spi_read(data->spi, buffer, length);
>>  			if (ret >=3D 0)
>>  				ret =3D -EPROTO;
>> =20
>> -			kfree(buffer);
>> -
>>  			dev_err(SSP_DEV, "No match error %x\n",
>>  				msg_options);
>> =20
>> @@ -428,22 +421,13 @@ int ssp_irq_msg(struct ssp_data *data)
>>  		mutex_unlock(&data->pending_lock);
>>  		break;
>>  	case SSP_HUB2AP_WRITE:
>> -		buffer =3D kzalloc(length, GFP_KERNEL | GFP_DMA);
>Is there any chance that GFP_DMA marking is needed?
>

As per my understanding, this must be legacy flag as there is no direct us=
e of any dma_* API=2E marking should be redundant and safe to drop=2E

>> -		if (!buffer)
>> -			return -ENOMEM;
