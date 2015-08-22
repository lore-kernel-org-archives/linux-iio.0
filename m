Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38006 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbbHVR30 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 13:29:26 -0400
Subject: Re: [PATCH v5 6/8] iio: gyro: bmg160: optimize i2c transfers in
 trigger handler
To: Wolfram Sang <wsa@the-dreams.de>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-7-git-send-email-irina.tirdea@intel.com>
 <55D056DF.5020201@kernel.org> <20150817090943.GO19600@pengutronix.de>
 <20150821102125.GA1656@katana> <1440172701.4081.1.camel@intel.com>
 <20150822040258.GA1605@katana>
Cc: "mpa@pengutronix.de" <mpa@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Tirdea, Irina" <irina.tirdea@intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D8B174.1010403@kernel.org>
Date: Sat, 22 Aug 2015 18:29:24 +0100
MIME-Version: 1.0
In-Reply-To: <20150822040258.GA1605@katana>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/15 05:02, Wolfram Sang wrote:
> 
>>>> The series[1] I am working on implements a i2c smbus block data 
>>>> regmap
>>>> bus driver. Regmap should then automatically do a block read in
>>>> regmap_bulk_read.
>>>
>>> Hmm, so doesn't your series make Irina's series obsolete? It 
>>> addresses
>>> the same problem only at a different layer (i2c core vs. regmap), or? 
>>> It
>>> would mean that i2c client drivers which want to support byte, word, 
>>> or
>>> block transfers should be converted to regmap. I assume most of the
>>> potential candidates are register based devices anyhow. Then, regmap
>>> would be the proper abstraction layer. Have I overlooked something?
>>>
>> This is the only driver converted to use regmap, because of SPI mode
>> support. The other drivers will still use Irina's changes.
> 
> The question is if they should. Or rather be converted to regmap. It is
> an open question and I am seeking for further input.
> 
There are a fairly large number of legacy drivers where this might apply.
Do we have any real idea of how many?  I'm assuming Irina only made use
of it in ones that were of personal interest.  A quick grep suggests
10's of drivers use the block call. I'm guessing quite a few would use
it if needed for a particular board.

Do we want to insist on a much larger change (conversion to regmap)
when if this in place, a simple single functional call change will do the
job?

Jonathan
