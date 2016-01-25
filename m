Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-124.synserver.de ([212.40.185.124]:1112 "EHLO
	smtp-out-013.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932879AbcAYQAK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2016 11:00:10 -0500
Subject: Re: [RFC 2/2] iio: ad5755: added support for switching between
 voltage and current output
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, linux-iio@vger.kernel.org
References: <1453467296-26356-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1453467296-26356-2-git-send-email-sean.nyekjaer@prevas.dk>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56A64686.8030003@metafoo.de>
Date: Mon, 25 Jan 2016 17:00:06 +0100
MIME-Version: 1.0
In-Reply-To: <1453467296-26356-2-git-send-email-sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/22/2016 01:54 PM, Sean Nyekjaer wrote:
> DAC ad5755 have both support for voltage and current output, before the driver
> only had support for switching modes at compile time. Not very smart...
> 
> This patch adds support for switching modes from userspace.
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
> 
> This patch is not done yet :-) I would like to get some feedback of my work.
> I have tested this patch with an ad5755 and it works.
> 
> So if you have any ideas on how I should progress please give me some feedback.

Hi,

I'd like to better understand why this is necessary (or not). What is your
usecase where you need to support switching at runtime?

- Lars

