Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44230 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaLSRPR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Dec 2014 12:15:17 -0500
In-Reply-To: <E1Y1wmJ-00012E-2N@stardust.g4.wien.funkfeuer.at>
References: <5493BC70.1020006@cdac.in> <E1Y1wmJ-00012E-2N@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Dht11 driver problem
From: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 19 Dec 2014 17:15:18 +0000
To: Harald Geyer <harald@ccbib.org>, Varka Bhadram <varkab@cdac.in>
CC: linux-iio - ML <linux-iio@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>
Message-ID: <0934C50F-E4AC-4A44-8010-DBFBC6C14CA9@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On December 19, 2014 12:35:30 PM GMT+00:00, Harald Geyer <harald@ccbib.org> wrote:
>Hi Varka,
>
>Varka Bhadram writes:
>
>> While reading the DHT11 data from sys file system, its failing.
>> 
>> Its failing because in probe function we register gpio as irq and
>> after that while read raw making same pin as output.
>> 
>> Is there any updated patches to avoid this problem..?
>
>Richard Weinberger is working on a patch series to work around this.
>See
>https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg783710.html
>for details.
> 
>> One more thing is that this driver is not available in IIO git tree.
>
>I don't know what you are refering to here.
>
Master branch is hardly ever used. Try togreg branch for the latest. Not cgit makes it
 harder than it should be to browse particular branches so you may not be
 looking at what you think you are! It has gotten me a few times...

Jonathan
>Harald
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
