Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.158]:33418 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYCBW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Oct 2018 22:01:22 -0400
Date: Wed, 24 Oct 2018 19:32:43 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: potentiometer: tpl0102: add IIO_AVAIL_RANGE
 support
Message-ID: <20181024173243.GB10909@x220.localdomain>
References: <20181024103858.28201-1-matt.ranostay@konsulko.com>
 <20181024103858.28201-3-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181024103858.28201-3-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On paź 24, 2018 11:38, Matt Ranostay wrote:
> Report back the step range of the respective potentiometers that are
> possible back to userspace.

The many "back" in that sentence don't you think? ;)

Maybe: "Report the possible step range of the respective potentiometers back to
userspace."

> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/potentiometer/tpl0102.c | 33 +++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 7 deletions(-)

The rest looks good to me

Reviewed-by: Slawomir Stepien <sst@poczta.fm>

-- 
Slawomir Stepien
