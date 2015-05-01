Return-Path: <gabriele.mzt@gmail.com>
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marxin.liska@gmail.com, marex@denx.de, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: acpi: Add ACPI0008 Ambient Light Sensor
Date: Fri, 01 May 2015 18:12:14 +0200
Message-ID: <10033848.82LkUmdQLq@xps13>
In-Reply-To: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com>
References: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Hi,

probably this is not completely related to this driver, but I
noticed something while testing it.

When I load acpi-als, /sys/bus/iio/devices/iio:device0/buffer/enable
is 0. If I try to set it to 1, I get the following error:
"Buffer not started: buffer parameter update failed (-22)"

After I got the error, I can successfully toggle "enable".

What I found is that the first time iio_request_update_kfifo() is
called, __iio_allocate_kfifo() gets called. Since bytes_per_datum
is 0 (as set iio_compute_scan_bytes()), it returns -EINVAL and so
does iio_request_update_kfifo(), causing the error above.

Subsequent calls of iio_request_update_kfifo() will return 0 as
update_needed is false, so "enable" can be toggled with no errors.

Isn't there something wrong here?

Regards,
Gabriele
