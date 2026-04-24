Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22476025
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776995564; cv=none; b=WAA9QQQyhmK51FgW5R9eAJPWQ7HDAS30OcVQSuH2BFhsYWw9U0xFUUgHkfdls7ovIE9ZZePByZuRDW5akFZSithBr/LqMswbVQ4EoJAop57oM5xhMxB9l82oe7nxGH014BMGEC4Y5QsPO4a5xDn1+ESLcRrYlxkuSYMtS+BEiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776995564; c=relaxed/simple;
	bh=FjKbW3QeLz48VQ8kJwhIfHRD4AToGOuWxZikEd4mAC0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=d7aStGTyQ9F5pshACWpQwWumRBuL/K42mqYiFmVsP9v8IUIRmN9Ik2wyfSc5D7u4n3CkzHP9SVKmRqjX2AjISSITNrSEPyE2a8T0wxuqsaUo0h++aAgF3kp1oH6UPTrChkOZrs9NBb8pQES/ItVTwpvV5cZD+wAga3AZ1u6OC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNjPrG0e; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNjPrG0e"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82fb2d0c5d1so3181907b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 18:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776995563; x=1777600363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dA4COagFILOeWH/SG7H9tln3mHa5hwZ6NIKUz643EAQ=;
        b=RNjPrG0e5d/l5nGTmIS9bwrK6aP08cP/KdtKbT2V9B+pqbtZniC8Zk9iRVPjerM8KD
         +S937DwATtGF+WvDGwRAySsu+RNbVa/AW+35KyQaT7jWfTEZNm89/PTtbFGmG9NWSjVI
         ys8Eprx/4PNksqXMnNnsY8XH8MZJDyFa9HashxjOSR8aJYball3WO9y01u4QDij/RFPV
         KTnnts8JYN4+mNsfr9QxKgx57WcVNI5ehbwbeKcxtswkYt31NeJziYC9KPVYiKg78ogY
         bVtZD4OvBp18L/mjfgKES3uFYQi6/CR50g511XxnENJ1h2U5/iTsov/tuLYYdOMDG+6W
         aP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776995563; x=1777600363;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA4COagFILOeWH/SG7H9tln3mHa5hwZ6NIKUz643EAQ=;
        b=tEoeqTota8D3HkSF/D6yJ6SrFIsFSrLlPx5BD/8D8Nh0t4auqv64XC6YZVHJK9or7k
         gLJ6dVbDvvrFvFKxrcW4eQue4UGLRYjLW8NtNK/Ysj4Fz/2pIwh5Vl9zSBN51b0zoqri
         wf/ptKNOUMPUqyGYoVF/mmYcmQMSCekjdaABoJSOcsHtrwX+pKjbRYSbIVDu5BcVnZxC
         bVfVi2zO4Le+DQF0bx01LlvMUyQw9XhJltulOA9ILTzrdlENOAUUK/XctUjCFoh88tk+
         C/2SvUJoQm7cRF1qMNO70mfyLgrGw2ucjRGKUpD9dotM4RLTAIKDaONHN99gJFUmMi+W
         Pbvw==
X-Forwarded-Encrypted: i=1; AFNElJ+8gLawAs2jmTa1uT5FV8D9EwktWJU6cP1VuaF3S5B9qZMLbXJa9k8oyFvaKExFvvMnlyPFght4rLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRsa9mY+q95U9D+P5ZMy3I0Nc2S03xqm5i2AXMjqiBUJKoHtN
	lQt/9iqfSHPRmBABgId1hiUdy1u1c/Vf27p8cYgdgI8vIUzA5kiAWvRx
X-Gm-Gg: AeBDieujEaNy3GIJc//opmtXcK2FlKdMw93I+iCiBDreE7dwbnHElf3H+xG98yuMVzT
	d2mKgZftQDIMdy5xNFKcGXqao4cnkCpvAHVx3TXLSd2WmfhOxe7KfORoiUeHKcycUva1th2y+z1
	WrZG9Fsnkn2R4z6ikVo3Y304QcieUaGorFOmIEtWmsa9kQzfIxuf8U/PcQxAmgiNAlsSYyg3i1x
	tn6uqGTdZuQuILqzHL/JZMJqtdTahPGetVBb/t8D7+K7R/uOgAnI3YLsX26lW7WdQjZmu8fgWR0
	8z4+SS0O8y1pOieTxTZmVJCgMymK8NupQK0S6J28lOuHem4MuXLJMexPjTdcuE2nCgVa4XFfOhc
	y5+ziABMIFOJf/JySVnmqym9LNNhnbOLXaCCUKkMFq18X9Gw+ppZc9cCNiw6aSpEsxEiT9XDgS5
	z4J0GZjmuHOoOjroEJhGw67uisw918KiNLOM30RZNCTFAzlXBM2PuVmRIoaw==
