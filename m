Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65203481AA5
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255666; cv=none; b=Jb9DkmJmmhZSRXx/SmiFezV3bokByJ0D8tHToaItiQMdi/ybSkZAi9SO2ogVDpnev8GYbcaL3sTzgF+k2pQYW6Ie66KSTp3gZ+iNlLGG14LSdBdusuJMctESvpscvX7+tnSuk0On1adwkPcixr/l2nFVtw0kSWnfkvYqC6tLj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255666; c=relaxed/simple;
	bh=Qfz2JBIID8kBw9YQESuE/2T4gh06WbRO5kl3dUZDXEg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PpmhF+A+FwPOIv6Au41l1EkEg3ohYM/R0j6Kd4OKLz0fHXIJlUb6D6yAsyerLjuHG39LAxopbG8+Szn4cWO+Vjc1C/rEpTN+A96LSDrTlPpxQwFo5OWl9ckEEqExahbbv78POqMzv8AXnCMHRBqw/zLorUpQ6gfS7fAHg3BtNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ge/MO/zu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ge/MO/zu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso14968345e9.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790255663; x=1790860463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rXL5Y7/cWgIONC+kU2uQwobZC+xYrWh2x3EN+RFUQQM=;
        b=ge/MO/zuOK7E1964ZcuVRLn8uCkCsSPFtnoGzbC0r5n6mCD7bh7CK5BO4VyvJdo8xR
         lC7k264Gc7fTyPMkB3JacWPTHfaR4tyFHaXKoatZLIjFTRnqteFrYMlUrmut1hGeigsB
         YzXyCuYxft2dDfV4yxWpVWyoO8FLQobgToxr4DUOTnIeNpfqJ1anca4muerA62vDP4cJ
         z3kpY+iPYkAlTUQLHr7tt9hFL3QenW0tV/v3JIL4UxF9Q7DIHaPat4an5IL8Sv0HqYw3
         IrdCc4NsTDFZvYPYyTFlW4DP8OM6U5HbW/ek0pVtn9oOtF9RK2laKC57mXQIFp7BzQ45
         cPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255663; x=1790860463;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rXL5Y7/cWgIONC+kU2uQwobZC+xYrWh2x3EN+RFUQQM=;
        b=an4cAolUMsIMeDcz/5zcKR621SQCBPz2nSEes/PyYqXQF+BjqECqlHdewRRX9MiBj6
         +fuRJU81cyGYwzKAZ4W91EqtRChlhbA1KRSfG6DfdvIPn0v17DzHhPHllhCelMJO/qUv
         DZMaAgdqxhSJroySHqir8FIZSLGWb1kFbvHW+DmvZw4qz3jafEBlIYuKXuhpKoqomfmM
         HY8aZl6pMxRrNm5Tyb6+1C9fUZDqTCfzwXw6Hgp8pfbhHpI4n+gLz/SrIP8r7emJEWAR
         XwATG5+5J5M5M8KZR8X9MhmTmYBAEwYR+Gxs5/vd7nmy7gk//OPvhkYCxjJMa/BXe5Tr
         AwhA==
X-Gm-Message-State: AFuF++lrOzewpV9Q7nr39UZ1B3i+GHSfs5XxpZKdgkviyx+SexcabSbm
	IpIgd1lZHjTLIwJmwXa0XRG1eQDb6T0u0sfNkcSssJCXF4rUYAjj0lMM1Ify6Libq4E=
X-Gm-Gg: AYBFou0uUc9S22Xq/4Sojd6jDV2NsqxmWm2vPf3rNHxPS0DVZ5GEPcmBERs253AtGEu
	gpGSlqV1pEd++LYjLPRPt40fYXBhfB6LrUcs3EIAci57hCugEiBRCk0ENtCLSQ50jYvN+gH5Zbw
	pSKK6YGJQHbjW6DsiKB/ZiJpbcKoaU1wn58fGuSxwRdS5qpFNje8WG9IHYCu3B5aIih5ARlGNHO
	JbgM6seYf8qtZPJ5rzsdnGojLGohyzZGJapwM1zyEl9O2Ga5a4IWeNbVnUal0trYxFX4ELtloPK
	+pe+g9m6bsA1CyZruKaBTeUzxIt3kHOjDFbbgza4KQeD5Gx4QGDfvYEeRZAbqGs2d5SL8qwnVNw
	kpETDh6by1Uft+zZGY31MRyREmpjmNzkNpYCiFgLj3FyefdJK5c5uwZ56GuPzmrNnR/cTsw+ezY
	drDx9R/fcbnE/i9R0TiPZfn/DLHN0HKoLzybs2RUuF+/EQYIVx7GXoNvs71ACz++s903Js8xokO
	S5jqoqdD7eD+qqDoQkfGF9kAP7Iag==
