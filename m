Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C842E8D0
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071359; cv=none; b=nU0jGXi8zrtV+5ReBfcJbJDlueUGYyTfQNVTQ6gjqDJrwBYs6hJxJK2+YJ6aFHH5zklo6tuapyEyi1EpZ38FyjILARGKjKaIaW2YFt2wPA18xeAwNYs9haVIJ51MOcx7oNqhG0JVmSdMu6gvW+VZm9uSog4xIzuLR/NaulXHONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071359; c=relaxed/simple;
	bh=uVTmFUQgmyurwuH+tx3PsrqDbjyomC1q+WpJv1Hqk7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o4Kjp3W5dx20CC+ioeFqnnQ56d7/FeJiIlww2w9jtqycNY/bPDOUdjf4h5mdzwmUE8rss5FaRmTuzQqf3G+pau/WZZ98UIPzKeXHPAUOi+6O3e23HTFIv9gPloNznOV8MsLN9hKNpWmjWC+Awtn0NKbN1mCWkYnxNWQ7s7YHtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CkWWqQAJ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CkWWqQAJ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a3897109bfso1550857eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784071348; x=1784676148; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+cwf8KxMbFBSRLsIM9pgNBAtX7liX+tdcg0AtezEmQQ=;
        b=CkWWqQAJ29KzyP9hvlIBzwiToiFgoEc+FqGE0/5K1Nht7C3E8ZuiqKzN8vTgj94wN4
         GyVD6EQcQvjRZmoZdAmWNH25r9SzbhdriRb97gDHx/thw1+qcspsG5Yj5bbwe4TSdCzl
         bd8hIs7QVrGXgaa10BGKxR0dlEITjOGf9WDZdjbEeEiXQxc5oVMrMELtx/GrYlSyF8ed
         f5m87gzyZX32UoPegkee8bzEc+ht852NCPEe4HcCT9ftWS20YMeXxKzwIEadamOxbGdo
         0+BrZBXRMAD/gbCuDQtC9SctVuaNx7SXeSXKE4wT0UBhQurVge5oWjtho7WJgTI6j74W
         ZZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071348; x=1784676148;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+cwf8KxMbFBSRLsIM9pgNBAtX7liX+tdcg0AtezEmQQ=;
        b=dxN2TRXfSF4rWwLGp9SIpgbCjrGTc6/JrO2AEJnjp5Zq0XCcwIAMZjXKQ6hB+fVNRU
         ju2wePusr7W0W+8nYMCKcxQq4UHyEiutyPSg1VSgcm1b0NySTvDFC1Oc9DvZksIWcCBu
         07WVAwix4UZjOHFBX7BuFtaqLFwwbH8StUtdwmLkCxEgIZwYAMqKCbUfz39rvaeIvCeD
         w/rSuUAF02bHw00DZCnMqWLJjuofzKvtGxncLacwAX5Vo0YxM+Ua9yfKM/QtvfstjDqL
         S/FO6pJUWQbS4Uo0/8oVWbQ40vNyA23QagJ5PHFlaZ/KyOYwXFCh6S61VXEw8vVaHI56
         glXA==
X-Forwarded-Encrypted: i=1; AFNElJ9CW1ch/k/ljgTgcTMpM0RFqfoOUhi8UHHuhepP1KBdMV0FvbI0ZvVyoXkYbZhoPqHPpM8iMMiFPvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3ZarwVT251QZJclvkCaeTnd1Gf+Ta8RE9Vkvfw4Mz8cVM+LW
	7Kf4AGxwLS+4yMNqnK49Qo/PMegE1dc6yqXd/HO3SF6jiNhyifVEVDWwRCtgUFU+sys=
