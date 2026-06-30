Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9036F439
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839929; cv=none; b=fl2DrnxUDzVXZryiRySzX9oSt2b4JpIVtJNbwz18IqTj7fNHl8C4Jr8wTkBDUal8XDz++CC4kNq5nREDiSIy/WEr+SIglvrjSw0wZed6VC23hw9ZRxdTQEUP2w9iltuwm0ynm8gkEKv0La4VM+/bWp2Zgc/0UDQcS0qz9zj+nGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839929; c=relaxed/simple;
	bh=UHiNQkDHv8wjlhA0ze6zoBrzWqVkQOHL2jhXocdMtvM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tCUaZBinhvJ9I61YzHyVg6kHWl4oPTchQsBIzlaewMaCO/GDD2i2pNyo8pNU8OjbLV5eKwSmChDqHQrP8zk4JIG7ySQ/MpHu4fm1ngKhaBAJ881GbRXiV6VilIhAZrycw/3gK26kz9Yk799ZH/GS7Z0tPK5V9fLwvESY6Jur8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIpk6KfC; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIpk6KfC"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so3381171e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782839926; x=1783444726; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=et+bMtuvqXMHROGP40ev+0eIWN1zPUfHGM72srmr7dY=;
        b=nIpk6KfC8qoA4500PLSRdvczfmesN3j9Ptoyu/PB+907pX78ROeF/XsM2fdpfmhmEc
         IOECccQmcPaq7xQEq5PU/85542e7d9Or0mDMd6vJX4c3fB44HDIFcN1zZo0+YgqvZCn8
         iMLQy9k/Z1AmXpUhv6Avca9Ej+SoPuncQtDCPyDNlkzWf60yGsaGNOvow0lbC4tlAVLu
         KZ+ImmGe99hJxCipPe/SkvIkZTbbWwhSbjXTunc6hbIYBEUoX2IAwUGIHVQQvzdKuza4
         jXazOpTwAZ7y7hXXiFBhT32yoJhfjt76pAOegVQlpEW+IXckZux9Q9JsKpbBhis6o0id
         ymHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782839926; x=1783444726;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=et+bMtuvqXMHROGP40ev+0eIWN1zPUfHGM72srmr7dY=;
        b=GT2dv0Z1tI4Dhlz9S5Sa1s4P/DcXar1HhvSbJ8AXpzECRajtUeaFnSQFxAij0kclhj
         4PARRzW9M0okCD4ZsFVoF3VhX7O1nUZPtzL0KBXpeJkWQjuGzRQJ0Ug9/7loDqIk41xF
         bT+fcgdYW4Wu+yPgi8koCYMsZvpqHXg18wExpXF8gGBoy/Zr9YjUbv9mXOoYMbZEFZbO
         H692EulbVD7WZeK9GkAwnR5EREfyYlvk05mFmG7dP9sA75C0VjPLWxmYDpATqcJ5rpaI
         B+tqPwPYjkdHdFsV+Uu/IIB0gPzhby0O/4YvtKjAb7jPZ+C0wjjN65S2vDSi8WF4e3CL
         1FJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmW3iJOxAw0o+0TkA+IcWBU7pO2kuSqMZvUYz0Yackfbx5IQc/OdMo3+HunRqSclUbMe+sC/417pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bzp6f39Lw12YXRP5VECLYEoILswTKiAoVnH/Lq2Ecu7ha6QN
	IzlizQmATv0/vo3kjBVFt/jo79cJCdFz1LTVM65jlqjKI/MWmoTi5xHk
X-Gm-Gg: AfdE7ckJRF2d4LLwKiq6T/ZxKXPLzxCwxmtzxf+0KM7zV+oaD/tnlfzTroExPH2x1m9
	oehEHqeBus36g4upu4UCQiF9FJfQGQsbrm+90itQ1vjgZxfqLC+VPD4uvOMO9eQQItfyLpORmiH
	TIYEFTRHYV5eAKktyVvDa/E80Otd5LKkHFXe0uOcSsKGtrnxG47TzRIGMfDS3WSFQHrJicYA1Cf
	g0E5aZsyrB2Y+LYxvDl21MWVio/TOYs7g7XXpGUsl5994ARYWRIKaYyLWPYtplN2xPIGdT8mF9N
	wd4N4mVFfi/Y5/2TbrK0UQNfXmloF4Kh/UXnJpMgHTfrRZTgDE/xbz0X5ihTN5ZLnfT6t/caJ/H
	w17Esz5N+MpETB3Ss72RSR2BUT9KxMbLM4XRjUn13gD9uBNihDWdl+IyHoSgB+y9aflK2l5lv6U
	YFaoY=
