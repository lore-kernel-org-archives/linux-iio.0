Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35099 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcFCHwR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 03:52:17 -0400
Received: by mail-wm0-f47.google.com with SMTP id a136so263268806wme.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2016 00:52:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464926549-43040-1-git-send-email-rocky.hsiao@dyna-image.com>
References: <1464926549-43040-1-git-send-email-rocky.hsiao@dyna-image.com>
From: Benson Leung <bleung@chromium.org>
Date: Fri, 3 Jun 2016 09:51:56 +0200
Message-ID: <CANLzEksFyFAuEeqs_hA63fFqhCr3xgfAa+mK3561WA24FW5Ngw@mail.gmail.com>
Subject: Re: [PATCH] Dyna-Image AL3320A update, add AL3010 driver
To: Rocky Hsiao <rocky.hsiao@dyna-image.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Olof Johansson <olofj@chromium.org>,
	Filipe Brandenburger <filbranden@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sonny Rao <sonnyrao@chromium.org>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Matt Ranostay <mranostay@gmail.com>,
	Puthikorn Voravootivat <puthik@chromium.org>,
	Andreas Dannenberg <dannenberg@ti.com>,
	linux-iio@vger.kernel.org, John Huang <john.huang@dyna-image.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Rocky,

On Fri, Jun 3, 2016 at 6:02 AM, Rocky Hsiao <rocky.hsiao@dyna-image.com> wrote:
>
> 1. Change al3320a.c to match light sensor test flow.
> 2. Add al3010.c to add new device AL3010.
>    original file copy from al3320a.c
>
> Signed-off-by: Rocky Hsiao <rocky.hsiao@dyna-image.com>
> ---
>  .../config/x86_64/chromiumos-x86_64.flavour.config |   2 +
>  drivers/iio/light/Kconfig                          |  10 +
>  drivers/iio/light/Makefile                         |   1 +
>  drivers/iio/light/al3010.c                         | 301 +++++++++++++++++++++
>  drivers/iio/light/al3320a.c                        |  73 ++++-
>  5 files changed, 378 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/iio/light/al3010.c
>
> diff --git a/chromeos/config/x86_64/chromiumos-x86_64.flavour.config b/chromeos/config/x86_64/chromiumos-x86_64.flavour.config
> index 7d2bed4..7980a14 100644
> --- a/chromeos/config/x86_64/chromiumos-x86_64.flavour.config
> +++ b/chromeos/config/x86_64/chromiumos-x86_64.flavour.config


This looks like this patch was based on a chromeos-kernel. As was
mentioned by Daniel, don't do this for submissions to linux-kernel or
linux-iio. Base this on the linux-iio tree.


-- 
Benson Leung
Senior Software Engineer, Chrom* OS
bleung@chromium.org
