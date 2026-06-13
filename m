Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6592AD3F
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309187; cv=none; b=eTYgxcCF5zf9CG2oCuTraNtn8XlZz1NrF5tO9+2EUP9hSs402D2wILYhqCnKDpL1OAwu24Zo1YiO4PDQwOcXFx3ttF45z405tmSxThtiVjUnu8RdsG8sE472cioqPYNvkQO0VOktEohHLkNvT+WVFKXa+e0ya0DP5YTSYO6Y3G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309187; c=relaxed/simple;
	bh=6k16D58X5Hp71dTQ2A4hs7CDJxnziA+HOcbHy3F7wYg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h9f4X6PQ4hu2YLCsiQq89Y5AY7aY9PFRWrYy3kUr9+8dqjRvHShsLKKncklaIyU1N05ZHq3/TfeRrE/lFWVxKGccM/D+sxVOgW526yhzcJoNs0dr2hH3fc8VqtH2Rh5ULYbBoMFZrmSVl2Yrwt+mIWncSAyu0B6OOklnSdpQDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW3k9+kn; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW3k9+kn"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59c1bacf871so669069e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 17:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781309184; x=1781913984; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8p1+OVmvemJz2aH/soukQnCPpp6FHT4E6Hl1lAMDXE=;
        b=OW3k9+knR2VedobA1/HIDXu1GO//1Xh1WTGPDqubRSdx0XLDCGjapDzJSqgduyXFSR
         LqmXV3KEnimT17WyfZZX7R9n+SnTI8QowmiYBeiYv4ak9wrlbBKkUmZWfoH6rkQDRnZZ
         DSq7eLbQHcUvxAhXv3JiiQ26sg/EliQtk7ZXopSwuS3hCyoBxHx1cveaUgYCjFI+/bo6
         +HhjVRMvdg+MX4/Iv+uk3ujLVWcD70mfbaa2VTlwnTqAQAav7Psr6TiCTkuEIr6Ai0ED
         IsSlEr8Uw9XNpjZk4ya/IGbOZvxTsyVQQhVlm2QWFCAKFB3vBldEwK2Oi1No3LYHtnyQ
         lugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309184; x=1781913984;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8p1+OVmvemJz2aH/soukQnCPpp6FHT4E6Hl1lAMDXE=;
        b=X5UoJvuuycRBSWAVdfT6RmQ5hGvEVQRj+SeyHIZMm5GQ9BLuo/+/CxjD+33Y5810D/
         eRpFKNW8ctXeeFX2HsKd2qcz7i5WEH6dwusd5nqyWosonZWaovI2nuh6pQDlWK7+nZ7F
         X9QAPVxKKVfHKwZnE1p2037GcIQLQE6/JfUzaeYrHZK9FVjhoBH0UT6G0Jg7P8YSenZM
         61MXocDp7IC7ObgAFGFu0FJEHDehFnZHqaWRzzCwDMSnPvfBt9mQtFuY1qDBWV0gYecw
         2ENF6IULL0lGlRX5WJBYXLrHqRerGbmbwwO4XkoM5t+PBmWHv/RXDd0z9MCcNCIBN/1Y
         OHcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Lc+uD0LDnSFjxekLNCCo1edpSLBnADalxFKYmtfL1P/8PW2J99YJJ0VIszq1UT9lvpd90NL5e2g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQjHji2n34h57XnJqqMckPbOk+ey2EFL8pbDPxBKL4dY0WVoO
	kOFNZU3wuR6ZyM4wMh/cGKKEpCrjR7P8u0FrlsmNPphrBaSCY91bozM/
X-Gm-Gg: Acq92OHY3zsSTW6sauAc7ZnuLhOOaL9JerDefNY9Qgf9BVUKeVVnHlScAVxazVRrdgT
	QnXdeiN6jJDkunWWIJIgQVcT+fEWoa40PEOG4o4WqfQFxpN0DeLIw0I7sFYs53ePzWJc/HbZGuw
	ETblH2voCo5fS0CZG9OGzrHjs0qJkK9mmC0YXei5iJWzxclHYo+RIVsQxeyle3QbqzGGYI+2G4V
	EYj2/fmvnnuuPy26qCvz2N4MhvIh+IyMOdAN3NgahF3QlOw9LP+ZYODr8mOEcddffwVoy0kx8Xq
	elVeon0pD1QTMfZfQA2nyTkDOiMJ0Vn3yEzulS9NCNBnhGLC8F63iFdTwWQbqWX1K884+cXqvS4
	esGS9uj5PelfphgA/E275VhuJFcl9PTyYHMuyhldydLKIUiIZw8K9FdZ9Vok6F4soxPwiho1hlQ
	UQND9LHgEVaJvDiw==
