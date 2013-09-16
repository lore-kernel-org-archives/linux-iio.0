Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1035 "EHLO
	smtp-out-153.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751426Ab3IPIS2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 04:18:28 -0400
Message-ID: <5236BF1E.906@metafoo.de>
Date: Mon, 16 Sep 2013 10:19:42 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
	Josh Wu <josh.wu@atmel.com>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Ge Gao <ggao@invensense.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 04/27] iio: Add iio_push_buffers_with_timestamp() helper
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-4-git-send-email-lars@metafoo.de> <5236B8BA.5050402@kernel.org>
In-Reply-To: <5236B8BA.5050402@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/16/2013 09:52 AM, Jonathan Cameron wrote:
[...]
> Interesting.  Whilst this obviously results in the removal of a lot of
> repeated code, I am nervous about introducing the 'hidden' requirement
> that the data buffer passed in must be bigger than is 'apparently' used
> in the code calling this. I'm not sure what the right answer is though.

Well it's not that hidden, it is clearly documented that the function is
going to store the timestamp in the buffer. My first idea was to make
storing timestamp a separate function. E.g. like

iio_store_timestamp(indio_dev, buf, ts);
iio_push_to_buffers(indio_dev, buf);

This makes it a bit more explicit that the buffer needs to be large enough
to hold the timestamp. But since that function would always be followed by
iio_push_to_buffers() I choose to add a function that does both, store the
timestamp and push the buffer out.

- Las
