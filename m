Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36733 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbbFPKbK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jun 2015 06:31:10 -0400
Received: by wigg3 with SMTP id g3so104349623wig.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2015 03:31:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <905a190eec730a8e31863e079a55029612784d93.1434404216.git.knaack.h@gmx.de>
References: <cover.1434404216.git.knaack.h@gmx.de>
	<905a190eec730a8e31863e079a55029612784d93.1434404216.git.knaack.h@gmx.de>
Date: Tue, 16 Jun 2015 13:31:08 +0300
Message-ID: <CAE1zot+y7izi2vJDg7q+VT+GMPdbNymuUmsAOQP0MBVAmzNETw@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio:accel:bmc150-accel: fix counting direction
From: Octavian Purdila <octavian.purdila@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jun 16, 2015 at 12:48 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>
> In bmc150_accel_unregister_triggers() triggers should be unregistered in
> reverse order of registration. Trigger registration starts with number 0,
> counting up. In consequence, trigger number needs to be count down here.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Reviewed-by: Octavian Purdila <octavian.purdila@intel.com>


> ---
>  drivers/iio/accel/bmc150-accel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 4e70f51..cc5a357 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -1464,7 +1464,7 @@ static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
>  {
>         int i;
>
> -       for (i = from; i >= 0; i++) {
> +       for (i = from; i >= 0; i--) {
>                 if (data->triggers[i].indio_trig) {
>                         iio_trigger_unregister(data->triggers[i].indio_trig);
>                         data->triggers[i].indio_trig = NULL;
> --
> 2.3.6
>
