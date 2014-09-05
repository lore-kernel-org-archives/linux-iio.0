Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44675 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972AbaIEJey (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Sep 2014 05:34:54 -0400
Date: Fri, 5 Sep 2014 12:34:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:STAGING - INDUSTR..." <linux-iio@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adc: mxs-lradc.c: sparse warning of
 incorrect type
Message-ID: <20140905093413.GJ6600@mwanda>
References: <1409849142-12185-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409849142-12185-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Sep 04, 2014 at 10:15:42PM +0530, Sudip Mukherjee wrote:
> fixed sparse warning : incorrect type in argument 1 
> 		       (different address spaces)
> 

The change log is not clear.  It's the IS_ERR() which is the problem?
This is a false positive which is fixed in a later version of Sparse.

regards,
dan carpenter


