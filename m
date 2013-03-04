Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60104 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758775Ab3CDVEI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2013 16:04:08 -0500
Message-ID: <51350C47.5020401@kernel.org>
Date: Mon, 04 Mar 2013 21:04:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Voltage scale, milli or micro?
References: <5134E53E.1090108@metafoo.de>
In-Reply-To: <5134E53E.1090108@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/2013 06:17 PM, Lars-Peter Clausen wrote:
> Hi,
> 
> So according to our documentation the voltage channel scale is in
> microvolts, but for some odd reason almost all drivers report the scale in
> millivolts. In the IIO hwmon bridge we also have this comment "Assumes that
> IIO and hwmon operate in the same base units. This is supposed to be true,
> but needs verification for new channel types." and hwmon also uses
> millivolts. So I'm wondering should we fix all our drivers to match the
> specification or should we update the specification to match reality.
> I would prefer the later.
> 
Definitely go with updating the spec given nothing conforms to it anyway.
Guess we'll have to check that though.

Jonathan
> - Lars
> 
