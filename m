Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B42749C1
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783784730; cv=none; b=tk9k5yA0dsr1F+cyqejz+bHWOARqTvV3VWpReuACEmr1UURsqeHRzk1IDtDSsKmYFPfbQSU891lgj2+FqE7Rrglei+opq9TRin3tO+OJQd6gvJwN9Q9BKBdUqhLCqb+sbxnUaL8d/JnD1isDuRf15cFdmdMYU8Zspnbz8m4OSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783784730; c=relaxed/simple;
	bh=kV151LtJ64etiwizmlKM/pdrH80JqisF+YGDBiPuocI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2PabzjUkciB51l3xMY9Wx4YusFPlov1zO90Hgs5I980pzd5rZ9K+t1+1aW5yjI5oTmxjA2omcKNpfFjNf0m8e7exSXMZYB9yNw6UFRxaN1Ci7cWZT1Ztjbs5gajVNsKEDRkyVJz+uF7JKSdNYZHwFldrg+TouKyTZtsyeFuf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HYtwWUwr; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HYtwWUwr"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1518909a34.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783784728; x=1784389528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nKBMbG0MqSCNHvRv0a1DtUb3V5ZdgxWmxrj85GMv8k=;
        b=HYtwWUwrfwj5Bhj9YtZL0B6krxxydiVEA0LlzMHJnrkX/DUZg4BPE/l3iutVQzttSh
         H/eJmCKGuFJBH4xwNXdlc6JDN+wtJ3S8N1qIYITvcqn5h6oa8CVELFrLllKWenaINvxF
         gTczmZdhOibTxaBoc91fwTatFfKwDBB++HaD2KBJk+ZGm/qDymt8mQvLfYxyKdlaI1PU
         6LbyA1bLAGTveUx8+27ax8/JfQJrATqdP/eXHT5vFDY+dUpSdw5lmah1arfG5mMoE6f7
         NBMEI3ZXaRjG11HPPEFgHk+N1LHslns8hFzIzL4VXQRzFnK51KKhBcv7D19ogXU3PuCD
         +oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783784728; x=1784389528;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4nKBMbG0MqSCNHvRv0a1DtUb3V5ZdgxWmxrj85GMv8k=;
        b=l+E1D93YXTF5O/m81KmPZl5Vqiy5KNcOIZW4JLqLfo1v1+9xJOft8JKfHp0d9dpKO/
         CZeYu61Vl+MreY1Uy3Qmlktb7Pjy9erODU48JYT7Q2DFK3rf39Q28Y208CfgQvoSQhZ3
         R4Z0SwVhBloQ4ONK11DImlgUCKjUCuJ56qZsSp5ffOzV2iwd1Y0FAir/XLfWYDiTZFR5
         R6cQ2sduiMjjGu9Aw6S8NZ6a6dHRWzeUhzjrCbbwas+Kb/nwHP8dqTAAl/tUn4IlcMAE
         3CyN5lDdCgZjFivq4v8xW8E5CxZdJHE6zuDVkPHzBWe2H8aIwBMesumuEjJvRGD1sMB4
         lutw==
X-Forwarded-Encrypted: i=1; AFNElJ8abXBFIjVj+rh3CjF1DAiyjVquKAh5Fx1T52bpJUp/fODzhxW1gMG+Cw+Crrbibax6kX2lDzWpLc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkrudHTrPCljokl42jwco7cygFB7NM9kXMhgrjSf5ErnSwpoL
	QBlKrK2wxKhlCYfvAtZ91PEFkz6VilhPXRdXsuZocCfYS/I2J2o4iZALAgFm40Vv8o8=
X-Gm-Gg: AfdE7cmROjwUNpsDljzsgHBuansnjZP7MDBant8+6UnvPeckoTr2EurfuhWXwRKn7wr
	H9U2PMH7Xb26m5750i0wOJ7orAFWLHhDqmxoWoNwVd3liqX9shbgRahjDv69TTGbrFESASHiFlN
	2jj7nfVBJIz7z5k6q9iJIdm+CSHyXR9eNOu0/BPeEgZQHGNYYZzp2yB1IOuDQTZaRZ1qNAeBbh9
	r5G3ZXx8YVFPJdwGXozscR9bNO1zmwwdNnCEx+57mjKedQ2DkiZFnQTFN823GY396/7mM+0UG2p
	Tr1/gBDx+12nFIMof2HGZyb8Wcmxk6ZNFeog1OhoJkuhZdBeGz4x0E6Jz2qV+n80Q5cyVRW99ad
	oscz5VR9qjjp2pQQPxC5BASbNgJRuM7l0m+L+rDO9DTVo2VionFCeNcyxE6VrPrY8D/khN8xDej
	ajJ0ltWVfrMHJYmE4n2s4krLP6VcSiW1U/zArASNS2Qa74DcApGGvF1czvC0RX5/8=
X-Received: by 2002:a05:6820:210a:b0:6a3:7ea5:a678 with SMTP id 006d021491bc7-6a39a6ab3c7mr1927906eaf.43.1783784727749;
        Sat, 11 Jul 2026 08:45:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcafda2ffsm8855734a34.12.2026.07.11.08.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:45:26 -0700 (PDT)
Message-ID: <a7305b57-c39f-44e9-abdc-50a0a5f2fd16@baylibre.com>
Date: Sat, 11 Jul 2026 10:45:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and
 similar ADCs
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 julianbraha@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1783629101.git.marcelo.schmitt@analog.com>
 <965e5a31bf10cb49b53f7351266eeed55e8f6bd5.1783629101.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <965e5a31bf10cb49b53f7351266eeed55e8f6bd5.1783629101.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 3:49 PM, Marcelo Schmitt wrote:
> Support for LTC2378-20 and similar analog-to-digital converters.
> 

...

> +static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
> +{
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	/* Cause a rising edge of CNV to initiate a new ADC conversion */
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);

Wouldn't mind a comment here explaining where 4 comes from.

> +	fsleep(4);
> +	ret = spi_sync_transfer(st->spi, &st->xfer, 1);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +
> +	return ret;
> +}
> +
