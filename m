Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:48834 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753311AbbKGSCL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Nov 2015 13:02:11 -0500
Message-ID: <1446919324.2701.1.camel@perches.com>
Subject: Re: [PATCH] Staging: iio: Fix some character line limit coding
 style issues
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Evan Hosseini <hosse005@umn.edu>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2015 10:02:04 -0800
In-Reply-To: <20151107163005.GI18797@mwanda>
References: <20151107150610.GA3250@archBox.attlocal.net>
	 <20151107163005.GI18797@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2015-11-07 at 19:30 +0300, Dan Carpenter wrote:
> The original is easier to read, sorry.  Checkpatch is a tool not the
> king of the world to obeyed at all times.

Completely agree.

Perhaps there could be some comment indicators added
to tell checkpatch to ignore certain warnings like
80 columns.

