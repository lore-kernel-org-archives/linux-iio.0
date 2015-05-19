Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-050.synserver.de ([212.40.185.50]:1104 "EHLO
	smtp-out-023.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752446AbbESRxs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2015 13:53:48 -0400
Message-ID: <555B78A3.2030202@metafoo.de>
Date: Tue, 19 May 2015 19:53:39 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Xander Huff <xander.huff@ni.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, ben.shelton@ni.com, joshc@ni.com,
	joe.hershberger@ni.com
Subject: Re: [PATCH 2/2] iio: adc: xilinx-xadc: Add xlnx,extend-name as an
 optional argument for aux channels
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com> <1431038644-41600-2-git-send-email-xander.huff@ni.com>
In-Reply-To: <1431038644-41600-2-git-send-email-xander.huff@ni.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/2015 12:44 AM, Xander Huff wrote:
> To better facilitate user-mode access to optional aux channels, allow
> device trees to specify a custom extended name for defined channels.

Hi,

'extend-name' is kind of a IIO specific term. I think a better name in the 
devicetree context would be 'label'. That's used everywhere else when giving 
a short description string to a node.

- Lars
