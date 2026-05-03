Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3835AC25
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777809895; cv=none; b=imAxjYLjcd8ba5atBt+gqgfJfa/2Dcsi+UcAV5E2dB0lcWYqM82vx0VDG/BX6d+J2W8ej//EnePIli1od1w/g6VrCUuRl3ZeftN4TVjmlP/WRyNcrpiAB3CGqT+nDjFtLiounYuP2nya1rhlxnHRIwTO4Lt5JI8uQjWf4xZ8noM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777809895; c=relaxed/simple;
	bh=6t8hf+jvclKcFqexAMHOQeHlJSVq6TZgFh3NWGMajyU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=suibC/1bWLr1t3AvADJYmadsT3vBBaqtDx4QicBkHD6aoaF/Znc/JVeov0kWVNrE5CzvjZmd+KlDwTAYCOA6kuCqnpfTjW3SXbQXQVh8iGrzdXbRM/ibCEUsgG8npDto5Wis3p5M+eMKyCJzlg6gBCWXji9V7EpQAoWsds+XHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWjNhl1T; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWjNhl1T"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so2331564b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777809893; x=1778414693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rjLwikMJwwv8WiyxLC2xfpYlI/x/m6P1WwnRYv4gplE=;
        b=CWjNhl1T/FgElY8+CZzm6ZdFcitS0aBrAoXTV+yM4nvK+9scNzCPdfRseinKkhfti/
         jaGrFb3G4rLt63rvROtiE+TDRPlIih0wSNXe8GYh8sOSD8HIgdUsi2jGXLkgGYtoHo8J
         6dJThttzSqBlbxs6PCAwOPSMC4x8FgTaivj3AT3FV0vxgjQ6R9I8Sag89olERGEjhZwp
         SanG1zjuI7Gx8+P1Lk/3wCn5PMTbRNk2BZiKnca8qr25YZv/LVn+1xM31UC6xc1qvu4r
         OmJGUoVZaqVcHbwBzc+aR/iaXOI2PONOYAiMR4lkobIoh+ao1AZ8PrL9xLN0fRa5RzB6
         +0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777809893; x=1778414693;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjLwikMJwwv8WiyxLC2xfpYlI/x/m6P1WwnRYv4gplE=;
        b=JEJtKlR6TtilLNpl81zEn2dftdtpNQKrhboJTA+KExQiFBW/nFF0UvXPRynJ5L/o+Q
         KZhkF4qrkNdb7ZrjrDU4S2YkPm8tKEZb2dljv+qcFZczph5hzD/QVs+GoNSd8NDP/UEO
         Swyzv6OaLFryF35GJhd7xvbkCofv2rk4+YDYXobSMj4EyH+LCe1a6WMlDh0KrW/hisZw
         H+uaY1i3vMJQOs+dwS1FYq1zjPXxkt55mSmGmgtKQRjUwIEwHVWUXirCbdNiPQIRxEgS
         COkHj7N6TsLljGJAiB3ks5bVxIlbIsaNpSecMWcRdfgj6LV4/A3wuLp+XvviE5nLXNfk
         ZiUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nZdtU93ukei09aEH4tKAGUkFkuerPgADTc6vptNDhXhtoHFsST8u0F6FBUhxC1P4gr3OqDnXF4/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzA9qm48JUlRiy3F+K8+6aCzz6W1mTeLdVJHeFu1BM50Zs0qGl
	eCDAV/mx5MjC+oJbgWlWS511OPsKzUvIAByJaCSJKYFSnn4DPhHhNEaU
X-Gm-Gg: AeBDietKHNFL0PmF+3/+5dzbS88HvBJ1xG4NjbjSfVuqFZNWAQ9eRTu0i1kL5iwvFFF
	ZeCSc06XsZJGfO6o2j8F5kpjImOLrD+u9N0upF494wFovZ4d/MsAGIZSHyEwhRciypol766DCV+
	wMVgl3nnvJg6jbIbWDDSJiDzj+6oCpZOf9ZUPu88xv/Pb1xCTXbwn8gA+kUDTptrvM2HDqFVKnt
	jUalSG0hAJUNAbabzkozZsDy9Tr2yX9aMIdUOQqQVAWuVkDL7xrzjK2avbgOp9DS65sslrglMgk
	pwNoJkPECyvUl2k92xf6x/JbsLWEkJ0NkQok1TEy91PUZ7sm8SA6ZCexKp4Yy60lZT2R+s1jjTs
	eYjYXM2bqdVhcOzUfrxpEFWhzjWa34NkDuimt2u78vGZfOgXOQz/mCHbIXA/iJPCm6lhKYt0dNc
	JF5RkM6jxXdHC++LSbqsHiObRqutduaAAg59j23cBlHLqcZT6L0QenQaNA4Q==
