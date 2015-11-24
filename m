Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1096 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753178AbbKXHoo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Nov 2015 02:44:44 -0500
Message-ID: <56541566.80604@metafoo.de>
Date: Tue, 24 Nov 2015 08:44:38 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Ranjit Waghmode <ranjit.waghmode@xilinx.com>, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, sbhatta@xilinx.com,
	punnaia@xilinx.com
Subject: Re: [LINUX PATCH] iio: xadc: fix for extended name remains same issue
References: <1448345847-15051-1-git-send-email-ranjit.waghmode@xilinx.com>
In-Reply-To: <1448345847-15051-1-git-send-email-ranjit.waghmode@xilinx.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/24/2015 07:17 AM, Ranjit Waghmode wrote:
> If we read channel details based on the device tree entry; channel’s scan_index
> and channel’s address were overwritten by scan_index and address of channel
> based on device tree. But extended name were remaining same because of which
> sysfs entry names were continuous.

I don't understand this part. Those channels don't have a extended name,
they are always NULL. Those are added as part of this patch as well, but the
patch description makes it sound like it is a fix for a existing issue.


> 
> So this patch takes care of the above issue by updating 'channels' structure
> inside xadc_parse_dt() function with the help of 'xadc_channels' structure
> so that every channel's parameters will be updated properly. Also for the
> sake of simplicity this patch updates default values for extend_name.

We can't really do that, that would break existing applications. And to be
honest I don't think regular channels should have a extended name.

