Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34752 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcFVJBz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 05:01:55 -0400
Received: by mail-lb0-f180.google.com with SMTP id oe3so18432960lbb.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 02:01:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <576A46EB.9040505@metafoo.de>
References: <1464572270-29154-1-git-send-email-mranostay@gmail.com>
 <6e79df7d-4ac1-3a44-e303-af858f30e161@kernel.org> <576A46EB.9040505@metafoo.de>
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 22 Jun 2016 02:01:13 -0700
Message-ID: <CAKzfze-SdCWkmvbHJifeeTyqRsvvxe=p5hwdrRj5OnbuSDmE6A@mail.gmail.com>
Subject: Re: [PATCH v3] iio: temperature: add support for Maxim thermocouple chips
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Marek Vasut <marex@denx.de>,
	Matt Porter <mporter@konsulko.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 22, 2016 at 1:06 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 06/03/2016 02:33 PM, Jonathan Cameron wrote:
>> On 30/05/16 02:37, Matt Ranostay wrote:
>>> Add initial driver support for MAX6675, and MAX31885 thermocouple chips.
>
> Is this a typo? There does not seem to be a MAX31885, only MAX31855.
>

Gah! Yes it is... will fix in next revision..

But any issues with the buffer invalidation?
