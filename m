Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094944DB69
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517078; cv=none; b=Wt6frjriNwdVhcaLxe7FHoUf470dhpHoMBYjI/9l15UQ77W22IckT+3BUe3mSGn+w0Uz3TDuwQJolnLcWoXgbY8rlDVsszdKvoRyYWkBDyg2eQ+yQTxzX0/4NdHPPdFo/9/IgpSgYDA7yG4BIB91JcAvzMRyTsBukV9b5utuvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517078; c=relaxed/simple;
	bh=IIU8wUeI0jxb5eXBdhbsfaDmibH8CEW4NJmO2Li21A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4rNyo4+3GxJCJAOd7NBbgCRKYf5Oe8QW4Ji8UR8pzI6Ry2n3Na6EdrNSjBPReN3Dg1uGzn8bm3kSvEMeo45cIfGcDD2lzKCoGq/cHY5qu34iZKU0AfIT50DHB5JbxIe2asmYIF9r5Gz9IQQkKTFK2fNpBP9A9qPV2+LGdXvJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=HtNQXA+F; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HtNQXA+F"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so3558313fac.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778517076; x=1779121876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EM/LUQ0z5ULIMOKs55kf8JAOorhzQl2aX18pg5yn5XQ=;
        b=HtNQXA+Fd+oMYulYia/J89/TYMJzXVgqIacHucQUi92FfqpG7GHLxHqv4pOuHspCYj
         K4BixEYYBdXYCUe1/qkZGdySdaDLB8SyhIHcBe4boJ0RVULrV855cMmv3Yrsb/DKSF27
         IhqE6mKNkjnuSHs4BkOGUokvqFh1EMiCDwK0FREQt4O8jkKiRRkuvL1hmDmfNY+qmuVz
         4V24EkbnFoy1peSh363VnhN8wZC0zrDDWv4mkJ6ktB0F15f3QC6Qy8lnVGwZU8PUC19f
         MQwqMszkSKfeyj+ECC3elhNrrlZyrcAd90nDX7NXPgfaD8yzTmbKwcsVtw8f57qKIog2
         eA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517076; x=1779121876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EM/LUQ0z5ULIMOKs55kf8JAOorhzQl2aX18pg5yn5XQ=;
        b=BA8cQgIGEhaoCZUIKnZhRNYDSWAK+ck77JzsyuGi+rVV63J7YzZEc2GMB00zwWHKT4
         7RwQUdNmHUj+m5cKrfYRioYz5FS7SuUnmIGU95BnApxbLaXybjikwv2h6CBJRPGpMy4x
         BbUECYxRJMjpLDQjg6ktKziaPOLUlDBQHfnP5S+G8Fc+0WTHY5XvxG5Axsl/j6G4dwxc
         UyRmGJ6wcWgqxx53miSLvbDtZMWh/wU/etBWRQXVwTziHp4WGputdVKg68Ot1IDd57rg
         RgXoTX6PCNhRBuy6JsXMk8QO8Yuxz1x6FVlnBmR04UqW/cGqNur/HpmkmqOnkh0cXCOp
         Ktdg==
X-Forwarded-Encrypted: i=1; AFNElJ9yVmUkNobO9dlpM++y73P9p7c7V6JMNPMkkFaA6oFSQWhLH/NMQfp5OK8o6AK5FjvjHrF0yCZAL9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YymLyYJ0d7yL/oXhArtwgDeyb7LJ1d5lGoW6nnz6oc6kNR3e6s+
	Drp56+ATP7zKLzOw54pcSfKdDPjY3VsKCW3cl4AQSSLsmBI/O8bySSq3HohG3K9y6dQ=
X-Gm-Gg: Acq92OGzB2IEPv8wbZlCYSkyRGgk8MEubInYeIDBeusT7riTWu3TKY6F2fx1Z6U+tHz
	qbY9gejVyZlWViwrA1X3PWWjMDBi2E9rNsm3NX9cazFD4J7n+yglyv9dEaMuCYPiJ4aTqdWvdjj
	vhCPS/oJEz/gfiQuSOtWW537yvtBVWxAshMzl6vZal1CeZZfxMbAaZeyKdCvv6vRZK5bzTqYLuJ
	Vnbarj/R9EfrsHV6X5iBjOk+A/vMhmq48Ga6vmqhzC9trUKI1y8ZYI3UWPVtopvo9h4DiXdgaXt
	YbZWK+xPU2mYoBnW5fgG+hwIiCaqa7lTldUS2/9mvX07Q7UD0rbERnzXR8qNK8+u43zApj2qX+k
	vjjGJlY5BpLAqEqEceNjskxDiOXH9oSs68TZM/DfHw077Q63GS+yDq9JNn8mmkFJvTmVKz+NpzO
	20sasQp6CSp2oHhjqo/6l3O3rwyZR0eIIXj8OQVVqnfbdt0D2g1HDAlwNObcAvgr7XRQCuwMQ=
X-Received: by 2002:a05:6870:242:b0:430:2b69:8e9a with SMTP id 586e51a60fabf-43556b27e81mr8020446fac.5.1778517074483;
        Mon, 11 May 2026 09:31:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:591:4577:3439:3a1e? ([2600:8803:e7e4:500:591:4577:3439:3a1e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435570ad8f4sm10106250fac.4.2026.05.11.09.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:31:13 -0700 (PDT)
Message-ID: <f9469c48-ea67-4106-a577-4818cf3dd51d@baylibre.com>
Date: Mon, 11 May 2026 11:31:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818
 binding
To: Denny Lin <dennylin0707@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260509022718.82957-1-dennylin0707@gmail.com>
 <20260509022718.82957-2-dennylin0707@gmail.com>
 <f6e2a4de-4c1d-46ef-b383-db62091fd0f4@baylibre.com>
 <CAGEkeHfeZWi99TMvkXHhMSrUS8PshuekqjszBXaS39VsLUZ4eA@mail.gmail.com>
 <3493d6ef-5f02-4eb1-b81a-89597045acbb@baylibre.com>
 <CAGEkeHcA+aJ_h5APbL_bG3vpyY+rSGEVn=Dk1Abe76MKDdyVpg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAGEkeHcA+aJ_h5APbL_bG3vpyY+rSGEVn=Dk1Abe76MKDdyVpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/11/26 11:23 AM, Denny Lin wrote:
> On Mon, May 11, 2026 at 7:51 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Usually, we want to be moving the drivers out of staging when
>> adding the DT bindings so that it all gets reviewed for correctness
>> at the same time.
>>
>> Drivers in staging are usually there because they are doing things
>> that are not actually acceptable for the final stable mainline
>> version of a driver and need more work.
>>
> 
> Thanks for the explanation.
> 
> I took a look at the driver and noticed it still uses the older
> IIO sysfs-based interface rather than the iio_chan_spec + read_raw
> model.
> 
> Would you recommend updating the driver first, or is it okay to
> proceed with the binding separately?
> 
> Thanks,
> Hungyu

ADI's website says that these parts are obsolete, so unless anyone is
actually still using these with a mainline kernel, I would suggest that
we drop the driver rather than spending time fixing it up.

In any case, unless you have the hardware for testing, it would be
best not to make significant changes. There is a non-standard "oti"
attribute that we would need to figure out what to do with. This is
likely why the driver is in staging in the first place.
