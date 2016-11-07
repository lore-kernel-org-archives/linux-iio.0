Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35343 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbcKGLhr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2016 06:37:47 -0500
MIME-Version: 1.0
In-Reply-To: <1477262381-7800-2-git-send-email-peda@axentia.se>
References: <1477262381-7800-1-git-send-email-peda@axentia.se> <1477262381-7800-2-git-send-email-peda@axentia.se>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 7 Nov 2016 13:37:44 +0200
Message-ID: <CAEnQRZDgF-x6rNiS1Uv9Evdt1sVfUu9pMF98Z4=r-vKP52C1kA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iio:core: add a callback to allow drivers to
 provide _available attributes
To: Peter Rosin <peda@axentia.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 24, 2016 at 1:39 AM, Peter Rosin <peda@axentia.se> wrote:
> From: Jonathan Cameron <jic23@kernel.org>
>
> A large number of attributes can only take a limited range of values.
> Currently in IIO this is handled by directly registering additional
> *_available attributes thus providing this information to userspace.
>
> It is desirable to provide this information via the core for much the same
> reason this was done for the actual channel information attributes in the
> first place.  If it isn't there, then it can only really be accessed from
> userspace.  Other in kernel IIO consumers have no access to what valid
> parameters are.
>
> Two forms are currently supported:
> * list of values in one particular IIO_VAL_* format.
>         e.g. 1.300000 1.500000 1.730000
> * range specification with a step size:
>         e.g. [1.000000 0.500000 2.500000]
>         equivalent to 1.000000 1.5000000 2.000000 2.500000

Is there any driver using this format? :)

>
> An addition set of masks are used to allow different sharing rules for the
> *_available attributes generated.
>
> This allows for example:
>
> in_accel_x_offset
> in_accel_y_offset
> in_accel_offset_available.
>
> We could have gone with having a specification for each and every
> info_mask element but that would have meant changing the existing userspace
> ABI.  This approach does not.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> [forward ported, added some docs and fixed buffer overflows /peda]
> Signed-off-by: Peter Rosin <peda@axentia.se>

The patch looks good to me at a first glance.
