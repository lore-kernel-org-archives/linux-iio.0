Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-012.synserver.de ([212.40.185.12]:1040 "EHLO
	smtp-out-164.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751290Ab3KSLbQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Nov 2013 06:31:16 -0500
Message-ID: <528B4C17.60001@metafoo.de>
Date: Tue, 19 Nov 2013 12:31:35 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mxs-lradc: compute temperature from channel 8 and
 9
References: <1384857392-2199-1-git-send-email-maxime.ripard@free-electrons.com> <alpine.DEB.2.01.1311191149130.18664@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1311191149130.18664@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/19/2013 11:51 AM, Peter Meerwald wrote:
> 
>> The mxs LRADC is able to read an internal die temperature sensor. The
>> temperature has to be calculated from the value read on channel 8 and channel 9.
>> To be able to expose the result to hwmon, implement iio channel 8 as
>> (channel 9 - channel 8). Then, implement IIO_CHAN_INFO_SCALE and
>> IIO_CHAN_INFO_OFFSET so that it can be processed by hwmon through the in kernel
>> provider/consumer mechanism.
> 
> wouldn't IIO_CHAN_INFO_PROCESSED be more suitable than IIO_CHAN_INFO_RAW?

No. PROCESSED means it has the right scale and offset. This is still a raw
value.

- Lars
