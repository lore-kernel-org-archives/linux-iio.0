Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f196.google.com ([209.85.212.196]:32882 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbJOKaI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Oct 2015 06:30:08 -0400
Received: by wicid10 with SMTP id id10so18125667wic.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2015 03:30:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1444900326-43839-1-git-send-email-marc.andre@netline.ch>
References: <1444900326-43839-1-git-send-email-marc.andre@netline.ch>
Date: Thu, 15 Oct 2015 13:30:06 +0300
Message-ID: <CAEnQRZC4sxWXkUgz7316NrzHYa9GkfneG82PcPKgK00S76W=GA@mail.gmail.com>
Subject: Re: iio:ad5064: Add support for LTC2617
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Marc Andre <marc.andre@netline.ch>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 15, 2015 at 12:12 PM, Marc Andre <marc.andre@netline.ch> wrote:
> Based on the discussion after submitting my patch to add a new driver
> for LTC2617, I've now implemented the support for the LTC2617 (and
> similar) devices into the AD5064 driver.
>
> I've split the implementation into two patches. The first patch adds
> basic support for LTC2617. The second patch fixes the power down
> functionality because the LTC handle that differently than the AD
> devices.
>
> Datasheet for LTC devices:
> LTC2606, LTC2616, LTC2626: http://www.linear.com/docs/6398
> LTC2607, LTC2617, LTC2627: http://www.linear.com/docs/8977
> LTC2709, LTC2619, LTC2629: http://www.linear.com/docs/8477

Please add this links to the commit message of 1/2 patch. Cover
letter will most likely be lost in the linux-iio list archives.
