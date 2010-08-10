Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1281280098-11111-1-git-send-email-jic23@cam.ac.uk>
References: <1281280098-11111-1-git-send-email-jic23@cam.ac.uk>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Tue, 10 Aug 2010 02:55:08 -0400
Message-ID: <AANLkTikjsmcCp2w-6ALb68_NVA2Pzx-fcEa_8uUiouBy@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 0/3] staging:iio: abi updates for new
	drivers from Analog.
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
	barry.song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Aug 8, 2010 at 11:08, Jonathan Cameron wrote:
> Here are the 3 abi update patches needed to make the drivers
> Mike posted to work with the current mainline kernel.

thanks, i merged your changes into our tree and was able to extend
them to another driver (gyro/adis16261).  we did have a tracker item
open to cull imu/volt.h usage, but it wasnt fixed yet as you noticed
;).

question about iio_work_cont though ... we have some drivers using that field.
static void ad7816_interrupt_bh(struct work_struct *work_s)
{
    struct iio_work_cont *wc = to_iio_work_cont_no_check(work_s);
    struct ad7816_chip_info *chip = wc->st;

i'm guessing the ad7816_chip_info.iio_work_cont should be converted to
a work_struct ?
-mike
