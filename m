Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D0496D4A
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971529; cv=none; b=JKckd99TjkxjqxqN4XH1wjQg82OqoBCnhe3Vb7xTcHX/tn5N9CVrgndzBDj6VWAXyQTCth0AGxuKTcU6trauzx5PRIqU2JVXnV4yjVvBYaFq669f6gag+s5YLooENiAoLGvD/OX+dy79LS8LPQ9+WI0MIQtKUMDmi1eB3dVXSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971529; c=relaxed/simple;
	bh=1P2H4aQIabAAYjQAcV3gyWmec7MeuHESTbXJ/ZwHW0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ztw4Z9/8JNyIJEInodkNVzcCs1x2XHJZqDQj2ApbEKwSo0xbJjGXRn0X8LTCPrSM/bwRi3OCOqbkz/E6M+Kreevu9iLQcVMuidGnHwkOIxwW/CJe3F1gLp9BUJDZdXZ1DMCOwwfCxKBdPVJ/gbKIJ34puTAQkHJqdCkWw1eZayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HVTz3jsW; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HVTz3jsW"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6cfed5dd083so132205eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790971524; x=1791576324; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hGLOfsMliwOpjvjoVWru3ZxxJGoZY5MaKdQvca3BhcY=;
        b=HVTz3jsWaMmvonsrMGHDJlFFP9DjUd6shkJiCDy8qkunv93QaD/Sr+hGllQNqnMvu8
         +GWW3QTm1q5Qm7kunLenmoCAYFb5M2uUUVZ7/51EYx/C6JvEKcX40dw6FD3AOyMVPA2i
         fsrUN/fO3UpMYza9nNAmCK70bSgZFTIGNhzBM6FnXkzC+5GvESi6Cr+3tDQgcCVaJ0pN
         9zkTBxT1/kX9PkgQ3UWGjIA+P3EPK+CWfwkywzjNboSYQhGDueo3pIwwz7USwXv7jgLN
         VbtJM9xuQxna+lL0Hs1QGahRYIraP9o7/GXuzCC+Hcm2GmaDqWq+/hC7xXmEbQXjbgII
         r2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971524; x=1791576324;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hGLOfsMliwOpjvjoVWru3ZxxJGoZY5MaKdQvca3BhcY=;
        b=xPk9gRD8ZV467IIA5LWBfj5TzlQ+7xQBFGqSBjtpmva7vRbq++tw6T58SQW2Igy62V
         +81EWTHQ1EGgteam2xDgvJcSwDXJCA+t39bkPFiiRYTbvHLwdvBCKNRShTIqWqdXv6Q3
         2V/mDFGBD+IsDGRyT2wBEbf9fOqclWWmJXMtIjs8p4jlTDxOkFaDTRyhmuyUqOL8IF9o
         7T4KY7AfPSukhiR92+uXawSOTGkA4kk7Cpjsp1+Y5T/4YKvcTRJLq1RYiddmaC0LN1fM
         1ygws0UyADu0GbjT3P27lxfoHFwsMulJJr73Iqf+fYbxnHbb9kHPztnxTPml3gmWtmG5
         wzoQ==
X-Gm-Message-State: AFuF++mbN0I/r0VzXI+POkM+nMSenE4ABzcNVwGnGOmmAtLedvWpEto0
	DpqLcIioHA51BQIufzTjueZ6cAwzH5mkP8fJipSUPxIuY1eY9eTY6ymr8xPNMRB8kT4=
X-Gm-Gg: AYBFou2mG8g/OPVuu5nP6bK9v2O9+xfqdHrFh6AhJDNjJ5la3MpKUU/ChdaFIq+96lg
	A0k9boUNyQA+oiiOSDh9vGjRGzygKsfwZ/kbZZv5qRw3Dszw7T543fqiMahybx6cYpXabqKCFmU
	JT1Ky994Gw83tHSiuI4O4Mk39hOhUw0bwXyQWJl0XOlZASYh29RXNr3dZP04d3LYKmOpBcNNjae
	1ObGj7Pn9t0p4wjj7dQG4RI3f85eJDX0hxNytenkLoc8T30mx1pKIjHgtlSArh5sna7XYuK+Z9l
	6wtGA188OF4cxO0K8itdh6othZzZpIPIWVOrRjI4UynpTQvn+qM+bzCKyAVKbDdgxg8EVeMPXOf
	xK6sfMKg0AwqvmTHfUdBlOXPNP93lRwxcvJkN4pnTLJhdi8GHtB4KMurbNtjpT0QKYh8cV3OFgJ
	H401xmH72bU86F9aj7pGZYo8woCZpodz5tfNV3578gZ5dCrip6TLSOtDZKcElmY2uHSp4M4Bbcq
	ivyylskhQ1HBw==