X-Gm-Gg: AfdE7ck7zs7L0jS1jpkOe+36cVIl8VuMK9RquT51k4GW8E2vwDLKvBd1lSUmb72xyMd
	3vc0G7zKc7zyoL/Q3sWzHmEE1D8BIePjmuQ5Y5wSykOdgMU1qgWbHoLwvnwnvrK9HQx+F3RY0E0
	vzfMJfvqjQl4LMBc+1SJTyyVomfXf8uhByP1K2xPKF4q3bzUI/3fQXCKbHVzJexOp/c2IFGoRbM
	9sXFBYjhoV30JZhwOpY5HfpePnH4eWpbab+Ta+gbyIVugBSZM5+XHVqKRhWHmwmOILfOqYt82zu
	CaSif4VsdwL42UbstKHRm4eKM/aiWXMrQ05Xvw4wP0NaEx6Gz6c7htfjQfM58n1/DY61fGg1laN
	NpZbuEKrc+6BVlk8awmsSUTC0c4v6NxxGROsXLIGsINxiP414CL6wPzvEElGUOC3HmTAuB4RgYB
	eSbXXi5IVPcjWWaOQGpt4o61bSfdo1
X-Received: by 2002:a05:6820:1f08:b0:6a3:98e9:c979 with SMTP id 006d021491bc7-6a3d9eb4c9amr487045eaf.14.1784071348385;
        Tue, 14 Jul 2026 16:22:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39af0e953sm7561978eaf.3.2026.07.14.16.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:22:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 0/8] iio: adc: new ti-ads112c14 driver
Date: Tue, 14 Jul 2026 18:21:22 -0500
Message-Id: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNwQrCMAwG4FeRnq20WdcxT76HeFjSTCPqpJ1Dk
 b27nR4U0VP4Q/L9d5U4Cie1nN1V5EGSdKcc3HymaNectqwl5KzAgDeldVqk000g3UseyQJQXga
 DNbiqLgrHKr+eI7dyfbLrzSunC+6Z+smaLnaS+i7enr2Dne5eFd6WvysGq41mj6EJbUUIuMLmd
 hCMvKDuqKaWAT4c+OdAdoixRoOlt/TLKd5OZc0fp8hO5XwogbC1wXw54zg+APHzsWBdAQAA
X-Change-ID: 20260514-iio-adc-ti-ads122c14-d0b92479334e
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6881; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uVTmFUQgmyurwuH+tx3PsrqDbjyomC1q+WpJv1Hqk7s=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVsR3/6QLfJBL/+IOg/+8c9Zwgt3H2SzSP6fvl
 yHFk2BgvK2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbEdwAKCRDCzCAB/wGP
 wHB8CACUjUheIgeqLJ81rSmMLMf7v79zeRKeSchhhnPdH9XQi7FFw8tGpVlSxA3Apwnea9kwgYY
 AZ1eUGqDas3N37L3T23Bi+mn/v+kXsghDiXAViLlOoSdR5KwBHDGkS0KFJ+hZkbHX0ObJIDMARc
 xaGnt4XeKA+KFrq2kcBExsv4H4w2L1H2BOhGi9k2NrzYyJwUYUvseqiXIeIWBbvOc7WAuJ/A1dO
 KVc5zzaiBat3GdqHw8nqNIsrsR4eVhAElecEg3sl7D1oDK6K0/UJnfTq6kmjWTEBp3uBIf88zmT
 hqsP8NQprBp1wgg5tnWIW4wVrDgiHwmFC41V+VXzc1flowAR
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This adds support for TI ADS112C14 and ADS122C14 ADC chips.

The closest thing we've seen to this in the kernel already is ads124s08.
However, that has a completely different register map and the DT
bindings are incomplete and the driver is extremely basic. So I've just
started from scratch here.

We've also had a similar submission recently for ADS1220 [1]. That chip
is in a similar situation to ads124s08 in that it has a different
register map (but the submitted DT bindings are better than the ones for
ads124s08, even if still a bit incomplete). And literally as I was
writing the previous sentence, another series [2]  was sent for yet
another similar family of chips (ADS1262). That one is even more complex
in the feature set than the ones I am working on.

[1]: https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/
[2]: https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/

All of these chips have in common that they are designed for use with
RTDs and thermocouples and so they look very similar to each other in
terms of wiring and feature set, even if the register maps are
different. They are in the gray area where we could either keep them
separate because they are just different enough, or we could do like
we've done before with ad_sigma_delta and have a bit of an abstraction
layer for the register differences and otherwise try to share as much
code as possible. Normally, I would lean towards keeping them separate,
but in this case, I'm considering trying to share code because the
devicetree bindings for the inputs is complex and is going to be mostly
the same across all of these chips.

