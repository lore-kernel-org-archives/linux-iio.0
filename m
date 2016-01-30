Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44799 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcA3PMj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 10:12:39 -0500
Date: Sat, 30 Jan 2016 18:12:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, Joe Perches <joe@perches.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	pmeerw@pmeerw.net, Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH 1/2] staging:iio:adc:added space around '-'
Message-ID: <20160130151213.GC13219@mwanda>
References: <cover.1452878721.git.bhumirks@gmail.com>
 <115dd2e3f67706fd323c18b23871068ad36dfa94.1452878721.git.bhumirks@gmail.com>
 <56995378.1010204@metafoo.de>
 <20160120142137.GC6370@mwanda>
 <56A4FD7F.6010800@kernel.org>
 <56A5068D.4080207@metafoo.de>
 <56ACC4D2.8040802@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56ACC4D2.8040802@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We could make checkpatch.pl not complain if the line says checkpatch: on
it.  It would look like this.

-               in_voltage-voltage_thresh_low_value,
+               in_voltage-voltage_thresh_low_value, /* checkpatch: not math */

I suppose I could have made the explanation longer since the it won't
complain about the 80 character limit...  What do you guys think?

regards,
dan carpenter

