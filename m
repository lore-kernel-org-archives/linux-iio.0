Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B24A8A0C
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361100; cv=none; b=QdU3CJxbQ4u/I3ITZX7vkMNc0tfJQjwuzJHHW8oLmjX2QHWdulODUAPFiHQhdXAAPVXN2NTCxf4TIpJsEYM4+CPHRXHtMf262k+nLZ3X5mf3iMyvf8KaXoSwxdIUje615CG3af36G4VzEhgBLW8kkQUNZj3qBjuK8IFpurPQ+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361100; c=relaxed/simple;
	bh=Ike3RXWaxfkiCBcUa9n8zGSdiMZUjyJh/tkpIiCsRQQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=tvmSBKBMj9nYkFVIzapWJGrsjJkj+0nC28h+rCNZa8k+3DVWlqzkGNl36uSJZE8ZmAtjsKPY2rR2gabj/vCZSdfVz32wIn7wAnUiLQHm2yyTntGVVpvsBKD2DgamttbRXcrb0c8BlP1MiJoHSihrGlFb5xUTNi7O2StuuslptJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfCAZGwT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfCAZGwT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so8067465e9.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361097; x=1788965897; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ut6WTLtprFfdFmADZkEnMEMmA93KZj0r2cZvBQ9PeRQ=;
        b=VfCAZGwTL6liD7CLg8mXtyS2kpp+HYFcB53d3KEbVdCMVPY8LuSruzf4StGe5k8kZ8
         MdU7OQruk7mCwSoK2hIJ6PsIiCiH+PsIPuchHX1zwG3YrXluCtDhC+Pe/QGynfgVmftX
         4ovRDnzgg0iz6Y4H11pQtb1FvsdO1HElkHVX7Zfa8Q8KKaXqmDqIatIc7JgSec0zaDBE
         WIpBC1AU9jdOjUuWcKAeCMyA0IA4CnHGPX5u08JKgVPxF8EYMeYPYPQaoKabeSDCBr7W
         50SEzEKXzOOqhCKclmfiMzSZO15tjfMuuK9IL5jZGPZ/Z3aOTQJzqa7SeUNnsG6r38JL
         V1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361097; x=1788965897;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ut6WTLtprFfdFmADZkEnMEMmA93KZj0r2cZvBQ9PeRQ=;
        b=GKVKvN2bWI/SVEmufcDMiXPhHCtCn+VpgUw47S+F3RqjvvdCXlMjQIwjuGxS4/iTrf
         HwsUdzr3DfUGRBA6g0b9enuDURQ7cg87Fy4bx8TwvbdMXIaNbdStOob/mzJojd74HEH2
         FriyIyY3BCOMnbASAklVTW5VqTsazg2FK4nR+5m0t4dYpCDcbWQIcRea4oMQApx4hKvU
         mPiyhlcv4EXSfncROyMhmM95C8VNJN9WLCLPv20/Jfr33FelsOc26pV7xGlscc4KWPQQ
         lAy5eP0GubuYnBRMCGMiwpnQvbhUJHvOIxyux2rI+5QHeunumeU2iN9Zkq8qq/xyy9Pc
         iM8g==
X-Gm-Message-State: AFuF++l+f0UyEfMvVeYxxaXgIRd1m6UPW/A6ny0Oe3b7fmoFh5vsimXs
	71GiuB+i9slbQ88wcVoFkCqovU3AxH10cgd2KeW+ypXSWvMa/Agep7Yb
X-Gm-Gg: AR+sD13ywjxg9U8eqzaKMeYj/Nd2o8qXFPc0OQfbJHS4OzW3oQhnNdbJ1TcfOfPHRGY
	ynleH2FEED5aOpKwWf972gBWNuz7g0MiNgRskSuF71+LXbAm7gaeXqVK7Dzhm+6ljyL6+U1eaXs
	l4vZUgdztpUXuBs7njrl9FmGBSav12XbimtmbJb5x7mYXcU06g6iOn8pjXjvPmk75BXlegBQ8vS
	NgJyRwpOTYBVCO0oKFwdz48tIZ3rfFcxjejGixX84DOUiOUPN9pyiUqpgoPAo8soAeonHwEyHL+
	MD6qQ737l1ZmYlyqXKenF3VGjGY5eaUAE/2Mv98TkL7Er3ArLFPQKHt1eXpSLUtVPSXRMxdD7jV
	YNuWqCNs2wbPLsXLnS7L/zICy9VGOR2rbNPANC+XOShyyMp6AQroKj1wXIo8lEQDHdWd0kczVcB
	TfwjbqndPFRbKe8ZLnuJ7cit4pEFy06MvQ47mfaBuAGzr1KC0laURqgb+Z9paXpQAJ1TZQnyuBX
	+Em21P2v4vn
X-Received: by 2002:a05:600d:4:b0:49c:e9c1:25ca with SMTP id 5b1f17b1804b1-49ce9c12778mr51716185e9.3.1788361096158;
        Wed, 02 Sep 2026 07:58:16 -0700 (PDT)
