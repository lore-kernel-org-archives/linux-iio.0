Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6E32E151
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377565; cv=none; b=nn+Z2p1UgwdRKEqCIGk0G9n6YFcuJHC6CZ2Yz3P7QNj599emVnSzmb0nZPEhpsehTvIcvKr3s4qHayEshOJtr5bcCLyHZB+SR5q1CpLhwh8lHkQ6GEVuLkV0XUoxu/w/AatRbk3Iwenl1j4AR9Rw4o07wfKxWYiHkAY7G1rLcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377565; c=relaxed/simple;
	bh=+y9BmG5ECYGZ7PTxJcCnYcGfDIEGHs+9VHyg7Z1lJ+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fROcg6E0Ywj3J1PpiqzNT2WxuXN+smROwEOm5Vm0fIGB9OspKbM7DAvDJmg1Doza5nW5OuVK+qchyIpbHTllII+oV2/NZsmXbwOtuGQ2PNylqAdkxGiLZZZRLlcAPu8z1WkEk+s4X24RAf0PHcosYq4Z1O5Ms9knaPbJBU1iQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DfB2/MeI; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DfB2/MeI"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b190cdc9feso1257334b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786377562; x=1786982362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2tmRYBxMWUfk/nrkAvGvFxCo8PUNTkvQH/ufUyuPgMg=;
        b=DfB2/MeIkLcQwHHUy5u5EEOnfMwx+qcbV3zrr3kjHI4FvcJ5Lf8Z5rvoF6eWZzDpLa
         4z6t2uegpGufLUi4xHjdtXv0mwjXu0+D01f/zr75pgzVU4I4SNHjQ9MU5shkQEDXmziu
         VTE6MBb4txQPW2fKZublAsParTIYBVsXJcZf4iPao9haUf2D+VE4BL59GUAV1Ssm09Gk
         MB1aNkELKEMLa3SPCD5IOVLbYJ1smRE9OaN+IBZxFcJce8G7SRZ4imL0iKrSXgNlZ8aV
         LoxzE7xmKOtdO+bE4o6tCl9wwM58Wkb8H8n54O4lkCZkHzy2gW8l55CFD3pDQCd2UGjY
         HUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377562; x=1786982362;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tmRYBxMWUfk/nrkAvGvFxCo8PUNTkvQH/ufUyuPgMg=;
        b=M9TaPt9rjlAvhBE8u8BZB0u3wUO04cDOdpo41feRIn/XpmscGEC+bXmew6N4wHxLG8
         CL2gggg5VXSP1hn7Tv46VQk9ZT3KYmuE73kQsSsFKo5RqHRkXR2sOaZwvz9j/i2F3QEm
         24nzvyQVgHTcYgHMF2eQGhaAYtKi1xlXyJo7RRaDu12Slavz0FvqS8u7o3mP5proprL0
         jxmcg3gnZIBbIQm9EvQMgUHpK+NiuKO51e8HpbPlZ+3cK5eR5CceIIzHIPd+PpYvIa2C
         sgb/fdyfgx2NrwVeZnH3iryYNFksdyBUvLdiEoUfj4vop/vZOfAI6NjqF5hcBTrG0r5c
         b1/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpk969+l2aIHr7N7hY4aur/TjpgB3YK/pLZg1FvKI5WZp9UBBTAMkrVuQ0XAD3w0xg4Id5yRqH4L6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4s4WJzLNpvNe2NLMiSliLKussA0cPhkRDMGGjnu9Nx++JieR
	LWdaHeMJu3tm3asoEpmHmk6P4lHn5VEBrs8gxsNf/4nprgrGG75MHT2jhB+gIP5iqAo=
X-Gm-Gg: AR+sD11x7vgETq5iShENixbNUnTXmFCy9tkoBsupH/R4CVu/JYung0FlgjRT21BtTr7
	JrkzD7/C+JxNoKUtScwkVdu4Lnx18C64ob28xUz55v64Ov62TV6JUgqY/BZYGKENLSmXD7sBx8T
	tP97rqAwHORO1XMI1euFW1p+c+xOBMEmUjE3zIwA6N+ozJKQ1ymqxFZQ9T/QF6LUMEQ80rXAC/5
	Fie6tV3QzouuShWTzD1JRRMyF/JqZY9eclcsyPjC6xjm9OOzg8M10wOKPPvBCgT2+JF9wG5CTuc
	Lq73EomRoXKbN904BTdcQUAqeBM9cXb5bKUlMoF3uaTmltwgO6iI8hSWHiZ8Vt28YeiTrKV7d/l
	F8f5qwyRdeWTyNBkZgqhBiC+Ux6srAKXspu7YCkzsjs8qE7jwuTmCZhYXoJeFVF18lMghFL2Odz
	lIdvuNxB3O6XnkgKvdqCZWaOVLXax0pUowaeA9AKIiVRW37Rw3lDO8+tkgy40JFYhGXNOKOvC7n
	AvGx5wxMwo9cQ/samfNj+up/KpDMNBjAss7VpZ31nDazuVJ93k=
X-Received: by 2002:a05:6808:c40a:b0:495:e1b6:2c5 with SMTP id 5614622812f47-4afadd36ea4mr23140067b6e.1.1786377562035;
        Mon, 10 Aug 2026 08:59:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e05b:7923:cf50:e4cf? ([2600:8803:e7e4:500:e05b:7923:cf50:e4cf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1aeda740csm6801267b6e.0.2026.08.10.08.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 08:59:21 -0700 (PDT)
Message-ID: <9caea0d2-3fad-4a47-a437-096c269938d5@baylibre.com>
Date: Mon, 10 Aug 2026 10:59:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] iio: adc: ti-ads112c14: add DRDY interrupt support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
 <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-1-76e0d30e6c6b@baylibre.com>
 <anmQw2X2-CjzSMko@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <anmQw2X2-CjzSMko@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 3:50 AM, Andy Shevchenko wrote:
> On Fri, Aug 07, 2026 at 04:19:46PM -0500, David Lechner (TI) wrote:
>> Add handling for the DRDY interrupt to wait for data ready events rather
>> than polling (only when it is wired up).
> 
> ...
> 
>> +static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *indio_dev = private;
>> +	struct ads112c14_data *data = iio_priv(indio_dev);
> 
> I have seen some discussion about this, but what's the problem with the
> 
> 	struct ads112c14_data *data = iio_priv(private);
> 
> ?

indio_dev gets used in a later patch, so point is to avoid churn.

> 
>> +	complete(&data->drdy_completion);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> ...
> 
>> +	if (device_property_present(dev, "interrupts")) {
> 
> Unfortunately this is no-go for ACPI-enabled systems.
> On ACPI we expect to have 'interrupt-names' but 'interrupts' is OF-only.

So device_property_present(dev, "interrupt-names") is OK?

> 
>> +		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
>> +		if (data->drdy_irq < 0)
>> +			return dev_err_probe(dev, data->drdy_irq,
>> +					     "failed to get drdy interrupt\n");
>> +
