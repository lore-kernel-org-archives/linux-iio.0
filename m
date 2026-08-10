Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F53B14AF
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 23:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403375; cv=none; b=imMntdrae1hH0kXfjk80gTm+7IGAkAft+5Slle8In2w1mfNhDC95D3PaSmMWRiLDkVgvO6+4Nge8Sxy2Yl7neoPqkk5QxDs4IOgA2n2iFkvHPdt0rONJFesnwto1/NCk8uCwqsKjaWTnR8X75XjxkJzL6Ooxyr6RsiTGvJ4hEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403375; c=relaxed/simple;
	bh=X71rJPEpNGMX6fN3SCSNqa8xVuuAFnkmXfXpfSjM03A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cF40W5eBQ5/zXnTg//IyMuwia0Yyc98TAigmGG/oSmmPYuPfXoXPS+EkD1btIN5X2kfesGr0bsN0PxHq4yoNa2BNlQNydOyTDWPYpsQeaEpMymTzrkcHfezOj4/UbodwEUC0kXDLcP8O1alhdUANa4zzqDw5dH6W8MFo/CV1mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdH9zU1E; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdH9zU1E"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4980dc26022so24619555e9.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 16:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786403372; x=1787008172; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IcYQ3EWiq+eD/+Q1XDAVHfH1xJiNbgDpsgmEp6vqXP0=;
        b=EdH9zU1EOaoGe1O4/F480a8328WuOi0isbKkVEp6ZkOIC+yWgaialhfrJ9J1mhgCz+
         3ehVVp4/KfBCBct8piMX0Z1Kf/iEPrIfe4gurTK9RlfrG+fZfG5t7XBIWZVCH0IgF6W1
         A85doCB9j8sCPlp0rbr89d6VZixiP2kdyu3bueAaRRwg9FwA65CJ8XppJt+wmyMH86HK
         JJzmIXC3bcfyqoHvi+uCk0WKI7wQvlBj1QPTG7lCSsESBNqXAjDPFE+Wr5WwMMjDU2Ba
         KCorRGcmEFwPHZPoEPkxa6L3XJ/xAlvIi2nzY5rrSpVdXLV5I1J9XJkGdlSBWrZM1cjk
         vKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786403372; x=1787008172;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IcYQ3EWiq+eD/+Q1XDAVHfH1xJiNbgDpsgmEp6vqXP0=;
        b=QB+5RkHN35aH6BkRedfnRikE+0e4KdY7WgZgULih2LQ74xol9myYo4C9wpXLJLfwRB
         w+hMEqOprO7/e1OrIImnBNMpe3qgHv/iJPgFciYGSjU/5OfeLdyveCaG5BXGiaQ31veN
         nsFlJAKtEo9EdlO3whus1lfy2gSMZ4MnkZYbNMRp8eYG7a3UGZj79Q8Hv4g4ZBDQYEwD
         35jaMwhX6PKqNZ1R6sXg0B9ZVAc4Gvb0umtYFXEmE+6aXIBu+HeIoTF9DNLVoRpTeUUl
         bTg4Ky5Et4g9uILXQiZcMcHVYo2WcUen5oln6KZzKqavhddbNmaE5L/jBmfL8UnbHBqA
         enCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqj1EvO4tx/iNtnbbfqqZ0/z58Z28JR4ZsdJvqupH9ntsmjvTXxooIHkV1lsGaU8Rh255DrkHrz3yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5hGWaVSKtgzj0XBvWZjZtn1ZlCR5mujUMHUX1CcpaE1qfSTT
	xNuIUYAJISWuM4lMFui9N8NgJKzygQz8ka+YdRztHfeFSmA5LGcKNY6I
