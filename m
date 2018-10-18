Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:40782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeJROHm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 10:07:42 -0400
Date: Thu, 18 Oct 2018 09:07:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] Staging iio/adc: fixes parenthesis alignment
Message-ID: <20181018060734.f7ysidkikuoxnkkw@mwanda>
References: <20181016160104.6276-1-marcelo.schmitt1@gmail.com>
 <0a6618af45b673ff14e4b92cd4642b72b632c7b8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0a6618af45b673ff14e4b92cd4642b72b632c7b8.camel@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I feel like these are overly nit-picky...

I understand that everyone is picky about different things.  For
example, I have a prefered style for error handling.  So two days ago
there was a new staging driver and it used label name like
"goto kmalloc_failed;" and I looked until I found an error handling bug
and then I said, "Here is a bug, plus your label names are bad."  When
people have bad style but it doesn't lead to bugs then I let them get
away with it.

regards,
dan carpenter
