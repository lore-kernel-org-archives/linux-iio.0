Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB113909B9
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490895; cv=none; b=ey8vvNATh9hGqxFkW58/UWqW3CzbnwVE+1Jnf3ej4d1n5i205acjtCh0xC9NoAFGWhaAky4Jts6Ge9kT5UHSF7xCoj5LbYtxOOq9xMXhcaX4n91zGQiyIFxIgn0dzup3EcTUhs73TZ69XcPQuxkHSQTUXdiD8QHSX9BtE7ZmtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490895; c=relaxed/simple;
	bh=Uz+tv28uguan4+TVeoqiw4dqH6wrGaL14lOoxbz5uo4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ivQwzZYeLPdAWYPD01iPY9nQYmGhCi5Tq6XVwdzKQks0PwqewYcInP7sLEwo6t/ZsnONWS6Mz0Qf1PloFBlQcPd411G3K27zoSXBRaEdJZn/HtN0eVrx9DgIjKAOs/Ht4dxgJWL6zDYPz/1KpyoKWLHiAj+PcH0uc26y0NfK3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+IRraMY; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+IRraMY"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64acd19e1dfso4445629d50.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 14:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772490893; x=1773095693; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r5SJBYcjwBqnt4UbsldqIEQalNfi3J745CT2W0Ye0s=;
        b=R+IRraMY4DpwuyB1v8Dzg6RJnSx/z53pe6HyLDPn456oHb8AiDW7jpzU0hKqdG1uC2
         Njew2o8/strK9NSxAxe6T4W9sw5Rxz7eAAxFVyplTx2ik5u62m4iWJdLksZisH81jJrR
         7gH3O1DQDcN5AoSMAZ0UFIthXgU+CBBKF6R/cDQHx7FG8q3a6OWkmsuasFjM8DkpuDq6
         SU34dK4Qp8AwiMVEK38RmgNY/OPOvwfuPaCVjCAsjgHJNEeQzGQjpdyqfWVS+Nh69fVi
         uUvK6LF8iE59Jnhe+8Pbfs031sn4KSnPOUKXdYo5Z4BW4KofOhbnEPn5R3T6UXdaYmCP
         VU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772490893; x=1773095693;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/r5SJBYcjwBqnt4UbsldqIEQalNfi3J745CT2W0Ye0s=;
        b=HIK6nGj2UZH1Jo6WHBWOAE0a65IxMSk/EPbZ3mTx8IIU5uSaWfkkt8XyoJG39UzhmE
         tehpYCZKcwXNp6DzRCWfhf3oWM3BfHF6O5f4JCy3D61EA1E5uzcCfYwG9DPa6/hdNyBz
         3xYTZZdIAZGLsCtBHD2eGV4K4GgIj3tkU1HW2lCDMsbTfZSLwvQZ2/C+M7AU0Xc//zeF
         z44iKV2kYXsyNr2wa3griuWwVaJ4GXTHMKzYjQ4xWGiv/L7qG8gyrqp7LczxFP+lXHgw
         iJI5MX2wh9iMWVmK8qUoEhrP+rT8slF4/G71mnp8O0SuKHCe8KyKBl/BeOMpTyYztHlR
         /eyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnSfRnVq7/rCqFRRFbJhAfasGVqnKIpLgFVysENWHctxikDENfOQiRcxo6kmLV0QfdZXONSCfQSmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91/n5gZVtqsfpXkSgd9CbMRh9brQaQ7IMeK2ucxNPCrFBwTed
	MhxCFxPM9mGMGDY0GaLlbTQjQ/VUyDLX67M6TdCK4XTLSzTVfgmqF60G
X-Gm-Gg: ATEYQzzJX3MWJNJf0ius7rP5LsjVQGQcQkC85baqcHptVd/huV/hwFXe87cyMjg0C9a
	kwpzwHvYL2nlYrcLYIYt5AEokRVvSHYh5uNx/xxehJROhP4jXNraXiK9Zi1iL+YqISdE+UtWGAH
	rYqfCB21b5zDSpRXG4JSotkV7c5ljdmvvGCzGqZfyKKbSyDHLmpXGNmpCmO1/uBInDkJA13p35x
	TElLStBiM3kvBwejbdX5rgUtG4NuS9OzGd1Z3dluQtTrL5lueInp+9uLyg+xtDEdSp3LxMeA2bf
	Am7r8qFrvRyVZNJuEVyObWx1+CI7XTdHBzjZ+JIwXMMXm5fCwuqo3lRub5CCToYa9YM5LIMC7vz
	3bfo6YS9n39xS+5pyVgN/N/r1xBQyP9x7MBXJotzQ9v56sar/GsG1ziPSiyJyzp37KstwqyCj3Z
	DcaT4loetoLFMHrX4cO0ReLITqbj+WmCW3e4gOJrppeweZNPItr9Et56+4WbPNO6+7qUrVSJKeR
	gYRDQvEJ5bWTYWe2LPSlWkxrEYNNcV3
X-Received: by 2002:a05:690e:118e:b0:64c:ec37:ab73 with SMTP id 956f58d0204a3-64cec37adf7mr686471d50.82.1772490893346;
        Mon, 02 Mar 2026 14:34:53 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7650fb7sm6033124d50.22.2026.03.02.14.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 14:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 16:34:34 -0600
Message-Id: <DGSNKQJ58INF.1ACGVKBMLTBT2@gmail.com>
Subject: Re: [PATCH 2/3] iio: filter: admv8818: Simplify locking with
 guard()
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Ethan Tidmore"
 <ethantidmore06@gmail.com>, "Antoniu Miclaus" <antoniu.miclaus@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-3-ethantidmore06@gmail.com>
 <f7203222-eaac-4757-9328-c34660a27eb2@baylibre.com>
In-Reply-To: <f7203222-eaac-4757-9328-c34660a27eb2@baylibre.com>

On Fri Feb 27, 2026 at 10:08 AM CST, David Lechner wrote:
> On 2/27/26 12:14 AM, Ethan Tidmore wrote:
>> Use guard() instead of manual locking to simplify code.
>>=20
>> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
>> ---
>
>
>> @@ -352,13 +344,8 @@ static int __admv8818_read_hpf_freq(struct admv8818=
_state *st, u64 *hpf_freq)
>> =20
>>  static int admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_f=
req)
>>  {
>> -	int ret;
>> -
>> -	mutex_lock(&st->lock);
>> -	ret =3D __admv8818_read_hpf_freq(st, hpf_freq);
>> -	mutex_unlock(&st->lock);
>> -
>> -	return ret;
>> +	guard(mutex)(&st->lock);
>> +	return __admv8818_read_hpf_freq(st, hpf_freq);
>>  }
>
> admv8818_read_hpf_freq() is the only caller of __admv8818_read_hpf_freq()
> so we can drop the wrapper, move the guard to __admv8818_read_hpf_freq()
> and rename it to admv8818_read_hpf_freq().
>
> I didn't check all functions, but might be others places where we can do
> this as well.

So this can be easily done with a few wrappers but these two functions
have this odd scenario:

	guard(mutex)(&st->lock);

	ret =3D __admv8818_hpf_select(st, hpf_corner_target);
	if (ret)
		return ret;

	return __admv8818_lpf_select(st, lpf_corner_target);

Where if I deleted that guard() and just made those hold the lock
separately this would be a behaviour change. Wondering if there was a
nice way to get around this?

Thanks,

ET
