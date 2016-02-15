Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30869 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbcBOQNe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Feb 2016 11:13:34 -0500
Message-ID: <56C1F92D.2020506@parrot.com>
Date: Mon, 15 Feb 2016 17:13:33 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>, <paul.cercueil@analog.com>
Subject: libiio and unindexed channel
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

I hope it is the right place to post for libiio related problems. Please,
forgive my mistakeif it is not.

I'm facing a rather odd problem with unindexed channel (as declared
in ms5611 pressure driver iio_chan_spec 's). libiio does not consider
pressure and temperature channels exposed by the driver as...
channels.

Trying to figure out why, I looked into libiio local backend and found
that:
* on tag v0.6, libiio simply consider unindexed driver channels as
   device attribute (see local.c:942) ;
* on actual master, libiio will promote unindexed driver channels to
   channels BUT without the scan_element ability (see local.c:1130)

I don't fully understand what real difference it makes but libiio manual
says:
</quote>
a channel that is a scan element is a channel that can generate samples
(for an input channel) or receive samples (for an output channel) after
being enabled.
<quote/>

I feel a bit lost here : I thought input channels were always able to
generate samples. What is this iio_channel_is_scan_element() here
for ? From userspace point of view, what channel indices should be used
for ?

Many thanks in advancefor sharing your time and knowledge.
Regards,
Gregor.

P.S.: by the way, setting the "indexed" field of iio_chan_spec's in
ms5611_core.c makes libiio see temperature and pressure as channels.

