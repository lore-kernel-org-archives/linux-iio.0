Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717583;
	b=1fl6sTUzo0usJZ7ukd7EBiZyjmHTRlv3gBXZ8Gr5f6WzoIfzME560V+oWRF2u0cApE6k
	 3q4mCyQnupPeNheYLj6VtKFqmk+9s0xskwh77GH86YaP86HFg1hXS80osiDyvb2PUu7KT
	 7gH3Z14cCliAGke1sEeO/BJv+ln2SepqrqhhuY1bSGdVwyXLtGrwzsPa9L7/eH5KE87tN
	 bLSabpSPdi73AKBAX09s01lAkgu179wSnlmf1eVDXIRxJHusbcwTYT9v5GdMLIg+NuWiT
	 KDupE+0P7CyTQCGbLDXZAXLeeEEUAIDr6eu/8CpwtSHZGsOVlzL9+Xg3yMa2aQRiiXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717583;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=zytjDUzv2j6e6iEvu96rxvzwImeHFyMYnbalPu6c8mU=;
	b=P+8q3URmGxJeEConFkdwfnZcZ+3U3J+xcra62uIbG928A7kqf8nS3ccXG3OwvUcXvwoA
	 o5XkNHZpjCGiYM2DYkNmLQSUVYjH0TSMoRpIsBCmxX6agqx7+irZlDlivKEMyNTKxOAF6
	 CRUWSIAuZqxpfrUfKNk43o09sPfpohqlDK9oJ9CsYlaFuRAK57YPqE1EjUR9lLWaxAK0k
	 INOoFidXAc0Nsi/eKZiJUmP+kpZKoHsE/Nrz/YIKCUMVGBxhcKERtnXu2bvxw2t2Fh5tM
	 /xeG3JICsId/MtffxEEVtrc9aIbMUD5m2XuwEhqC86A8K+lMbD5oESU6D1AiFNyVwSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaD7I2p4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C7606BA15;
	Tue,  3 Nov 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaD7I2p4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717583;
	b=uzFQgvjyx8HSfkdovqpMLDE7AnnTuoYXL4C6dvJ6dUfpk6PMFsAf3ZRrZu2oIaq8ON9q
	 D3XsDYtD9DGtp5dDmgJqY0uhp9cY9Rv/JQJWPFtuH0/km4zI9Oz5Jgt+Wb95YQ8RlGB0+
	 VUvTd4pNWgC7VdJm5SgMTjoX0VUWWS10CcSL8DX94Hr2Eylj96L8IINrpxLvZkgNfak+g
	 I3jQyjCcGI0O7IGxN4eP6tayNKC6Vl3+ErDO2+txSh8vw5hnhU3Z1a6QUS/vZz3BrvgHd
	 esHEMfUiXe217/113kjV+mXTG0FzS2zrStjRiFHPSgnigwyaYNG1Bk369ooFLacVc6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717583;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=zytjDUzv2j6e6iEvu96rxvzwImeHFyMYnbalPu6c8mU=;
	b=JDfpTdXzG2uvU9vzaXWU+3A9o2Uwo1yQIUIR/zZiW+kfecofPogAij+FgDKGb+xHmMEu
	 Q6zy1sy7vZ9n4OOTvn9M4eqQ9RWCl7AVr03UIXNY9fflVZvRfYrLorOkyU2gY2FYY1Xe+
	 3OSvolfsjK5MwzbtlnJ+oaZRyIz+dAVjnAWIpp/asuVzE1dKtzDJeoZcHU7v/wQ6itzQr
	 5MvlSyalHmhzuXHIv71uMH26xXgZkGx9/cA8pfoayLHN+Som6bFTbYzVJEVCXhcuhIQ5c
	 W0rf5ZZqXch7Npd7N26fLCRCFqvjB85QrH15aQqO7e4WnPt7AQC99C1gU4FM1Lw/VwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4AED1F000C1;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717583;
	bh=zytjDUzv2j6e6iEvu96rxvzwImeHFyMYnbalPu6c8mU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=kaD7I2p4Xa0c0Fq2kaQOhpVKKf6DwdT0fB6NzA3pVSpGPUury6khW4A7tT1eghMbf
	 5/MLIMk4pWpFIeo2+frEsA5c3TxsF0mHuLcLhZDM0hj3I914Es/uS+Kjs9y5YTAVQV
	 AkV7MJt2BIgtYtkMBJ5UTJvmqRhWjBgtu//IoQ9dqhSM/4qs+CUVZoM5mw/2B97guC
	 2JVqYjTLlfRD8RXqHpq0LrXn8biIPesQEftaMFcgEGoybKly0MC6H3RxT+lY+Lx3FB
	 vtyawnE/u4YvhW+I+tXVgMbxbnXB+KcAYvlyHYrHSwlb+nd/NfM+qIA+KkcQe8Ok7y
	 TPqEi3mbEDgGw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 49AD44699E;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v3 00/10] iio: frequency: ad9910: add IIO backend support