After seeing Kurt's v2 though (that doesn't attempt to share code), it
seems like the chips are different enough that sharing code might be
more complicated/messy than I initially thought. So I'm happy to keep
going that route.

This series includes just basic support for reading single measurements
from the ADC and gain selection via the scale attribute. I plan to
follow this up with additional series to add support for buffered reads,
filtering/oversampling configuration, event support, gpio controller
support, burnout support, DRDY interrupt support, DELAY support, CRC
checking, external clock support.

The most interesting part about this (that I alluded to above) is the
way channels are handled. These are multipling ADCs with differential
and single-ended inputs. But what sets them apart from other similar
chips is that since they are designed for use with RTDs, there can also
be a current output required to excite the RTD and this current output
might be different for different channels. So the way I conceptualized
the channels is that the devicetree specifies the conditions needed
to take a particular measurement rather than being purely a physical
channel.

This makes things more flexible, but does make the driver a bit more
complex. For example, knowing when the current output needs to be
enabled or disabled. For now, I have chosen a lazy-enable where they
are not turned on until the first measurement is taken that requires
them, but then they stay on until another measurement is taken that
doesn't require them. This can lead to some oddness with the diagnostic
channels that may be measuring something that indirectly requires the
current output (i.e. the external reference voltage when it is connected
to a resistor rather than a power supply). This means you need to take
a measurement that requires the current output to be enabled before the
diagnostic channels will give accurate readings.

I have also pushed a branch to [3] that contains the start of some
documentation for this driver that can give some more insight into how
the implementation works. It still needs some work and also documents
some things that haven't been implemented yet, so I haven't included it
in this series yet.

[3]: https://github.com/dlech/linux/blob/b4/iio-adc-ti-ads122c14/Documentation/iio/ads112c14.rst

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v4:
- Kept the review tags on dt-bindings patchs, but made some changes to
  a few of them that are worth a quick look again just in case.
- This didn't come up in review of this series, but in other mails on
  the list, Jonathan has been commenting on improper use of claiming
  direct mode, so I have added a mutex instead.
- Fixed use of 64-bit scale storage on big-endian.
- Removed burnout code (saving for later series).
- Most other changes were minor/cosmetic. More details in each patch.
- Link to v3: https://patch.msgid.link/20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com

Changes in v3:
- Mostly cosmetic changes and a few bug fixes to address review feedback.
- See individual patches for details of changes.
- Link to v2: https://patch.msgid.link/20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com

Changes in v2:
- Added patches for adding properties to adc.yaml.
- Some of these are coming from: https://lore.kernel.org/linux-iio/20260622-new-channel-props-v2-0-aafd5369f253@gmail.com/
- For now, I have stuck with one channel per single-channel pin or
  diff-channels pin pair rather than some of the other ideas that were
  discussed. Handling burn out current enable will be handled in a later
  series. I'm leaning towards something like the _burnoutraw attribute
  that Jonathan suggested.
- See individual patches for details of changes (mostly renaming DT
  properties, fixing some driver bugs and style issues).
- Link to v1: https://patch.msgid.link/20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com

---
David Lechner (TI) (5):
      dt-bindings: iio: adc: add input-chopping property
      dt-bindings: iio: adc: add ti,ads122c14
      iio: adc: add ti-ads112c14 driver
      iio: adc: ti-ads112c14: implement gain on internal short SYS_MON channel
      iio: adc: ti-ads112c14: add measurement channel support

Kurt Borja (3):
      dt-bindings: iio: adc: Add reference-sources property
      dt-bindings: iio: adc: Add excitation current sources properties
      dt-bindings: iio: adc: Add burn-out current properties

 Documentation/devicetree/bindings/iio/adc/adc.yaml |   41 +
 .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  |  217 ++++
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   12 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ti-ads112c14.c                     | 1206 ++++++++++++++++++++
 6 files changed, 1484 insertions(+)
---
base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
change-id: 20260514-iio-adc-ti-ads122c14-d0b92479334e

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

