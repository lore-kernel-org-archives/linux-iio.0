Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48998 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbcDCKOI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 06:14:08 -0400
Subject: Re: [PATCH v5] iio: potentiometer: add driver for Microchip
 MCP413X/414X/415X/416X/423X/424X/425X/426X
To: Joachim Eastwood <manabian@gmail.com>
References: <20160323085720.GA6836@x220> <56F946AA.9070203@kernel.org>
 <CAGhQ9Vztpo7gdrxxFdmjcNLe_dMXjYx1QHdiRUoXN4quhsPRNw@mail.gmail.com>
Cc: Slawomir Stepien <sst@poczta.fm>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5700ECED.10803@kernel.org>
Date: Sun, 3 Apr 2016 11:14:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAGhQ9Vztpo7gdrxxFdmjcNLe_dMXjYx1QHdiRUoXN4quhsPRNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/16 19:17, Joachim Eastwood wrote:
> On 28 March 2016 at 16:58, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 23/03/16 08:57, Slawomir Stepien wrote:
>>> The following functionalities are supported:
>>>  - write, read from volatile memory
>>>
>>> Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22060b.pdf
>>>
>>> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
>> One process comment below... And git actually copes fine with what you
>> did (I wondered which way it would go until I tried it :)
>>
>> Applied to the togreg branch of iio.git - initially pushed out as
>> testing for the autobuilders to play pingpong with it.
>>
>> A very nice, clean driver.  Thanks for your hard work on this.
>>
>> Note it is in a branch I happy to rebase for the next week, so if Joachim
>> in particular would like to add a reviewed by tag, I'd be delighted to append
>> it.  Often reviewers don't get enough credit in my opinion!
> 
> Sure;
> Reviewed-by: Joachim Eastwood <manabian@gmail.com>
Added, thanks
> 
> 
> regards,
> Joachim Eastwood
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