X-Received: by 2002:a05:600c:83c4:b0:49f:c331:39e4 with SMTP id 5b1f17b1804b1-49fe66ca101mr38946645e9.7.1790255662495;
        Thu, 24 Sep 2026 06:14:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4054fsm111837945e9.3.2026.09.24.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:14:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] iio: adc: add support for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Date: Thu, 24 Sep 2026 15:14:14 +0200
Message-Id: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACYitWoC/42OSw6CMBRFt0I69pn+UHDkPgyDtjzgGWlJiwRD2
 LuAG3B4kpNz78ISRsLEbtnCIk6UKPgN5CljrjO+RaB6Yya5vPBSKhjDQA5SX8w5B6IAvZmV1uI
 KpnYgeYlFwXOlGsu2xhCxofnoP6ofp7d9ohv36G50lMYQP8eBSezev1uTAA5a1NoaYRunxf1F3
 sRwDrFl1bquX16RXMbdAAAA
X-Change-ID: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Qfz2JBIID8kBw9YQESuE/2T4gh06WbRO5kl3dUZDXEg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqtSIrYW5acOXlGWUhOwpfb127DsHq3pb5yt8c7Ux+
 knPGIk+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCarUiKwAKCRB33NvayMhJ0RMCEA
 DBOwwCygGuaoOBaL4nm80ATdnNEsggnefCw7AyBbTfeClfJDziYloc2QSHJ8jkB5bw2arC1gWN7A9w
 DpPYStCStoXNM7EX+yOD8mcQsRf5tpm10CS5WJkHp6Gdg+RdKgx7EYP1D3cC5q3DGZ3NyZf5E2Rdv9
 +1pWyE3sT+nOHwqoGPFuT3y+JJ217ikY4MLkz5a94lMaXLseHznBt5W72fJ3gQPH+a7MymSESSmsrb
 33S2/5s3/xlqCBjRX2dSCjGuAorNjFIjfsiWJ+MdJuzWf3jrcMpIgeoP8id1cDalySXEkOsqpw3NOb
 ayFaZxQfqwsHRlDz+kC1mlhRfRRmguA+XJ6MwSwZHalMXA7/1nEpVOWC+xT583kCJxids7gdzFV6eG
 llh4cXyBiCy4yw4atU+5ug4JD8bhuMQXIkZkZ3yFgyhmOfvROsX4+Hjx2VCzykSxm5uQxdgACZFZNp
 KGSCF2xC4l5xgRSlXI0foAfRfGYkxOXlvjrRZ6SQOmQopgEy5X9W0it+M4SOOBFk8HS3iV+IkHelWK
 S//5LL84vg889NdJJ7ZXqXBOOAtY1FtQRiqSHCDaba/DHyygw5j+Ct4l7c5JMukl/fgVG+nthBkSQa
 x3cLUvBDFZm5oiqes6opLfDKb12OLtKJu3QRFJD5Q4ERkS2VMLpLXnjt0wLQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The MAX34417 is a specialized current and voltage monitor used to determine
power consumption of portable systems. The driver support getting the channel
voltage and accumulated average power over an I2C/SMBUS serial interface.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- switch to shunt-resistor-micro-ohms no more required
- removed gpio.h from example
- Fixed max34417->MAX34417 in Kconfig and comments
- Added missing includes and remove unneeded
- Fixed typos in comments
- Switched to fsleep()
- Better aligned max34417_read_power declararation
- Handled 0 acc_count
- Switched to GENMASK_ULL() for 32bits systems
- Added missing empty lines
- Moved the input correction into a helper
- Set default input correction for all channels
- Switched to dev_err_probe() to return from probe
- Switched to device_for_each_child_node_scoped()
- Handled invalid shunt-resistor-micro-ohms value
- Link to v1: https://patch.msgid.link/20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org

---
Neil Armstrong (2):
      dt-bindings: iio: add: document the MAX34417 Four-Channel High Dynamic Range Power Accumulator
      iio: adc: add driver for the MAX34417 Four-Channel High Dynamic Range Power Accumulator

 .../bindings/iio/adc/maxim,max34417.yaml           | 100 ++++++
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max34417.c                         | 374 +++++++++++++++++++++
 4 files changed, 486 insertions(+)
---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260923-topic-sm8x50-iio-max34417-adc-209e880533fb

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

