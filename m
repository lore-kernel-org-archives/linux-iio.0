Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-125.synserver.de ([212.40.185.125]:1150 "EHLO
	smtp-out-240.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750902AbbIYJvG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2015 05:51:06 -0400
Message-ID: <56051904.3060804@metafoo.de>
Date: Fri, 25 Sep 2015 11:51:00 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: dac: ad5504: leave sysfs naming to the core
References: <1443174310-20428-1-git-send-email-martink@posteo.de>
In-Reply-To: <1443174310-20428-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/25/2015 11:45 AM, Martin Kepplinger wrote:
> This shouldn't actually change anything since the core calls the events
> sysfs folder "events" anyways.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
