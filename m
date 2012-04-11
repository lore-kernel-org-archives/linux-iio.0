Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:41374 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab2DKLUs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 07:20:48 -0400
Message-ID: <4F85690D.1050605@cam.ac.uk>
Date: Wed, 11 Apr 2012 12:20:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 00/14] IIO: Kill off IIO_CHAN macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org> <4F856945.9040704@metafoo.de>
In-Reply-To: <4F856945.9040704@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/11/2012 12:21 PM, Lars-Peter Clausen wrote:
> On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
>> This kills off the remaing users and gets rid of it!
>>
>> Please can people sanity check I haven't messed up the
>> removal in their drivers (and anyone elses if they are
>> bored enough!)
> I wrote a small set of cocci scripts which automate the removal and detected
> some small issues. If you are interested in the scripts I've uploaded them
> at http://metafoo.de/kill_iio_chan.tar.bz2
>
> The cocci pretty printer doesn't cope very well with unwinding a macro, so
> I've added some extra sed expressions to cleanup the result.
>
>
Don't suppose you fancy updating those to do the processed and 
unprocessed stuff
you suggested?


