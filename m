Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48759 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbcDCJZ5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 05:25:57 -0400
Subject: Re: [PATCH] iio: max5487: Add support for Maxim digital
 potentiometers
To: Daniel Baluta <daniel.baluta@intel.com>,
	Peter Rosin <peda@axentia.se>
References: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
 <9dc210ed21cc467699ec0a33a62507f9@EMAIL.axentia.se>
 <CAEnQRZBBVuYSBNPXTTSR0UeiQa8UH8TVndzn5AhrWWYp-iSQKA@mail.gmail.com>
Cc: Cristina Moraru <cristina.moraru09@gmail.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5700E1A3.6020204@kernel.org>
Date: Sun, 3 Apr 2016 10:25:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBBVuYSBNPXTTSR0UeiQa8UH8TVndzn5AhrWWYp-iSQKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/16 09:28, Daniel Baluta wrote:
>> .wipers and .max_pos need not be in max5487_cfg, they are common.
>> .wipers isn't even used. Which means that if you like, you can
>> use the ohms reading as the driver_data directly instead of going
>> via the MAX548x enumeration, see below. Or is there some reason
>> not doing so?
> 
> You make a good point. Anyhow we thought of a generic approach. In the future
> this chip family could support more wipers with different positions.
Make it generic when you need too.  Easy enough to add later!

J
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

