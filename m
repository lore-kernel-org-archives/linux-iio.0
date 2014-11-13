Return-Path: <abrestic@google.com>
MIME-Version: 1.0
Sender: abrestic@google.com
In-Reply-To: <1415888044-16635-5-git-send-email-ezequiel.garcia@imgtec.com>
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com>
	<1415888044-16635-5-git-send-email-ezequiel.garcia@imgtec.com>
Date: Thu, 13 Nov 2014 11:10:51 -0800
Message-ID: <CAL1qeaF0LfbeTE4LxL05mHDBeV775AaW2F9+NsHnOMiVdZHNdw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: Add Cosmic Circuits ADC support
From: Andrew Bresticker <abrestic@chromium.org>
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hartley <james.hartley@imgtec.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Ezequiel,

On Thu, Nov 13, 2014 at 6:14 AM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> Here goes the third round of this series. You can find the previous patchset
> and its discussion here: http://thread.gmane.org/gmane.linux.kernel.iio/14553.
>
> Changes from v2:
>
>   * Changed a devicetree property from adc-available-channels to
>     adc-reserved-channels, so it can be made optional.
>
>   * Renamed the driver from cc_10001_xxx to cc10001_xxx so it's consistent
>     with the rest of the kernel style.
>
>   * Some more minor cosmetic fixes.
>
> Changes from v1:
>
>   * Removed unneeded header includes.
>
>   * Changed all the names and macros prefix: s/CC_10001_/CC10001_.
>
>   * Used .update_scan_mode callback to preallocate the buffer.
>
>   * Used indio_dev for the struct iio_dev.
>
>   * Only read the regulator voltage when needed.
>
>   * Fixed probe() error handling.
>
>   * Used for_each_set_bit() instead of open-coding it.
>
>   * Name the power-down register as _POWER_UP, to make the code
>     less silly.
>
>   * Error out when no valid sample can be read (i.e. when end-of-conversion
>     poll times out).
>
>   * ... plus some assorted code cleaning based on the feedback.
>
> Ezequiel Garcia (1):
>   DT: Add a vendor prefix for Cosmic Circuits
>
> Phani Movva (2):
>   iio: adc: Cosmic Circuits 10001 ADC driver
>   DT: iio: adc: Add CC_10001 binding documentation

This series (with v4 of patch 2/3):

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
