Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682353;
	b=rdis2a1DI6X3zNeOwwFTAnkFnLhwTBS1V1kRel3RSph5KwFxv88HI+RYHD8Kr9WoXpFc
	 2JgE3dhOjoRxVKzwanLU1Ms8+XounvJ2mXthswNktOFaVaF3kmVdHq19P2UvYvhEVL8sJ
	 5NSbUmgzlfZ862gRJ1zCdn9AflvO5Bw++PB0JnyBEJjk9FSpzMWLYrxUcOBAo1kpVCwwP
	 SCfFu1lAr1RW/Q6lRQC3Oi+SsdLKA5Dwk5h4wc9l+JWBowozeqEJI/8hYVZ6wwuCL7O28
	 6KBJYnXPr+GEszZ5dhkm9yaI0dzpUiF0f+PIrq4GHRZJ+N93cGh7JuXqezhs4YmH9sA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682353;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	b=rh+FJXMpFqIuKTYN9L7k7uThpwI5KnuPqvXqli5uDGXzqz+Y9OPWxKzLL1ZsOvxRx434
	 1VoZ5kpHyQM2XFWsSvCb9uEDpgjgiaLff4Bqj8BCVtjMItK4CiyWHtU3CuewPcq9PFOjX
	 +auU30cXdsjMD3EFusatTmYStYqvz4O/lsH0pEnOD1YXJ6sBw/19B7ePmJpuHYoGrlmUu
	 VQtxJerHKfZaRw3NeEi9tYKOeJBnG1u/smzxKu/GXSvrVMZAvkw+Uz3IZfvuXN5Stv5wC
	 7YMOU27ijqmmULQ6Bf8iNQzImv9dvnrQ5uICmdikZaIzgbRsMQ47NxaRgdPZoVKTMaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkMkVaMR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5003606CC49;
	Thu, 22 Oct 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkMkVaMR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682352;
	b=0qmLwQAqJg8htCiJh2prayla+QSJXGbrtEw+IKYzfBYIwsIW05tfGQ3sPF8Cz3idd01n
	 MK3w/m34BoqzrOxi4iOohbJ0V/GP2r4XvBpseU1ddY+2GCvtKcUhFiRGW7Z9zs+IK8ZjH
	 w3weykxdIRrcFM3MAe2DVvY/US8ihUY+0sw4s4/sJVmIapz5dUve6QM7xFeO+DLJmHcK+
	 BC92tR9JnpvkpELODYcjL1nbIuEj8dL6yzt8J0RgZ0YtD1zXgnZgR5Dkn5JZqmaC83Qzw
	 N6uo5+b2RVLyVQRLAncgT9CXaj/FE1yJnc3Khh2yDCy5DySnBeM+gphbCwQf8pbtejA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682352;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	b=z7xenscEQKLaVKcBAn3/hqFgBAe47ucOVQnxqt37PGShSJos7PfoESWqjH1656m++exr
	 8hgCMG5MxzUFCvX975C9NlB5hBCrGPVk9kgL5HEn3Cp11EipEA6IYQI2upThisiCj3z/H
	 biNaGxWa2tanDjazNITsM5jeiOS6Q9D7OjMBXcKwMOVq+SaM3TvBR7ZdfRDBTKkGT7BDy
	 EqoyF6nAD+bZT9oahBRtoBhYDsUI9bFqCl0ogTxHts9Om7jEAXf/WVLZGPRLEykrhfnA0
	 Qijd1mCqRHDKUbvzgdMWbPsaczmB0w0uYkqwp3kVrLNx/aucgB4X55BlwYm4kZt+MVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 825971F031ED;
	Thu, 22 Oct 2026 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682352;
	bh=6+KUMNWETbOIm1etOJvqfpofFQZLeiAo3ByMDioY4WU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UkMkVaMRETkcUXeOOihD1HEZocJL8C0LNJOb0sRg3PkG1dZJgra5bb9aSThLT3eKq
	 YyUWLu9XtFWCrgG23TYSkqr9tH/4Faqa/epS2HSFGWkhDHx9kxlVd7d2p2KGa0oOy5
	 Z3+ZVCCdega5k/Jgnnq0og6WAWu5oIb0NJRUy1MPCQzYv4sRiv5LQGjLV2/Ghiy8n9
	 OQN5HNfRUVQKAiwa4y5BVNJSsGyAtJ9EYu7NfR2pDzJz/BygHjvwp48q6FPRe8cbUD
	 FSGmBZBvuBumDDOQXu6OpPWU8twjSuoFkp6oezH5pnr8NDeJfpmx8Gl3BWLWCSg+hK
	 utIYjkHFHCSVQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B761B41E6F;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:19:08 -0300
Subject: [PATCH v2 10/10] docs: iio: ad9910: document DRCTL pin control
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
Message-Id: <20261022-ad9910-backend-support-v2-10-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
In-Reply-To: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=6219;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9AdEqIZ+bYqk9Lw6P7OuqM0LPTI0z5xHBJLcZX+ImKY=;
 b=uXb3PIln3CqI5BQMvSFeUzmQlLZ1I31Q5FdLc+gCuiqatzRl2MJl5j89dMPyZZ2mimGOwRjBy
 HED3yDG8d7YByxQfFGWKiPN+Wp+AtN+j4n5YOh7bgHJBjxBBepXlNJT
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


