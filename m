Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-143.synserver.de ([212.40.185.143]:1381 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751959AbbKWJij (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2015 04:38:39 -0500
Message-ID: <5652DE33.4000008@metafoo.de>
Date: Mon, 23 Nov 2015 10:36:51 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Michael.Hennerich@analog.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio/adc/ad9467.c: Add support for AD9649
References: <1447658287-7785-1-git-send-email-mike.looijmans@topic.nl> <5651B19B.90504@kernel.org>
In-Reply-To: <5651B19B.90504@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/22/2015 01:14 PM, Jonathan Cameron wrote:
> On 16/11/15 07:18, Mike Looijmans wrote:
>> The AD9649 is a 14-bit 20-80Msps ADC.
> Hi Mike,
> 
> This patch is missing a sign-off. Please resend with one - see
> Documentation/SubmittingPatches if you want more detail.
> 
> Also more excitingly this file doesn't actually exist in the iio tree.
> Guessing this patch is against Analog's tree?
> If so you'll need to work on persuading them to send it upstream.

Yes, we'll take it through the ADI tree.

> 
> Lars, Michael? I'm going to hazard a guess that this was sat waiting
> for the DMA patches to be upstreamed and might show up sometime soonish for review?

The DMA support is one of the prerequisites for this drivers, there are
others as well. But we'll get there soonish, hopefully.

