Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from axentia.se ([87.96.186.132]:34870 "EHLO EMAIL.axentia.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbcCYKWn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 06:22:43 -0400
From: Peter Rosin <peda@axentia.se>
To: Cristina Moraru <cristina.moraru09@gmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
Subject: RE: [PATCH] iio: max5487: Add support for Maxim digital
 potentiometers
Date: Fri, 25 Mar 2016 10:20:34 +0000
Message-ID: <6b5caa6c47c34d5eaa302dccf8dd89aa@EMAIL.axentia.se>
References: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
In-Reply-To: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi again,

Cristina Moraru wrote:
> Add implementation for Maxim MAX5487, MAX5488, MAX5489
> digital potentiometers.
> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> CC: Daniel Baluta <daniel.baluta@intel.com>

Some more comments, the mcp4531 chips have n**2 + 1 positions,
therefore .max_pos in that driver isn't the number of wiper positions, it's
the actual maximum value. So, in this driver, the corrent number for
.max_pos would be 255, otherwise the reported scale is wrong (and then
you also need to adjust the EINVAL check in max5487_write_raw to use >
instead of >=).

Further comparison with the mcp4531 driver reveals that this driver does
not support IIO_CHAN_INFO_RAW in max5487_read_raw. I assume the SPI
interface does not support reading back the current value?

Cheers,
Peter
