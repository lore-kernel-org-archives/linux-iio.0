Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-072.synserver.de ([212.40.185.72]:1168 "EHLO
	smtp-out-033.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751496AbcBOQvb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2016 11:51:31 -0500
Subject: Re: libiio and unindexed channel
To: Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org, paul.cercueil@analog.com
References: <56C1F92D.2020506@parrot.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56C2020F.9000902@metafoo.de>
Date: Mon, 15 Feb 2016 17:51:27 +0100
MIME-Version: 1.0
In-Reply-To: <56C1F92D.2020506@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/15/2016 05:13 PM, Gregor Boirie wrote:
> Hi all,
> 
> I hope it is the right place to post for libiio related problems. Please,
> forgive my mistakeif it is not.
> 
> I'm facing a rather odd problem with unindexed channel (as declared
> in ms5611 pressure driver iio_chan_spec 's). libiio does not consider
> pressure and temperature channels exposed by the driver as...
> channels.
> 
> Trying to figure out why, I looked into libiio local backend and found
> that:
> * on tag v0.6, libiio simply consider unindexed driver channels as
>   device attribute (see local.c:942) ;
> * on actual master, libiio will promote unindexed driver channels to
>   channels BUT without the scan_element ability (see local.c:1130)
> 
> I don't fully understand what real difference it makes but libiio manual
> says:
> </quote>
> a channel that is a scan element is a channel that can generate samples
> (for an input channel) or receive samples (for an output channel) after
> being enabled.
> <quote/>
> 
> I feel a bit lost here : I thought input channels were always able to
> generate samples. What is this iio_channel_is_scan_element() here
> for ? From userspace point of view, what channel indices should be used
> for ?
> 
> Many thanks in advancefor sharing your time and knowledge.
> Regards,
> Gregor.
> 
> P.S.: by the way, setting the "indexed" field of iio_chan_spec's in
> ms5611_core.c makes libiio see temperature and pressure as channels.

Hi,

One of the major issues of the current IIO userspace ABI is that it is not
really machine readable friendly. libiio employs a couple of heuristics to
try to recover the original information. Your usecase is currently not
covered by the heuristics. But it should be fairly easy to add. If there is
a entry in scan_elements/ whether it has a index or not it should cause
libiio to infer a channel for it. Patches welcome.

- Lars

