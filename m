Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63957 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaKYQLD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Nov 2014 11:11:03 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so9633865wib.10
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2014 08:11:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416919687-14271-2-git-send-email-vlad.dogaru@intel.com>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
	<1416919687-14271-2-git-send-email-vlad.dogaru@intel.com>
Date: Tue, 25 Nov 2014 18:11:02 +0200
Message-ID: <CAEnQRZAeNkAp1=iCfaY02h_BaEVFueNA=wyf=NUOZe1_3PyTNw@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: dummy: set scan_index for unbuffered channels
From: Daniel Baluta <daniel.baluta@intel.com>
To: Vlad Dogaru <vlad.dogaru@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 25, 2014 at 2:48 PM, Vlad Dogaru <vlad.dogaru@intel.com> wrote:
> If we do not set scan_index explicitly it will default to 0, causing
> more than one channel to have the same scan_index.  This does not make
> sense, as scan_index is used to order values in a buffer sample.
>
> Set the activity and voltage output channels to unbuffered
> (scan_index = -1) to fix this.
>
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/staging/iio/iio_simple_dummy.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index 10a9e08..2948900 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -242,6 +242,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>                 .output = 1,
>                 .indexed = 1,
>                 .channel = 0,
> +               .scan_index = -1,
>         },
>         {
>                 .type = IIO_STEPS,
> @@ -259,6 +260,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>                 .modified = 1,
>                 .channel2 = IIO_MOD_RUNNING,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +               .scan_index = -1,
>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>                 .event_spec = &iio_running_event,
>                 .num_event_specs = 1,
> @@ -269,6 +271,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>                 .modified = 1,
>                 .channel2 = IIO_MOD_WALKING,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +               .scan_index = -1,
>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>                 .event_spec = &iio_walking_event,
>                 .num_event_specs = 1,
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
