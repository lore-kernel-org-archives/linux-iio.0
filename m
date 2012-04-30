Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:44593 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab2D3K1Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2012 06:27:24 -0400
Message-ID: <4F9E6909.6090409@cam.ac.uk>
Date: Mon, 30 Apr 2012 11:27:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: add mcp4725 I2C DAC driver
References: <1335719618-28295-1-git-send-email-pmeerw@pmeerw.net> <1335719618-28295-2-git-send-email-pmeerw@pmeerw.net> <4F9E5ED3.1010400@cam.ac.uk> <alpine.DEB.2.01.1204301215220.27698@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1204301215220.27698@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/30/2012 11:18 AM, Peter Meerwald wrote:
> Hello Jonathan,
>
>> Mostly fine.   As I explain below you were a little unlucky in which driver to
>> base on.  Roland's driver is lovely and clean, but is lagging a bit in interface
>> terms.
> thank you for your comments!
> I'll see if I understand the chan_spec interface enough
>
> so the plan is to have part of iio in staging and the other part (core)
> in 3.5? and I can submit a driver to go in one or the other?
Yes. So far I've concentrated on moving the core infrastructure out of 
staging.
This was not really because anyone was happy with it all, but rather that
some chunks of code were getting stalled because the companies in question
weren't willing to have drivers for them in staging and others were 
insisting that
the driver be in IIO. The userspace abi's are stable (kernel ones no 
where near!)
so there was nothing blocking the move.
> regards, p.
>

