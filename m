Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847204;
	b=PBV0ls+Dsg5EtYjByx1d8bZbAWtWMeEjZUMDKLzAX5GgDkpEra4bdzDm7tjQ7iUhGIdB
	 Xpe6ANS7OMjF4O3DZII6/8tL2aFTvX0gZn8ri/w4hwF6OS09QASOh6y61ssre2HvUKQpo
	 5aUb/7ASMCxvXmcXxKmFUQZ+gaMaaCS/4CecbRahu3DyUDETvMT6uZDiGhHWw946wqRA+
	 YDIpIAVp3oI/rR6WN/88/FWmf0QeK4Wv0Z1Yutum65ZEo5fMvhU2lIoqpA/XV1wQhwTn4
	 ZtM/7cjhl7LzqRBCC8aG7DgTWFZjNof2TrFfrumbpAwab37VITgE6H82OyQL2Sv9yxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847204;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	b=mVFd0BfnskRY2ddByO3+7ZndFi3L7xhmRSlhu9QWjHwpsawsWEOkhSsWKhKajGDVaonF
	 WDQuf2HbSsfO5X4Meovg4QzT2ua4GeMrHZAaahhLd70SmFrGzE/0T/7b3LWbf8Y+YrfaJ
	 BzVOPBnVxWSK5nPwTYw04VIGy2+Ww6zoAwRMxKhyD9+/ScSb3ynGpEUItmGX5DZoIWxFr
	 v2RPk5AH9aHE3l4nJl37itcVGVFTc1W/RPMqhxl5TJgxvu4hsqsdZjwikybKNnVl8wngQ
	 5WIyaecvSvtjqIjYKuvdDkbLaWS67a9fwifmqi1gE8edwc2XDa5aJxf7JSVCwhI+Tvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgzcg7+Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5060A2620;
	Mon, 16 Nov 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgzcg7+Y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847204;
	b=ziJalQAQbYd68QFWlbYgVjJdUkeU8CkGqZp3BBS+QwTrt4mgBFao8K8p7c/z6sg2iwTj
	 bqi0xQuLSkiGyei4rfeJ9a3RIAo8xtY+RmFx5sAFLnnWQ6odtD888UUCE/wFAnCtxgHs2
	 9jpGJabPUodsSyeLenwnZO7b5uOkFTNEgoRiCM96JwJho99F6dTeSpSRlbVk+KmbifYuj
	 tcO8NprbekwO3FnjkyeGA8pUo40W4vvA98S6janbf7cbm6Txmnv2iy1G9dYKR+0v+fCPU
	 ZBgSquXnHHGbcaGyNvNu09kTaCWOM5tJ6G3VwszoarlEkBUwvXQeVUYtxJk93mEbuwA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847204;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	b=ZVwVLxO+3gUaHc5K+hiPWMAWDaPI6Bd+sGk0/GUcm1qzuDo3hsWQrpKXRAIU88E3II+7
	 JyAzfo4HewLqCVP05/Aa1HRf45Z+w5phvFhiZx7ty4rHQ0Gs0a7+0Febdc14q4lvLcPjB
	 2HnuaqRV9rMnp07PHx1AAS6FUofoP16SDP7Dmc/5EHhkwgcJea4das8mT9i26+D/omV09
	 CnfSJ5zXlfdScuhPSCCXZbBsUrXkQoIjU/DssUu8hFceP1sV2CNFoBdSzHr6Nao9fiHmb
	 Vq91Na3M50MMYnNgb2Ll77sv3pX72HCHYS/Ui52zIgQfo/uWBfChiHUd5eRyUEE2yjw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CD36D1F00930;
	Mon, 16 Nov 2026 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847204;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cgzcg7+YzDNz2rKvIWPXIS2UM+n6wado0GQO1KEgDx/RrCRAFYHVL7RSqg1A7uglR
	 btc/X4T0HrJ8X2k3IUeRYtGhac1cklc2kcVQBR+lozZF0FvMicJIUkKuvjxjB5vgoT
	 fC26zhAer20fao1q1sRvf8lLRc4JjFxgbnL+69XV3wFfFkyYJtG6Cyfj7IPesHuurq
	 cI459u2v6jeFSq7JQOzXChSyAyMlMUmPylaXqoH7s/Buf4rvRGN53T2RlZqPpjZpUZ
	 kp5jRpzPY8WRYLVt78JAqo5UwclJ1RlTx57roTEDxGfjvmV8dqz4VxS7HNmhyAyNTY
	 /XFtqct90P+YA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C58B84A546;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:40:04 +0000
