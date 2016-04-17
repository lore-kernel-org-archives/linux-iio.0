Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33219 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbcDQEdI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 00:33:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so13768738pfe.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Apr 2016 21:33:07 -0700 (PDT)
Date: Sat, 16 Apr 2016 21:33:04 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: gyro: bmg160: use regmap to retrieve struct
 device
Message-ID: <20160417043303.GA2689@d830.WORKGROUP>
References: <cover.1460314070.git.amsfield22@gmail.com>
 <63dd9227f9a7e56f7e03f8963e798e6d7d8bb70f.1460314070.git.amsfield22@gmail.com>
 <57129157.3080603@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57129157.3080603@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 16, 2016 at 08:24:07PM +0100, Jonathan Cameron wrote:
> On 10/04/16 20:08, Alison Schofield wrote:
> > Driver includes struct regmap and struct device in its global data.
> > Remove the struct device and use regmap API to retrieve device info.
> > 
> > Patch created using Coccinelle plus manual edits.
> > 
> > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc'd Srinivas
> 
> Actually I'm curious as to why linux-arm-kernel and linux-samsung-soc are cc'd?
> Not terribly relevant lists...

Jonathan,
They were left over from when exynos driver was in the patch set. I kept
the cc list from v1, to show drivers dropped.

Alas, I see all your other comments and forwards.  My get_maintainer
options were too strict. (--nokeywords --nogit --nogit-fallback
--norolestats)

Thanks for pointing it out.  I will correct that in future patches.
alisons


...snip...