X-Received: by 2002:a05:6a00:aa8c:b0:823:1c5f:1c43 with SMTP id d2e1a72fcca58-8352d2b63dbmr5679078b3a.36.1777809892786;
        Sun, 03 May 2026 05:04:52 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c017:782d:e512:3b34:6995:988f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b01a4asm8022542b3a.43.2026.05.03.05.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 05:04:52 -0700 (PDT)
Date: Sun, 03 May 2026 16:53:27 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
 christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
 kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_2/9=5D_iio=3A_ssp=5Fsensors=3A_fac?=
 =?US-ASCII?Q?tor_out_pending_list_add/remove_helper=28s=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260426150830.7ab41ad3@jic23-huawei>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com> <20260426091710.3722035-3-sanjayembedded@gmail.com> <20260426150830.7ab41ad3@jic23-huawei>
Message-ID: <F6B75893-D8A8-4072-BB26-83F630805700@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 April 2026 7:38:30=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Sun, 26 Apr 2026 14:47:03 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> The SSP SPI transfer path manipulates the pending message list in
>> multiple places, each time open-coding the same locking and list
>> operations=2E
>>=20
>> Re-factor the pending list add and delete logic into small helper
>> functions and drop use_no_irq variable to avoid duplication and
>> simplify transfer flow to follow=2E
>>=20
>> No functional change intended=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> Suggested-by: Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom>
>> Reviewed-by: Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom>
>> ---
>> Changes in v7:
>> - Following suggestion from Andy, keep helper API definition in single
>>   line and re-place the comment section
>> - v6 change: https://lore=2Ekernel=2Eorg/all/20260415050749=2E3858046-4=
-sanjayembedded@gmail=2Ecom/
>> Changes in v6:
>> - Include tag for the suggestion of helper functions
>> - Drop completely use_no_irq variable with review comment from Andy
>> - v5 change: https://lore=2Ekernel=2Eorg/all/20260406080852=2E2727453-4=
-sanjayembedded@gmail=2Ecom/
>> ---
>>  drivers/iio/common/ssp_sensors/ssp_spi=2Ec | 58 ++++++++++++++--------=
--
>>  1 file changed, 33 insertions(+), 25 deletions(-)
>>=20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_spi=2Ec
>> index 08ed92859be0=2E=2E870214551f0b 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> @@ -174,15 +174,35 @@ static int ssp_check_lines(struct ssp_data *data,=
 bool state)
