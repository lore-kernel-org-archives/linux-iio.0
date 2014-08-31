Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42424 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbaHaPut (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 31 Aug 2014 11:50:49 -0400
Message-ID: <54034456.5050004@kernel.org>
Date: Sun, 31 Aug 2014 16:50:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: pushing SOC specific Trigger provider driver to upstream kernel
References: <27E62D98F903554192E3C13AFCC91C3C2B778F57@hbmail01.hb.imgtec.org>
In-Reply-To: <27E62D98F903554192E3C13AFCC91C3C2B778F57@hbmail01.hb.imgtec.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/14 15:50, Naidu Tellapati wrote:
> Hi Mr. Jonathan and all,
> 
For now just cc'd Lars-Peter on the basis Analog have a very similar timer based trigger (still in staging)
and I suspect he has some thoughts on this.

Lars, want to comment?
> My name is Naidu Tellapati from India. I work for Imagination Technologies, India. Thanks in advance for your help in this regard.
> 
> After going through some of the emails in the Linux-IIO email archive, we have taken the following approach to implement our Linux IIO based ADC driver.
> 
> We are planning to have two drivers as part of our implementation.
> 
> 1. Timer's Periodic Interrupt Trigger Provider IIO driver (This driver uses our SOC specific Timer's periodic interrupt)
> 
> 2. The generic IIO ADC driver (This ADC driver uses the periodic Timer Interrupt Trigger provided by the above driver)
> 
> The plan is to push both the drivers upstream to kernel.org. Now please suggest us, do you consider SOC specific Trigger Provider driver as well for pushing upstream to kernel.org ?
> 
> 
> Thanks in advance,
> 
> Regards,
> Naidu.
> 
> 
> 
