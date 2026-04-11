Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9675D231C9F
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909646; cv=none; b=szoU1si5lksJRbZVVNiAwye0fdt66DVXt0AiI9QkUc1VCPhYNjz4pMO0YJ6g5YY3FwN0q0G1a0r8peai9JtXQQXhGw0cuYw9v0OVBRPmcfJlT3AZ00EUMDo5bSaoSJ+PFNgMkXTztOhtKpvt7zVTqAsyJsNRd2YQRXP+ku3hMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909646; c=relaxed/simple;
	bh=WiaWCOtI99U5c9sp0hhrP6eQqd/wM0LqySzZ2/tIFsg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rIbuSk/dQqEOhp4cVYZd4lgPLQqtVsfVx9zAvyPOqeg+sjHsJ3BSKIgJ32StSi0lunRWK20pUPyIxHc6TMwWMmLgWiG2RPrppr63sbMc4icjr07AutI9MZmYQYS6Ds3xKEDV6RdXivhVeJ5S279df227/2OTsJBfqNR6JcgC1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rno5qHhP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rno5qHhP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aae4816912so20026035ad.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775909645; x=1776514445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PkFAub7hRXynXWsH4tT7kR+2SO1S/nFQFHvZunhxrD8=;
        b=Rno5qHhPYTImG8XYJyNCSyGXkavGFIEqBfFjqnduNWFFuW/c2UzQTGWosXk07kSJu9
         NB1nR307elO9ua89MndyA2syqxwZbMpoAU0yT++GKkBiGnzrNkzBq37jGOaIy2K08TT/
         dfQOG0wd+YwhIRfJiFBvg2E14WUjYNxqTEn/Y7DZkbEYsKW47orY3uoynqqQEoCJliwD
         UfVSg3y21ldIhlE1GphyIyMxRGDO+6aW4Y8Yof1QS/4Xz1rZAjshuZ+C3KX4g/HINHZe
         FdsRmsf45HXDF9+MqjYmKhoi2XvnZPBVfDPqPE37CjkMOiCSzpZctfhDc9tLD0NcQPj7
         vWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775909645; x=1776514445;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkFAub7hRXynXWsH4tT7kR+2SO1S/nFQFHvZunhxrD8=;
        b=FN+EPt/qsb9dywKdr2sTVik01DHyYKBwZScTlLKmnTlUHqk6VPJBuBN12E6Qz/LbhI
         gvy+PQdhuNBG6flVJJlj5gAh/C+z0WQp42Pmo1RaGFDKP9Jnf4P3Bx08ZyzattWo47fM
         PWeEaF5ZhRYWJ/xZZIv+YgRwvbE8JorsrNxo6B6PZBU6SeWiuucWSWugRmOCMcyuX9Mi
         b0cLCqlom1XfPs0Hfm01S9e/GiWaimc9T5+NN79GqCx7EyTvKL1VcMNhupz7uVbahG9P
         2xcC7EyaJfUP69teU7aos+XLSUglAB3lBiu9wcOdtm1+bqzOz0m+pQdlexobpt8AjXLk
         5QSg==
X-Forwarded-Encrypted: i=1; AJvYcCUmEK/5RJV6r6KJCLsnhsEUkVMhyWGutm4WXdhjSmXwfPf7aQr3D4ipB5MDv32Xs2mXHkY06fi6upY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz02aOYkWZ7oA8kp+lohWdpjw1XRR94+0RKFOpDB/b7YtinZ7tS
	tR/7fW4lomSlmkikxRQJRwOzOJcFHwLu60Z5beQ60hYeFmcjn1CAqtP/S58L5Q==
