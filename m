Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36087 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbcG0J3N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 05:29:13 -0400
MIME-Version: 1.0
In-Reply-To: <1469484416-17305-1-git-send-email-colin.king@canonical.com>
References: <1469484416-17305-1-git-send-email-colin.king@canonical.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 27 Jul 2016 02:28:26 -0700
Message-ID: <CAKzfze97P6yJEMAeg6Wv5UMDV4iuqBSQOdeLjG1Ctf_xywQxSg@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: fix typo in val assignment
To: Colin King <colin.king@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Sanchayan Maity <maitysanchayan@gmail.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 25, 2016 at 3:06 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Fix an incorrect assignment due to a typo on a variable name. The
> variable val2 should be assigned 100000 and not val.

Yikes! Good catch..

Reviewed-By: Matt Ranostay <mranostay@gmail.com>

>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index ae038a5..407f141 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -434,7 +434,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
>                         break;
>                 case IIO_ELECTRICALCONDUCTIVITY:
>                         *val = 1; /* 0.00001 */
> -                       *val = 100000;
> +                       *val2 = 100000;
>                         break;
>                 case IIO_CONCENTRATION:
>                         *val = 0; /* 0.000000001 */
> --
> 2.8.1
>
