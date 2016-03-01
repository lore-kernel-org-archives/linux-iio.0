Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37066 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbcCAJiY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2016 04:38:24 -0500
MIME-Version: 1.0
In-Reply-To: <56D559F4.3040606@posteo.de>
References: <56D559F4.3040606@posteo.de>
Date: Tue, 1 Mar 2016 11:38:22 +0200
Message-ID: <CAEnQRZCx7nFhJfA31mfdTicCppfh-n7usKucQx1dvjPuFNESsA@mail.gmail.com>
Subject: Re: extending /sys/.../iio:deviceX/in_accelX_power_mode
From: Daniel Baluta <daniel.baluta@intel.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matt Ranostaj <mranostay@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	mfuzzey@parkeon.com,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 1, 2016 at 10:59 AM, Martin Kepplinger <martink@posteo.de> wrote:
> Would it be ok, if adding in_accelX_power_mode to a driver, to extend it
> so that in_accel_power_mode_available offers:
>
> low_noise low_power low_power_low_noise normal
>
> if there's a default "normal" mode, plus options to increase or decrease
> oversampling / power consumption for my device?
>
> Specifically I'm unsure about "low_power_low_noise" being enough
> user-friendly. The chip I work with just happens to offer these 4 modes.
> Would you leave out "low_power_low_noise" and go with
>
> low_noise low_power normal
>
> or is it not even desired to add "normal" to the list?
>
> Although strictly not necessary, I would add any new addition to the
> Documentation as well.

The problem with this is that is not uniform across sensors. What
chip are you looking at?

For example INV6500 has:
* sleep mode
* standby mode
* etc.

Daniel.