Subject: [PATCH v4 12/12] docs: iio: ad9910: document DRCTL pin control
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
Message-Id: <20261116-ad9910-backend-support-v4-12-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=6219;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9AdEqIZ+bYqk9Lw6P7OuqM0LPTI0z5xHBJLcZX+ImKY=;
 b=3iAnJPFWKY/dBuJtaEHNfAh+V+JWDqolzSlWNPF/6rIpBV1ZQW4tUjG807ALgx7V3/YVhotRY
 5kqaQGZdqeOBkQwZNtLBplVW70o21SlC0oDfH7nozdMA993fdNUVj3O
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Document the integration_time attribute of the digital ramp generator
(DRG) rising and falling channels, and describe how the DRCTL pin
waveform is generated from those values according to the dwell_en
configuration. Add usage examples for triangular and sawtooth sweeps
driven through the DRCTL pin.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/iio/ad9910.rst | 90 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/Documentation/iio/ad9910.rst b/Documentation/iio/ad9910.rst
index aab569f561db..bff55cca8c82 100644
--- a/Documentation/iio/ad9910.rst
+++ b/Documentation/iio/ad9910.rst
@@ -85,13 +85,13 @@ system clock (SYSCLK) which affects all other channels.
      - ``drg_rising_frequency``
      - ``drg_frequency``
      - DRG frequency rising-ramp parameters: limit code, dwell enable,
-       ramp clock, rate of change.
+       ramp clock, rate of change, integration time.
 
    * - ``out_frequency132``
      - ``drg_falling_frequency``
      - ``drg_frequency``
      - DRG frequency falling-ramp parameters: limit code, dwell enable,
-       ramp clock, rate of change.
+       ramp clock, rate of change, integration time.
 
    * - ``out_phase130``
      - ``drg_phase``
@@ -104,13 +104,13 @@ system clock (SYSCLK) which affects all other channels.
      - ``drg_rising_phase``
      - ``drg_phase``
      - DRG phase rising-ramp parameters: limit code, dwell enable, ramp clock,
-       rate of change.
+       rate of change, integration time.
 
    * - ``out_phase132``
      - ``drg_falling_phase``
      - ``drg_phase``
      - DRG phase falling-ramp parameters: limit code, dwell enable, ramp clock,
-       rate of change.
+       rate of change, integration time.
 
    * - ``out_altcurrent130``
      - ``drg_amplitude``
@@ -123,13 +123,13 @@ system clock (SYSCLK) which affects all other channels.
      - ``drg_rising_amplitude``
      - ``drg_amplitude``
      - DRG amplitude rising-ramp parameters: limit code, dwell enable,
-       ramp clock, rate of change.
+       ramp clock, rate of change, integration time.
 
    * - ``out_altcurrent132``
      - ``drg_falling_amplitude``
      - ``drg_amplitude``
      - DRG amplitude falling-ramp parameters: limit code, dwell enable,
-       ramp clock, rate of change.
+       ramp clock, rate of change, integration time.
 
    * - ``out_altcurrent140``
      - ``ram``
@@ -493,6 +493,60 @@ Ramp channel attributes
        from the hardware step size and the current ramp clock. Writing
        requires ``sampling_frequency`` to be configured first.
 