X-Received: by 2002:a05:6820:310b:b0:6cd:3ffc:e328 with SMTP id 006d021491bc7-6e09ea63c65mr272579eaf.70.1790971523911;
        Fri, 02 Oct 2026 13:05:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b543:49c5:7c72:a244])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6df37fe3061sm3566115eaf.1.2026.10.02.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:05:21 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 02 Oct 2026 15:05:13 -0500
Subject: [PATCH] docs: iio: add documentation for ti-ads112c14 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-iio-adc-ti-ads112c14-docs-v1-1-d5f3efb27727@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAyF4atUnrFUuym0XKViCI4BMzQoLgip6
 t0JMD19w/tXcC2mDsdmhaIvc8tzBe0akFucr4qWqoFb3rcj92iWMSbBxeo4EQsFTFkcuRtoDEP
 fHWKA+n8Uvdj7155Of/vzfFdZvkHYtg+cUvfdfQAAAA==
X-Change-ID: 20260925-iio-adc-ti-ads112c14-docs-2381948537a4
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16237;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=1P2H4aQIabAAYjQAcV3gyWmec7MeuHESTbXJ/ZwHW0U=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqwA56fFNMcZB5IV9UusL1xYpcZIWh66Viaf4XT
 HwXaSECAFSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasAOegAKCRDCzCAB/wGP
 wAaNCACWYn/ukIc6QVV1dZVwpqHDkPtH/3c3y0/tIUWfqPE/5SA8q9pPAzgB/15SUa7XRaRYwJ0
 Od4jM48DVDi2lD3rv9otm9lA13GAHDuRWQO4LBeeJT0MyKwrYkqCMcFexLd16Fz8SQoX10sRcoy
 hdMyD0cBcTQeIyDUJ9JbYNA6RyHnnxPNT6BR0tMSUKuhKBohPufF3QksyqCRxLYaqntyxKLgkpK
 1qNBd1BmejbKabAOsD5svjP4sXjemZo4oPhEZuTdkPXwqCqiLPVYK2rsxDjzAPPspLwWN1MSqKY
 EZfii+fi155jlO0h4OLhZwSwXuLdwj0Hz6rZQ1h1cPuWBGCL
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add documentation for the TI ADS112C14 and ADS122C14 ADC driver.

These chips have several quirks that don't map cleanly to the usual IIO
ABI, so it is worth documenting them for users. This covers how the
devicetree channel nodes map to IIO channels, the system monitor
channels, the order in which the interdependent filter_type,
oversampling_ratio and sampling_frequency attributes need to be written,
the settlingtime attribute and when it applies, burnout current, GPIOs,
debugfs register access and the different behavior of buffered reads
depending on which trigger is used. Also include some devicetree
examples of typical sensor configurations.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 Documentation/iio/ads112c14.rst | 355 ++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst     |   1 +
 MAINTAINERS                     |   1 +
 3 files changed, 357 insertions(+)

