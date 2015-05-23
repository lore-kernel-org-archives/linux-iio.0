Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50291 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526AbbEWLXt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 07:23:49 -0400
Message-ID: <55606340.1090403@kernel.org>
Date: Sat, 23 May 2015 12:23:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Xander Huff <xander.huff@ni.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	ben.shelton@ni.com, joshc@ni.com, joe.hershberger@ni.com
Subject: Re: [PATCH 2/2] iio: adc: xilinx-xadc: Add xlnx,extend-name as an
 optional argument for aux channels
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com> <1431038644-41600-2-git-send-email-xander.huff@ni.com> <555B78A3.2030202@metafoo.de>
In-Reply-To: <555B78A3.2030202@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/15 18:53, Lars-Peter Clausen wrote:
> On 05/08/2015 12:44 AM, Xander Huff wrote:
>> To better facilitate user-mode access to optional aux channels, allow
>> device trees to specify a custom extended name for defined channels.
> 
> Hi,
> 
> 'extend-name' is kind of a IIO specific term. I think a better name in the devicetree context would be 'label'. That's used everywhere else when giving a short description string to a node.
> 
Hi Lars,

What do you think of the general idea?  I'm unconvinced we want to do this in channel naming.
Perhaps we want an additional attribute giving access to this sort of 'semantic' information?

