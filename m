Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1426254366-27021-1-git-send-email-darshanapadmadas@gmail.com>
References: <1426254366-27021-1-git-send-email-darshanapadmadas@gmail.com>
Date: Fri, 13 Mar 2015 15:59:08 +0200
Message-ID: <CAEnQRZD7zQdfX_uMa74dD1Od_ZKzuwtriu22tmjsKJxmif8KOg@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] iio: Add ABI documentation for in_magn
 offset and raw values
From: Daniel Baluta <daniel.baluta@intel.com>
To: Darshana Padmadas <darshanapadmadas@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Mar 13, 2015 at 3:46 PM, Darshana Padmadas
<darshanapadmadas@gmail.com> wrote:
> This patch adds ABI documentation entries for in_magn_offset
> and in_magn_raw. At least one user exists, mag3110 and
> hid-sensor-magn-3d in drivers/iio/magnetometer.

Hi,

Because we have:

* .modified field set to 1
* .channel2 set to some modifier (e.g IIO_MOD_X)
* info_mask_separate  set to IIO_CHAN_INFO_RAW

resulting attributes will be of the form:

* in_magn_x_raw, in_magn_y_raw, in_magn_z_raw etc.


The patch looks good for offset attribute because in hid-sensor-magn-3d we have:
* info_mask_shared_by_type set to IIO_CHAN_OFFSET.

Please use the dummy driver to confirm this. And resend the patch keeping only
the entry for offset.

thanks,
Daniel.
