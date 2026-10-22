Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682350;
	b=z+czLZu/nt6l/E7U2eN11Rjq0JRHtEL6NFers7jmEkwA9Pwo0q8p5nu10vRYakh5/Pem
	 SyCaumCfAdrbGQP+XIOpfy1kmnVr4hpRjU1Jk+7zByCTnbh7IfEaYQ4NcHjlk1/kDutQ6
	 8yU2YFu8VwZfm90iarbvnqx90XVyJU6XqpvSanBSKVvN49cTpi2wKOknMItarneiMYolf
	 aIYHpJz+zNOr3Z0mDfoKn5x7EBHng445zVdEDFKChhn3BZYQOn41t5dUouoTrM6i7MAff
	 W052aAKflsT7nMX4fEspVUsT0si+e/7qCtITME5YS6farJtW3wbJYmQRO9LO3jAeSAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682350;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=s8461N4x6bAd9nJahZR75PpHJ9523zVsVCtLDHgioC8=;
	b=LV7UdNrOVbf6vyQaQZ3Ir6783xXWLKRb4wg66OU8RVwMDkdpVxTGNV5XXNeArU4TF6+n
	 u8JgCK0G+szOqXVAZgzCLI9vSClOY3ZXUC7pRdafslPDK+wg/63PQT38wByP59LtLYcPa
	 MV5n/RiySlI6KWKATJ7rxN5Ae5e7yOY7FXHPXV7GIlmjC2EYT3wI/rVaIBNFq7OlwNelm
	 imjP36VMPJAvIFvIKon/uxwUcNWVHSx+PfXEHnEdyd2ct+wz37fDdn+HZBIizTsWPYspC
	 h4zvG/2aJKvdog2G3C/aj70K6GNqc82PADmSQoR37Xaj77LEb6PZWkRhyxl7e3zovWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Il4+S/7p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C7606CC42;
	Thu, 22 Oct 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Il4+S/7p
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682349;
	b=aPuG9em0hhrVsF5iokravzKPyiPC3pPAE+ddDHznvGlu5uAZhNwfoe+xoUnaBdgBtM/m
	 1A0FgYnb0n6Xyakfqi1xlZ0jD58xpER0oXFolGWMbhUbcOoGWU+cHGRNnMKKaRWIqx+ho
	 IGMzErWbuifbU6zlYinWx2LP8y6VgKkYj8MigmAeMc/dd3lXzq/Os8zLHi6LDZ2F+dSmH
	 4SCietQ4j4JW8Z4M/+hEfT0IDw30FZnwyIHPaqFAQpPLpDuwcN7l49GTyA6mwKEu7OILC
	 sVwtx/k7b5JZGpOn1fRqj+DdFKzjm3MLNLd2cEUcQEb798E3qCoMmfptBUdRiUffnQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682349;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=s8461N4x6bAd9nJahZR75PpHJ9523zVsVCtLDHgioC8=;
	b=lcyxS8Jko8Sr/OWVAHSqj++eUr/I7dN+aBiaSgGPQ9A/Yr7Z2AI3teRlhxpAtwlXGCb7
	 lyn1zmcucMyu4vPpbS8lQKfD2sGMjagNtPEGZzla7Ulfd78wSQJNIEqqMpebWRx5hi1hB
	 UT745mBjPRI0C5bCoCBPKRFibeX2hFlUNycN01pWRD5ymGrGvoBttCmscUmHlBHoF0+xr
	 g/2KvpmX3rcpSdgGt0Fow68J2CaC8+9WxQlOH7AR41LfCz/qIx1WQ6RBPiy/xDL/ZjNYp
	 YuY5qajNxhpLpG4rv3l0AzJnKAvGgPAtQifE1uVplx9KqljHHX6+bMm1pifmtrP+zlQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 929C51F01825;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682349;
	bh=s8461N4x6bAd9nJahZR75PpHJ9523zVsVCtLDHgioC8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Il4+S/7pKcYheXI/6/z+C3XKEBFcowDQMLZkC3Jtpn/VcdNWMXRhdTY89HahVLYfX
	 hSpCZGGz3ANlkx0H64/jysXGKE8DtL8gsxg5QKV68h4/T2pEOCuvuvFg6qxFU01T9P
	 8Z0acnWedIhAgvSu4D0/QCOPvF1OMZXUmW3zHP8H1E2FKlTVKvmcqP+u166x6+r08C
	 be6lYerdqTlgRefJIOMuGzjjTP7O6cXvF+qRXK9lKURgnlQTjxn04WpYE6t5pK5rIH
	 t6eagxzSZIFVAWpKsDENWyYmZeG/VbCUxCQOcdCag2RPHvwrs0kAb1vff7UOU/ceG0
	 9h5cDA4LU21XA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E27B641E49;
	Thu, 22 Oct 2026 15:19:07 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v2 00/10] iio: frequency: ad9910: add IIO backend support
Date: Thu, 22 Oct 2026 12:18:58 -0300
Message-Id: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
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
X-B4-Tracking: v=1; b=H4sIAGMp2moC/3WNyw6CMBBFf4V0bc1MqTxc+R+GRWlHqI+2aYFoC
 P8u4NrlSe49Z2aJoqXEztnMIk02We9WEIeM6V65jrg1KzMBooA6B65MXSPwVukHOcPTGIKPA8d
 SydJgKWUObD2HSDf73sXX5sdpbO+kh822LXqbBh8/e3nCbbdHEPD0LzIhB55rgYWsdEWiuCinn
 r47av9izbIsX7sMNCjPAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=3858;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=0eDi3cJlO2Kr5JHOSDc8le20UlTOxTiPawBS9a/r7Yw=;
 b=sxcKxjCN9UmZ2Bs3ih1g5pqsK/jnxHT9HQq5BAZRrooMewHfSK9NAtArw3Q2C1l8AQ9zbUoJk
 P/9zAYqltf6AVzz1rJBJm2VIvzNkTuEaY+ciBXsXoVAxPJFmHcH+Eiy
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
 drivers/iio/frequency/ad9910-axi-backend.c         | 525 +++++++++++++++++++++
 drivers/iio/frequency/ad9910.c                     | 420 ++++++++++++++---
 drivers/iio/frequency/ad9910.h                     |  44 ++
 drivers/iio/industrialio-backend.c                 |  38 ++
 include/linux/iio/backend.h                        |   2 +
 12 files changed, 1205 insertions(+), 66 deletions(-)
---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20260930-ad9910-backend-support-17a47d174430

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


