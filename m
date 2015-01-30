Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-060.synserver.de ([212.40.185.60]:1063 "EHLO
	smtp-out-060.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbbA3IeH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jan 2015 03:34:07 -0500
Message-ID: <54CB41F9.1060800@metafoo.de>
Date: Fri, 30 Jan 2015 09:34:01 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [patch] iio: imu: adis16400: Fix sign extension
References: <20150130083058.GD21357@mwanda>
In-Reply-To: <20150130083058.GD21357@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/30/2015 09:30 AM, Dan Carpenter wrote:
> Because of C's type promotion rules, the code shifts in
> "((val16 & 0xFFF) << 4) >> 4;" cancel each other out and they're a
> no-op.
>
> The intention here was to sign-extend then 11th bit so we can use the
> sign_extend32() function.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Please review this carefully.  I'm pretty sure it's correct but this is
> the first time I've ever used the sign_extend32() function.

Hi,

Rasmus already fixed this a couple of days ago.

Thanks,
- Lars
