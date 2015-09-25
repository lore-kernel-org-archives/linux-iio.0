Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:46974 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634AbbIYJsX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 25 Sep 2015 05:48:23 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 287C1209A2
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2015 11:48:22 +0200 (CEST)
Message-ID: <5605180F.8040901@posteo.de>
Date: Fri, 25 Sep 2015 11:46:55 +0200
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: dac: ad5504: leave sysfs naming to the core
References: <1443174310-20428-1-git-send-email-martink@posteo.de>
In-Reply-To: <1443174310-20428-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2015-09-25 um 11:45 schrieb Martin Kepplinger:
> This shouldn't actually change anything since the core calls the events
> sysfs folder "events" anyways.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/iio/dac/ad5504.c | 1 -
>  1 file changed, 1 deletion(-)
> 

sorry, this is a single patch, not 1/3.

                      martin

