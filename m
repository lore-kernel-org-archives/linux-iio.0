Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:36528 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbIEIUF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 04:20:05 -0400
MIME-Version: 1.0
In-Reply-To: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
References: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
Date: Sat, 5 Sep 2015 11:20:02 +0300
Message-ID: <CAEnQRZD=Sy6qPK3+pA_gxqZEdNYRCqUK5O0dk7k16f0D7M-Sow@mail.gmail.com>
Subject: Re: [RFC v1 0/4] iio: new chemical sensor framework and channel types
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 5, 2015 at 8:53 AM, Matt Ranostay <mranostay@gmail.com> wrote:
> Initial RFC for new chemical sensor framework, IIO_CONCENTRATION,
> and IIO_RESISTANCE channel types.
>
> Important notes:
> * Not been tested on real hardware yet but that isn't the main RFC reason and
>   once hardware is in hand it will be verified
> * Reason the IIO_CONCENTRATION type isn't in percent but has modifiers for ppm
>   and ppb is the scale value for the latter would cause a integer overflow
>   using IIO_VAL_FRACTIONAL

Please add this details also in the commit message introducing
IIO_CONCENTRATION. Readers
will faster find commit messages than cover letter.

Interesting patches Matt! :)

thanks,
Daniel.
