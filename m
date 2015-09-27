Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36739 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbbI0N4N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 09:56:13 -0400
Subject: Re: [PATCH] iio: adc: ad799x: leave sysfs naming to the core
To: Lars-Peter Clausen <lars@metafoo.de>,
	Martin Kepplinger <martink@posteo.de>,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net
References: <1443174841-25782-1-git-send-email-martink@posteo.de>
 <56052F05.90807@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5607F578.1050906@kernel.org>
Date: Sun, 27 Sep 2015 14:56:08 +0100
MIME-Version: 1.0
In-Reply-To: <56052F05.90807@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/15 12:24, Lars-Peter Clausen wrote:
> On 09/25/2015 11:54 AM, Martin Kepplinger wrote:
>> This shouldn't change anything since the core calls the events folder
>> "events" anyways.
>>
>> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
