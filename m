Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:51408 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab3AaVnI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 16:43:08 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC 00/11] staging/iio: Devicetree support
Date: Thu, 31 Jan 2013 13:42:57 -0800
Message-Id: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds basic device tree support to the IIO subsystem. It is the
result of the [1] and [2] discussions. The patch set is based on v3.8-rc5.

Patches 1 to 7 are either bug fixes or cleanup patches and can at least in
theory be applied immediately, per the subsystem maintainer's choice.

Patch 8 and 9 modify the parameters to iio_channel_get_all_cb(),
iio_channel_get_all(), and iio_map_array_unregister() to prepare for the
subsequent patches. If and how those changes are acceptable is TBD.
Obviously the changes make sense to me, but if anyone has a better solution
please let me know.

Patch 10 adds basic OF support to the IIO subsystem. Support is modeled after
the clock subsystem. Obviously this will need some cleanup, and we'll have to
decide if the approach is acceptable and which OF specific functions will be
required. But it is at least a starting point for the discussion.

Patch 11 adds basic device-tree configuration to the MAX1363 driver;
I needed that for my target system which uses an external reference voltage.

For reference, here is a real dts file snippet:

	max1139: voltage-sensor@35 {
        	compatible = "maxim,max1139";
		reg = <0x35>;
		vref = <3300>;
		#io-channel-cells = <1>;
	};
	...
	iio_hwmon {
		compatible = "iio-hwmon";
		io-channels = <&max1139 0>, <&max1139 1>, <&max1139 2>,
			<&max1139 3>, <&max1139 4>, <&max1139 5>,
			<&max1139 6>, <&max1139 7>, <&max1139 8>,
			<&max1139 9>, <&max1139 10>, <&max1139 11>;
	};

This is the resulting output from the "sensors" command:

iio_hwmon-isa-000a
Adapter: ISA adapter
in1:          +0.00 V
in2:          +3.12 V
in3:          +1.64 V
in4:          +2.50 V
in5:          +3.29 V
in6:          +1.51 V
in7:          +3.30 V
in8:          +3.30 V
in9:          +1.05 V
in10:         +3.30 V
in11:         +1.65 V
in12:         +1.65 V

Probe deferral works quite nicely:

[   17.267086] platform iio_hwmon.10: Driver iio_hwmon requests probe deferral

Guenter

---
[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
[2] http://marc.info/?l=lm-sensors&m=135375101529918&w=1
