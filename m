Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:38611 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544AbaJUOFg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Oct 2014 10:05:36 -0400
Received: by mail-wg0-f41.google.com with SMTP id b13so1411028wgh.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2014 07:05:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1413897052-19780-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1413897052-19780-1-git-send-email-roberta.dobrescu@gmail.com>
Date: Tue, 21 Oct 2014 17:05:26 +0300
Message-ID: <CAEnQRZC6=WfUCdHfWuGUvwxT59sDfC+BDuN95h7Di=mytGJQ4g@mail.gmail.com>
Subject: Re: [OPW kernel] [PATCH] staging: iio: Documentation: Add support for
 missing IIO modifiers
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: opw-kernel <opw-kernel@googlegroups.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Better subject name: staging: iio: iio_event_monitor: Add support for
missing IIO modifiers

On Tue, Oct 21, 2014 at 4:10 PM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> This patch adds names for the missing IIO modifiers and it removes duplicate
> entries for the names of IIO_MOD_LIGHT_BOTH and IIO_MOD_LIGHT_IR.
> It also adds support for the missing IIO modifiers in the function
> event_is_known.

This looks good. We should separate a bit, at least in the commit message,
the addition of missing identifiers with removing the duplicate ones.

e.g

This patch fixes the missing IIO modifiers in event_is_known function
and iio_modifier_names struct.

While at it remove duplicate name entries of IIO_MOD_LIGHT_BOTH
and IIO_MOD_LIGHT_IR.

>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> ---
>  .../staging/iio/Documentation/iio_event_monitor.c  | 32 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
> index 569d6f8..0300900 100644
> --- a/drivers/staging/iio/Documentation/iio_event_monitor.c
> +++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
> @@ -69,16 +69,29 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_X] = "x",
>         [IIO_MOD_Y] = "y",
>         [IIO_MOD_Z] = "z",
> +       [IIO_MOD_X_AND_Y] = "x&y",
> +       [IIO_MOD_X_AND_Z] = "x&z",
> +       [IIO_MOD_Y_AND_Z] = "y&z",
> +       [IIO_MOD_X_AND_Y_AND_Z] = "x&y&z",
> +       [IIO_MOD_X_OR_Y] = "x|y",
> +       [IIO_MOD_X_OR_Z] = "x|z",
> +       [IIO_MOD_Y_OR_Z] = "y|z",
> +       [IIO_MOD_X_OR_Y_OR_Z] = "x|y|z",
>         [IIO_MOD_LIGHT_BOTH] = "both",
>         [IIO_MOD_LIGHT_IR] = "ir",
>         [IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
>         [IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
> -       [IIO_MOD_LIGHT_BOTH] = "both",
> -       [IIO_MOD_LIGHT_IR] = "ir",
>         [IIO_MOD_LIGHT_CLEAR] = "clear",
>         [IIO_MOD_LIGHT_RED] = "red",
>         [IIO_MOD_LIGHT_GREEN] = "green",
>         [IIO_MOD_LIGHT_BLUE] = "blue",
> +       [IIO_MOD_QUATERNION] = "quternion",
> +       [IIO_MOD_TEMP_AMBIENT] = "ambient",
> +       [IIO_MOD_TEMP_OBJECT] = "object",
> +       [IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
> +       [IIO_MOD_NORTH_TRUE] = "from_north_true",
> +       [IIO_MOD_NORTH_MAGN_TILT_COMP] = "from_north_magnetic_tilt_comp",
> +       [IIO_MOD_NORTH_TRUE_TILT_COMP] = "from_north_true_tilt_comp"

Comma here.

>  };
>
>  static bool event_is_known(struct iio_event_data *event)
> @@ -118,6 +131,14 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_MOD_X:
>         case IIO_MOD_Y:
>         case IIO_MOD_Z:
> +       case IIO_MOD_X_AND_Y:
> +       case IIO_MOD_X_AND_Z:
> +       case IIO_MOD_Y_AND_Z:
> +       case IIO_MOD_X_AND_Y_AND_Z:
> +       case IIO_MOD_X_OR_Y:
> +       case IIO_MOD_X_OR_Z:
> +       case IIO_MOD_Y_OR_Z:
> +       case IIO_MOD_X_OR_Y_OR_Z:
>         case IIO_MOD_LIGHT_BOTH:
>         case IIO_MOD_LIGHT_IR:
>         case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
> @@ -126,6 +147,13 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_MOD_LIGHT_RED:
>         case IIO_MOD_LIGHT_GREEN:
>         case IIO_MOD_LIGHT_BLUE:
> +       case IIO_MOD_QUATERNION:
> +       case IIO_MOD_TEMP_AMBIENT:
> +       case IIO_MOD_TEMP_OBJECT:
> +       case IIO_MOD_NORTH_MAGN:
> +       case IIO_MOD_NORTH_TRUE:
> +       case IIO_MOD_NORTH_MAGN_TILT_COMP:
> +       case IIO_MOD_NORTH_TRUE_TILT_COMP:
>                 break;
>         default:
>                 return false;

Please keep Jonathan (maintainer of IIO subsystem) in Cc.

Daniel.
