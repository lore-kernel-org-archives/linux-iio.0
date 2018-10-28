Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ2BhQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 21:37:16 -0400
Date: Sun, 28 Oct 2018 16:52:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 0/6] staging:iio:ad2s90: Add scale info and improve
 error handling
Message-ID: <20181028165202.52ee89b3@archlinux>
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 26 Oct 2018 22:59:59 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch set adds scale info to ad2s90's single channel, improve
> error handling in it's functions and fix a possible race condition
> issue.
> 
> The goal with this patch set is to address the points discussed in the
> mailing list in an effort to move ad2s90.c out of staging.
Thanks,

A good series in general.  A few suggested improvements.
If I haven't commented on a patch, usually it means I'm happy with it
and will pick it up with the rest of the series.

Jonathan

> 
> Changes in v2:
>  - Added my S-o-B in patch 5.
> 
> Matheus Tavares (5):
>   staging:iio:ad2s90: Make read_raw return spi_read's error code
>   staging:iio:ad2s90: Make probe handle spi_setup failure
>   staging:iio:ad2s90: Remove always overwritten assignment
>   staging:iio:ad2s90: Move device registration to the end of probe
>   staging:iio:ad2s90: Check channel type at read_raw
> 
> Victor Colombo (1):
>   staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and
>     read_raw
> 
>  drivers/staging/iio/resolver/ad2s90.c | 55 ++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 