Received: from localhost ([2001:4bb8:16d:f647:c3b0:727e:b1fd:6610])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b425sm154136445e9.1.2026.09.02.07.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 07:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 16:58:09 +0200
Message-Id: <DL4X3IXEI8WK.OOFNRSU7FGRW@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v8 4/4] iio: light: veml6031x00: add support for events
 and trigger
Cc: <linux-iio@vger.kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>,
 <sashiko-reviews@lists.linux.dev>, "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
 <20260901-veml6031x00-v8-4-532cb4f2168a@gmail.com>
 <20260901132208.EE64C1F000E9@smtp.kernel.org>
 <DL49BADYC1U8.2N2F6YW5ZR5S2@gmail.com>
In-Reply-To: <DL49BADYC1U8.2N2F6YW5ZR5S2@gmail.com>

On Tue Sep 1, 2026 at 10:19 PM CEST, Javier Carrasco wrote:
> On Tue Sep 1, 2026 at 3:22 PM CEST, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential iss=
ue(s) to consider:
>> - [High] Use-After-Free of iio->pollfunc in IRQ handler during device un=
bind or probe failure.
>> - [Medium] Unintended I2C read of configuration register when pushing ti=
mestamp to buffer
>> - [Medium] The interrupt_users counter can permanently underflow during =
error recovery, breaking hardware interrupt control.
>> --
>>
>> commit c87f3d48e1ee614fc184995b816c8f8679a6b774
>> Author: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>
>> iio: light: veml6031x00: add support for events and trigger
>>
>> The device provides a shared interrupt line to notify events and data re=
ady.
>> Add support for configurations with and without an interrupt line, provi=
ding
>> events and trigger support when an interrupt line is available.
>>
>>> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml60=
31x00.c
>>> index 3d5a27a0baaed..7bd7975eb1a76 100644
>>> --- a/drivers/iio/light/veml6031x00.c
>>> +++ b/drivers/iio/light/veml6031x00.c
>> [ ... ]
>>> +static int __veml6031x00_set_trigger_state(struct veml6031x00_data *da=
ta, bool state)
>>> +	__must_hold(&data->irq_lock)
>>> +{
>> [ ... ]
>>> +	data->trig_en =3D state;
>>> +
>>> +	return 0;
>>> +
>>> +clear_interrupt:
>>> +	veml6031x00_set_interrupt(data, !state);
>>> +
>>> +	return ret;
>>> +}
>>
>> [Severity: Medium]
>> Can data->interrupt_users permanently underflow here during error recove=
ry?
>>
>> If an I2C error occurs in __veml6031x00_set_trigger_state() while disabl=
ing
>> the trigger, this error recovery path calls veml6031x00_set_interrupt() =
to
>> revert the counter, but fails to update the software state (data->trig_e=
n).
>>
>> If a subsequent successful disable happens later, the counter will be
>> decremented again, potentially underflowing to UINT_MAX and silently ski=
pping
>> all future hardware writes.
>>
>> [ ... ]
>
> That is not true because the error path will *increment* the counter to
> re-enable the IRQ and keept it consistent with data->trig_en. If an I2C
> operation fails, the trigger will stay enabled in the device registers,
> and therefore data-trig_en should stay enabled.
>
> I tested it by adding some hacks to force that situation, and what may
> actually happen is that if *on top* of that failure, the I2C operation
> in veml6031x00_set_interrupt() also fails, interrupt_users will be
> decremented (as it should, because the interrupt could not be
> re-enabled), and *then* a second call to disable the trigger will set
> interrupt_users to UINT_MAX.
>
> Although this is very unlikely, the fix seems to be trivial:
>
>  if (state) {
>  	data->interrupt_users++;
>  	if (data->interrupt_users > 1)
>  		return 0;
>  } else {
>  	+	if (!data->interrupt_users)
>  	+		return 0;
>
>  	data->interrupt_users--;
>  	if (data->interrupt_users > 0)
>  		return 0;
>  }
>
> Note that this fix is not a hack to just get rid of reaching UINT_MAX, it
> reflects the fact that the previous failed operations lead to a disabled
> interrupt and an enabled trigger in the hardware, and there is no need
> to act on the interrupt again when trying to disable the trigger a
> second time.
>
> I will add it for V9 after testing it with some hacks to force that
> scenario.
>

I am trying to reproduce that scenario with forced errors, and even if
those two errors happen during the first attempt to disable the trigger,
it's not really possible to reach interrupt_users =3D UINT_MAX.
The 'buffer/enable' attribute is set to 0 by the core even if
set_trigger_state() returns an error code, and the next time
'buffer/enable' is set to 0, nothing really happens because
set_trigger_state() is not even called.

I could still add the check I suggested in V9 and avoid future issues,
but I don't see how to reproduce this in the current state of the core
and driver, even forcing those failed I2C operations.

Best regards,
Javier
