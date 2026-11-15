Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794705773;
	b=s0qggY8AR/Lw5uBq5IwLFwfMEGyzCJLhKQGif+c2lQ984mk5NLQN9XF6Bd34T2oYNgBo
	 ObLNWxPVdHmEIXWtNSYF6fxRknzNkC9dLxjJ6Boj0CSoB/oO+CQFfg9kqWunf7eeVy1AP
	 ZyJ0yDXLpdpL22o6Wg6Wb8vGpsf/a4wDKmjb2lAwB8Oky9Pj9goLlhgYtmZLJf8LCGbb8
	 Vc/mu8xxSY6Z24JPVtEFL7kVpBEnzU0aBBnT9Ss3M1V/GRSDx2eQeQflxlCvQdDTYif0A
	 JXNH/peiIRv09DTbyRNUtdouQrEO0hNtufIPueP8ZeGCl8wzNUvFfhCH3/37eHDemlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dp/67JmcNvmFQHE7Njd0ridip6Zcl0Wn6uMgmcNbwbU=;
	b=g01dcpWyv2t8Ten0CK7dDlcPzYtL6I+Sfwb7rBf+luibsiYP1+EvXM/zBWUmmgmT+6Gq
	 oKrPG3uOetpaHoIBetcg4abobECvZOGD3TJ8bWnipP7RXcbmqzPSuxmQY8xuVlxLdTZQe
	 2uQnQBEYmXoDGDf7Zf7Iodj/zcBojOlWgGqCLM+3H6ewDPE7a1fy56SU0ooPrU4XpzUMh
	 SRVrYX/RUG4Zf4dyN0FytbAKAfKFAD8cQmE5v7Zkh57DrP9wKWB7Yc03KfF3vT5CcgMaR
	 CG6KdzttLmAtyjUcXzY04ephgmG9ZMkClqSJ/iBp3aMX3J3DLySEhsfsnjNvNKFxSkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JXvE48TK;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF3606A32F
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40DF3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JXvE48TK
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so3675098a12.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 17:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794705771; x=1795310571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dp/67JmcNvmFQHE7Njd0ridip6Zcl0Wn6uMgmcNbwbU=;
        b=JXvE48TKiy91S9dvEv9At4IP8YWrv9G85CuWVftuPW0Nm42VDo9KFgSl0Wt6vcS56X
         H/qmdvNli+F431Mg85skwEVk3uZHmXjh03Qi1nriXU+eIVvL33jxebJhCOEYHkhdTzpe
         qqZmE/91d+DfQD6wRraqOOfh+6h/j5NhZExktRhovVugD8/uWjdRZ5edtEdRvQKSbyzS
         f2JkGxlgs18vVYYXWbHFihlv83Ce+ekiPSYHXuNjHYNdv4NqwZegVHcEX7C9VocMT2zZ
         HChWwWqXQwoRrokeuXsOueXT9eKfEoso4m9TOGVYvUa0b1HSABp4Vy3dHtUYsJRq4o7h
         Ty0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794705771; x=1795310571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dp/67JmcNvmFQHE7Njd0ridip6Zcl0Wn6uMgmcNbwbU=;
        b=uLw7O0k9I9BtAPL2BJWA4Y0v4a6Kr5U0otMIM4JqhsNBwgaO1rWrWT0cXb/b2DCwqG
         08Cw06+uApyMg+/vfaECmKEHxRGjljyjuKWNCPQ04ggjA/ts3yyDBrxFr/gC3x8uW+AX
         MNzK2Q2FXXOVylZ6lwLvtDBz8UKlVsHQhCBQ44oiTA8O5u/guf+8zZFzVjnF52D3lr+b
         5ZQqBYGW0PmqglROfNy3EvPMMl4Yd5rSnNLjYqI4yq2Xfs6Fa5Ru3dVfMoTEJ7vM8ET4
         U26oWyYy8lm4tFgmcsdoadAzz60KyZ1JSIL/mnIe0SfFiGJlfEIn4N0klHp5wBORaWtY
         aGnQ==
X-Forwarded-Encrypted: i=1; AL+hErECCsyxNmv3rZE0XKrlKLfIWvvvDBoUHWQcmMTvt0a+HnZGSE2PiKtlI1g5Wsy/wj3Kgz9/GsgZ+Dc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9apEYwzfinhupQ0Fi8lVHq/R/Kb7kg9Zo/fkXxtiNOd5W6riW8
	8SEgQ4F6yL1pPgkqpb/ALGX9d0gyHEDzt3J2xenWKonQlRipOKkJVNY=
