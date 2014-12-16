Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:52737 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaLPLZO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Dec 2014 06:25:14 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so16810438wgh.26
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2014 03:25:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1418721366-5566-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1418721366-5566-1-git-send-email-roberta.dobrescu@gmail.com>
Date: Tue, 16 Dec 2014 13:25:13 +0200
Message-ID: <CAEnQRZBcrBgBCL_hT11=vdgODN0qWrjp=XdR=OzPoyQpYrX4bA@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Add a blank line after declarations
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

On Tue, Dec 16, 2014 at 11:16 AM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> This patch fixes the following checkpatch.pl warning:
> WARNING: Missing a blank line after declarations
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/trigger/iio-trig-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index 254c7e9..3dfab2b 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -135,6 +135,7 @@ static int iio_sysfs_trigger_probe(int id)
>         struct iio_sysfs_trig *t;
>         int ret;
>         bool foundit = false;
> +
>         mutex_lock(&iio_sysfs_trig_list_mut);
>         list_for_each_entry(t, &iio_sysfs_trig_list, l)
>                 if (id == t->id) {
> @@ -185,6 +186,7 @@ static int iio_sysfs_trigger_remove(int id)
>  {
>         bool foundit = false;
>         struct iio_sysfs_trig *t;
> +
>         mutex_lock(&iio_sysfs_trig_list_mut);
>         list_for_each_entry(t, &iio_sysfs_trig_list, l)
>                 if (id == t->id) {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
