Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-171.synserver.de ([212.40.185.171]:1045 "EHLO
	smtp-out-171.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbCXMaX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2015 08:30:23 -0400
Message-ID: <551158E0.7040401@metafoo.de>
Date: Tue, 24 Mar 2015 13:30:24 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
	daniel.baluta@intel.com
Subject: Re: [PATCH] iio: Add ABI documentation for out_voltage scan_elements
References: <1426588609-24683-1-git-send-email-hamohammed.sa@gmail.com> <550D5D41.7070606@kernel.org>
In-Reply-To: <550D5D41.7070606@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/21/2015 01:00 PM, Jonathan Cameron wrote:
> On 17/03/15 10:36, Haneen Mohammed wrote:
>> This patch adds ABI documentation entries for out_voltageY_en,
>> out_voltageY_type, and out_voltageY_index.
>> At least one user for these is preset:
>> AD8366 SPI Dual-Digital VGA.
>>
>> Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
> These aren't used in the mainline driver.  We don't have buffered support
> for output channels yet.  Looking at Analog's tree I don't think they have
> support for this driver doing buffered output either (I think they may have
> some internal support or maybe it's just a plan on how to do it!)

We do have support for output buffers in our tree, but obviously not for a 
VGA. I think we should add the upstream documentation for these attributes 
at the same time we add the infrastructure support.

- Lars