X-Gm-Gg: AYBFou02/AQ9tOJ6gRzbZB40W0E0et+4c+joUYg4reaHmwtV5Th408A/FNJe6EZfNVG
	qNBigWafifxCzKrPduip80ensP03hr/KKM6BjytsNukZip0XFdpAo8EPfLBQ2gGD3Ep4DRkdoda
	3DVH4QcRnjcEdRrk550fZwPYo1dcfSlkUFIz9/S4u//Y+eDoTmTckdYg9+nyZBfpiy3ROmFUfJy
	/kAH97NiP/5RND6dyzqc7LeoK3q8qCBzs8I9l61FCZE5GUTQfU0vaDQKcTXyMKZBDvIO16Ypozs
	L/x8297IUf2Ohd4O9J6leJeKI0whW2C0MM+Ac5TEFEV/sVnrQ2sotYRXtuWjcPS/66clmdfPT4V
	vMLCCBrVjNg3VgdNhZL2jsbSb0YAtmcg/LsCtmUToOhlPAvNvLRyeJSZETvb6MTp7XFGVx48XWn
	M0Glfwa65jhDKYbTjX1DXNq6bHSpsJ1akTFbJ3QFSivP/7IxrvNKUj8JYM1JDVEvddO0eIWCAYn
	5LK355omPivhZFjlbhMHbO+W1g/nGExyX//SfRViNMVu6aVU3WW3EnRZKa1O28YTHpAaJIooMAv
	2CVm90cNaVcF1jbmZqJYVdySoPli4kw2suztRJ3XZOIYm2sOrwb1mySTmRh3EYwGDjeIwoxmcsI
	HbrsZHtjEsgJNUQhVtEqk+mTf
X-Received: by 2002:a05:6402:849:b0:6b7:c9d4:6b96 with SMTP id 4fb4d7f45d1cf-6b7c9d47044mr4130497a12.8.1794705771576;
        Sat, 14 Nov 2026 17:22:51 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c6a5924bsm2636697a12.18.2026.11.14.17.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:22:51 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: val@packett.cool
Cc: marc.lainez@gmail.com,
	luca.weiss@fairphone.com,
	barnabas.czeman@mainlining.org,
	danila@jiaxyga.com,
	sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Add driver for Qualcomm QGauge (qcom_qg) fuel gauge
Date: Sun, 15 Nov 2026 02:22:47 +0100
Message-ID: <20261115012247.621144-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112170841.2189322-1-val@packett.cool>
References: <20261112170841.2189322-1-val@packett.cool>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Val,

On Thu, 12 Nov 2026 14:07:26 -0300, Val Packett wrote:
> This series adds a driver for the "qgauge" battery fuel gauge
> present in Qualcomm PMICs like PMI632, PM6150, PM7250B, PM2250.
> The PMI632 is used in SDM632, SM6115/SM4250, SM6125 based phones.

I tried v1 on an SM6125 phone, a Xiaomi Mi A3 (sm6125-xiaomi-laurel-sprout,
PMI632), on top of next-20261113. Board side: the node enabled with
monitored-battery (simple-battery with the OCV table from the stock
profile), io-channels = <&pmi632_adc ADC5_BAT_THERM_100K_PU> as
"batt-therm" and power-supplies = <&pmi632_typec>.

It probes without any kernel log output and reports sane values:

  capacity            66
  voltage_now         3979548   (vbat_sns from the ADC: 3.98 V)
  voltage_avg         3979937
  current_now         -72631
  temp                297       (SoC TSENS zones: 29-30 C)
  charge_full         4048000   (design 4030000, so the SDAM read works)
  health              Good
  status              Charging

Two things I noticed:

- voltage_ocv returns -ENODATA ("No data available") while capacity is
  reported at the same time. Is that intended, e.g. the PON OCV being
  used for capacity but not exposed?

- status is derived only from power_supply_am_i_supplied(), so it says
  Charging whenever USB is connected. On my phone the charger float
  voltage is limited to 3.96 V with a local patch and the battery sits at
  3.98 V, so current_now stays at about -70 mA (discharging) while status
  reads Charging. I would expect the same once a battery is full. Would
  it make sense to report Not charging / Full based on the current?

Tested-by: Majid Hajiheidari <majidhhdri@gmail.com> # sm6125-xiaomi-laurel-sprout

Happy to test v2 as well.

Thanks,
Majid