Date: Tue, 03 Nov 2026 11:52:56 -0300
Message-Id: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEj16WoC/3WNyw6CMBQFf8V0bc29baXgyv8wLkppoT4oaYFoC
 P9uwY0xYTnJOTMTiSY4E8lpN5FgRhedbxPw/Y7oRrW1oa5KTBiwDAoOVFVFgUBLpe+mrWgcus6
 HnqJUQlYoheBA0rkLxrrXKr5cvxyH8mZ0v9iWReNi78N7LY+47NYIAh63IiNSoFwzzESuc8Oys
 2rVw9cH7Z9kqYzsx8PYpoclD1grLZTW8j/PPM8fb8ptiBcBAAA=
X-Change-ID: 20260930-ad9910-backend-support-17a47d174430
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=4225;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=crclX+Wh/E611EdZhkgNZ8cUrSJu3ltuiZn/FoAIESE=;
 b=xYSl+hPNrXQeTr9KYu9pXF1Jl8dhbY8tLPl7CMPS8mKYhN6yRjgJLYba1Otg8VfIJwTtGB4+R
 srhkHMPggNEDqcuyrMqDyKARQgImvIpBMR8ia5XtrMEwq0YEHMtA9R3
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This series extends the AD9910 DDS driver with support for an IIO backend,
enabling data streaming through the parallel data port, and with control of
the DRCTL pin, which defines the slope direction of the digital ramp
generator (DRG).

The parallel data port allows modulation of the DDS core parameters
(amplitude, phase, frequency or polar) at up to the PDCLK rate, which is
SYSCLK / 4. Such data rates require an FPGA IP core as the data source, so
an AXI backend driver is added for the AD9910 HDL reference design. Besides
streaming data from memory via DMA, the IP core also drives the PROFILE[2:0]
and DRCTL pins. The latter is exposed as a PWM output, so that the frontend
driver can consume it through the PWM framework without depending on the
backend being present.

The backend is optional: the AD9910 remains functional through the SPI
control interface alone, hence the new devm_iio_backend_get_optional()
helper.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v3:
- ad9910: Get the DRCTL PWM with con_id = NULL.
- backend: Explicit F[1:0] destination mapping for the parallel port channels.
- backend: Split DRCTL waveform write error and disable paths.
- backend bindings: Reword the #pwm-cells description.
- Link to v2: https://patch.msgid.link/20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com

Changes in v2:
- IIO Backend: Use device_property_present() when getting optional backends.
- AD9910 Backend: Move PWM driver to waveform semantics.
- AD9910 Backend: sync PWM configs when sysclk updates.
- Misc changes addressing other feedback (including sashiko's).
- Link to v1: https://patch.msgid.link/20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com

To: Rodrigo Alencar <rodrigo.alencar@analog.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
To: linux@analog.com
To: linux-kernel@vger.kernel.org
To: devicetree@vger.kernel.org
To: linux-pwm@vger.kernel.org
To: linux-doc@vger.kernel.org
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Uwe Kleine-König <ukleinek@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>

---
Rodrigo Alencar (10):
      iio: frequency: ad9910: powerdown fix
      iio: backend: add devm_iio_backend_get_optional()
      dt-bindings: iio: frequency: add adi,ad9910-axi-backend
      dt-bindings: iio: frequency: ad9910: add io-backends property
      iio: frequency: ad9910: move channel indexes into a shared header
      iio: frequency: ad9910: add axi backend driver
      iio: frequency: ad9910: support drctl control
      iio: frequency: ad9910: support iio backend
      iio: ABI: add integration_time for output channels
      docs: iio: ad9910: document DRCTL pin control

 Documentation/ABI/testing/sysfs-bus-iio            |  17 +
 .../iio/frequency/adi,ad9910-axi-backend.yaml      |  74 +++
 .../bindings/iio/frequency/adi,ad9910.yaml         |  38 ++
 Documentation/iio/ad9910.rst                       |  90 +++-
 MAINTAINERS                                        |   3 +
 drivers/iio/frequency/Kconfig                      |  19 +
 drivers/iio/frequency/Makefile                     |   1 +
 drivers/iio/frequency/ad9910-axi-backend.c         | 551 +++++++++++++++++++++
 drivers/iio/frequency/ad9910.c                     | 425 +++++++++++++---
 drivers/iio/frequency/ad9910.h                     |  44 ++
 drivers/iio/industrialio-backend.c                 |  38 ++
 include/linux/iio/backend.h                        |   2 +
 12 files changed, 1236 insertions(+), 66 deletions(-)
---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20260930-ad9910-backend-support-17a47d174430

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


