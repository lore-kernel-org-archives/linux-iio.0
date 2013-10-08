Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-117.synserver.de ([212.40.185.117]:1109 "EHLO
	smtp-out-117.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab3JHNwF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2013 09:52:05 -0400
Message-ID: <52540E74.3050101@metafoo.de>
Date: Tue, 08 Oct 2013 15:53:56 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: crzy <chskr1016@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: change device attributes dynamically
References: <loom.20131008T094235-776@post.gmane.org>
In-Reply-To: <loom.20131008T094235-776@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/08/2013 09:46 AM, crzy wrote:
> I want to change device attributes at /sys/iio..... for AD-FMCOMMS1-EBZ.When 
> will the driver detects the value is changed?will the driver dynamically 
> detects them ?
> i want to change values dynamically like
> echo 500000000 > out_altvoltage1_DAC_CLK_frequency

Hi,

Yes you can change the attributes dynamically. The driver will update the
registers as soon as you write the new value. But in case of the FMCOMMS1
board you should modify the sampling frequency of the DAC by writing to the
"out_altvoltage_1A_sampling_frequency" attribute of the "cf-ad9122-core-lpc"
device.

- Lars

