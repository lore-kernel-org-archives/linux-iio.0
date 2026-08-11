Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB39401A16
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483799; cv=none; b=klP948f2XbjQYN76ygC+bHw2pnI0s38QqzuBUTFMQQqhzdbjKAY3lnZ2vEgGz/jUBTltGMkLm9ELhO5kaq5saGLjqiN9XLqcRl7eLkUnkUbUM6P5SuaZXCEHcTN+DaNx5a6brM4XumKTo0l5C7b+zHyUNPF5PsSOCswp/mGr1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483799; c=relaxed/simple;
	bh=HtViY9Wu7iXmFgYNEtxZ70DL5CR7SJwt2n8TIpoymA4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ZKEMCf3vebJhr+GfPCxOZoXozo6tf79Ry8+WrVwINM2OQIkdagi7mRCVZtmp38YWSfts6fJw1z8EB6I0Z8Gqn9ONCfMM35alch3Wi0G07a09/9XdVsZlCGBdu91fIWP/iiBWhlgZ/UAxhMCCkTAJmepWHyZLUqckNSr/wUt1jAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWCxW0S0; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWCxW0S0"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bf94664327so125361e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786483797; x=1787088597; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+Z0LPzjSkEFAa4Rs2HSCwHSd8eZwKugfFLQ5+qI5zho=;
        b=KWCxW0S0B5phcBhE5ZazdNXpb3iMFGs1IVNA7IaXS4qN6DHn1i/ibCMiMiof+BB201
         AYccAXkFAFptbLbyH8XaxjU+pV/tEMv2G9LUf42caZO6lt1TtNeh6rCmiFH8cjwPyANj
         UPbkjxO781Kv/FzftDyFyPtDNQGghL47Ou89WubnLOheyQ4Rc3eO2K0QAEs01HCf+mEL
         rYCEWiOQbfQ9ez7itsihuRzBt65N6ssp3r52tig+RjGEVYYuxH1yB5r6cIaOPWj/JZG8
         4z0Jwxkkb2hu4z6E9fzfeRlcXYbubScBxHuACWJrmPUf/vgGyK7yqHibR9LftD04rD3K
         EkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483797; x=1787088597;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Z0LPzjSkEFAa4Rs2HSCwHSd8eZwKugfFLQ5+qI5zho=;
        b=px+FbgoTP8nJT5AxsJKgg3U0G7n2kgexyP5wwX9Wk/HF4Q/eBahdQMDlMnEutN5zqj
         5ORHXC6eztO5lwS17GGHia8teP3DVgSCSVrvxDCTWQYw84vdbIe8vpwCzXEfMMcleSOt
         o6SWPp8VaL2W31m/AKkp/XDXGITzvh/vDHrD1iwcSXsnmhJKvI9ajDnpGCAUqjaa2HE+
         bRoUqVam/BfUCzoQ47W3oacOAQfR43g+5vOas1rXMO05TbMCuEPIfu4M0fJKDXd4PuSj
         7KO8g8Zie1wQWtC8HXM4ztrl03kbl14FX4R7TGbpnCyZXq4tbXHs7fQc+0zC3ziCEg7e
         /ylw==
X-Forwarded-Encrypted: i=1; AHgh+Rqa1w3NLg47+E3d4BjKOBq1p970nuBZ74uhXgngvhvph6XrKHGE2rgy+PCBnNRwDToN3NaHO7fKZGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8fxkpMSK/l9xC4XcB1Sy+J+TQg1S0v4s3kuadrDndSvnRlDM
	sD6A+tgkIYSv6TuaHDcQLUtccetCvX7M/Tmxe2G80P8jwGpjJ7VfnTYV6PYPoA==
X-Gm-Gg: AR+sD13zjQ0SBLb0e4EutSnc1oaFZvMrZWDj0Kulj5a68hkWeD69olgzq9Zgl/W8DBg
	oLxrnZoa46U/JztkUKInhI9dID66biwQaa0bS9bmKU5J+mY2QVYZesESmyGmfM+YRIxNKKZfpxv
	N01UPAS+Yb1eUNKW7RfefwkGQsSc816dpSxLmsnRBjDGAW5/hWNZuZ660eEJA9NZ6f15rr73uS6
	Z8zPUrQ/3bpIWr0uloFjrrAoeXekB9VzWvWS7G/9Puv7+vAjVyBX1+eTfrZ0RCKgr+961293lRC
	oycWzpf2EyFSVuSm7Z5diJguRhWDyjiH/PC4M2jgOENKrW1NqvJSlYkE8uGAxTWth+0sKkbVZEL
	YoUO7j1fw0qGeHHqLIzLS7FXH8gnYhfMCgDhF+w8HhVkjW+6P3satu4r2W9OQA25eVIcE3+tD2z
	DzBCz11Vd/VnN++o07srK5eKgi3q2dnuDSo8AUi0k/2XODQUxIcb/y
X-Received: by 2002:a05:6122:134a:b0:5ab:26f:49e3 with SMTP id 71dfb90a1353d-5c501f4f871mr4423e0c.3.1786483796965;
        Tue, 11 Aug 2026 14:29:56 -0700 (PDT)
Received: from localhost ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c45b74e7ebsm520373e0c.14.2026.08.11.14.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 14:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 16:29:53 -0500
Message-Id: <DKMFNGU0U0GN.2D5Q6K2XV8VJ5@gmail.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Bartosz Golaszewski" <brgl@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, "Jonathan Cameron" <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-1-f89925d72792@gmail.com>
 <CAMRc=Mf9Z5UMyt9bZP5b86mK0cWnbO=oxoR4iu+0f_YwZ-2CyA@mail.gmail.com>
In-Reply-To: <CAMRc=Mf9Z5UMyt9bZP5b86mK0cWnbO=oxoR4iu+0f_YwZ-2CyA@mail.gmail.com>

On Mon Aug 10, 2026 at 3:46 AM -05, Bartosz Golaszewski wrote:
> On Sat, 8 Aug 2026 05:58:23 +0200, Kurt Borja <kuurtb@gmail.com> said:
>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>> integrated PGA, internal reference, excitation and burn-out current
>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>
>> Each can configure its own voltage reference source, the two excitation
>> current sources (IDAC), plus input and excitation channels rotation for
>> offset and IDAC mismatch cancellation. This lets the device drive and
>> ratiometrically measure RTDs and other resistive sensors.
>>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>
> ...
>
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +
>> +  gpio-controller: true
>> +
>
> Where is the gpio-controller functionality in this series? I don't see th=
e
> driver providing any GPIO chip.
>
> Bart

Hi Bart,

The chip does have GPIO controller capabilities that are not yet
implemented in the driver. I'll go for it after this series. I don't
know why b4's --auto-to-cc is picking up the GPIO list. I'll drop it
until I actually implement the feature.

This chip is compatible with gpio_regmap but it would need (*request)
and (*free) callbacks for it to work properly, as this chip doesn't have
pinctrl. My plan was to extend these callbacks to gpio_regmap_config.
What do you think of this?

--=20
Thanks,
 ~ Kurt
