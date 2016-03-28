Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35842 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcC1SRJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 14:17:09 -0400
MIME-Version: 1.0
In-Reply-To: <56F946AA.9070203@kernel.org>
References: <20160323085720.GA6836@x220>
	<56F946AA.9070203@kernel.org>
Date: Mon, 28 Mar 2016 20:17:08 +0200
Message-ID: <CAGhQ9Vztpo7gdrxxFdmjcNLe_dMXjYx1QHdiRUoXN4quhsPRNw@mail.gmail.com>
Subject: Re: [PATCH v5] iio: potentiometer: add driver for Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X
From: Joachim Eastwood <manabian@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Slawomir Stepien <sst@poczta.fm>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28 March 2016 at 16:58, Jonathan Cameron <jic23@kernel.org> wrote:
> On 23/03/16 08:57, Slawomir Stepien wrote:
>> The following functionalities are supported:
>>  - write, read from volatile memory
>>
>> Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22060b.pdf
>>
>> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> One process comment below... And git actually copes fine with what you
> did (I wondered which way it would go until I tried it :)
>
> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play pingpong with it.
>
> A very nice, clean driver.  Thanks for your hard work on this.
>
> Note it is in a branch I happy to rebase for the next week, so if Joachim
> in particular would like to add a reviewed by tag, I'd be delighted to append
> it.  Often reviewers don't get enough credit in my opinion!

Sure;
Reviewed-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
