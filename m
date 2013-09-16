Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41494 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3IPRfZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 13:35:25 -0400
Message-ID: <52374F7C.5000308@kernel.org>
Date: Mon, 16 Sep 2013 19:35:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/27] iio: Add iio_push_buffers_with_timestamp() helper
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-4-git-send-email-lars@metafoo.de> <5236B8BA.5050402@kernel.org> <alpine.DEB.2.01.1309160955230.31656@pmeerw.net> <5236BEF9.2020002@metafoo.de>
In-Reply-To: <5236BEF9.2020002@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/16/13 09:19, Lars-Peter Clausen wrote:
> On 09/16/2013 09:58 AM, Peter Meerwald wrote:
>>
>>> Interesting.  Whilst this obviouslby results in the removal of a lot of
>>> repeated code, I am nervous about introducing the 'hidden' requirement
>>> that the data buffer passed in must be bigger than is 'apparently' used
>>> in the code calling this. I'm not sure what the right answer is though.
>>
>> maybe add some iio magic that always allocs the buffer dynamically based 
>> on the channel definition/scan_bytes
> 
> A lot of drivers already do something like priv_data->buffer =
> kzalloc(indio_dev->scan_bytes, ...) in their update_scan_mode callback.
> Maybe we can add a transfer_buffer field to the iio_dev struct and have a
> function that can be used as a default update_scan_mode callback that
> allocates the buffer.
That would probably make sense and remove quite a lot of my concern about these.
Can happen as a later patch set though.

Jonathan
