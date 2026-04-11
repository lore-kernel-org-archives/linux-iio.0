Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277429D26B
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909833; cv=none; b=gxLyF1BJ7qt9EgDIyvMTKDu2lElMeOGN6ApIyms7CU34e/LSW7kxTRSpoxHdyYNzxoj0DAo+HNvDjrmwG+sytdrbJTYEQfy4gNMKJ3FwoagXGpQC4585YT08p/sqhGG5fhWU+6u66dP3FTBzmU3KqJjaq0yAQ8UX0xvH5hfbLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909833; c=relaxed/simple;
	bh=n6rP9/A8t0fjLsv8Wntg2MW55QnenI8NlmtRj0+DDOE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e5ZeoKcxDi6IJenOAwRX+/BALvhHCDW8UK+v+YGO5OtRbRWzQYWi30anJA/84DMYhKSYIBUdQMfT13iI5wGMzyuBa/dZdDZ+HsvCu9PRq6YLxdqVhHQRDSEGXZZP+GRMKZwcNpsPsROXgYWhQvggDiPPjWh3fFlxqSSUpHkwAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHU0zx3i; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHU0zx3i"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1152117a12.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775909832; x=1776514632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sWPGLZHkUvIGjDcTNuB6cYL96SSQ6TMjGBJoDLwMWr8=;
        b=qHU0zx3iAIl6Y0rVY+82foONIDdoN9cVERIt4uTKhZAAbjMiB7zc1vk1da7Q1RKnzj
         2QWr6Vde29413eJ2Imju0jRneLQBrp964+az8oc+34X2GPT30wycrsLqtQZg/MsRItRv
         wp7XNn2hvGZ4rnbe9zyjyIkyu8U018zJbqhMozzTgAWxnxrxpww9DNt39A5mO8HKhRQX
         VEI3cM2sDuUegtwsPrYF0sJSUy2ZTFHt6z52yCRACW/V5D1dF2ycKAOCp9F+PXmZ0Sms
         wROlAlVJ/zlaZ0oA+e8PQWi+w30ZieY9qjiD7yLNa9ykk++ia3wns0dkHp5pRljmJdms
         P0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775909832; x=1776514632;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWPGLZHkUvIGjDcTNuB6cYL96SSQ6TMjGBJoDLwMWr8=;
        b=sgbMns2yAuZv/6R6gWz1wxkmPP04acsX6QVrK3edpvgXP0mQri32epFWLe1SF+VjxW
         vxSKbZWJqDdswev61775qWEaPZsHVGpNsaog2PH6pKKDgV170KoDkUgBJ4i6CADcGbWT
         of+rLxj0rzdafZ3P8rreWDWzIHAt16wAN0Pb2V7Rovd+DD/J8ztw4IA0Wk8GOvr7Kvc0
         6QUKdUwy8XN/JifEs0cQ1rmWdXJqf200nOWf07Qe00TT9/yx7mqxLdz8ke+JGxu59eP9
         eLLeF5gTHNB/kq6TBv0ImxCKxkscowdye0bLgUKeRfjdLZgD5zU7PO8D9IDDx75ge9RO
         TSug==
X-Forwarded-Encrypted: i=1; AJvYcCUYPLJqQiZVF/PQalFJKpEQ8pWm9kD9D3XGoRA6yuJNKxNwQtoBhW/b6/3uSjFjyeu4DyN8GvOBTI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwf4P9dFRfCOBej4miZb6alqlZdk5A80q2ql5ZTNTaS1SU1fEC
	wxOY1e36bRcVd58AznPEqIo7TVdn6dVjY3SpBzbkkjWRcGgpnO/1qDAI
X-Gm-Gg: AeBDievDSEqDgbO8WfXZE0eLNovRcWRrzxK2gUHuxvopslABbBGIwoQd/BvtSx2T1ZO
	O1R6XfnKkntr+6O/9gUdT/Q9KyVjjMcki0rp/cMuYWcqPmuiy81/nBFF/WZT2fIGrNSiTZzfI0B
	LmAZxxyH1CZDmPPnnOG6pfKC/ar9X1QGJd9H17OC8h6WKiVRNbCXOold3sxeCWUJxoRSbi4ih7G
	5NzpsY5I/vaVTPsipsWvduz6DTOYO/PAmAVMa36KHQW7DciKAMTcyd8+XN9dWZA7ffPm95pIPkk
	obRU2pgGDB+tk79q7AK/o5n9nVgc5koBoKz9Kx/K7fJM0GjG2vQOMu+DQkkOYLufzFtbz4DbKVu
	Vr/ftHZaN3vo+plRrUpYsultj7EZ5in8qrCcZa4K1kRvhcAL40wf2VB86hLDEI720swkHZD8KxH
	a95tp4GYyHY28xE2FPPvpaH+LYzTZYQPl4ZojWdf4=
X-Received: by 2002:a05:6a00:b4b:b0:82a:fc5:fb81 with SMTP id d2e1a72fcca58-82f0c1ce8c6mr7307039b3a.5.1775909831507;
        Sat, 11 Apr 2026 05:17:11 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1955:aff9:1:0:8c78:2328])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a70csm5362576b3a.55.2026.04.11.05.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 05:17:11 -0700 (PDT)
Date: Sat, 11 Apr 2026 17:47:01 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
CC: kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_5/5=5D_iio=3A_ssp=5Fsensors=3A_reus?=
 =?US-ASCII?Q?e_preallocated_RX_buffer_for_SPI_transfers?=
User-Agent: Thunderbird for Android
In-Reply-To: <8c5dfc4c-dff9-46a4-adcc-dbca54f0c125@baylibre.com>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com> <20260406080852.2727453-6-sanjayembedded@gmail.com> <8c5dfc4c-dff9-46a4-adcc-dbca54f0c125@baylibre.com>
Message-ID: <ACDA46EE-53D8-4E1E-89FE-FACA53F78F51@gmail.com>
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

I misunderstood the __aligned() constraints=2E

I have reworked the struct so the DMA aligned buffer is the last member an=
d replaced pointer with fixed size buffer as suggested=2E

>What would work here though is:
>
>	u8 rx_buf[SSP_DATA_PACKET_SIZE];
>
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
