Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1053 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756235Ab2DKLTV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 07:19:21 -0400
Message-ID: <4F856945.9040704@metafoo.de>
Date: Wed, 11 Apr 2012 13:21:41 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 00/14] IIO: Kill off IIO_CHAN macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
> This kills off the remaing users and gets rid of it!
> 
> Please can people sanity check I haven't messed up the
> removal in their drivers (and anyone elses if they are
> bored enough!)

I wrote a small set of cocci scripts which automate the removal and detected
some small issues. If you are interested in the scripts I've uploaded them
at http://metafoo.de/kill_iio_chan.tar.bz2

The cocci pretty printer doesn't cope very well with unwinding a macro, so
I've added some extra sed expressions to cleanup the result.

- Lars
