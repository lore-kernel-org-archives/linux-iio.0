Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717586;
	b=qt9dhqhvnFMu/6VYWY3XgmwpLXporZ9SdONupzbxjPAxOxX+V1G26JaCmRx1MZ+eu6V2
	 1KVTfrFN6uhpIbEsMmDwpVat0TUE0mPbvRdjHjFnc1qE3NC1Yy2r7jDODJc7i1KUrcsCL
	 PhSrxG73XFKLg35qnJgiAHJia8Dwo27y67dKKowQKczu+3WEi5c/O7ajUN4pEu3dQThJx
	 FFzejHKlAHgdFpxPkC11NGlp3HHzSI7ng5h89sx1BBNwhs4jukIgSIOJDDrVobuTvjcvC
	 9ZreB3LBCYLtk6bWfulViE7Ul8cDCGAzS2OGXvofKnsHnpl1ha61ew7/CoGdi3uxG4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717586;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	b=fB8xVvSZyC6jSOhEE5TeMpV29OJPWDNFxd3pOlq/iClNHnfekVurb/yvTAXofJLhv7V6
	 m5BHP6W5iEHkkaNAy5lS+MJyhl/u6+7irh7ud+Eu8PZCJOZZ2M97mMsJkb9Rh6QlKUk1V
	 lCmGoJAvtxaqq2t871rnGoevWlgDqx4OSIK5pY0kgaLG2WCY41jOdyjJYUCKyEg/fdyFB
	 D8qb2XYIdznTRJ9Qxvrqtz3PEj3+Rzpw+a9GVe4roVHp8+Pg7ojXUoBsYwc9vZY//27f1
	 sEgBLzcJlCS9MgYQQSARLt3y5Etdl3CiCrUtY3KcQPA3pZ6LWOkZnlHIjUmMHjwounQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ophI3+Zb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7B6082BCD;
	Tue,  3 Nov 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ophI3+Zb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717585;
	b=lPrA3OD/V2IMByOoVOwA2VBDQxz29e6p95b/eHMt3Rj8FTwg9tO30uqvNBFUsFecsxyx
	 CvPtqzxAvcL2FAzbqK7/ta3eZBUcIGCS5dqj7vcvder8zuCbxRAb80WZFIgXCLNz1/M+a
	 nzQGcErZmt11wpulFMY5HRRvzH8ntRbCRF7PIOmz0FBBhGqBsoZXRhv8h9TDfjilS5XwO
	 656cDbPSfeArTkUfJ63NMHRcinpqgY4Ws/ePnjEXur5J3pVZqtehaqlTCUjDw7pc0OcLq
	 QFZWZ1lHaLnhWJ4BAgiOXivFmGB9pAHyoGECAFLtYFua9d2HBo++1ffywF7U0PHqfWg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717585;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	b=SPcDNV4fas5mgiq3kHzDSgOtyn6f9encT9ac9OW02RkY9MUya6PHVd5vNJ4bgN8gAiJe
	 MwKTNWGvrjx0AjKjRQkh0CMpymcVvJbSnN5lDpSlS5GyWuqXq0w1zR4TDLqIAYVvPZhOc
	 42CX/11HEA9Mlx7+wyvoBPZWjIJgq8HRM4VKgfBmZGvvYnYEW08c1uFiDfKZtPFLWegr5
	 4T0mJhFglvqcVvvINifiI/Flp8S6coEBF5cwP+13FKPrOZoOEfgjEgFq4bMhwXE1WMCRF
	 XFayzpaP87btVTHQQub+jxPvFkgBMqP2heZb/VaZMzclKRYoW3KJ+HfTVqMnLsSmnMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C172B1F00A18;
	Tue,  3 Nov 2026 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717585;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ophI3+Zbj+OMNNkQzA1dSV3YKkLRbLB6+AOf/i6mlIxgwKAFVSqBmtQBsSRYWPsNj
	 RRgBA/Qcqs0Hx4L4f2iTTn336Q3vK1H3zrLVvkY2LGnwqYrGnpDwa77/vjyl46aTD0
	 +Dxy+F/m+gxL3oAC+ez04xsgfp2OMXtI2ucvo4FNvb4xBeMgAyN9Qi6g+4HrCQU527
	 mTYtGqH48RojghMO6lfvuUSwk1F4teMx2JnuEVUP5gkaf8KdNo84PYI06yUntT4PGN
	 eZ7QVhBtf0QQ2ypvyzdzajQsLIVfAvbjgnFCWYrcBQ8jZB6SFfSC4ec+a1Ho0XHekH
	 +5gz/w8wAOnEg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D2FB6469C2;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Nov 2026 11:53:06 -0300
Subject: [PATCH v3 10/10] docs: iio: ad9910: document DRCTL pin control
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
Message-Id: <20261103-ad9910-backend-support-v3-10-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
In-Reply-To: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=6219;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9AdEqIZ+bYqk9Lw6P7OuqM0LPTI0z5xHBJLcZX+ImKY=;
 b=SF1JYoXgO+FxUz2GP4/tQHNTweCPsntKfTq76xvARUEKSPTFgnFk+uhwJvEgELc01WUcw112a
 Cdfges/M0G1AcSavfuvKQFIVXvcBU9cQckmpKfutUvbedCaFwS5D+hn
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