X-Received: by 2002:a05:6122:7d4:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-5bb79a93ec5mr1419591e0c.4.1781309184166;
        Fri, 12 Jun 2026 17:06:24 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb691bb8a4sm4328705e0c.10.2026.06.12.17.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 17:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 19:06:16 -0500
Message-Id: <DJ7HEIO6NRT4.2C1XVYIG81J4D@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 0/5] iio: adc: Add TI ADS126X ADC family support
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <95291df3-c34b-40a4-ba73-813ccd4b9ef8@baylibre.com>
In-Reply-To: <95291df3-c34b-40a4-ba73-813ccd4b9ef8@baylibre.com>

On Fri Jun 12, 2026 at 6:50 PM -05, David Lechner wrote:
> On 6/12/26 5:46 PM, Kurt Borja wrote:
>> Hi all,
>>=20
>> This series introduces support for TI ADS1262 and ADS1263 ADCs [1].
>> These devices are very similar (if not the same), except ADS1263
>> includes a secondary auxiliary ADC.
>>=20
>> The main ADC has quite a few features supported the main driver
>> (ti-ads1262), including:
>>=20
>>   - Power management
>>   - IIO direct and buffer modes
>>   - Channel hot-reloading
>>   - Internal or external oscillator
>>   - Internal or external voltage reference
>>   - Filter configuration
>>   - Sensor bias configuration
>>   - IDAC configuration
>>   - Level-shift voltage configuration
>>   - Manual calibration support
>>   - GPIO controller capabilities
>>=20
>> I plan to add these features to the main driver soon:
>>=20
>>   - SPI offload support (38400 SPS turns out to be too high for some
>>     systems)
>>   - User triggered, automatic calibration (Datasheet 9.4.9)
>>=20
>> Additionally, full support for the (less capable) auxiliary ADC is
>> introduced by the auxiliary ti-ads1263-adc2 driver included in this
>> series.
>>=20
>> The auxiliary ADC operates almost completely independent of the main
>> ADC. The only consideration that has to be taken for interoperability is
>> when reading conversion data in direct mode (Datasheet 9.4.7.1), which
>> happens only in buffer mode, when multiple channels are enabled.
>>=20
>> When reading data in direct mode, all SPI activity is forbidden between
>> the data-ready signal and the data retrieval. To achieve this a second
>> mutex called xfer_lock was introduced to block SPI activity on the
>> device.
>>=20
>> This is one of the biggest drivers I've developed, so I hope the code
>> and the comments are self-explainatory. If not, please let me know so I
>> can clarify them.
>>=20
>> As always, thanks for your reviews and help. Submitting upstream is
>> always a great learning experience :)
>>=20
>> [1] https://www.ti.com/lit/ds/symlink/ads1263.pdf
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>> Kurt Borja (5):
>>       dt-bindings: iio: adc: Add TI ADS126x ADC family
>>       iio: adc: Add ti-ads1262 driver
>>       iio: adc: ti-ads1262: Add GPIO controller support
>>       iio: adc: ti-ads1262: Add calibration support
>>       iio: adc: Add ti-ads1263-adc2 driver
>>=20
>>  .../devicetree/bindings/iio/adc/ti,ads1262.yaml    |  308 +++
>>  .../bindings/iio/adc/ti,ads1263-adc2.yaml          |   49 +
>>  MAINTAINERS                                        |   10 +
>>  drivers/iio/adc/Kconfig                            |   26 +
>>  drivers/iio/adc/Makefile                           |    2 +
>>  drivers/iio/adc/ti-ads1262.c                       | 2180 +++++++++++++=
+++++++
>>  drivers/iio/adc/ti-ads1262.h                       |   39 +
>>  drivers/iio/adc/ti-ads1263-adc2.c                  |  470 +++++
>>  8 files changed, 3084 insertions(+)
>> ---
>> base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
>> change-id: 20251129-ads126x-fb6107505cae
>>=20
>
> Hi Kurt,
>
> I'm currently working on the TI ADS112C14 family of chips which
> are functionally very similar (although have a bit of a different
> register map).
>
> I have some different ideas for the devicetree bindings that I
> think will make it a bit more flexible. Given how similar the
> chips are, I think we will want to align on how we do these (and
> there was one more similar, and thankfully much simpler, TI ADC
> driver submitted this week too!).
>
> So rather that looking at your stuff too closely yet, I will send
> what I have next week and we can compare notes then.

Hi David,

Of course!

Devicetree bindings were a bit of a pain for me. I definitely want to
check your approach, specially on the IDAC stuff. The ADS1262 has many
pin configurations. I even considered a pinctrl driver for it, which
would have taken care of IDAC, biases, etc.

I plan to work on sashiko's feedback this weekend and submit next week.
Won't make huge changes, just fix some rookie mistakes... :/

--=20
Thanks,
 ~ Kurt
