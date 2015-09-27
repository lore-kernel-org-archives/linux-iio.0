Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36752 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbbI0N5o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 09:57:44 -0400
Subject: Re: [PATCH 1/3] iio: dac: ad5504: leave sysfs naming to the core
To: Lars-Peter Clausen <lars@metafoo.de>,
	Martin Kepplinger <martink@posteo.de>,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net
References: <1443174310-20428-1-git-send-email-martink@posteo.de>
 <56051904.3060804@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5607F5D6.6010505@kernel.org>
Date: Sun, 27 Sep 2015 14:57:42 +0100
MIME-Version: 1.0
In-Reply-To: <56051904.3060804@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/15 10:51, Lars-Peter Clausen wrote:
> On 09/25/2015 11:45 AM, Martin Kepplinger wrote:
>> This shouldn't actually change anything since the core calls the events
>> sysfs folder "events" anyways.
>>
>> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied, thanks.
> 
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