>>  	return 0;
>>  }
>> =20
>> +static inline void ssp_pending_add(struct ssp_data *data, struct ssp_m=
sg *msg)
>> +{
>> +	/*
>> +	 * Check if this is a short one way message or the whole transfer has
>> +	 * second part after an interrupt=2E
>> +	 */
>> +	if (msg->length =3D=3D 0)
>> +		return;
>
>I know Andy suggested your bring these into the helpers, but to me
>it's obscuring flow as it looks at the caller like it was added
>to the pending list when it wasn't=2E=2E  And we end up with multiple
>checks on msg_length where we had one before=2E
>
>One option would be to have it return a bool to indicate whether
>it was added to the pending list or not=2E
>
>Andy, would that work for you?
>
>> +
>> +	mutex_lock(&data->pending_lock);
>> +	list_add_tail(&msg->list, &data->pending_list);
>> +	mutex_unlock(&data->pending_lock);
>> +}
>> +
>> +static inline void ssp_pending_del(struct ssp_data *data, struct ssp_m=
sg *msg)
>> +{
>> +	/* See ssp_pending_add() for transfer length logic */
>> +	if (msg->length =3D=3D 0)
>Not useful to know if this happened at caller, so no need to return
>bool from this=2E
>> +		return;
>> +
>> +	mutex_lock(&data->pending_lock);
>> +	list_del(&msg->list);
>> +	mutex_unlock(&data->pending_lock);
>> +}
>> +
>>  static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
>>  			   struct completion *done, int timeout)
>>  {
>>  	int status;
>> -	/*
>> -	 * check if this is a short one way message or the whole transfer has
>> -	 * second part after an interrupt
>> -	 */
>> -	const bool use_no_irq =3D msg->length =3D=3D 0;
>> =20
>>  	if (data->shut_down)
>>  		return -EPERM;
>> @@ -202,35 +222,23 @@ static int ssp_do_transfer(struct ssp_data *data,=
 struct ssp_msg *msg,
>>  		goto _error_locked;
>>  	}
>> =20
>> -	if (!use_no_irq) {
>> -		mutex_lock(&data->pending_lock);
>> -		list_add_tail(&msg->list, &data->pending_list);
>> -		mutex_unlock(&data->pending_lock);
>> -	}
>> +	ssp_pending_add(data, msg);
>
>With suggestion above this would become
>
Thank you for the input=2E
Agree will include in next series=2E

>	use_irq =3D ssp_pending_add(data, msg);
>> =20
>>  	status =3D ssp_check_lines(data, true);
>>  	if (status < 0) {
>> -		if (!use_no_irq) {
>> -			mutex_lock(&data->pending_lock);
>> -			list_del(&msg->list);
>> -			mutex_unlock(&data->pending_lock);
>> -		}
>> +		ssp_pending_del(data, msg);
>>  		goto _error_locked;
>>  	}
>> =20
>>  	mutex_unlock(&data->comm_lock);
>> =20
>> -	if (!use_no_irq && done)
>> -		if (wait_for_completion_timeout(done,
>> -						msecs_to_jiffies(timeout)) =3D=3D
>> -		    0) {
>> -			mutex_lock(&data->pending_lock);
>> -			list_del(&msg->list);
>> -			mutex_unlock(&data->pending_lock);
>> +	if (msg->length && done &&
>then
>	if (use_irq && done &&
>	    !wait_for_completion_timeout()
>> +	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {
>> +		ssp_pending_del(data, msg);
>> =20
>> -			data->timeout_cnt++;
>> -			return -ETIMEDOUT;
>> -		}
>> +		data->timeout_cnt++;
>> +		return -ETIMEDOUT;
>> +	}
>> =20
>>  	return 0;
>> =20
>The mix of using a goto error handling block and not in here is not elega=
nt but
>it's would take quite a bit of reorganizing to tidy that up=2E  One optio=
n would be to
>factor out this bit
>	mutex_lock(&data->comm_lock);
>
>	status =3D ssp_check_lines(data, false);
>	if (status < 0)
>		goto _error_locked;
>
>	status =3D spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
>	if (status < 0) {
>		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
>		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
>		goto _error_locked;
>	}
>
>	if (!use_no_irq) {
>		mutex_lock(&data->pending_lock);
>		list_add_tail(&msg->list, &data->pending_list);
>		mutex_unlock(&data->pending_lock);
>	}
>
>	status =3D ssp_check_lines(data, true);
>	if (status < 0) {
>		if (!use_no_irq) {
>			mutex_lock(&data->pending_lock);
>			list_del(&msg->list);
>			mutex_unlock(&data->pending_lock);
>		}
>		goto _error_locked;
>	}
>
>	mutex_unlock(&data->comm_lock);
>
>into a helper, use guard() for the outer mutex and then direct returns=2E
>
Hi Jonathan,

Thank you for review and point,

If we convert this change to sub-function then suggested use_irq would be =
shifted to sub-function; then how would you suggest to handle that bool ?
- keep msg->length as it is
- in sub function __ssp_do_transfer(data, msg), should we pass additional =
parameter to bool for further execution?

Or any better alternative to handle both ?

Thanks,
Sanjay Chitroda

>Then we only have a simple check on return value from that to decide
>to increment the counter and exit on error=2E
>