X-Gm-Gg: AeBDiesk/5pbVnxLfU7GWRapiQZBoNMaXQUaNnHfKt2gpZCo91FPgsMbBaHFhwBfzqJ
	661VXVvxLRpzkSrHqwBviHn7dvcNzlMwrGiKV93pk1ScVh994a8l5Ef728NuIiX+e9OrYWWpFNt
	41YL9v6JbTuMOgH+E5ek3ztoNypAY1ZC3IGtRrI1UNwF7vLW6cVh15wfZeV+dS8TLIMfyOnHfec
	+rmcwKbB7G4kOapLJDVb6NNzMRYKJ/x/kPvLNu/qT1YhckeIekl/nW/0GQN+2cqdDguhnWaGEcY
	j923tU/hZZ/Vm+Q1CBQM8W4+WMcI0klgln0VU2wRuAZPLRs+prw3bHZbTXcc1C/e9XZanhYHRXk
	iqEIi6t6nHCxjfy67GM4wDfHe+3qW0Tj1SsxDb5YH6sdJt8NBhGL60C6ogxlWROlj4LDhq+eTeS
	e1fy9AiwvYoqpUwC2M8k9B2fnoSd/yzaIxC9LIxbA=
X-Received: by 2002:a17:902:6bc3:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2b2d599adedmr49896055ad.17.1775909644921;
        Sat, 11 Apr 2026 05:14:04 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1955:aff9:1:0:8c78:2328])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd610esm58604875ad.20.2026.04.11.05.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 05:14:03 -0700 (PDT)
Date: Sat, 11 Apr 2026 17:27:18 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
CC: kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_5/5=5D_iio=3A_ssp=5Fsensors=3A_reus?=
 =?US-ASCII?Q?e_preallocated_RX_buffer_for_SPI_transfers?=
User-Agent: Thunderbird for Android
In-Reply-To: <8c5dfc4c-dff9-46a4-adcc-dbca54f0c125@baylibre.com>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com> <20260406080852.2727453-6-sanjayembedded@gmail.com> <8c5dfc4c-dff9-46a4-adcc-dbca54f0c125@baylibre.com>
Message-ID: <2C46168B-17F7-4D00-ACEA-B0A85F120D47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 6 April 2026 9:37:49=E2=80=AFpm IST, David Lechner <dlechner@baylibre=
=2Ecom> wrote:
>On 4/6/26 3:08 AM, Sanjay Chitroda wrote:
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
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
>If we are going to claim this is an optimization, we should have
>some measurements to back that up=2E
>

Hi David,

Thank you for your inputs and feedback=2E


>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> ---
>> Changes in v5:
>> - Rebase change on top of latest v5 patch series=2E
>> Changes in v4:
>> - Use preallocated buffer and stash a buffer that gets reused each time=
 instead of a fresh allocation=2E
