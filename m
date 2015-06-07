Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47704 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbFGQOf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 12:14:35 -0400
Message-ID: <55746DEA.5020409@kernel.org>
Date: Sun, 07 Jun 2015 17:14:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH V5 0/7] iio: mma8452 enhancements
References: <20150601133943.24925.83080.stgit@localhost>
In-Reply-To: <20150601133943.24925.83080.stgit@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/06/15 14:39, Martin Fuzzey wrote:
> This series adds some additional features to the mma8452 accelerometer driver
> 	* debugfs register access
> 	* transient threshold events
> 	* highpass filter
> 	* interrupt driven sampling (trigger)
> 
> Attributes are added to the core for:
> * highpass filter for readings
> * both high and lowpass filters for events
> 
> In addition a latent bug in the device initialisation is fixed.
> 
> V5 changes:
> 	* Moved event highpass filter event attribute declaration
> 	 from patch 4 to 6 (to be with the implementation code)
> 	* Added a validate_device function to prevent use of trigger
> 	with other devices
> 
> The first three patches have already been applied to -next but have
> been resent, unchanged, in this series to keep it all together.
> 
Even more confusing, where is patch 3?