+   * - ``integration_time``
+     - s
+     - Time interval assigned to the ramp direction, which is used to generate
+       the DRCTL pin waveform. See `DRCTL pin control`_. Rising and falling
+       ramp channels of all destinations share the same underlying value for
+       their respective directions. The written value is adjusted to the
+       resolution supported by the PWM provider.
+
+DRCTL pin control
+^^^^^^^^^^^^^^^^^
+
+The DRCTL pin selects the DRG slope direction: a logic high drives the ramp
+towards the upper limit and a logic low drives it towards the lower limit.
+When a PWM is assigned to the DRCTL pin (via the ``pwms`` and ``pwm-names``
+devicetree properties), the driver generates the DRCTL waveform from the
+``integration_time`` of the rising and falling ramp channels, according to the
+``dwell_en`` configuration:
+
+.. flat-table::
+   :header-rows: 1
+
+   * - Rising ``dwell_en``
+     - Falling ``dwell_en``
+     - DRCTL waveform
+
+   * - 1
+     - 1
+     - DRCTL is held high for the rising ``integration_time`` and then held
+       low for the falling ``integration_time``. The PWM period is the sum of
+       both intervals. If a ramp reaches its limit before its interval
+       elapses, the output dwells at that limit.
+
+   * - 0
+     - 1
+     - Sawtooth rising ramp: a new ramp starts at every DRCTL rising edge,
+       which happens periodically at the rising ``integration_time``. The
+       falling ``integration_time`` is not used.
+
+   * - 1
+     - 0
+     - Sawtooth falling ramp: a new ramp starts at every DRCTL falling edge,
+       which happens periodically at the falling ``integration_time``. The
+       rising ``integration_time`` is not used.
+
+   * - 0
+     - 0
+     - Bidirectional continuous ramp. DRCTL is not relevant and it is held
+       low.
+
+The DRCTL output is disabled when the resulting PWM period is zero, e.g., when
+the relevant ``integration_time`` attributes are set to ``0``. Without a PWM
+assigned to the DRCTL pin, writing to ``integration_time`` fails with
+``-EOPNOTSUPP``.
+
 Usage examples
 ^^^^^^^^^^^^^^
 
@@ -525,6 +579,30 @@ Configure a frequency sweep from 40 MHz to 60 MHz with a rate of change of
   # Enable the DRG with frequency as the destination
   echo 1 > /sys/bus/iio/devices/iio\:device0/out_frequency130_en
 
+With the same limits and rate of change, each ramp takes 0.8 ms to complete.
+Configure a PWM-driven triangular sweep that dwells 0.2 ms at each limit:
+
+.. code-block:: bash
+
+  # Enable dwell on both limits, so DRCTL controls the ramp direction
+  echo 1 > /sys/bus/iio/devices/iio\:device0/out_frequency131_dwell_en
+  echo 1 > /sys/bus/iio/devices/iio\:device0/out_frequency132_dwell_en
+
+  # DRCTL high for 1 ms (rising ramp) and low for 1 ms (falling ramp)
+  echo 0.001 > /sys/bus/iio/devices/iio\:device0/out_frequency131_integration_time
+  echo 0.001 > /sys/bus/iio/devices/iio\:device0/out_frequency132_integration_time
+
+Configure a rising sawtooth sweep that restarts every 1 ms:
+
+.. code-block:: bash
+
+  # No dwell at the upper limit: the ramp returns to the lower limit
+  echo 0 > /sys/bus/iio/devices/iio\:device0/out_frequency131_dwell_en
+  echo 1 > /sys/bus/iio/devices/iio\:device0/out_frequency132_dwell_en
+
+  # A new rising ramp starts every 1 ms
+  echo 0.001 > /sys/bus/iio/devices/iio\:device0/out_frequency131_integration_time
+
 RAM mode
 --------
 

-- 
2.43.0


