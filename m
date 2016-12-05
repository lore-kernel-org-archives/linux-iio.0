Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51229 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbcLEUyT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 15:54:19 -0500
Date: Mon, 5 Dec 2016 23:53:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 12/19] staging: iio: isl29028: fix comparison between
 signed and unsigned integers
Message-ID: <20161205205339.GC31243@mwanda>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-13-git-send-email-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480817983-32359-13-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Dec 03, 2016 at 09:19:36PM -0500, Brian Masney wrote:
> Fixed warning found by make W=2 to reduce the amount of build noise:
> 
> warning: comparison between signed and unsigned integer expressions
> [-Wsign-compare]

Ugh...  Please don't do work arounds for nonsense warnings.  W=2 is so
stupid.  Better to just grep -v this warning instead of trying to please
a broken static analysis.  Warnings like this are why it's disabled by
default.

regards,
dan carpenter