diff --git a/Documentation/iio/ads112c14.rst b/Documentation/iio/ads112c14.rst
new file mode 100644
index 000000000000..e3a031e851be
--- /dev/null
+++ b/Documentation/iio/ads112c14.rst
@@ -0,0 +1,355 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+================
+ADS112C14 driver
+================
+
+ADC driver for Texas Instruments ADS112C14 and similar devices. The module name
+is ``ti-ads112c14``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `ADS112C14 <https://www.ti.com/product/ADS112C14>`_ (16-bit)
+* `ADS122C14 <https://www.ti.com/product/ADS122C14>`_ (24-bit)
+
+These are low-power ADCs with 8 analog inputs and an I2C interface. They are
+primarily designed for use with resistive sensors such as RTDs, thermocouples
+and resistive bridges.
+
+Supported features
+==================
+
+Measurement channels
+--------------------
+
+Each ``channel@`` node in the devicetree describes the conditions needed to
+take a particular measurement rather than just a physical input. In addition to
+the analog input(s), this includes the reference source, excitation currents,
+burnout current and input chopping. See the `ti,ads112c14.yaml`_ devicetree
+binding for the details.
+
+.. _ti,ads112c14.yaml: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
+
+The IIO channels in sysfs are named after the analog inputs given in the
+devicetree:
+
+* The ``single-channel = <X>`` devicetree property creates an ``in_voltageX``
+  channel.
+* The ``diff-channels = <X>, <Y>`` devicetree property creates an
+  ``in_voltageX-voltageY`` channel.
+* If the measurement uses the external reference and the
+  ``ti,refp-refn-resistor-ohms`` devicetree property is given, the measurement
+  is ratiometric to the resistor between REFP and REFN, so it is reported as an
+  ``in_resistanceX`` channel instead, where ``X`` is the positive input. In
+  this case, ``raw * scale`` gives the resistance in ohms.
+
+If a devicetree channel node has a ``label`` property, it can be read from the
+``in_*_label`` sysfs attribute.
+
+Unless the ``bipolar`` devicetree property is given, the raw value is unsigned.
+
+The ``in_*_scale`` sysfs attribute selects the PGA gain. The available values
+are listed in the ``in_*_scale_available`` sysfs attribute.
+
+Excitation currents are left enabled after a measurement until a measurement is
+made that does not use them.
+
+System monitor channels
+-----------------------
+
+The following channels are always present in sysfs, regardless of the
+devicetree:
+
+============================ ===============================================
+Channel                      Description
+============================ ===============================================
+``in_temp100``               Internal temperature sensor.
+``in_voltage101``            External reference voltage (REFP - REFN).
+``in_voltage102``            AVDD supply voltage.
+``in_voltage103``            DVDD supply voltage.
+``in_voltage104-voltage104`` Internal short, used for offset calibration.
+============================ ===============================================
+
+The chip measures the external reference, AVDD and DVDD through an internal
+attenuator that divides by 8. This is already taken into account in the scale,
+so ``raw * scale`` gives the actual voltage in millivolts.
+
+The internal short channel has a writable ``in_voltage104-voltage104_scale``
+sysfs attribute so that the PGA gain can be set to match the gain of the
+measurement channel being calibrated.
+
+When the external reference is a resistor driven by the excitation currents
+(e.g. in an RTD configuration), there is only a reference voltage while the
+excitation currents are enabled. So a measurement that uses the excitation
+currents needs to be made first, otherwise the ``in_voltage101`` reading will
+not be meaningful.
+
+Filter type, oversampling ratio and sampling frequency
+------------------------------------------------------
+
+The filter type, oversampling ratio and sampling frequency can be set per
+channel with the ``in_*_filter_type``, ``in_*_oversampling_ratio`` and
+``in_*_sampling_frequency`` sysfs attributes.
+
+On these chips, these three settings are tightly coupled and do not map
+directly to separate register fields. The available values of one attribute
+depend on the current value of the others, so the attributes must be written in
+a specific order:
+
+1. Write ``in_*_filter_type``.
+2. If the filter type is ``sinc4`` or ``sinc4+sinc1``, write
+   ``in_*_oversampling_ratio`` and then ``in_*_sampling_frequency``.
+3. If the filter type is ``sinc4+sinc1+pf1``, write ``in_*_sampling_frequency``
+   and then ``in_*_oversampling_ratio``.
+
+After each write, check the ``*_available`` sysfs attribute of the next
+attribute to see which values can be selected.
+
+Settling time
+-------------
+
+The ``in_*_settlingtime`` sysfs attribute sets the total time for the ADC to
+settle before it outputs the first conversion result after starting conversions
+or after changing settings. The ``in_*_settlingtime_available`` sysfs attribute
+gives the range of allowed values as ``[min step max]``.
+
+The minimum value is the fixed latency of the digital filter for the current
+filter type, oversampling ratio and sampling frequency. This already includes
+the time for the conversion itself. Selecting a larger value adds a
+programmable delay before the conversion starts, which can be used to allow
+external circuitry (e.g. filters on the analog inputs) to settle. The available
+delays are not evenly spaced, so the driver selects the smallest delay that
+gives at least the requested settling time. Read back the attribute after
+writing it to see the actual value.
+
+The settling time applies to more than just the first conversion in some
+cases:
+
+* In single-shot mode, every conversion is a first conversion. This includes
+  reading ``in_*_raw`` and buffered reads that are not using the DRDY trigger
+  (see `Device buffers`_).
+* When input chopping is enabled with the ``input-chopping`` devicetree
+  property, the input mux is swapped after each conversion, so every
+  conversion waits for the settling time. In this case, the actual data rate
+  is lower than ``in_*_sampling_frequency`` and is approximately
+  ``1 / settlingtime``.
+
+Burnout current
+---------------
+
+If a devicetree channel node has the ``burn-out-current-nanoamp`` property, the
+channel has an extra ``in_*_burnoutraw`` sysfs attribute. Reading it takes a
+single conversion with the burnout current sources enabled. This can be used to
+detect an open or shorted sensor. The burnout current affects the accuracy of
+the reading, so it is only enabled for this conversion and not for normal
+reads. Input chopping is also disabled during this conversion since the chip
+does not allow it to be used together with the burnout current sources.
+
+External clock
+--------------
+
+If the ``clocks`` devicetree property is given, the chip is clocked from the
+external clock on the GPIO3 pin instead of the internal 4.096 MHz oscillator.
+The available sampling frequencies and settling times in sysfs are scaled
+accordingly.
+
+I2C CRC
+-------
+
+The I2C CRC feature of the chip is always enabled. The driver checks the CRC of
+all register reads and direct reads. For buffered reads, see `Device buffers`_.
+
+GPIO controller
+---------------
+
+If the ``gpio-controller`` devicetree property is given, the AIN4/GPIO0 to
+AIN7/GPIO3 pins can be used as GPIOs. The lines are named ``iio:deviceN:GPIOx``.
+
+Pins that are used for something else according to the devicetree are not
+available as GPIOs. This includes:
+
+* Analog inputs and excitation current outputs used by any measurement channel
+  (AIN4 to AIN7 are GPIO0 to GPIO3).
+* GPIO0 and GPIO1 when an external reference is used (REFP and REFN share these
+  pins).
+* GPIO2 when ``interrupt-names`` contains ``fault``.
+* GPIO3 when ``interrupt-names`` contains ``drdy`` or when the ``clocks``
+  property is given.
+
+Outputs are always configured as push-pull.
+
+Debugfs register access
+-----------------------
+
+The chip registers can be read and written via the ``direct_reg_access``
+debugfs attribute. This can be used to check settings against the datasheet and
+to check status that is not otherwise available, such as the AVDD and reference
+undervoltage and fault flags in the ``STATUS_MSB`` register (0x02). For
+example:
+
+.. code-block:: bash
+
+    $ cd /sys/kernel/debug/iio/iio:device0
+    $ echo 0x02 > direct_reg_access
+    $ cat direct_reg_access
+
+Writing registers this way bypasses the driver, so it should only be used for
+debugging.
+
+Unimplemented features
+----------------------
+
+* Power management (power-down and standby modes).
+* Monitoring and events (e.g. AVDD and reference undervoltage, /FAULT pin).
+* Open-drain configuration of the GPIO outputs and /DRDY output.
+
+Device buffers
+==============
+
+This driver supports IIO triggered buffers. The behavior depends on which
+trigger is used.
+
+DRDY trigger
+------------
+
+If the ``interrupt-names`` devicetree property contains ``drdy``, the driver
+provides a trigger for it. The driver does not set the interrupt trigger type,
+so it must be given in the ``interrupts`` devicetree property. Since /DRDY is
+active low, this should be ``IRQ_TYPE_EDGE_FALLING``.
+
+When this trigger is used, the chip runs in continuous conversion mode and the
+data is read each time a conversion completes. In this mode, only one channel
+may be enabled at a time, and the data rate is given by the
+``in_*_sampling_frequency`` sysfs attribute of that channel (except when input
+chopping is enabled, see `Settling time`_).
+
+The trigger is not assigned by default, so it has to be selected by writing to
+the ``trigger/current_trigger`` sysfs attribute. The trigger is named
+``<name>-dev<N>-drdy``, where ``<name>`` is the value of the ``name`` sysfs
+attribute of the IIO device and ``<N>`` is the same number as in the
+``iio:device<N>`` directory name of the IIO device. For example, for
+``iio:device0``, ``<N>`` is ``0``:
+
+.. code-block:: bash
+
+    $ cd /sys/bus/iio/devices/iio:device0
+    $ echo "$(cat name)-dev0-drdy" > trigger/current_trigger
+
+Other triggers
+--------------
+
+When any other trigger is used (e.g. an hrtimer trigger), the chip runs in
+single-shot mode and each enabled channel is read in turn each time the trigger
+fires. In this mode, any number of channels may be enabled. Since every
+conversion includes the settling time, the trigger frequency cannot be set as
+high as ``in_*_sampling_frequency``. Each time the trigger fires, it takes at
+least the sum of the ``in_*_settlingtime`` values of all enabled channels plus
+the I2C communication time to read all of the channels. The trigger frequency
+needs to be low enough to allow for this.
+
+Buffer data format
+------------------
+
+Each sample is stored in 32 bits, big-endian, with the conversion result in the
+upper bits. The byte immediately following the conversion result contains the
+CRC byte sent by the chip. The driver does not check this CRC for buffered
+reads, so userspace can use it to detect and discard corrupted samples. The CRC
+is CRC-8 with polynomial 0x07 and initial value 0xFF, calculated over the bytes
+of the conversion result.
+
+Devicetree examples
+===================
+
+The following examples show some typical sensor configurations. See the
+datasheet for the corresponding circuit diagrams.
+
+2-wire RTD
+----------
+
+One excitation current drives both the RTD and the reference resistor, so the
+measurement is ratiometric and the RTD resistance is available from
+``in_resistance1_raw`` and ``in_resistance1_scale``.
+
+.. code-block::
+
+    adc@40 {
+        compatible = "ti,ads122c14";
+        reg = <0x40>;
+        avdd-supply = <&avdd>;
+        dvdd-supply = <&dvdd>;
+        ti,refp-refn-resistor-ohms = <500>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+            diff-channels = <1>, <4>;
+            excitation-channels = <0>;
+            excitation-current-nanoamp = <500000>;
+            reference-sources = "external";
+        };
+    };
+
+3-wire RTD
+----------
+
+Two matched excitation currents are used to cancel out the lead resistance.
+Input chopping is enabled to reduce offset errors.
+
+.. code-block::
+
+    adc@40 {
+        compatible = "ti,ads122c14";
+        reg = <0x40>;
+        avdd-supply = <&avdd>;
+        dvdd-supply = <&dvdd>;
+        ti,refp-refn-resistor-ohms = <500>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+            diff-channels = <1>, <2>;
+            excitation-channels = <0>, <3>;
+            excitation-current-nanoamp = <500000>, <500000>;
+            input-chopping;
+            reference-sources = "external";
+        };
+    };
+
+Resistive bridge with thermistor
+--------------------------------
+
+The bridge is excited by AVDD, which is also connected to REFP, so the bridge
+measurement is ratiometric. The thermistor is measured using the internal
+reference. The labels make it easy to find the channels in userspace.
+
+.. code-block::
+
+    adc@40 {
+        compatible = "ti,ads122c14";
+        reg = <0x40>;
+        avdd-supply = <&avdd>;
+        dvdd-supply = <&dvdd>;
+        refp-supply = <&avdd>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+            diff-channels = <6>, <7>;
+            bipolar;
+            reference-sources = "external";
+            label = "bridge";
+        };
+
+        channel@1 {
+            reg = <1>;
+            diff-channels = <1>, <2>;
+            reference-sources = "internal-2.5v";
+            label = "thermistor";
+        };
+    };
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index d0fb32f4b80f..6f9146d686f5 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -37,6 +37,7 @@ Industrial I/O Kernel Drivers
    adis16475
    adis16480
    adis16550
+   ads112c14
    adxl313
    adxl380
    adxl345
diff --git a/MAINTAINERS b/MAINTAINERS
index ecc22d1149d1..82b8a294e5b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27309,6 +27309,7 @@ M:	David Lechner <dlechner@baylibre.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
+F:	Documentation/iio/ads112c14.rst
 F:	drivers/iio/adc/ti-ads112c14.c
 
 TI ADS1018 ADC DRIVER

---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20260925-iio-adc-ti-ads112c14-docs-2381948537a4

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

