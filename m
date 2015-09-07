Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-013.synserver.de ([212.40.185.13]:1054 "EHLO
	smtp-out-210.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753534AbbIGIIr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Sep 2015 04:08:47 -0400
Message-ID: <55ED460A.1080706@metafoo.de>
Date: Mon, 07 Sep 2015 10:08:42 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	"open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [RFC v2 4/4] iio: chemical: add SGX VZ89x VOC sensor support
References: <1441593547-10896-1-git-send-email-mranostay@gmail.com>	<1441593547-10896-5-git-send-email-mranostay@gmail.com>	<CAFSKS=NvhBvwknAXs-Pfd-bJ4U6zrXD3zBZT0GaC+w5JUg24ig@mail.gmail.com>	<CAKzfze_UBjKauqqCLDSkUu-ee+ZC0VzQCaYpZEgpfRny_H4y1A@mail.gmail.com> <CAKzfze8sEkr5q6-X42Z24nqrqy8JMdqL3omRKOraz1G0BehyJg@mail.gmail.com>
In-Reply-To: <CAKzfze8sEkr5q6-X42Z24nqrqy8JMdqL3omRKOraz1G0BehyJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/2015 06:27 AM, Matt Ranostay wrote:
> Thinking this over do we needed a IIO_CHAN_INFO_PROCESSED_OFFSET to
> signal that it needs to be after the (value - offset) * scale
> calculation?

Well, value * scale + offset = (value + offset/scale) * scale. So just scale
your offset inversely to the scale.