X-Received: by 2002:a05:6a00:1bc6:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-82f8b50fb97mr23687506b3a.13.1776995562827;
        Thu, 23 Apr 2026 18:52:42 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac05:e3c5:4f57:3515:1f92:c0c2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb38ddsm20733487b3a.34.2026.04.23.18.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 18:52:42 -0700 (PDT)
Date: Fri, 24 Apr 2026 07:22:37 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: =?ISO-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>
CC: jic23@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
 demonsingur@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
User-Agent: Thunderbird for Android
In-Reply-To: <aenU2WZnVJ-esibn@nsa>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com> <aenU2WZnVJ-esibn@nsa>
Message-ID: <8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23 April 2026 1:46:32=E2=80=AFpm IST, "Nuno S=C3=A1" <noname=2Enuno@gma=
il=2Ecom> wrote:
>On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote:
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> The listed maintainer analog domain email for Cosmin Tanislav is no
>> longer valid, and he would no longer maintain this driver(s)=2E
>>=20
>> Replacing email maintainer with list, to keep it valid all the time=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> ---
>> Changes in v3:
>> - Following input from Nuno and confirmation from Jonathan,
>>   replacing domain specific maintainer with mailing list=2E
>> - Link to v1: https://lore=2Ekernel=2Eorg/all/20260418211336=2E1800221-=
1-sanjayembedded@gmail=2Ecom/
>> ---
>
>While you're doing this, could you take the opportunity and also update
>this entry?
>
>https://elixir=2Ebootlin=2Ecom/linux/v7=2E0/source/MAINTAINERS#L1837
>
>Thanks!
>- Nuno S=C3=A1
>
Hi Nuno S=C3=A1,

Are you suggesting to have separate change to add mailing list in analog d=
evices and iio driver which you pointed ?=20

This change is specific to email debounce due to Cosmin analog domain acco=
unt=2E

Also, I had take a glance on MAINTAINERS, it looks there are good amount o=
f drivers which are maintained by you and Michael Hennerich from analog=2E =
If you suggest I can plan to add analog mailing list in all respective plac=
es in separate change=2E

This way all analog device maintained drivers will have mailing list of an=
alog=2Ecom

Kindly share your thoughts on the same=2E

Thanks,
Sanjay Chitroda=20



>>  MAINTAINERS | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c981cbdff500=2E=2E6498f0aed1ff 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c=2Ec
>>  F:	drivers/iio/accel/adxl355_spi=2Ec
>> =20
>>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> +L:	linux@analog=2Ecom
>>  L:	linux-iio@vger=2Ekernel=2Eorg
>>  S:	Supported
>>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> @@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,=
ad4080=2Eyaml
>>  F:	drivers/iio/adc/ad4080=2Ec
>> =20
>>  ANALOG DEVICES INC AD4130 DRIVER
>> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> +L:	linux@analog=2Ecom
>>  L:	linux-iio@vger=2Ekernel=2Eorg
>>  S:	Supported
>>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> @@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,=
ad7293=2Eyaml
>>  F:	drivers/iio/dac/ad7293=2Ec
>> =20
>>  ANALOG DEVICES INC AD74115 DRIVER
>> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> +L:	linux@analog=2Ecom
>>  L:	linux-iio@vger=2Ekernel=2Eorg
>>  S:	Supported
>>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> @@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/addac/ad=
i,ad74115=2Eyaml
>>  F:	drivers/iio/addac/ad74115=2Ec
>> =20
>>  ANALOG DEVICES INC AD74413R DRIVER
>> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> +L:	linux@analog=2Ecom
>>  L:	linux-iio@vger=2Ekernel=2Eorg
>>  S:	Supported
>>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> --=20
>> 2=2E34=2E1
>>=20
