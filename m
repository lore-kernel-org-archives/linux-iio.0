Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35831 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbcIIPfv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2016 11:35:51 -0400
MIME-Version: 1.0
In-Reply-To: <1473434693-5495-1-git-send-email-labbott@redhat.com>
References: <1473434693-5495-1-git-send-email-labbott@redhat.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 9 Sep 2016 18:35:41 +0300
Message-ID: <CAEnQRZBnw_s33+Bbtm9hrG5uqX0HYiCOPfo5RTa3oJ1OHT+dFg@mail.gmail.com>
Subject: Re: [PATCH] iio: Use type header from kernel tree
To: Laura Abbott <labbott@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 9, 2016 at 6:24 PM, Laura Abbott <labbott@redhat.com> wrote:
>
> The iio tools have been updated as new event types have been added to
> the kernel. The tools currently use the standard system headers which
> means that the system may not have the newest defintitions. This leads
> to build failures when building newer tools on older hosts:
>
> gcc -Wall -g -D_GNU_SOURCE   -c -o iio_event_monitor.o
> iio_event_monitor.c
> iio_event_monitor.c:59:3: error: =E2=80=98IIO_UVINDEX=E2=80=99 undeclared=
 here (not in a
> function)
>   [IIO_UVINDEX] =3D "uvindex",
>    ^~~~~~~~~~~
> iio_event_monitor.c:59:3: error: array index in initializer not of
> integer type
> iio_event_monitor.c:59:3: note: (near initialization for
> =E2=80=98iio_chan_type_name_spec=E2=80=99)
> iio_event_monitor.c:97:3: error: =E2=80=98IIO_MOD_LIGHT_UV=E2=80=99 undec=
lared here (not
> in a function)
>   [IIO_MOD_LIGHT_UV] =3D "uv",
>    ^~~~~~~~~~~~~~~~
> iio_event_monitor.c:97:3: error: array index in initializer not of
> integer type
> iio_event_monitor.c:97:3: note: (near initialization for
> =E2=80=98iio_modifier_names=E2=80=99)
> <builtin>: recipe for target 'iio_event_monitor.o' failed
>
> Switch to using the header from the kernel tree to ensure the newest
> defintions are always picked up.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Hi Laura,

Thanks for your patch. The solution here would be to install the
headers for your
new kernel in order to use the updated types.

That is you should run make headers_install.

$ make help | grep headers
  headers_install - Install sanitised kernel headers to INSTALL_HDR_PATH

You can use INSTALL_HDR_PATH to put the headers in a custom directory
and tell gcc to also include this directory when searching for include head=
ers.

Daniel.
