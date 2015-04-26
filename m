Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41684 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbDZRAY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 13:00:24 -0400
Message-ID: <553D19A5.1030101@kernel.org>
Date: Sun, 26 Apr 2015 18:00:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, pmeerw@pmeerw.net
CC: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Introduce support for MMC35240 magnetic sensor
References: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/15 16:58, Daniel Baluta wrote:
> This adds support for Memsic's MMC35240 magnetometer. The sensor does
> not offer an interrupt line for data ready so for the moment we only
> expose raw readings via sysfs interface.
> 
> This patchset also adds ACPI and Power Management support.
> 
> Changes since v1:
> 	* fixed nits reported by Peter and Jonathan
> 	* https://lkml.org/lkml/2015/4/15/186
> 
> Daniel Baluta (3):
>   iio: magnetometer: Add support for MEMSIC MMC35240 sensor
>   iio: magnetometer: mmc35240: Add PM sleep support
>   iio: magnetometer: Add ACPI support for MMC35240
> 
>  drivers/iio/magnetometer/Kconfig    |  11 +
>  drivers/iio/magnetometer/Makefile   |   1 +
>  drivers/iio/magnetometer/mmc35240.c | 511 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 523 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/mmc35240.c
> 
I'm happy with the whole series.  Will leave it a few days though to
give Peter time to take another look if he wants (or anyone else
who feels like it!)

Hopefully I'll manage a quick catch up session sometime mid week
as only getting to this stuff on Saturday's is leaving me with quite
a backlog at the moment!

Jonathan

