Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:58931 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161175AbcFIH7r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2016 03:59:47 -0400
Subject: Re: Interface between IIO driver and an input driver
To: Jonathan Cameron <jic23@kernel.org>,
	Marc Titinger <mtitinger@baylibre.com>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-iio@vger.kernel.org
References: <57512F0D.3050009@free-electrons.com>
 <57513C09.2060802@baylibre.com>
 <1fb6beed-af47-8ffc-3422-d5ac53c8e832@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <575921EE.9090808@metafoo.de>
Date: Thu, 9 Jun 2016 09:59:42 +0200
MIME-Version: 1.0
In-Reply-To: <1fb6beed-af47-8ffc-3422-d5ac53c8e832@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2016 11:39 AM, Jonathan Cameron wrote:
> On 03/06/16 09:12, Marc Titinger wrote:
>>
>> Hi All,
>>
>>
>> (sorry Quentin, I here just share a related thought, not actually
>> helping you much).
>>
>> a nice feature would be to have some sort of "mixer" interface,
>> similar to the one common with audio APIs. 
> Lars in particular has been looking at extending the media controller
> interface somewhat in this direction (and into audio ;) This is
> the big hammer solution. It'll be cool in the long run but I don't
> get the impression it'll come terribly quickly.


That's primarily for describing the flow between different hardware modules
in hardware. I think in this case we only have software flow and in my
opinion this hardware is a classical case of multi-function device and
should be implemented as such. The MFD would take care of things like
interrupt multiplexing and resource allocation while each function gets its
own driver making use of the facilities provided by the MFD.
