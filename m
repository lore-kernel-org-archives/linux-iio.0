Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50287 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab0FGGM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2010 02:12:58 -0400
Received: by gye5 with SMTP id 5so2001929gye.19
        for <linux-iio@vger.kernel.org>; Sun, 06 Jun 2010 23:12:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1275878775-25681-1-git-send-email-21cnbao@gmail.com>
References: <1275878775-25681-1-git-send-email-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 7 Jun 2010 14:12:35 +0800
Message-ID: <AANLkTinSUT6bxMPlfCKLJ4KoeFKgsvjM2o316VzBsFzy@mail.gmail.com>
Subject: Re: [PATCH] iio: fix typo
To: jic23@cam.ac.uk, gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry, pls ignore this patch because it will destory compiling.
I just want to know why the api is called bps, but the function is call=
ed bpd.
-barry

On Mon, Jun 7, 2010 at 10:46 AM, Barry Song <21cnbao@gmail.com> wrote:
>
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> ---
> =C2=A0drivers/staging/iio/industrialio-ring.c | =C2=A0 =C2=A04 ++--
> =C2=A0drivers/staging/iio/ring_generic.h =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A02 +-
> =C2=A02 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/stagin=
g/iio/industrialio-ring.c
> index ada159b..ac56d9e 100644
> --- a/drivers/staging/iio/industrialio-ring.c
> +++ b/drivers/staging/iio/industrialio-ring.c
> @@ -340,7 +340,7 @@ EXPORT_SYMBOL(iio_read_ring_length);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(iio_write_ring_length);
>
> -ssize_t iio_read_ring_bps(struct device *dev,
> +ssize_t iio_read_ring_bpd(struct device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct device_attribute *attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0char *buf)
> =C2=A0{
> @@ -353,7 +353,7 @@ ssize_t iio_read_ring_bps(struct device *dev,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return len;
> =C2=A0}
> -EXPORT_SYMBOL(iio_read_ring_bps);
> +EXPORT_SYMBOL(iio_read_ring_bpd);
>
> =C2=A0ssize_t iio_store_ring_enable(struct device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_attribute *attr,
> diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio=
/ring_generic.h
> index 0e44375..1b22bdb 100644
> --- a/drivers/staging/iio/ring_generic.h
> +++ b/drivers/staging/iio/ring_generic.h
> @@ -269,7 +269,7 @@ ssize_t iio_write_ring_length(struct device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_attribute *attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *buf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len);
> -ssize_t iio_read_ring_bps(struct device *dev,
> +ssize_t iio_read_ring_bpd(struct device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct device_attribute *attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0char *buf);
> =C2=A0ssize_t iio_store_ring_enable(struct device *dev,
> --
> 1.5.6.3
>
