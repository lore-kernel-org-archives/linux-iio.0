Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:35459 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbbFJUQO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2015 16:16:14 -0400
Received: by labko7 with SMTP id ko7so40392762lab.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2015 13:16:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52e7c9b1da4e0918722cc993bd3b25287f342e55.1433721755.git.knaack.h@gmx.de>
References: <cover.1433721755.git.knaack.h@gmx.de>
	<52e7c9b1da4e0918722cc993bd3b25287f342e55.1433721755.git.knaack.h@gmx.de>
Date: Wed, 10 Jun 2015 23:16:12 +0300
Message-ID: <CAEnQRZALJLbyQ9e5_JVr5xi+kH+pEGfPDGisay+C=b0n9XJM8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tools:iio:iio_event_monitor: check if event is
 fully read
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 10, 2015 at 10:51 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Check that the read event is of the expected size.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  tools/iio/iio_event_monitor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 016760e..2559fba 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -299,6 +299,12 @@ int main(int argc, char **argv)
>                         }
>                 }
>
> +               if (ret != sizeof(event)) {
> +                       printf("Reading event failed!\n");
> +                       ret = -EIO;
> +                       break;
> +               }
> +

For a test program this should be good enough, not sure if it does make sense
to read until we get all data.

Also, we should print the error at stderr.

>                 print_event(&event);
>         }

thanks,
Daniel.
