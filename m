Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:55659 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbaLPLXR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Dec 2014 06:23:17 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so13317241wiv.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2014 03:23:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1418721107-5429-3-git-send-email-roberta.dobrescu@gmail.com>
References: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com>
	<1418721107-5429-3-git-send-email-roberta.dobrescu@gmail.com>
Date: Tue, 16 Dec 2014 13:23:15 +0200
Message-ID: <CAEnQRZCmxDPCJmMPcsVAeX=euOU6EFpy58QnPttKCo7BD8vrxQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: frequency: Remove unnecessary braces around
 single statement block
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 16, 2014 at 11:11 AM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> This patch fixes the following checkpatch.pl warning:
> WARNING: braces {} are not necessary for single statement blocks
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/frequency/adf4350.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 2b301eb..10a0dfc 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -611,9 +611,8 @@ static int adf4350_remove(struct spi_device *spi)
>         if (st->clk)
>                 clk_disable_unprepare(st->clk);
>
> -       if (!IS_ERR(reg)) {
> +       if (!IS_ERR(reg))
>                 regulator_disable(reg);
> -       }
>
>         return 0;
>  }
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
