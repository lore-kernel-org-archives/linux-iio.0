Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35348 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbcI3TVK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2016 15:21:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id s64so6410024lfs.2
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2016 12:21:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160930161922.GA11685@localhost.localdomain>
References: <20160930161922.GA11685@localhost.localdomain>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 30 Sep 2016 22:21:07 +0300
Message-ID: <CAEnQRZA_vtutS7xbUVi4Xvdkx9Eph+4cuD-MR=A11Fb15ULekw@mail.gmail.com>
Subject: Re: [PATCH] iio: Documentation: Correct the path used to create triggers.
To: Sandhya Bankar <bankarsandhya512@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Alison Schofield <amsfield22@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 30, 2016 at 7:19 PM, Sandhya Bankar
<bankarsandhya512@gmail.com> wrote:
> Correct the path used to create triggers.
>
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  Documentation/iio/iio_configfs.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.txt
> index f0add35..4e5f101 100644
> --- a/Documentation/iio/iio_configfs.txt
> +++ b/Documentation/iio/iio_configfs.txt
> @@ -82,8 +82,8 @@ users to create hrtimer triggers under /config/iio/triggers/hrtimer.
>
>  e.g:
>
> -$ mkdir /config/triggers/hrtimer/instance1
> -$ rmdir /config/triggers/hrtimer/instance1
> +$ mkdir /config/iio/triggers/hrtimer/instance1
> +$ rmdir /config/iio/triggers/hrtimer/instance1
>
>  Each trigger can have one or more attributes specific to the trigger type.
>
> --
> 1.8.3.1
>