X-Received: by 2002:a05:6122:488f:b0:5bd:73b5:6d2b with SMTP id 71dfb90a1353d-5bdcf383d61mr998917e0c.8.1782839926387;
        Tue, 30 Jun 2026 10:18:46 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bdc1846eb0sm1763358e0c.4.2026.06.30.10.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 10:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 12:18:38 -0500
Message-Id: <DJMK080GOMNP.1K9VX4CMRQKL4@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iio: adc: ti-ads1262: Add excitation current
 support
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-4-4b1b231325ba@gmail.com>
 <20260630014723.786a8885@jic23-huawei>
In-Reply-To: <20260630014723.786a8885@jic23-huawei>

On Mon Jun 29, 2026 at 7:47 PM -05, Jonathan Cameron wrote:
> On Sun, 28 Jun 2026 00:36:05 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Support the two IDAC excitation current sources. Each channel can route
>> its IDAC1/IDAC2 outputs to a pin via the "excitation-channels" property
>> and select a magnitude via "excitation-current-nanoamp".
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/iio/adc/ti-ads1262.c | 78 +++++++++++++++++++++++++++++++++++++=
+++++--
>>  1 file changed, 76 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
>> index ece97a0c2b1304ad..8921eaae537f6b0a 100644
>> --- a/drivers/iio/adc/ti-ads1262.c
>> +++ b/drivers/iio/adc/ti-ads1262.c
>> @@ -193,6 +193,22 @@ enum {
>>  	ADS1262_INPMUX_LAST
>>  };
>> =20
>> +enum {
>> +	ADS1262_IDACMUX_AIN0,
>> +	ADS1262_IDACMUX_AIN1,
>> +	ADS1262_IDACMUX_AIN2,
>> +	ADS1262_IDACMUX_AIN3,
>> +	ADS1262_IDACMUX_AIN4,
>> +	ADS1262_IDACMUX_AIN5,
>> +	ADS1262_IDACMUX_AIN6,
>> +	ADS1262_IDACMUX_AIN7,
>> +	ADS1262_IDACMUX_AIN8,
>> +	ADS1262_IDACMUX_AIN9,
>> +	ADS1262_IDACMUX_AINCOM,
>> +	ADS1262_IDACMUX_NO_CONN,
>> +	ADS1262_IDACMUX_LAST
>
> _LAST usually means inclusive. So probably call this NUM or something lik=
e that
> to show that it should be one more than last value.
>
>> +};
>
>> @@ -450,7 +468,7 @@ static int ads1262_dev_read_by_cmd(struct ads1262 *s=
t, u8 cmd, __be32 *val)
>>  static int ads1262_channel_enable(struct ads1262 *st,
>>  				  struct ads1262_channel *chan)
>>  {
>> -	u8 mode0, mode1, mode2, inpmux, refmux;
>> +	u8 mode0, mode1, mode2, inpmux, idacmux, idacmag, refmux;
>>  	int ret;
>> =20
>>  	/* Avoid using guard() here to mitigate AB/BA deadlock warning */
>> @@ -464,6 +482,10 @@ static int ads1262_channel_enable(struct ads1262 *s=
t,
>>  		FIELD_PREP(ADS1262_MODE2_BYPASS_MASK, chan->pga_bypass);
>>  	inpmux =3D FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, chan->input[1]) |
>>  		 FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, chan->input[0]);
>> +	idacmux =3D FIELD_PREP(ADS1262_IDACMUX_MUX1_MASK, chan->idac_mux[0]) |
>> +		  FIELD_PREP(ADS1262_IDACMUX_MUX2_MASK, chan->idac_mux[1]);
>> +	idacmag =3D FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, chan->idac_mag[0]) |
>> +		  FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, chan->idac_mag[1]);
>
> This presumably feeds into the discussion of locking that you were having
> with David, but I'd find this a lot easier to read if these were just
> above where the values are used. Then we can clearly see the match betwee=
n
> masks and fields.  If you have to do it like this, then add variables up
> here for the masks as well.

I'll move them above each regmap calls after reorganizing the locking
stuff.

>
>
>>  	refmux =3D FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->reference[1]) |
>>  		 FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->reference[0]);
>>  	mutex_unlock(&st->chan_lock);

--=20
Thanks,
 ~ Kurt