X-Gm-Gg: AR+sD11xw5ylV7sxtvFXQhSGz3cqQCeG3zdnAniLJ2eMjqrZ6Nxxq7lfz0K3HtFnlAc
	smUh2P3h8s2x46QB46HKSXOEmCbADl5Jq01LZKSPVy+ggQedZpZMayDcYvmymK81Ay82gFQssHb
	W4KBkal4FSNMjziahayZFWlTviWimZgmAwzwiN1IQa7bzFjligeSYftgX1igox5Byh8/kfOklQb
	vEJuHaItDyqg+CJbW6s8pTQW/5Qblh5HoSjwhraRJocfreUTPR6Y4wR84NNVSiR9afWPLZhZ8vR
	ObhN/Yn9qIsApMYyNa9alQ1Sihnkgv9IagK4IL5aRXxK4Sn1z/ss8itIYRwoOHjp1/kyldHtasW
	/obWaY0cSVPD0SUoo5dyJdt0rkjrAzZQHTiYimGfgI9XDRnmOFBHVSoivvW6px5y4UgGJarfdo2
	p7D7XfFA5ly5cqvsDXvWVEfjdn6YnvWtD8pQK0Kd71O2gOOL5weSJro+/OQGnrfkhPTc5ZF/2jF
	bs=
X-Received: by 2002:a05:600c:840f:b0:493:a623:d090 with SMTP id 5b1f17b1804b1-49972796db0mr51504395e9.10.1786403372290;
        Mon, 10 Aug 2026 16:09:32 -0700 (PDT)
Received: from localhost ([2001:4bb8:16f:15e0:67a4:d119:6328:800e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e7b34sm37612569f8f.19.2026.08.10.16.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 16:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 01:09:29 +0200
Message-Id: <DKLN56PMUK93.20VF8V664A37X@gmail.com>
Subject: Re: [PATCH v5 4/4] iio: light: veml6031x00: add support for events
 and trigger
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
 <20260807-veml6031x00-v5-4-e60876fb3640@gmail.com>
 <annvIc7WLeWEDCAC@ashevche-desk.local>
In-Reply-To: <annvIc7WLeWEDCAC@ashevche-desk.local>

On Mon Aug 10, 2026 at 5:32 PM CEST, Andy Shevchenko wrote:
> On Fri, Aug 07, 2026 at 03:51:55PM +0200, Javier Carrasco wrote:
>> The device provides a shared interrupt line for to notify events and
>> data ready, which can be used as a trigger. The interrupt line is not a
>> requirement for the device to work. Implement variants for the cases
>> whether the interrupt line is provided or not.
>
> ...
>
...

>> +static int veml6031x00_write_th(struct iio_dev *iio, int val, int val2,=
 int dir)
>> +{
>> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> +	__le16 regval =3D cpu_to_le16(val);
>
> There is no technical need to assign it here, especially if the below
> validation won't pass, but it doesn't have any side effects, so I guess
> it's fine.
>

I will assign it after the val check instead.

>> +	int ret;
>> +
>> +	if (val < 0 || val > U16_MAX || val2)
>> +		return -EINVAL;
>> +
>> +	if (dir =3D=3D IIO_EV_DIR_RISING) {
>> +		ret =3D regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L,
>> +					&regval, sizeof(regval));
>> +		if (ret)
>> +			dev_dbg(regmap_get_device(data->regmap),
>> +				"Failed to set high threshold %d\n", ret);
>> +	} else {
>> +		ret =3D regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
>> +					&regval, sizeof(regval));
>> +		if (ret)
>> +			dev_dbg(regmap_get_device(data->regmap),
>> +				"Failed to set low threshold %d\n", ret);
>> +	}
>> +
>> +	return ret;
>> +}
>
> ...
>
>> +static int veml6031x00_set_interrupt(struct veml6031x00_data *data, boo=
l state)
>> +	__must_hold(&data->irq_lock)
>
> The sparse annotations is fine, but lockdep one is even better.
>

I have seen a few instances in a number of subsystems where both are used
at the same time. What is the preferred alternative here?

>> +{
>> +	int ret;
>> +
>> +	if (state) {
>> +		data->int_users++;
>> +		if (data->int_users > 1)
>> +			return 0;
>> +	} else {
>> +		data->int_users--;
>> +		if (data->int_users > 0)
>> +			return 0;
>> +	}
>> +
>> +	ret =3D regmap_field_write(data->rf.int_en, state);
>> +	if (ret) {
>> +		if (state)
>> +			data->int_users--;
>> +		else
>> +			data->int_users++;
>> +	}
>> +
>> +	return ret;
>> +}
>

Best regards,
Javier
