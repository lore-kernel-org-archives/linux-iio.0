Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1154 "EHLO
	smtp-out-153.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753474Ab3IPIRp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 04:17:45 -0400
Message-ID: <5236BEF9.2020002@metafoo.de>
Date: Mon, 16 Sep 2013 10:19:05 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/27] iio: Add iio_push_buffers_with_timestamp() helper
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-4-git-send-email-lars@metafoo.de> <5236B8BA.5050402@kernel.org> <alpine.DEB.2.01.1309160955230.31656@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1309160955230.31656@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/16/2013 09:58 AM, Peter Meerwald wrote:
> 
>> Interesting.  Whilst this obviouslby results in the removal of a lot of
>> repeated code, I am nervous about introducing the 'hidden' requirement
>> that the data buffer passed in must be bigger than is 'apparently' used
>> in the code calling this. I'm not sure what the right answer is though.
> 
> maybe add some iio magic that always allocs the buffer dynamically based 
> on the channel definition/scan_bytes

A lot of drivers already do something like priv_data->buffer =
kzalloc(indio_dev->scan_bytes, ...) in their update_scan_mode callback.
Maybe we can add a transfer_buffer field to the iio_dev struct and have a
function that can be used as a default update_scan_mode callback that
allocates the buffer.

- Lars
