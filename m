Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:55465 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbbA3Jb7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jan 2015 04:31:59 -0500
Received: by mail-lb0-f179.google.com with SMTP id 10so35358265lbg.10
        for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2015 01:31:57 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: imu: adis16400: Fix sign extension
References: <20150130083058.GD21357@mwanda> <54CB41F9.1060800@metafoo.de>
	<20150130092250.GK6507@mwanda>
Date: Fri, 30 Jan 2015 10:31:55 +0100
In-Reply-To: <20150130092250.GK6507@mwanda> (Dan Carpenter's message of "Fri,
	30 Jan 2015 12:22:50 +0300")
Message-ID: <87r3ucty0k.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jan 30 2015, Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Rasmus, are you using a static checker?  Which one?

Sort of:

https://github.com/Villemoes/linux-cocci/blob/master/misc/sign_extend.cocci

Rasmus
