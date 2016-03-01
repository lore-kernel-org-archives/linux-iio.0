Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
Subject: extending /sys/.../iio:deviceX/in_accelX_power_mode
To: Jonathan Cameron <jic23@kernel.org>, daniel.baluta@intel.com,
 lars@metafoo.de, mranostay@gmail.com, hamohammed.sa@gmail.com,
 darshanapadmadas@gmail.com, mfuzzey@parkeon.com, octavian.purdila@intel.com,
 irina.tirdea@intel.com, cristina.opriceana@gmail.com,
 vladimir.barinov@cogentembedded.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <56D559F4.3040606@posteo.de>
Date: Tue, 1 Mar 2016 09:59:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Would it be ok, if adding in_accelX_power_mode to a driver, to extend it
so that in_accel_power_mode_available offers:

low_noise low_power low_power_low_noise normal

if there's a default "normal" mode, plus options to increase or decrease
oversampling / power consumption for my device?

Specifically I'm unsure about "low_power_low_noise" being enough
user-friendly. The chip I work with just happens to offer these 4 modes.
Would you leave out "low_power_low_noise" and go with

low_noise low_power normal

or is it not even desired to add "normal" to the list?

Although strictly not necessary, I would add any new addition to the
Documentation as well.

thanks
                            martin