>> - Link to v3: https://lore=2Ekernel=2Eorg/all/20260315125509=2E857195-3=
-sanjayembedded@gmail=2Ecom/
>> Changes in v3:
>> - prepare series to have all respective cleanup API support for the ssp=
_sensors following input from Andy Shevchenko
>> - Link to v2 https://lore=2Ekernel=2Eorg/all/20260311174151=2E3441429-1=
-sanjayembedded@gmail=2Ecom/
>> Changes in v2:
>> - split series to individual patch
>> - address review comment from Andy Shevchenko
>> - Link to v1 https://lore=2Ekernel=2Eorg/all/20260310200513=2E2162018-3=
-sanjayembedded@gmail=2Ecom/
>> ---
>>  drivers/iio/common/ssp_sensors/ssp=2Eh     |  5 +++++
>>  drivers/iio/common/ssp_sensors/ssp_dev=2Ec | 12 ++++++++++++
>>  drivers/iio/common/ssp_sensors/ssp_spi=2Ec | 19 +++----------------
>>  3 files changed, 20 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp=2Eh b/drivers/iio/commo=
n/ssp_sensors/ssp=2Eh
>> index f649cdecc277=2E=2Eaa125fd1bed5 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp=2Eh
>> +++ b/drivers/iio/common/ssp_sensors/ssp=2Eh
>> @@ -175,6 +175,8 @@ struct ssp_sensorhub_info {
>>   * @sensor_devs:	registered IIO devices table
>>   * @enable_refcount:	enable reference count for wdt (watchdog timer)
>>   * @header_buffer:	cache aligned buffer for packet header
>> + * @rx_buf:		buffer to receive SPI data
>> + * @rx_buf_size:	allocated size of rx_buf
>>   */
>>  struct ssp_data {
>>  	struct spi_device *spi;
>> @@ -222,6 +224,9 @@ struct ssp_data {
>>  	atomic_t enable_refcount;
>> =20
>>  	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __align=
ed(IIO_DMA_MINALIGN);
>> +
>> +	u8 *rx_buf;
>> +	size_t rx_buf_size;
>
>No, these can't be after _aligned(IIO_DMA_MINALIGN); without causing prob=
lems=2E
>
>What would work here though is:
>
>	u8 rx_buf[SSP_DATA_PACKET_SIZE];
>

Okay, packet size is 960 bytes; to avoid using static memory i have used d=
ynamic memory with devm API=2E

However following your input I will update change in next series with stat=
ic allocation=2E

>>  };
>> =20
>>  void ssp_clean_pending_list(struct ssp_data *data);
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_dev=2Ec
>> index aab28f2a0f75=2E=2E2a8d6f040ae4 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> @@ -516,6 +516,18 @@ static int ssp_probe(struct spi_device *spi)
>>  		goto err_setup_spi;
>>  	}
>> =20
>> +	data->rx_buf_size =3D SSP_DATA_PACKET_SIZE;
>> +	data->rx_buf =3D devm_kzalloc(&spi->dev,
>> +				    data->rx_buf_size,
>> +				    GFP_KERNEL | GFP_DMA);
>
>Since this is a fixed size, we don't need a separate alloc here=2E We can
>just embed the array in the data struct=2E
>

Yes, understood=2E

>> +
>> +	if (!data->rx_buf) {
>> +		dev_err(&spi->dev,
>> +			"Failed to allocate memory for rx_buf\n");
>> +		ret =3D -ENOMEM;
>> +		goto err_setup_spi;
>> +	}
>> +
>>  	for (i =3D 0; i < SSP_SENSOR_MAX; ++i) {
>>  		data->delay_buf[i] =3D SSP_DEFAULT_POLLING_DELAY;
>>  		data->batch_latency_buf[i] =3D 0;
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_spi=2Ec
>> index 7c1780e15acf=2E=2E2f7445e8b4d1 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> @@ -383,19 +383,13 @@ int ssp_irq_msg(struct ssp_data *data)
>>  			 * but the slave should not send such ones - it is to
>>  			 * check but let's handle this
>>  			 */
>> -			buffer =3D kmalloc(length, GFP_KERNEL | GFP_DMA);
>> -			if (!buffer) {
>> -				ret =3D -ENOMEM;
>> -				goto _unlock;
>> -			}
>> +			buffer =3D data->rx_buf;
>
>
>I don't think it is helpful to keep the buffer local variable=2E
>
I will keep buffer at top of ssp_irq_msg() instead of local to specific sw=
itch case=2E

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
>> @@ -428,22 +422,15 @@ int ssp_irq_msg(struct ssp_data *data)
>>  		mutex_unlock(&data->pending_lock);
>>  		break;
>>  	case SSP_HUB2AP_WRITE:
>> -		buffer =3D kzalloc(length, GFP_KERNEL | GFP_DMA);
>> -		if (!buffer)
>> -			return -ENOMEM;
>> +		buffer =3D data->rx_buf;
>> =20
>>  		ret =3D spi_read(data->spi, buffer, length);
>>  		if (ret < 0) {
>>  			dev_err(SSP_DEV, "spi read fail\n");
>> -			kfree(buffer);
>>  			break;
>>  		}
>> =20
>> -		ret =3D ssp_parse_dataframe(data, buffer, length);
>> -
>> -		kfree(buffer);
>> -		break;
>> -
>> +		return ssp_parse_dataframe(data, buffer, length);
>>  	default:
>>  		dev_err(SSP_DEV, "unknown msg type\n");
>>  		return -EPROTO;
>
