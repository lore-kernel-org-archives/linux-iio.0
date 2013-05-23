Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26427 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757494Ab3EWJPg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2013 05:15:36 -0400
Date: Thu, 23 May 2013 12:15:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: iio: frequency: New driver for Analog Devices ADF4350/ADF4351
 Wideband Synthesizers
Message-ID: <20130523091530.GF30128@mwanda>
References: <20130522202531.GA1438@elgon.mountain>
 <519DD204.4040807@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <519DD204.4040807@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 23, 2013 at 10:23:32AM +0200, Michael Hennerich wrote:
> Thanks for the reminder.
> We actually fixed the typo in the mask some time ago,
> 0x9 should be 0x3, we send a patch shortly.
> 
> 7 or 3 being signed by default shouldn't matter. The whole term
> at the end is just a big mask used to reject some bits being
> set in r2_user_settings.

It's truncated away, yes.  But sign extension from int literals is
an easy thing for the static checkers to spot and it's upsets and
worries them.  Let's fix that as well, I would do it but it's an
awkward thing because I have to wait for your first patch and then
write a patch on top of that...

regards,
dan carpenter
