Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:61419 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964877Ab3GCQ6H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2013 12:58:07 -0400
Message-ID: <51D458E8.4020009@metafoo.de>
Date: Wed, 03 Jul 2013 19:01:28 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Hector Palacios <hector.palacios@digi.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"marex@denx.de" <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH RFC] iio: mxs-lradc: add scaling to enable divide_by_two
 operation
References: <1372845969-31776-1-git-send-email-hector.palacios@digi.com> <51D400FF.5060803@metafoo.de> <51D453AE.3020005@digi.com> <51D4575E.2040002@free-electrons.com>
In-Reply-To: <51D4575E.2040002@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2013 06:54 PM, Alexandre Belloni wrote:
[...]
>> Does the iio provide any descriptor that automatically shows the value
>> in mV (already converted)?
>>
> 
> You can use IIO_CHAN_INFO_PROCESSED to expose that information.

But in this case you really shouldn't. IIO_CHAN_INFO_PROCESSED is for cases
where a non trivial formula is needed to calculate the real value from the raw
value.

- Lars

