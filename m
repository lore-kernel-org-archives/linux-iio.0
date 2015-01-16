Return-Path: <gabriele.mzt@gmail.com>
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: thymythos@googlemail.com
Reply-To: 1419349152.30443.0@smtp.gmail.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7] iio: acpi: Add ACPI0008 ALS driver
Date: Fri, 16 Jan 2015 18:36:48 +0100
Message-ID: <1504751.reIqVWQMRq@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Hi,

I found this driver and I'm quite interested in it since my laptop has
this kind of sensor.

I've noticed a problem with v7, with acpi_als_enable() to be specific.
The ACPI handles used to enable the sensor are not standard and as a
matter of fact they are not available on my system, so the driver fails
to load. This should not happen, I think some quirk should be used here.

Please, Cc me, I'm not suscribed to this list.

Regards,
Gabriele
