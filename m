Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <8eb45695460b1131ed1abf72700667aa98e6b5b6.1413858979.git.bvandre@gmail.com>
References: <cover.1413858979.git.bvandre@gmail.com>
	<8eb45695460b1131ed1abf72700667aa98e6b5b6.1413858979.git.bvandre@gmail.com>
Date: Thu, 23 Oct 2014 13:39:11 +0300
Message-ID: <CAEnQRZAcKhMbHg7B5ExnNG2zgixYV5jEPsKPZuCZS-Z+jKfxeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Staging: iio: adc: fix line over 80 characters
From: Daniel Baluta <daniel.baluta@intel.com>
To: Brian Vandre <bvandre@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>,
	alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 21, 2014 at 5:48 AM, Brian Vandre <bvandre@gmail.com> wrote:
> This fixes the checkpatch.pl warning:
> WARNING: line over 80 characters
>
> Signed-off-by: Brian Vandre <bvandre@gmail.com>

As a part of OPW [1] IIO cleanup project [2] we analyzed all checkpatch.pl
warnings / errors and we decided not to fix some of them as there is no
obvious improvement.

This "line over 80 characters" warning was one of them. In my opinion
it doesn't make code easier to read.

thanks,
Daniel.

[1] http://kernelnewbies.org/OPWIntro
[2] http://kernelnewbies.org/IIO_cleanup
